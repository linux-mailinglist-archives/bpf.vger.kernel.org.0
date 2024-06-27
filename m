Return-Path: <bpf+bounces-33257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4091A8FD
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10F8B25354
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE713195F17;
	Thu, 27 Jun 2024 14:15:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76C2139A8
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497722; cv=none; b=MFJI2VK4REz30X8ygjL48GZx512i5N6wgE3nXfKurKHhpJZ76hPx3Wjh2msyiWSnYuO+EKFuTu6okkd4Io+lm+Q9r3wUFhogtDbp02lona2hnm8rLGaHqYxp58JnhjpMI8zLAYeSX5N5P0dJCk6+Q2oS3MWX0vIFOKmCw+LiUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497722; c=relaxed/simple;
	bh=29PNH4qw/21qEx3S3qc6wMVAccLZczLvQt4MjXdb6rA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mwfxVvG2zMZemse4I9hXoz3nmdqONVd7ZQyg4a+tr+zZd+J8bbuaKowEGk/jEUfNEnzqFp9t9ftKIx7+cp3ZlMBFng9NP5zJdJYI7yRyx6z4P9nfDA6XuVhVud0g3AhWu1/80/DgkP1l3uAHTghJY/fcZ0rjbSxOvETZnuNN5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W90vQ4nHvz4f3jrc
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 22:14:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8C5311A0181
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 22:15:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3hmDoc31m8QHoAQ--.59972S2;
	Thu, 27 Jun 2024 22:15:08 +0800 (CST)
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com>
 <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com>
 <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com>
 <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
 <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com>
 <CAADnVQ+2JoqJJvinPvKA+4Nm8F9rTrpXBdq4SmbTeq_9bw=mwg@mail.gmail.com>
 <a3eb33c4-b84f-5386-291c-c43d77b39c48@huaweicloud.com>
 <CAEf4BzZPno3m+G0v8ybxb=SMNbmqofCa5aa_Ukhh2OnZO9NxXw@mail.gmail.com>
 <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com>
 <CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com>
 <ce6f4648-9073-fd5b-a26b-187863e7070e@huaweicloud.com>
 <CAADnVQJ0gLSNNCnKeWMrHeoGG8DRG8kBoWxo3y0ubat-PgBcMg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <90a50937-cca2-101a-799a-daf65956e6c1@huaweicloud.com>
Date: Thu, 27 Jun 2024 22:15:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ0gLSNNCnKeWMrHeoGG8DRG8kBoWxo3y0ubat-PgBcMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3hmDoc31m8QHoAQ--.59972S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1kCrWrZrWxGFyftF18Xwb_yoW7tw4Dpa
	yFkFyUKrykXF98tr1IqanavFWUtw4rXr1UWr98ta43Gryq9rySqr48tFWj9F9xurnxtr4U
	trsFv393X3W8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 6/27/2024 11:34 AM, Alexei Starovoitov wrote:
> On Tue, Jun 25, 2024 at 9:30 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 6/26/2024 10:06 AM, Alexei Starovoitov wrote:
>>> On Mon, Jun 24, 2024 at 7:12 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> Hi,
>>>>
>>>> Sorry to resurrect the old thread to continue the discussion of APIs for
>>>> qp-trie.
>>>>

SNIP
>>>> (3) libbpf API
>>>>
>>>> Add bpf_map__get_next_sized_key() to high level APIs.
>>>>
>>>> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
>>>>                                            const void *cur_key,
>>>>                                            size_t cur_key_sz,
>>>>                                            void *next_key, size_t
>>>> *next_key_sz);
>>>>
>>>> Add
>>>> bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delete_sized_elem()/bpf_map_get_next_sized_key()
>>>> to low level APIs.
>>>> These APIs have already considered the case in which map has
>>>> variable-size value, so there will be no need to add other new APIs to
>>>> support such case.
>>>>
>>>> LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, size_t
>>>> key_sz,
>>>>                                          const void *value, size_t value_sz,
>>>>                                          __u64 flags);
>>>> LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, size_t
>>>> key_sz,
>>>>                                          void *value, size_t *value_sz,
>>>>                                          __u64 flags);
>>>> LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, size_t
>>>> key_sz,
>>>>                                          __u64 flags);
>>>> LIBBPF_API int bpf_map_get_next_sized_key(int fd,
>>>>                                           const void *key, size_t key_sz,
>>>>                                           void *next_key, size_t
>>>> *next_key_sz);
>>> I don't like this approach.
>>> It looks messy to me and solving one specific case where
>>> key/value is a blob of bytes.
>>> In other words it's taking api to pre-BTF days when everything
>>> was an opaque blob.
>> I see.
>>> I think we need a new object dynptr-like that is composable with other types.
>>> So that user can say that key is
>>> struct map_key {
>>>    long foo;
>>>    dynptr_like array;
>>>    int bar;
>>> };
>>>
>>> I'm not sure whether the existing bpf_dynptr fits exactly, but it's
>>> close enough.
>>> Such dynptr_like object should be able to be used as a string.
>>> And map should allow two such strings:
>>> struct map_key {
>>>    dynptr_like file_name;
>>>    dynptr_like dir;
>>> };
>>>
>>> and BTF for such map should see distinguish it as two strings
>>> and not as a single blob of bytes.
>>> The observability of bpf maps with bpftool should be able to print it.
>>>
>>> The use of such api will look the same from bpf prog and from user space.
>>> bpf prog can do:
>>>
>>>  struct map_key key;
>>>  bpf_dynptr_from_whatever(&key.file_name, ...);
>>>  bpf_dynptr_from_whatever(&key.dir, ...);
>>>  bpf_map_lookup_elem(map, &key);
>>>
>>> and similar from user space.
>>> bpf_dynptr_user will be a struct with size and a pointer.
>>> The existing sys_bpf commands will stay as-is.
>>> The user space will do:
>>>
>>> struct map_key {
>>>    bpf_dynptr_user file_name;
>>>    bpf_dynptr_user dir;
>>> } key;
>>>
>>> key.dir.size = 1000;
>>> key.dir.ptr = malloc(1000);
>>> ...
>>> bpf_map_lookup_elem( &key); // existing syscall cmd
>>>
>>> In this case sizeof(struct map_key) == sizeof(bpf_dynptr_user) * 2 == 32
>>>
>>> Both for bpf prog and for user space.
>> It seems the idea could be implemented through both hash-table and qp-trie.
> yes. I think so.
>
>> For hash-table, firstly we need to keep each offset of these dynptr_like
>> objects. During update operation, we need to calculate the hash for each
>> dynptr_like object and combine these hashes into a new hash. During
>> lookup, we need to compare each dynptr_like object alone to check
>> whether or not it is the same as the target element.
> yep.
> We already have btf_field/btf_record infra that describe map value.
> They can be used to describe map key just as well.
> The tricky part would be to make the whole hash of dynptr-s and compare
> quick enough without hurting common use case of traditional hash map.
>
>> For qp-trie, we also need to keep the offset for each dynptr_like
>> object. During update operation, we should marshal the passed key into a
>> plain blob and save the plain blob in qp-trie. During lookup, we don't
>> marshal the input key, instead we lookup up the qp-trie by using each
>> field in the map key step-wise.
> yes. exactly.
>
>> However for get_next_key operation, we
>> need to unmarshal the plain blob into a dynptr_like object.
> hmm. I haven't thought about get_next_key for qp-trie.
> A bit tricky indeed.
>
>> For the two hypothetical implementations above, I think the lookup
>> performance may be better than qp-trie and its memory usage will not be
>> bad, so I prefer to support dynptr_like object in hash map key first. WDYT ?
> I'd actually do it with qp-trie first.
> bpftrace is using strings as keys a lot and some scripts use "multi key" too
> (like string plus int)
> Currently bpftrace sizes up hash key_size to max and it's not efficient.
> I think qp-trie with multi-key support would work very well for that use case.
>
> iirc early version of qp-trie was limited to nul-terminated strings
> as a key, but I believe it's possible to tweak the algorithm to support
> binary key. Then what you describing above how lookup/update of a key
> will work nicely.
> I also suspect that lookup will be much faster in qp-trie compared
> to hash table, hence that's what I would implement first.

The first version of qp-trie had already supported to use arbitrary
bytes as key [1]. The lookup performance comparison between qp-trie and
hash-table varies according to the benchmark result in the early
patch-set [1]. For normal strings (e.g., strings in BTF or kallsyms),
hash-table performance better. I will try whether or not it is possible
to work out a hack version for both hash-table and qp-trie to compare
the lookup performance first.

[1]:
https://lore.kernel.org/bpf/20220726130005.3102470-1-houtao1@huawei.com/


