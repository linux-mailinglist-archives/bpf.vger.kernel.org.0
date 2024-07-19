Return-Path: <bpf+bounces-35106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3388F937C58
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5639A1C21E36
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6BF146A73;
	Fri, 19 Jul 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+dCrpD5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D443687
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413111; cv=none; b=qadA/V5GRlMU9c0QSuhB6q4bP/ghapHHVC4xyoi3kNkveI5dLBOsc6WSqw57IMyiuCJS+f2p6YBF64sHGLoWygBmiJwX/5YXX89MAyQXljyAfePI7AhqsL79PeY5k3aJZku/sI6AB8RYpMWsAF7TA+F4XW55AdOc+PGW5IJ3pxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413111; c=relaxed/simple;
	bh=i8+PFcyb97Oab+U2JNxVbQHC/T546znzvjBq6J/WERk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmJaDivK24EUJFepsYmSYzOqHKcAY/0ht7ELIIkDQpaQFsJYOdFy9W3VQaph1hdnzNwrK8U5GbTw0axA6ZuPmjj92xqcS/CN03LZIUdd5X9ag+WY5UPl7yS9Lkb83aX1cHfMg8VMk9vD1CGhnR0W9BOvZoBLQXfxS0DlP5CXN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+dCrpD5; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-26106ec9336so668349fac.2
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721413109; x=1722017909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti+iPCVKgSemcLGWmIYVX2skgHneDGh78DYdEJvAKoY=;
        b=c+dCrpD5ZD+Q2Was6aYt5oxPgQyKY9YX2+mgwzeZIOR31sFwtqJ59W+ASZUkf4e51h
         lxO9ZBvEge33KAbyFtTYID27032lAeZrP8XXZkSjjn4fRYeuunhGgFQPxbArdmMm3rVg
         eTrTMIXL2oE8ZFLNTieN3TFufallUC9/72tobyeDMCLWDcxou9YiUT1f5kXeK0JYbOT0
         /lA4xP0jY+OX1gqg8NpAA8iZ3Kw7wHH/co09/NZ3PwG17yjZOPfhoyvW2sVzbD2ti4PK
         OvjB5j17FUaiI3os38RQZLHpktRSPzeS37r5GECg/3mimw41AbIXU5ipu0C+FQz38H25
         GdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721413109; x=1722017909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti+iPCVKgSemcLGWmIYVX2skgHneDGh78DYdEJvAKoY=;
        b=l0EiKTkGOB2lq8hAQFK6gD3KDLDefKxBVFU3T7N7rX/cdTyB6V8MdxaS7dGH/y2WsH
         VghLs7wZSgL4UPc2aOLM/AwwW2W3W+tC18jotLqAdKj4g8gKI14HNw65fmDjV9o0TVbJ
         fL0KOvq5rgH34OipM3aCKoO+vsQ15LVzqyq4oajmuoAhbwkanCo29WLzGXb3UPFlyHsy
         xrTfCC7Gnsse4/Q0Vs93XVIHQhpBa1C5blsE/w+ZO3X5OL0iY3WdV5jS8hfCQZqQV52e
         adVJ8GEDJ/KanQMMSk/MS2h0I3YMyt6kUTcQOE/ROJsre9frWaN4HDnV2njdXa+9Vajv
         b2Tg==
X-Gm-Message-State: AOJu0YwPTZCtrO38xeJCrg8OMqJAYxYweH17s/NJhDyWnPygvKUvJae5
	Tygdq98A5hlqbIrzWsKzM/XUPGROvWiNk73YsJ87QN9jfrfQWadQhsZrCOIUK7V6LkhQVheUwy4
	C8UIsEUBq2F9UxaTOufntOlCF2zoZYpZF
X-Google-Smtp-Source: AGHT+IHetHXkjC+ZUOxFQKDl3yECvgllxDuVyDJJjdLXo1HBmGDVkjkpbanAobL/Q2ICFxcRYiT2sjyoi6DpPO0ZPdY=
X-Received: by 2002:a05:6870:a78e:b0:25e:bded:3607 with SMTP id
 586e51a60fabf-260d905d7fdmr6889866fac.14.1721413108863; Fri, 19 Jul 2024
 11:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
In-Reply-To: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 11:18:16 -0700
Message-ID: <CAEf4BzYX=sfVGcEYq=KSmnC28cqUsRpN=fCwRuUpOMrYAfzzHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 3:57=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> Make use of -M compiler options when building .test.o objects to
> generate .d files and avoid re-building all tests every time.
>
> Previously, if a single test bpf program under selftests/bpf/progs/*.c
> has changed, make would rebuild all the *.bpf.o, *.skel.h and *.test.o
> objects, which is a lot of unnecessary work.
>
> A typical dependency chain is:
> progs/x.c -> x.bpf.o -> x.skel.h -> x.test.o -> trunner_binary
>
> However for many tests it's not a 1:1 mapping by name, and so far
> %.test.o have been simply dependent on all %.skel.h files, and
> %.skel.h files on all %.bpf.o objects.
>
> Avoid full rebuilds by instructing the compiler (via -MMD) to
> produce *.d files with real dependencies, and appropriately including
> them. Exploit make feature that rebuilds included makefiles if they
> were changed by setting %.test.d as prerequisite for %.test.o files.
>
> A couple of examples of compilation time speedup (after the first
> clean build):
>
> $ touch progs/verifier_and.c && time make -j8
> Before: real    0m16.651s
> After:  real    0m2.245s
> $ touch progs/read_vsyscall.c && time make -j8
> Before: real    0m15.743s
> After:  real    0m1.575s
>
> A drawback of this change is that now there is an overhead due to make
> processing lots of .d files, which potentially may slow down unrelated
> targets. However a time to make all from scratch hasn't changed
> significantly:
>
> $ make clean && time make -j8
> Before: real    1m31.148s
> After:  real    1m30.309s
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>
> ---
> v3 -> v4: Make $(TRUNNER_BPF_OBJS) order only prereq of trunner binary
> v2 -> v3: Restore dependency on $(TRUNNER_BPF_OBJS)
> v1 -> v2: Make %.test.d prerequisite order only
> ---
>  tools/testing/selftests/bpf/.gitignore |  1 +
>  tools/testing/selftests/bpf/Makefile   | 44 +++++++++++++++++++-------
>  2 files changed, 34 insertions(+), 11 deletions(-)
>

It seems to behave correctly, but it reports wrong flavor when
building .bpf.o, e.g.,:

$ touch progs/test_vmlinux.c
$ make -j90
  CLNG-BPF [test_maps] test_vmlinux.bpf.o
  CLNG-BPF [test_maps] test_vmlinux.bpf.o
  CLNG-BPF [test_maps] test_vmlinux.bpf.o
  GEN-SKEL [test_progs] test_vmlinux.skel.h
  GEN-SKEL [test_progs-cpuv4] test_vmlinux.skel.h
  GEN-SKEL [test_progs-no_alu32] test_vmlinux.skel.h
  TEST-OBJ [test_progs] vmlinux.test.o
  TEST-OBJ [test_progs-no_alu32] vmlinux.test.o
  EXT-COPY [test_progs-no_alu32] urandom_read bpf_testmod.ko
bpf_test_no_cfi.ko liburandom_read.so xdp_synproxy sign-file
uprobe_multi ima_setup.sh verify_sig_setup.sh
btf_dump_test_case_bitfields.c btf_dump_test_case_multidim.c
btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c
btf_dump_test_case_packing.c btf_dump_test_case_padding.c
btf_dump_test_case_syntax.c
  TEST-OBJ [test_progs-cpuv4] vmlinux.test.o
  EXT-COPY [test_progs-cpuv4] urandom_read bpf_testmod.ko
bpf_test_no_cfi.ko liburandom_read.so xdp_synproxy sign-file
uprobe_multi ima_setup.sh verify_sig_setup.sh
btf_dump_test_case_bitfields.c btf_dump_test_case_multidim.c
btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c
btf_dump_test_case_packing.c btf_dump_test_case_padding.c
btf_dump_test_case_syntax.c
make[1]: Nothing to be done for 'docs'.
  BINARY   test_progs
  BINARY   test_progs-no_alu32
  BINARY   test_progs-cpuv4
$ ls -la test_vmlinux.bpf.o no_alu32/test_vmlinux.bpf.o cpuv4/test_vmlinux.=
bpf.o
-rw-r--r-- 1 andriin users 21344 Jul 19 11:08 cpuv4/test_vmlinux.bpf.o
-rw-r--r-- 1 andriin users 21408 Jul 19 11:08 no_alu32/test_vmlinux.bpf.o
-rw-r--r-- 1 andriin users 21408 Jul 19 11:08 test_vmlinux.bpf.o


Note [test_maps] for all three variants (I expected
test_maps/test_progs + no_alu32 + cpuv4, just like we see for skel.h).
Can you please double check what's going on? Looking at timestamps it
seems like they are actually regenerated, though.


BTW, if you get a chance, see if you can avoid unnecessary EXT-COPY as
well (probably a bit smarter rule dependency should be set up, e.g.,
phony target that then depends on actual files or something like
that).

Regardless, this is a massive improvement and seems to work correctly,
so I've applied this and will wait for follow ups. Thanks a lot!

BTW, are you planning to look into vmlinux.h optimization as well?

> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index 5025401323af..4e4aae8aa7ec 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -31,6 +31,7 @@ test_tcp_check_syncookie_user
>  test_sysctl
>  xdping
>  test_cpp
> +*.d
>  *.subskel.h
>  *.skel.h
>  *.lskel.h

[...]

