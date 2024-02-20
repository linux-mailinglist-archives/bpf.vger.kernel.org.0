Return-Path: <bpf+bounces-22287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7932A85B3B7
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 08:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FE21F23EA6
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744765A4CE;
	Tue, 20 Feb 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kWA+ZmhB"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0772E414;
	Tue, 20 Feb 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413371; cv=none; b=HNX3DjHzNe9msufQrBO9WHz3ae0a7uaQvklSCRkvU6OStbxW03ZriicSSpIvJjNVYV26CmGmzhDjDbTNb8s6S69cVXkRlXtQevkRi7bLpUrdLqGH5SIAsyei4+mILxUoyNcnCGjR/MKOFmyqs5iR5mUlSL6svN5IrwlGCN4jKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413371; c=relaxed/simple;
	bh=cu/T1BOs7iJNYFJOKO7j3SL4H6llYux4Y5Jm+sXsTL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqIc88PGczjo9tKtzSmCxY7wwKZ4ds5MqfFVbextZGYepvVn75GON6WjZnfs7cdchVJVnb/ho2MMMvC7CMQQGefPmhsiuPTKnIgKiGTGlD3sB63EXu/RVd5pVlZtDdKy1DrpChT2WmuUYdvxgk9S5+Ir4zQo6bHvmC9Clh2lwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kWA+ZmhB; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708413365; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aRVK0RBqvwU9ESK4wUCOXJ5JGHcyUKkaoM4QJ3fPRkU=;
	b=kWA+ZmhB9lo4K/EAOIii30ukVBvjUbQWy+Jvm3l7T3FJYZvcYARr1rVOPZixaFA6y8WnkNybUM2QkZZXxa0G13uR4ogobpgi7vWWA58f7VtCuP/OrrGWtxQTtFdyi8sqFJ7mp1Mkko6MG56dHe0eyWNOodmUIyT1ZZLlrAxp+8o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W0w0R3Y_1708413363;
Received: from 30.221.148.206(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0w0R3Y_1708413363)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:16:05 +0800
Message-ID: <e1c747a9-64b7-471b-8fb8-093b8f080490@linux.alibaba.com>
Date: Tue, 20 Feb 2024 15:16:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC nf-next v5 0/2] netfilter: bpf: support prog update
Content-Language: en-US
To: Pablo Neira Ayuso <pablo@netfilter.org>, Quentin Deslandes <qde@naccy.de>
Cc: kadlec@netfilter.org, fw@strlen.de, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org
References: <1704175877-28298-1-git-send-email-alibuda@linux.alibaba.com>
 <70114fff-43bd-4e27-9abf-45345624042c@naccy.de> <ZcztLZPiz+FkF8kF@calendula>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <ZcztLZPiz+FkF8kF@calendula>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/15/24 12:41 AM, Pablo Neira Ayuso wrote:
> On Wed, Feb 14, 2024 at 05:10:46PM +0100, Quentin Deslandes wrote:
>> On 2024-01-02 07:11, D. Wythe wrote:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> This patches attempt to implements updating of progs within
>>> bpf netfilter link, allowing user update their ebpf netfilter
>>> prog in hot update manner.
>>>
>>> Besides, a corresponding test case has been added to verify
>>> whether the update works.
>>> --
>>> v1:
>>> 1. remove unnecessary context, access the prog directly via rcu.
>>> 2. remove synchronize_rcu(), dealloc the nf_link via kfree_rcu.
>>> 3. check the dead flag during the update.
>>> --
>>> v1->v2:
>>> 1. remove unnecessary nf_prog, accessing nf_link->link.prog in direct.
>>> --
>>> v2->v3:
>>> 1. access nf_link->link.prog via rcu_dereference_raw to avoid warning.
>>> --
>>> v3->v4:
>>> 1. remove mutex for link update, as it is unnecessary and can be replaced
>>> by atomic operations.
>>> --
>>> v4->v5:
>>> 1. fix error retval check on cmpxhcg
>>>
>>> D. Wythe (2):
>>>    netfilter: bpf: support prog update
>>>    selftests/bpf: Add netfilter link prog update test
>>>
>>>   net/netfilter/nf_bpf_link.c                        | 50 ++++++++-----
>>>   .../bpf/prog_tests/netfilter_link_update_prog.c    | 83 ++++++++++++++++++++++
>>>   .../bpf/progs/test_netfilter_link_update_prog.c    | 24 +++++++
>>>   3 files changed, 141 insertions(+), 16 deletions(-)
>>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c
>>>
>> It seems this patch has been forgotten, hopefully this answer
>> will give it more visibility.
>>
>> I've applied this change on 6.8.0-rc4 and tested BPF_LINK_UPDATE
>> with bpfilter and everything seems alright.
> Just post it without RFC tag.

Glad to know that, I will send a formal version soon.

D. Wythe







