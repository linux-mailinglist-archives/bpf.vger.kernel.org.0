Return-Path: <bpf+bounces-26223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0846689CE55
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 00:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AA6285AA8
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 22:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FB5149C63;
	Mon,  8 Apr 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pvhH6QO7"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7914600C
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614433; cv=none; b=IqZGqi/AgieGZ9GRacK+qXCSBhItl5CEUWIVwbT4FZ1uzBLP7Yxd2cycUPzIN9o/pzOjpJ7JGVFiSOx+vXaKaRy03sxGbnfMP/1fMbeXdVHtnpwYs93FJYaAkRlgoQiNvNl1mLIkbR4l+OfscsZmPJWFDfmcE6gPRxUgRUyzg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614433; c=relaxed/simple;
	bh=fcqzwNIHpsBhQ4rwOpHZEBXcBXlLIFXPo0FPbnJFNUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Yh1ARRxe8yaXf2CwKkegsHPhe4i3pJr5mW0BOWETwKZwqbHlY2CHWYceN5UlZDaNWOJPdOjPh4zHjiwP5bjKKHM72yD3yGWDXbOOxwr+Kn8PIZ67OlSMzpGFDBdqrqxSFWw0dMkgeKqQ3yApvQE5M/gQroxBiU2X4H7jBrzRNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pvhH6QO7; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <81c43248-5483-4dfd-a5e3-4c3d1bf5f3e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712614429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Igfnypc8vPl2kE0aSVWH2QxHO69qJpqzE7R1RALBSg=;
	b=pvhH6QO79tCXqfB5d6wg+2Dn0kplxeqKIfWIImvzbDPlazgPLgurC77SbxTj4JrQqubPpN
	eSJAvJ5KtcF5WG1YZHJtWSF/Cqb2+s4SkJXWux+abkqSrrPEnLYowCyxMn+ajOTeIYx3pu
	wJS9kl7PfdWXmNVzPzrG8q/S1cBMoIY=
Date: Mon, 8 Apr 2024 15:13:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_map_delete_elem
To: syzbot <syzbot+d40ad71c1ba64324d256@syzkaller.appspotmail.com>
References: <0000000000006c85760615734276@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
In-Reply-To: <0000000000006c85760615734276@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/6/24 1:17 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    026e680b0a08 Merge tag 'pwm/for-6.9-rc3-fixes' of git://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b1fee3180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
> dashboard link: https://syzkaller.appspot.com/bug?extid=d40ad71c1ba64324d256
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b539b1180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e55795180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3b5659d2008c/disk-026e680b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7fd1552fafde/vmlinux-026e680b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ba622b1b0ec4/bzImage-026e680b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d40ad71c1ba64324d256@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in htab_lock_bucket kernel/bpf/hashtab.c:160 [inline]
> BUG: KMSAN: uninit-value in htab_lru_map_delete_elem+0x628/0xb20 kernel/bpf/hashtab.c:1459
>   htab_lock_bucket kernel/bpf/hashtab.c:160 [inline]
>   htab_lru_map_delete_elem+0x628/0xb20 kernel/bpf/hashtab.c:1459
>   ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
>   bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
>   ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>   __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
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
>   smap_restore arch/x86/include/asm/smap.h:56 [inline]
>   get_shadow_origin_ptr mm/kmsan/instrumentation.c:37 [inline]
>   __msan_metadata_ptr_for_load_8+0x2c/0x40 mm/kmsan/instrumentation.c:92
>   last_frame arch/x86/kernel/unwind_frame.c:82 [inline]
>   is_last_frame arch/x86/kernel/unwind_frame.c:87 [inline]
>   is_last_task_frame+0x62/0x420 arch/x86/kernel/unwind_frame.c:156
>   unwind_next_frame+0x9d/0x470 arch/x86/kernel/unwind_frame.c:276
>   arch_stack_walk+0x1ec/0x2d0 arch/x86/kernel/stacktrace.c:25
>   stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
>   kmsan_save_stack_with_flags mm/kmsan/core.c:74 [inline]
>   kmsan_internal_chain_origin+0x57/0xd0 mm/kmsan/core.c:183
>   __msan_chain_origin+0xc3/0x150 mm/kmsan/instrumentation.c:251
>   __skb_dst_copy include/net/dst.h:282 [inline]
>   skb_dst_copy include/net/dst.h:290 [inline]
>   __copy_skb_header+0x362/0x850 net/core/skbuff.c:1528
>   __skb_clone+0x57/0x650 net/core/skbuff.c:1579
>   skb_clone+0x3aa/0x550 net/core/skbuff.c:2070
>   __tcp_transmit_skb+0x438/0x4890 net/ipv4/tcp_output.c:1308
>   tcp_transmit_skb net/ipv4/tcp_output.c:1480 [inline]
>   tcp_write_xmit+0x3ee1/0x8900 net/ipv4/tcp_output.c:2792
>   __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:2977
>   tcp_push+0x755/0x7a0 net/ipv4/tcp.c:738
>   tcp_sendmsg_locked+0x6079/0x6cb0 net/ipv4/tcp.c:1310
>   tcp_sendmsg+0x49/0x90 net/ipv4/tcp.c:1342
>   inet_sendmsg+0x142/0x280 net/ipv4/af_inet.c:851
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x267/0x380 net/socket.c:745
>   sock_write_iter+0x368/0x3d0 net/socket.c:1160
>   call_write_iter include/linux/fs.h:2108 [inline]
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0xb63/0x1520 fs/read_write.c:590
>   ksys_write+0x20f/0x4c0 fs/read_write.c:643
>   __do_sys_write fs/read_write.c:655 [inline]
>   __se_sys_write fs/read_write.c:652 [inline]
>   __x64_sys_write+0x93/0xe0 fs/read_write.c:652
>   do_syscall_64+0xd5/0x1f0
>   entry_SYSCALL_64_after_hwframe+0x72/0x7a
> 
> Local variable stack created at:
>   __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
> 
> CPU: 1 PID: 5008 Comm: sshd Not tainted 6.9.0-rc2-syzkaller-00002-g026e680b0a08 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> =====================================================

#syz dup: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem


