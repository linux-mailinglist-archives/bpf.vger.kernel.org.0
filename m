Return-Path: <bpf+bounces-39714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B889768B2
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 14:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F271F28346
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC901A2635;
	Thu, 12 Sep 2024 12:06:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB9288BD;
	Thu, 12 Sep 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142805; cv=none; b=tkhhy0jRdx6fOVGdeFfdn+2b4DfXQjtiy7BL1Ki+5c2XN3yq4ks7RZDV559SrA2s7RZKvJU7rkvkrdtBvVYf40mrGdla1yLj1/wygP2xCs5smRC6IJ/AWQlknTvHfpiLs6VWmG3kq6CtdOyHHVfCWXkRbFKcKolmzMOMnghrsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142805; c=relaxed/simple;
	bh=wfRhT8zfb2EJ0bC5KDG1x6YoG07uRPBRGRJPN7kOFcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9+PKwOaMp24MQuS7WILVRGf4/jzzJSCQPvIPdk8/p5Fl/RHHxGR6ygzRxbrDoxGeXiXg/TSIPLoKqrld+57SNBonYYr1nSdgMRoHkGZ2YdB0McmrBNjas/DYHZ5PfLCagv/NFM1qOvOahzZ8XIQ8go7zh2HJotK7ByaeffYA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f760f7e25bso9853641fa.2;
        Thu, 12 Sep 2024 05:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726142801; x=1726747601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh7/VzYrFR4xEzChF75YXPTOWk0K7klrepkrXvFDAv8=;
        b=azj3DHkd0MpkCLE2LaiWFZsGoiLgvKlrnxO0i+IV/aYv56wCZ9sAr2uiEzPSWmuEmN
         mlgAntlb/1QU8RrRzlmGxs7YiKGIpFRxUKCaN4+/iQNVHsy0PfCdRKjqZyykMEZmSQXK
         uK0uvXS5OMgj+PhfS2qxNlxG5QcrqBloVAYj+KeLcnM/my90TsRpceUhMGwzoiea6v8d
         wXXeDL0ENITzKdcuPKr/i0Qt0o87SDIitb5YvLV4GUEg0xZBtaByUBhU0ql10+ze0TaZ
         Z3kU5vi3tFXLIklzo1IHOPnNlQzVQbDM0qBpofa+fm0iR+mlOaQ4hcpbXqlzQTGO02yt
         gPiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsO2THzeqgaiCI6Iz+Fhq75t6ImbIzVvIG72D8yfeMMOljfwVJNBQd1nWIjY8DoW+xQeGURcA9@vger.kernel.org, AJvYcCW9bEVK20/cxo+g7MoVyOPYSB1h924Ok8SgIGsoYZHIx71KBtvsa/DcHWBCWoIkc2AttQBu34COYwZmuLvX@vger.kernel.org, AJvYcCWNkb5ChseGI4fdEOtCb+6yYe2TZ9QXGLv7xxBOiebeIQILq6F+eZgbU+ef0rWf7xKpuhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDK7Fh1trliBoxhK+vPzDsNm1NKuevYhaylGEVo9OdVHHVO7HC
	oKw5iks+mQKdB7qvKb1e519qMaC5U83X3nOEoLs4+6FicF6NcX7N
X-Google-Smtp-Source: AGHT+IFHxtjwIeu1UeE0SGrrb3l4Tq0XDURpuvXrwPBpkWNzC1MA0QwEUQX7Gc8nDZP/woPrOkir3w==
X-Received: by 2002:a2e:a9a6:0:b0:2f7:7f76:992b with SMTP id 38308e7fff4ca-2f787f4484dmr12662321fa.37.1726142800261;
        Thu, 12 Sep 2024 05:06:40 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cc33sm6521419a12.87.2024.09.12.05.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:06:39 -0700 (PDT)
Date: Thu, 12 Sep 2024 05:06:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
	bigeasy@linutronix.de
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703120143.43cc1770@kernel.org>

Hello Sebastian, Jakub,

On Wed, Jul 03, 2024 at 12:01:43PM -0700, Jakub Kicinski wrote:
> On Wed, 3 Jul 2024 14:27:58 +0200 Sebastian Andrzej Siewior wrote:
> > During the introduction of struct bpf_net_context handling for
> > XDP-redirect, the tun driver has been missed.
> > 
> > Set the bpf_net_context before invoking BPF XDP program within the TUN
> > driver.
> 
> Sorry if I'm missing the point but I think this is insufficient.
> You've covered the NAPI-like entry point to the Rx stack in your
> initial work, but there's also netif_receive_skb() which drivers 
> may call outside of NAPI, simply disabling BH before the call.

I've seen some crashes in 6.11-rc7 that seems related to 401cb7dae8130
("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.").

Basically bpf_net_context is NULL, and it is being dereferenced by
bpf_net_ctx->ri.kern_flags (offset 0x38) in the following code.

	static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
	{
		struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
		if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {

That said, it means that bpf_net_ctx_get() is returning NULL.

This stack is coming from the bpf function bpf_redirect()
	BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
	{
	      struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();


Since I don't think there is XDP involved, I wondering if we need some
preotection before calling bpf_redirect()


There is the full stack, against bc83b4d1f0869 ("Merge tag
'bcachefs-2024-09-09' of git://evilpiepirate.org/bcachefs")

	[  138.278753] BUG: kernel NULL pointer dereference, address: 0000000000000038
	[  138.292684] #PF: supervisor read access in kernel mode
	[  138.302954] #PF: error_code(0x0000) - not-present page
	[  138.313224] PGD 8fc4e6067 P4D 8fc4e6067 PUD 8fc4e5067 PMD 0
	[  138.324539] Oops: Oops: 0000 [#1] SMP
	[  138.357085] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
	[  138.368574] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
	[  138.385971] RIP: 0010:bpf_redirect (./include/linux/filter.h:788 net/core/filter.c:2531 net/core/filter.c:2529)
	[ 138.394509] Code: e9 79 ff ff ff 0f 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 65 48 8b 04 25 00 2f 03 00 48 8b 80 20 0c 00 00 <8b> 48 38 f6 c1 02 75 2c c7 40 20 00 00 00 00 48 c7 40 18 00 00 00
	All code
	========
	   0:	e9 79 ff ff ff       	jmp    0xffffffffffffff7e
	   5:	0f 0b                	ud2
	   7:	cc                   	int3
	   8:	cc                   	int3
	   9:	cc                   	int3
	   a:	cc                   	int3
	   b:	cc                   	int3
	   c:	cc                   	int3
	   d:	cc                   	int3
	   e:	cc                   	int3
	   f:	cc                   	int3
	  10:	cc                   	int3
	  11:	cc                   	int3
	  12:	cc                   	int3
	  13:	cc                   	int3
	  14:	cc                   	int3
	  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
	  1a:	65 48 8b 04 25 00 2f 	mov    %gs:0x32f00,%rax
	  21:	03 00
	  23:	48 8b 80 20 0c 00 00 	mov    0xc20(%rax),%rax
	  2a:*	8b 48 38             	mov    0x38(%rax),%ecx		<-- trapping instruction
	  2d:	f6 c1 02             	test   $0x2,%cl
	  30:	75 2c                	jne    0x5e
	  32:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
	  39:	48                   	rex.W
	  3a:	c7                   	.byte 0xc7
	  3b:	40 18 00             	rex sbb %al,(%rax)
		...
	Code starting with the faulting instruction
	===========================================
	   0:	8b 48 38             	mov    0x38(%rax),%ecx
	   3:	f6 c1 02             	test   $0x2,%cl
	   6:	75 2c                	jne    0x34
	   8:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
	   f:	48                   	rex.W
	  10:	c7                   	.byte 0xc7
	  11:	40 18 00             	rex sbb %al,(%rax)
		...
	[  138.432073] RSP: 0018:ffffc9000f0e33d8 EFLAGS: 00010246
	[  138.442523] RAX: 0000000000000000 RBX: ffff888288d4dae0 RCX: ffff888290f6dde2
	[  138.456801] RDX: 00000000000000a8 RSI: 0000000000000000 RDI: 0000000000000002
	[  138.471080] RBP: ffffc9000f0e3450 R08: 0000000000000000 R09: 0000000000000000
	[  138.485354] R10: 0000000000000000 R11: 0000000000000005 R12: ffff88829776aa68
	[  138.499624] R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000002
	[  138.513894] FS:  00007f0a67000640(0000) GS:ffff88903f880000(0000) knlGS:0000000000000000
	[  138.530076] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[  138.541562] CR2: 0000000000000038 CR3: 00000008fc4e8005 CR4: 00000000007706f0
	[  138.555830] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	[  138.570097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	[  138.584364] PKRU: 55555554
	[  138.589769] Call Trace:
	[  138.594656]  <TASK>
	[  138.598850] ? __die_body (arch/x86/kernel/dumpstack.c:421)
	[  138.605826] ? page_fault_oops (arch/x86/mm/fault.c:711)
	[  138.614017] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
	[  138.621859] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
	[  138.630227] ? bpf_redirect (./include/linux/filter.h:788 net/core/filter.c:2531 net/core/filter.c:2529)
	[  138.637547] bpf_prog_61d4b6831e57702d_tw_ns_nk2phy+0x31c/0x327
	[  138.649385] ? bpf_selem_link_map (./kernel/bpf/bpf_local_storage.c:402)
	[  138.657748] netkit_xmit (./include/linux/bpf.h:1243 ./include/linux/filter.h:691 ./include/linux/filter.h:698 drivers/net/netkit.c:46 drivers/net/netkit.c:86)
	[  138.664898] dev_hard_start_xmit (./include/linux/netdevice.h:4913 ./include/linux/netdevice.h:4922 net/core/dev.c:3580 net/core/dev.c:3596)
	[  138.673263] __dev_queue_xmit (net/core/dev.h:168 net/core/dev.c:4424)
	[  138.681279] ? __dev_queue_xmit (./include/linux/bottom_half.h:? ./include/linux/rcupdate.h:890 net/core/dev.c:4348)
	[  138.689470] ip6_finish_output2 (./include/net/neighbour.h:? net/ipv6/ip6_output.c:141)
	[  138.697833] ip6_finish_output (net/ipv6/ip6_output.c:? net/ipv6/ip6_output.c:226)
	[  138.706021] ip6_output (./include/linux/netfilter.h:303 net/ipv6/ip6_output.c:247)
	[  138.712643] ? __rmqueue_pcplist (mm/page_alloc.c:2976)
	[  138.721350] ip6_xmit (net/ipv6/ip6_output.c:380)
	[  138.727976] ? refill_obj_stock.llvm.9389014391162377460 (mm/memcontrol.c:2912)
	[  138.740509] ? security_sk_classify_flow (security/security.c:?)
	[  138.750088] ? __sk_dst_check (net/core/sock.c:599)
	[  138.757756] inet6_csk_xmit (net/ipv6/inet6_connection_sock.c:135)
	[  138.765080] __tcp_transmit_skb (net/ipv4/tcp_output.c:1466)
	[  138.773445] ? _copy_from_iter (./arch/x86/include/asm/uaccess_64.h:110 ./arch/x86/include/asm/uaccess_64.h:118 ./arch/x86/include/asm/uaccess_64.h:125 lib/iov_iter.c:55 ./include/linux/iov_iter.h:51 ./include/linux/iov_iter.h:247 ./include/linux/iov_iter.h:271 lib/iov_iter.c:249 lib/iov_iter.c:260)
	[  138.781460] tcp_connect (net/ipv4/tcp_output.c:4032 net/ipv4/tcp_output.c:4142)
	[  138.788605] ? bpf_trampoline_6442578911+0x59/0xa3
	[  138.798183] tcp_v6_connect (net/ipv6/tcp_ipv6.c:333)
	[  138.805854] __inet_stream_connect (net/ipv4/af_inet.c:680)
	[  138.814565] ? __kmalloc_cache_noprof (./arch/x86/include/asm/jump_label.h:55 ./include/linux/memcontrol.h:1694 mm/slub.c:2158 mm/slub.c:4002 mm/slub.c:4041 mm/slub.c:4188)
	[  138.823795] tcp_sendmsg_fastopen (net/ipv4/tcp.c:1035)
	[  138.832507] tcp_sendmsg_locked (net/ipv4/tcp.c:1087)
	[  138.840870] ? lock_sock_nested (net/core/sock.c:3551)
	[  138.848883] ? __bpf_prog_exit_recur (./kernel/bpf/trampoline.c:909)
	[  138.857765] tcp_sendmsg (net/ipv4/tcp.c:1354)
	[  138.864562] ____sys_sendmsg.llvm.5426677171080474013 (net/socket.c:733 net/socket.c:745 net/socket.c:2597)
	[  138.876749] ? __import_iovec (./include/linux/err.h:61 lib/iov_iter.c:1282)
	[  138.884590] ___sys_sendmsg (net/socket.c:2651)
	[  138.892084] ? do_pte_missing (mm/memory.c:5019 mm/memory.c:5052 mm/memory.c:5191 mm/memory.c:3947)
	[  138.900274] ? __perf_sw_event (kernel/events/internal.h:228 kernel/events/core.c:10002 kernel/events/core.c:10027)
	[  138.908115] ? handle_mm_fault (mm/memory.c:? mm/memory.c:5858)
	[  138.916477] __x64_sys_sendmsg (net/socket.c:2680 net/socket.c:2689 net/socket.c:2687 net/socket.c:2687)
	[  138.924317] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
	[  138.931638] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
	[  138.939477] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
	[  138.949575] RIP: 0033:0x7f0b1e1293eb
	[ 138.956732] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 99 a6 f6 ff 41 89 c0 8b 55 ec 48 8b 75 f0 8b 7d f8 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 45 f8 e8 d1 a6 f6 ff 48 8b
	All code
	========
	   0:	48 89 e5             	mov    %rsp,%rbp
	   3:	48 83 ec 20          	sub    $0x20,%rsp
	   7:	89 55 ec             	mov    %edx,-0x14(%rbp)
	   a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
	   e:	89 7d f8             	mov    %edi,-0x8(%rbp)
	  11:	e8 99 a6 f6 ff       	call   0xfffffffffff6a6af
	  16:	41 89 c0             	mov    %eax,%r8d
	  19:	8b 55 ec             	mov    -0x14(%rbp),%edx
	  1c:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
	  20:	8b 7d f8             	mov    -0x8(%rbp),%edi
	  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
	  28:	0f 05                	syscall
	  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
	  30:	77 35                	ja     0x67
	  32:	44 89 c7             	mov    %r8d,%edi
	  35:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	  39:	e8 d1 a6 f6 ff       	call   0xfffffffffff6a70f
	  3e:	48                   	rex.W
	  3f:	8b                   	.byte 0x8b
	Code starting with the faulting instruction
	===========================================
	   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
	   6:	77 35                	ja     0x3d
	   8:	44 89 c7             	mov    %r8d,%edi
	   b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	   f:	e8 d1 a6 f6 ff       	call   0xfffffffffff6a6e5
	  14:	48                   	rex.W
	  15:	8b                   	.byte 0x8b
	[  138.994291] RSP: 002b:00007f0a66ffc220 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
	[  139.009429] RAX: ffffffffffffffda RBX: 00007f0a66ffc548 RCX: 00007f0b1e1293eb
	[  139.023697] RDX: 0000000020004040 RSI: 00007f0a66ffc370 RDI: 0000000000000172
	[  139.037965] RBP: 00007f0a66ffc240 R08: 0000000000000000 R09: 00007f0a66411228
	[  139.052234] R10: 00007f0a66ffc678 R11: 0000000000000293 R12: 00007f0a66ffc4c0
	[  139.066504] R13: 000000000000001c R14: 00007f0a66443000 R15: 0000000000000021
	[  139.080776]  </TASK>
	[  139.085138] Modules linked in: sunrpc(E) bpf_preload(E) sch_fq(E) squashfs(E) tls(E) tcp_diag(E) inet_diag(E) act_gact(E) cls_bpf(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) iTCO_wdt(E) iTCO_vendor_support(E) evdev(E) xhci_pci(E) i2c_i801(E) kvm(E) acpi_cpufreq(E) i2c_smbus(E) xhci_hcd(E) wmi(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)

