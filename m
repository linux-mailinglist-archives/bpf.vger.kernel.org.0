Return-Path: <bpf+bounces-44022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F09BC921
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 10:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0A31F228E8
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B31D094B;
	Tue,  5 Nov 2024 09:29:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED970837;
	Tue,  5 Nov 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798991; cv=none; b=RcH4kNXbLgc8t6iD5FtjkRZTnjSE+BWYS9xBXO0XdV5CpBE4yo1pYeHit42p9N6smD3apq1S35otMm6XnB9SA49M9zQBe9o0e7EwPv6zAZBhuIh8WWn0vys3A7lyypKnXELUuzosi+Syj7mBkEBomoszu7UrrEGCwS/unsUTI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798991; c=relaxed/simple;
	bh=N9BeLlIwtdwAax1CuoV69ddGLngWNQlFFQvDk+mEHfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNIxQu+75OeEg2Mu58+bWudJFVGXiHtYCmB8gS9jNwj2BS4iOMJXfCrGCpcyaK5ZP6uk9Y2+ftFDjgRzKAHKOpSLTz87BUf/SgGvuLFIA2jBl9Z1x38GG7j8dZl7oevgWevJx12GQoC3Apf+fotye3kp+N5+3frzDIt65hnOTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjNMV0jmfz4f3m7T;
	Tue,  5 Nov 2024 17:29:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DC6871A018C;
	Tue,  5 Nov 2024 17:29:44 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDnj7GH5Slnk02NAw--.34665S2;
	Tue, 05 Nov 2024 17:29:44 +0800 (CST)
Message-ID: <51af2860-e448-4ed1-917c-5d195a4693b5@huaweicloud.com>
Date: Tue, 5 Nov 2024 17:29:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops
 trampoline
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
 <CAADnVQKnJkJpWkuxC32UPc4cvTnT2+YEnm8TktrEnDNO7ZbCdA@mail.gmail.com>
 <5c16fb2f-efa2-4639-862d-99acbd231660@huaweicloud.com>
 <CAADnVQLvpwLp=t1oz3ic-EKnaio2DhOCanmuBQ+8nSf-jzBePw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQLvpwLp=t1oz3ic-EKnaio2DhOCanmuBQ+8nSf-jzBePw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnj7GH5Slnk02NAw--.34665S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF48Cr1kAFyrCw47WFWUCFg_yoWrGF1fpr
	y8G3WayF4DZrWDC34Iqw47ZFnay390q3srWr95J34fCa90qr9Fqr1UtryfCas3Crs5ZF1j
	vr1FvrZruFy7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/5/2024 1:53 AM, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 3:55 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>>>>                   *(unsigned long *)(udata + moff) = prog->aux->id;
>>>> +
>>>> +               /* init ksym for this trampoline */
>>>> +               bpf_struct_ops_ksym_init(prog, image + trampoline_start,
>>>> +                                        image_off - trampoline_start,
>>>> +                                        ksym++);
>>>
>>> Thanks for the patch.
>>> I think it's overkill to add ksym for each callsite within a single
>>> trampoline.
>>> 1. The prog name will be next in the stack. No need to duplicate it.
>>> 2. ksym-ing callsites this way is quite unusual.
>>> 3. consider irq on other insns within a trampline.
>>>      The unwinder won't find anything in such a case.
>>>
>>> So I suggest to add only one ksym that covers the whole trampoline.
>>> The name could be "bpf_trampoline_structopsname"
>>> that is probably st_ops_desc->type.
>>>
>>
>> IIUC, the "whole trampoline" for a struct_ops is actually the page
>> array st_map->image_pages[MAX_TRAMP_IMAGE_PAGES], where each page is
>> allocated by arch_alloc_bpf_trampoline(PAGE_SIZE).
>>
>> Since the virtual addresses of these pages are *NOT* guaranteed to
>> be contiguous, I dont think we can create a single ksym for them.
>>
>> And if we add a ksym for each individual page, it seems we will end
>> up with an odd name for each ksym.
> 
> I see. Good point. Ok. Let's add ksym for each callback.
> 
>> Given that each page consists of one or more bpf trampolines, which
>> are not different from bpf trampolines for other prog types, such as
>> bpf trampolines for fentry, and since each bpf trampoline for other
>> prog types already has a ksym, I think it is not unusual to add ksym
>> for each single bpf trampoline in the page.
>>
>> And, there are no instructions between adjacent bpf trampolines within
>> a page, nothing between two trampolines can be interrupted.
>>
>> For the name, bpf_trampoline_<struct_ops_name>_<member_name>, like
>> bpf_trampoline_tcp_congestion_ops_pkts_acked, seems appropriate.
> 
> Agree. This naming convention makes sense.
> I'd only shorten the prefix to 'bpf_tramp_' or even 'bpf__'
> (with double underscore).
> It's kinda obvious that it's a trampoline and it's an implementation
> detail that doesn't need to be present in the name.
>

OK, 'bpf__' looks great.

>>
>>>>           }
>>>>
>>>>           if (st_ops->validate) {
>>>> @@ -790,6 +829,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>>>    unlock:
>>>>           kfree(tlinks);
>>>>           mutex_unlock(&st_map->lock);
>>>> +       if (!err)
>>>> +               bpf_struct_ops_map_ksyms_add(st_map);
>>>>           return err;
>>>>    }
>>>>
>>>> @@ -883,6 +924,10 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>>>>            */
>>>>           synchronize_rcu_mult(call_rcu, call_rcu_tasks);
>>>>
>>>> +       /* no trampoline in the map is running anymore, delete symbols */
>>>> +       bpf_struct_ops_map_ksyms_del(st_map);
>>>> +       synchronize_rcu();
>>>> +
>>>
>>> This is substantial overhead and why ?
>>> synchronize_rcu_mult() is right above.
>>>
>>
>> I think we should ensure no trampoline is running or could run before
>> its ksym is deleted from the symbol table. If this order is not ensured,
>> a trampoline can be interrupted by a perf irq after its symbol is deleted,
>> resulting a broken stacktrace since the trampoline symbol cound not be
>> found by the perf irq handler.
>>
>> This patch deletes ksyms after synchronize_rcu_mult() to ensure this order.
> 
> But the overhead is prohibitive. We had broken stacks with st_ops
> for long time, so it may still hit 0.001% where st_ops are being switched
> as the comment in bpf_struct_ops_map_free() explains.
>

Got it

> As a separate clean up I would switch the freeing to call_rcu_tasks.
> Synchronous waiting is expensive.
> 
> Martin,
> 
> any suggestions?


