Return-Path: <bpf+bounces-45103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F779D166C
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 17:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F21F2264F
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D181BDA8C;
	Mon, 18 Nov 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oFrqHZpR"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C31BD9D2
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949025; cv=none; b=KBC7f6fD/kiYG9hdlL5neRYDiq17furP01UafTNsj/JhaF2OEWWL+poKleO4SEya40WrE/Ferff0yNed7LZxpNhqPa66/8jeK8u4SSI7H08pKWAuadULvRAEEEw/i+9q0OYYJP6npw08PmNzE1yKBJCAiib0HTrpSJQy+2sqZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949025; c=relaxed/simple;
	bh=0uMfA4X7J/JwV61maTmKXD9wKnVz5aU+5l6RwceZSzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNw5ljZp0LzViNmRBvEsGhRFPVhAK/8ITKULnBhgj6dtkTTv9WEbQxCBMM0lYm959g1kYbE7EPWgRTCRhjazcTGsnkBAsxmiYSscUv848lRy/LxuX9nMIUrJEK4k4kJsx4XRNUxIWFFIfi9KUF1AKwKAyXtEmLZMmEuL2l9hyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oFrqHZpR; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7ad8e67-ab9a-430d-a6eb-f585445a7068@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731949021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3aCPsz1yl5JLw83wHnF2pAFNhFDiem94GZt5xJG9WY=;
	b=oFrqHZpRpgp2j1JzHXTBgfk97awhldyPX3VMMsKXKABTojruuGxlQgARyiscC2FB2WWEcX
	vwDLkbGi1Ng4yX5FRwfQhMwt44ZG4n96jw69TeMrvySt+mumxmC4m6yIrnD/wov4elzWkC
	Z3oQWbVK7TIxDIf5QKnYAnZwdkAX9EE=
Date: Mon, 18 Nov 2024 08:56:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM
 trie
Content-Language: en-GB
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-8-houtao@huaweicloud.com>
 <20241118133002.Ev7Lo3kN@linutronix.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241118133002.Ev7Lo3kN@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/18/24 5:30 AM, Sebastian Andrzej Siewior wrote:
> On 2024-11-18 09:08:05 [+0800], Hou Tao wrote:
>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
>> index d447a6dab83b..d8995acecedf 100644
>> --- a/kernel/bpf/lpm_trie.c
>> +++ b/kernel/bpf/lpm_trie.c
>> @@ -319,6 +326,25 @@ static int trie_check_noreplace_update(const struct lpm_trie *trie, u64 flags)
>>   	return 0;
>>   }
>>   
>> +static void lpm_trie_node_free(struct lpm_trie *trie,
>> +			       struct lpm_trie_node *node, bool defer)
>> +{
>> +	struct bpf_mem_alloc *ma;
>> +
>> +	if (!node)
>> +		return;
>> +
>> +	ma = (node->flags & LPM_TREE_NODE_FLAG_ALLOC_LEAF) ? trie->leaf_ma :
>> +							     trie->im_ma;
>> +
>> +	migrate_disable();
>> +	if (defer)
>> +		bpf_mem_cache_free_rcu(ma, node);
>> +	else
>> +		bpf_mem_cache_free(ma, node);
>> +	migrate_enable();
> I guess a preempt_disable() here instead wouldn't hurt much. The inner
> pieces of the allocator (unit_free()) does local_irq_save() for the
> entire function so we don't win much with migrate_disable().

Typically, bpf_mem_*() functions are surrounded directly
or indirectly by migrate_disable/enable. Let us just keep
this pattern to be consistent with other similar usage.
One close example is in kernel/bpf/cpumask.c.

>
>> +}
>> +
> Sebastian


