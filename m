Return-Path: <bpf+bounces-10069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D317A7A0C16
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F1A1C20B1B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF54262BC;
	Thu, 14 Sep 2023 17:58:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645591D54D
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 17:58:38 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD661FF5
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 10:58:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-502934c88b7so2194511e87.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694714315; x=1695319115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow/EkEHuuppRgqaLrjUA4gmZm4vZxN4SCbA0kpXdfeo=;
        b=DhrY3s1Y3kg/Z235qOwaCtTN+Nzo1c1c8T4t1+uvqBL8aulvhY9OozKvciJXJpfU2a
         JD0GeuhkRglzEx9fWxQNdRx2EbdF3+SoZj0LCzm5LyrJzS9EmJ196kWtqsRt+iWUYBPM
         wfrAnxMWR3N0ddfdFGjZatc4wDTO+iQRGw9WmKsKoM3tB4EvS3DvN9VDXxJzYhQosJOs
         auBazbWM6Js4eST+5aIbIYafyA75YUfaB4Rb0i5ewCa1xNKnW61g7/8QznlEOY+7hfrb
         Km4Y1oH+WU1vRAGiR8qZNryD0fIZWXXBnDL23rsYkLTQdHspo41SxHhmtBN9ENFLGD61
         1F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694714315; x=1695319115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow/EkEHuuppRgqaLrjUA4gmZm4vZxN4SCbA0kpXdfeo=;
        b=juibr4/XT2PC+JC2jE/ycJ5uq/E7/ah51kMbkWi4+8ygSCVC17iNsbb3V7rvm43X1F
         DYGbromgX1LriEEZE27EwEm1nQ68XAiTLvaZt44+TwfKgeCU5VtwPfray/ooppjBiZnF
         JtZObtoTuh3vcaCQ02wi7o5jbu++ix4oIJSGn6O2eKpyOxnXf/IQ+k9bBuzCpV5FKUxO
         oKlN123C0ngylzhNyKYd6KOIAbBmvT2r+r2OwEN7g4zMgOYm7XhuGcnqqmU3KrbAiRhm
         lPushV5CpL96EHGGNVmUi1N3tjmz5XXx3KJJXd9oXFhhYA5gYMTUHKxcqTubZed8gMJp
         xd+A==
X-Gm-Message-State: AOJu0Yz5rNyaQb8pZu8k1Zrg+Gjl/U+hwKyUqnPETaN8toWT8KXzIMMR
	BViQ81VpA101A5pv6giNMRp/QU/MtGN8DoPD90s=
X-Google-Smtp-Source: AGHT+IFEkHw8LbVlMggWGrCy0WCFIiFBWoC92It64oNtWxnW5MwXyQZz6DoVVo/JAPiAmFA6Akjm8Cjz16xnJg21VeA=
X-Received: by 2002:a05:6512:703:b0:500:a092:d085 with SMTP id
 b3-20020a056512070300b00500a092d085mr4488886lfs.68.1694714315332; Thu, 14 Sep
 2023 10:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913142646.190047-1-alan.maguire@oracle.com>
In-Reply-To: <20230913142646.190047-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 10:58:23 -0700
Message-ID: <CAEf4BzayTrNnOLj4t2s1aegATjqMdvz1iiGq4A6gMmbxJ+zmYg@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/3] dwarves: detect BTF kinds supported by kernel
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 7:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> When a newer pahole is run on an older kernel, it often knows about BTF
> kinds that the kernel does not support, and adds them to the BTF
> representation.  This is a problem because the BTF generated is then
> embedded in the kernel image.  When it is later read - possibly by
> a different older toolchain or by the kernel directly - it is not usable.
>
> The scripts/pahole-flags.sh script enumerates the various pahole options
> available associated with various versions of pahole, but in the case
> of an older kernel is the set of BTF kinds the _kernel_ can handle that
> is of more importance.
>
> Because recent features such as BTF_KIND_ENUM64 are added by default
> (and only skipped if --skip_encoding_btf_* is set), BTF will be
> created with these newer kinds that the older kernel cannot read.
> This can be (and has been) fixed by stable-backporting --skip options,
> but this is cumbersome and would have to be done every time a new BTF kin=
d
> is introduced.
>

Yes, this is indeed the problem, but I don't think any sort of auto
detection by pahole itself of what is the BTF_KIND_MAX is the best
solution. Sometimes new features are added to existing kinds (like
kflag usage, etc), and that will still break even with "auto
detection".

I think the solution is to design pahole behavior in such a way that
it allows full control for old kernels to specify which BTF features
are expected to be generated, while also allowing to default to all
the latest and greatest BTF features by default for any other
application.

So, how about something like the following. By default, pahole
generates all the BTF features it knows about. But we add a new flag
that says to stay conservative and only generate a specified subset of
BTF features. E.g.:

1) `pahole -J <eLF.o>`  will generate everything

2) `pahole -J <elf.o> --btf_feature=3Dbasic` will generate only the very
basic stuff (we can decide what constitutes basic, we can go all the
way to before we added variables, or can pick any random state after
that)

3) `pahole -J <elf.o> --btf_feature=3Dbasic --btf_feature=3Denum64
--btf_feature=3Dfancy_funcs` will generate only requested bits.

We can have --btf_feature=3Dall as a convenience as well, but kernel
scripts won't use it.

From the very beginning, pahole should not fail with a feature name
that it doesn't recognize, though (maybe emit a warning, don't know).
So that kernel-side scripts can be simpler: when kernel starts to
recognize some new BTF functionality, we just unconditionally add
another `--btf_feature=3D<something>`. And that works starting from the
first pahole version that supports this `--btf_feature` flag.


All this cleverness in trying to guess what kernel supports and what
not (without actually running the kernel and feature-testing) will
just come biting us later on. This never works reliably.


> So this series attempts to detect the BTF kinds supported by the
> kernel/modules so that this can inform BTF encoding for older
> kernels.  We look for BTF_KIND_MAX - either as an enumerated value
> in vmlinux DWARF (patch 1) or as an enumerated value in base vmlinux
> BTF (patch 3).  Knowing this prior to encoding BTF allows us to specify
> skip_encoding options to avoid having BTF with kinds the kernel itself
> will not understand.
>
> The aim is to minimize pain for older stable kernels when new BTF
> kinds are introduced.  Kind encoding [1] can solve the parsing problem
> with BTF, but this approach is intended to ensure generated BTF is
> usable when newer pahole runs on older kernels.
>
> This approach requires BTF kinds to be defined via an enumerated type,
> which happened for 5.16 and later.  Older kernels than this used #defines
> so the approach will only work for 5.16 stable kernels and later currentl=
y.
>
> With this change in hand, adding new BTF kinds becomes a bit simpler,
> at least for the user of pahole.  All that needs to be done is to add
> internal "skip_new_kind" booleans to struct conf_load and set them
> in dwarves__set_btf_kind_max() if the detected maximum kind is less
> than the kind in question - in other words, if the kernel does not know
> about that kind.  In that case, we will not use it in encoding.
>
> The approach was tested on Linux 5.16 as released, i.e. prior to the
> backports adding --skip_encoding logic, and the BTF generated did not
> contain kinds > BTF_KIND_MAX for the kernel (corresponding to
> BTF_KIND_DECL_TAG in that case).
>
> Changes since RFC [2]:
>  - added --skip_autodetect_btf_kind_max to disable kind autodetection
>    (Jiri, patch 2)
>
> [1] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@orac=
le.com/
> [2] https://lore.kernel.org/bpf/20230720201443.224040-1-alan.maguire@orac=
le.com/
>
> Alan Maguire (3):
>   dwarves: auto-detect maximum kind supported by vmlinux
>   pahole: add --skip_autodetect_btf_kind_max to disable kind autodetect
>   btf_encoder: learn BTF_KIND_MAX value from base BTF when generating
>     split BTF
>
>  btf_encoder.c      | 37 +++++++++++++++++++++++++++++++++
>  btf_encoder.h      |  2 ++
>  dwarf_loader.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  dwarves.h          |  3 +++
>  man-pages/pahole.1 |  4 ++++
>  pahole.c           | 10 +++++++++
>  6 files changed, 108 insertions(+)
>
> --
> 2.39.3
>

