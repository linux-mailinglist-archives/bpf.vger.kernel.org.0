Return-Path: <bpf+bounces-33434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A891CE35
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F0E1C210F0
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592985642;
	Sat, 29 Jun 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbmf2JW4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0B22331
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719679765; cv=none; b=UZChVvdNMGbcx2GW7R4+NX2jwVvmZn+EHkU6PhS09xmCl/BGb2B1MCNaD+XAl/wjrN0fc6RDJgOG9PM2QBpVD4u4G2eHym9ASJwln7Ppao6gWC62ONVT54Pr+sF9720RJXNwdQrT6T3KAIywfYkNWFME0xKontxCaUO6173lHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719679765; c=relaxed/simple;
	bh=JcgDvMUp/vrovFba9Dbo8q6XucjA4zPlFhCagAY+RS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEhUCMEMyhYbvwa2RSm0+nL08Y66kAnZHSDrC8DU8590jmub+p3NpJ9rDL8O2VBEgituVboRkcQX4zlWsy8AX/1xK20PgJpR1JFvL5AhfwGjX5K5rEDd5wDqpq03qkzYRI6kH1cdwD9lE3NSZSmgjLyJX7xv8KWDEO4tB9/kt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbmf2JW4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ee4ab4076bso23647291fa.0
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719679762; x=1720284562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XIYJfR/9MDDMU6Dc4FEsJlojpLVuTmfSzQ1oqUvIQ4=;
        b=dbmf2JW47KdzlM8F6p21YHM2oiRe1GNp5pRDNs7HU4FLkA+LbnHz8wsJhnjBNC6pie
         oGfaYAaM5B6VNUuw2MoDFe0La0EnJtvd7+zqW/LXupY99Yj+I8f9SzzPQGfGvFL2gIYl
         u7n6PZvih5vJyWeMLgN3CZoxgCetkYx+14du7aNxEu9vOGW0G+KQNsmP5QrbMFQ5wHJn
         FnIY6uFxCV1PRET/MgomVUYzxKsMlAp8hj1T0J+JXHFZHZ1GIMjCy3Gh3LSfD0f31s98
         2Z4fD0yyazMHC8QoiS2HTCcSxvPBhWy64q4JORglDci8jasAp9j1UX0NGdnV7cMm37nz
         GRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719679762; x=1720284562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XIYJfR/9MDDMU6Dc4FEsJlojpLVuTmfSzQ1oqUvIQ4=;
        b=VbVv0pfvCdNSD3E8FFLK/teOIid/rMSH1hFteh5Raqw8okhAQDIB+eGAm4pd9Bejrs
         emNbes+NvzsrofrcXqeK7PXqC0FBGRRydRIYeIB4Bx58BVsrEKADPLHMOdwQuoP16DAO
         6Q1sGV7uOOdh7rYefMiVABxh1pDyZyE9d1RdCr0yTNqF1BsTs5NkVZ7EuuGcOE08G/JK
         Kn9/4bNNgkYY2RRjbfICIPnVux0+MNYJ67cc2PW8c5MsGNzPEuWt4fBuinNG9A/7o76l
         megeHo9Xl2varZR04CUJQF20OnWzkTZMUJb/oIumVOqXrymUGuyt1YrbdE7GtHkD+w7U
         kDnA==
X-Forwarded-Encrypted: i=1; AJvYcCU0GLbAv3gUT722RhWVDFiMgZBZnjJNC8KJ/a1NWqAjiPmaf+VS3pvRJdBRTaJeVhjLUcX47tmmgaDnvWZ1wu+m1Pfv
X-Gm-Message-State: AOJu0Ywnr4dzUaQ38EXzPd5rrpXjQUmP2aWYlvUD4dwqXt+MKfUFzdYg
	QLAL9ZDbayXV3FpsIWX9k55L7cog0lyhH5nZFWLYVfayD4sB5TEmcr+VHT8CM+R9xx+kvxMYUr+
	dafpzuHbxtouuDb4n8UCBMfjyYRU=
X-Google-Smtp-Source: AGHT+IElKv3878Hk7c7gLZiC4cvsdpfiVkJk19tGFrcdLTDLfcbMuy5OlDgU0bHzIFXTsd8mls8qZJ3xDUVuZ0YHcHc=
X-Received: by 2002:a2e:8387:0:b0:2ee:4b7a:7c1c with SMTP id
 38308e7fff4ca-2ee5e6dcedcmr4490501fa.21.1719679761815; Sat, 29 Jun 2024
 09:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUU71k9kh3GGc8w=F4rdJeBc3LOPH-gNXrjTTUicnufe5g@mail.gmail.com>
In-Reply-To: <CA+icZUU71k9kh3GGc8w=F4rdJeBc3LOPH-gNXrjTTUicnufe5g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sat, 29 Jun 2024 18:48:45 +0200
Message-ID: <CA+icZUXJj10358cBqxGo_zdR-JncbwPmBRAxiow3KRrVyHJjEQ@mail.gmail.com>
Subject: Re: [Linux-v6.9.7] BTF/pahole issue with LLVM/Clang ThinLTO
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <kees@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 10:13=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> Hi,
>
> I wanted to test the impact on build-time with Linux v6.9.7.
>
> The motivation was to build with and without this revert:
>
> $ git revert f1feed67c79e
> ( Revert "kbuild: Remove support for Clang's ThinLTO caching" )
>
> As I read about pahole issues with LLVM/Clang and LTO in the
> ClangBuiltLinux BTS I used pahole/next.git.
>
> $ git log --oneline tags/v1.27..
> 693522ee3a94 (HEAD -> pahole-next-v1.27-7-g693522ee3a94,
> origin/tmp.master, origin/next, next) core: Ignore DW_TAG_inheritance
> with byte_size zero when finding holes
> 43f9515d8211 dwarf_loader: Print the DWARF offset in
> tag__print_unsupported_tag()
> e82a0fdcfb8e dwarf_loader: Simplify tag__print_not_supported()
> f7e3f0942fed pahole: Bail out when not finding debug anywhere
> 94a01bde592c dwarf_loader: Add missing cus__add(cus, cu) to
> cus__merge_and_process_cu()
> 6a2b27c0f512 core: Initialize cu->node with INIT_LIST_HEAD()
> 0ce7745fa46d PKG-MAINTAINERS: Add maintainer for nixpkgs package
>
> DWARF-v5 was enabled.
>
> The slim LLVM toolchain version 18.1.8 from kernel.org was used (Thanks N=
athan).
> Link: https://mirrors.edge.kernel.org/pub/tools/llvm/
>
> This constellation is BROKEN in the modfinal/BTF section:
>
> # BTF [M] drivers/gpu/drm/i915/i915.ko
>   if [ ! -f vmlinux ]; then printf "Skipping BTF generation for %s due
> to unavailability of vmlinux
> " drivers/gpu/drm/i915/i915.ko 1>&2; else LLVM_OBJCOPY=3D"llvm-objcopy"
> /opt/pahole/bin/pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base
> vmlinux drivers/gpu/drm/i915/i915.ko;
> ./tools/bpf/resolve_btfids/resolve_btfids -b vmlinux
> drivers/gpu/drm/i915/i915.ko; fi;
> ld.lld: error: drivers/gpu/drm/nouveau/nouveau.o:(.debug_str): offset
> is outside the section
> make[5]: *** [scripts/Makefile.modfinal:57:
> drivers/gpu/drm/nouveau/nouveau.ko] Error 1
> make[5]: *** Waiting for unfinished jobs....
> ld.lld: error: drivers/gpu/drm/amd/amdgpu/amdgpu.o:(.debug_info+0x7d117f5=
):
> unknown relocation (33554442) against symbol
> make[5]: *** [scripts/Makefile.modfinal:56:
> drivers/gpu/drm/amd/amdgpu/amdgpu.ko] Error 1
> make[4]: *** [Makefile:1852: modules] Error 2
> make[3]: *** [debian/rules:74: build-arch] Error 2
> dpkg-buildpackage: error: make -f debian/rules binary subprocess
> returned exit status 2
> make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
> make[1]: *** [/home/dileks/src/linux/git/Makefile:1541: bindeb-pkg] Error=
 2
> make: *** [Makefile:240: __sub-make] Error 2
>
> Before doing wild experiments I like to see a confirmation of
> reproducing the ERROR.
> Nathan, can you support me?
> My last successful build: Linux-kernel version 6.8.10 using Debian's
> pahole version 1.26.
>
> Attached is my linux-config which is based on Debian's kernel v6.9.7.
>
> Thanks.
>
> Best regards,
> -Sedat-

[ Add some BPF/BTF folks ]

I found upstream commit fcd1ed89a0439c45e1336bd9649485c44b7597c7
("kbuild,bpf: Switch to using --btf_features for pahole v1.26 and later")

Can BPF/BTF folk comment?

Thanks.

Best regards,
-Sedat-

