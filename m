Return-Path: <bpf+bounces-42594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B439A645D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34807280FB4
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F41E9095;
	Mon, 21 Oct 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFKZXh/9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B81E907F
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507224; cv=none; b=t/VcXCeC0QNhOx2UVIyjF3tywnKvNFyn33QXAssyBNyOS5DH2MrCiWlDa8FBhh3bK/JI5KFOpmvNSRStb00BfbeMUrUJo52hL/icllG+/L1tdHu2yWrAUNdDGd5wOE4kqvpNa2Ja5b2HcUFzNZ4X9FG6tNhrNXDKaxZ40fvGYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507224; c=relaxed/simple;
	bh=XMh2izgvm8GzC0vvqpsmJUxDgFlEGRDjEERvZDHwQko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/zogXH0BUz0HmXem5HdMICwEnE/uavcPwkPYkmpqLY1CEvhG0SgzwCz83CgCLbvfK9tpoGMR7bJ3q6aXAl2nb1aertvLf2GB7C6HPgaMFDmlEbOXqIldvcfhdKwki0H+FK4qgpblwQf19ASsC2fWR21/sbsptEWlMbbCFl9G7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFKZXh/9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a156513a1so596668366b.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507221; x=1730112021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DzH2zQhAMIzxI16fuNVEvOOBoGfV2h8K4U8GDuWQGc=;
        b=iFKZXh/9S64Vy4XnIP+67JISsaeiSPPo2DsvffgtgKT7K7lzyD8gkk41aUxqo4E+dR
         L5YwthC6UlkoD+rEGC6ebPL1uCxO4SrUufjcxs1lVOXq6Om1QGn17x82FfD21O0EL3kx
         thk1q0hXu3Ta9xGN4lboS8lle1pchD/rvk+RfqkPM2QxV/ClRsH1UCmrt1oWtvr9QW4H
         PrtVan/TEnR21h8uZ/wJOqBciecrhXfAbzzPxTFSN2whJXf7hF7qzkVj84mIUvVwq4T+
         mOyAHY0TVIo90a9BD5N7qtvJKekyzPrc5VTcDH1kRipKBh9FjXkoLHBnn3A8jAMyH30I
         sg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507221; x=1730112021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DzH2zQhAMIzxI16fuNVEvOOBoGfV2h8K4U8GDuWQGc=;
        b=mKYmgx3dOHaVV1BPNlww9Bgg15i8piOTS3udPxynzU+2UUTjczol/WzyACvx1xIxHL
         AfYmVNIbcnya4qI0pGqI7cCpszf8mkaJ8C92wyIYRDTbju2b+u4fWjX5doTpGiT+XheD
         KYlckuSvF+M0zj6DZDPOtKIJfK7FZHJ9WIKV3y0E8dWvrJ3pYqx/TExXhP3RF01ZVQmM
         5RBWqObolGbVoqAjYwBRBXdQ/vLjcysuZd6ewdLhzFJkyBhAus4Oa35On8jhdXOiuY6F
         fOS5/qsWjTxI3Ice8iAVZv3Vy7GVn5yofA6+9PNn2JjZRkm0w3cM8K6g2mGtdzZFlBa8
         Tx6A==
X-Forwarded-Encrypted: i=1; AJvYcCVyyntTZNGFiOv5X/tVISm84pwK9uT3p4yyga59v3Sws3m8316gzzUGp6dqFMYwpadhbz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsgAVao1BpV0BLmhXSm6Z4f6C3+15vfebMwnSlDMqCOJ1HIPP
	VshLKANa6/jwd526obBYk9QOKpAF2YQEtS615mFkYxt0PiVD2zh3ztdiiQ==
X-Google-Smtp-Source: AGHT+IFZWl6R3DIHs+Y5cI+YGS9OzGrYk0VyixeiIW+EKEJKm2Czxcw56NV1cHrLCSOXUJMeNgdLyg==
X-Received: by 2002:a17:907:9451:b0:a99:f7df:b20a with SMTP id a640c23a62f3a-a9a69ca04fbmr1243984966b.62.1729507220695;
        Mon, 21 Oct 2024 03:40:20 -0700 (PDT)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157220dsm187549966b.155.2024.10.21.03.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:40:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 12:40:18 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v6 8/9] selftests/bpf: Add tracing prog private
 stack tests
Message-ID: <ZxYvkmP39zbCUGwd@krava>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191431.2108197-1-yonghong.song@linux.dev>
 <ZxV9KUHDcRPC5s9_@krava>
 <2b304d79-80a7-4366-8267-7e3d724f6e86@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b304d79-80a7-4366-8267-7e3d724f6e86@linux.dev>

On Sun, Oct 20, 2024 at 09:32:38PM -0700, Yonghong Song wrote:
> 
> On 10/20/24 2:59 PM, Jiri Olsa wrote:
> > On Sun, Oct 20, 2024 at 12:14:31PM -0700, Yonghong Song wrote:
> > 
> > SNIP
> > 
> > > +__naked __noinline __used
> > > +static unsigned long loop_callback(void)
> > > +{
> > > +	asm volatile (
> > > +	"call %[bpf_get_prandom_u32];"
> > > +	"r1 = 42;"
> > > +	"*(u64 *)(r10 - 512) = r1;"
> > > +	"call cumulative_stack_depth_subprog;"
> > > +	"r0 = 0;"
> > > +	"exit;"
> > > +	:
> > > +	: __imm(bpf_get_prandom_u32)
> > > +	: __clobber_common);
> > > +}
> > > +
> > > +SEC("raw_tp")
> > > +__description("Private stack, callback")
> > > +__success
> > > +__arch_x86_64
> > > +/* for func loop_callback */
> > > +__jited("func #1")
> > > +__jited("	endbr64")
> > this should fail if CONFIG_X86_KERNEL_IBT is not enabled, right?
> > 
> > hm, but I can see that also in other tests, so I guess it's fine,
> > should we add it to config.x86_64 ?
> 
> The CI has CONFIG_X86_KERNEL_IBT as well.
> 
> I checked x86 kconfig, I see
> 
> config CC_HAS_IBT
>         # GCC >= 9 and binutils >= 2.29
>         # Retpoline check to work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93654
>         # Clang/LLVM >= 14
>         # https://github.com/llvm/llvm-project/commit/e0b89df2e0f0130881bf6c39bf31d7f6aac00e0f
>         # https://github.com/llvm/llvm-project/commit/dfcf69770bc522b9e411c66454934a37c1f35332
>         def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=branch -mindirect-branch-register)) || \
>                   (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
>                   $(as-instr,endbr64)
> 
> config X86_KERNEL_IBT
>         prompt "Indirect Branch Tracking"
>         def_bool y
>         depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
>         # https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
>         depends on !LD_IS_LLD || LLD_VERSION >= 140000
>         select OBJTOOL
>         select X86_CET
>         help
>           Build the kernel with support for Indirect Branch Tracking, a
>           hardware support course-grain forward-edge Control Flow Integrity
>           protection. It enforces that all indirect calls must land on
>           an ENDBR instruction, as such, the compiler will instrument the
>           code with them to make this happen.
>           In addition to building the kernel with IBT, seal all functions that
>           are not indirect call targets, avoiding them ever becoming one.
>           This requires LTO like objtool runs and will slow down the build. It
>           does significantly reduce the number of ENDBR instructions in the
>           kernel image.
> 
> So CONFIG_X86_KERNEL_IBT will be enabled if clang >= version_14 or newer gcc.

IIUC it's just dependency, no? doesn't mean it'll get enabled automatically

> In my system, the gcc version is 13.1. So there is no need to explicitly add
> CONFIG_X86_KERNEL_IBT to the selftests/bpf/config.x86_64 file.

I had to enable it manualy for gcc 13.3.1

jirka

