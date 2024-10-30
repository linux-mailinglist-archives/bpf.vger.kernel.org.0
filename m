Return-Path: <bpf+bounces-43542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D80E9B5FA7
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 11:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D8D284A1D
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34C81E32C1;
	Wed, 30 Oct 2024 10:02:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F951E1C2F
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282572; cv=none; b=JEV5QhHA9OUs7xZ4B20gsQJFJa8i3YIyoGHzFiLqww5p0KprSboQ9h48aRrQSQ0wyb9mu+BufT+r4O9HxBiLiNPEXReeBp8EJwpHSIt4R0gFnzEvCTfYZCnxlXkF1GXX2EnfkiU5dgcUT12RStQ4krApDDN78m8ss7hoEyRWiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282572; c=relaxed/simple;
	bh=dxVAwY/8HQOBw4q7k1uoaEbZPMDSsLX2K1FHryji8BU=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qtD9QYVe2qR4/V4Su6LT4Oa/iZDMbabSYmb8PQXjUp8YcGTn+jLl9gD561SVy8Lg1Bm249zqMOwaH/8tBn8IpiHj14kP/UiBZYXOLvASQBYE6SGp/O4a6ZnEYRfPaOBkaof2u0lAyiB1q+WSaI9FOF/G5p1nMC9utxcKVUqYYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XdjNV0M9Mz4f3kKT
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 18:02:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A1C671A018D
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 18:02:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBXBOFCBCJngGVtAQ--.58801S2;
	Wed, 30 Oct 2024 18:02:46 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next 12/16] bpf: Support basic operations for dynptr
 key in hash map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-13-houtao@huaweicloud.com>
 <CAADnVQKSYzEVA2fPLOhZs6Bdz492wmVU9DAp4q0qLdTHYAhEEQ@mail.gmail.com>
Message-ID: <c6d60075-ee0e-f875-c098-ffe9ff7e8d6b@huaweicloud.com>
Date: Wed, 30 Oct 2024 18:02:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKSYzEVA2fPLOhZs6Bdz492wmVU9DAp4q0qLdTHYAhEEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBXBOFCBCJngGVtAQ--.58801S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1DCw45KrW8uF18tF47urg_yoW7Gw15pF
	WrGa4FqrWkCFn2vwn3JF4FkFWYy3WkWr1UG3s8K34Ykas8CFyfGr4xWayF9Fy5CrykCrnY
	qw4Ut3W5Gw15urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/12/2024 12:47 AM, Alexei Starovoitov wrote:
> On Tue, Oct 8, 2024 at 2:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The patch supports lookup, update, delete and lookup_delete operations
>> for hash map with dynptr map. There are two major differences between
>> the implementation of normal hash map and dynptr-keyed hash map:
>>
>> 1) dynptr-keyed hash map doesn't support pre-allocation.
>> The reason is that the dynptr in map key is allocated dynamically
>> through bpf mem allocator. The length limitation for these dynptrs is
>> 4088 bytes now. Because there dynptrs are allocated dynamically, the
>> consumption of memory will be smaller compared with normal hash map when
>> there are big differences between the length of these dynptrs.
>>
>> 2) the freed element in dynptr-key map will not be reused immediately
>> For normal hash map, the freed element may be reused immediately by the
>> newly-added element, so the lookup may return an incorrect result due to
>> element deletion and element reuse. However dynptr-key map could not do
>> that, there are pointers (dynptrs) in the map key and the updates of
>> these dynptrs are not atomic: both the address and the length of the
>> dynptr will be updated. If the element is reused immediately, the access
>> of the dynptr in the freed element may incur invalid memory access due
>> to the mismatch between the address and the size of dynptr, so reuse the
>> freed element after one RCU grace period.
>>
>> Beside the differences above, dynptr-keyed hash map also needs to handle
>> the maybe-nullified dynptr in the map key.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/hashtab.c | 283 +++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 257 insertions(+), 26 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index b14b87463ee0..edf19d36a413 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -88,6 +88,7 @@ struct bpf_htab {
>>         struct bpf_map map;
>>         struct bpf_mem_alloc ma;
>>         struct bpf_mem_alloc pcpu_ma;
>> +      

SNIP
>> +
>> +static inline bool htab_is_same_key(const void *key, const void *tgt, unsigned int key_size,
>> +                                   const struct btf_record *rec)
>> +{
>> +       if (!rec)
>> +               return !memcmp(key, tgt, key_size);
>> +       return is_same_dynptr_key(key, tgt, key_size, rec);
>> +}
>> +
>>  /* this lookup function can only be called with bucket lock taken */
>>  static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash,
>> -                                        void *key, u32 key_size)
>> +                                        void *key, u32 key_size,
>> +                                        const struct btf_record *record)
>>  {
>>         struct hlist_nulls_node *n;
>>         struct htab_elem *l;
>>
>>         hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
>> -               if (l->hash == hash && !memcmp(&l->key, key, key_size))
>> +               if (l->hash == hash && htab_is_same_key(l->key, key, key_size, record))
>>                         return l;
>>
>>         return NULL;
>> @@ -657,14 +769,15 @@ static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash
>>   */
>>  static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
>>                                                u32 hash, void *key,
>> -                                              u32 key_size, u32 n_buckets)
>> +                                              u32 key_size, u32 n_buckets,
>> +                                              const struct btf_record *record)
>>  {
>>         struct hlist_nulls_node *n;
>>         struct htab_elem *l;
>>
>>  again:
>>         hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
>> -               if (l->hash == hash && !memcmp(&l->key, key, key_size))
>> +               if (l->hash == hash && htab_is_same_key(l->key, key, key_size, record))
>>                         return l;
> If I'm reading this correctly the support for dynptr in map keys
> adds two map->key_record != NULL checks in the fast path,
> hence what you said in cover letter:
>
>> It seems adding dynptr key support in hash map degrades the lookup
>> performance about 12% and degrades the update performance about 7%. Will
>> investigate these degradation first.
>>
>> a) lookup
>> max_entries = 8K
>>
>> before:
>> 0:hash_lookup 72347325 lookups per sec
>>
>> after:
>> 0:hash_lookup 64758890 lookups per sec
> is surprising.
>
> Two conditional branches contribute to 12% performance loss?
> Something fishy.
> Try unlikely() to hopefully recover most of it.
> After analyzing 'perf report/annotate', of course.

Using unlikely/likely doesn't help much. It seems the big performance
gap is due to the inline of lookup_nulls_elem_raw() in
__htab_map_lookup_elem(). Still don't know the reason why
lookup_nulls_elem_raw() is not inlined after the change. After marking
the lookup_nulls_elem_raw() function as inline, the performance gap is
within ~2% for htab map lookup.  For htab_map_update/delete_elem(),  the
reason and the result is similar. Should I mark these two functions
(lookup_nulls_elem_raw and lookup_elem_raw) as inline in the next
revision, or should I leave it as is and try to fix the degradation in
another patch set ?

> Worst case we can specialize htab_map_gen_lookup() to
> call into different helpers.
> .


