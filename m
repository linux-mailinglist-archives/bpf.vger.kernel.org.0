Return-Path: <bpf+bounces-36440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D6C94871F
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 03:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D2B284F75
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507BBA20;
	Tue,  6 Aug 2024 01:57:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352B1182C5
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 01:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909461; cv=none; b=uQqdCsFd9QpnhyBzKA/5bS9C7dyuuFBnKrXl/HqNbmGs9NLZWvz7zdXvn5kFm/ytr2ZUSYNGkAicJ4iWLvYPGU6krG8wJQg4EmOgJms4Og4nsZTZZToBlzAWFbAq4o9Mas5ttkRTatSuA4LneU7den6nCzk4uWONlAEo03n3pJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909461; c=relaxed/simple;
	bh=Ktw9W0iWYuWagJbE0Qrs6FnOhiqyJ+kZ91y6umCUXAo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f3xNNX8ouVz12j+r+n1XPMRSkQ+9ApIFEZ8x3QVsTSrA2sQzFJgbcSgaPWFNRKaQgLFnNwkN6fOWwlnCdK12wKJGN6hEdgN23ewntxAk+wxAbrxoomurQIWgXxPvOvWXZC/5l8cGTj6/OaiLF8BtHyYuAaFXiyLNzV583nGNwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WdGdk1ZW8z4f3lCj
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 09:57:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 79EC01A0359
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 09:57:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDXC7sEg7FmOIyMAw--.41281S2;
	Tue, 06 Aug 2024 09:57:28 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Amery Hung <ameryhung@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 davemarchevsky@fb.com, Amery Hung <amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com>
 <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
 <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com>
 <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com>
 <c72b14ef-47a9-4746-876a-609542755dd0@linux.dev>
 <CAMB2axMOTr-3svaKGqHxAwoR2_uZQ7ZWJrOzSZF7o7jqndhxQQ@mail.gmail.com>
 <fc6ba752-78c0-4514-900d-7bef6c1f447e@linux.dev>
 <CAMB2axOt=TGrp53ZN8ocaO=d4E86Wb6gEzFewbT27iC_iK3+Zw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7ade8465-4c9e-3d8b-7373-3207c453d41e@huaweicloud.com>
Date: Tue, 6 Aug 2024 09:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMB2axOt=TGrp53ZN8ocaO=d4E86Wb6gEzFewbT27iC_iK3+Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDXC7sEg7FmOIyMAw--.41281S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWxWw17Xr45ArW3uF48WFg_yoW7JF4Upa
	47AF1akr4kJry3CrnIgFn8Wa4ftrW7ArsYvF95GryY93Z0qr1kXr1jkrWY9F4qkrnYyw1v
	yr4UXF9xG3s8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 8/6/2024 8:31 AM, Amery Hung wrote:
> On Mon, Aug 5, 2024 at 3:25 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> On 8/5/24 1:44 PM, Amery Hung wrote:
>>>>>>> Maybe we should move the common btf used by kptr and graph_root into
>>>>>>> btf_record and let the callers of btf_parse_fields() and
>>>>>>> btf_record_free() to decide the life cycle of btf in btf_record.
>>>>>> Could you maybe explain if and why moving btf of btf_field_kptr and
>>>>>> btf_field_graph_root to btf_record is necessary? I think letting
>>>>>> callers of btf_parse_fields() and btf_record_free() decide whether or
>>>>>> not to change refcount should be enough. Besides, I personally would
>>>>>> like to keep individual btf in btf_field_kptr and
>>>>>> btf_field_graph_root, so that later we can have special fields
>>>>>> referencing different btf.
>>>>> Sorry, I didn't express the rough idea clearly enough. I didn't mean to
>>>>> move btf of btf_field_kptr and btf_field_graph_root to btf_record,
>>>>> because there are other btf-s which are different with the btf which
>>>>> creates the struct_meta_tab. What I was trying to suggest is to save one
>>>>> btf in btf_record and hope it will simplify the pin and the unpin of btf
>>>>> in btf_record:
>>>>>
>>>>> 1) save the btf which owns the btf_record in btf_record.
>>>>> 2) during btf_parse_kptr() or similar, if the used btf is the same as
>>>>> the btf in btf_record, there is no need to pin the btf
>>>> I assume the used btf is the one that btf_parse is working on.
>>>>
>>>>> 3) when freeing the btf_record, if the btf saved in btf_field is the
>>>>> same as the btf in btf_record, there is no need to put it
>>>> For btf_field_kptr.btf, is it the same as testing the btf_field_kptr.btf is
>>>> btf_is_kernel() or not? How about only does btf_get/put for btf_is_kernel()?
>>>>
>>> IIUC. It will not be the same. For a map referencing prog btf, I
>>> suppose we should still do btf_get().
>>>
>>> I think the core idea is since a btf_record and the prog btf
>>> containing it has the same life time, we don't need to
>>> btf_get()/btf_put() in btf_parse_kptr()/btf_record_free() when a
>>> btf_field_kptr.btf is referencing itself.
>>>
>>> However, since btf_parse_kptr() called from btf_parse() and
>>> map_check_btf() all use prog btf, we need a way to differentiate the
>>> two. Hence Hou suggested saving the owner's btf in btf_record, and
>> map_check_btf() calls btf_parse_kptr(map->btf).
>>
>> I am missing how it is different from the
>> btf_new_fd()=>btf_parse()=>btf_parse_kptr(new_btf).
>>
>> akaik, the map->record has no issue now because bpf_map_free_deferred() does
>> btf_record_free(map->record) before btf_put(map->btf). In the map->record case,
>> does the map->record need to take a refcnt of the btf_field_kptr.btf if the
>> btf_field_kptr.btf is pointing back to itself (map->btf) which is not a kernel btf?

I think you are right. For both callees of btf_parse_kptr() when the btf
saved in btf_field_kptr.btf is the same as the passed btf, there is no
need to call btf_get(). For bpf map case, just as you remained, map->btf
has already pin the btf passed to btf_parse_kptr() in map_create().
>>> then check if btf_record->btf is the same as the btf_field_kptr.btf in
>>> btf_parse_kptr()/btf_record_free().
>> I suspect it will have the same end result? The btf_field_kptr.btf is only the
>> same as the owner's btf when btf_parse_kptr() cannot found the kptr type from a
>> kernel's btf (the id == -ENOENT case in btf_parse_kptr).

It seems your suggestion of using btf_is_kernel() is much simpler:

(1) btf_parse_kptr():  doesn't invoke btf_get() when bpf_find_btf_id()
returns -ENOENT and let the caller ensure the life cycle of the passed btf.
(2) btf_record_free(): only invoke btf_put() if the saved btf is a
kernel btf.
(3) btf_record_dup(): only invoke btf_get() if the saved btf is a kernel
btf.
> I added some code to better explain how I think it could work.
>
> I am thinking about adding a struct btf* under struct btf_record, and
> then adding an argument in btf_parse_fields:
>
> btf_parse_fields(const struct btf *btf,..., bool btf_is_owner)
> {
>         ...
>         /* Before the for loop that goes through info_arr */
>         rec->btf = btf_is_owner ? btf : NULL;
>         ...
> }
>
> The btf_is_owner indicates whether the btf_record returned by the
> function will be part of the btf. So map_check_btf() will set it to
> false while btf_parse() will set it to true. Maybe "owner" is what
> makes it confusing? (btf_record for a map belongs to bpf_map but not
> map->btf. On the other hand, btf_record for a prog btf is part of it.)
>
> Then, in btf_record_free(), we can do:
>
> case BPF_KPTR_XXX:
>         ...
>         if (rec->btf != rec->fields[i].kptr.btf)
>                 btf_put(rec->fields[i].kptr.btf);
>
> In btf_parse_kptr(), we also do similar things. We just need to pass
> btf_record into it.


