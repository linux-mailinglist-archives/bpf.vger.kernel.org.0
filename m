Return-Path: <bpf+bounces-48566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA00A09596
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231C7162116
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04521170B;
	Fri, 10 Jan 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Y05vyJIC"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77A2116E6;
	Fri, 10 Jan 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522769; cv=none; b=Qwe5rFcJKp2BzDIls6YwodwrHMLc8VFYMqta5NgBMmXPhOh8rtEUL3SI20dT2vey3l03MrnM7cdNsRDORoExZHlXtHU8OdmT8dY1PZ8+YCGWSR4ZMlbgLsDDx5uFpL6IlrakPIiaLoE+rJrc507GbhYAUvsOxlJCpAkPw4D7FhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522769; c=relaxed/simple;
	bh=XQf8PNqFl72fr0M/6yjt5LFRxL77jNP53tuENbACcPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG+n/PH+44QjJv2cgarfiYG2/rFE/BOViFNtT+b1exqz56BHMygdFvOVoRb/MPed3GD4uazoRKOTUSLLljQe69fsexqTNdBgz7bQiBvO/4bFqGgfXyD5E2GTkpjE+PwIQtPilQKsfcnnHjzXSoEhlYFPil1mPGME5Ip6TATrI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Y05vyJIC; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YV58M3WQ7z9tnh;
	Fri, 10 Jan 2025 16:25:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1736522755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gShcPC8qXPqwrtPaApGkI9pbmctxLebCdkupikjGhDY=;
	b=Y05vyJIC9MvB/Dh7M+iZIVLBNfWh/i54JP4e9vBZEjGg5SmIqcQ4z/YaoWXNYR6ZA18f2F
	TJpoE5jN5LeBxYkRIYTTBuYrgdcncDXaDPawkPVpjf2rEZhwP7piOHWFhPdVMZ3PL3VrKP
	EezK4Rg/sj54dKxEG3qYM8334UZ+6VvsldCcFFnCEyO15Qmvkrriv4TrZuv+Qzlh1GA6IF
	Ze9i7JQJo51oULIq9IR2I2FZAauzTF9dE9oqZxslBkR4VLspIs3KztVo+0PrNMJDh4Izoi
	E/eLb3++3CRdYxttCZlsoBI496ZNWUFObfaxpI8fBhRLIfupQuBwgwPQaA5stA==
Date: Sat, 11 Jan 2025 02:25:37 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, olsajiri@gmail.com, mhiramat@kernel.org, 
	oleg@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, BPF-dev-list <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, 
	x86@kernel.org, linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awkkmoqmn5u34xu6"
Content-Disposition: inline
In-Reply-To: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4YV58M3WQ7z9tnh


--awkkmoqmn5u34xu6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Crash when attaching uretprobes to processes running in Docker
MIME-Version: 1.0

On 2025-01-10, Eyal Birger <eyal.birger@gmail.com> wrote:
> Hi,
>=20
> When attaching uretprobes to processes running inside docker, the attached
> process is segfaulted when encountering the retprobe. The offending commit
> is:
>=20
> ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
>=20
> To my understanding, the reason is that now that uretprobe is a system ca=
ll,
> the default seccomp filters in docker block it as they only allow a speci=
fic
> set of known syscalls.

FWIW, the default seccomp profile of Docker _should_ return -ENOSYS for
uretprobe (runc has a bunch of ugly logic to try to guarantee this if
Docker hasn't updated their profile to include it). Though I guess that
isn't sufficient for the magic that uretprobe(2) does...

> This behavior can be reproduced by the below bash script, which works bef=
ore
> this commit.
>=20
> Reported-by: Rafael Buchbinder <rafi@rbk.io>
>=20
> Eyal.
>=20
> --- CODE ---
> #!/bin/bash
>=20
> cat > /tmp/x.c << EOF
> #include <stdio.h>
> #include <seccomp.h>
>=20
> char *syscalls[] =3D {
> "write",
> "exit_group",
> };
>=20
> __attribute__((noinline)) int probed(void)
> {
> printf("Probed\n");
> return 1;
> }
>=20
> void apply_seccomp_filter(char **syscalls, int num_syscalls)
> {
> scmp_filter_ctx ctx;
>=20
> ctx =3D seccomp_init(SCMP_ACT_ERRNO(1));
> for (int i =3D 0; i < num_syscalls; i++) {
> seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
> seccomp_syscall_resolve_name(syscalls[i]), 0);
> }
> seccomp_load(ctx);
> seccomp_release(ctx);
> }
>=20
> int main(int argc, char *argv[])
> {
> int num_syscalls =3D sizeof(syscalls) / sizeof(syscalls[0]);
>=20
> apply_seccomp_filter(syscalls, num_syscalls);
>=20
> probed();
>=20
> return 0;
> }
> EOF
>=20
> cat > /tmp/trace.bt << EOF
> uretprobe:/tmp/x:probed
> {
>     printf("ret=3D%d\n", retval);
> }
> EOF
>=20
> gcc -o /tmp/x /tmp/x.c -lseccomp
>=20
> /usr/bin/bpftrace /tmp/trace.bt &
>=20
> sleep 5 # wait for uretprobe attach
> /tmp/x
>=20
> pkill bpftrace
>=20
> rm /tmp/x /tmp/x.c /tmp/trace.bt
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--awkkmoqmn5u34xu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZ4E78QAKCRAol/rSt+lE
bxuQAP9L5u1uqwbKwQwyDYN3169phWr/xY/2p7TaDBMRcmPWKAEAzKBzmJ01ajsw
paYb+ERj7Lm51eMipaxJyxUrHPgtrAE=
=fDTV
-----END PGP SIGNATURE-----

--awkkmoqmn5u34xu6--

