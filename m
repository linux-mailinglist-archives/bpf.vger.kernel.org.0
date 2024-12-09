Return-Path: <bpf+bounces-46424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A459EA181
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 22:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A65E282D74
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A119D891;
	Mon,  9 Dec 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jSHBlCEN"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695B19D092
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781391; cv=none; b=ULYGClXmWY+TUldIfsviMiX+hAS5gTSpJXYIUJbQOJSbkp19FJMje5hDa0aulOTPwqsCxLoNiM+UJypeIQujSVbNHr2onnm+YAvvxCxCIfwIwXacE6T6lFw1/3pHB2S057BXcUQpHLnXxO6TVWKvUTnz8FvGjxXeXMoGyAIDDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781391; c=relaxed/simple;
	bh=rLikFwWBaSJVkAJl7elSg6TEqIpcLFI+lP4vN60vbY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=GngxCvr9oBnCEEaQopjcmlfeEex8jVWm/ofysKPLoxLdaLTWoEMiH8KcdVpE89WMWumFjUDGUMjEqXzlxIEDUbeBxRxewJ7PqE1nA3vsz/5gBJY1+bqx+lp80zaHFGdI2Obq3ZY5Tlj31IkG130jLp+RhfIclU7POhw8bfnqcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jSHBlCEN; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09b0c78a-09be-474d-b080-bdd5e7c76e40@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733781386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOMJNfwreH26POHoZy5xtvsHbwUvB7HFQGPmn4XFhZI=;
	b=jSHBlCENcCjlMvV4QEHL7fQNkI18KFeKgHb5YtptsmiyeYpaVaqLT9E2O3+o5Gj0caMwLl
	d7grm7+qCqqqJVKH8Ji6raz+jUveO4CTsD9uG0IGjIjvcOrJo5T+Q8ccBZ1Su6mNWJu/Up
	EZesVWjK28vBGG2kfkZvEcGJziqQFUk=
Date: Mon, 9 Dec 2024 13:56:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: unregistering tcp_ca struct_ops can cause kernel page fault
To: rtm@csail.mit.edu
References: <74665.1733669976@localhost>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <74665.1733669976@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/24 6:59 AM, rtm@csail.mit.edu wrote:
> The attached program, along with the attached bpf_cubic.o eBPF binary,
> uses bpftool to install a tcp_ca struct ops, creates a tcp connection,
> and then unregisters the struct ops while the tcp connection is still
> active. On my 6.13.0 system this causes a kernel fault due to

I tried the latest bpf-next/master (6.13-r2 + some recent bpf patches). I cannot 
reproduce. I also don't recall any recent fix related to struct_ops refcnt in 
the bpf_struct_ops or bpf_tcp_ca.

I don't see how this could happen now because the icsk->icsk_ca_ops is 
refcnt-ed. e.g. the setsockopt(TCP_CONGESTION) in your attached tcpbpf12a.c. 
bpf_try_module_get, which then calls bpf_struct_ops_get for the bpf written 
tcp-cc, should have refcnt-ed the icsk_ca_ops. I traced on the kernel code path 
triggered by your tcpbpf12a.c and the refcnt looks correct.

If you can reproduce consistently, please help to debug and narrow further why 
the bpf_struct_ops_map_free() cleanup is finished while a tcp_sock still has a 
hold of it in icsk->icsk_ca_ops.

> tcp_tso_segs() calling through a de-allocated struct tcp_congestion_ops.
> 
> bpf_cubic.o came from
> 
>    https://github.com/aroodgar/bpf-tcp-congestion-control-algorithm
> 
> Linux ubuntu66 6.13.0-rc1-00337-g7503345ac5f5 #11 SMP Sun Dec  8 08:37:57 EST 2024 x86_64 x86_64 x86_64 GNU/Linux
> 
> Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> CPU: 6 UID: 0 PID: 1594 Comm: a.out Not tainted 6.13.0-rc1-00337-g7503345ac5f5 #11
> Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
> RIP: 0010:__x86_indirect_thunk_array+0xa/0x20
> Code: 66 0f 1f 00 31 ff e9 15 70 d6 fe cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>   cc cc cc cc cc cc cc e8 01 00 00 00 cc 48 89 04 24 <c3> cc cc cc cc 90 66 66 2e
>   0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> RSP: 0018:ffffc90002037c60 EFLAGS: 00010202
> RAX: 6b6b6b6b6b6b6b6b RBX: ffff88810afc0b00 RCX: 0000000000000018
> RDX: 00000000077b668a RSI: 0000000000008000 RDI: ffff88810afc0b00
> RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000008000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000008000 R14: 0000000000000000 R15: ffffffff842f6140
> FS:  00007f5457b84740(0000) GS:ffff88842db80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5457d8c710 CR3: 000000011b4b8005 CR4: 00000000003706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ? die_addr+0x31/0x80
>   ? exc_general_protection+0x1b4/0x3c0
>   ? asm_exc_general_protection+0x26/0x30
>   ? __x86_indirect_thunk_array+0xa/0x20
>   ? tcp_tso_segs+0x1c/0x90
>   ? tcp_write_xmit+0x74/0x1840
>   ? __mod_memcg_state+0x91/0x190
>   ? __tcp_push_pending_frames+0x31/0xc0
>   ? tcp_sendmsg_locked+0xafc/0xd10
>   ? tcp_sendmsg+0x26/0x40
>   ? sock_write_iter+0x167/0x1a0
>   ? vfs_write+0x35d/0x400
>   ? ksys_write+0xc6/0xe0
>   ? do_syscall_64+0x3f/0xd0
>   ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
> 
> Robert Morris
> rtm@mit.edu
> 


