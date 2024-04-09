Return-Path: <bpf+bounces-26252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C1689D1F5
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072F81F22F01
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 05:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE84657AE;
	Tue,  9 Apr 2024 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JYA5zrFI"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1686A012
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712640927; cv=none; b=hIhhWTLZLnOou6k99ziDxr7ORuvoMsymc5qh5QhC/L+sWJjF7N66QkH3JXRAg/S2QmM34hSToUG05rmvztE+qQTdZguGWaJ3iDzNLB9Sryvlro8LDuxqUazL+vZUaOenPJgYrMBvsKFsTpNi7GxZ6pkPOXhN0CeBo9wVAr1wLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712640927; c=relaxed/simple;
	bh=XhHRctfVaCz2w502f+LjDY2L6sQ4gi2VmzK4Ei0Fet4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=WvM4EnuCLXJKqEdrWHlJpk23h18dWPQMG4/ZqXQuxqwmcdoqjfe8Om1ucrtHhF5c9OGZP7fKJmrxi9aeYwwCQSsUFMxC+KhgzPJTqh6kk9YeF+isrXxC2jchtbzVsl+jjQx1HfxIhE4l1sKmne/67cvqo3b53q3D5POs7WaQWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JYA5zrFI; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b85ed24e-e7ed-49b8-b93a-cb0f9e32540c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712640922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vf1j7wSZq2M24p6/dNYg1VPX+BthblGI9d+1+yhGlLs=;
	b=JYA5zrFIXZLzwBtix3jjPqkEJWf87TXyh6PC2Of0d4GEnhH0Yyblvm3Q+Yre7UacBl0R4k
	lh55o/ib/QDTNxCIbpK4Irhw18qt+1rlM2rJqG79ZjST5NIs6DKL30/B//uxnRxQKhUOQr
	GHwx5yKlLdXeKcRByeEIYxJpELpbHQA=
Date: Mon, 8 Apr 2024 22:35:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in bpf_bprintf_prepare
To: syzbot <syzbot+c2dc95f7d0825a145992@syzkaller.appspotmail.com>
References: <000000000000a1a6990611ea8b4d@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
In-Reply-To: <000000000000a1a6990611ea8b4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/21/24 12:55 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c1ca10ceffbb Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1364db0c180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
> dashboard link: https://syzkaller.appspot.com/bug?extid=c2dc95f7d0825a145992
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/83d019f0ac47/disk-c1ca10ce.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/49e05dd7a23d/vmlinux-c1ca10ce.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/68ec9fa2d33d/bzImage-c1ca10ce.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c2dc95f7d0825a145992@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in bpf_bprintf_prepare+0x20d7/0x23b0 kernel/bpf/helpers.c:904
>   bpf_bprintf_prepare+0x20d7/0x23b0 kernel/bpf/helpers.c:904
>   ____bpf_snprintf kernel/bpf/helpers.c:1060 [inline]
>   bpf_snprintf+0x141/0x360 kernel/bpf/helpers.c:1044
>   ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1986
>   __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2226

#syz dup: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem

>   bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
>   __bpf_prog_run include/linux/filter.h:651 [inline]
>   bpf_prog_run include/linux/filter.h:658 [inline]
>   bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
>   bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991
>   bpf_prog_test_run_flow_dissector+0x6f4/0xa20 net/bpf/test_run.c:1359
>   bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
>   __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
>   __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
>   __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Local variable stack created at:
>   __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2226
>   bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
>   __bpf_prog_run include/linux/filter.h:651 [inline]
>   bpf_prog_run include/linux/filter.h:658 [inline]
>   bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
>   bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991
> 
> CPU: 0 PID: 6318 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkaller-00331-gc1ca10ceffbb #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> =====================================================


