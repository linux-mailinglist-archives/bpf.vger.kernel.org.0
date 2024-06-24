Return-Path: <bpf+bounces-32917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C48914FA2
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 16:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4577C1C221D9
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEDF142648;
	Mon, 24 Jun 2024 14:12:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF513D62B
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238363; cv=none; b=aFWqNCEXdkBRVRRaESrrAn7WKvM4dUL7+gUFQZcwwoNDhv0aQct7nVv5lkf+BDz2rOnG6x0RwT84gmfqE7IsZvVowSqy/w1Pqjl7yRx2Itnrx0t4AS/W2ixP04+L8CFmTUY3BL6I2Tc/b2ug0KJ4ehmyIDz8YoOnPT/rcmY6CNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238363; c=relaxed/simple;
	bh=DTopYDAtvtPPdUO93zMN7KvysCwj1UoShWxSEXJK2OQ=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GM7YPyhF7DRMirdTml9sCYw7YrlWpvW4yjjCCtJ9J0nyYao9EbjJUw4JCzij5FhJUa70prKCosR6J/+mG7sIVpkZB//PGmeDo4NWY773qzRZJjsT2StFKECO80eiphqU7eRJSLLDPRHuqvQnqLOsjl6zUNIQP6T/X0ONCDJsvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W78zt2XD4z4f3jHb
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 22:12:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 13CA61A0170
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 22:12:37 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDn9mDRfnlm60_UAA--.61615S2;
	Mon, 24 Jun 2024 22:12:37 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: APIs for qp-trie //Re: Question: Is it OK to assume the address of
 bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
Message-ID: <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com>
Date: Mon, 24 Jun 2024 22:12:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZPno3m+G0v8ybxb=SMNbmqofCa5aa_Ukhh2OnZO9NxXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDn9mDRfnlm60_UAA--.61615S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF15trWUKFWkGr15WrWUtwb_yoW7Cw1fpF
	18Jr1UJryUJr48Jr1UJr4UJryUJr1UJw1UJryDJFyUJr1DXr1jqr1UXF1jgr15Ar4kJr1U
	tr1Utr1UZr1UArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Sorry to resurrect the old thread to continue the discussion of APIs for
qp-trie.

On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> On Tue, Aug 22, 2023 at 6:12 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>

SNIP

>> updated to allow using dynptr as map key for qp-trie.
>>> And that's the problem I just mentioned.
>>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
>>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
>> Sorry for misunderstanding your reply. But before switch to the kfuncl
>> way, could you please point me to some code or function which shows the
>> specialty of PTR_MAP_KEY ?
>>
>>
> Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> logic assumes that there is associated struct bpf_map * pointer from
> which we know fixed-sized key length.
>
> But getting back to the topic at hand. I vaguely remember discussion
> we had, but it would be good if you could summarize it again here to
> avoid talking past each other. What is the bpf_map_ops changes you
> were thinking to do? How bpf_attr will look like? How BPF-side API for
> lookup/delete/update will look like? And then let's go from there?
> Thanks!
>
> .

The APIs for qp-trie are composed of the followings 5 parts:

(1) map definition for qp-trie

The key is bpf_dynptr and map_extra specifies the max length of key.

struct {
    __uint(type, BPF_MAP_TYPE_QP_TRIE);
    __type(key, struct bpf_dynptr);
    __type(value, unsigned int);
    __uint(map_flags, BPF_F_NO_PREALLOC);
    __uint(map_extra, 1024);
} qp_trie SEC(".maps");

(2) bpf_attr

Add key_sz & next_key_sz into anonymous struct to support map with
variable-size key. We could add value_sz if the map with variable-size
value is supported in the future.

        struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
                __u32           map_fd;
                __aligned_u64   key;
                union {
                        __aligned_u64 value;
                        __aligned_u64 next_key;
                };
                __u64           flags;
                __u32           key_sz;
                __u32           next_key_sz;
        };

(3) libbpf API

Add bpf_map__get_next_sized_key() to high level APIs.

LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
                                           const void *cur_key,
                                           size_t cur_key_sz,
                                           void *next_key, size_t
*next_key_sz);

Add
bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delete_sized_elem()/bpf_map_get_next_sized_key()
to low level APIs.
These APIs have already considered the case in which map has
variable-size value, so there will be no need to add other new APIs to
support such case.

LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, size_t
key_sz,
                                         const void *value, size_t value_sz,
                                         __u64 flags);
LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, size_t
key_sz,
                                         void *value, size_t *value_sz,
                                         __u64 flags);
LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, size_t
key_sz,
                                         __u64 flags);
LIBBPF_API int bpf_map_get_next_sized_key(int fd,
                                          const void *key, size_t key_sz,
                                          void *next_key, size_t
*next_key_sz);

(4) bpf_map_ops

Update the arguments for map_get_next_key()/map_lookup_elem_sys_only().
Add map_update_elem_sys_only()/map_delete_elem_sys_only() into bpf_map_ops.

Updating map_update_elem()/map_delete_elem() is also fine, but it may
introduce too much churn and need to pass map->key_size to these APIs
for existing callers.

struct bpf_map_ops {
        int (*map_get_next_key)(struct bpf_map *map, void *key, u32
key_size, void *next_key, u32 *next_key_size);
        void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void
*key, u32 key_size);

        int (*map_update_elem_sys_only)(struct bpf_map *map, void *key,
u32 key_size, void *value, u64 flags);
        int (*map_delete_elem_sys_only)(struct bpf_map *map, void *key,
u32 key_size);
};

(5) API for bpf program

Instead of supporting bpf_dynptr as ARG_PTR_TO_MAP_KEY, will add three
new kfuncs to support lookup/update/deletion operation on qp-trie.


