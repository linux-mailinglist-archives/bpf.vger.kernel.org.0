Return-Path: <bpf+bounces-58060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66EAB4720
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13AB1B41CA5
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758892609EE;
	Mon, 12 May 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSp/UDlo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BF2512F1
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087649; cv=none; b=XNHkUXjdjXqudNB74tY1YFNwOBAxS/cBmuL6otOrbprnGObZM03zw0gxmE8Q9Flo81rTgYHjUfnmpT/cTgb4bxL5CBC4Jj/Q3qi6GxkU4yhyGYS+zoGL8dlgDeNUN8zmmwNNqvKanDZIU9bmRuuaRj5gPV+k30SoBCY361kY+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087649; c=relaxed/simple;
	bh=Hh0ihlqiO5FJBjBifeNlxmS6EVhsEvTTaQ+MCHiegnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fE+szXbd0Famldnbijn4wjTGVmAMbb4ts4ccKqpp/l2BIukqSKG7zP7BmRuqI7QNvEJ9Q0+M/gSR5GN/QTbDHqZMQ3wxigGDZF77BQ4RIqc5+RFX48GKMb4+YjtYG/+xoaaVRESSD5SnedrV3bi9uxbzHG9Wp11d3Q6I4E6TaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSp/UDlo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b9625662so4017179f8f.3
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747087645; x=1747692445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO+btBJX9FF78G4msCowpwpzhlKdxeU2sg1jA21V2Ok=;
        b=PSp/UDloKHRUJHOfxmovXOKF13Z/SsvEPOzpOzCNDX/4Q9KoqXNTFwMiZozJ+28BCk
         d5MjGW40kmbxl0kMtjr7Ee+qtOXM2R22sD+50wehYJ6XeG0kW8omyrpgyfTqMQWqgUIe
         aMQnYKT2s0q/yudtHk0k7iGGhJu8RLfE0vnRja+hLzKlssEqls6hluNxBCMKpLPK4b9q
         cgAkMRrL/eZC4zDn9k1+DNzveyopWnI2unNfiQp4+BpP8AQ1+b9snsVjiphX0OMu8iK7
         AhWAjFkIJfVNAOyrBsu7XLbp5jvct/DhA+b2c4vkwS/hqE7m8/w8ZBwUy1N5q/tbac/v
         xs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087645; x=1747692445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO+btBJX9FF78G4msCowpwpzhlKdxeU2sg1jA21V2Ok=;
        b=ZgeTUmowVGB0t0smQUHi3rvFPd7mVe84f3VyyfDIejaJRVUS99F0eXgdmEOA0IIl31
         thjm4N/OhdAU5nRHg3O9+vay9/ZRoWSEcOoVbhkQzm7YxQAPyiAAccBkZOfTyom4VDHu
         nY5Wn97T3OV37IGy0Y2a+pGmL9FjHbRHsXQXGSFIftHv7/IHvonzLY78FqBxDs5IRSYc
         hwOWycxlUqys/E62+9grd750Qc1mVDpZ6FtCfSoUqiboaCqBAxnbjptJHIoN7CgDr9l+
         Yjd7FWrTuDTMjfY6LA44uFBk9DCEwI5zgHp53GTR509CRviecyQ8X45UFwP+G/IYbjYE
         rktg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Mg/cKCXd4RMstRGtnQ5k5jjCvAe3E4eM2+2Xm8wWeo/vA6QmfgdzNB3us8E0Ra7Pof4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGznouPmUDiEmjRNeYN15a1Ova2gglLx1tOxUiNkgbHKLZx7c+
	bFHBbp+C067i1qVelaQ1s/+7KjKsbV2ZqCWH94GcXgQ5D5EcNd3oE7+t2rEFOZJ6zbjdX9lpqTB
	0paPcZja+Y5mrM+VC5GP7t2Q/fUo=
X-Gm-Gg: ASbGncut1kGWC1kW73WMWTfA4iDXXD7cGOCPZ7P26GxpSr+Z8cF/JBr5pxL6sIuaMQz
	+eVgLsDAZfmzRV5HOhxi8sCVtuQAHEoOIeLeIPioxGTbaLogpRW8ToSVh/4Fag2556MJzjYkMIR
	mOfnpxDxYnOZ27S2E02anmRpChmnzMoZuWI7+Ixeodpbjp8Gnp1vN5s1n2suPDvg==
X-Google-Smtp-Source: AGHT+IGE8KKudctGjEL3owN5r0KyzBgEHHXdaqBFk0NJIv3ADIWuAsE+rOsWDWJtQK3fLUkhkvZEnACSyWW6TsItVaY=
X-Received: by 2002:a05:6000:2511:b0:3a0:7fd4:2848 with SMTP id
 ffacd0b85a97d-3a1f64c0cb2mr13120447f8f.52.1747087645487; Mon, 12 May 2025
 15:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-11-memxor@gmail.com>
 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
 <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
 <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com>
 <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com>
 <CAEf4BzanV6=_HHVVNxC1Vfsg6R7XYPxsCdEqVXsyBvA4zrGzbw@mail.gmail.com>
 <CAP01T75+6RsdyWXEQNcvPrZnZmH_Ykga5Km4hOgQShVgS2-rLQ@mail.gmail.com>
 <CAADnVQKgtcxQbt_Gbz=oHCa7B3u68Kw2QcFbeE--8whG=KfY1Q@mail.gmail.com> <CAP01T74qmZ4VwVoctX8yh62k=H=XvQfSNyDf_HEe8Ti6oS_MaA@mail.gmail.com>
In-Reply-To: <CAP01T74qmZ4VwVoctX8yh62k=H=XvQfSNyDf_HEe8Ti6oS_MaA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 15:07:14 -0700
X-Gm-Features: AX0GCFtbk_E2yZlXdokp1m00I2-UnFLtMcdxHAZ_TCJnFYdo3J0beDqaf-F4yNI
Message-ID: <CAADnVQLKA=-JEVo95pShbVJCe3-Zxr5pzRk8Emb_cD6T0FpVuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 2:57=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 12 May 2025 at 17:50, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 12, 2025 at 1:51=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 9 May 2025 at 17:33, Andrii Nakryiko <andrii.nakryiko@gmail.c=
om> wrote:
> > > >
> > > > On Fri, May 9, 2025 at 11:48=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, May 9, 2025 at 11:31=E2=80=AFAM Eduard Zingerman <eddyz87=
@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, 2025-05-09 at 10:31 -0700, Alexei Starovoitov wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream d=
ata?
> > > > > > > Or add a new command ?
> > > > > >
> > > > > > You mean like this:
> > > > > >
> > > > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uap=
i/linux/bpf.h
> > > > > > index 71d5ac83cf5d..25ac28d11af5 100644
> > > > > > --- a/tools/include/uapi/linux/bpf.h
> > > > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > > > @@ -6610,6 +6610,10 @@ struct bpf_prog_info {
> > > > > >         __u32 verified_insns;
> > > > > >         __u32 attach_btf_obj_id;
> > > > > >         __u32 attach_btf_id;
> > > > > > +       __u32 stdout_len; /* length of the buffer passed in 'st=
dout' */
> > > > > > +       __u32 stderr_len; /* length of the buffer passed in 'st=
derr' */
> > > > > > +       __aligned_u64 stdout;
> > > > > > +       __aligned_u64 stderr;
> > > > > >  } __attribute__((aligned(8)));
> > > > > >
> > > > > > And return -EAGAIN if there is more data to read?
> > > > >
> > > > > Exactly.
> > > > > The only concern that all other __aligned_u64 will probably be ze=
ro,
> > > > > but kernel will still fill in all other non-pointer fields and
> > > > > that information will be re-populated again and again,
> > > > > so new command might be cleaner.
> > > >
> > > > +1, but I'd allow reading only either stdout or stderr per each
> > > > command invocation to keep things simple API-wise (e.g., which stre=
am
> > > > got EAGAIN, if you asked for both?) I haven't read carefully enough=
 to
> > > > know if we'll allow creating custom streams beyond stderr/stdout, b=
ut
> > > > this would scale to that more naturally as well.
> > > >
> > >
> > > What's your preference/concerns re: pseudo files in sysfs?
> > > That does seem like it would be simplest for someone using this
> > > (read() on a file vs special BPF syscall).
> >
> > sysfs is abi.
> > If we start creating directories:
> > /sys/kernel/bpf/<prog_id>/stdout
> > it will be permanent.
> >
> > Though I'd like to see it, I feel we're not quite ready
> > to cross that bridge.
> >
> > Let's add a new sys_bpf command for now,
> > some trivial helper function in libbpf,
> > and corresponding bpftool support.
>
> Ok, but the new sys_bpf command is also ABI, no?
> I'm fine with either, but it seems both will be permanent.
> Only difference is visibility.

Right, but the blast radius is smaller.
cmd is easier to extend.

