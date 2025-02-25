Return-Path: <bpf+bounces-52526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18011A4450D
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B427A257F
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F266166F29;
	Tue, 25 Feb 2025 15:55:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA813CFA6
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498923; cv=none; b=EAsBhZr9zS2qnvxg+m7zkBgLuhYElH2SNfU+vZkbMuSjCZDA4bafyTw6gcJwRgm8uaoPDw54of4Fh6M/N028CL9XPZy2+beiL4c8JNOeCrwk9lNn1TbYwB4sdaq9EII87CJqeY0xhdLuzIWQ83zliDc+NnVhq6elCqSR6wiYlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498923; c=relaxed/simple;
	bh=XG7sBb1bx3TjOgX/579l1+WSLLiAuM/wwnmj5aFAss8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVh7ixb2wGbS64TazxYqFZyvQemA5e/43Ljz135WlznGCrGV34DhxG3+/qpgXL+H0Dl/utRRwVSVLio1MP49Zyv2ip0Mkfkm5gKDuukaklXy6XHBDcUz2TAkIJ/40HbT+54b7jl4a+o1Xicp0rSO/ZiulyIKAUwhlQmQ5yr/Udg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmxH6-0004PI-VB; Tue, 25 Feb 2025 16:55:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmxH6-002nfN-1Y;
	Tue, 25 Feb 2025 16:55:12 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2197C3CB981;
	Tue, 25 Feb 2025 15:55:12 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:55:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chris Ward <tjcw01@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Ward <tjcw@uk.ibm.com>, 
	bpf@vger.kernel.org
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
Message-ID: <20250225-gay-awesome-copperhead-502cd2-mkl@pengutronix.de>
References: <CAC=wTOhhyaoyCcAbX1xuBf5v-D=oPjjo1RLUmit=Uj9y0-3jrw@mail.gmail.com>
 <CAC=wTOgrEP3g3sKxBfGXqTEyMR2-D74sK2gsCmPS2+H-wBH6QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="scjmc72w3micqk5g"
Content-Disposition: inline
In-Reply-To: <CAC=wTOgrEP3g3sKxBfGXqTEyMR2-D74sK2gsCmPS2+H-wBH6QA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bpf@vger.kernel.org


--scjmc72w3micqk5g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
MIME-Version: 1.0

On 23.01.2023 12:35:41, Chris Ward wrote:
> The 5.15.0 kernel (built by 'git checkout v5.15' from the kernel.org
> torvalds tree) fails in the same way that the 6.2.0-rc5+ kernel fails.
> So it seems that something Canonical did for the Ubuntu 20.04 kernel
> causes eBPF to work correctly.
>=20
> On Mon, 23 Jan 2023 at 11:06, Chris Ward <tjcw01@gmail.com> wrote:
> >
> > I am trying to use the 'bleeding edge' kernel to determine whether a
> > problem I see has already been fixed, but with this kernel the eBPF
> > verifier will not load the dispatcher program that is contained within
> > libxdp. I am testing kernel commit hash 2475bf0 which fails, and the
> > kernel in Ubuntu 22.04 (5.15.0-58-generic) works properly. I am
> > running the test case from
> > https://github.com/tjcw/bpf-examples/tree/tjcw-explore-sameeth ; to
> > build it go to the AF_XDP-filter directory and type 'make', and to run
> > it go to the AF_XDP-filter/runscripts/iperf3-namespace directory and
> > type 'sudo FILTER=3Daf_xdp_kern PORT=3D50000 ./run.sh' .
> > The lines from the run output indicating the failure are
> > libbpf: prog 'xdp_dispatcher': BPF program load failed: Invalid argument
> > libbpf: prog 'xdp_dispatcher': -- BEGIN PROG LOAD LOG --
> > Func#11 is safe for any args that match its prototype
> > btf_vmlinux is malformed
> > reg type unsupported for arg#0 function xdp_dispatcher#29
> > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > ; int xdp_dispatcher(struct xdp_md *ctx)
> > 0: (bf) r6 =3D r1                       ; R1=3Dctx(off=3D0,imm=3D0)
> > R6_w=3Dctx(off=3D0,imm=3D0)
> > 1: (b7) r0 =3D 2                        ; R0_w=3D2
> > ; __u8 num_progs_enabled =3D conf.num_progs_enabled;
> > 2: (18) r8 =3D 0xffffb2f6c06d8000       ; R8_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D84,imm=3D0)
> > 4: (71) r7 =3D *(u8 *)(r8 +0)           ; R7=3D1
> > R8=3Dmap_value(off=3D0,ks=3D4,vs=3D84,imm=3D0)
> > ; if (num_progs_enabled < 1)
> > 5: (15) if r7 =3D=3D 0x0 goto pc+141      ; R7=3D1
> > ; ret =3D prog0(ctx);
> > 6: (bf) r1 =3D r6                       ; R1_w=3Dctx(off=3D0,imm=3D0)
> > R6=3Dctx(off=3D0,imm=3D0)
> > 7: (85) call pc+140
> > btf_vmlinux is malformed
> > R1 type=3Dctx expected=3Dfp
> > Caller passes invalid args into func#1
> > processed 84 insns (limit 1000000) max_states_per_insn 0 total_states
> > 9 peak_states 9 mark_read 1
> > -- END PROG LOAD LOG --
> > libbpf: prog 'xdp_dispatcher': failed to load: -22
> > libbpf: failed to load object 'xdp-dispatcher.o'
> > libxdp: Failed to load dispatcher: Invalid argument
> > libxdp: Falling back to loading single prog without dispatcher
> >
> > Can this regression be fixed before kernel 6.2 ships ?

I'm seeing the same failure on 32 bit ARM on v6.13.

Have you found a solution?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--scjmc72w3micqk5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme959wACgkQDHRl3/mQ
kZwKqQgAkyEMUXm57z+zY8etkW9twSYYtv9iV2JoLZmCHPUzOsrfJO8U/hEQMNPq
jkrehTci2uDVFGBikkLEsVamHhwrtONYJPUYPRQq7WQpRuIgdM92rvWITvSBAjQg
pmmPFSJne81BB3hottZSpky4GkDSrizp69026Orvk8uXVlHSw7n19ul+CfSEY1C1
lf9rlM1qqDU5f3ytq6VeEONKOgUidwSUck4vQeOUhesDkdNoeNHyoD2SmfY5u02W
h8Xx6v1996QteQm5oJzahitIF2538uzKqPptF6qv99v1HjCfXCVqTqh5FW84IUIX
merv3wU78SX4JouxHknOrC6uCo8X7w==
=tX/x
-----END PGP SIGNATURE-----

--scjmc72w3micqk5g--

