Return-Path: <bpf+bounces-52560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D1AA44A74
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 19:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171763AB4F9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE5F19DF4F;
	Tue, 25 Feb 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npqMRZi2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259D20DD42;
	Tue, 25 Feb 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507678; cv=none; b=Sn8ltjVyff8mNh0T/MLP72hm5C+xX1x22nPi5m6RJot0VrJRpenU9xTQ/esMthRm3HzegUEeD+rO0ESXrJr/hgLm0jyofia2ys61NpRSlhZfTI3eGnKpL6Zyn3Q14huEpZ+FFgsDbHRaSvY6zLFvMuHBA9udrlFbH+bABIzD27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507678; c=relaxed/simple;
	bh=P9rtsNS+RCkc638Dy/ti+/Tl+inwmItniR5TKEAyZyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ACbOfsibwE4+kFHceZ49ZCLeLfH7TQ6NNAfcCp77doez9iRFUef7+FgXKJ51Ggb2S0yDJC5/g1JL2QLxBnPg9rO6sQBCAixZIyYr0v49/isjxmNSSqQhEQ10E41Beq636Ro373ckM1DcItJdy7oJiS9RQzK/SX5aMOnEeisNtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npqMRZi2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22100006bc8so106100195ad.0;
        Tue, 25 Feb 2025 10:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507676; x=1741112476; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERH+Ahahw4gBYxe9gONT8K3CBgmHlt+LMhgiDC0SriA=;
        b=npqMRZi23FRCk6BLGB2RmctKsRFt6Zo87tGM/QXnx2s4pkF7QW60FTGMqyjrJZz2vZ
         kFbIw2LL+F+JZx/aZ95eggyKs4IuO/59gCgarAYvJZJt9qvW06KE4VVCke56taH0myUL
         SfnbvLzvEYpwGlH/VNfrhXF5GK9UsPvvsO0ad/x/31IuoFPxAi29R1roclYaNd5n4LGz
         wzVjtzYwzqAzKQohTkx0CSRJS0CHfLC7pmHt1k7YXdZ+GqCa+7tztmCRNRqcHYZqHaEQ
         8L2UfzOIZsxQuiewlaIvpplVZWUG1CBsys3VxQzWkrSCwYd83cD+CA9KfqyYKdBlx8kz
         iBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507676; x=1741112476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERH+Ahahw4gBYxe9gONT8K3CBgmHlt+LMhgiDC0SriA=;
        b=cIVeqznoRXoGwKy7rgMkrktw975Js1JfXbj+o1s1PvDs+CWqNzgpsymf+Z5ggR4wGV
         eRAftNd5PMdYdtRPe/y2YVUL+Qtv+4OBFLZWqy7ezEqhZymDIJkNJe+vG9jy/olRrRf1
         +fGsvPcst/qOh99YmRsp4XOjCGf5XhJSF5QcmuQvlTbr4+dPfJqSOMTg/mdzTK13nsr0
         hexgqtZJXslGYs+eBKs67An7pOSAgZOCB9BctTRgW5pCuBQgkE8xh+a77KX3EacON/Nc
         XBZ1QOvkM0ZedxbOoPuihYnzASfw560NWYJ0sosajppJY75CMKuL9EO20hNOe5MP9Z8f
         kG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr/hewi9zs11ydijPMn1zbx0lZKbEOBMcmIYeVswxUqKzIszwYkAS/7OteGlDRxmYGEXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxujqjLUVioI8NOnNTt9YS8V6mztk93XgYJZJNqMO3ojQOm/Yc4
	mhxztKQVyeAFcbmVINPa6wEboUTd9G9zB6EDJxirHJXYgcHyT4/y
X-Gm-Gg: ASbGnct0caoBn9YhWY2kcokdCjvFAdQEx1MIq+63RdnScrYkrd5Shn3fFEYJyv+2dFL
	adPbOlYRCmuYtIPDjVMGGA2uGB0p3DmkvzyNEgbcOq59OFavVMFXLSO2itH/OU9xFrGQ9bZdwl+
	HVRQykJQAPrmyKarOIbTZfBHpZpHeDsPmvodC+iF3xXc6gf3J58+NXgayZtdI24iDqSwyTSbw2i
	sMS+r+Nor8opZ4ELx73tmTHUonZFwOIAseVyUoupQeFyNdEE9+McTEy/OPPmr6HZuJLHpVtgDNr
	hADIQu6R16o3FjvQywXoopA=
X-Google-Smtp-Source: AGHT+IEMqPHR0NMAoe4xmOR8PtXIJmCH6EJvppt+4qmwAdSs8BFuE8kVjEVtBO4C+ggntHBXBp1Rwg==
X-Received: by 2002:a17:902:e5ce:b0:216:6283:5a8c with SMTP id d9443c01a7336-22307e67561mr67577015ad.39.1740507675939;
        Tue, 25 Feb 2025 10:21:15 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00ac23sm17475995ad.81.2025.02.25.10.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:21:15 -0800 (PST)
Message-ID: <397970e484d2d0c1e0649d78cc723fbe3ad2ad5f.camel@gmail.com>
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
From: Eduard Zingerman <eddyz87@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Chris Ward <tjcw01@gmail.com>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	 <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Ward <tjcw@uk.ibm.com>, 
	bpf@vger.kernel.org
Date: Tue, 25 Feb 2025 10:21:11 -0800
In-Reply-To: <20250225-gay-awesome-copperhead-502cd2-mkl@pengutronix.de>
References: 
	<CAC=wTOhhyaoyCcAbX1xuBf5v-D=oPjjo1RLUmit=Uj9y0-3jrw@mail.gmail.com>
	 <CAC=wTOgrEP3g3sKxBfGXqTEyMR2-D74sK2gsCmPS2+H-wBH6QA@mail.gmail.com>
	 <20250225-gay-awesome-copperhead-502cd2-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-25 at 16:55 +0100, Marc Kleine-Budde wrote:
> On 23.01.2023 12:35:41, Chris Ward wrote:
> > The 5.15.0 kernel (built by 'git checkout v5.15' from the kernel.org
> > torvalds tree) fails in the same way that the 6.2.0-rc5+ kernel fails.
> > So it seems that something Canonical did for the Ubuntu 20.04 kernel
> > causes eBPF to work correctly.
> >=20
> > On Mon, 23 Jan 2023 at 11:06, Chris Ward <tjcw01@gmail.com> wrote:
> > >=20
> > > I am trying to use the 'bleeding edge' kernel to determine whether a
> > > problem I see has already been fixed, but with this kernel the eBPF
> > > verifier will not load the dispatcher program that is contained withi=
n
> > > libxdp. I am testing kernel commit hash 2475bf0 which fails, and the
> > > kernel in Ubuntu 22.04 (5.15.0-58-generic) works properly. I am
> > > running the test case from
> > > https://github.com/tjcw/bpf-examples/tree/tjcw-explore-sameeth ; to
> > > build it go to the AF_XDP-filter directory and type 'make', and to ru=
n
> > > it go to the AF_XDP-filter/runscripts/iperf3-namespace directory and
> > > type 'sudo FILTER=3Daf_xdp_kern PORT=3D50000 ./run.sh' .
> > > The lines from the run output indicating the failure are
> > > libbpf: prog 'xdp_dispatcher': BPF program load failed: Invalid argum=
ent
> > > libbpf: prog 'xdp_dispatcher': -- BEGIN PROG LOAD LOG --
> > > Func#11 is safe for any args that match its prototype
> > > btf_vmlinux is malformed
> > > reg type unsupported for arg#0 function xdp_dispatcher#29
> > > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > > ; int xdp_dispatcher(struct xdp_md *ctx)
> > > 0: (bf) r6 =3D r1                       ; R1=3Dctx(off=3D0,imm=3D0)
> > > R6_w=3Dctx(off=3D0,imm=3D0)
> > > 1: (b7) r0 =3D 2                        ; R0_w=3D2
> > > ; __u8 num_progs_enabled =3D conf.num_progs_enabled;
> > > 2: (18) r8 =3D 0xffffb2f6c06d8000       ; R8_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D84,imm=3D0)
> > > 4: (71) r7 =3D *(u8 *)(r8 +0)           ; R7=3D1
> > > R8=3Dmap_value(off=3D0,ks=3D4,vs=3D84,imm=3D0)
> > > ; if (num_progs_enabled < 1)
> > > 5: (15) if r7 =3D=3D 0x0 goto pc+141      ; R7=3D1
> > > ; ret =3D prog0(ctx);
> > > 6: (bf) r1 =3D r6                       ; R1_w=3Dctx(off=3D0,imm=3D0)
> > > R6=3Dctx(off=3D0,imm=3D0)
> > > 7: (85) call pc+140
> > > btf_vmlinux is malformed
> > > R1 type=3Dctx expected=3Dfp
> > > Caller passes invalid args into func#1
> > > processed 84 insns (limit 1000000) max_states_per_insn 0 total_states
> > > 9 peak_states 9 mark_read 1
> > > -- END PROG LOAD LOG --
> > > libbpf: prog 'xdp_dispatcher': failed to load: -22
> > > libbpf: failed to load object 'xdp-dispatcher.o'
> > > libxdp: Failed to load dispatcher: Invalid argument
> > > libxdp: Falling back to loading single prog without dispatcher
> > >=20
> > > Can this regression be fixed before kernel 6.2 ships ?
>=20
> I'm seeing the same failure on 32 bit ARM on v6.13.
>=20
> Have you found a solution?
>=20
> regards,
> Marc
>=20

Hello,

When I try the link from the discussion:
https://github.com/tjcw/bpf-examples/tree/tjcw-explore-sameeth
I get a 404 error from github.

(Sorry for previous email, it was sent unintentionally).


