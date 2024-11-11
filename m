Return-Path: <bpf+bounces-44547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C09C4848
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 22:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8786B29CE0
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7D1A76B5;
	Mon, 11 Nov 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qr9gI9Mp"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418E150990
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360630; cv=none; b=QO6HHrHNMwUs7Nh274q5OE9v8lEe4iCLTj4R1HKGD7p4R8cBe7ugkd6ysZ0ekHHIv0daZKXAak+HjVQOMYhFeh98zllaayKok27I3T8sWulQ34/VVlQghAr1APaCCl9JueDh4VZ5PRrex79Mrqh8DvzNoiBUnCqvk2DuJMUGk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360630; c=relaxed/simple;
	bh=1omhm+cftw4C+//TCjr1CLiArFucYSxSGMFCBwoEuwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpMjR4VvJX0oy3c5V2qPDNWNBMdj0LfajpEw1CAWXqC/Xzv76oe4x8l3BX1SWcqVY50FBBc+ZSUcXeiKLYScj3msdufqHdAlRlFL+eOqotcsiqZUNFRLYdHBjOdJmZESG45doUO+TAJy9nFkek561ZV37wP68spTmlzpYrnrYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qr9gI9Mp; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f8f02f5c-acad-4f65-85d3-e20f70fe6b7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731360626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3h8roleKYG5crgbO790r6ULEew10zpc8VqYqlaxMs58=;
	b=Qr9gI9MpRgbEK9AQBY9aEF/pfN9ZTwUyDuJhKxVhayaiGtqdOxAZjW0I8pO9j8NpQN1Hbi
	f/SR8s+JKVK6TUCnT9iABNZ5sjvjMq5AXooMo2M/NuoNqhTTUIl/1kAutLP/UXhGF4HJnO
	+pWlLlnqYqjfTSKICOTo+n8+fRVdx/o=
Date: Mon, 11 Nov 2024 13:30:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for struct_ops map
 release
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241108082633.2338543-1-xukuohai@huaweicloud.com>
 <20241108082633.2338543-3-xukuohai@huaweicloud.com>
 <60a50f93-5416-4ee5-b34a-a1a88652dc82@linux.dev>
 <e898a2b2-779b-45e6-b2d2-a2a796e322ff@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e898a2b2-779b-45e6-b2d2-a2a796e322ff@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/9/24 12:40 AM, Xu Kuohai wrote:
> On 11/9/2024 3:39 AM, Martin KaFai Lau wrote:
>> On 11/8/24 12:26 AM, Xu Kuohai wrote:
>>> -static void bpf_testmod_test_2(int a, int b)
>>> +static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
>>>   {
>>> +    WRITE_ONCE(__bpf_dummy_ops, &__bpf_testmod_ops);
>>>   }
>>
>> [ ... ]
>>
>>> +static int run_struct_ops(const char *val, const struct kernel_param *kp)
>>> +{
>>> +    int ret;
>>> +    unsigned int repeat;
>>> +    struct bpf_testmod_ops *ops;
>>> +
>>> +    ret = kstrtouint(val, 10, &repeat);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (repeat > 10000)
>>> +        return -ERANGE;
>>> +
>>> +    while (repeat-- > 0) {
>>> +        ops = READ_ONCE(__bpf_dummy_ops);
>>
>> I don't think it is the usual bpf_struct_ops implementation which only uses 
>> READ_ONCE and WRITE_ONCE to protect the registered ops. tcp-cc uses a 
>> refcnt+rcu. It seems hid uses synchronize_srcu(). sched_ext seems to also use 
>> kthread_flush_work() to wait for all ops calling finished. Meaning I don't 
>> think the current bpf_struct_ops unreg implementation will run into this issue 
>> for sleepable ops.
>>
> 
> Thanks for the explanation.
> 
> Are you saying that it's not the struct_ops framework's
> responsibility to ensure the struct_ops map is not
> released while it may be still in use? And the "bug" in
> this series should be "fixed" in the test, namely this
> patch?

Yeah, it is what I was trying to say. I don't think there is thing to fix. Think 
about extending a subsystem by a kernel module. The subsystem will also do the 
needed protection itself during the unreg process. There is already a 
bpf_try_module_get() to help the subsystem.

>> The current synchronize_rcu_mult(call_rcu, call_rcu_tasks) is only needed for 
>> the tcp-cc because a tcp-cc's ops (which uses refcnt+rcu) can decrement its 
>> own refcnt. Looking back, this was a mistake (mine). A new tcp-cc ops should 
>> have been introduced instead to return a new tcp-cc-ops to be used.
> 
> Not quite clear, but from the description, it seems that
> the synchronize_rcu_mult(call_rcu, call_rcu_tasks) could

This synchronize_rcu_mult is only need for the tcp_congestion_ops 
(bpf_tcp_ca.c). May be it is cleaner to just make a special case for 
"tcp_congestion_ops" in st_ops->name in map_alloc and only set 
free_after_mult_rcu_gp to TRUE for this one case, then it won't slow down other 
struct_ops map freeing also.

imo, the test in this patch is not needed in its current form also since it is 
not how the kernel subsystem implements unreg in struct_ops.

> be just removed in some way, no need to do a cleanup to
> switch it to call_rcu.
> 
>>
>>> +        if (ops->test_1)
>>> +            ops->test_1();
>>> +        if (ops->test_2)
>>> +            ops->test_2(0, 0);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
> 


