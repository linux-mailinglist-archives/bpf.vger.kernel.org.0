Return-Path: <bpf+bounces-9591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472B7995F8
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 04:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5D91C20B91
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 02:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226915A8;
	Sat,  9 Sep 2023 02:39:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD80629
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 02:39:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C7D1FF0
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 19:39:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RjHHP1RJzz4f3nb1
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 10:39:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3SdnP2vtku50CAA--.2877S2;
	Sat, 09 Sep 2023 10:39:14 +0800 (CST)
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
 <3b6e3e7e-9d4f-7939-c8c0-edb266bc3758@huaweicloud.com>
 <CAEf4BzY1amO0NErRAFSDXou4HUqTuq+kphHfj-t4VMXv9qXgcg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <31c832c6-546b-75e3-34e1-1dddde7c217f@huaweicloud.com>
Date: Sat, 9 Sep 2023 10:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzY1amO0NErRAFSDXou4HUqTuq+kphHfj-t4VMXv9qXgcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3SdnP2vtku50CAA--.2877S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW3Ar13tr1xGr43Wry8Xwb_yoWxJF18pF
	WrGF95KrZ8XFyjyw1j9w45X3yFqr1vqr1UJ39xJa4rCr909ryxJF18KFWDurW3Cr1kGw42
	yrWqy34fX34DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 9/9/2023 6:34 AM, Andrii Nakryiko wrote:
> On Wed, Aug 30, 2023 at 11:29 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi Andrii,
>>
>> On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
>>> On Tue, Aug 22, 2023 at 6:12 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> SNIP
>>>>>> Yes. bpf prog will use dynptr as the map key. The bpf program will use
>>>>>> the same map helpers as hash map to operate on qp-trie and the verifier
>>>>>> will be updated to allow using dynptr as map key for qp-trie.
>>>>> And that's the problem I just mentioned.
>>>>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
>>>>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
>>>> Sorry for misunderstanding your reply. But before switch to the kfunc
>>>> way, could you please point me to some code or function which shows the
>>>> specialty of PTR_MAP_KEY ?
>>>>
>>>>
>>> Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
>>> logic assumes that there is associated struct bpf_map * pointer from
>>> which we know fixed-sized key length.
>> Thanks for the information. Will check that.
>>> But getting back to the topic at hand. I vaguely remember discussion
>>> we had, but it would be good if you could summarize it again here to
>>> avoid talking past each other. What is the bpf_map_ops changes you
>>> were thinking to do? How bpf_attr will look like? How BPF-side API for
>>> lookup/delete/update will look like? And then let's go from there?
>>> Thanks!
>> Sorry for the late reply. I am a bit distracted by other work this week.
>>
>> For bpf_attr, a new field 'dynkey_size' is added to support
>> BPF_MAP_{LOOKUP/UPDATE/DELETE}_ELEM and BPF_MAP_GET_NEXT_KEY on qp-trie
>> as shown below:
>>
>> struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>>         __u32           map_fd;
>>         __aligned_u64   key;
>>         union {
>>                 __aligned_u64 value;
>>                 __aligned_u64 next_key;
>>         };
>>         __u64           flags;
>>         __u32           dynkey_size;    /* input/output for
>>                                          * BPF_MAP_GET_NEXT_KEY. input
>>                                          * only for other commands.
>>                                          */
> hm.. I wonder if it would be more elegant to add `key_size` and
> `value_size`, and allow to specify it (optionally) even for maps that
> have fixed-size keys and values. Return error if expected key/value
> size doesn't match map definition. From libbpf side, libbpf can be
> smart to not set it on older kernels (or if user didn't provide this
> information). But for bpf_map__lookup_elem() and other higher-level
> APIs, we should have all this information available.

I am OK with the addition of key_size and value_size in bpf_attr and I
will try to do that. After the addition, bpf syscall will also need to
check these two size for fixed-size map, but I am a bit worried about
the compatibility of libbpf and kernel for fixed-size map. There are
three possible cases:
1) new libbpf and older kernel. key_size and value_size will be ignored
by older kernel, because the definition of bpf_attr in older kernel is
shorter. It will be OK.
2) old libbpf and new kernel.  key_size and value_size will be zero for
kernel, because libbpf doesn't pass these values. We can use 0 as an
unspecified size, but for some map (e.g., bloom-filter) zero key_size is
also valid, so do we need to introduce a feature bit to tell both
key_size and value_size are valid ?
3) matched libbpf and kernel. Same problem as 2): use zero as an
unspecified size or an extra flag is needed.

I totally missed these higher-level APIs with both key_sz and value_sz. 
It seems these high-level also need updates to support qp-trie (e.g.,
bpf_map__get_next_key, because the size of current key and next key are
different).
>
>
>> };
>>
>> And 4 new APIs are added in libbpf to support basic operations on qp-trie:
>>
>> LIBBPF_API int bpf_map_update_dynkey_elem(int fd, const void *key,
>> unsigned int key_size, const void *value, __u64 flags);
>> LIBBPF_API int bpf_map_lookup_dynkey_elem(int fd, const void *key,
>> unsigned int key_size, void *value);
>> LIBBPF_API int bpf_map_delete_dynkey_elem(int fd, const void *key,
>> unsigned int key_size);
>> LIBBPF_API int bpf_map_get_next_dynkey(int fd, const void *key, void
>> *next_key, unsigned int *key_size);
>>
>> About 3 weeks again, I have used the lowest bit of key pointer in
>> .map_lookup_elem/.map_update_elem/.map_delete_elem to distinguish
>> between bpf_user_dynkey-typed key from syscall and bpf_dynptr_kern-typed
>> key from bpf program. The definition of bpf_user_dynkey and its
>> allocation method are shown below. bpf syscall uses it to allocate
>> variable-sized key and passes it to qp-trie.
>>
>> /* Allocate bpf_user_dynkey and its data together */
>> struct bpf_user_dynkey {
>>         unsigned int size;
>>         void *data;
>> };
>>
>> static void *bpf_new_user_dynkey(unsigned int size)
>> {
>>         struct bpf_user_dynkey *dynkey;
>>         size_t total;
>>
>>         total = round_up(sizeof(*dynkey) + size, 2);
>>         dynkey = kvmalloc(total, GFP_USER | __GFP_NOWARN);
>>         if (!dynkey)
>>                 return ERR_PTR(-ENOMEM);
>>
>>         dynkey->size = size;
>>         dynkey->data = &dynkey[1];
>>         return (void *)((long)dynkey | BPF_USER_DYNKEY_MARK);
>> }
>>
>>
>> After Alexei suggested that bit hack is only OK for memory or
>> performance reason, I'm planning to add 2 new callbacks in bpf_map_ops
>> to support update/delete operations in bpf syscall as shown below, but I
>> have tried it yet.
>>
>> /* map is generic key/value storage optionally accessible by eBPF
>> programs */
>> struct bpf_map_ops {
>>         /* funcs callable from userspace (via syscall) */
>>         /* ...... */
>>         void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
> a bit confused, did you mean to also have key_size as a third argument here?

Ah, I am planning to pass bpf_user_dynkey to these newly-added APIs and
bpf_user_dynke::size is the size of the key. Passing a plain pointer and
key size is also fine.
>
>>         long (*map_update_elem_sys_only)(struct bpf_map *map, void *key,
>> void *value, u64 flags);
>>         long (*map_delete_elem_sys_only)(struct bpf_map *map, void *key);
>>         /* ...... */
>> };
>>
>>
>>
>>
>>
>>
>>


