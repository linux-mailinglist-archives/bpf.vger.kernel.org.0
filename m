Return-Path: <bpf+bounces-45932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A59E0257
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 13:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20168165B94
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0451FECD0;
	Mon,  2 Dec 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKcValhA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891551FECB0;
	Mon,  2 Dec 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143340; cv=none; b=BexYvZikSBYiDD6bzFk9oJINv+gH3BoqvN+QCCZ9Q71xEXbSb3P/CpfBMm3z09+JGUXJMKYDbNWutvjV72YlRXWMKUtOznSOLgRaEPFzLK0+pUTNDMRLtOi3YgHLbBwlaDMNJuvT81THWyhzCRboApwgSKzK3YlaGYsuEjPVuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143340; c=relaxed/simple;
	bh=ZUxsmMS3Mj50Owl+CtW2LaA41VDB9pzBJe4flh17kE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UzTta4Qw5ieM9kW4jWJR0jBITlbXH6WDaARM1ZrHwm+TMu7fjd8Vzl3xs6lJU/ZyM6f0yEyVzn2qyNMjm5bypxsdJDV+ZW7bh21rbqpu5TDkh4Fk1Ixet4gl4/zleUdTpMyj/FvYx21BuX4jtB0ori1o9K1wk6DP9oioz3XKQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKcValhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B8FC4CED1;
	Mon,  2 Dec 2024 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733143340;
	bh=ZUxsmMS3Mj50Owl+CtW2LaA41VDB9pzBJe4flh17kE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VKcValhAP4NDcMq/BocoSWIXUDyL28n9ptnqgRUar2qUTZIMdwx8ByaITVypHFTPT
	 bUb3bVM91nBMHksI/U/neBGSK0sySs/xJHRLw+H6UyoLCBl1Gr6OC6Qv1KEy12zQxZ
	 hSEsvhGp/SFzbvnr8Wt8gFquW4j098xst6fdQhmvF6eVR5w1rmbeHzP9yPik4lYU7l
	 FP3Om2BBHPdY5e+TemqzKyQR5fqVp+kEr8ADFrDVgcwVwBCyCirSW/dCa/8NTxPWJX
	 2k3m9Sa+NsFeJ12IvtIVquysDp5b5RCZLmv7hR83Fn9ZwXtPEeAzDP91AXDPoPrpAG
	 O18xqHaFJ3eMA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, syzbot
 <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, bpf <bpf@vger.kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo
 <haoluo@google.com>, John Fastabend <john.fastabend@gmail.com>, Jiri Olsa
 <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Matt Bobrowski
 <mattbobrowski@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Stanislav Fomichev <sdf@fomichev.me>, Song
 Liu <song@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING: locking bug in
 __lock_task_sighand
In-Reply-To: <CAADnVQKdRWA1zG6X4XNwOWtKiUHN-SRREYN_DCNU59LsK8S5LA@mail.gmail.com>
References: <67486b09.050a0220.253251.0084.GAE@google.com>
 <CAADnVQKdRWA1zG6X4XNwOWtKiUHN-SRREYN_DCNU59LsK8S5LA@mail.gmail.com>
Date: Mon, 02 Dec 2024 12:41:53 +0000
Message-ID: <mb61p8qsymf3i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> Puranjay, Andrii and All,
>
> looks like if (irqs_disabled()) is not enough.
> Should we change it to preemptible() ?
>
> It will likely make it async all the time,
> but in this it's an ok trade off?
>

Yes, as BPF programs can run in all kinds of contexts.

We should replace 'if (irqs_disabled())' with 'if (!preemptible())'

because the definition is:

#define preemptible()	(preempt_count() == 0 && !irqs_disabled())

and we need if ((preempt_count() != 0) || irqs_disabled()), in both
these cases we want to make it async.

I will try to test the fix as Syzbot has now found a reproducer.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZ02rEhQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2neeVAP9oIrj3EmYDgSEJCJ4dIGcv2o4GKh1j
WMnk4NhjuJMnUQD9FeG8rr2tbb38XZ3h6tpRcsFUfmbD1uTcqCQ+kCFkWwU=
=8s87
-----END PGP SIGNATURE-----
--=-=-=--

