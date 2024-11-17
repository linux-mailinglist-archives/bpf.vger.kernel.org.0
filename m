Return-Path: <bpf+bounces-45038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D49D01D1
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 02:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317012853C2
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 01:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5ABC8CE;
	Sun, 17 Nov 2024 01:25:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E7A945;
	Sun, 17 Nov 2024 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731806743; cv=none; b=aEIdQkdIH2D6FjQboeib76W6NT4aTohAXS43rk1wFGnxsxfMETMoXr7GiBpyYgiHcIunnDyfte51UDYnixT/SDQNshRS+BJDU0NzdQvAmt43FzyLHQ6iztFKCXtKlqrbc+76gUHbMAwdnr/0kPyhKZ0qD5Fl5yfrdzbTuFL4l80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731806743; c=relaxed/simple;
	bh=yRpliie+ArulndQE8yACjhS1R7McHB8t9iuOlOoptYs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qo8xiGXZs5VrBwh3DkyvaeJXwS4fM30t7mQxp5uly+cEP6k7IsA/LWmY0JBDsrqLPT52MbGxB5/my88ASh62yc2Q0kk0OV35ZFQQujbu7NXmAIdL2IYKdcbtHsK2tSPfbEZ+CygZpEHX9oCYU/FmfxMfaNMPWSWZgGg7wXQtXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XrY1S5XqQzpbK3;
	Sun, 17 Nov 2024 09:23:40 +0800 (CST)
Received: from kwepemh200010.china.huawei.com (unknown [7.202.181.119])
	by mail.maildlp.com (Postfix) with ESMTPS id BBA2D1400D1;
	Sun, 17 Nov 2024 09:25:32 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 kwepemh200010.china.huawei.com (7.202.181.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 17 Nov 2024 09:24:50 +0800
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	=?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	<tglx@linutronix.de>, Kunwu Chan <kunwu.chan@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com>,
	=?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
 <87v7wsmqv4.ffs@tglx> <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev>
 <87sersyvuc.ffs@tglx> <20241116092102.O_30pj9W@linutronix.de>
 <CAADnVQ+ToRZ6ZQL44Z9TAn6c=ecqrDgrnJenH7-miHJSWe7Nsw@mail.gmail.com>
 <1ed46394-f065-4e8b-8f37-c450b0c1b3a9@t-8ch.de>
 <CAADnVQJBGKioLA0JuyCQdD-jRKn2bpb7A7r6Yo4drBb9G1tvbg@mail.gmail.com>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <10d39b66-2be9-c023-bffe-ffae1de4ea41@huawei.com>
Date: Sun, 17 Nov 2024 09:24:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJBGKioLA0JuyCQdD-jRKn2bpb7A7r6Yo4drBb9G1tvbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh200010.china.huawei.com (7.202.181.119)

Hi,

On 11/17/2024 12:42 AM, Alexei Starovoitov wrote:
> On Sat, Nov 16, 2024 at 8:15 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
>> On 2024-11-16 08:01:49-0800, Alexei Starovoitov wrote:
>>> On Sat, Nov 16, 2024 at 1:21 AM Sebastian Andrzej Siewior
>>> <bigeasy@linutronix.de> wrote:
>>>> On 2024-11-15 23:29:31 [+0100], Thomas Gleixner wrote:
>>>>> IIRC, BPF has it's own allocator which can be used everywhere.
>>>> Thomas Weißschuh made something. It appears to work. Need to take a
>>>> closer look.
>>> Any more details?
>>> bpf_mem_alloc is a stop gap.
>> It is indeed using bpf_mem_alloc.
>> It is a fairly straightforward conversion, using one cache for
>> intermediate and one for non-intermediate nodes.
> Sounds like you're proposing to allocate two lpm specific bpf_ma-s ?
> Just use bpf_global_ma.
> More ma-s means more memory pinned in bpf specific freelists.
> That's the main reason to teach slub and page_alloc about bpf requirements.
> All memory should be shared by all subsystems.
> Custom memory pools / freelists, whether it's bpf, networking
> or whatever else, is a pain point for somebody.
> The kernel needs to be optimal for all use cases.

I have been working on it since last week [1] and have already written a
patch (a patch in a patch set) for it. In my patch, these two allocators
will be merged if they are mergable and now the merge is decided by the
return value of kmalloc_size_roundup(). Also considering about using
bpf_global_ma instead, but the biggest problem for bpf_global_ma is the
memory accounting. The allocated memory will be accounted under root
memory cgroup instead of the memory cgroup of users.

[1]:
https://lore.kernel.org/bpf/e14d8882-4760-7c9c-0cfc-db04eda494ee@huaweicloud.com/
>
>> I'll try to send it early next week.
> Looking forward.
>
>>> As Vlastimil Babka suggested long ago:
>>> https://lwn.net/Articles/974138/
>>> "...next on the target list is the special allocator used by the BPF
>>> subsystem. This allocator is intended to succeed in any calling
>>> context, including in non-maskable interrupts (NMIs). BPF maintainer
>>> Alexei Starovoitov is evidently in favor of this removal if SLUB is
>>> able to handle the same use cases..."
>>>
>>> Here is the first step:
>>> https://lore.kernel.org/bpf/20241116014854.55141-1-alexei.starovoitov@gmail.com/
>
> .


