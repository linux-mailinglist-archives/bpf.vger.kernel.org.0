Return-Path: <bpf+bounces-73564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B58C33C78
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 03:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AFB18C6296
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 02:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E9225408;
	Wed,  5 Nov 2025 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g7qCS6Ka"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FD1624D5;
	Wed,  5 Nov 2025 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309934; cv=none; b=BNt4vK8hNUcLoAdN+K8tNjVxTSeswa7Oqw8044npoZxTwlf5xRNzLOSbEf757d8F2a6ee7RhQKZhCbC6sHVIVtwEYeJvQaZLF4Nr+85SsJU3mpEz3YgmpB4ZFywaweOIhDc25+80v5rgAd4rzGWbBP2fn3zI8qXOvyqyadKZLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309934; c=relaxed/simple;
	bh=oazV4JOKBA2vqOi6rlfJo/k2juAIH9NuVotjR+Z/4LM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GCBoGKdxzDb04wto3Gee8pWVxUoZQhwMfxHkRNEHetE/Hd13sf8XYPYgmQl8WgqwtrFheaF8YXdU8oNICCWpPBfY79xPqy27/oy2fLwznMGrT20sa6e5gn9ReFgH1NRCglz0z9qfzY8fLoHFOJY1cQLg0rFHm5yINmyR83JCIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=g7qCS6Ka; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1762309923;
	bh=xbpnPeTN3sNe5hwyh0I7bt+HxkzyN2NKAz4dbYCQm24=;
	h=Date:From:To:Cc:Subject:From;
	b=g7qCS6Kaf2/ZonCXUFVBFutQKbsQ7IJgAzrTPpG+R/2jK5D2wxGnxWh+oxtazehNv
	 e9hnViPCyN0fpcu/O4nJK7KN9meyIjW/CKrQkDho/kNT3px3MVyNalUYR8Y/f6McXb
	 tKANEWfkghGcZz3DBwQNPXA19ocP13JPBmhNJTcuav6lmGB2m46nVbHYTfXvzz6CvT
	 i1TT3R0uZtx8HT2+2d/ohTuFHzGwxK7J+YKnA0/BerXYwm5BA3IVZ3exWLthmFcjKv
	 LLT2z/rf7CPgxlxrO9g+nXh/jVKm52A57ZqTrD9eq87T9l1EpvRykkxZMpjRL3gedT
	 CnCvcQhDq7QhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4d1TqP0RJSz4w1j;
	Wed, 05 Nov 2025 13:32:00 +1100 (AEDT)
Date: Wed, 5 Nov 2025 13:31:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Arnaud Lecomte <contact@arnaud-lcm.com>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the bpf-next tree
Message-ID: <20251105133159.6303b1ee@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hHbeuxLOfeh=yC3==zvTqlN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hHbeuxLOfeh=yC3==zvTqlN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  kernel/bpf/stackmap.c

between commit:

  e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helpe=
r function")

from the bpf-next tree and commit:

  c69993ecdd4d ("perf: Support deferred user unwind")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/bpf/stackmap.c
index 2365541c81dd,8f1dacaf01fe..000000000000
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@@ -333,9 -310,12 +333,9 @@@ BPF_CALL_3(bpf_get_stackid, struct pt_r
  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
  		return -EINVAL;
 =20
 -	max_depth +=3D skip;
 -	if (max_depth > sysctl_perf_event_max_stack)
 -		max_depth =3D sysctl_perf_event_max_stack;
 -
 +	max_depth =3D stack_map_calculate_max_depth(map->value_size, elem_size, =
flags);
  	trace =3D get_perf_callchain(regs, kernel, user, max_depth,
- 				   false, false);
+ 				   false, false, 0);
 =20
  	if (unlikely(!trace))
  		/* couldn't fetch the stack trace */
@@@ -463,15 -446,13 +463,15 @@@ static long __bpf_get_stack(struct pt_r
  	if (may_fault)
  		rcu_read_lock(); /* need RCU for perf's callchain below */
 =20
 -	if (trace_in)
 +	if (trace_in) {
  		trace =3D trace_in;
 -	else if (kernel && task)
 +		trace->nr =3D min_t(u32, trace->nr, max_depth);
 +	} else if (kernel && task) {
  		trace =3D get_callchain_entry_for_task(task, max_depth);
 -	else
 +	} else {
  		trace =3D get_perf_callchain(regs, kernel, user, max_depth,
- 					   crosstask, false);
+ 					   crosstask, false, 0);
 +	}
 =20
  	if (unlikely(!trace) || trace->nr < skip) {
  		if (may_fault)

--Sig_/hHbeuxLOfeh=yC3==zvTqlN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmkKtx8ACgkQAVBC80lX
0Gzsbgf/cj+cg7MDVkATjRrphld5ewGcoa8oh9IZs6ux/Ips33Tdnh0firBtZXb+
ot3C8ySymjlNaZERZeFd3l13M8loMDrj9MhUDlpT5xkxmobYQ3HbA57F+ZSgI7If
/CbyDEVuo/+8/HCP0Oq9Liosbi9/4brC1RdVJyIT81TwGFCg/Thc9PlG137kWVni
gLPkCpNFpVrrWChXWWZGj+Rzi9w4gS6Rs4vZej2eVQhm58PB1aKC+GvbgCm4fTqA
dNK5+iJ/jRc+/NZ7J6ZhePkS34Kw5vG6VR7nJFYK8i44oGvKTixPJCGycU2FP3DZ
j5ppkGQQRtX6dDmkEG4EQr1D4jlwFQ==
=ZjLt
-----END PGP SIGNATURE-----

--Sig_/hHbeuxLOfeh=yC3==zvTqlN--

