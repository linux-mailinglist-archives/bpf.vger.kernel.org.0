Return-Path: <bpf+bounces-31481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA48FDDBE
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 06:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27BA285C62
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63427219FF;
	Thu,  6 Jun 2024 04:32:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C68821
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 04:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717648324; cv=none; b=qmb6VUO+iLvPcMkRRz22rSzgioRcKmY+hAlkQVZfugkDSxSC6TGlnkW1MtZbWwhL55Rjuz8pSYVMEC++5ebtknI+v9q69Za2w5+vYpQBdqd4fgB76fLGn43x+W2Z3p3QqFKns28Ths0OHh/rgGqqyhBMWb/mU3s3e4PXx5UDL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717648324; c=relaxed/simple;
	bh=mcaccSQR7xme4DfIKXT99GzwHOGeMZ5/DbVJ3g3/uDA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NhwsbKsHA2DzDbYpfs3Xt21/E+HoExjbF8rNqeuLZYDnmdRwLG9wcikuBDpT+H8jrIVNm10E5wEPuhZDJQ47mnUDLrzKIFuigb2UbOol3gwqQeMQthCFLSsp0GCLpI42NHCYxn5nRFlKvAzlbmtk5ZoG3tIe+FOoDpgKmvqPDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VvryF42r2z4f3jtr
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 12:31:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E11F51A0181
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 12:31:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCn9We3O2FmHlP3Ow--.49451S2;
	Thu, 06 Jun 2024 12:31:55 +0800 (CST)
Subject: Re: qp-trie? Re: [PATCH bpf-next 06/10] bpf: Add support for qp-trie
 map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>,
 KP Singh <kpsingh@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Lorenz Bauer <oss@lmb.io>, "Paul E . McKenney" <paulmck@kernel.org>,
 Hou Tao <houtao1@huawei.com>
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
 <20220917153125.2001645-7-houtao@huaweicloud.com>
 <CAADnVQ+0eTwL_iJo8Y79GHB-8zAgNCV7Ka9Mza1b+8ENOShBvw@mail.gmail.com>
 <3a21310f-e5ec-c9fb-86a8-6eeecb0b6975@huaweicloud.com>
 <CAADnVQK0U8pdW0NAno5fS7RYpZcPDWxNHXYaunw4foP9JFLZnQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <8038fc1b-1d73-c8df-9cd1-2dfcde8360fc@huaweicloud.com>
Date: Thu, 6 Jun 2024 12:31:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQK0U8pdW0NAno5fS7RYpZcPDWxNHXYaunw4foP9JFLZnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCn9We3O2FmHlP3Ow--.49451S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF15Gw4DAry7Xr45Gw4rXwb_yoW5Wr1kpF
	WfK3WFkr4DJF1IywsrXws2g34UX39Y9r15GFyYqryUCrWfXr9F9r4IyF45ua43ur4Skay2
	qF4qkry7XFWDZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Alexei,

On 6/6/2024 11:45 AM, Alexei Starovoitov wrote:
> On Wed, Jun 5, 2024 at 6:41 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi Alexei,
>>
>> On 6/5/2024 9:48 PM, Alexei Starovoitov wrote:
>>> Hi Hou,
>>>
>>> Are you still working on qp-trie ?
>>> All prerequisites (like bpf_mem_alloc support) have landed.
>>> Anything keeping you from respinning this set?
>> Sorry, it is paused due to my limited time for bpf subsystem recently.
>> During the limited time for bpf subsystem, I am still trying to resolve
>> the huge memory usage for global bpf_mem_alloc. The problem can be
>> demonstrated by using the bpf_ma benchmark [1] and it happens as follows:
> that was the issue with per-cpu only, no?

No. Both bpf_global_ma and bpf_global_percpu_ma have the same problem.
>
>> (1) there are intensive allocation/free calls for global bpf_mem_alloc
>> in one period on a specific CPU
>> (2) there is not any call afterwards on this CPU
>> (3) these two RCU callbacks in bpf memory allocator end, and it will not
>> be called anymore, because there is not unit_free()/unit_free_rcu() call
>> on the CPU
>> (4) but there will be many objects in free_by_rcu and free_by_rcu_ttrace
>> which are not freed.
> I don't quite see how that can happen.
>
>> I am working on a patch-set which tries to resolve the problem by the
>> following two methods:
>> (1) track the active refcount of global bpf memory allocator hold by bpf
>> programs and bpf maps and invoke a new bpf_mem_alloc_flush() API to
>> flush freeable objects in these lists when the active refcount goes down
>> as zero.
>> (2) try to call call_rcu_tasks_trace() nested if there are freeable
>> objects in the free_by_rcu_ttrace, because bpf_mem_alloc_flush may leave
>> these freeable objects due to concurrency with __free_by_rcu().
> I feel you're seeing something else related to long delays
> in rcu_tasks_trace GP or weirdness with per-cpu alloc.

Er, rcu_tasks_trace GP is relatively slow, but I think it's due to the
artificial alloc/free operations in bpf_ma benchmark is too fast.
>
>> I hope the RFC patch-set for global bpf memory allocator will be posted
>> before next week. After that, I will try to continue my work on qp-trie.
> Anyway, at the last LPC there was a discussion to generalize
> all of bpf_ma logic and make it part of slab.
> So I suggest we hold on to any further changes to bpf_ma.

OK. I will postpone the change, but I still think posting a RFC for
discussion may also benefit the generalization of bpf_ma in slub,  andI
could do that later.
>
> Please prioritize qp-trie. It's more urgent.
> At LPC multiple folks requested a good data structure to store
> variable length objects.
> .

OK. Will do qp-trie first. Could you elaborate one possible use case for
the "variable length objects" thing ?



