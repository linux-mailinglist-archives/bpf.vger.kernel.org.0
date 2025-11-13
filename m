Return-Path: <bpf+bounces-74343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3863C55971
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 04:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 422924E75F4
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 03:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB9296BB6;
	Thu, 13 Nov 2025 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oXdIpCao"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3C274B23;
	Thu, 13 Nov 2025 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005698; cv=none; b=k5cq8hYkX/X3w2Ot64e3Tsdv8bNEoa1gnWO0TXuTRnApCLB6oMIP2tZ92BtAzqRcIvn3PnW1RMzbl4grusWD77xPH6uQ+guP+13jpgt5tfOjoN/HZ8Dskmc5BHwnAg/CWcvIXADRZ/i2WIc4gWCEi4k3x/99RpMWVX8Lo2uxBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005698; c=relaxed/simple;
	bh=/pGO0fdusEy8QxI603Svb6mphEh80MlylAtLpdXdDPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+IHcryfOTkNzd6fZhfon3ZDeUaxGq1b+669CAwPEZn/kT4UTIgeYI0XmYU5K75t7Tj5qnsPBw7kmFbz890BT4OJA5ZpheZ4FeRxgRBcxGFFLPq1oFNS75i7VRDyBjQpxjs8Zy0Y3RNbdxJLeygmR3vUd+rKXK9ZBe0eMgJ0A3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oXdIpCao; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763005687; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NQ0cb143Fk6+kUWaeT8PET+2Q8tlg6Zp5AevuF4vT2M=;
	b=oXdIpCaok8o64rgHN9BMuepstqP9QIRy9Ffq5EXx7/qR66Goo4yS73wtpcwZFWTpPNZLTPAcDHh/WR1D9199cNnNAjO3OqKBvOvPXUso7cdAEsKsTkPYkbQBX4WCRXB3dRhw75dPSkKH4wGL/Yp064Nl3tBiku4NdTzwGjLkcRE=
Received: from 30.180.123.14(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WsI3wdv_1763005686 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Nov 2025 11:48:07 +0800
Message-ID: <e1d26f84-7ea2-46de-8ab9-31e49b485832@linux.alibaba.com>
Date: Thu, 13 Nov 2025 11:48:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] make vmalloc gfp flags usage more apparent
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2025/11/13 02:58, Vishal Moola (Oracle) wrote:
> We should do a better job at enforcing gfp flags for vmalloc. Right now, we
> have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
> supported flags. If a caller were to pass in an unsupported flag, we may
> BUG, silently clear it, or completely ignore it.
> 
> If we are more proactive about enforcing gfp flags, we can making sure
> callers know when they may be asking for unsupported behavior.
> 
> This patchset lets vmalloc control the incoming gfp flags, and cleans up
> some hard to read gfp code.
> 
> ---
> Linked rfc [1] and rfc v2[2] for convenience.

Just FYI, I hit this warning when booting today's mm-new branch.

[    1.238451] ------------[ cut here ]------------
[    1.238453] Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to 
gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
[    1.249347] WARNING: CPU: 27 PID: 338 at mm/vmalloc.c:3937 
__vmalloc_noprof+0x74/0x80
[    1.249352] Modules linked in:
[    1.249354] CPU: 27 UID: 0 PID: 338 Comm: (journald) Not tainted 
6.18.0-rc5+ #55 PREEMPT(none)
[    1.249357] RIP: 0010:__vmalloc_noprof+0x74/0x80
[    1.249359] Code: 00 5d e9 6f f8 ff ff 89 d1 49 89 e0 48 8d 54 24 04 
89 74 24 04 81 e1 e0 ad 11 00 48 c7 c7 68 b0 75 82 89 0c 24 e8 7c bf ce 
ff <0f> 0b 8b 14 24 eb ab e8 f0 61 a5 00 90
  90 90 90 90 90 90 90 90 90
[    1.249360] RSP: 0018:ffffc90000bebe08 EFLAGS: 00010286
[    1.249362] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 
ffffffff82fdee68
[    1.249363] RDX: 000000000000001b RSI: 0000000000000000 RDI: 
ffffffff82a5ee60
[    1.249364] RBP: 0000000000001000 R08: 0000000000000000 R09: 
ffffc90000bebcb8
[    1.249364] R10: ffffc90000bebcb0 R11: ffffffff8315eea8 R12: 
ffff88810aac98c0
[    1.249365] R13: 0000000000000000 R14: ffffffff8141abe0 R15: 
fffffffffffffff3
[    1.249368] FS:  00007fbc9436ee80(0000) GS:ffff88bec00e1000(0000) 
knlGS:0000000000000000
[    1.249370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.249371] CR2: 0000562248eda010 CR3: 00000001028a8005 CR4: 
0000000000770ef0
[    1.249371] PKRU: 55555554
[    1.249372] Call Trace:
[    1.249373]  <TASK>
[    1.249374]  bpf_prog_alloc_no_stats+0x37/0x250
[    1.249377]  ? __pfx_seccomp_check_filter+0x10/0x10
[    1.249379]  bpf_prog_alloc+0x1a/0xa0
[    1.249381]  bpf_prog_create_from_user+0x51/0x130
[    1.249385]  seccomp_set_mode_filter+0x117/0x410
[    1.249387]  do_syscall_64+0x5b/0xda0
[    1.249390]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.249392] RIP: 0033:0x7fbc94f4c9cd


