Return-Path: <bpf+bounces-38992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C3A96D291
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF930288670
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CFA189901;
	Thu,  5 Sep 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THL8aWW8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D21527B4
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526619; cv=none; b=U8siu0UOZvRfRaDL+P6kMML6W1gQZdBi9qzCXJw7GmFKP9VWr6eJ+NjONa/gQN1jH65edEwGFYwElbj1imCCYwPX0XALbZX1JK15nE8X3U+vL+OXfUaJEoNhmVqySLhRFETtwjIIKTjcgZJtFSe1wPjUYESjWVA+ASZDsM41KYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526619; c=relaxed/simple;
	bh=G2yhxC0iMJis8DZvLGyiuU7u1V5cyHZuW1ixf1U+rUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DOQYG2qw4lrKfp4HzY82i1mdC/2R5rM1ZM0NaOMay8fwEjkMTnKPstMZ+Rr8ihEgKdUSiImHB+KqtnPa3m0Est9mw4uHJK9vmSzZAqDx9BWySVaPZxVmAZ3cV3qVZc0okUlZxGUdcNzDFAkpsMdx3HcUgve+h+CYybhUVfag3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THL8aWW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA70EC4CEC3;
	Thu,  5 Sep 2024 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725526619;
	bh=G2yhxC0iMJis8DZvLGyiuU7u1V5cyHZuW1ixf1U+rUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=THL8aWW8NoWJV7e0W5QYfL0ibC2uaYfC3zCpgFvTghpZ4QT+pusWnlBlf1Qhh+ixw
	 xweglu33/Fl3Y7gu5FHzpyCJcz5x5YusyFuphsRFzHy2VwCJ3fHpYIDoMBq6oiwmd3
	 QfJuTVtHlZ0c4WSR5zEfHjAbHByIgwzDQQaKgjzPo9jjFVgo4h+vNJtgfBnzu7+QGG
	 4dainTEWmhtPS6+5Cmt+f+fRXuU2p7MrLz+LFCN7esaPcuwj+IJgWBt0Zqy+CDRhue
	 A3OBshBHCSHvp8zmqF8qJ7Hhn0crUTe7eWN7Pt7Wi+ltPLghqK622XgGyMkEYCn9kU
	 2SCKM/DuIneHg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: implement bpf_send_signal_pid/tgid()
 helpers
In-Reply-To: <CAEf4BzaOxhTBf5TDZ0tstQNtdh-uf+d+ARTTX0YMnapdXucP5g@mail.gmail.com>
References: <20240724113944.75977-1-puranjay@kernel.org>
 <CAADnVQKXY5E11gpng=0P_YFLJZh+nmiJDLOrtv2hftvxinukFQ@mail.gmail.com>
 <mb61pjzfrsgc4.fsf@kernel.org>
 <CAEf4BzaOxhTBf5TDZ0tstQNtdh-uf+d+ARTTX0YMnapdXucP5g@mail.gmail.com>
Date: Thu, 05 Sep 2024 08:56:42 +0000
Message-ID: <mb61ph6auscl1.fsf@kernel.org>
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

> On Wed, Sep 4, 2024 at 6:23=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> Hi,
>> Sorry for the delay on this.
>>
>> > On Wed, Jul 24, 2024 at 4:40=E2=80=AFAM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
>> >>
>> >> Implement bpf_send_signal_pid and bpf_send_signal_tgid helpers which =
are
>> >> similar to bpf_send_signal_thread and bpf_send_signal helpers
>> >> respectively but can be used to send signals to other threads and
>> >> processes.
>> >
>> > Thanks for working on this!
>> > But it needs more homework.
>> >
>> >>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>> >>         FN(unspec, 0, ##ctx)                            \
>> >> @@ -6006,6 +6041,8 @@ union bpf_attr {
>> >>         FN(user_ringbuf_drain, 209, ##ctx)              \
>> >>         FN(cgrp_storage_get, 210, ##ctx)                \
>> >>         FN(cgrp_storage_delete, 211, ##ctx)             \
>> >> +       FN(send_signal_pid, 212, ##ctx)         \
>> >> +       FN(send_signal_tgid, 213, ##ctx)                \
>> >
>> > We stopped adding helpers long ago.
>> > They need to be kfuncs.
>> >
>> >>         /* */
>> >>
>> >>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER tha=
t don't
>> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> >> index cd098846e251..f1e58122600d 100644
>> >> --- a/kernel/trace/bpf_trace.c
>> >> +++ b/kernel/trace/bpf_trace.c
>> >> @@ -839,21 +839,30 @@ static void do_bpf_send_signal(struct irq_work =
*entry)
>> >>         put_task_struct(work->task);
>> >>  }
>> >>
>> >> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
>> >> +static int bpf_send_signal_common(u32 sig, enum pid_type type, u32 p=
id)
>> >>  {
>> >>         struct send_signal_irq_work *work =3D NULL;
>> >> +       struct task_struct *tsk;
>> >> +
>> >> +       if (pid) {
>> >> +               tsk =3D find_task_by_vpid(pid);
>> >
>> > by vpid ?
>> >
>> > tracing bpf prog will have "random" current and "random" pidns.
>> >
>> > Should it be find_get_task vs find_task too ?
>> >
>> > Should kfunc take 'task' parameter instead
>> > received from bpf_task_from_pid() ?
>> >
>> > two kfuncs for pid/tgid is overkill. Combine into one?
>>
>> So, I will add a single kfunc that can do both pid and tgid and it will
>> take the 'task' parameter received from the call to bpf_task_from_pid()
>> and a 'bool' to select pid/tgid.
>
> Can you please also investigate passing an extra u64 of "context" to
> the signal handler? It's been requested before, and at least for some
> signals the kernel seems to support this functionality. Would be best
> to avoid proliferation of kfuncs, if we can handle all this in one.
>

Yes, I will look into that. Are you referring to the 'void *context'
that is passed to the handlers registered with sigaction()? like:

=2D-- 8< ---

void  handle_prof_signal(int signal, siginfo_t * info, void * context)
{
}

struct sigaction sig_action;
struct sigaction old_action;

memset(&sig_action, 0, sizeof(sig_action));

sig_action.sa_sigaction =3D handle_prof_signal;
sig_action.sa_flags =3D SA_RESTART | SA_SIGINFO;
sigemptyset(&sig_action.sa_mask);

sigaction(SIGPROF, &sig_action, &old_action);

=2D-- >8 ---

And we want to the BPF program to also be able to pass a custom context
to the signal handler like above? is there an existing mechanism to do
that in the kernel?

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZtlySxQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nXeAAQCDC7W/aHhi0VvCJY1N83lBDCNlO+Vb
YUhhLBTji9LB0gD/bQpTcy0A/VgaKqgxInKBn7A69V0ZWyIMUMgF6Z+J9wc=
=sPqD
-----END PGP SIGNATURE-----
--=-=-=--

