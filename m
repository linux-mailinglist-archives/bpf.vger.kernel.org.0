Return-Path: <bpf+bounces-33126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46826917748
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 06:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCABE28347D
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B77136E3E;
	Wed, 26 Jun 2024 04:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4CF2BD18
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376224; cv=none; b=g8yPE+9nBphuToOxAgmYO9nNa4uMv9OzZhtf2uaK6lWRl3RjHXwsHdtSrDQyO9Sf55dWH6g8bfJOc44tuS9+T9k6N2gz+WUFomMawQMUNIOcdFeCTPX+E5TFzPMqnt5uHljUy13Nr+PzE2x4Kge+E3T4zD9UHJBOZG8/nmi7kZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376224; c=relaxed/simple;
	bh=ZLVIt51tebDxWZ4QaSHgztTAT2XqG7wQS/u1ym0JIIw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WomKZyYSpjFWYK8I594vDA7IZ+20YSk3TA2e0yeFWG9upZM+lXAoC2zAtsYBH0bqBJn10Ml3IB9m8GVFHLMXtBRg/eAhe8Kyw9ku0gjmAkxyqU7CJpZBx2jItE6rslpQHeDdXxw3cbyHxcQLsZ4+oRvoBQX/ji4tXNxd5zl7H+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W87z51552z4f3jLh
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 12:30:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3E7A01A0568
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 12:30:16 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAnnHhUmXtmGVRsAQ--.52162S2;
	Wed, 26 Jun 2024 12:30:16 +0800 (CST)
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ce6f4648-9073-fd5b-a26b-187863e7070e@huaweicloud.com>
Date: Wed, 26 Jun 2024 12:30:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAnnHhUmXtmGVRsAQ--.52162S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF15JryDXrykArWfWF45KFg_yoW7Kry3pF
	WFkFy7KFWDXry5tr1vqa1fArWrtw4Fgw15Cr98ta45GFyq934IqF48KFWUur9xurn7Jr47
	trsFqr93Xa18AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 6/26/2024 10:06 AM, Alexei Starovoitov wrote:
> On Mon, Jun 24, 2024 at 7:12 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> Sorry to resurrect the old thread to continue the discussion of APIs for
>> qp-trie.
>>
>> On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
>>> On Tue, Aug 22, 2023 at 6:12 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> Hi,
>>>>
>> SNIP
>>
>>>> updated to allow using dynptr as map key for qp-trie.
>>>>> And that's the problem I just mentioned.
>>>>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
>>>>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
>>>> Sorry for misunderstanding your reply. But before switch to the kfuncl
>>>> way, could you please point me to some code or function which shows the
>>>> specialty of PTR_MAP_KEY ?
>>>>
>>>>
>>> Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
>>> logic assumes that there is associated struct bpf_map * pointer from
>>> which we know fixed-sized key length.
>>>
>>> But getting back to the topic at hand. I vaguely remember discussion
>>> we had, but it would be good if you could summarize it again here to
>>> avoid talking past each other. What is the bpf_map_ops changes you
>>> were thinking to do? How bpf_attr will look like? How BPF-side API for
>>> lookup/delete/update will look like? And then let's go from there?
>>> Thanks!
>>>
>>> .
>> The APIs for qp-trie are composed of the followings 5 parts:
>>
>> (1) map definition for qp-trie
>>
>> The key is bpf_dynptr and map_extra specifies the max length of key.
>>
>> struct {
>>     __uint(type, BPF_MAP_TYPE_QP_TRIE);
>>     __type(key, struct bpf_dynptr);
>>     __type(value, unsigned int);
>>     __uint(map_flags, BPF_F_NO_PREALLOC);
>>     __uint(map_extra, 1024);
>> } qp_trie SEC(".maps");
>>
>> (2) bpf_attr
>>
>> Add key_sz & next_key_sz into anonymous struct to support map with
>> variable-size key. We could add value_sz if the map with variable-size
>> value is supported in the future.
>>
>>         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>>                 __u32           map_fd;
>>                 __aligned_u64   key;
>>                 union {
>>                         __aligned_u64 value;
>>                         __aligned_u64 next_key;
>>                 };
>>                 __u64           flags;
>>                 __u32           key_sz;
>>                 __u32           next_key_sz;
>>         };
>>
>> (3) libbpf API
>>
>> Add bpf_map__get_next_sized_key() to high level APIs.
>>
>> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
>>                                            const void *cur_key,
>>                                            size_t cur_key_sz,
>>                                            void *next_key, size_t
>> *next_key_sz);
>>
>> Add
>> bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delete_sized_elem()/bpf_map_get_next_sized_key()
>> to low level APIs.
>> These APIs have already considered the case in which map has
>> variable-size value, so there will be no need to add other new APIs to
>> support such case.
>>
>> LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, size_t
>> key_sz,
>>                                          const void *value, size_t value_sz,
>>                                          __u64 flags);
>> LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, size_t
>> key_sz,
>>                                          void *value, size_t *value_sz,
>>                                          __u64 flags);
>> LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, size_t
>> key_sz,
>>                                          __u64 flags);
>> LIBBPF_API int bpf_map_get_next_sized_key(int fd,
>>                                           const void *key, size_t key_sz,
>>                                           void *next_key, size_t
>> *next_key_sz);
> I don't like this approach.
> It looks messy to me and solving one specific case where
> key/value is a blob of bytes.
> In other words it's taking api to pre-BTF days when everything
> was an opaque blob.

I see.
> I think we need a new object dynptr-like that is composable with other types.
> So that user can say that key is
> struct map_key {
>    long foo;
>    dynptr_like array;
>    int bar;
> };
>
> I'm not sure whether the existing bpf_dynptr fits exactly, but it's
> close enough.
> Such dynptr_like object should be able to be used as a string.
> And map should allow two such strings:
> struct map_key {
>    dynptr_like file_name;
>    dynptr_like dir;
> };
>
> and BTF for such map should see distinguish it as two strings
> and not as a single blob of bytes.
> The observability of bpf maps with bpftool should be able to print it.
>
> The use of such api will look the same from bpf prog and from user space.
> bpf prog can do:
>
>  struct map_key key;
>  bpf_dynptr_from_whatever(&key.file_name, ...);
>  bpf_dynptr_from_whatever(&key.dir, ...);
>  bpf_map_lookup_elem(map, &key);
>
> and similar from user space.
> bpf_dynptr_user will be a struct with size and a pointer.
> The existing sys_bpf commands will stay as-is.
> The user space will do:
>
> struct map_key {
>    bpf_dynptr_user file_name;
>    bpf_dynptr_user dir;
> } key;
>
> key.dir.size = 1000;
> key.dir.ptr = malloc(1000);
> ...
> bpf_map_lookup_elem( &key); // existing syscall cmd
>
> In this case sizeof(struct map_key) == sizeof(bpf_dynptr_user) * 2 == 32
>
> Both for bpf prog and for user space.

It seems the idea could be implemented through both hash-table and qp-trie.

For hash-table, firstly we need to keep each offset of these dynptr_like
objects. During update operation, we need to calculate the hash for each
dynptr_like object and combine these hashes into a new hash. During
lookup, we need to compare each dynptr_like object alone to check
whether or not it is the same as the target element.

For qp-trie, we also need to keep the offset for each dynptr_like
object. During update operation, we should marshal the passed key into a
plain blob and save the plain blob in qp-trie. During lookup, we don't
marshal the input key, instead we lookup up the qp-trie by using each
field in the map key step-wise. However for get_next_key operation, we
need to unmarshal the plain blob into a dynptr_like object.

For the two hypothetical implementations above, I think the lookup
performance may be better than qp-trie and its memory usage will not be
bad, so I prefer to support dynptr_like object in hash map key first. WDYT ?


>
>
> .


