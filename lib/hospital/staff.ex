defmodule Hospital.Staff do
  @moduledoc """
  The Staff context.
  """

  import Ecto.Query, warn: false
  alias Hospital.Repo

  alias Hospital.Staff.Doctor

  @doc """
  Returns the list of doctors.

  ## Examples

      iex> list_doctors()
      [%Doctor{}, ...]

  """
  def list_doctors do
    Repo.all(Doctor)
  end

  def get_doctor_name(id) do
    Repo.one(from d in Doctor, where: d.id == ^id, select: d.name)
  end
  @doc """
  Gets a single doctor.

  Raises `Ecto.NoResultsError` if the Doctor does not exist.

  ## Examples

      iex> get_doctor!(123)
      %Doctor{}

      iex> get_doctor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_doctor!(id), do: Repo.get!(Doctor, id)

  def get_doctor_by_uid!(user_id) do
    query =
      from d in Doctor,
        where: d.user_id == ^user_id

    Repo.one(query)
  end



  def get_doctor_name_by_uid(user_id) do
  Repo.one(from d in "doctors", where: d.user_id == ^user_id, select: d.name)
  end

  @doc """
  Creates a doctor.

  ## Examples

      iex> create_doctor(%{field: value})
      {:ok, %Doctor{}}

      iex> create_doctor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_doctor(attrs \\ %{}) do
    %Doctor{}
    |> Doctor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a doctor.

  ## Examples

      iex> update_doctor(doctor, %{field: new_value})
      {:ok, %Doctor{}}

      iex> update_doctor(doctor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_doctor(%Doctor{} = doctor, attrs) do
    doctor
    |> Doctor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a doctor.

  ## Examples

      iex> delete_doctor(doctor)
      {:ok, %Doctor{}}

      iex> delete_doctor(doctor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_doctor(%Doctor{} = doctor) do
    Repo.delete(doctor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking doctor changes.

  ## Examples

      iex> change_doctor(doctor)
      %Ecto.Changeset{data: %Doctor{}}

  """
  def change_doctor(%Doctor{} = doctor, attrs \\ %{}) do
    Doctor.changeset(doctor, attrs)
  end

  alias Hospital.Staff.Timing

  @doc """
  Returns the list of timings.

  ## Examples

      iex> list_timings()
      [%Timing{}, ...]

  """
  def list_timings do
    Repo.all(Timing)
  end

  @doc """
  Gets a single timing.

  Raises `Ecto.NoResultsError` if the Timing does not exist.

  ## Examples

      iex> get_timing!(123)
      %Timing{}

      iex> get_timing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timing!(id), do: Repo.get!(Timing, id)

  @doc """
  Creates a timing.

  ## Examples

      iex> create_timing(%{field: value})
      {:ok, %Timing{}}

      iex> create_timing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timing(attrs \\ %{}) do
    %Timing{}
    |> Timing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timing.

  ## Examples

      iex> update_timing(timing, %{field: new_value})
      {:ok, %Timing{}}

      iex> update_timing(timing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timing(%Timing{} = timing, attrs) do
    timing
    |> Timing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a timing.

  ## Examples

      iex> delete_timing(timing)
      {:ok, %Timing{}}

      iex> delete_timing(timing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timing(%Timing{} = timing) do
    Repo.delete(timing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timing changes.

  ## Examples

      iex> change_timing(timing)
      %Ecto.Changeset{data: %Timing{}}

  """
  def change_timing(%Timing{} = timing, attrs \\ %{}) do
    Timing.changeset(timing, attrs)
  end

  alias Hospital.Staff.Appointment

  @doc """
  Returns the list of appointments.

  ## Examples

      iex> list_appointments()
      [%Appointment{}, ...]

  """

  def list_appointments do
    Repo.all(Appointment)
  end

  @doc """
  Gets a single appointment.

  Raises `Ecto.NoResultsError` if the Appointment does not exist.

  ## Examples

      iex> get_appointment!(123)
      %Appointment{}

      iex> get_appointment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appointment!(id), do: Repo.get!(Appointment, id)

  @doc """
  Creates a appointment.

  ## Examples

      iex> create_appointment(%{field: value})
      {:ok, %Appointment{}}

      iex> create_appointment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appointment(attrs \\ %{}) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
  end

  def is_doc_free(doctor_id, date, from, to) do
    query =
      from a in Appointment,
        join: d in Doctor,
        on: a.doctor_id == ^doctor_id,
        where: a.date == ^date

    query2 = from q in query, where: q.from == ^from
    query3 = from q in query2, where: q.to == ^to

    if is_nil(Repo.one(query3)), do: true, else: false
  end

  @doc """
  Updates a appointment.

  ## Examples

      iex> update_appointment(appointment, %{field: new_value})
      {:ok, %Appointment{}}

      iex> update_appointment(appointment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appointment(%Appointment{} = appointment, attrs) do
    appointment
    |> Appointment.changeset(attrs)
    |> Repo.update()
  end

  def get_doctor_appointment(doctor_id) do
    query = from a in Appointment, where: a.doctor_id == ^doctor_id
    Repo.all(query)
  end

  def get_patient_appointment(patient_id) do
    query = from a in Appointment, where: a.patient_id == ^patient_id
    Repo.all(query)
  end

  def return_doctor_patient(id) do
    doctor_id = Repo.one(from a in Appointment, where: a.id == ^id, select: a.doctor_id)
    Repo.one(from d in Doctor, where: d.id == ^doctor_id, select: d.name)
  end

  def return_patient_name(id) do
    patient_id = Repo.one(from a in Appointment, where: a.id == ^id, select: a.patient_id)
    Repo.one(from d in Hospital.Patients.Patient, where: d.id == ^patient_id, select: d.name)
  end

  @doc """
  Deletes a appointment.

  ## Examples

      iex> delete_appointment(appointment)
      {:ok, %Appointment{}}

      iex> delete_appointment(appointment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appointment(%Appointment{} = appointment) do
    Repo.delete(appointment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appointment changes.

  ## Examples

      iex> change_appointment(appointment)
      %Ecto.Changeset{data: %Appointment{}}

  """
  def change_appointment(%Appointment{} = appointment, attrs \\ %{}) do
    Appointment.changeset(appointment, attrs)
  end
end
