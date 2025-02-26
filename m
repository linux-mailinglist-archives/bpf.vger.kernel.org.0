Return-Path: <bpf+bounces-52659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD94A46641
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA87019C6EF2
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD43021CC5A;
	Wed, 26 Feb 2025 16:01:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6721D59E
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585681; cv=none; b=b4ORKnno88mQ6YzBhM5fbdGsywvaumnZEHnw99cQP5vMbktVK3GiceG7+UwHrScdqGNJAw/sx3ZnchNLAXP0e+MbRrdu0eVd3wfYo99qt84E7uemietXzoenV5OIIiHbBOIceoW4yt0otoBh6UeoxW9n+kXKpJ1st3dfkLP4r2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585681; c=relaxed/simple;
	bh=qfZYouDxsh/WAtD6+LlCLtcolQODxFnmFR0MCfqqnPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgNwFZgV2iFY/yf8JdNtDk6i9QNo6BUWazmkzuFYjvqj2u65gcE01IjR5PSuORT6YPlHaud/VQjJcFRdbmTfxgNZ0MtoL8CP4HNmJlTRLTW9hbnXZtiwO86ssxlqFWOvaEn3xojbpEEtAy3+YES/NQHuGAx8OKbCAiMfeX5txA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tnJqO-00084B-Av; Wed, 26 Feb 2025 17:01:08 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tnJqN-002yPM-2Y;
	Wed, 26 Feb 2025 17:01:07 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6C4183CC749;
	Wed, 26 Feb 2025 16:01:07 +0000 (UTC)
Date: Wed, 26 Feb 2025 17:01:05 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Chris Ward <tjcw01@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	linux-kernel@vger.kernel.org, Chris Ward <tjcw@uk.ibm.com>, bpf@vger.kernel.org
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
Message-ID: <20250226-rigorous-idealistic-lemming-2fe868-mkl@pengutronix.de>
References: <CAC=wTOhhyaoyCcAbX1xuBf5v-D=oPjjo1RLUmit=Uj9y0-3jrw@mail.gmail.com>
 <CAC=wTOgrEP3g3sKxBfGXqTEyMR2-D74sK2gsCmPS2+H-wBH6QA@mail.gmail.com>
 <20250225-gay-awesome-copperhead-502cd2-mkl@pengutronix.de>
 <397970e484d2d0c1e0649d78cc723fbe3ad2ad5f.camel@gmail.com>
 <20250225-radical-piquant-tench-4d2588-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztrwt5mp4x6lpdhg"
Content-Disposition: inline
In-Reply-To: <20250225-radical-piquant-tench-4d2588-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bpf@vger.kernel.org


--ztrwt5mp4x6lpdhg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
MIME-Version: 1.0

On 25.02.2025 23:57:47, Marc Kleine-Budde wrote:

[...]

> With the CONFIG_DEBUG_INFO_BTF=3Dy kernel the verifier seems to be more
> happy. Now it fails with "-22":
>=20
> | sudo ./xdp_pass_user -d lan0
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | libbpf: prog 'xdp_pass': BPF program load failed: Invalid argument
> | libbpf: prog 'xdp_pass': -- BEGIN PROG LOAD LOG --
> | Extension programs should be JITed
> | processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
> | -- END PROG LOAD LOG --
> | libbpf: prog 'xdp_pass': failed to load: -22
> | libbpf: failed to load object 'xdp-dispatcher.o'
> | libxdp: Compatibility check for dispatcher program failed: Invalid argu=
ment
> | libxdp: Falling back to loading single prog without dispatcher
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | Success: Loading XDP prog name:xdp_prog_simple(id:20) on device:lan0(if=
index:4)
>=20
>=20
> After unloading and enabling the JIT...
>=20
> | =E2=9E=9C (pts/0) frogger@riot:xdp-tutorial/basic01-xdp-pass (main=E2=
=9C=97) echo 1 |sudo tee /proc/sys/net/core/bpf_jit_enable                 =
                 =20
>=20
> ... the dispatcher fails to load with "524". Yes, the number is
> positive.
>=20
> | =E2=9E=9C (pts/0) frogger@riot:xdp-tutorial/basic01-xdp-pass (main=E2=
=9C=97) sudo ./xdp_pass_user -d lan0 --unload-all
> | Success: Unloading XDP prog name: xdp_prog_simple
> | =E2=9E=9C (pts/0) frogger@riot:xdp-tutorial/basic01-xdp-pass (main=E2=
=9C=97) sudo ./xdp_pass_user -d lan0            =20
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | libxdp: Compatibility check for dispatcher program failed: Unknown erro=
r 524
> | libxdp: Falling back to loading single prog without dispatcher
> | libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> | Success: Loading XDP prog name:xdp_prog_simple(id:48) on device:lan0(if=
index:4)
>=20
> strace indicates this syscalls fails:
>=20
> | bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint=3D{name=3DNULL, prog_fd=3D=
17}}, 16) =3D -1 ENOTSUPP (Unknown error 524)
>=20
> I'm on a armv7l, i.e. a 32 bit ARM system. Maybe I'm missing some kernel
> option or BPF_RAW_TRACEPOINT_OPEN is not supported on armv7l. Will look
> deeper into the kernel config options tomorrow.

FTR: I figured out that the dispatcher needs eBPF trampoline support,
which doesn't exist on ARM.

| https://docs.ebpf.io/linux/concepts/trampolines/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ztrwt5mp4x6lpdhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme/Or4ACgkQDHRl3/mQ
kZz6nwgAhK3xtcL0y/nJMeIVoEr+IC8B0uXcCNwKvmEV3p3XGsDSxHe0gStqczK7
QZ7urM55HcLG5/Ec3S/Ew8/LljZxH3LWAmEfqgnDLserCYp6aM20zt8gSrGzUd3g
qhFjRpgRqKFyeqfMVRO2MtTPmzelX2EllHWxfv1d/xgSm9kJK4/kY8bcdhhHwH45
+jo6kYnaSK2BVcJg1GTdvZJhLTRb7CyQ4tABmKMHHC+vL+GhulboB0FF/xuaJ95I
wKFSz+mtXdbu42Ae7MXbo/KbS3yI8egdBpka4NsU0n3Y31k7cxO0SyWZwfE+kAon
AuMleAaLxAQwyK3IT5w+8UGQu6D/Aw==
=k5RJ
-----END PGP SIGNATURE-----

--ztrwt5mp4x6lpdhg--

