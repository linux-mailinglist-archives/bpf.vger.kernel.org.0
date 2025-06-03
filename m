Return-Path: <bpf+bounces-59479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCFACBF04
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 06:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E603A2E3F
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491D17C224;
	Tue,  3 Jun 2025 04:01:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705FE372
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923276; cv=none; b=ZpiL4hQbweHxy+v2e1iTCyS/URdzVVbsjCxeKt1QJ2FBkBEzdKfc8r4pIROhqwQGtD4XxELYbM+dC1rLWwk73n3xqlxFHZY29iZOZIiRSJTSlzVwEJregP1PDYrrh150g+iPro9G8KwYBDEj1zuyrIqxM7ps+I0hMP2bGOw0EFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923276; c=relaxed/simple;
	bh=vnGoFaisDL8HYl79lOivOzQu6upYu9nRgqJxlDo5bDE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L8DM3HyzfENSJMzA3kDeKrYfH7c4pP7YjSDm4FYsCTeH5nXQdjJ17VXooyHL8UTJajMBPtpa7DQCf5cbh5WlCYoRPmm/nocN+oN0E58VEHZku5tTr3P1DC0BB9EJ2+SwkvknhqXyMmDYd1eOLtY/KdSzgJd1K+v6iEhPqYzNJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bBH7r3zV2zKHMsx
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 12:01:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E9C601A0898
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 12:01:10 +0800 (CST)
Received: from [10.174.177.163] (unknown [10.174.177.163])
	by APP4 (Coremail) with SMTP id gCh0CgAn11uCcz5o3tthOQ--.55484S2;
	Tue, 03 Jun 2025 12:01:10 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf mem allocator dtor
 for hash map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20250526062555.1106061-1-houtao@huaweicloud.com>
 <20250526062555.1106061-3-houtao@huaweicloud.com>
 <CAADnVQLH3Ut8dF9t=_zB4acbZYuN=9+fgsACossGqFVTPO6EaQ@mail.gmail.com>
 <137a5a3f-c571-5ade-7ea1-d224ec6b36f0@huaweicloud.com>
 <CAADnVQLBsYU0xysuqzbZCKbSZP=CLdc8FPaMsvxtrwApwVT6EQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7e0125a1-0a74-8afe-6278-3d3a4387f153@huaweicloud.com>
Date: Tue, 3 Jun 2025 12:01:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLBsYU0xysuqzbZCKbSZP=CLdc8FPaMsvxtrwApwVT6EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAn11uCcz5o3tthOQ--.55484S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWfXFWxuFyUGFW7tw4kXrb_yoWrZr13pr
	Z5G3W3Kr4kJFZ2kwsaqanrKr1akw4rGFyUCFW5KryYkrn8Kr97Kr409w45WF1rCr4kJrnY
	qrZ2vasI934UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 6/3/2025 10:45 AM, Alexei Starovoitov wrote:
> On Mon, Jun 2, 2025 at 7:27 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 6/3/2025 7:08 AM, Alexei Starovoitov wrote:
>>> On Sun, May 25, 2025 at 11:08 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> BPF hash map supports special fields in its value, and BPF program is
>>>> free to manipulate these special fields even after the element is
>>>> deleted from the hash map. For non-preallocated hash map, these special
>>>> fields will be leaked when the map is destroyed. Therefore, implement
>>>> necessary BPF memory allocator dtor to free these special fields.
>>>>
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
>>>>  kernel/bpf/hashtab.c | 34 ++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>> index dd6c157cb828..2531177d1464 100644
>>>> --- a/kernel/bpf/hashtab.c
>>>> +++ b/kernel/bpf/hashtab.c
>>>> @@ -128,6 +128,8 @@ struct htab_elem {
>>>>         char key[] __aligned(8);
>>>>  };
>>>>
>>>> +static void check_and_free_fields(struct bpf_htab *htab, struct htab_elem *elem);
>>>> +
>>>>  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
>>>>  {
>>>>         return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
>>>> @@ -464,6 +466,33 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>>>>         return 0;
>>>>  }
>>>>
>>>> +static void htab_ma_dtor(void *obj, void *ctx)
>>>> +{
>>>> +       struct bpf_htab *htab = ctx;
>>>> +
>>>> +       /* The per-cpu pointer saved in the htab_elem may have been freed
>>>> +        * by htab->pcpu_ma. Therefore, freeing the special fields in the
>>>> +        * per-cpu pointer through the dtor of htab->pcpu_ma instead.
>>>> +        */
>>>> +       if (htab_is_percpu(htab))
>>>> +               return;
>>>> +       check_and_free_fields(htab, obj);
>>>> +}
>>> It seems the selftest in patch 3 might be working "by accident",
>>> but older tests should be crashing?
>> Er, didn't follow the reason why the older test should be crashing.  For
>> the per-cpu hash map, the per-cpu pointer gets through
>> htab_elem_get_ptr() is valid until one tasks trace RCU gp passes,
>> therefore, the bpf prog will always manipulate a valid per-cpu pointer.
>> The comment above wants to say is that htab_elem_get_ptr() in
>> htab_ma_dtor() may return a freed per-cpu pointer, because the order of
>> freeing htab_elem->ptr_to_pptr and htab_elem is nondeterministic.
>>
>>> It looks like you're calling check_and_free_fields() twice now.
>>> Once from htab_elem_free() and then again in htab_ma_dtor() ?
>>>
>>> If we're going for dtor then htab should delegate all clean up to it.
>> Yes. check_and_free_fields() is called twice.
> I meant that things will be crashing since it's called twice.
> In bpf_obj_free_fields()
> timer/wq are probably fine to be called multiple times.
> list_head/rb_tree/kptr should be fine as well,
> but uptr will double unpin.
>
> I doubt we really thought through the consequences of
> calling bpf_obj_free_fields() on the same map value multiple times.

Thanks for the explanation. I got it now. Considering that uptr is only
available for task local storage, it is fine for now. But we should
handle that if check_and_free_fields() is called multiple times.
>
>> There are three possible
>> locations to free the special fields:
>>
>> 1) when the element is freed through bpf_mem_cache_free()
>> 2) before the element is reused
>> 3) before the element is freed to slab.
>>
>> 3) is necessary to ensure these special fields will not be leaked and 1)
>> is necessary to ensure these special fields will be freed before it is
>> reused. I didn't find a good way to only call it once.
> My point is that we have to call it once, especially since
> it's recursive in obj_drop, or...
> if we have to call it multiple times we need to fix uptr and
> review all other special fields carefully.

I see.
>
>> Maybe adding a
>> bit flag to the pointer of the element to indicate that it has been
>> destroyed is OK ? Will try it in the next revision.
> Not sure what you have in mind.

Er. I was just wondering that if it is possible to the bit 0 of the
element pointer to indicate that the element has been destroyed,
therefore, the second invocation of dtor can be avoided.

> .


