Return-Path: <bpf+bounces-33120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67391763B
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 04:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B601F23B0F
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43290282FD;
	Wed, 26 Jun 2024 02:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FF208A7
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369702; cv=none; b=Mo/7S4nr9Gfy/u9uz2Qk34+u4HKq3pAXMJq39DASMPrIuP40Eht4dG794HvusaUWxO4xjHWIzKaUTfTplUk2IaMoPLgfEJQX9TDFCMhxekH80pzgBcZTtKNpuPKiHnAGBSJCvcVKmpu/xgLJMhKy4FTdGdalNz2x8FxrsBRrTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369702; c=relaxed/simple;
	bh=RIz2qwFEbPRdueXyFgvYh8wEZtYcU1erJkWHWGVZ3TI=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MCgChkGrB/plCM82cLu/LZd0kDN0pV1mfjOjpNeJs5UhCpxLBFWMB2OhrAZlK721LfoChW4oSbiVcvI6RFvbFo85LTF3R7HnWAJl8wmZZ0LG1zQxudSwjyfmdjhCSaMVbQknHdc80DuGqPa2ySlYMStWuuFr/jrmYhrU1e+AC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W85YZ25F0z4f3jLV
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 10:41:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 616B61A0170
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 10:41:29 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBHVF7Vf3tmyb5fAQ--.38513S2;
	Wed, 26 Jun 2024 10:41:29 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
 <CAEf4BzYWWrrEGcHjVSOMeBvsO0ymk56S4iMG_WSwQJc6rxwmzw@mail.gmail.com>
Message-ID: <5d835551-9124-4fcc-bdb7-74828c55273d@huaweicloud.com>
Date: Wed, 26 Jun 2024 10:41:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYWWrrEGcHjVSOMeBvsO0ymk56S4iMG_WSwQJc6rxwmzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBHVF7Vf3tmyb5fAQ--.38513S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF15JryDGw4DZF1rtF45trb_yoWxAr4kpF
	W8GFykKrWvy34Yqr10qw4fJrWFqw45Kw15GF98Jay5GryDur97Zr48GFZ8CrZxurnrCrsI
	qr4qqrWfWw18ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi Andrii,

On 6/25/2024 11:55 AM, Andrii Nakryiko wrote:
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
> I'm not sure we need `struct bpf_dynptr` as the key type. We can just
> say that key_size has to be zero, and actual keys are variable-sized.
>
> Alternatively, we can treat key_size as "maximum key size", any
> attempt to use longer keys will be rejected.
>
> But in either case "struct bpf_dynptr" as key type seems wrong to me.

The use of bpf_dynptr services two purposes:
(1) tell bpf subsystem that qp-trie is a map with variable-size key.
If don't use bpf_dynptr, the purpose can be accomplished by checking the
map_type.

(2) facilitate the dump of key in bpftool when btf is available
when dump the key & value tuple through btf dump, a btf_type is needed
for the key. Because the key is variable-size, so neither using void
type (key_size =0 case)  nor using the type with the maximal key size
are appropriate. But the use of bpf_dynptr can also be avoided, if we
add a special case for qp-trie when dumping its key.

Setting key_size as zero seems weird, because qp-trie has key. I prefer
to set key_size as the maximal key size and set the btf_key_id as 0.
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
> Yep, this seems inevitable. And yes, value_sz seems like a reasonable
> thing to have. It might be an option/flag whether QP-trie has
> fixed-sized or variable-sized value, I guess. But we can get there
> after all the other things are figured out.

Do we need to add value_sz with the qp-trie patch-set or later ? I
prefer to leave it as the future work.
>
>> (3) libbpf API
>>
>> Add bpf_map__get_next_sized_key() to high level APIs.
> All the *_sized_* names are... unfortunate, tbh. I'm not sure what's
> the right naming, but "sized" in the middle doesn't seem that. I think
> it should be a uniform suffix. Maybe something like "_varsz",
> "_varlen", or at least "_sized" (but as a suffix)?...

I see. I have considered bpf_map_update_vs_key_elem() or similar, but I
changed it to _sized later. Because bpf_map_update_sized_elem() not only
supports variable-sized key, but also supports fixed-size key,  so I
think it is a bit weird that the high level API bpf_map__update_elem()
invokes bpf_map__update_elem_varlen() in turn to update element for map
with fixed-size key. I will try to add _sized as a suffix in the formal
patch set.
>
>> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
>>                                            const void *cur_key,
>>                                            size_t cur_key_sz,
>>                                            void *next_key, size_t
>> *next_key_sz);

SNIP
>>
>>
>>
>> (4) bpf_map_ops
>>
>> Update the arguments for map_get_next_key()/map_lookup_elem_sys_only().
>> Add map_update_elem_sys_only()/map_delete_elem_sys_only() into bpf_map_ops.
>>
>> Updating map_update_elem()/map_delete_elem() is also fine, but it may
>> introduce too much churn and need to pass map->key_size to these APIs
>> for existing callers.
>>
> We can have a protocol that key_size and value_size might be zero for
> fixed-sized maps, in which case key/value size is not
> checked/enforced, right?

Yes. We could pass 0 as key_size for the existing callers of
->map_update_elem()/->map_delete_elem()
>
> I think it's much better to keep one universal interface that works
> for both fixed- and variable-sized map (especially that we can
> technically have maps where fixed-sized or variable-sized is a matter
> of choice and some map_flag value).

I see your point. Will update
map_update_elem()/map_delete_elem()/map_lookup_elem() instead.
>
>> struct bpf_map_ops {
>>         int (*map_get_next_key)(struct bpf_map *map, void *key, u32
>> key_size, void *next_key, u32 *next_key_size);
>>         void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void
>> *key, u32 key_size);
>>
>>         int (*map_update_elem_sys_only)(struct bpf_map *map, void *key,
>> u32 key_size, void *value, u64 flags);
>>         int (*map_delete_elem_sys_only)(struct bpf_map *map, void *key,
>> u32 key_size);
>> };
>>
>> (5) API for bpf program
>>
>> Instead of supporting bpf_dynptr as ARG_PTR_TO_MAP_KEY, will add three
>> new kfuncs to support lookup/update/deletion operation on qp-trie.
>>
> hopefully those won't be qp-trie specific? Also, are you planning to
> have only key variable-sized or value as well?

Will make these kfuncs be available for all maps with variable-size key
support. I think it is better to have both variable-sized key and value
in these kfuncs. WDYT ?
>


