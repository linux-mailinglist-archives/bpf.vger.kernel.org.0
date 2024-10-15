Return-Path: <bpf+bounces-42000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870C99E333
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183E4283C5E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391D1E2031;
	Tue, 15 Oct 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsv7WmBi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA067F7FC;
	Tue, 15 Oct 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986222; cv=none; b=RP86LNKNAtnFX4VFTf/VLfEaMT9vhvT08Lig3zmOXP44E3zzaYa+sUtDYTkxEVhxaujx4O5D5Agwj3VFkGqoxmxo2K3P9v4oajFE+TUlMud+rCvSC2Et0Xau3EFmkTENjjFR50ymk7L6qt7wUI8AjbsFG6FEGMpp1pMilu5Xwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986222; c=relaxed/simple;
	bh=XbbtQwgzS/RoY3OIlALRUgO8LRfIuiE3RHLo2Fy4w+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qQrsFyXLXimJAihwSoWGSDIPwubR81wsj439hTxfuqfAfMlGqojeKcejqdHsXpVcTZ+27bVzZXHn1HWPeC0O9faNYhrR2Kvvayn18twESzKz7wI+ODFCoLtQHVMxCj4GSoHwxIRW3kgnwxIkHDq3hIkWMBTh5yz7/FGpOooO7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsv7WmBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB48DC4CEC6;
	Tue, 15 Oct 2024 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728986222;
	bh=XbbtQwgzS/RoY3OIlALRUgO8LRfIuiE3RHLo2Fy4w+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dsv7WmBigmJHRTeWdSshrbzbirjuaZfm9l6aCOU7Agc3bJB51w/wq7MJAyMF2xHOW
	 Lno/+4u0nxcydG/nddrf/HLx0PjItk7aj6/oqJQZBBlwZ5YmmZNG2MtELH1tB/5UdI
	 jrM8MQQvVCYOupJcDh5dVLDzVjx1mE+2SXx7E8gevtNGrrPp0Ft82ITDH/0x1MPjQC
	 8p+IszJjppYholnoEAAPNuddMzPPR7cOUcjpdGi+N07CfKeZxa/6l+o9jLEI58hvSB
	 NPmEA4ECjfKyd8GGN99v2q/aEdg9eIryR8PhVGVPQte1d9PhJrD1kyTjSEYxhi2l/d
	 ougL3DXg5VLlA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf: implement bpf_send_signal_task()
 kfunc
In-Reply-To: <CAEf4Bza5HCFZmMA8UcM92TXzDq8CxKpjPkQ_s2PLuc-dGR8y2A@mail.gmail.com>
References: <20241008114940.44305-1-puranjay@kernel.org>
 <20241008114940.44305-2-puranjay@kernel.org>
 <CAEf4Bza5HCFZmMA8UcM92TXzDq8CxKpjPkQ_s2PLuc-dGR8y2A@mail.gmail.com>
Date: Tue, 15 Oct 2024 09:56:48 +0000
Message-ID: <mb61pbjzln0yn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 8, 2024 at 4:49=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>>
>> Implement bpf_send_signal_task kfunc that is similar to
>> bpf_send_signal_thread and bpf_send_signal helpers  but can be used to
>> send signals to other threads and processes. It also supports sending a
>> cookie with the signal similar to sigqueue().
>>
>> If the receiving process establishes a handler for the signal using the
>> SA_SIGINFO flag to sigaction(), then it can obtain this cookie via the
>> si_value field of the siginfo_t structure passed as the second argument
>> to the handler.
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  kernel/bpf/helpers.c     |  1 +
>>  kernel/trace/bpf_trace.c | 52 +++++++++++++++++++++++++++++++++-------
>>  2 files changed, 45 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 4053f279ed4cc..2fd3feefb9d94 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3035,6 +3035,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIR=
E | KF_RCU | KF_RET_NULL)
>>  #endif
>>  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_throw)
>> +BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
>>  BTF_KFUNCS_END(generic_btf_ids)
>>
>>  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index a582cd25ca876..d9662e84510d3 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -802,6 +802,8 @@ struct send_signal_irq_work {
>>         struct task_struct *task;
>>         u32 sig;
>>         enum pid_type type;
>> +       bool has_siginfo;
>> +       struct kernel_siginfo info;
>>  };
>>
>>  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
>> @@ -809,27 +811,46 @@ static DEFINE_PER_CPU(struct send_signal_irq_work,=
 send_signal_work);
>>  static void do_bpf_send_signal(struct irq_work *entry)
>>  {
>>         struct send_signal_irq_work *work;
>> +       struct kernel_siginfo *siginfo;
>>
>>         work =3D container_of(entry, struct send_signal_irq_work, irq_wo=
rk);
>> -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->=
type);
>> +       siginfo =3D work->has_siginfo ? &work->info : SEND_SIG_PRIV;
>> +
>> +       group_send_sig_info(work->sig, siginfo, work->task, work->type);
>>         put_task_struct(work->task);
>>  }
>>
>> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
>> +static int bpf_send_signal_common(u32 sig, enum pid_type type, struct t=
ask_struct *task, u64 value)
>>  {
>>         struct send_signal_irq_work *work =3D NULL;
>> +       struct kernel_siginfo info;
>> +       struct kernel_siginfo *siginfo;
>> +
>> +       if (!task) {
>> +               task =3D current;
>> +               siginfo =3D SEND_SIG_PRIV;
>> +       } else {
>> +               clear_siginfo(&info);
>> +               info.si_signo =3D sig;
>> +               info.si_errno =3D 0;
>> +               info.si_code =3D SI_KERNEL;
>> +               info.si_pid =3D 0;
>> +               info.si_uid =3D 0;
>> +               info.si_value.sival_ptr =3D (void *)(unsigned long)value;
>> +               siginfo =3D &info;
>> +       }
>>
>>         /* Similar to bpf_probe_write_user, task needs to be
>>          * in a sound condition and kernel memory access be
>>          * permitted in order to send signal to the current
>>          * task.
>>          */
>> -       if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
>> +       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
>>                 return -EPERM;
>>         if (unlikely(!nmi_uaccess_okay()))
>>                 return -EPERM;
>>         /* Task should not be pid=3D1 to avoid kernel panic. */
>> -       if (unlikely(is_global_init(current)))
>> +       if (unlikely(is_global_init(task)))
>>                 return -EPERM;
>>
>>         if (irqs_disabled()) {
>> @@ -847,19 +868,21 @@ static int bpf_send_signal_common(u32 sig, enum pi=
d_type type)
>>                  * to the irq_work. The current task may change when que=
ued
>>                  * irq works get executed.
>>                  */
>> -               work->task =3D get_task_struct(current);
>> +               work->task =3D get_task_struct(task);
>> +               work->has_siginfo =3D siginfo =3D=3D &info;
>> +               copy_siginfo(&work->info, &info);
>
> we shouldn't copy_siginfo() if !work->has_siginfo, no?

Yes, but it is only used when has_siginfo is true, so copying it doesn't
cause any problems. I just didn't want to add another check here.

> other than that, lgtm
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for the Ack. I hope this can go in now!

Thanks,
Puranjay Mohan

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZw48YRQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nfQyAQCeqW35HEAD4ksD/dnVgtkBCH6pkJkX
gc/F0aFK9fezDAD/XQbmXYj951w/eA8EIETkBnOR/Rlyi0NwiqDNtUCvugc=
=Qt+j
-----END PGP SIGNATURE-----
--=-=-=--

