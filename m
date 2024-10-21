Return-Path: <bpf+bounces-42577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C39A5CF8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 09:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416F3B246DB
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 07:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECC01D1519;
	Mon, 21 Oct 2024 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgpeZWk6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F189193427
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495643; cv=none; b=fW7BDpOTBLRpr+YNdmNlVk1DD1aYy8S5IIOpM8gz+4q5AETE6brIA2AGAF0frQzIPVGy1zmY8zlK3w+TNPdy5V3ne6f4R6sk5Zg+U4LB772YGespNYUjVUniJRzY1xSeHBqEOn1s1vXa+0i9UKLkJeiej6Oz1gYC9Q9JmFYjb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495643; c=relaxed/simple;
	bh=fly8nmxQ9DeClihSicgCyXWomH8ITjoesuKmDnbSBF0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3icSBHZl1B6i8wcmm8Aml3wvDmoexeBKHkWu9l+nZdMmc6zGZUbJCV8zNWbPZTx4uXP/MsFzpRkzRntJsV5BGU7bR1JpHE9YmDg6maQ9l1H2hz9ZyGxnJY168gPkzi82bUZ6HVxNGwGs5ERAanyUp+wyXKfweO7pvXsIiFdkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgpeZWk6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so5041199a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729495639; x=1730100439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYrLtvxeq4FjFCTWRSZiwV/D+2tEOk9uJlaSP4MhI+0=;
        b=VgpeZWk6lnAmTJWIIacIKJ7bCNQ+fdUEjU5q0o6wSPB/kFCR4cz4wMefNhDjaUfk+G
         Ys8SI1Okyb/Oqfl7JDL1RQoV7K8UZ8UB/4qbfu2iMvtcU7I/aD8iH5z9P8OLrlOboKor
         yeBisucWKUzhUvosyDmF8jP0DBGTz2XA+eIUF4M3ppUMYpMvJyiLrZOdM6VO8VVaDYhS
         6URUSzjvvZ0NdCY5n81VPve2cOURS9/B+wCRQan25NKKzOEKt9vSO9cfyDAvqB09SSG2
         BpVmO6Bfqy9TgUA5X8fLUAuasUaNGeIE8y53DZ/XtnopNPUu+1vEI4b8t2rwnhh2HJaK
         NFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495639; x=1730100439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYrLtvxeq4FjFCTWRSZiwV/D+2tEOk9uJlaSP4MhI+0=;
        b=MoQzF3ZJbKUGd02ATb1+4Fmlk2xVsAh6W4i0V8Bnk+GbuykVv6S7Dhnd8tVpI5GPn9
         EgPxj+gDWQllrp/P3QNIxjC3oFywNlR9NuPHLSHHVrtvm6+8gkv1K8FNdseOrR9awmxx
         AejljHiFzt06rHww8VthxXXj7AVolKnUd/qJ83U+yCqk7hIhTNMisNqKDSKN8JgDLnZd
         47FGwdKg1JnfL4nUCV7+aYR5O13tsWb6J3cgFKXZEGkvlomGFFK3GPmwJghiRh1S0aX8
         62RhCbbJ+2IIjjzp4Y5x7bZGdQtmXq/wbEQcYKJp5QC0gKHANmGjGKcX50nOHuyYldTc
         R7uQ==
X-Gm-Message-State: AOJu0YxhBI5GwCkfwivilbEYqrAZ2VARIauEKpA4ud9MgAYRlo7LQehJ
	T9/loolpapWks+kG8wLOCP69ci47q2hR43Ue6IkQG/1OAAJBDCmV
X-Google-Smtp-Source: AGHT+IHRUJa94kt5zhXyYsKdFC6DZ6XU/9zToaz98gwTxsB46Gt6340yqxCoe5bxZQKXFUYsPU7pcg==
X-Received: by 2002:a05:6402:5212:b0:5ca:14e5:b685 with SMTP id 4fb4d7f45d1cf-5ca14e5b70dmr6433631a12.3.1729495638774;
        Mon, 21 Oct 2024 00:27:18 -0700 (PDT)
Received: from krava (85-193-35-184.rib.o2.cz. [85.193.35.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a8d9sm1640522a12.49.2024.10.21.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:27:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 09:27:15 +0200
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpftool: Prevent setting duplicate
 _GNU_SOURCE in Makefile
Message-ID: <ZxYCU-BfEhA1EePA@krava>
References: <cover.1729233447.git.vmalik@redhat.com>
 <820bd20ea460548828ae9a50f5bdbad0700591e5.1729233447.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820bd20ea460548828ae9a50f5bdbad0700591e5.1729233447.git.vmalik@redhat.com>

On Fri, Oct 18, 2024 at 08:49:00AM +0200, Viktor Malik wrote:
> When building selftests with CFLAGS set via env variable, the value of
> CFLAGS is propagated into bpftool Makefile (called from selftests
> Makefile). This makes the compilation fail as _GNU_SOURCE is defined two
> times - once from selftests Makefile (by including lib.mk) and once from
> bpftool Makefile (by calling `llvm-config --cflags`):
> 
>     $ CFLAGS="" make -C tools/testing/selftests/bpf
>     [...]
>     CC      /bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
>     <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
>     <command-line>: note: this is the location of the previous definition
>     cc1: all warnings being treated as errors
>     [...]
> 
> Filter out -D_GNU_SOURCE from the result of `llvm-config --cflags` in
> bpftool Makefile to prevent this error.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/bpf/bpftool/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index ba927379eb20..a4263dfb5e03 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -147,7 +147,11 @@ ifeq ($(feature-llvm),1)
>    # If LLVM is available, use it for JIT disassembly
>    CFLAGS  += -DHAVE_LLVM_SUPPORT
>    LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
> -  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
> +  # llvm-config always adds -D_GNU_SOURCE, however, it may already be in CFLAGS
> +  # (e.g. when bpftool build is called from selftests build as selftests
> +  # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
> +  # compilation error due to redefinition. Let's filter it out here.
> +  CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
>    LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>    ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>      LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
> -- 
> 2.47.0
> 

