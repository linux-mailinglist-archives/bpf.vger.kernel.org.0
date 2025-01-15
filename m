Return-Path: <bpf+bounces-48922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F473A11FE2
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF72F162468
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7AE1E98F6;
	Wed, 15 Jan 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bifLeUaz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE51E7C22;
	Wed, 15 Jan 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937553; cv=none; b=P+HQzwQBpXTVAMKAuxK30J1rYznUAesHKDkp+sQRzC0iQJGgF/qYxtrM0K1leNCuBfRBgu4z9RTJV8USs8lCauuqIIvY2JF5Tivta3LbwpIMYOW8S/YY/mad7JB0jtmBYtpbEq+OS8hZqRYw6/OtUvxO2zsNTO3gaioqJyQ46kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937553; c=relaxed/simple;
	bh=DKeDSMDRLcKb3EsIb4UeOELYiUB4wAuvAFvDauJtTz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aSyQiNkuoPb4qwvKUUDVMReDaAWScA07Gz/rBNsSLwkJG1q8Jwu71mLeeed0XivuR5lsGM/Npbe98qI3V5uRy53P+D1NaPwl4RjcuixYyRjyUIHZ/4ut1xRBWVR+NMinlUwNnvII85oilU3KsOaVGqO17/PzqsEin6bjR5Ks+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bifLeUaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8753AC4CEEC;
	Wed, 15 Jan 2025 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736937552;
	bh=DKeDSMDRLcKb3EsIb4UeOELYiUB4wAuvAFvDauJtTz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bifLeUazxqHGYWzAyIzCKN9Lr0HVbiBojSXoDxzwBJwN4Bl5fVtwKhwyUjTtKADXd
	 PQCOWVVozerQAR3XhODBOFu+aLNQaNYXBubSUdJZk3w1qXFwJJD76NdNi6ax5ZZNbl
	 UXsqpsQmxErnKnWH/T1hWIsyy74VSES1ctNlbDsN8EeG38QiSGCO4Aw8rIVO27OPO4
	 pPVg044wZmM3nEYuVffIHmisbRbSY6k6LvftvWS0L8E2saaWALfG22aZNhjPbN8OCB
	 VyitqjR2FFpmLP96MUmP2edJWV8reb8f1eB5GxRpPUL2bCSRTOhq27GmYsl3vGj05d
	 NO35wOCfRSxAA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eddy Z
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, John Fastabend
 <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh
 <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Matt Bobrowski
 <mattbobrowski@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Stanislav Fomichev <sdf@fomichev.me>, Song
 Liu <song@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING: locking bug in
 __lock_task_sighand
In-Reply-To: <CAADnVQL=_6n+yJfs+TPxtBEVcpYV6nPEgjfRmacCdm7qLCSj0g@mail.gmail.com>
References: <67486b09.050a0220.253251.0084.GAE@google.com>
 <CAADnVQKdRWA1zG6X4XNwOWtKiUHN-SRREYN_DCNU59LsK8S5LA@mail.gmail.com>
 <mb61p8qsymf3i.fsf@kernel.org>
 <CAADnVQ+_TUjJ6Ytn96QqtHnBB--muefbbOoAsRw4z=40Pf1+tA@mail.gmail.com>
 <CAADnVQL=_6n+yJfs+TPxtBEVcpYV6nPEgjfRmacCdm7qLCSj0g@mail.gmail.com>
Date: Wed, 15 Jan 2025 10:38:56 +0000
Message-ID: <mb61p5xmgicov.fsf@kernel.org>
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

> On Tue, Dec 17, 2024 at 3:49=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon, Dec 2, 2024 at 4:42=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>> >
>> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> >
>> > > Puranjay, Andrii and All,
>> > >
>> > > looks like if (irqs_disabled()) is not enough.
>> > > Should we change it to preemptible() ?
>> > >
>> > > It will likely make it async all the time,
>> > > but in this it's an ok trade off?
>> > >
>> >
>> > Yes, as BPF programs can run in all kinds of contexts.
>> >
>> > We should replace 'if (irqs_disabled())' with 'if (!preemptible())'
>> >
>> > because the definition is:
>> >
>> > #define preemptible()   (preempt_count() =3D=3D 0 && !irqs_disabled())
>> >
>> > and we need if ((preempt_count() !=3D 0) || irqs_disabled()), in both
>> > these cases we want to make it async.
>> >
>> > I will try to test the fix as Syzbot has now found a reproducer.
>>
>> Puranjay,
>>
>> Any progress on a patch ?
>
> ping.

Hi Alexei,
Sorry for being AWOL. I was on a long vacation in India and just got
back.

Here is the patch to fix this: https://lore.kernel.org/all/20250115103647.3=
8487-1-puranjay@kernel.org/

Thanks,
Puranjay

#syz test: https://github.com/puranjaymohan/bpf.git bpf_preemt_fix

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZ4eQQRQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2naW6AQCrWnOZ/OtsclWT1hQw6i7s0mEBacwN
J5+VPyQbt3jgJAEAyWEMjhLAOHW65D0ok+4Soqgz/YcEp917e4J3TCijFQY=
=dEwy
-----END PGP SIGNATURE-----
--=-=-=--

