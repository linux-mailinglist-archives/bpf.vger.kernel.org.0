Return-Path: <bpf+bounces-38880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60A96BE5A
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870B31F261D2
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362391E531;
	Wed,  4 Sep 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgOlUR4s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58101CFEAC
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456215; cv=none; b=hMVnIjCEtVISpnEcCKIORIeumLJqNddfbciCEOhC27E8NpQep9Za/lscqqrl/gyyNEIkWkdzQMJlkzMgBM1B1azclCOXOHiOs37C2BaoWzDnGLl85qgzg+3dvkK3GMI/820SlpIHffh+BLIcXRitqoLafmDHscFvt1ECPzQtpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456215; c=relaxed/simple;
	bh=m9rLFcWVEydGsY/1vRpaH9ctPVxMkclASTWd0X2whqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ouFYZo/oSXJgTbHIeaAOAU03QArEEBqSvV/hByRd46KTJ5SawZg9+H/3pogS/sWYYnW1Wu6D1qhoTwrkzOawXJ0Y3rzRMbez2NEpuU5xWEPUUYNuLp9/ltXAbPWCG8EEzmIJxJCNuTC6+zWGEQPF9doopEc3hdGgfp2bSaNO14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgOlUR4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE19C4CEC2;
	Wed,  4 Sep 2024 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725456215;
	bh=m9rLFcWVEydGsY/1vRpaH9ctPVxMkclASTWd0X2whqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MgOlUR4sg9XlwGI1CNzHhYRjzWWIAywY1gFiy8KSAdX8kWw+a9BS8o+QhCKaVI+k3
	 t/q6u82TAmgrBqf0GEkCvd4+2WCeblTmRD220cKPxDMoCL66dFkfJDvTRTKnuo65+9
	 cCuHTsg7qadbwlqgYS9Exdm0VaQYPXPeb6zhfD5IF/pjWIPNpc+nYPc/M8BIFb9sBf
	 fF5glI8SSo+MBOMl2UlDIDU8i75dHGS97bxsA27ITIr58tsQpRjUFqGDlx3pbiuTpP
	 b+UBm8XrmV+597mRdXXRYgUTSS3qSKb3kvpYho5SJwjKhXglTSX6FBfGjsaPk8ZW/e
	 ViGXM1KG2WQZw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf
 <bpf@vger.kernel.org>, puranjay12@gmail.com
Subject: Re: [PATCH bpf-next 1/2] bpf: implement bpf_send_signal_pid/tgid()
 helpers
In-Reply-To: <CAADnVQKXY5E11gpng=0P_YFLJZh+nmiJDLOrtv2hftvxinukFQ@mail.gmail.com>
References: <20240724113944.75977-1-puranjay@kernel.org>
 <CAADnVQKXY5E11gpng=0P_YFLJZh+nmiJDLOrtv2hftvxinukFQ@mail.gmail.com>
Date: Wed, 04 Sep 2024 13:23:23 +0000
Message-ID: <mb61pjzfrsgc4.fsf@kernel.org>
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

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

Hi,
Sorry for the delay on this.

> On Wed, Jul 24, 2024 at 4:40=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>> Implement bpf_send_signal_pid and bpf_send_signal_tgid helpers which are
>> similar to bpf_send_signal_thread and bpf_send_signal helpers
>> respectively but can be used to send signals to other threads and
>> processes.
>
> Thanks for working on this!
> But it needs more homework.
>
>>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>>         FN(unspec, 0, ##ctx)                            \
>> @@ -6006,6 +6041,8 @@ union bpf_attr {
>>         FN(user_ringbuf_drain, 209, ##ctx)              \
>>         FN(cgrp_storage_get, 210, ##ctx)                \
>>         FN(cgrp_storage_delete, 211, ##ctx)             \
>> +       FN(send_signal_pid, 212, ##ctx)         \
>> +       FN(send_signal_tgid, 213, ##ctx)                \
>
> We stopped adding helpers long ago.
> They need to be kfuncs.
>
>>         /* */
>>
>>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that d=
on't
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index cd098846e251..f1e58122600d 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -839,21 +839,30 @@ static void do_bpf_send_signal(struct irq_work *en=
try)
>>         put_task_struct(work->task);
>>  }
>>
>> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
>> +static int bpf_send_signal_common(u32 sig, enum pid_type type, u32 pid)
>>  {
>>         struct send_signal_irq_work *work =3D NULL;
>> +       struct task_struct *tsk;
>> +
>> +       if (pid) {
>> +               tsk =3D find_task_by_vpid(pid);
>
> by vpid ?
>
> tracing bpf prog will have "random" current and "random" pidns.
>
> Should it be find_get_task vs find_task too ?
>
> Should kfunc take 'task' parameter instead
> received from bpf_task_from_pid() ?
>
> two kfuncs for pid/tgid is overkill. Combine into one?

So, I will add a single kfunc that can do both pid and tgid and it will
take the 'task' parameter received from the call to bpf_task_from_pid()
and a 'bool' to select pid/tgid.

>
>> +               if (!tsk)
>> +                       return -ESRCH;
>> +       } else {
>> +               tsk =3D current;
>> +       }

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZthfTBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nWxjAP0fsbNXrFRnsXV387jt+/WvOjibeAYw
4KfUiUGxnW1cHQEAmoMl9+k9RyMXIKqPY2K9ZjZJ5884g62uKmz9Ja2t/wc=
=Vq0E
-----END PGP SIGNATURE-----
--=-=-=--

