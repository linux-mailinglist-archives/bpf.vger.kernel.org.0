Return-Path: <bpf+bounces-36358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38739947616
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 09:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A89CB213A5
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6B144D1A;
	Mon,  5 Aug 2024 07:32:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF11E505
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843173; cv=none; b=AwpGgcLyVi+IPeN9RWzMn2mmP0R3kIC+E+xrSSfKjThjh6yFA8yX3JsiBZ/tV5e9qlLQRvgYsbwQSiJUz1b8y0yPKLX2s7qlEsqMu+mkNNF3mkRvVpar97wqjxEpzmC7F7PmK+YmbaMdgWUORTWW/1ADksqdmOwlQMjzBOrNg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843173; c=relaxed/simple;
	bh=SIz4dBg63f/kN+0/yPR2oyreLJi53IbAN5KhOtB0aGs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SIwi98Y82xTQeEUZLeJvULv4Uqc3MW2ExyD8YxijnWswP9EnpBHEJ4ld4xKq+gWne0D2CuCOdoPQ7H90g4GwTyq9KLdl99BhnvzuZaznaanxwgFpxqjNFFm+/khdKOwHYiCZG86NFxMdd5tOLkbFsa/uDx+jW+sg5FoX7WGUkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wcp752ByGz4f3jM9
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 15:32:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8606D1A018D
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 15:32:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCXvoQagLBmKgZJAw--.46773S2;
	Mon, 05 Aug 2024 15:32:46 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 davemarchevsky@fb.com, Amery Hung <amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com>
 <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
 <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com>
Date: Mon, 5 Aug 2024 15:32:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCXvoQagLBmKgZJAw--.46773S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1fCF48XFyfXw1ruFWDCFg_yoWrtw1DpF
	97AF1fCrWkJr1xCr1qga1F934fKr4fCa17XFyrG3WF9r9FqryvqF10krWY9a1YkrsYkw1v
	vr4q9F9xG3yDArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 8/5/2024 12:31 PM, Amery Hung wrote:
> On Sun, Aug 4, 2024 at 7:41 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 8/3/2024 8:11 AM, Amery Hung wrote:
>>> From: Dave Marchevsky <davemarchevsky@fb.com>
>>>
>>> Currently btf_parse_fields is used in two places to create struct
>>> btf_record's for structs: when looking at mapval type, and when looking
>>> at any struct in program BTF. The former looks for kptr fields while the
>>> latter does not. This patch modifies the btf_parse_fields call made when
>>> looking at prog BTF struct types to search for kptrs as well.
>>>
>> SNIP
>>> On a side note, when building program BTF, the refcount of program BTF
>>> is now initialized before btf_parse_struct_metas() to prevent a
>>> refcount_inc() on zero warning. This happens when BPF_KPTR is present
>>> in program BTF: btf_parse_struct_metas() -> btf_parse_fields()
>>> -> btf_parse_kptr() -> btf_get(). This should be okay as the program BTF
>>> is not available yet outside btf_parse().
>> If btf_parse_kptr() pins the passed btf, there will be memory leak for
>> the btf after closing the btf fd, because the invocation of btf_put()
>> for kptr record in btf->struct_meta_tab depends on the invocation of
>> btf_free_struct_meta_tab() in btf_free(), but the invocation of
>> btf_free() depends the final refcnt of the btf is released, so the btf
>> will not be freed forever. The reason why map value doesn't have such
>> problem is that the invocation of btf_put() for kptr record doesn't
>> depends on the release of map value btf and it is accomplished by
>> bpf_map_free_record().
>>
> Thanks for pointing this out. It makes sense to me.
>
>> Maybe we should move the common btf used by kptr and graph_root into
>> btf_record and let the callers of btf_parse_fields() and
>> btf_record_free() to decide the life cycle of btf in btf_record.
> Could you maybe explain if and why moving btf of btf_field_kptr and
> btf_field_graph_root to btf_record is necessary? I think letting
> callers of btf_parse_fields() and btf_record_free() decide whether or
> not to change refcount should be enough. Besides, I personally would
> like to keep individual btf in btf_field_kptr and
> btf_field_graph_root, so that later we can have special fields
> referencing different btf.

Sorry, I didn't express the rough idea clearly enough. I didn't mean to
move btf of btf_field_kptr and btf_field_graph_root to btf_record,
because there are other btf-s which are different with the btf which
creates the struct_meta_tab. What I was trying to suggest is to save one
btf in btf_record and hope it will simplify the pin and the unpin of btf
in btf_record:

1) save the btf which owns the btf_record in btf_record.
2) during btf_parse_kptr() or similar, if the used btf is the same as
the btf in btf_record, there is no need to pin the btf
3) when freeing the btf_record, if the btf saved in btf_field is the
same as the btf in btf_record, there is no need to put it

For step 2) and step 3), however I think it is also doable through other
ways (e.g., pass the btf to btf_record_free or similar).
>
> Thanks,
> Amery
>
>>> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>>> ---
>>>  kernel/bpf/btf.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 95426d5b634e..7b8275e3e500 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -5585,7 +5585,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
>>>               type = &tab->types[tab->cnt];
>>>               type->btf_id = i;
>>>               record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
>>> -                                               BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT, t->size);
>>> +                                               BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
>>> +                                               BPF_KPTR, t->size);
>>>               /* The record cannot be unset, treat it as an error if so */
>>>               if (IS_ERR_OR_NULL(record)) {
>>>                       ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
>>> @@ -5737,6 +5738,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
>>>       if (err)
>>>               goto errout;
>>>
>>> +     refcount_set(&btf->refcnt, 1);
>>> +
>>>       struct_meta_tab = btf_parse_struct_metas(&env->log, btf);
>>>       if (IS_ERR(struct_meta_tab)) {
>>>               err = PTR_ERR(struct_meta_tab);
>>> @@ -5759,7 +5762,6 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
>>>               goto errout_free;
>>>
>>>       btf_verifier_env_free(env);
>>> -     refcount_set(&btf->refcnt, 1);
>>>       return btf;
>>>
>>>  errout_meta:
> .


