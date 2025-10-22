Return-Path: <bpf+bounces-71657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF31BF9974
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC173B0A19
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0081FCF7C;
	Wed, 22 Oct 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0AP2GnV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C81D88A4
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095737; cv=none; b=HH+BdxhLAz44b1RiigwZWtAvg//lHEEKLb8GxsmxQNvmpM/kvP5E3myZEjQ4YZoDslazdvHwCnDQaZwVQ/nND+iX54UvxYeEgbouM82gE9fjUTv9hvKXHGIIFwGHK1n0XRNc6hmyJC0Rs6OAtBk15Cb3mp5u7Wi9IdilAZDJVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095737; c=relaxed/simple;
	bh=Jr9o8Fe1cMM3n6Vlk+UfVvrS4X6V47Y9qhlCyKITm0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0myV6Iaq1tsoaqS5wEpMndRrTMxEM3k48MRnUWqWtcEAcrn5Vd9FGDEiDMr6+f7wBtu7bEqoKxNu6y8kyzwcI8ehlFSzfDfp0NJRg4eqIBvSelyMTt31qy7i7HDXXCyUBNwBMJAbJKwBzv5yjdNPWJ7fTR81eufdlDa3Z8k1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0AP2GnV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso844136a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 18:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761095733; x=1761700533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woIbsdxyP3SY2orn275GN3OxfriuvKkh/5p7Czi2+bM=;
        b=c0AP2GnVK9voeE+G28kwj4ROp/PTI9+xZjKV/vF+4qKRWFyUGOortsuSSnt7I8I+Uk
         DPwfm3u5p/JL2LdEqVPu+/XyvfZb2oiw4r9jjLf3TKuUYIK+jWBtGX+CeNsaH/LmDz1m
         BPZEUaajJhlHOAzVi7cHc5puB3W+tAniv7D9eG6hmLEqa2cZlT+XtrHbPDfa7hFVZXLT
         AxiLVgPxenyGXvCSJx7OU7gUVL5+lz/wS2npNV2v+8BmKQvfL/wsNRk+AZiTBbD7dg84
         xJ4ezO8GwP9MT2QNzr+Le/TKAEGaPusjOsWygeikrtuPpgNOyFw+4R5FfWvCUqyWlBTm
         eITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761095733; x=1761700533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woIbsdxyP3SY2orn275GN3OxfriuvKkh/5p7Czi2+bM=;
        b=Z+dddOCbWq4YWoA9cUdILdgYINJnikTJcfD70HCwVV1odCx6hEEZNIoEkXYh3qmcBF
         kBcK7cjCks4/ML5ndpSVpdKtj9bAPsF4USbfK3M9fnbFKLbIP1FGRyrPwLgX1crakUKm
         E/CFR1Ah6Xtch9mdLHx60ATirTiqaONRKjt+YSVdIQlOJP8Akskxl/iHJfCnMAJyYUbp
         NX7rA/MC7xBWswj8nTzS9fjybBptNJkDxC3ejxrdCOqPWIwgMo3ICVvu29BJx12xi4OA
         gbUlYKbX1kL/PEdfJ/krNs+zaEIgUqpDlEiycRk7oGFGMcZvK33G6GKfTV6xtbvg1cLm
         r9xA==
X-Forwarded-Encrypted: i=1; AJvYcCX/l4vy1pTMjENzDCm4VG0GN6UXMKfkAFRv4KuhXkpG4eg9AwR4gR0puf/hpV45cfnlXHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSl0yW7MokETtV33bInbdktDIMnXYzw/DVNS+ZRjnrqGhkbzr
	/V+HwIlLs91vSokTNEKPlPJ/Fuz0hyOm9PDITvRoU4eASs/+Z1vmHCWDltTY6XATQhLb/bRGR4I
	S6MBm8O8ifjW3O6agd06hNdCM7k5qMus=
X-Gm-Gg: ASbGncuBcn2tKsxvivN1g7jzjVccLllCAng/fMN+Pert8pXS2dWkhfx3e+k2oW1aqzN
	+4FsREbtN/PH5gy0aB9M/7I6m4PRo1vT0zHbp7AqFj+ISyGjERum1nlOOOCGWWtNNrX4a2X+h0c
	661eGkBA3xrvfZCK6fsACx4RoCkdxY1AKkYG3/Np9p2SBudlJIYrJJI3d/+1Z2xYbcL9T47NjhS
	oRi0QdGxGeDtaUEqOEcgXFdUAvb5tXM6u0qEW3/DcHdM5TKaACVl6OgsDgaWw==
X-Google-Smtp-Source: AGHT+IF8qT+3cQlutV2V5LKeFy+yWaAPEmk3Tmkf7M+saEzE2zSCWO8VFBs5h26E80tQEv0kG/6sg9DsaoP8ItQy+eM=
X-Received: by 2002:a05:6402:440b:b0:62f:4828:c7d5 with SMTP id
 4fb4d7f45d1cf-63e173c288cmr1721406a12.16.1761095733265; Tue, 21 Oct 2025
 18:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-6-dolinux.peng@gmail.com> <e8b8b84a-b132-44f0-827b-668f32755ff7@oracle.com>
In-Reply-To: <e8b8b84a-b132-44f0-827b-668f32755ff7@oracle.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 22 Oct 2025 09:15:21 +0800
X-Gm-Features: AS18NWBRkH6bTJXyB56Sq1g9RoN36lgLPFuPztF6E3otkDZ-f1rD7uN3XKCLono
Message-ID: <CAErzpmuSEfgih1-RDN1FAxB5Sd1phKr9Ntr9YmdDw2vXGgZ0Gw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:28=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 20/10/2025 10:39, Donglin Peng wrote:
> > Pahole v1.32 and later supports BTF sorting. Add a new configuration
> > option to control whether to enable this feature for vmlinux and
> > kernel modules.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> >  kernel/bpf/Kconfig   | 8 ++++++++
> >  scripts/Makefile.btf | 5 +++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index eb3de35734f0..08251a250f06 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -101,4 +101,12 @@ config BPF_LSM
> >
> >         If you are unsure how to answer this question, answer N.
> >
> > +config BPF_SORT_BTF_BY_KIND_NAME
> > +     bool "Sort BTF types by kind and name"
> > +     depends on BPF_SYSCALL
> > +     help
> > +       This option sorts BTF types in vmlinux and kernel modules by th=
eir
> > +       kind and name, enabling binary search for btf_find_by_name_kind=
()
> > +       and significantly improving its lookup performance.
> > +
> >  endmenu # "BPF subsystem"
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index db76335dd917..3f1a0b3c3f3f 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -29,6 +29,11 @@ ifneq ($(KBUILD_EXTMOD),)
> >  module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_fea=
tures=3Ddistilled_base
> >  endif
> >
> > +ifeq ($(call test-ge, $(pahole-ver), 132),y)
> > +pahole-flags-$(CONFIG_BPF_SORT_BTF_BY_KIND_NAME)     +=3D --btf_featur=
es=3Dsort
> > +module-pahole-flags-$(CONFIG_BPF_SORT_BTF_BY_KIND_NAME) +=3D --btf_fea=
tures=3Dsort
> > +endif
> > +
>
> perhaps it's useful informationally, but you don't need to wrap the
> addition of the sort flag in a pahole version check; unsupported
> btf_features are just ignored. Also we're at v1.30 in pahole now (we'll
> be releasing 1.31 shortly hopefully), so any version check should be
> v1.30/v1.31. I'd say just leave out the version check though.

Understood, thanks. Will do.

>
> Alan

