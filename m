Return-Path: <bpf+bounces-46221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EBF9E6269
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB745188352F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A0E200CD;
	Fri,  6 Dec 2024 00:48:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DB1758B
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446103; cv=none; b=CBS5/P9RptUx7OeHq4evXQdhEXw/h3wPE8tanUTBKCaU+t3RcwXD3/YkBx+CJjGYZu2p1Ln0rAyah/lbbcTC2bp772NBqgEDjvzWFaH3PGmN0gp4IGjQLZdGCBaXeh59GNK/EUVBgtZyMGjJwEWlz1IPO3IJu1m6f9yD5r44Jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446103; c=relaxed/simple;
	bh=B8+VZgoWfEeGiOegmx3c1es7RFuSR7RheCIIxcZWXj4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xwjt+o1z/eFXVEfp1NjXvC+nay5z4PquZC8PZY8mvRY+uzPpKP/rgYq3v2PNboP7lYjE7nPDIZwtCd1CXKezJSWlAo3OQ595B+2T1qfjIYBFgCxb6C3SjXvyx/eeKDtrUu9LL25+E6HWFDkJbB9u53BhY5yq02MHkIrE24a2cyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y4CKS3NCSz4f3jcq
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 08:47:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 887E51A0196
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 08:48:15 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3kobLSVJnY3MgDw--.18838S2;
	Fri, 06 Dec 2024 08:48:15 +0800 (CST)
Subject: Re: [PATCH bpf v2 7/9] bpf: Use raw_spinlock_t for LPM trie
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-8-houtao@huaweicloud.com> <87frnai67q.fsf@toke.dk>
 <CAADnVQLD+m_L-K0GiFsZ3SO94o3vvdi6dT3cWM=HPuTQ2_AUAQ@mail.gmail.com>
 <fede4cf9-60df-ce3a-9290-18d371622d3b@huaweicloud.com>
 <CAADnVQLab0+JfMUy9RzU27hNsFfON1eu7Ta3VvzBAQp9R1m55w@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1cddf09f-5da6-63e6-7317-33907e196767@huaweicloud.com>
Date: Fri, 6 Dec 2024 08:48:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLab0+JfMUy9RzU27hNsFfON1eu7Ta3VvzBAQp9R1m55w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3kobLSVJnY3MgDw--.18838S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWUtw4kWFWrZFW7Xw4Dtwb_yoW8Kw43pF
	W8Kay5tF4DJrs0ywn2y3y8W34jyw1fK3WjvFn5Gr17ur90gr1fKr40vr4YgF95Ar4IkF4a
	q340qa4fZ3s5Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/6/2024 1:06 AM, Alexei Starovoitov wrote:
> On Thu, Dec 5, 2024 at 12:53 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 12/3/2024 9:42 AM, Alexei Starovoitov wrote:
>>> On Fri, Nov 29, 2024 at 4:18 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>>
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> After switching from kmalloc() to the bpf memory allocator, there will be
>>>>> no blocking operation during the update of LPM trie. Therefore, change
>>>>> trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usable in
>>>>> atomic context, even on RT kernels.
>>>>>
>>>>> The max value of prefixlen is 2048. Therefore, update or deletion
>>>>> operations will find the target after at most 2048 comparisons.
>>>>> Constructing a test case which updates an element after 2048 comparisons
>>>>> under a 8 CPU VM, and the average time and the maximal time for such
>>>>> update operation is about 210us and 900us.
>>>> That is... quite a long time? I'm not sure we have any guidance on what
>>>> the maximum acceptable time is (perhaps the RT folks can weigh in
>>>> here?), but stalling for almost a millisecond seems long.
>>>>
>>>> Especially doing this unconditionally seems a bit risky; this means that
>>>> even a networking program using the lpm map in the data path can stall
>>>> the system for that long, even if it would have been perfectly happy to
>>>> be preempted.
>>> I don't share this concern.
>>> 2048 comparisons is an extreme case.
>>> I'm sure there are a million other ways to stall bpf prog for that long.
>> 2048 is indeed an extreme case. I would do some test to check how much
>> time is used for the normal cases with prefixlen=32 or prefixlen=128.
> Before you do that please respin with comments addressed, so we can
> land the fixes asap.

OK. Original I thought there was no need for respin. Before posting the
v3, I want to confirm the comments which need to be addressed in the new
revision:

1) [PATCH bpf v2 6/9] bpf: Switch to bpf mem allocator for LPM trie
Move  bpf_mem_cache_free_rcu outside of the locked scope (From Alexei)
Move the first lpm_trie_node_alloc() outside of the locked scope (There
will be no refill under irq disabled region)

2)  [PATCH bpf v2 2/9] bpf: Remove unnecessary kfree(im_node) in
lpm_trie_update_elem
Remove the NULL init of im_node (From Daniel)



