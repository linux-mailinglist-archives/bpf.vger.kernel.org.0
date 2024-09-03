Return-Path: <bpf+bounces-38798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A1596A4EC
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314CF1F24A55
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E418BC22;
	Tue,  3 Sep 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm+w2FzK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2717A90F
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382727; cv=none; b=pnv1OM1o14LwLu8V60TjnDlDhS4SPh6Bz1ru2Yq9ZhC6w6ZoP/XfmSFwe+tGYVE06GmTVS36k79QBDUxKRP21VWQn96/JVXwnXsoyClJHBdmP+rM7UOyEAz7xKTWvxFxUukFVfe9gVrRLThAkVAHb+zwO8TyTtBbiDlEyvTlIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382727; c=relaxed/simple;
	bh=OnEXtwX9OTWmCcgb5myyeE5pOzLFIhfy+j1a5H2iuMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+axFYMx1AoBv75CuiErBJ5mqK4LbsHKts8I9MnKsXMZflDOzvhOefsuB6i/kNZ6XBkBQh9MhYZcafqCFgDcrA6emE28UNBOaWDv391WcvQAlbwI/6CT9VgaD8Le6JvBcblHcg4JcSAFy8fJx10LzeEWP+XTSEhsDvdsRgvik+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bm+w2FzK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so2717963a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725382725; x=1725987525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QEB0kuSRNEC5JtqhOMsOqdRUsT6ICW9zCcb3qQiRJk=;
        b=Bm+w2FzKhM8iswDZIuGikvWbfxsm8dfiS07H+lzJyaxIApZ4bsuYT/isyUYiYwB0Qk
         c4qKmzbcWKuk8akTpmUUIqV/n0J72ETzCzP0gTTPL/YwN41BFd2H2931i+71s0cKMjDE
         CTKJYiDkeNXwHhyfdGXjecBYwWyJvAmNEMi2/xz5hGgf5GW4gjYKkf5vqXEBrt6RQYNn
         LqdgIs0U8lXpG8mGJsnKBBOHF2sxwkTHVQHy1/lfoqEMR+xvglvo4xILI7+V75JIqWeY
         PbHP+ws82xPPWtBFySFk7rb4Y3HyPGGoiknzMEi4jnwuCLMZv3/7AXGVuTl1ISjQHVnA
         /jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725382725; x=1725987525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QEB0kuSRNEC5JtqhOMsOqdRUsT6ICW9zCcb3qQiRJk=;
        b=G1/CmFtJnKFMOgmCIupUoQeu/IexxFCYCwMlsl7KRnmnEmvJQT5PPuqR13fb4Gv00N
         8xL29L+qKiE349Ywgk5gTjRHdGw/mJv0LcHjsrRGIE6vv0oArleieu+YGC/2BzOLx6Qe
         QDapAADHsbjOAFb3B1dejQ8iZdspXRL8mMY7hpt8gqoF0lK8PQBtcVpQi//5m38G9axp
         j/UPHwbLnCREMe25ZRX3S43T6S2OIGw/eILz/GxEd3IpbAEZMs5hgeAHa0Yo0qDGl+FN
         x8BnJLhU08pioYRP1ATLLzYD+T31dUlToZnLuW7W0xCx9MUE8kSx0jof+pLrCz9VlQmK
         midA==
X-Forwarded-Encrypted: i=1; AJvYcCXMwqyr0ETEu01Ksob43wZJ5bPys3SRCvvhh8Gb0rNVERi6N7VIf5oLWNVEXMdUebRPV90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fAJM83IIKl9FsL+cXEFXwtOVqEgOYKH5m3P2kUsrXwwukKre
	3nMW5L/I9DAIM0ZnPy5KNL4mVaGQmTbdMeV/WwF6X7CBQuS23jNsySXJKTK6pZE6EmXXfvnIyMX
	VVR7YY32kxQkl2abQUfMKNpnMwKOx0g==
X-Google-Smtp-Source: AGHT+IEZKenWuHig7WqsBuiRnYTQiR64J8W3kOfLy3lhU5eZ8G8GX4xXk3DzXmC2s8eiqDwxu1ueR086L/skdUoLKzg=
X-Received: by 2002:a17:90b:3812:b0:2c9:6aa9:1d76 with SMTP id
 98e67ed59e1d1-2da62fde7efmr3119401a91.18.1725382725030; Tue, 03 Sep 2024
 09:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828174608.377204-1-ihor.solodrai@pm.me> <20240828174608.377204-2-ihor.solodrai@pm.me>
 <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
 <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com> <xldWjE0i64YdD2vmNCSi3aJ7kls4eQT-R_EWtcnRaYIZuWvjdIBwjgGcoBYm02UHiO6bz5ZyyMtBDZXeLxC_iXkdo_PqkdWkMejoocJw5rs=@pm.me>
In-Reply-To: <xldWjE0i64YdD2vmNCSi3aJ7kls4eQT-R_EWtcnRaYIZuWvjdIBwjgGcoBYm02UHiO6bz5ZyyMtBDZXeLxC_iXkdo_PqkdWkMejoocJw5rs=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Sep 2024 09:58:32 -0700
Message-ID: <CAEf4BzYWxcg5qbxr8B3OAyatrfgT8JNysUYW1=vuzjcMF6snVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h unnecessarily
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 11:18=E2=80=AFAM Ihor Solodrai <ihor.solodrai@pm.me=
> wrote:
>
> Andrii, Eduard,
>
> On Friday, August 30th, 2024 at 1:34 PM, Andrii Nakryiko <andrii.nakryiko=
@gmail.com> wrote:
>
> [...]
>
> > I've applied patches as is, despite them not solving the issue
> > completely, as they are moving us in the right direction anyways. I do
> > get slightly different BTF every single time I rebuild my kernel, so
> > the change in patch #2 doesn't yet help me.
>
> Thanks for applying the patches.
> I didn't realize vmlinux.h generation is non-deterministic. Interesting.
>
> >
> > For libbpf headers, Ihor, can you please follow up with adding
> > bpf_helper_defs.h as a dependency?
>
> I've tried tracking down where bpf_helper_defs.h is coming from and
> (assuming my analysis is correct) this header is generated by
> `scripts/bpf_doc.py`. From the selftests/bpf point of view the
> dependency chain is as follows:
>
>   1. vmlinux.h depends on bpftool:
>
>        $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DI=
R)
>
>   2. bpftool is installed for selftests via `make -C tools/bpf/bpftool in=
stall-bin`:
>
>        BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
>        $(DEFAULT_BPFTOOL): ...
>           $(Q)$(MAKE) $(submake_extras) -C $(BPFTOOLDIR) ... install-bin
>
>   3. bpftool install-bin depends on libbpf:
>
>        $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
>          ...
>        install-bin: $(OUTPUT)bpftool
>
>
>   4. $(LIBBPF) recipe runs `make -C tools/lib/bpf install_headers`,
>      which depends on $(BPF_GENERATED) which equals to $(BPF_HELPER_DEFS)
>
>        BPF_GENERATED    :=3D $(BPF_HELPER_DEFS)
>          ...
>        install_headers: $(BPF_GENERATED) $(INSTALL_SRC_HDRS) $(INSTALL_GE=
N_HDRS)
>
>   5. Finally $(BPF_HELPER_DEFS) recipe executes the python script (in lib=
/bpf):
>
>      $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
>         $(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
>                 --file $(srctree)/tools/include/uapi/linux/bpf.h > $(BPF_=
HELPER_DEFS)
>
>
> I don't see any benefit to adding bpf_helper_defs.h as a direct
> dependency of anything in selftests/bpf. %.bpf.o already depend on
> vmlinux.h, and unless we somehow get rid of vmlinux.h dependency on
> bpftool, bpf_helper_defs.h should always be there at a point when
> %.bpf.o objects are compiled.
>

Making sure that bpf_helper_defs.h is generated by the time .bpf.o is
being compiled is one thing. Triggering .bpf.o regeneration when
bpf_helper_defs.h changes is another. The second used to be important
when we were adding new helpers, otherwise we can get compilation
error because of missing helper definitions.

This is much less of an issue today, we we might just leave it as is.
Making sure bpf_helper_defs.h is there might be good enough.

>
> >
> > I have some ideas on how to make BTF regeneration in vmlinux.h itself
> > unnecessary, that might help with this issue. Separately (depending on
> > what are the negatives of the reproducible_build option) we can look
> > into making pahole have more consistent internal BTF type ordering
> > without negatively affecting the overall BTF dedup performance in
> > pahole. Hopefully I can work with Ihor on this as follow ups.
>
> I still know little about how all this machinery works, but I'd be
> glad to help.

I'd like to avoid regenerating BTF inside the vmlinux image, if
possible. This will cut down significantly on incremental kernel build
times. We can chat about this separately a bit later, don't worry.

>
> >
> > P.S. I also spent more time than I'm willing to admit trying to
> > improve bpftool's BTF sorting to minimize the chance of vmlinux.h
> > contents being different, and I think I removed a bunch of cases where
> > we had unnecessary differences, but still, it's fundamentally
> > non-deterministic to do everything based on type and field names,
> > unfortunately.
>
> [...]
>
>

