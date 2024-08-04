Return-Path: <bpf+bounces-36351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8F94705A
	for <lists+bpf@lfdr.de>; Sun,  4 Aug 2024 21:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA841C20777
	for <lists+bpf@lfdr.de>; Sun,  4 Aug 2024 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909F12D214;
	Sun,  4 Aug 2024 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VmRJvzNc"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8B4405
	for <bpf@vger.kernel.org>; Sun,  4 Aug 2024 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722799770; cv=none; b=BvvNTY/AZSa4N6Os304OJ/+vZpLwJdoMlwjLaG1O0alUJQ6bF/NPeyW4Dm4C+Uw1oFmpbvYrULtCW5hE5BMx9v3VA9TG1GGZdNixvgAYyteu3LGOUQwGnaHg7WvzydU1KL87FmTlVABJ5xBxmDIaTtpKHScSr6VSE1u4rT/A5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722799770; c=relaxed/simple;
	bh=H3AkRS+9g7VIQ3tOVnDnqf7Vu8oTxLoocvECGsNelLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npYifw2RcUr05wEPb3qb1P3cPU9DTVGr1ggtBwgwiB+7r8YQ3yaknSFEw5IhMMBTKZiIWjCNirlLrcOXfHJ2klAab5+y+YH/83kPtV8rbuav4bCbNaR+d0wqlxoD2RVmGBlKHJohyeRpYWam8OUrQCA1xgcLdk3fd6tjysu9x+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VmRJvzNc; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 4 Aug 2024 13:29:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722799763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ErT83E6Eo5pZ43mwvOfImXHmlZrnpfVYSsOrRbVxvkE=;
	b=VmRJvzNcniWOoCiaAh3pobCSZpltypVrskdTjobkg9gCRZcIDPGMfpg9IW6sTbA+0MCKBe
	WcA+UF2/2jutmiyc12bN9X7Xdl4pNC8lNV1qDXIDgykmQEt11IDvVnaUru7XRmQid7EtcK
	gRFvJlRNuKI6UiQFtGZc0bn7l34YkiQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jose Fernandez <jose.fernandez@linux.dev>
To: bpf@vger.kernel.org
Cc: yonghong.song@linux.dev
Subject: Re: BPF arena atomic example not working
Message-ID: <fleinfsx2ciqepk3323kgsdquovvlauhrmnxitzkqomhcuibnx@n6sqe2q5lhmr>
References: <c5i2ggshxbl66rm7jiy2fbqg2s5roiqjq6fv5u3pswlxodz2xw@cn47hrarvapn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5i2ggshxbl66rm7jiy2fbqg2s5roiqjq6fv5u3pswlxodz2xw@cn47hrarvapn>
X-Migadu-Flow: FLOW_OUT

On 24/08/04 09:59AM, Jose Fernandez wrote:
> Hi folks,
> 
> I have not found BPF arena documentation, beyond the patches and selftests.
> I'm using the arena_atomics selftest as reference to create a simple BPF program
> that increments a value atomically.
> 
> bpf: https://github.com/jfernandez/bpf-playground/blob/main/arena.bpf.c
> userspace: https://github.com/jfernandez/bpf-playground/blob/main/arena.c
> common header: https://github.com/jfernandez/bpf-playground/blob/main/bpf_arena_common.h
> 
> I'm using the 6.10.2 kernel and libbpf 1.4.3.
> 
> The program does not load when I use the `__arena_global` macro. If fails with:
> 
> libbpf: map 'arena': at sec_idx 7, offset 0.
> libbpf: map 'arena': found type = 33.
> libbpf: map 'arena': found max_entries = 10.
> libbpf: map 'arena': found map_flags = 0x400.
> libbpf: map 'arena': found map_extra = 0x100000000000.
> libbpf: sec '.relraw_tp/sys_enter': collecting relocation for section(3) 'raw_tp/sys_enter'
> libbpf: sec '.relraw_tp/sys_enter': relo #0: insn #1 against 'add64_value'
> libbpf: sec '.relraw_tp/sys_enter': relo #1: insn #4 against 'add64_result'
> libbpf: object 'arena': failed (-95) to create BPF token from '/sys/fs/bpf', skipping optional step...
> libbpf: map 'arena': created successfully, fd=3
> libbpf: prog 'add': BPF program load failed: Permission denied
> libbpf: prog 'add': -- BEGIN PROG LOAD LOG --
> arg#0 reference type('UNKNOWN ') size cannot be determined: -22
> 0: R1=ctx() R10=fp0
> ; int add(const void *ctx) @ arena.bpf.c:17
> 0: (b7) r1 = 2                        ; R1_w=2
> ; add64_result = __sync_fetch_and_add(&add64_value, 2); @ arena.bpf.c:19
> 1: (18) r2 = 0x100000000000           ; R2_w=scalar()
> 3: (db) r1 = atomic64_fetch_add((u64 *)(r2 +0), r1)
> misaligned access off (0x0; 0xffffffffffffffff)+0+0 size 8
> processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'add': failed to load: -13
> libbpf: failed to load object 'arena'
> libbpf: failed to load BPF skeleton 'arena': -13
> Failed to open BPF skeleton
> 
> I found Yonghong Song's patch that appears to address a similar issue. But I'm
> using a return value and not getting the `lock` instruction:
> https://lore.kernel.org/bpf/20240803025928.4184433-1-yonghong.song@linux.dev/

I compiled clang from the master branch, recompiled, and now the program loads.

I used the latest clang (18.1.8) previously, which doesn't set 
__BPF_FEATURE_ADDR_SPACE_CAST, and the fallback macros were used:

#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
#define __arena __attribute__((address_space(1)))
#define __arena_global __attribute__((address_space(1)))
#define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
#define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
#else
#define __arena
#define __arena_global SEC(".addr_space.1")
#define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
#define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
#endif

> I have compared with code with the selftest and I can't spot any signifcant
> differences that may cause this issue. I would appreciate any help or guidance.

I'm unblocked now. After looking more closely at the selftest, it appears
like they require llvm >= 19. I assumed the latest 18 release supported 
had that flag.

> 
> Thanks,
> Jose

