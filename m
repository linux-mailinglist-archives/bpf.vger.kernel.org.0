Return-Path: <bpf+bounces-45444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62F9D5899
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 04:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D789D1F22B27
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94627E575;
	Fri, 22 Nov 2024 03:37:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E123098B
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732246626; cv=none; b=STxcbdsejJYdZgNaG2WoSFzwE7kZe+E7PjQWEV0via4bvgr6q6LubS831uXwcByq8uTjP4iH+rVuWhboiXS1AdURWNK1nZMYJne6Rlnhf2RPnRQKn/WHN4o5PGFUj7Xw1y5v77YeTMdLmceJNfD1K5cWjT1yovpUYwU9ou+0GxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732246626; c=relaxed/simple;
	bh=ffsUoS1IicMwAmQHsJZJhZW6PUToplYaqJ+K3KTic1Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kY4pO5JKWnNFbMt5Ap75JtVpTTjMpKXn3Yjwp4cdGcmGnGizIVaack7Xj6lplTkshoDBt222okDEXRS8iK6eR4wg0sFl+B3Ed90P9qrsgJSNBnsjqIPIujFszh/Bz+hO41+MvX8GNe8XBRXG6wwzicT14g9ZAbGkTSM4hApNDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xvgkd2KLpz4f3jXn
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 11:36:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E24B81A0197
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 11:36:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXALJV_D9n+puwCQ--.19602S2;
	Fri, 22 Nov 2024 11:36:57 +0800 (CST)
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM
 trie
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-8-houtao@huaweicloud.com> <8734jkizoj.fsf@toke.dk>
 <20241121124649-bc310634-8cc9-464e-bb81-6a9ad0f8e136@linutronix.de>
 <87wmgwhhsm.fsf@toke.dk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b5270bb8-7511-0f81-7779-9f0b76b07e6d@huaweicloud.com>
Date: Fri, 22 Nov 2024 11:36:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wmgwhhsm.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXALJV_D9n+puwCQ--.19602S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1xuF4DJw15Gr45tw4DCFg_yoW5uF4kpF
	W7K3W7Krs0qw4vvwn2yw17Wa40kw4xGF1UGF90qry8uryS9F1fWrW7Kay8uFyDuF4xCa4U
	trWqvrW3ZFyDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/21/2024 8:50 PM, Toke Høiland-Jørgensen wrote:
> Thomas Weißschuh <thomas.weissschuh@linutronix.de> writes:
>
>> On Thu, Nov 21, 2024 at 12:39:08PM +0100, Toke Høiland-Jørgensen wrote:
>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>
>>>> Fix these warnings by replacing kmalloc()/kfree()/kfree_rcu() with
>>>> equivalent bpf memory allocator APIs. Since intermediate node and leaf
>>>> node have fixed sizes, fixed-size allocation APIs are used.
>>>>
>>>> Two aspects of this change require explanation:
>>>>
>>>> 1. A new flag LPM_TREE_NODE_FLAG_ALLOC_LEAF is added to track the
>>>>    original allocator. This is necessary because during deletion, a leaf
>>>>    node may be used as an intermediate node. These nodes must be freed
>>>>    through the leaf allocator.
>>>> 2. The intermediate node allocator and leaf node allocator may be merged
>>>>    because value_size for LPM trie is usually small. The merging reduces
>>>>    the memory overhead of bpf memory allocator.
>>> This seems like an awfully complicated way to fix this. Couldn't we just
>>> move the node allocations in trie_update_elem() out so they happen
>>> before the trie lock is taken instead?

Had considered about it. However, it will allocate two nodes for each
update, I think it may be too expensive.
>> The problematic lock nesting is not between the trie lock and the
>> allocator lock but between each of them and any other lock in the kernel.
>> BPF programs can be called from any context through tracepoints.
>> In this specific case the issue was a tracepoint executed under the
>> workqueue lock.
> That is not the issue described in the commit message, though. If the
> goal is to make the lpm_trie map usable in any context, the commit
> message should be rewritten to reflect this, instead of mentioning a
> specific deadlock between the trie lock and the allocator lock.

The original intention of the patch set is trying to resolve the
multiple syzbot dead-lock locking reports [1]. All of these reports
involve trie->lock and the internal lock in kmalloc(). However, as
pointed out by Thomas, only fixing the order of trie->lock and internal
lock in kmalloc() is not enough. Will update the commit message to
reflect that.

[1]:
https://lore.kernel.org/bpf/e14d8882-4760-7c9c-0cfc-db04eda494ee@huaweicloud.com/
>
> And in that case, I think it's better to use a single 'struct
> bpf_mem_alloc' per map (like hashmaps do). This will waste some memory
> for intermediate nodes, but that seems like an acceptable trade-off to
> avoid all the complexity around two different allocators.
>
> Not sure if Alexei's comment about too many allocators was aimed solely
> at this, or if he has issues even with having a single allocator per map
> as well; but in that case, that seems like something that should be
> fixed for hashmaps as well?

In my understanding, the motivation for using a shared bpf_mem_alloc
instead of a per-map one is to reduce the memory overhead of per-cpu
object freelist in each bpf memory allocator. The hash map is a bit
different, because these freed objects return back to bpf_mem_alloc may
be reused immediately, so if the freed object is reused by other
call-sites (e.g., no hash map) and the hlist_nulls_node is overwritten,
the lookup procedure of hash map may incur oops.

>
> -Toke


