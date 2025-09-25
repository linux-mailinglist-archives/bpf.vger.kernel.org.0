Return-Path: <bpf+bounces-69764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B193BBA0F94
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6887AEB45
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773B3128D7;
	Thu, 25 Sep 2025 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlAUVMow"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335453B2A0
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823695; cv=none; b=PUidLUDainWk40UwiAeKZncpTx97L7yhg7x6yOa2A1K6HEH5Ke2Z56Pc9Fv/bik5B4DQ8THZysyR6CZLBUrhq5RB+i81DDrG9OyTZyw3QwJv8qVJ6lLDpRWgmoX8UqqSzDoEqvvJQRqya4aYElocX5ZVBumj5ONK+BioYeOwGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823695; c=relaxed/simple;
	bh=pC3OqEkMNULWSdZKrg5g2TUu6Cf+gxHxzNoP4AMCyWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjOvgxy4Vb3QNxKmgoupDFLmKWflrPRCpUnzNFYAqWqwpa6UmTMdfLU0/YWhO/8b5iD7eLmugmmqCtsfTQ4ikAFDZvFDN4JvT82p40UxGDntNnCDydE5V9FmOpk6eCSVXpIOQsiz72kD0GlFrnVDHgDXGrKFRY5RArTDqZr5Em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlAUVMow; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2e363118so12886985e9.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758823692; x=1759428492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl0d2USndmPuwfUMorsqM+pj4ZYIOWY49U+4BqE1Tmw=;
        b=HlAUVMowLtCF8/3g5qyLY46mzSWaL3/YEEnYzA0nB8S4PGI2yjYcL/WtMSi1+SKWbk
         yDK5P+xo5WGFuEAUIqPi6OVz+8H2UJgPInXZK/nNtTBA2Keta2zPU+sgclIlNAFD6tmI
         dpnPBFbZlZGK8w5RKjtsQB3I4ULcis0YXiSbIUHLIDpOfZ3nuzsjfQMFnmd7s33dcNxJ
         GfVSET32+wVVaDpBwEJZmwouORPDbdQdcgxX2XUQTbd+8RY0M6QBTVD3KbjiuQPVsKkm
         pKPpJfWEBiVtE4QhKkJN6snbFMyFum9dfDobpLVrcU4kk2a8HPAfRQSmztwkM7MU77W0
         JsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823692; x=1759428492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl0d2USndmPuwfUMorsqM+pj4ZYIOWY49U+4BqE1Tmw=;
        b=CYwQWoriSl7MFAxmhchA09vohu7W/39abB25MYZh3K3nUGgzBRzF0P5/vV2cZ53Giv
         DBPvWgUB8vCjsn2+/GJPvws07NOkFsC6lDzjH9/vpr65FJDXwW9SyL2wVMz+JS2WwSzk
         UG3RYl1SXj+LisSUmR+mi2CuzuA7lkUq3LaPlenYxZ+AE8Yb5vJm+SXNhMOfibFKlpKH
         q5jthmFoc9tq+exyYpSdBFFU7fciID3MzY2s4r/8rL4DxyM83AurPUToEb+XvPH8BbpL
         97qYV19ZjdKzrbjxowyAzsFfXE31/LPvzNvzgeUxDKcFFb9iZpR06fYcn23pBKt3Z25o
         sKlQ==
X-Gm-Message-State: AOJu0Yx6r9PiD9rV0JoPFt4v+HwvwM1FCJWTLeD0QA1TDx7hBW/VmYJj
	0+nZElAabc85JCxdofSfX+hItW7Z4MMPjNArYpLJ2uJfPi59IvPoY101Ly+g4g==
X-Gm-Gg: ASbGncvsO8uSRjJ/++2rCRGzxUigJD3MVA/cVtNG2LwOGvavv1ECQsDQiWF86D8xM5i
	iVNWJiqjAeOQecqsj6avZowbr0yv1RULSXryUwDANpNBx0vH3frFWvLLFMYcDJ7tjgVb/zOR9rP
	1WregHynmLoS6gBeoMnWJ5yNaowaLhgVdX3Ft1qmKV/NULdhzldelWLX1E3Doy5WnwuL4OKmHNM
	wG5hITN5FZd3BBf+nX2tv+9Qf4bAXtB1qIWERPZ1Dd+Inlyjgl3slnDqbgtMee5BFvHtEOxK6+L
	s/Un99x/WIg32zp+LtNgW3SYynVbNAwJSTXseu1om2h9xORHnHoij1Gfyso+TBwcb8eF2GLVfH5
	XJSJ+aCyjSlTC+WU+5y3aArIHq/a4+PS0
X-Google-Smtp-Source: AGHT+IGyovc+O0SoO0ZvJGtzJsUr7gWEbGZuqb0UIN5nsxY+FSIK6CjHyDmqhTWRoXojErD1hY2o4A==
X-Received: by 2002:a5d:5d07:0:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-40e44a5479fmr3499952f8f.4.1758823692308;
        Thu, 25 Sep 2025 11:08:12 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab48c28sm85373685e9.18.2025.09.25.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:08:11 -0700 (PDT)
Date: Thu, 25 Sep 2025 18:14:05 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 13/13] selftests/bpf: add selftests for
 indirect jumps
Message-ID: <aNWGbdMKci1gu2iU@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-14-a.s.protopopov@gmail.com>
 <71cc9b1aaae03dc948f2543b44efab2ed6c1b74f.camel@gmail.com>
 <8f529733004eed937b92cc7afab25a6f288b29aa.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f529733004eed937b92cc7afab25a6f288b29aa.camel@gmail.com>

On 25/09/20 03:27PM, Eduard Zingerman wrote:
> On Fri, 2025-09-19 at 17:58 -0700, Eduard Zingerman wrote:
> > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > > Add selftests for indirect jumps. All the indirect jumps are
> > > generated from C switch statements, so, if compiled by a compiler
> > > which doesn't support indirect jumps, then should pass as well.
> > >
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> >
> > Patch #8 adds a lot of error conditions that are effectively untested
> > at the moment. I think we need to figure out a way to express gotox
> > tests in inline assembly, independent of clang version, and add a
> > bunch of correctness tests.
> >
> > [...]
> 
> Here is an example (I modifier verifier_and.c, the patch should use
> some verifier_gotox.c, of course):
> 
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
>   #include "bpf_misc.h"
>   #include "../../../include/linux/filter.h"
> 
>   SEC("socket")
>   __success
>   __retval(1)
>   __naked void jump_table1(void)
>   {
>   	asm volatile (
>   ".pushsection .jumptables,\"\",@progbits;\n"
>   "jt0_%=:\n"
>   	".quad ret0_%=;\n"
>   	".quad ret1_%=;\n"
>   ".size jt0_%=, 16;\n"
>   ".global jt0_%=;\n"
>   ".popsection;\n"
> 
>   	"r0 = jt0_%= ll;\n"
>   	"r0 += 8;\n"
>   	"r0 = *(u64 *)(r0 + 0);\n"
>   	".8byte %[gotox_r0];\n"
>   "ret0_%=:\n"
>   	"r0 = 0;\n"
>   	"exit;\n"
>   "ret1_%=:\n"
>   	"r0 = 1;\n"
>   	"exit;\n"
>   	:
>   	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
>   	: __clobber_all);
>   }
> 
>   char _license[] SEC("license") = "GPL";
> 
> It verifies and executes (having fix for emit_indirect_jump() applied):
> 
>   VERIFIER LOG:
>   =============
>   func#0 @0
>   Live regs before insn:
>         0: .......... (18) r0 = 0xffff888108c66700
>         2: 0......... (07) r0 += 8
>         3: 0......... (79) r0 = *(u64 *)(r0 +0)
>         4: .......... (0d) gotox r0
>         5: .......... (b7) r0 = 0
>         6: 0......... (95) exit
>         7: .......... (b7) r0 = 1
>         8: 0......... (95) exit
>   Global function jump_table1() doesn't return scalar. Only those are supported.
>   0: R1=ctx() R10=fp0
>   ; asm volatile ( @ verifier_and.c:122
>   0: (18) r0 = 0xffff888108c66700       ; R0_w=map_value(map=jt,ks=4,vs=8)
>   2: (07) r0 += 8                       ; R0_w=map_value(map=jt,ks=4,vs=8,off=8)
>   3: (79) r0 = *(u64 *)(r0 +0)          ; R0_w=insn(off=8)
>   4: (0d) gotox r0
>   7: (b7) r0 = 1                        ; R0_w=1
>   8: (95) exit
>   processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>   =============
>   do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>   #488/1   verifier_and/jump_table1:OK
>   #488     verifier_and:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> This example can be mutated in various ways to check behaviour and
> error conditions.
> 
> Having such complete set of such tests, I'd only keep a few canary
> C-level tests.

Thanks a lot, I can use it for sure!

As for C-level tests, I want to keep a bunch of them in any
case to test libbpf operations.

(I also remember your request to extend compute_live_registers,
just didn't have time to get to it yet.)

