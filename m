Return-Path: <bpf+bounces-4235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE0749BA0
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EC6281283
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1A8F59;
	Thu,  6 Jul 2023 12:21:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929328C07
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 12:21:31 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1E6E70
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 05:21:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QxbH76N9Sz4f3pBn
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:21:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAnuDK+saZk6518Mg--.45123S2;
	Thu, 06 Jul 2023 20:21:21 +0800 (CST)
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <43425377-667b-ab01-951a-0513ef79a59d@huaweicloud.com>
Date: Thu, 6 Jul 2023 20:21:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKarXOLIEWxxsQvJ@zh-lab-node-5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAnuDK+saZk6518Mg--.45123S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF13ur48uFWxWF45KrykXwb_yoW5WFWxpr
	WFkF4fGw4kurZFqw1I9a48WFW2vrn5Ar15ZrW5G34jyrnFgr1S9r10k3WjkF129rW7AwnI
	9w429393Xas5CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/6/2023 7:54 PM, Anton Protopopov wrote:
> On Thu, Jul 06, 2023 at 06:49:02PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 7/6/2023 12:01 AM, Anton Protopopov wrote:
>>> Add a new map test, map_percpu_stats.c, which is checking the correctness of
>>> map's percpu elements counters.  For supported maps the test upserts a number
>>> of elements, checks the correctness of the counters, then deletes all the
>>> elements and checks again that the counters sum drops down to zero.
>>>
>>> The following map types are tested:
>>>
>>>     * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
>>>     * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
>>>     * BPF_MAP_TYPE_HASH,
>>>     * BPF_MAP_TYPE_PERCPU_HASH,
>>>     * BPF_MAP_TYPE_LRU_HASH
>>>     * BPF_MAP_TYPE_LRU_PERCPU_HASH
>>>     * BPF_MAP_TYPE_LRU_HASH, BPF_F_NO_COMMON_LRU
>>>     * BPF_MAP_TYPE_LRU_PERCPU_HASH, BPF_F_NO_COMMON_LRU
>>>     * BPF_MAP_TYPE_HASH_OF_MAPS
>>>
>>> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
>> Acked-by: Hou Tao <houtao1@huawei.com>
>>
>> With two nits below.
> Thanks, fixed both for v5.
Great.
SNIP
> +static void delete_and_lookup_batch(int map_fd, void *keys, __u32 count)
> +{
> +	static __u8 values[(8 << 10) * MAX_ENTRIES];
> +	void *in_batch = NULL, *out_batch;
> +	__u32 save_count = count;
> +	int ret;
> +
> +	ret = bpf_map_lookup_and_delete_batch(map_fd,
> +					      &in_batch, &out_batch,
> +					      keys, values, &count,
> +					      NULL);
> +
> +	/*
> +	 * Despite what uapi header says, lookup_and_delete_batch will return
> +	 * -ENOENT in case we successfully have deleted all elements, so check
> +	 * this separately
> +	 */
>> It seems it is a bug in __htab_map_lookup_and_delete_batch(). I could
>> post a patch to fix it if you don't plan to do that by yourself.
> This should be as simple as
>
> @@ -1876,7 +1876,8 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>         total += bucket_cnt;
>         batch++;
>         if (batch >= htab->n_buckets) {
> -               ret = -ENOENT;
> +               if (!total)
> +                       ret = -ENOENT;
>                 goto after_loop;
>         }
>         goto again;

No. I think changing it to "if (max_count > total) ret = -ENOENT;" will
be more appropriate, because it means the requested count couldn't been
fulfilled and it is also consistent with the comments in 
include/uapi/linux/bpf.h
>
> However, this might be already utilized by some apps to check that they've read
> all entries. Two local examples are map_tests/map_in_map_batch_ops.c and
> map_tests/htab_map_batch_ops.c. Another example I know is from BCC tools:
> https://github.com/iovisor/bcc/blob/master/libbpf-tools/map_helpers.c#L58
I think these use cases will be fine. Because when the last element has
been successfully iterated and returned, the out_batch is also updated,
so if the batch op is called again, -ENOENT will be returned.
>
> Can we update comments in include/uapi/linux/bpf.h?
I think the comments are correct.
>
>
> .


