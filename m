Return-Path: <bpf+bounces-8200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F9783722
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 02:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872F6280F66
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 00:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E510ED;
	Tue, 22 Aug 2023 00:55:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497BEA5
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 00:55:42 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B552C1BE
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 17:55:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RV9qT4p7wz4f3m8D
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 08:55:01 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCHp79iB+RkdCLSBA--.28687S2;
	Tue, 22 Aug 2023 08:55:02 +0800 (CST)
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com>
 <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com>
 <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com>
Date: Tue, 22 Aug 2023 08:54:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCHp79iB+RkdCLSBA--.28687S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13tFWktr4fur15Cr4fuFg_yoWrCF1Dpa
	yrWayjgr4kJa4ayry2gw48XF40yrn2qr1UW348t3yrCryq9ryagry8WayakFs5Jr1xG3yj
	qFWjv34fXr1xZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/22/2023 7:49 AM, Alexei Starovoitov wrote:
> On Sat, Aug 19, 2023 at 3:39 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 8/18/2023 7:00 AM, Alexei Starovoitov wrote:
>>> On Wed, Aug 16, 2023 at 11:35 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> ping ?
>>> Sorry for the delay. I've been on PTO.
>>>
>>>> On 8/3/2023 9:28 PM, Hou Tao wrote:
>>>>> On 8/3/2023 9:19 PM, Hou Tao wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I am preparing for qp-trie v4, but I need some help on how to support
>>>>>> variable-sized key in bpf syscall. The implementation of qp-trie needs
>>>>>> to distinguish between dynptr key from bpf program and variable-sized
>>>>>> key from bpf syscall. In v3, I added a new dynptr type:
>>>>>> BPF_DYNPTR_TYPE_USER for variable-sized key from bpf syscall [0], so
>>>>>> both bpf program and bpf syscall will use the same type to represent the
>>>>>> variable-sized key, but Andrii thought ptr+size tuple was simpler and
>>>>>> would be enough for user APIs, so in v4, the type of key for bpf program
>>>>>> and syscall will be different. One way to handle that is to add a new
>>>>>> parameter in .map_lookup_elem()/.map_delete_elem()/.map_update_elem() to
>>>>>> tell whether the key comes from bpf program or syscall or introduce new
>>>>>> APIs in bpf_map_ops for variable-sized key related syscall, but I think
>>>>>> it will introduce too much churn. Considering that the size of
>>>>>> bpf_dynptr_kern is 8-bytes aligned, so I think maybe I could reuse the
>>>>>> lowest 1-bit of key pointer to tell qp-trie whether or not it is a
>>>>>> bpf_dynptr_kern or a variable-sized key pointer from syscall. For
>>>>>> bpf_dynptr_kern, because it is 8B-aligned, so its lowest bit must be 0,
>>>>>> and for variable-sized key from syscall, I could allocated a 4B-aligned
>>>>>> pointer and setting the lowest bit as 1, so qp-trie can distinguish
>>>>>> between these two types of pointer. The question is that I am not sure
>>>>>> whether the idea above is a good one or not. Does it sound fragile ? Or
>>>>>> is there any better way to handle that ?
>>> Let's avoid bit hacks. They're not extensible and should be used
>>> only in cases where performance matters a lot or memory constraints are extreme.
>> I see. Neither the performance reason nor the memory limitation fit here.
>>> ptr/sz tuple from syscall side sounds the simplest.
>>> I agree with Andrii exposing the dynptr concept to user space
>>> and especially as part of syscall is unnecessary.
>>> We already have LPM as a precedent. Maybe we can do the same here?
>>> No need to add new sys_bpf commands.
>> There is no need to add new sys_bpf commands. We can extend bpf_attr to
>> support variable-sized key in qp-trie for bpf syscall. The probem is the
>> keys from bpf syscall and bpf program are different: bpf syscall uses
>> ptr+size tuple and bpf program uses dynptr, but the APIs in bpf_map_ops
>> only uses a pointer to represent the key, so qp-trie can not distinguish
>> between the keys from bpf syscall and bpf program. In qp-trie v1, the
>> key of qp-trie was similar with LPM-trie: both the syscall and program
>> used the same key format. But the key format for bpf program changed to
>> dynptr in qp-trie v2 according to the suggestion from Andrii. I think it
>> is also a bad ideal to go back to v1 again.
>>
>>> If the existing bpf_map_lookup_elem() helper doesn't fit qp-tree we can
>>> use new kfuncs from bpf prog and LPM-like map accessors from syscall.
>> It is a feasible solution, but it will make qp-trie be different with
>> other map types. I will try to extend the APIs in bpf_map_ops first to
>> see how much churns it may introduce.
> you mean you want to try to dynamically adapt bpf_map_lookup_elem()
> to consider 'void *key' as a pointer to dynptr for bpf prog and
> lpm-like tuple for syscall?
> I'm afraid the verifier changes will be messy, since PTR_TO_MAP_KEY is
> quite special.

No. I didn't plan to do that. I am trying to add three new APIs in
bpf_map_ops to handle lookup/update/delete operation from bpf syscall
(e.g, map_lookup_elem_syscall). So bpf program and bpf syscall can use
different API to operate on qp-trie.
> __bpf_kfunc void *bpf_qptree_lookup(const bpf_map *map, const struct
> bpf_dynptr_kern *key, ...);
> will be so much easier to add.


