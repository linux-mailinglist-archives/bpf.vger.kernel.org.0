Return-Path: <bpf+bounces-74039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDB8C44AC8
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 01:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3552B1889CB8
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 00:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993FE1C8FBA;
	Mon, 10 Nov 2025 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU/lA2at"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576754C81
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735509; cv=none; b=eYKpZJREsrJ8ia4PDzzTe04bafNcmcLyZG3Jm5nXWbRG0jm/N1PDtrPlIrvctRaOT/LioaSP3F8O7u8pxD4Kb/CqZRNs4LDbId/TmlIUk/XcZeezLtO88ecb2t41v4mjnULeXEffYS3BhVjkeXQV3JmwcSdlTJcvmm3bgtIjqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735509; c=relaxed/simple;
	bh=nscrX5q0V9+IiSB6g1Ihy59OGQnsnX1NvjsHMFtBXRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqlbf4dqgAFd1Re+V9+rT1GDOd/tviJHizDQXBqUJ4ILA89rqMSTFSdFGw/5E7XoLKkISw1QTvUsoNpCUi3VLuCuqWJFTJcKgV1GtQQdA05VLR3pvwQ6IfPO2+ETNybsuaAN59aGh8HmPsZp0/3GYkVZSMWHgO2eux7Sfh0sYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU/lA2at; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4edb166b4e3so8033751cf.3
        for <bpf@vger.kernel.org>; Sun, 09 Nov 2025 16:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762735506; x=1763340306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG9+esmtn2iSOL2wvO1i8kRVD0mkler7unxM+L1HKt8=;
        b=cU/lA2at4v+gHU17lWAyMLbL6j8NMDjgmHK8/LM+C+h1M1wVbRjS9q6vU0BG76FTBK
         EK5CU/QKpqMw2irVCZun0SsN+dm9ZeiIR7KWWbyFpwOxEv8YRnl7XaqizZ4NlE7shFjc
         FiborlmFlyoKDqgN45AORdFwRNR0TaA7+RXkqKC6bOI+yFWErv5pBCUl959JQyABF6OB
         DpgYCGxRVHiFpeSjEc0/4eV6dbagbIS27rWn1klXm/On/tnDJT76aF3Vn7+nQ2T3xvwk
         gtiw2YstCL+JwzToJ0i9UK33wKG8NL4Ybu9DaosK0Ow2uzuzjFsDp92WwOfRLusS2G50
         oN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762735506; x=1763340306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG9+esmtn2iSOL2wvO1i8kRVD0mkler7unxM+L1HKt8=;
        b=BJvx9wPCSXbEc7tCaA+bI2PF8vGkIs9q/C9j45EaopkjC1gUbbD1K+h7aybe3UZ1AQ
         lhorEiQbpHiBYZ8RxKzyQ6lpZ/bW85w4GjKrIQwAfNg6W/cFMwzxvhxegyeKEc+krhy1
         7mnhxr5K+LqqXCgmqxb4UaFtiJAFjfd6Al3bowZMCg1p4eFT6I0QOueQyedvQCD8P7pc
         friViD5I/2tvyBdES7sgKSDN8m/J2ZxjXyB35oB/pvkvHw9w9Y0ZZTnjb1rIlwzpdQlv
         mER6n4tEoG3ubkoaXpjAKSifMsa1aBzWPjRBWgrgwKsTHBV2haeya5QPWEOTo8rYnPW4
         9c1w==
X-Gm-Message-State: AOJu0Yyk3IelxWpazjkaNwrFxGwW9n9whi9c5C+6Jrgd02bDQzcXTA2X
	pzXZ9JuY68l3YyDwf3EFLS9vs7BwkjP9SRUneJBmifw+IANGbslZmgxgg7icyltlwIU13ZJNrGQ
	GY08eq4MxgVETJ/5D8ut3D5bKSBXrv7U=
X-Gm-Gg: ASbGncvIw6EoWVgVLAcQfd6Otb2Tt2ylSZYbcGxpxyAM5AMtH0JW7kAHm1hIhG6gvtr
	/6WZ9yd2dupxBvhT+4ijz9AcNEbOj+p5b3WQo5O2FGteN55d0YUyv7b8a/nxkBEfO6R2KX3lek6
	fOK9RJVxsTowIdEczhBC0VAm/QR1K56pRU6sxiwjQhHBBE8243UNUCBRV7iwlycbVUY4XRPitJV
	QcTsqtjNm9cfWNpn4g8q9AFGXw2TlbzkNxAHdHqboAuO5e0EIARE84RkCyRQeoULF9Zlus=
X-Google-Smtp-Source: AGHT+IFbsKvPo4QOdZdH1Hs6UEx2eQFogP6cNT3FFamLxD0jTz/gDjn1rgE9WLWUyJwYh0limZ9DA+vXX+q9LKZty1o=
X-Received: by 2002:a05:622a:353:b0:4ec:efdd:938e with SMTP id
 d75a77b69052e-4eda4e7bbc6mr77601811cf.11.1762735506093; Sun, 09 Nov 2025
 16:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2yuppeOisqT+G6pf9zsP7sTbbbgKWpMe6s5TL6fZ-coWg@mail.gmail.com>
 <893afb17-aac2-47d6-8651-e07ccc37995b@linux.dev>
In-Reply-To: <893afb17-aac2-47d6-8651-e07ccc37995b@linux.dev>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sun, 9 Nov 2025 16:44:54 -0800
X-Gm-Features: AWmQ_bk1E9eooG2UAoLJY5E7fAz0tG_AOuxXuF32u7oh2XVYvkqd328mhNU6F1Y
Message-ID: <CAK3+h2yZ=RS1SM_NvycfiBM_16HEc5apZdKiCv6_75Ts8Ps6=g@mail.gmail.com>
Subject: Re: [BPF selftests]:bpf_arena_common.h: error: conflicting types for 'bpf_arena_alloc_pages'
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, ast <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:50=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 11/9/25 9:09 AM, Vincent Li wrote:
> > Hi,
> >
> > Sorry if this is a known issue,  but I could not find it.  my build env=
ironment:
> >
> > [root@fedora linux-loongson]# pahole --version
> > v1.30
> > [root@fedora linux-loongson]# clang --version
> > clang version 21.1.5
> > Target: loongarch64-redhat-linux
> > Thread model: posix
> > InstalledDir: /usr/bin
> >
> > [root@fedora linux-loongson]# bpftool version
> > bpftool v7.6.0
> > using libbpf v1.6
> > features: llvm, skeletons
> >
> > I got errors below while building bpf selftests with bpf-next branch,
> > I had to comment out the bpf_arena_alloc_pages,
> > bpf_arena_reserve_pages, bpf_arena_free_pages in
> > tools/include/vmlinux.h, then progs/stream.c build succeeded. It looks
> > like these functions in tools/include/vmlinux.h generated by bpftool
> > are not the same as in bpf_arena_common.h. is there something wrong in
> > my build environment?
>
> Could you try pahole master branch? See the conversion in
>    https://lore.kernel.org/bpf/8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@l=
inux.dev/
>

Thanks Yonghong! I just tried the pahole master branch which shows
1.30 version, and pahole next branch which shows 1.31 version, same
problem.

[root@fedora dwarves]# pahole --version
v1.31

[root@fedora build]# cd /usr/src/linux-loongson/tools/testing/selftests/bpf=
/
[root@fedora bpf]# make clean
  CLEAN
  CLEAN   Module.symvers
  CLEAN   eBPF_helpers-manpage
  CLEAN   eBPF_syscall-manpage
[root@fedora bpf]# make -j6

Auto-detecting system features:
...                                    llvm: [ on  ]
...
  INSTALL bpftool
  GEN      vmlinux.h
...
CLNG-BPF [test_progs] strobemeta.bpf.o
In file included from progs/stream.c:8:
/usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:47:1=
5:
error: conflicting types for 'bpf_arena_alloc_pages'
   47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena
*addr, __u32 page_cnt,

> >
> >
> > In file included from progs/stream.c:8:
> > /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:=
47:15:
> > error:
> >        conflicting types for 'bpf_arena_alloc_pages'
> >     47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena
> > *addr, __u32 page_cnt,
> >        |               ^
> > /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlin=
ux.h:180401:14:
> > note:
> >        previous declaration is here
> >   180401 | extern void *bpf_arena_alloc_pages(void *p__map, void
> > *addr__ign, u32 page_cnt, int node_i...
> >          |              ^
> > In file included from progs/stream.c:8:
> > /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:=
49:5:
> > error:
> >        conflicting types for 'bpf_arena_reserve_pages'
> >     49 | int bpf_arena_reserve_pages(void *map, void __arena *addr,
> > __u32 page_cnt) __ksym __weak;
> >        |     ^
> > /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlin=
ux.h:180403:12:
> > note:
> >        previous declaration is here
> >   180403 | extern int bpf_arena_reserve_pages(void *p__map, void
> > *ptr__ign, u32 page_cnt) __weak __ksym;
> >          |            ^
> > In file included from progs/stream.c:8:
> > /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:=
50:6:
> > error:
> >        conflicting types for 'bpf_arena_free_pages'
> >     50 | void bpf_arena_free_pages(void *map, void __arena *ptr, __u32
> > page_cnt) __ksym __weak;
> >        |      ^
> > /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vmlin=
ux.h:180402:13:
> > note:
> >        previous declaration is here
> >   180402 | extern void bpf_arena_free_pages(void *p__map, void
> > *ptr__ign, u32 page_cnt) __weak __ksym;
> >          |             ^
> > 3 errors generated.
> >
> > Vincent
>

