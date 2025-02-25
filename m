Return-Path: <bpf+bounces-52591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63160A45097
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EE3189CED2
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F1233156;
	Tue, 25 Feb 2025 22:58:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53147204F9B
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524280; cv=none; b=i1wKQXMSgSRa7QweWzEvK9z0/u4yB7tbtQqd639Q/Wr7STr1O+irvQtxs1ViJkGZ5wgRq2gDinSrw3fhUP0yuBXKrU4eGBti9Z6Ehv2sPwPoQQNoat6+7h7CWtA4TmppzWyuNFM7t+Z1T9DpppT5hnlBSY2F3kUBn7jJdPiNFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524280; c=relaxed/simple;
	bh=PoTlQ4385s5DrEh/kQ0+befiVswqZC276gg7tyJP8fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afM2fg3VJ00ZGH8cQWGKsHp/ixeC+ux29UD78Yj6bTXIL87TrVVx98TdVSggbK+Gs1lnjDW3xOPz/2TK8U2CoHQOw3FOLMSw0lXOKjTWdr97b81IjoyzH3WleW/ROOoVdQT84bQJLUZkZtfzZCvPTS0nXyMSbRt7sQP0bPl2WXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tn3s4-0000tz-9u; Tue, 25 Feb 2025 23:57:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tn3s3-002qjR-2f;
	Tue, 25 Feb 2025 23:57:47 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 808E33CBDC8;
	Tue, 25 Feb 2025 22:57:47 +0000 (UTC)
Date: Tue, 25 Feb 2025 23:57:47 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Chris Ward <tjcw01@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	linux-kernel@vger.kernel.org, Chris Ward <tjcw@uk.ibm.com>, bpf@vger.kernel.org
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
Message-ID: <20250225-radical-piquant-tench-4d2588-mkl@pengutronix.de>
References: <CAC=wTOhhyaoyCcAbX1xuBf5v-D=oPjjo1RLUmit=Uj9y0-3jrw@mail.gmail.com>
 <CAC=wTOgrEP3g3sKxBfGXqTEyMR2-D74sK2gsCmPS2+H-wBH6QA@mail.gmail.com>
 <20250225-gay-awesome-copperhead-502cd2-mkl@pengutronix.de>
 <397970e484d2d0c1e0649d78cc723fbe3ad2ad5f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4eimhjfg3mx4uc63"
Content-Disposition: inline
In-Reply-To: <397970e484d2d0c1e0649d78cc723fbe3ad2ad5f.camel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bpf@vger.kernel.org


--4eimhjfg3mx4uc63
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
MIME-Version: 1.0

On 25.02.2025 10:21:11, Eduard Zingerman wrote:
> On Tue, 2025-02-25 at 16:55 +0100, Marc Kleine-Budde wrote:
> > On 23.01.2023 12:35:41, Chris Ward wrote:
> > > The 5.15.0 kernel (built by 'git checkout v5.15' from the kernel.org
> > > torvalds tree) fails in the same way that the 6.2.0-rc5+ kernel fails.
> > > So it seems that something Canonical did for the Ubuntu 20.04 kernel
> > > causes eBPF to work correctly.
> > >
> > > On Mon, 23 Jan 2023 at 11:06, Chris Ward <tjcw01@gmail.com> wrote:
> > > >
> > > > I am trying to use the 'bleeding edge' kernel to determine whether a
> > > > problem I see has already been fixed, but with this kernel the eBPF
> > > > verifier will not load the dispatcher program that is contained wit=
hin
> > > > libxdp. I am testing kernel commit hash 2475bf0 which fails, and the
> > > > kernel in Ubuntu 22.04 (5.15.0-58-generic) works properly. I am
> > > > running the test case from
> > > > https://github.com/tjcw/bpf-examples/tree/tjcw-explore-sameeth ; to
> > > > build it go to the AF_XDP-filter directory and type 'make', and to =
run
> > > > it go to the AF_XDP-filter/runscripts/iperf3-namespace directory and
> > > > type 'sudo FILTER=3Daf_xdp_kern PORT=3D50000 ./run.sh' .
> > > > The lines from the run output indicating the failure are
> > > > libbpf: prog 'xdp_dispatcher': BPF program load failed: Invalid arg=
ument
> > > > libbpf: prog 'xdp_dispatcher': -- BEGIN PROG LOAD LOG --
> > > > Func#11 is safe for any args that match its prototype
> > > > btf_vmlinux is malformed
> > > > reg type unsupported for arg#0 function xdp_dispatcher#29
> > > > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > > > ; int xdp_dispatcher(struct xdp_md *ctx)
> > > > 0: (bf) r6 =3D r1                       ; R1=3Dctx(off=3D0,imm=3D0)
> > > > R6_w=3Dctx(off=3D0,imm=3D0)
> > > > 1: (b7) r0 =3D 2                        ; R0_w=3D2
> > > > ; __u8 num_progs_enabled =3D conf.num_progs_enabled;
> > > > 2: (18) r8 =3D 0xffffb2f6c06d8000       ; R8_w=3Dmap_value(off=3D0,=
ks=3D4,vs=3D84,imm=3D0)
> > > > 4: (71) r7 =3D *(u8 *)(r8 +0)           ; R7=3D1
> > > > R8=3Dmap_value(off=3D0,ks=3D4,vs=3D84,imm=3D0)
> > > > ; if (num_progs_enabled < 1)
> > > > 5: (15) if r7 =3D=3D 0x0 goto pc+141      ; R7=3D1
> > > > ; ret =3D prog0(ctx);
> > > > 6: (bf) r1 =3D r6                       ; R1_w=3Dctx(off=3D0,imm=3D=
0)
> > > > R6=3Dctx(off=3D0,imm=3D0)
> > > > 7: (85) call pc+140
> > > > btf_vmlinux is malformed
> > > > R1 type=3Dctx expected=3Dfp
> > > > Caller passes invalid args into func#1
> > > > processed 84 insns (limit 1000000) max_states_per_insn 0 total_stat=
es
> > > > 9 peak_states 9 mark_read 1
> > > > -- END PROG LOAD LOG --
> > > > libbpf: prog 'xdp_dispatcher': failed to load: -22
> > > > libbpf: failed to load object 'xdp-dispatcher.o'
> > > > libxdp: Failed to load dispatcher: Invalid argument
> > > > libxdp: Falling back to loading single prog without dispatcher
> > > >
> > > > Can this regression be fixed before kernel 6.2 ships ?
> >
> > I'm seeing the same failure on 32 bit ARM on v6.13.
> >
> > Have you found a solution?

> When I try the link from the discussion:
> https://github.com/tjcw/bpf-examples/tree/tjcw-explore-sameeth
> I get a 404 error from github.

I'm have the same error as Chris Ward wrote in their original mail. But
I'm using the xdp-tutorial's [1] basic01-xdp-pass/xdp_pass_user example.

[1] https://github.com/xdp-project/xdp-tutorial.git

This is my error message.

| sudo ./xdp_pass_user -d lan0
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: prog 'xdp_dispatcher': BPF program load failed: Invalid argument
| libbpf: prog 'xdp_dispatcher': -- BEGIN PROG LOAD LOG --
| btf_vmlinux is malformed
  ^^^^^^^^^^^^^^^^^^^^^^^^

Now I understand, what this error message wants to tell me. I should
recompile my kernel with CONFIG_DEBUG_INFO_BTF=3Dy.

| 0: R1=3Dctx() R10=3Dfp0
| ; int xdp_dispatcher(struct xdp_md *ctx) @ xdp-dispatcher.c:118
| 0: (bf) r6 =3D r1                       ; R1=3Dctx() R6_w=3Dctx()
| ; __u8 num_progs_enabled =3D conf.num_progs_enabled; @ xdp-dispatcher.c:1=
20
| 1: (18) r8 =3D 0xc3b45cc8               ; R8_w=3Dmap_value(map=3Dxdp_disp=
=2Erodata,ks=3D4,vs=3D124)
| 3: (71) r7 =3D *(u8 *)(r8 +2)           ; R7_w=3D1 R8_w=3Dmap_value(map=
=3Dxdp_disp.rodata,ks=3D4,vs=3D124)
| 4: (b7) r0 =3D 2                        ; R0_w=3D2
| ; if (num_progs_enabled < 1) @ xdp-dispatcher.c:123
| 5: (15) if r7 =3D=3D 0x0 goto pc+136      ; R7_w=3D1
| ; ret =3D prog0(ctx); @ xdp-dispatcher.c:125
| 6: (bf) r1 =3D r6                       ; R1_w=3Dctx() R6_w=3Dctx()
| 7: (85) call pc+135
| btf_vmlinux is malformed
| R1 type=3Dctx expected=3Dfp
| Caller passes invalid args into func#1 ('prog0')
| processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
| -- END PROG LOAD LOG --
| libbpf: prog 'xdp_dispatcher': failed to load: -22
| libbpf: failed to load object 'xdp-dispatcher.o'
| libxdp: Failed to load dispatcher: Invalid argument
| libxdp: Falling back to loading single prog without dispatcher
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| Success: Loading XDP prog name:xdp_prog_simple(id:118) on device:lan0(ifi=
ndex:4)


With the CONFIG_DEBUG_INFO_BTF=3Dy kernel the verifier seems to be more
happy. Now it fails with "-22":

| sudo ./xdp_pass_user -d lan0
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: prog 'xdp_pass': BPF program load failed: Invalid argument
| libbpf: prog 'xdp_pass': -- BEGIN PROG LOAD LOG --
| Extension programs should be JITed
| processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
| -- END PROG LOAD LOG --
| libbpf: prog 'xdp_pass': failed to load: -22
| libbpf: failed to load object 'xdp-dispatcher.o'
| libxdp: Compatibility check for dispatcher program failed: Invalid argume=
nt
| libxdp: Falling back to loading single prog without dispatcher
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| Success: Loading XDP prog name:xdp_prog_simple(id:20) on device:lan0(ifin=
dex:4)


After unloading and enabling the JIT...

| =E2=9E=9C (pts/0) frogger@riot:xdp-tutorial/basic01-xdp-pass (main=E2=9C=
=97) echo 1 |sudo tee /proc/sys/net/core/bpf_jit_enable                    =
              =20

=2E.. the dispatcher fails to load with "524". Yes, the number is
positive.

| =E2=9E=9C (pts/0) frogger@riot:xdp-tutorial/basic01-xdp-pass (main=E2=9C=
=97) sudo ./xdp_pass_user -d lan0 --unload-all
| Success: Unloading XDP prog name: xdp_prog_simple
| =E2=9E=9C (pts/0) frogger@riot:xdp-tutorial/basic01-xdp-pass (main=E2=9C=
=97) sudo ./xdp_pass_user -d lan0            =20
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| libxdp: Compatibility check for dispatcher program failed: Unknown error =
524
| libxdp: Falling back to loading single prog without dispatcher
| libbpf: elf: skipping unrecognized data section(7) xdp_metadata
| Success: Loading XDP prog name:xdp_prog_simple(id:48) on device:lan0(ifin=
dex:4)

strace indicates this syscalls fails:

| bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint=3D{name=3DNULL, prog_fd=3D17=
}}, 16) =3D -1 ENOTSUPP (Unknown error 524)

I'm on a armv7l, i.e. a 32 bit ARM system. Maybe I'm missing some kernel
option or BPF_RAW_TRACEPOINT_OPEN is not supported on armv7l. Will look
deeper into the kernel config options tomorrow.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4eimhjfg3mx4uc63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme+SugACgkQDHRl3/mQ
kZym9QgAhImQR2nv2LbKQCYUtfl8kx4lC3rP4M/Zf4YR9P9qBIqShfyAMDBEMDrx
m4c3OUPTugMDtYO6JLQM7A+SgCSn0lPkrj+yaygZb0f8YSvCNy8Z4PALaMm2R6wO
dnY+DL0ysv1ECc0e3F0fhZSqxda1Dzxfi4KPOVHAfhLrij6ET+fQBggpKes567Kv
5qruYFCqxj67v6e0qINB59Q/qFi280cUO9KmcXYe1aqgp2e1I36eqKkgMD6FQc/p
PDjImetj6Gp92p3KXQW7oU3EW7EDSqNAHewyy9rH6+AcaTfmwDVD76fZJ5Y+ocm3
5uvddOsEquEz9AAACpR4ZRCllCYuNg==
=AB+9
-----END PGP SIGNATURE-----

--4eimhjfg3mx4uc63--

