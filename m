Return-Path: <bpf+bounces-44421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36F9C2B4C
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 09:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B61F21E79
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C300145B0C;
	Sat,  9 Nov 2024 08:40:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE2647;
	Sat,  9 Nov 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731141654; cv=none; b=qhl4iChl3qidDOP+hP79+eNaRqjHQaKTAun1RxGHA2mJrfTe2qXxPb8e3dkVK43Oa/whO6TCHEbGHiD/jHbx0qboSuPOtFuRhvWsTRPC+iU8/TwwNd8dEZNVMYp/wnPu51Nrf4pQN7DUVlxZdFX1NNjo8Ln8O9Ni0VE0FswomYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731141654; c=relaxed/simple;
	bh=pxd33NTDnSG5J/R/Y7RshQj9GXCHq3NO8FHMWwcbTrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijxuzTNpZeRsSOp6gUi/CHn758jw9fEqtJwGFzTHLfk46NewMRdfVs7juDHjWj4nKx+8Itu1Bw11/luX/5RoWq8Dxs7U4WeVRlrxBnXtHn1qEaNfgDAxc+bGN/e9kjFVY3vXFznQt2dABMzz6zy06nbulVJeAhj2RN1twkVQeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xlq521TC1z4f3n6H;
	Sat,  9 Nov 2024 16:40:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2AD4C1A0196;
	Sat,  9 Nov 2024 16:40:41 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgAXDK4HIC9nUlMABQ--.1264S2;
	Sat, 09 Nov 2024 16:40:41 +0800 (CST)
Message-ID: <e898a2b2-779b-45e6-b2d2-a2a796e322ff@huaweicloud.com>
Date: Sat, 9 Nov 2024 16:40:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for struct_ops map
 release
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241108082633.2338543-1-xukuohai@huaweicloud.com>
 <20241108082633.2338543-3-xukuohai@huaweicloud.com>
 <60a50f93-5416-4ee5-b34a-a1a88652dc82@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <60a50f93-5416-4ee5-b34a-a1a88652dc82@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXDK4HIC9nUlMABQ--.1264S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWxAF15tw4kJr17ZF1rtFb_yoW8uFyfpF
	s5JrWUAFZrJrsYqF1jgr1UZFyrAr1qqw1DXry8X3Z8Ar47Zr9YgF1jqrs29F15Cr4kGF1U
	A3yjvr9rZr17AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/9/2024 3:39 AM, Martin KaFai Lau wrote:
> On 11/8/24 12:26 AM, Xu Kuohai wrote:
>> -static void bpf_testmod_test_2(int a, int b)
>> +static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
>>   {
>> +    WRITE_ONCE(__bpf_dummy_ops, &__bpf_testmod_ops);
>>   }
> 
> [ ... ]
> 
>> +static int run_struct_ops(const char *val, const struct kernel_param *kp)
>> +{
>> +    int ret;
>> +    unsigned int repeat;
>> +    struct bpf_testmod_ops *ops;
>> +
>> +    ret = kstrtouint(val, 10, &repeat);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (repeat > 10000)
>> +        return -ERANGE;
>> +
>> +    while (repeat-- > 0) {
>> +        ops = READ_ONCE(__bpf_dummy_ops);
> 
> I don't think it is the usual bpf_struct_ops implementation which only uses READ_ONCE and WRITE_ONCE to protect the registered ops. tcp-cc uses a refcnt+rcu. It seems hid uses synchronize_srcu(). sched_ext seems to also use kthread_flush_work() to wait for 
> all ops calling finished. Meaning I don't think the current bpf_struct_ops unreg implementation will run into this issue for sleepable ops.
> 

Thanks for the explanation.

Are you saying that it's not the struct_ops framework's
responsibility to ensure the struct_ops map is not
released while it may be still in use? And the "bug" in
this series should be "fixed" in the test, namely this
patch?

> The current synchronize_rcu_mult(call_rcu, call_rcu_tasks) is only needed for the tcp-cc because a tcp-cc's ops (which uses refcnt+rcu) can decrement its own refcnt. Looking back, this was a mistake (mine). A new tcp-cc ops should have been introduced 
> instead to return a new tcp-cc-ops to be used.

Not quite clear, but from the description, it seems that
the synchronize_rcu_mult(call_rcu, call_rcu_tasks) could
be just removed in some way, no need to do a cleanup to
switch it to call_rcu.

> 
>> +        if (ops->test_1)
>> +            ops->test_1();
>> +        if (ops->test_2)
>> +            ops->test_2(0, 0);
>> +    }
>> +
>> +    return 0;
>> +}


