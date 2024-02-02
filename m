Return-Path: <bpf+bounces-21098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C15847C16
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2331A1C22CF1
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343883A10;
	Fri,  2 Feb 2024 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRtuSQNH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C7839F2
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911826; cv=none; b=u4RW/DSvC0vnUXEBAfu42s1DYXxXreKIg82woXhwX810SV3KoT7qCm+XX/arUrzbSmQ9aDRolvzztWc8u8AHDlX/30EOkJCZNOGrBU/KgT4GOOIIenb6bZq5Mx0pNYNiwFcAY0JuGBbVPojY2OktpGUzhMSkrjR5298Bmw0gau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911826; c=relaxed/simple;
	bh=FvcQLVBQnDbqVQ8r9LgDny7WpEDF2DUenQyPv/NJmKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqPFBOFeIzW3Nj1lhg7CCE052mOh/SvaNvhDI6bPwMfH0pYgSh+AGjC/0BVurGqY3qia9iqCciEtSo9NdqA05anqjqfJ0mriFMyn4jDcheVerptH4lQgVkqkOtf9a3kxoW2S3XcfyVYi3UXsMst1QQ0Fx+ee//cqDRf7C19NHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRtuSQNH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dfebd129a1so1339402b3a.2
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911825; x=1707516625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvcQLVBQnDbqVQ8r9LgDny7WpEDF2DUenQyPv/NJmKk=;
        b=KRtuSQNH3aKoM49ejFJs8dW9G+BwCZk9P+4x1p/aEp3kvTQR9i5pUypmAwpNQX5Ggk
         M28ADRoxzXEmo6EfQGPUhJQW26P3laivZg86L0ZpgoVtdow4R5xS0o3l/H9m3MZ1/nCX
         nv3hd2zS12HdBBDS9QSfqs5pOt1xaq19sHsY1m5jIYeKlfD4fDeAI4OGkiCPinb/7utL
         c7B9SNLO8c7wX84ESor2ximj+mwcq3vSfwcqm5K3V19SWP2vKIEKqvCZ1k431tISWQdc
         w/hnoPVgSh7+55tAkjvWvHDYh8DFmDoX0V9yUD2+n27h5QeZO1Vb+PXJNF9S+UYWHqP0
         +JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911825; x=1707516625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvcQLVBQnDbqVQ8r9LgDny7WpEDF2DUenQyPv/NJmKk=;
        b=H8i3JZq2bmWXhXYMp1j6oDwATAvkVor/tpcPPvEWsXO5z8KAqijnCLoDmEnAW5Zghk
         Oqdsg8q+bYEN/JqnvrFNZ4m1qBebkuA6uxzXDL1lups1JV1kvXAqaeJs3778cbtWV1GQ
         Y+BTjLcTzU2oIsVKsiU0R9WTA4ogMqXysz7yBgXOcpFnlI6wx72iPJjRE7wdPv5PUXOk
         pPgvFdU3uSnMQwTYZfXsNNlAuXB/ZbmwuLnI7eJbdppI5pyPSb7zPyeVi46N3Mzq8uz7
         ymefN5SF5IQc+mTHK8Ec7m7omfwKm4B0hw5sbAH/xBGg5psGYC9KSYQH3vO9uz8SL7eR
         Dn9Q==
X-Gm-Message-State: AOJu0YzurHW1xy1WEQ/5PKUhqqSGi6DJMlk1ds9gNLpAS6edS6ZZsPaN
	HgCtjz2azOkHRpaEiViSG06n06hzi3J6pAKGfbgX74Rd3xOpbt3PoFS4s1OFmnRlha9tsP10as2
	qmRJecJeJ5Yfwm92uPBh0XW8FSQc=
X-Google-Smtp-Source: AGHT+IE42bxVEUEu8pCRvzPCFisoAtBD6liIM1kgCLk79A+coPFlFAE6/aZSBprlQRlRTEaYM2QgjIBA0uQAJixkhSA=
X-Received: by 2002:a05:6a00:1825:b0:6dd:c404:1ff4 with SMTP id
 y37-20020a056a00182500b006ddc4041ff4mr4531443pfa.1.1706911824699; Fri, 02 Feb
 2024 14:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
In-Reply-To: <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 14:10:13 -0800
Message-ID: <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Bryce Kahle <bryce.kahle@datadoghq.com>
Cc: Quentin Monnet <quentin@isovalent.com>, Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:05=E2=80=AFPM Bryce Kahle <bryce.kahle@datadoghq.c=
om> wrote:
>
> I have discovered an issue with this approach. If you minimize the
> vmlinux file first, then it can remove/renumber types that are
> referenced from the module BTF. This causes bpftool to fail to parse
> the module BTF file. Likewise, if you minimize the vmlinux second,
> then the minimized module BTF will reference invalid vmlinux type IDs
> because they have been renumbered/removed.
>
> We essentially need to minimize all the modules and the vmlinux at the
> same time.

Maybe the right solution is to concat vmlinux and all the relevant
module BTFs first, dedup it again, then minimize against that "super
BTF". But yes, you'd have to specify both vmlinux and all the module
BTFs at the same time (which bpftool allows you to do easily with its
CLI interface, so not really a problem)

>
>
> On Wed, Jan 31, 2024 at 4:54=E2=80=AFPM Quentin Monnet <quentin@isovalent=
.com> wrote:
> >
> > 2024-01-30 23:05 UTC+0000 ~ Bryce Kahle <git@brycekahle.com>
> > > From: Bryce Kahle <bryce.kahle@datadoghq.com>
> > >
> > > Enables a user to generate minimized kernel module BTF.
> > >
> > > If an eBPF program probes a function within a kernel module or uses
> > > types that come from a kernel module, split BTF is required. The spli=
t
> > > module BTF contains only the BTF types that are unique to the module.
> > > It will reference the base/vmlinux BTF types and always starts its ty=
pe
> > > IDs at X+1 where X is the largest type ID in the base BTF.
> > >
> > > Minimization allows a user to ship only the types necessary to do
> > > relocations for the program(s) in the provided eBPF object file(s). A
> > > minimized module BTF will still not contain vmlinux BTF types, so you
> > > should always minimize the vmlinux file first, and then minimize the
> > > kernel module file.
> > >
> > > Example:
> > >
> > > bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> > > bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
> > >
> > > v3->v4:
> > > - address style nit about start_id initialization
> > > - rename base to src_base_btf (base_btf is a global var)
> > > - copy src_base_btf so new BTF is not modifying original vmlinux BTF
> > >
> > > Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
> >
> > Looks good, thank you!
> >
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> >
>

