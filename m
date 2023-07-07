Return-Path: <bpf+bounces-4377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F025A74A887
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279B51C20EC2
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066ED1112;
	Fri,  7 Jul 2023 01:41:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A47F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 01:41:12 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5680F9D
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:41:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qxx1t4szWz4f3m6f
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:41:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAXxCEvbadktz2nMQ--.18953S2;
	Fri, 07 Jul 2023 09:41:07 +0800 (CST)
Subject: Re: [PATCH v4 bpf-next 5/6] selftests/bpf: test map percpu stats
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-6-aspsk@isovalent.com>
 <5efebb7d-138a-5353-2bc2-a2a1ffa66a2d@huaweicloud.com>
 <ZKarXOLIEWxxsQvJ@zh-lab-node-5>
 <43425377-667b-ab01-951a-0513ef79a59d@huaweicloud.com>
 <ZKa6LHj295dY7G+q@zh-lab-node-5>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6bf45335-67ef-4eb0-0e97-c3b3ee55a451@huaweicloud.com>
Date: Fri, 7 Jul 2023 09:41:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKa6LHj295dY7G+q@zh-lab-node-5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAXxCEvbadktz2nMQ--.18953S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArW8GF17tryUAw13tF1xAFb_yoWrJw4rpr
	W5KF43Kw4vkw17Zr17u348XF4avrnYyFy5JFy5K34qyrykWr1S934xK3Wj9Fy3Zr1rC3Wa
	vr42gFWfXasYy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/6/2023 8:57 PM, Anton Protopopov wrote:
> On Thu, Jul 06, 2023 at 08:21:17PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 7/6/2023 7:54 PM, Anton Protopopov wrote:
>>
SNIP
>>> +static void delete_and_lookup_batch(int map_fd, void *keys, __u32 count)
>>> +{
>>> +	static __u8 values[(8 << 10) * MAX_ENTRIES];
>>> +	void *in_batch = NULL, *out_batch;
>>> +	__u32 save_count = count;
>>> +	int ret;
>>> +
>>> +	ret = bpf_map_lookup_and_delete_batch(map_fd,
>>> +					      &in_batch, &out_batch,
>>> +					      keys, values, &count,
>>> +					      NULL);
>>> +
>>> +	/*
>>> +	 * Despite what uapi header says, lookup_and_delete_batch will return
>>> +	 * -ENOENT in case we successfully have deleted all elements, so check
>>> +	 * this separately
>>> +	 */
>>>> It seems it is a bug in __htab_map_lookup_and_delete_batch(). I could
>>>> post a patch to fix it if you don't plan to do that by yourself.
>>> This should be as simple as
>>>
>>> @@ -1876,7 +1876,8 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>>         total += bucket_cnt;
>>>         batch++;
>>>         if (batch >= htab->n_buckets) {
>>> -               ret = -ENOENT;
>>> +               if (!total)
>>> +                       ret = -ENOENT;
>>>                 goto after_loop;
>>>         }
>>>         goto again;
>> No. I think changing it to "if (max_count > total) ret = -ENOENT;" will
>> be more appropriate, because it means the requested count couldn't been
>> fulfilled and it is also consistent with the comments in 
>> include/uapi/linux/bpf.h
> Say, I have a map of size N and I don't know how many entries there are.
> Then I will do
>
>     count=N
>     lookup_and_delete(&count)
>
> In this case we will walk through the whole map, reach the 'batch >=
> htab->n_buckets', and set the count to the number of elements we read.
>
> (If, in opposite, there's no space to read a whole bucket, then we check this
> above and return -ENOSPC.)
>
>>> However, this might be already utilized by some apps to check that they've read
>>> all entries. Two local examples are map_tests/map_in_map_batch_ops.c and
>>> map_tests/htab_map_batch_ops.c. Another example I know is from BCC tools:
>>> https://github.com/iovisor/bcc/blob/master/libbpf-tools/map_helpers.c#L58
>> I think these use cases will be fine. Because when the last element has
>> been successfully iterated and returned, the out_batch is also updated,
>> so if the batch op is called again, -ENOENT will be returned.
>>> Can we update comments in include/uapi/linux/bpf.h?
>> I think the comments are correct.
> Currently we return -ENOENT as an indicator that (a) 'in_batch' is out of
> bounds (b) we reached the end of map. So technically, this is an optimization,
> as if we read elements in a loop by passing 'in_batch', 'out_batch', even if we
> return 0 in case (b), the next syscall would return -ENOENT, because the new
> 'in_batch' would point to out of bounds.
>
> This also makes sense for a map which is empty: we reached the end of map,
> didn't find any elements, so we're returning -ENOENT (in contrast with saying
> "all is ok, we read 0 elements").
>
> So from my point of view -ENOENT makes sense. However, comments say "Returns
> zero on success" which doesn't look true to me as I think that reading the
> whole map in one syscall is a success :)

I get your point. The current implementation of BPF_MAP_LOOKUP_BATCH
does the following two things:
1) returns 0 when the whole map has not been iterated but there is no
space for current bucket.
2) doesn't return 0 when the whole map has been iterated successfully
(and the requested count is fulfilled)

For 1) I prefer to update the comments in uapi. If instead we fix the
implementation, we may break the existed users which need to check
ENOSPC to continue the batch op.
For 2) I don't have a preference. Both updating the comments and
implementation are fine to me.

WDYT ?


