Return-Path: <bpf+bounces-34916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F673932710
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 15:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F975B23BF7
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE3B19AA7A;
	Tue, 16 Jul 2024 13:05:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77820524B4
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135120; cv=none; b=tzpIaCyPBSiceqQkpzDNzyyPEj7Z/UKjSVNcouzUyTv8w4P3nrDHNFX2PkMmSsS7/dlm2zv1XsF/lwHnrh3t7pSuI7Xi1bilZYrsuqibDQLHndv0+8wsvDTWsA5O5Ybg4uAPyV8yfN9d7htHVnChRkho33cEVjqebPkyfi/CsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135120; c=relaxed/simple;
	bh=FKkmO5ddVvVMH3W3nKNhptnMUq2oH8FmWaqzj1Fm7J4=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OWdfSIt6Ga1Zk2yHwusVNROliTWVjLWjfska0i2gRDwwXfpMnIp3dBGqiSR5sjQ/FbbEhl/kumNFzyi/A12hQuClkfawn/ar6aSxx/9C43U2lRMGM6buwPPBycL4ZRzEvPuvk/LWbDYPOXcIpfE8usFLzoyoPyTcqMuZZAo2Oi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WNfRy44yNz4f3jkK
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 21:05:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 827BE1A016E
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 21:05:10 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAXdg0BcJZm6+EwAQ--.22680S2;
	Tue, 16 Jul 2024 21:05:08 +0800 (CST)
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
From: Hou Tao <houtao@huaweicloud.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
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
 <90a50937-cca2-101a-799a-daf65956e6c1@huaweicloud.com>
Message-ID: <3bf6cbb1-45f3-a338-81b8-28275526af70@huaweicloud.com>
Date: Tue, 16 Jul 2024 21:05:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <90a50937-cca2-101a-799a-daf65956e6c1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAXdg0BcJZm6+EwAQ--.22680S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tw18WF48KF1UurWDGw1rZwb_yoW8Wr4rKo
	WfGFsxGa1fAr1UKryDKw1Iqr1fJ3WUGFykGryjgwn3tw4Yg3Wjy3y7Jas5Aay2vFy8Gr1D
	C34UJ34DuFyfWF1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYw7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 6/27/2024 10:15 PM, Hou Tao wrote:
> Hi,
>
> On 6/27/2024 11:34 AM, Alexei Starovoitov wrote:
>> On Tue, Jun 25, 2024 at 9:30 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>
>>> On 6/26/2024 10:06 AM, Alexei Starovoitov wrote:
>>>> On Mon, Jun 24, 2024 at 7:12 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>> Hi,
>>>>>
>>>>> Sorry to resurrect the old thread to continue the discussion of APIs for
>>>>> qp-trie.
>>>>>
> SNIP
>>>>> (3) libbpf API
>>>>>
>>>>> Add bpf_map__get_next_sized_key() to high level APIs.
>>>>>
>>>>> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
>>>>>                                            const void *cur_key,
>>>>>                                            size_t cur_key_sz,
>>>>>                                            void *next_key, size_t
>>>>> *next_key_sz);
>>>>>
>>>>> Add
>>>>> bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delete_sized_elem()/bpf_map_get_next_sized_key()
>>>>> to low level APIs.
>>>>> These APIs have already considered the case in which map has
>>>>> variable-size value, so there will be no need to add other new APIs to
>>>>> support such case.
>>>>>
>>>>> LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, size_t
>>>>> key_sz,
>>>>>                                          const void *value, size_t value_sz,
>>>>>                                          __u64 flags);
>>>>> LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, size_t
>>>>> key_sz,
>>>>>                                          void *value, size_t *value_sz,
>>>>>                                          __u64 flags);
>>>>> LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, size_t
>>>>> key_sz,
>>>>>                                          __u64 flags);
>>>>> LIBBPF_API int bpf_map_get_next_sized_key(int fd,
>>>>>                                           const void *key, size_t key_sz,
>>>>>                                           void *next_key, size_t
>>>>> *next_key_sz);
>>>> I don't like this approach.
>>>> It looks messy to me and solving one specific case where
>>>> key/value is a blob of bytes.
>>>> In other words it's taking api to pre-BTF days when everything
>>>> was an opaque blob.
>>> I see.
>>>> I think we need a new object dynptr-like that is composable with other types.
>>>> So that user can say that key is
>>>> struct map_key {
>>>>    long foo;
>>>>    dynptr_like array;
>>>>    int bar;
>>>> };
>>>>
>>>> I'm not sure whether the existing bpf_dynptr fits exactly, but it's
>>>> close enough.
>>>> Such dynptr_like object should be able to be used as a string.
>>>> And map should allow two such strings:
>>>> struct map_key {
>>>>    dynptr_like file_name;
>>>>    dynptr_like dir;
>>>> };
>>>>
>>>> and BTF for such map should see distinguish it as two strings
>>>> and not as a single blob of bytes.
>>>> The observability of bpf maps with bpftool should be able to print it.
>>>>
>>>> The use of such api will look the same from bpf prog and from user space.
>>>> bpf prog can do:
>>>>
>>>>  struct map_key key;
>>>>  bpf_dynptr_from_whatever(&key.file_name, ...);
>>>>  bpf_dynptr_from_whatever(&key.dir, ...);
>>>>  bpf_map_lookup_elem(map, &key);
>>>>
>>>> and similar from user space.
>>>> bpf_dynptr_user will be a struct with size and a pointer.
>>>> The existing sys_bpf commands will stay as-is.
>>>> The user space will do:
>>>>
>>>> struct map_key {
>>>>    bpf_dynptr_user file_name;
>>>>    bpf_dynptr_user dir;
>>>> } key;
>>>>
>>>> key.dir.size = 1000;
>>>> key.dir.ptr = malloc(1000);
>>>> ...
>>>> bpf_map_lookup_elem( &key); // existing syscall cmd
>>>>
>>>> In this case sizeof(struct map_key) == sizeof(bpf_dynptr_user) * 2 == 32
>>>>
>>>> Both for bpf prog and for user space.
>>> It seems the idea could be implemented through both hash-table and qp-trie.
>> yes. I think so.
>>
>>> For hash-table, firstly we need to keep each offset of these dynptr_like
>>> objects. During update operation, we need to calculate the hash for each
>>> dynptr_like object and combine these hashes into a new hash. During
>>> lookup, we need to compare each dynptr_like object alone to check
>>> whether or not it is the same as the target element.
>> yep.
>> We already have btf_field/btf_record infra that describe map value.
>> They can be used to describe map key just as well.
>> The tricky part would be to make the whole hash of dynptr-s and compare
>> quick enough without hurting common use case of traditional hash map.
>>
>>> For qp-trie, we also need to keep the offset for each dynptr_like
>>> object. During update operation, we should marshal the passed key into a
>>> plain blob and save the plain blob in qp-trie. During lookup, we don't
>>> marshal the input key, instead we lookup up the qp-trie by using each
>>> field in the map key step-wise.
>> yes. exactly.
>>
>>> However for get_next_key operation, we
>>> need to unmarshal the plain blob into a dynptr_like object.
>> hmm. I haven't thought about get_next_key for qp-trie.
>> A bit tricky indeed.
>>
>>> For the two hypothetical implementations above, I think the lookup
>>> performance may be better than qp-trie and its memory usage will not be
>>> bad, so I prefer to support dynptr_like object in hash map key first. WDYT ?
>> I'd actually do it with qp-trie first.
>> bpftrace is using strings as keys a lot and some scripts use "multi key" too
>> (like string plus int)
>> Currently bpftrace sizes up hash key_size to max and it's not efficient.
>> I think qp-trie with multi-key support would work very well for that use case.
>>
>> iirc early version of qp-trie was limited to nul-terminated strings
>> as a key, but I believe it's possible to tweak the algorithm to support
>> binary key. Then what you describing above how lookup/update of a key
>> will work nicely.
>> I also suspect that lookup will be much faster in qp-trie compared
>> to hash table, hence that's what I would implement first.
> The first version of qp-trie had already supported to use arbitrary
> bytes as key [1]. The lookup performance comparison between qp-trie and
> hash-table varies according to the benchmark result in the early
> patch-set [1]. For normal strings (e.g., strings in BTF or kallsyms),
> hash-table performance better. I will try whether or not it is possible
> to work out a hack version for both hash-table and qp-trie to compare
> the lookup performance first.

I had hacked bpf verifier (mainly check_stack_range_initialized()) to
support variable-sized key for both qp-trie and hash-table. For now,
only one bpf_dynptr is allowed in the key. I also update the benchmark
in qp-trie patch-set [1] to compare the lookup performance between
normal hash-table, hash-table with variable-sized key (namely
dynkey-htab), and qp-trie. The key for hash-table with variable-sized
key and qp-trie is shown below:

struct test_key {
        __u64 cookie;
        struct bpf_dynptr_user desc;
};

For randomly generated dynptr key, when the max length of ->desc is big
(e.g., >128) the performance of qp-trie is the best and it is 20%~80%
faster then dynkey hash-table. Not sure about the reason why dynkey-htab
is slower, it may be due to the overhead of hash function or hash
collision. The performance of dynkey hash table is only 5% good compared
with the normal hash-table when the max length of ->desc is 128. When
the max length of ->desc is 512, dynkey hash-table will be 20% faster
than normal hash table as shown below:

| max length of desc | qp-trie | dynkey-hash-tab |normal hash-tab | 
| ---   |  ---         | ---      | ---     |
|  64    | 7.5 M/s   | 7.1 M/s  | 8.3 M/s |
| 128    | 6.7 M/s   | 5.3 M/s  | 5.3 M/s |
| 256    | 4.9 M/s   | 3.4 M/s  | 3.2 M/s |
| 512    | 3.5 M/s   | 2.1 M/s  | 1.8 M/s |
| 1024   | 2.5 M/s   | 1.4 M/s  | 1.1 M/s |
| 2048   | 1.7 M/s   | 0.9 M/s  | 0.6 M/s |

When using strings from BTF, kallsyms or Alexa top 1M sites as the
dynptr in test_key, the performance of qp-trie is about 40% or more
slower than dynkey hash-table and normal hash-table. The mean length of
strings in these input files is about 17/24/15 respectively. And there
is no big difference between the lookup performance of dynkey hash-table
and normal hash-table. It may be due to the reason the implementation of
dynkey hash-table, because it invokes jhash three times to get the final
hash value.

| input | qp-trie | dynkey-hash-tab |normal hash-tab |
| ---      |  ---         | ---      | ---     |
| BTF      | 4.6 M/s   | 7.3 M/s  | 7.4 M/s |
| kallsyms | 4.7 M/s   | 6.5 M/s  | 6.5 M/s |
| top 1M   | 2.4 M/s   | 4.4 M/s  | 4.3 M/s |

The following is the detailed output of these benchmarks:

(1) Randomly generated key (the max/mean/stddev length of str in
test_key: 256/128/74)

$ sudo ./bench qp-trie-lookup --entries 100000 -a
Setting up benchmark 'qp-trie-lookup'...
generate 100000 random keys
str length: max 256 mean 128 stdev 74
Benchmark 'qp-trie-lookup' started.
Iter   0 ( 26.974us): hits    4.743M/s (  4.743M/prod), drops   
0.009M/s, total operations    4.753M/s
Iter   1 ( 23.165us): hits    4.957M/s (  4.957M/prod), drops   
0.009M/s, total operations    4.967M/s
Iter   2 (-22.390us): hits    4.994M/s (  4.994M/prod), drops   
0.010M/s, total operations    5.004M/s
Iter   3 ( -1.854us): hits    5.003M/s (  5.003M/prod), drops   
0.010M/s, total operations    5.013M/s
Iter   4 ( -0.583us): hits    4.997M/s (  4.997M/prod), drops   
0.010M/s, total operations    5.007M/s
Iter   5 ( 44.078us): hits    5.001M/s (  5.001M/prod), drops   
0.010M/s, total operations    5.011M/s
Iter   6 (-36.684us): hits    5.003M/s (  5.003M/prod), drops   
0.010M/s, total operations    5.013M/s
Summary: hits    4.993 ± 0.018M/s (  4.993M/prod), drops    0.010 ±
0.000M/s, total operations    5.002 ± 0.018M/s

$ sudo ./bench dynkey-htab-lookup --entries 100000 -a
Setting up benchmark 'dynkey-htab-lookup'...
generate 115980 random keys
str length: max 256 mean 129 stdev 74
Benchmark 'dynkey-htab-lookup' started.
Iter   0 ( 23.154us): hits    3.167M/s (  3.167M/prod), drops   
0.006M/s, total operations    3.173M/s
Iter   1 (  7.390us): hits    3.317M/s (  3.317M/prod), drops   
0.006M/s, total operations    3.324M/s
Iter   2 (  5.382us): hits    3.321M/s (  3.321M/prod), drops   
0.007M/s, total operations    3.327M/s
Iter   3 (-16.280us): hits    3.337M/s (  3.337M/prod), drops   
0.007M/s, total operations    3.344M/s
Iter   4 (  6.161us): hits    3.326M/s (  3.326M/prod), drops   
0.006M/s, total operations    3.333M/s
Iter   5 ( 36.514us): hits    3.328M/s (  3.328M/prod), drops   
0.006M/s, total operations    3.334M/s
Iter   6 (  3.131us): hits    3.322M/s (  3.322M/prod), drops   
0.007M/s, total operations    3.329M/s
Summary: hits    3.325 ± 0.007M/s (  3.325M/prod), drops    0.006 ±
0.000M/s, total operations    3.332 ± 0.007M/s

$ sudo ./bench htab-lookup --entries 100000 -a
Setting up benchmark 'htab-lookup'...
generate 100000 random keys
str length: max 256 mean 128 stdev 74
Benchmark 'htab-lookup' started.
Iter   0 ( 24.011us): hits    3.155M/s (  3.155M/prod), drops   
0.007M/s, total operations    3.161M/s
Iter   1 (  5.609us): hits    3.270M/s (  3.270M/prod), drops   
0.007M/s, total operations    3.277M/s
Iter   2 (  1.621us): hits    3.258M/s (  3.258M/prod), drops   
0.007M/s, total operations    3.264M/s
Iter   3 ( -5.675us): hits    3.260M/s (  3.260M/prod), drops   
0.007M/s, total operations    3.267M/s
Iter   4 ( -5.918us): hits    3.270M/s (  3.270M/prod), drops   
0.007M/s, total operations    3.276M/s
Iter   5 ( 58.144us): hits    3.273M/s (  3.273M/prod), drops   
0.007M/s, total operations    3.280M/s
Iter   6 (-50.080us): hits    3.254M/s (  3.254M/prod), drops   
0.007M/s, total operations    3.261M/s
Slab: 49.674 MiB
Summary: hits    3.264 ± 0.008M/s (  3.264M/prod), drops    0.007 ±
0.000M/s, total operations    3.271 ± 0.008M/s

(2) strings in BTF

[houtao@localhost bpf]$ sudo ./bench qp-trie-lookup --file btf.txt -a
Setting up benchmark 'qp-trie-lookup'...
item 115980
str length: max 71 mean 17 stdev 8
Benchmark 'qp-trie-lookup' started.
Iter   0 ( 41.758us): hits    4.570M/s (  4.570M/prod), drops   
0.000M/s, total operations    4.570M/s
Iter   1 ( -4.925us): hits    4.651M/s (  4.651M/prod), drops   
0.000M/s, total operations    4.651M/s
Iter   2 (-16.757us): hits    4.667M/s (  4.667M/prod), drops   
0.000M/s, total operations    4.667M/s
Iter   3 (  6.480us): hits    4.672M/s (  4.672M/prod), drops   
0.000M/s, total operations    4.672M/s
Iter   4 ( -8.465us): hits    4.670M/s (  4.670M/prod), drops   
0.000M/s, total operations    4.670M/s
Iter   5 ( 45.533us): hits    4.669M/s (  4.669M/prod), drops   
0.000M/s, total operations    4.669M/s
Iter   6 (-28.153us): hits    4.674M/s (  4.674M/prod), drops   
0.000M/s, total operations    4.674M/s
Summary: hits    4.667 ± 0.008M/s (  4.667M/prod), drops    0.000 ±
0.000M/s, total operations    4.667 ± 0.008M/s

$ sudo ./bench dynkey-htab-lookup --file btf.txt -a
Setting up benchmark 'dynkey-htab-lookup'...
item 115980
str length: max 71 mean 17 stdev 8
Benchmark 'dynkey-htab-lookup' started.
Iter   0 ( 18.721us): hits    7.144M/s (  7.144M/prod), drops   
0.000M/s, total operations    7.144M/s
Iter   1 (  5.173us): hits    7.317M/s (  7.317M/prod), drops   
0.000M/s, total operations    7.317M/s
Iter   2 (-10.935us): hits    7.297M/s (  7.297M/prod), drops   
0.000M/s, total operations    7.297M/s
Iter   3 ( 12.811us): hits    7.330M/s (  7.330M/prod), drops   
0.000M/s, total operations    7.330M/s
Iter   4 (-13.239us): hits    7.314M/s (  7.314M/prod), drops   
0.000M/s, total operations    7.314M/s
Iter   5 ( 51.453us): hits    7.308M/s (  7.308M/prod), drops   
0.000M/s, total operations    7.308M/s
Iter   6 (-40.370us): hits    7.324M/s (  7.324M/prod), drops   
0.000M/s, total operations    7.324M/s
Summary: hits    7.315 ± 0.012M/s (  7.315M/prod), drops    0.000 ±
0.000M/s, total operations    7.315 ± 0.012M/s

$ sudo ./bench htab-lookup --file btf.txt -a
Setting up benchmark 'htab-lookup'...
item 115980
str length: max 71 mean 17 stdev 8
Benchmark 'htab-lookup' started.
Iter   0 ( 24.738us): hits    7.223M/s (  7.223M/prod), drops   
0.000M/s, total operations    7.223M/s
Iter   1 ( 18.379us): hits    7.352M/s (  7.352M/prod), drops   
0.000M/s, total operations    7.352M/s
Iter   2 (-23.881us): hits    7.419M/s (  7.419M/prod), drops   
0.000M/s, total operations    7.419M/s
Iter   3 ( -0.607us): hits    7.438M/s (  7.438M/prod), drops   
0.000M/s, total operations    7.438M/s
Iter   4 (  7.016us): hits    7.410M/s (  7.410M/prod), drops   
0.000M/s, total operations    7.410M/s
Iter   5 ( 31.897us): hits    7.403M/s (  7.403M/prod), drops   
0.000M/s, total operations    7.403M/s
Iter   6 (-14.837us): hits    7.428M/s (  7.428M/prod), drops   
0.000M/s, total operations    7.428M/s
Slab: 22.310 MiB
Summary: hits    7.408 ± 0.030M/s (  7.408M/prod), drops    0.000 ±
0.000M/s, total operations    7.408 ± 0.030M/s



> [1]:
> https://lore.kernel.org/bpf/20220726130005.3102470-1-houtao1@huawei.com/
>


