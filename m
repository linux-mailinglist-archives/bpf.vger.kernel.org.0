Return-Path: <bpf+bounces-26222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175489CE54
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 00:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D0B1C224E2
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 22:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8C149DEB;
	Mon,  8 Apr 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b1xNyWHo"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8A14600C
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614380; cv=none; b=HY1vwewLrn1ayIvsYVdMt6+quHfazQbG8skOcvRt1mND9xI180FxsPbK0R5qbk/UCDNjKFK1M+oAQXU9nGeJIYdyaepUuk+ECAAW/uZW9cKaz333pNdwc4T3ws6VWdh0iwZTPygZdicT1C+g13RtS1sRVa/njlMzCWofHzxjHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614380; c=relaxed/simple;
	bh=r8LH63MyqaiZndA+R9wXcNBq11U4EVs+sATq36XLBnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cObXr8mAH2zfkFgKTHUv/ATmFc1PTqGm3TsFUgU5aHduxW+ddsursUXpmB0Jz8cZzzEi0G8IA07S/fWoizq15PkASKeCsTJCQMmfEVQjgR5pabnOrfBE5DN7fI6dSmaH7gRBd5yMb6jjjgn3Z7fg1Sa8QfFz9Dn0n2ltNjIwyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b1xNyWHo; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64666a8e-97fe-49b2-82f1-6469e3411746@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712614374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=reSuF8rvIjBX3uwVzXDJibVe3ZtGBxFw95faajSbTY0=;
	b=b1xNyWHooh7wC+N2p+YHlpjUO/eJv5Ms49Y29/UwHC88QDq9Y7B3xHhsNG7R6aXtrAqw8/
	IANxVUGiXiGm3a14jqrP1mSkmhkvXHV3bj7l05d6eqvXEmfgOKTuJb9vwgdQ3ous6iaP25
	mML6v5CxLUMj3xt7QC8YSK/jzpNsoFM=
Date: Mon, 8 Apr 2024 15:12:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in
 htab_lru_percpu_map_lookup_elem
To: syzbot <syzbot+b8d77b9bb107fa1bd641@syzkaller.appspotmail.com>
References: <0000000000002e2b130615707e3c@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
In-Reply-To: <0000000000002e2b130615707e3c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/6/24 9:59 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    026e680b0a08 Merge tag 'pwm/for-6.9-rc3-fixes' of git://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=173c55e5180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8d77b9bb107fa1bd641
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1495512d180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143c2415180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3b5659d2008c/disk-026e680b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7fd1552fafde/vmlinux-026e680b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ba622b1b0ec4/bzImage-026e680b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b8d77b9bb107fa1bd641@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
> BUG: KMSAN: uninit-value in htab_lru_percpu_map_lookup_elem+0x39a/0x580 kernel/bpf/hashtab.c:2326
>   __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
>   htab_lru_percpu_map_lookup_elem+0x39a/0x580 kernel/bpf/hashtab.c:2326
>   ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
>   bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
>   ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>   __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
>   __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
>   trace_kfree include/trace/events/kmem.h:94 [inline]
>   kfree+0x6a5/0xa30 mm/slub.c:4377
>   kvfree+0x69/0x80 mm/util.c:680
>   __bpf_prog_put_rcu+0x37/0xf0 kernel/bpf/syscall.c:2232
>   rcu_do_batch kernel/rcu/tree.c:2196 [inline]
>   rcu_core+0xa59/0x1e70 kernel/rcu/tree.c:2471
>   rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2488
>   __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
>   invoke_softirq kernel/softirq.c:428 [inline]
>   __irq_exit_rcu kernel/softirq.c:633 [inline]
>   irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>   sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
>   asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
>   __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
>   flush_tlb_mm_range+0x294/0x320 arch/x86/mm/tlb.c:1036
>   flush_tlb_page arch/x86/include/asm/tlbflush.h:254 [inline]
>   ptep_clear_flush+0x166/0x1c0 mm/pgtable-generic.c:101
>   wp_page_copy mm/memory.c:3329 [inline]
>   do_wp_page+0x419d/0x66e0 mm/memory.c:3660
>   handle_pte_fault mm/memory.c:5316 [inline]
>   __handle_mm_fault mm/memory.c:5441 [inline]
>   handle_mm_fault+0x5b76/0xce00 mm/memory.c:5606
>   do_user_addr_fault arch/x86/mm/fault.c:1362 [inline]
>   handle_page_fault arch/x86/mm/fault.c:1505 [inline]
>   exc_page_fault+0x419/0x730 arch/x86/mm/fault.c:1563
>   asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:623
> 
> Local variable stack created at:
>   __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
> 
> CPU: 1 PID: 5015 Comm: syz-executor232 Not tainted 6.9.0-rc2-syzkaller-00002-g026e680b0a08 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> =====================================================

#syz dup: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem


