Return-Path: <bpf+bounces-74699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B84C628BC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 07:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AA3AE221
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 06:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C583164BE;
	Mon, 17 Nov 2025 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gf5NFbf1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB4315789
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763361507; cv=none; b=OkuLCkSQW0VXnTQ3ENH0pRRycrfDMiR5LJjuq/tn1QDQ3V2t3onjde7pVoAdiAr6R+OkJGBYGGiv9sH2WX+S3QV6LrxglXcTTB0vkIP3w9YZmj2rYBH7+K9hgVU0CmXrlZfOtCv17/bw4sLqlAx5YRjf8bXm5lt4VZXH2qpa0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763361507; c=relaxed/simple;
	bh=A3rPgwriz9b4YMnOHBRbVV8RhIKuGfNGKqAw/aSnWR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d26F+1EzyIHJnKU7FlsdkfgTSAQMI6t3BfbD7/nGRNRXKn9swmH7Cnvnwvi9JwbI3GrjNvjW9yYrB9pCcgoq1CpKP6dh3Wrv3AyJVnFPRP8ReFYAR0cJQAQw0c+7I6WsQ8hSpKh3BotctIriVuqIly2/raAjjgJra2DXPQCDmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gf5NFbf1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5957e017378so4466155e87.3
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 22:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763361502; x=1763966302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKPR8K5JHXfnzVilFNApKLVvNZlS9+8kqXfsjfMNXqI=;
        b=gf5NFbf1JXmj3AGYkhkTLg/oETWuiJ81BRLbW9KHkG4aPxxhP09VYdkFChl5ISNsvW
         B1cRpQaFmpw31ymrVP55jw00Dm0KgFGGPLBjKfxcwfQKdGw5aOdW1E9yK+1ZJfs42gfF
         pbr3OaePXjI/o7NmANcZad9rrsNLIv50WjcGeOXFHvVnH9mLyunPsjcBuMfL31IfLX/8
         9XF0tWe/m7n4hoPamVdKEbO5iDMK+0X2ADJc+oCrfBdvRMqs1LZ9+xGdlGwonBORFD12
         +7VRMj5EQvFIoTWUo4+BuHAublOfKXlrxAt0xdmQLo7rLSQBLdEUBUJyNKIMiXQ6wbG3
         fxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763361502; x=1763966302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKPR8K5JHXfnzVilFNApKLVvNZlS9+8kqXfsjfMNXqI=;
        b=WOLVLZChLjrrDNEJe+D3cNzq1x6+f8JaPuZ9uOr4JNXb7LcUjbfWVJyQUn5srLF2vg
         6+E7BIDxvPxKnGnP+/CqIawHdWkAqRUaX9yp39wvYTlENhhmdvwx5Y2XOUGH5mK+t1a8
         faJEIogWSvipEW9oxXi07uVctmFzPj15jhe2hiKj+UOaxwrGnYFdV4XAyMmuvMtfOYNw
         pFlGVP1B8uJIK1aOWIyWC2eE6ZgVzwY5Uahe+/16L1aOX85wpgYwPLbdU70wMRI6tsGF
         XtGkh74y00f0/Oe7zwLparRWLmv35/pb53VOat231/v7kHREYlHo/IJ76qShq1ifYw++
         z4Mw==
X-Gm-Message-State: AOJu0YxoEasPAw4KWkhn6FPUX2zRGg/ZCUmJeFHREpZwSWQzsb1Eee4n
	zzCP3xe1c/Tibo/1ZU1pouQdlKc7xTz250sh/dur5C6nGKh2tEtrj7cxIasIxPDTzs9bG4YWuUT
	BO5nLezKXHwPZCVNVYVAC33Im2N24DhX2XkjbAkrYkA==
X-Gm-Gg: ASbGncsnzOVnnqsHzEYQswBB8RNutjcKZtFKf/4W5656+csPudFy+l1BBQHcuZfVAo/
	FhS5GdT1cnPA7yukfygnbvKl3R0oZge5ptUaBUCUv9RPAX1CNNYrHfHw1xsT2Z8VkbdYKeDKSYd
	vy9SWJEhvljpOpUJp6wvCgK0X5BPxi9IzVgzFz//7AhHCCcHAujoTG8s8IajloDxCts3300aziy
	DT3jw3tHejW4bJWIF/R3LH0fEdxtaC8josgee4CT9lmI5T9kf2LIPksBrIRviMtIt3QM1WZ2I1x
	EH5nBKPoAd/GH4koCn4=
X-Google-Smtp-Source: AGHT+IF2nuhg87qiUvcOswURQNG1UrXLxNTg9RKGJWjZh7RuDRmzJpvcQFqpdeQyNJOrQ9CjFviUwVaU1c282AQ/H5Y=
X-Received: by 2002:a05:6512:3a8f:b0:595:83f5:c33e with SMTP id
 2adb3069b0e04-59584198566mr3695392e87.11.1763361502263; Sun, 16 Nov 2025
 22:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115225550.1086693-1-hoyeon.lee@suse.com> <20251115225550.1086693-6-hoyeon.lee@suse.com>
 <fa987c2b-b806-4aa7-a318-812fc7d0f414@linux.dev>
In-Reply-To: <fa987c2b-b806-4aa7-a318-812fc7d0f414@linux.dev>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Mon, 17 Nov 2025 15:37:50 +0900
X-Gm-Features: AWmQ_bnRlBGsS_F9znam2aLrWmZfBD5qK6FdCrSiGBUG8wo4GZBjDq9kjSkoE4U
Message-ID: <CAK7-dKYDqV97K+hbw651zbu3-UZ1WSOf2a07uqWWtiRSfJV_zQ@mail.gmail.com>
Subject: Re: [bpf-next v1 5/5] selftests/bpf: propagate LLVM toolchain to
 runqslower build
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 3:04=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 11/15/25 2:55 PM, Hoyeon Lee wrote:
> > The selftests/bpf invokes a nested make when building runqslower, but
> > LLVM toolchain version (clang/llvm-strip) is not propagated. As a
> > result, runqslower is built with system default clang, not respecting
> > specified LLVM version.
> >
> >      # LLVM=3D-21 make -C tools/testing/selftests/bpf
> >      ...
> >      make feature_display=3D0 -C /bpf/tools/bpf/runqslower             =
           \
> >          OUTPUT=3D/bpf/tools/testing/selftests/bpf/tools/build/runqslow=
er/        \
> >          BPFOBJ_OUTPUT=3D/bpf/tools/testing/selftests/bpf/tools/build/l=
ibbpf/     \
> >          BPFOBJ=3D/bpf/tools/testing/selftests/bpf/tools/build/libbpf/l=
ibbpf.a    \
> >          BPF_INCLUDE=3D/bpf/tools/testing/selftests/bpf/tools/include  =
           \
> >          BPFTOOL_OUTPUT=3D/bpf/tools/testing/selftests/bpf/tools/build/=
bpftool/   \
> >          VMLINUX_BTF=3D/sys/kernel/btf/vmlinux BPF_TARGET_ENDIAN=3D--ta=
rget=3Dbpfel   \
> >          EXTRA_CFLAGS=3D'-g -O0  ' EXTRA_LDFLAGS=3D' ' &&              =
             \
> >          cp  /bpf/tools/testing/selftests/bpf/tools/build/runqslower/ru=
nqslower \
> >              /bpf/tools/testing/selftests/bpf/runqslower
> >      clang -g -O2 --target=3Dbpfel -I/bpf/tools/testing/selftests/bpf/t=
ools/build/runqslower/ \
> >            -I/bpf/tools/testing/selftests/bpf/tools/include -I/bpf/tool=
s/include/uapi       \
> >            -c runqslower.bpf.c -o /bpf/tools/testing/selftests/bpf/tool=
s/build/runqslower/runqslower.bpf.o && \
> >            llvm-strip -g /bpf/tools/testing/selftests/bpf/tools/build/r=
unqslower//runqslower.bpf.o
> >      /bin/sh: 1: clang: not found
>
> I tried with LLVM=3D-20 make -C tools/testing/selftests/bpf in my system =
and
> there is no build error.
>
> Also could you try with command line
>     make -C tools/testing/selftests/bpf LLVM=3D1
> for clang build kernel or selftests, LLVM=3D1 is recommended as it
> encodes a bunch of clang command lines:
>    CC              =3D $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
>    LD              =3D $(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX)
>    AR              =3D $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)
>    NM              =3D $(LLVM_PREFIX)llvm-nm$(LLVM_SUFFIX)
>    OBJCOPY         =3D $(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX)
>    OBJDUMP         =3D $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
>    READELF         =3D $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
>    STRIP           =3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
>
>
Thanks for the review.

Just to clarify, the issue is not the build failure itself. The error
"clang: not found" only appeared because I intentionally did not set
update-alternatives to avoid falling back to the system default compiler.

The real issue is that the runqslower sub-make invokes "clang" instead
of "clang-21" when LLVM=3D-21 is specified. This shows that the selected
LLVM toolchain version is not being propagated into the nested build.

LLVM=3D1 works well for general builds, but in this case the intention is
to verify that a specific LLVM version is consistently applied across
all sub-makes. That propagation does not currently happen, and the patch
addresses exactly that.

Thanks again for taking a look.
>
>
> >
> > Explicitly propagate CLANG and LLVM_STRIP to the runqslower sub-make so
> > that the LLVM toolchain selection from lib.mk is preserved.
> >
> > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > ---
> >   tools/testing/selftests/bpf/Makefile | 1 +
> >   tools/testing/selftests/lib.mk       | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 34ea23c63bd5..79ab69920dca 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -306,6 +306,7 @@ endif
> >
> >   $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUT=
PUT)
> >       $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower      =
      \
> > +                 CLANG=3D$(CLANG) LLVM_STRIP=3D$(LLVM_STRIP)          =
          \
> >                   OUTPUT=3D$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=3D$(VMLINUX=
_BTF)     \
> >                   BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/          =
        \
> >                   BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf/                 =
        \
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/l=
ib.mk
> > index a448fae57831..f14255b2afbd 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -8,6 +8,7 @@ LLVM_SUFFIX :=3D $(LLVM)
> >   endif
> >
> >   CLANG :=3D $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
> > +LLVM_STRIP :=3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> >
> >   CLANG_TARGET_FLAGS_arm          :=3D arm-linux-gnueabi
> >   CLANG_TARGET_FLAGS_arm64        :=3D aarch64-linux-gnu
>

