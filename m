Return-Path: <bpf+bounces-35120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772AF937D90
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 23:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC62282453
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1314883F;
	Fri, 19 Jul 2024 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL/DJ3Pn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA11487F4
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721426076; cv=none; b=FWmz+lyFqcHeFQ2Xq/xQF1CGhl3IT6MtQZh34Gqe4HlN4aGFcA1w7A+XOy3D7kUqUi+pEPc5wePgfexKqE6SGrHrVdHiRzpRZH1H6bI3LpG6WzAJ6tr6JWhQVIa/fjN7UOch6LyMb0XcC3aQQ65TI5PKFRHGvGfXc/xhJWazzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721426076; c=relaxed/simple;
	bh=h2I8moReb93qwT8q78l5L2Mp4Kpr6pBokjOaUEVqYgg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxUCKSPDgyb9WpElF5SRpBfBCq2N2viHsnHz8JVn2N0AYJ6drXJ1RnL/UPuUNamTkO8dKifSCj8kQdPAEmLhPTiP0cy34NPY/NTMD9dx439HnsaY2/dNU67uJi28bOT1S9/HIqo3NxbqMWIw91Q+Lr8AK0lmq4P4Gw2fY+iTcj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL/DJ3Pn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so970030b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721426074; x=1722030874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ARQdc7sH7K/9RvflusjqkqxHZMNifFyrKJFDcvjGxh4=;
        b=jL/DJ3PngIixPR5HqllePby67pxiA2Cvy7fCqlp7SVU6tL6fEBRpteJkJ6g8MzOLI6
         f4sjHofJZjtpW3dwHwpdHGmsFZ5yyBr1wk+cw+JR8JqVNc8eJAhx/RaSneMhZK2JZ9FZ
         ER/CFNXKAu8L72uI01EG4DTqwCXpLCV0e8wPWLuGtVYLnWSmso/UF5CA0VfTmziLNHAu
         QtizWVHfvIofUzZpeI4HHlAfbYVc/R8lg+2fVx+Y0zD7OdaPa08edWoyx3GKJA8QexwM
         zOQCm0NvszuBSdex1tuUfQMrcnzqFZZPTIBZdnt0K4ZZnbNxdRXr2a9+2g9kRV1XZTGv
         odBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721426074; x=1722030874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARQdc7sH7K/9RvflusjqkqxHZMNifFyrKJFDcvjGxh4=;
        b=XWoptU1j6BV99HTAY5zewtfocYztRlQJMi4hFVIX7nYTtzmWjzG2QIaF/sQRHu5zKc
         oxKNN480jzxMUNJldGM2gXAC3oqGUD3tqXKEKi058ukOo3xGT2390siHTrk7XGUhhS3N
         T/PUEUyH0woYn2GKyyPejOTin3V+Hg4zbo1+MZQf2tT7EThdx2wTR0ij2vS3m7w2E0BK
         5dsHQgiI0J1JB3brvWdUrHbUlNAi4c36y8/WZvKF69ZMyEAjxXhifkKT1iU/1qfeAX/v
         vNE/8aFSdzPn+K0J7B7GOrg09LPRJYqg7iEURXb20IDWBlHbOo7kNLK109kzVJjUcLH7
         ki5w==
X-Forwarded-Encrypted: i=1; AJvYcCUohH46TNscFSlXlr4PiVfDTxsMVS2B8Yx5frR3vOifSixeMiLwWqMvacgWvsE36VeTx/P9vweKv4k8jV33Z7N5uhMx
X-Gm-Message-State: AOJu0YwovoK4JFodt2JL+VIJhZB7GN/xEBBmajeNWbKop2nq3A61SlFo
	LhRjlUj4ND/Wj3cqgLLrBwICZfZ/3jzCy6CZz/u2BxpBwv+SHxHF
X-Google-Smtp-Source: AGHT+IGjA3HZeVUo4tDvLCI1t7VfL/gdfmua7h81fnoX7rhJ0eDrI2wGRVvcnhp6LMWig2Q13YxAHw==
X-Received: by 2002:a05:6a21:118e:b0:1bd:2a05:5f24 with SMTP id adf61e73a8af0-1c423bf1d31mr1288289637.27.1721426073718;
        Fri, 19 Jul 2024 14:54:33 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff59e010sm1636359b3a.168.2024.07.19.14.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 14:54:33 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 19 Jul 2024 14:54:31 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for
 test objects
Message-ID: <Zprglznwj5h1/Wps@kodidev-ubuntu>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
 <CAEf4BzYX=sfVGcEYq=KSmnC28cqUsRpN=fCwRuUpOMrYAfzzHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYX=sfVGcEYq=KSmnC28cqUsRpN=fCwRuUpOMrYAfzzHg@mail.gmail.com>

On Fri, Jul 19, 2024 at 11:18:16AM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 18, 2024 at 3:57 PM Ihor Solodrai <ihor.solodrai@pm.me> wrote:
> >
> > Make use of -M compiler options when building .test.o objects to
> > generate .d files and avoid re-building all tests every time.
> >
> > Previously, if a single test bpf program under selftests/bpf/progs/*.c
> > has changed, make would rebuild all the *.bpf.o, *.skel.h and *.test.o
> > objects, which is a lot of unnecessary work.
> >
> > A typical dependency chain is:
> > progs/x.c -> x.bpf.o -> x.skel.h -> x.test.o -> trunner_binary
> >
> > However for many tests it's not a 1:1 mapping by name, and so far
> > %.test.o have been simply dependent on all %.skel.h files, and
> > %.skel.h files on all %.bpf.o objects.
> >
> > Avoid full rebuilds by instructing the compiler (via -MMD) to
> > produce *.d files with real dependencies, and appropriately including
> > them. Exploit make feature that rebuilds included makefiles if they
> > were changed by setting %.test.d as prerequisite for %.test.o files.
> >
> > A couple of examples of compilation time speedup (after the first
> > clean build):
> >
> > $ touch progs/verifier_and.c && time make -j8
> > Before: real    0m16.651s
> > After:  real    0m2.245s
> > $ touch progs/read_vsyscall.c && time make -j8
> > Before: real    0m15.743s
> > After:  real    0m1.575s
> >
> > A drawback of this change is that now there is an overhead due to make
> > processing lots of .d files, which potentially may slow down unrelated
> > targets. However a time to make all from scratch hasn't changed
> > significantly:
> >
> > $ make clean && time make -j8
> > Before: real    1m31.148s
> > After:  real    1m30.309s
> >
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> >
> > ---
> > v3 -> v4: Make $(TRUNNER_BPF_OBJS) order only prereq of trunner binary
> > v2 -> v3: Restore dependency on $(TRUNNER_BPF_OBJS)
> > v1 -> v2: Make %.test.d prerequisite order only
> > ---
> >  tools/testing/selftests/bpf/.gitignore |  1 +
> >  tools/testing/selftests/bpf/Makefile   | 44 +++++++++++++++++++-------
> >  2 files changed, 34 insertions(+), 11 deletions(-)
> >
> 
> It seems to behave correctly, but it reports wrong flavor when
> building .bpf.o, e.g.,:
> 
Hi Andrii,

This is actually an old, confusing bug unrelated to the current (very
nice) improvements. I have a fix as part of a larger series
targeting libc portability and MIPS support which I'll post shortly.  Or
I can send separately if you like?

Thanks,
Tony

> $ touch progs/test_vmlinux.c
> $ make -j90
>   CLNG-BPF [test_maps] test_vmlinux.bpf.o
>   CLNG-BPF [test_maps] test_vmlinux.bpf.o
>   CLNG-BPF [test_maps] test_vmlinux.bpf.o
>   GEN-SKEL [test_progs] test_vmlinux.skel.h
>   GEN-SKEL [test_progs-cpuv4] test_vmlinux.skel.h
>   GEN-SKEL [test_progs-no_alu32] test_vmlinux.skel.h
>   TEST-OBJ [test_progs] vmlinux.test.o
>   TEST-OBJ [test_progs-no_alu32] vmlinux.test.o
>   EXT-COPY [test_progs-no_alu32] urandom_read bpf_testmod.ko
> bpf_test_no_cfi.ko liburandom_read.so xdp_synproxy sign-file
> uprobe_multi ima_setup.sh verify_sig_setup.sh
> btf_dump_test_case_bitfields.c btf_dump_test_case_multidim.c
> btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c
> btf_dump_test_case_packing.c btf_dump_test_case_padding.c
> btf_dump_test_case_syntax.c
>   TEST-OBJ [test_progs-cpuv4] vmlinux.test.o
>   EXT-COPY [test_progs-cpuv4] urandom_read bpf_testmod.ko
> bpf_test_no_cfi.ko liburandom_read.so xdp_synproxy sign-file
> uprobe_multi ima_setup.sh verify_sig_setup.sh
> btf_dump_test_case_bitfields.c btf_dump_test_case_multidim.c
> btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c
> btf_dump_test_case_packing.c btf_dump_test_case_padding.c
> btf_dump_test_case_syntax.c
> make[1]: Nothing to be done for 'docs'.
>   BINARY   test_progs
>   BINARY   test_progs-no_alu32
>   BINARY   test_progs-cpuv4
> $ ls -la test_vmlinux.bpf.o no_alu32/test_vmlinux.bpf.o cpuv4/test_vmlinux.bpf.o
> -rw-r--r-- 1 andriin users 21344 Jul 19 11:08 cpuv4/test_vmlinux.bpf.o
> -rw-r--r-- 1 andriin users 21408 Jul 19 11:08 no_alu32/test_vmlinux.bpf.o
> -rw-r--r-- 1 andriin users 21408 Jul 19 11:08 test_vmlinux.bpf.o
> 
> 
> Note [test_maps] for all three variants (I expected
> test_maps/test_progs + no_alu32 + cpuv4, just like we see for skel.h).
> Can you please double check what's going on? Looking at timestamps it
> seems like they are actually regenerated, though.
> 
> 
> BTW, if you get a chance, see if you can avoid unnecessary EXT-COPY as
> well (probably a bit smarter rule dependency should be set up, e.g.,
> phony target that then depends on actual files or something like
> that).
> 
> Regardless, this is a massive improvement and seems to work correctly,
> so I've applied this and will wait for follow ups. Thanks a lot!
> 
> BTW, are you planning to look into vmlinux.h optimization as well?
> 
> > diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> > index 5025401323af..4e4aae8aa7ec 100644
> > --- a/tools/testing/selftests/bpf/.gitignore
> > +++ b/tools/testing/selftests/bpf/.gitignore
> > @@ -31,6 +31,7 @@ test_tcp_check_syncookie_user
> >  test_sysctl
> >  xdping
> >  test_cpp
> > +*.d
> >  *.subskel.h
> >  *.skel.h
> >  *.lskel.h
> 
> [...]

