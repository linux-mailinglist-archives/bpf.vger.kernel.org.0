Return-Path: <bpf+bounces-26249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6FF89D1EC
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8651E1C22BF1
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 05:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868535FB8F;
	Tue,  9 Apr 2024 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DMA6cidZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24241C6E
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712640635; cv=none; b=daj1O9Rq2RabOJuKb/8o7b0KPc19BFjruP2a6twYenR3Ugo2eiy29j4H4b6L1ILwT0hw225Rls7SyBfXB6JuIFth+6WhlRJoZ0ElR6+3iGo+5BQtVl/54pWHMdYO9cRHO5+EJi5wTqCnulxa5tjX7FH39AqvgHvcv1K5/Bg9+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712640635; c=relaxed/simple;
	bh=Fz3PHmDtJLvKZS5hQfm+0ibnseLU5xNTfqqrFmCqUp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Dum9rjAgWCzq5vlQZ9QhjmF0Q5NRYWO2HSRID1PjNHeJ2R0DSgvx0hrMcNVRvJqGmu8J+oTysGtWBvL+PV9eRxHIVx6LZyBjeszEamHHCkppTnPhThk1N6UrrS6GJqEcsrVVvDJVfYzlFuO+pm+Ny/UoMDsNgqnAeZe6a4+1twM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DMA6cidZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c5ccbda-a4ea-4585-bb28-e1ae967cf741@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712640631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1u+BEOPK1tBIn4dugW2eHK+BWf+YmmYpwlsMf2e5wg=;
	b=DMA6cidZDKTK4HxhEZ3NLqANL4DDz7AjZhgE2uwDeBPFL+HoGKtGxZgC/+8lgVPgnnouO9
	gW8JvYzI0TK4sPppm9SCfjJkffrXYP7Q1Fpj+XbJw5f9tAVKsenZnHhFi3Nxksbi0/SMez
	i7sifZ0WTN85pDZ+6We3ZGxzpXrgzCY=
Date: Mon, 8 Apr 2024 22:30:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in strnchr
To: syzbot <syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com>
References: <0000000000009e2ff406130de279@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
In-Reply-To: <0000000000009e2ff406130de279@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/7/24 12:30 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of git://g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bb9306180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
> dashboard link: https://syzkaller.appspot.com/bug?extid=9b8be5e35747291236c8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11093316180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a53082180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a4610b1ff2a7/disk-04b8076d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/991e9d902d39/vmlinux-04b8076d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a5b8e8e98121/bzImage-04b8076d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in strnchr+0x90/0xd0 lib/string.c:388
>   strnchr+0x90/0xd0 lib/string.c:388
>   bpf_bprintf_prepare+0x1c2/0x23b0 kernel/bpf/helpers.c:829
>   ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
>   bpf_trace_printk+0xec/0x3e0 kernel/trace/bpf_trace.c:375
>   ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1986
>   __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2225

This is the same as the dev_map_lookup_elem report when running in interpreter 
mode. It loads a different program to call bpf_trace_printk instead.

    0: (6a) *(u16 *)(r10 -8) = 628106613
    1: (bf) r1 = r10
    2: (07) r1 += -8
    3: (b7) r2 = 5
    4: (bf) r3 = r1
    5: (85) call bpf_trace_printk#-315920
    6: (b7) r0 = 0
    7: (95) exit


#syz dup: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem


