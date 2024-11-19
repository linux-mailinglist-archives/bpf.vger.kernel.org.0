Return-Path: <bpf+bounces-45130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028729D1CEC
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 02:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD76282CD8
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 01:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3F2AD2C;
	Tue, 19 Nov 2024 01:06:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3181BF24
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978419; cv=none; b=etFyWFItHwwt//p/C8iJXoR9S3HzlFq41Vi72ih103yVgc+txOwAhP22jkcaBKHj6mxcDOaAH/Kd6whsYESDrcI4HQVxK9lVYC9ITBYMsf+sZU7Fcive7nEVlp/gxCKnLQJl1zVJlAsbrpCdDcwMX2fQiFRnbpRfi9+WVspB+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978419; c=relaxed/simple;
	bh=0zUSdenMOqy0Vl5Cis5lm+wHFd4KFCFo8zxADcN8POM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JSYYgHu3X9ifDa6fCTSkXuuylECC6XE1vzq/DCJpR3P/0RzbAaGj+NO0IisgdukdEeXQn55IyYuSs2hX9kV7W9j7J7Kdc3IZ9hbWreLhQCDtDJMYNZ9oiopAIAiqr465SWXhe+SQT6bNpYHBcu2CFDoMkY+/H3NMalXAHCTwM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsmXp2VSdz4f3kkd
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:06:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B84D91A06D7
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:06:47 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAnA4ek5Dtn59XACA--.8965S2;
	Tue, 19 Nov 2024 09:06:47 +0800 (CST)
Subject: Re: [PATCH bpf-next 06/10] bpf: Add bpf_mem_cache_is_mergeable()
 helper
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
 <20241118010808.2243555-7-houtao@huaweicloud.com>
 <20241118142841-47031015-7ab8-454b-b6d5-12090d10b0d1@linutronix.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e4dc43a4-2588-8aac-b8c4-0d365eba7b90@huaweicloud.com>
Date: Tue, 19 Nov 2024 09:06:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241118142841-47031015-7ab8-454b-b6d5-12090d10b0d1@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAnA4ek5Dtn59XACA--.8965S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF17ur47KFW7XF4DJry5Arb_yoW8uF18pF
	W7GF18CFs0vF4UX3W7Wrn2ya95Xw4Sg3W7Ka4aqryUZrnI9rnrGr4DGry3WF90vr4qkF40
	kr1qgF4fCryUZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/18/2024 9:29 PM, Thomas Weißschuh wrote:
> On Mon, Nov 18, 2024 at 09:08:04AM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Add bpf_mem_cache_is_mergeable() to check whether two bpf mem allocator
>> for fixed-size objects are mergeable or not. The merging could reduce
>> the memory overhead of bpf mem allocator.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  include/linux/bpf_mem_alloc.h |  1 +
>>  kernel/bpf/memalloc.c         | 12 ++++++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
>> index e45162ef59bb..faa54b9c7a04 100644
>> --- a/include/linux/bpf_mem_alloc.h
>> +++ b/include/linux/bpf_mem_alloc.h
>> @@ -47,5 +47,6 @@ void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
>>  void bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
>>  void bpf_mem_cache_raw_free(void *ptr);
>>  void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
>> +bool bpf_mem_cache_is_mergeable(size_t size, size_t new_size, bool percpu);
>>  
>>  #endif /* _BPF_MEM_ALLOC_H */
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 889374722d0a..49dd08ad1d4f 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -1014,3 +1014,15 @@ int bpf_mem_alloc_check_size(bool percpu, size_t size)
>>  
>>  	return 0;
>>  }
>> +
>> +bool bpf_mem_cache_is_mergeable(size_t size, size_t new_size, bool percpu)
>> +{
>> +	/* Only for fixed-size object allocator */
>> +	if (!size || !new_size)
>> +		return false;
>> +
>> +	return (percpu && ALIGN(size, PCPU_MIN_ALLOC_SIZE) ==
>> +			  ALIGN(new_size, PCPU_MIN_ALLOC_SIZE)) ||
>> +	       (!percpu && kmalloc_size_roundup(size + LLIST_NODE_SZ) ==
>> +			   kmalloc_size_roundup(new_size + LLIST_NODE_SZ));
> This would be easier to read:
>
> if (percpu)
> 	return ALIGN() == ALIGN();
> else
> 	return kmalloc_size_roundup() == kmalloc_size_roundup();

Indeed. Thanks for the suggestion. Will do in v2.
>> +}
>> -- 
>> 2.29.2
>>


