Return-Path: <bpf+bounces-36349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E59946FBD
	for <lists+bpf@lfdr.de>; Sun,  4 Aug 2024 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF666B20E8A
	for <lists+bpf@lfdr.de>; Sun,  4 Aug 2024 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A93762EB;
	Sun,  4 Aug 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zp7VHTj2"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4ED6A01E
	for <bpf@vger.kernel.org>; Sun,  4 Aug 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787185; cv=none; b=UmRHW0H+AzbXvMN9FcoTbf/tj+kZaCAVpGtOxljO2zLgP1tANynkp9nQJbrJYv6nl+eqibHHuQHU/Yk5tuUK7wh02mhf2892IE4uwqG6mDtq0503yD5dYGHDKIInzoa1n8iOkV2sYDfbNw8tt5O6F3cwseGkTDXTVo84tKiPPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787185; c=relaxed/simple;
	bh=uVia8GbI0Vpbzxs0+lD0oBkhhvDYd27NfmkT1S59GYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qFE/I9IG4MmP+FfEh/8byjIpaCrv3Bcly514JilkUdZ36zFQSDtZcSfemNuSIcjtsBn3CGT071i132j6MgMK3tIIXxbEUCqMSDiJJ6i7BLmCFvoBjXAFWeXlMJVEp/VAIkjF/u7OvIz60ZMNC3k/dpGeU0ppofWyShnO40rYFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zp7VHTj2; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 4 Aug 2024 09:59:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722787181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ba+lFtW9JfDP3Y5enOAh51A50Wpsd8NZ8ru+f89g6Pc=;
	b=Zp7VHTj21lePoLeTrqHTxW5zt+m66uIKvtY/VmxXUOpknogmFUnfGbQzfjNC4ItLkzIyVu
	ms0SVbSzm+WvA/mtr7L+2ehNImigUQV5GbrocMc07eGK+onosT9pRzwHsFJBFxbyLdktfE
	fH51N4vcUFoEGSN0M+VOTjjBhgxx5zg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jose Fernandez <jose.fernandez@linux.dev>
To: bpf@vger.kernel.org
Cc: yonghong.song@linux.dev
Subject: BPF arena atomic example not working
Message-ID: <c5i2ggshxbl66rm7jiy2fbqg2s5roiqjq6fv5u3pswlxodz2xw@cn47hrarvapn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi folks,

I have not found BPF arena documentation, beyond the patches and selftests.
I'm using the arena_atomics selftest as reference to create a simple BPF program
that increments a value atomically.

bpf: https://github.com/jfernandez/bpf-playground/blob/main/arena.bpf.c
userspace: https://github.com/jfernandez/bpf-playground/blob/main/arena.c
common header: https://github.com/jfernandez/bpf-playground/blob/main/bpf_arena_common.h

I'm using the 6.10.2 kernel and libbpf 1.4.3.

The program does not load when I use the `__arena_global` macro. If fails with:

libbpf: map 'arena': at sec_idx 7, offset 0.
libbpf: map 'arena': found type = 33.
libbpf: map 'arena': found max_entries = 10.
libbpf: map 'arena': found map_flags = 0x400.
libbpf: map 'arena': found map_extra = 0x100000000000.
libbpf: sec '.relraw_tp/sys_enter': collecting relocation for section(3) 'raw_tp/sys_enter'
libbpf: sec '.relraw_tp/sys_enter': relo #0: insn #1 against 'add64_value'
libbpf: sec '.relraw_tp/sys_enter': relo #1: insn #4 against 'add64_result'
libbpf: object 'arena': failed (-95) to create BPF token from '/sys/fs/bpf', skipping optional step...
libbpf: map 'arena': created successfully, fd=3
libbpf: prog 'add': BPF program load failed: Permission denied
libbpf: prog 'add': -- BEGIN PROG LOAD LOG --
arg#0 reference type('UNKNOWN ') size cannot be determined: -22
0: R1=ctx() R10=fp0
; int add(const void *ctx) @ arena.bpf.c:17
0: (b7) r1 = 2                        ; R1_w=2
; add64_result = __sync_fetch_and_add(&add64_value, 2); @ arena.bpf.c:19
1: (18) r2 = 0x100000000000           ; R2_w=scalar()
3: (db) r1 = atomic64_fetch_add((u64 *)(r2 +0), r1)
misaligned access off (0x0; 0xffffffffffffffff)+0+0 size 8
processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'add': failed to load: -13
libbpf: failed to load object 'arena'
libbpf: failed to load BPF skeleton 'arena': -13
Failed to open BPF skeleton

I found Yonghong Song's patch that appears to address a similar issue. But I'm
using a return value and not getting the `lock` instruction:
https://lore.kernel.org/bpf/20240803025928.4184433-1-yonghong.song@linux.dev/

I have compared with code with the selftest and I can't spot any signifcant
differences that may cause this issue. I would appreciate any help or guidance.

Thanks,
Jose

