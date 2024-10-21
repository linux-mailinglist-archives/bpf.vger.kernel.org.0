Return-Path: <bpf+bounces-42629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960E9A6AF8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A30C2843E3
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7A1F5848;
	Mon, 21 Oct 2024 13:48:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9321EBA0C
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518534; cv=none; b=uWr8ixDOG8N5JG0o0s76h/5NQp+JukCvnFFpO1dYbO6bSbuEnHec1vG+LC9R0DbLBGw5aG4Tq1L3S7KK6i9rz1uE7rJGGEpd6R43ujaH6CH8znJkQDBh7hO3CsZZLd16wd9DcFfFjGzLQWEYAHaJBbz3q5U6iiQ7BivoclBcGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518534; c=relaxed/simple;
	bh=hV7t7uKn6brpgd7kLZxmKcqsygEGAyiETjynt5WMuuw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T58I6ti4r376Bxhss0szCD8TmN2fxBvHCQvMvzJNsZHn6AzmkUjZ8y/Q5Whjkqn/epHzA8Hotv4k1w+6uO0QoxmDH3Y74/4Is15cVvGG7WA8Gxe7GaDreCAmkflW77qhylL4e8sivaDjL6J8saHKmBc8c3sIIGeoHU8V5JwaB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXGqL2sSkz4f3nZq
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:48:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8AAC31A018D
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:48:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBnnMi9WxZn1zfhEg--.59826S2;
	Mon, 21 Oct 2024 21:48:48 +0800 (CST)
Subject: Re: [PATCH bpf-next 03/16] bpf: Parse bpf_dynptr in map key
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-4-houtao@huaweicloud.com>
 <47dda61b85917e864eab5cde7e16723a5884ce69.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <964bd121-d4ee-b7ee-37c0-d5710f8c5317@huaweicloud.com>
Date: Mon, 21 Oct 2024 21:48:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <47dda61b85917e864eab5cde7e16723a5884ce69.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBnnMi9WxZn1zfhEg--.59826S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18ZF4kAr4rtF4DJFWDurg_yoW8CryUpF
	WfKFWxGay8tFW5GrW5ua4DZFyqqw4ktw17Wwn5GayYvr1DKr12gF18ZFWFgrW5ZFs8Jw45
	Aw1aqrWFv3srAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/11/2024 2:02 AM, Eduard Zingerman wrote:
> On Tue, 2024-10-08 at 17:14 +0800, Hou Tao wrote:
>
> [...]
>
>> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
>> index 645bd30bc9a9..a072835dc645 100644
>> --- a/kernel/bpf/map_in_map.c
>> +++ b/kernel/bpf/map_in_map.c
> [...]
>
>> @@ -45,9 +45,13 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>>  		 * invalid/empty/valid, but ERR_PTR in case of errors. During
>>  		 * equality NULL or IS_ERR is equivalent.
>>  		 */
>> -		struct bpf_map *ret = ERR_CAST(inner_map_meta->record);
>> -		kfree(inner_map_meta);
>> -		return ret;
>> +		ret = ERR_CAST(inner_map_meta->record);
>> +		goto free;
>> +	}
>> +	inner_map_meta->key_record = btf_record_dup(inner_map->key_record);
>> +	if (IS_ERR(inner_map_meta->key_record)) {
>> +		ret = ERR_CAST(inner_map_meta->key_record);
>> +		goto free;
> The 'goto free' executes a call to bpf_map_meta_free() which does
> btf_put(map_meta->btf), but corresponding btf_get(inner_map->btf) only
> happens on the lines below => in case when 'free' branch is taken we
> 'put' BTF object that was not 'get' by us.

Yes, but map_meta->btf is NULL, so calling btf_put(NULL) incurs no harm.
My purpose was trying to simplify the error handling, but it seems that
it leads to confusion. Will only undo the done part in next revision.
>
>>  	}
>>  	/* Note: We must use the same BTF, as we also used btf_record_dup above
>>  	 * which relies on BTF being same for both maps, as some members like
>> @@ -71,6 +75,10 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>>  		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
>>  	}
>>  	return inner_map_meta;
>> +
>> +free:
>> +	bpf_map_meta_free(inner_map_meta);
>> +	return ret;
>>  }
>>  
>>  void bpf_map_meta_free(struct bpf_map *map_meta)
> [...]


