Return-Path: <bpf+bounces-42754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA749A9ACF
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F000FB2495D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9F14901B;
	Tue, 22 Oct 2024 07:20:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0A3232
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581650; cv=none; b=kIE0yVb0Tl8wTF6FUCy9dTW4b6oHDGNWH4TIC5MJlsFoYGuoYbbusyGJehqSDkL1wpeJeR5SLFojx2ULx9cNPytIjhSAQK22yWiPzwRQ5WzaEHLyufg87q/jQ4SJ2b5lhfPChbs9XNegnrJnRRfGm+rn1jneBgdz/OHOqdWpuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581650; c=relaxed/simple;
	bh=vIoNRfmQew7qjWlZe3YV/N1+B6UIkmxyhZZ/G96XFYs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IjvzfBW2DsCNmH6gv6tYJBEGB7o+N63GFGTo+NgZJRr5wqXCVsb8iO86GRFznBSr0bdW50vPcymrEOqGKJTZBl9ebufS9p3wPZPEhwjh45e4sR7MwCvvAj/N6S0L1Qtjl215DCuUh/NsRmupqwQiyZNSorOA97EG4Q9VNWE0x/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXk955HPyz4f3jsL
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:20:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1C7391A018C
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:20:43 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCXzMhFUhdnsV8mEw--.52510S2;
	Tue, 22 Oct 2024 15:20:41 +0800 (CST)
Subject: Re: [PATCH bpf-next 03/16] bpf: Parse bpf_dynptr in map key
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-4-houtao@huaweicloud.com>
 <CAADnVQKmkaYJixBrJpWPDpHM9R9jq91meY9bERCVaC11CN4G_w@mail.gmail.com>
 <b2ceb4b4-e9bf-dc07-86ac-c7c3edbd4d04@huaweicloud.com>
 <CAADnVQL=GB7LoCQ=ceyxJDHRFudnHGsQXVMMMJa90H-70vwnpQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5bc378ac-b9a0-66b8-e7d3-94852f05ba37@huaweicloud.com>
Date: Tue, 22 Oct 2024 15:20:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQL=GB7LoCQ=ceyxJDHRFudnHGsQXVMMMJa90H-70vwnpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCXzMhFUhdnsV8mEw--.52510S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xArWrAr45CrWkGF4kJFb_yoW5Zw4DpF
	1fGFy2kr4kJrnrCrnFgw4F9as7tryFgrW7uFWrt34jgFyvqr9rXF18KF45uF9YkF4rtrZ7
	Ar4jqas5u34vyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/22/2024 11:59 AM, Alexei Starovoitov wrote:
> On Mon, Oct 21, 2024 at 7:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 10/12/2024 12:29 AM, Alexei Starovoitov wrote:
>>> On Tue, Oct 8, 2024 at 2:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> +#define MAX_DYNPTR_CNT_IN_MAP_KEY 4
>>>> +
>>>>  static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>>>>                          const struct btf *btf, u32 btf_key_id, u32 btf_value_id)
>>>>  {
>>>> @@ -1103,6 +1113,40 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>>>>         if (!value_type || value_size != map->value_size)
>>>>                 return -EINVAL;
>>>>
>>>> +       if (btf_type_is_dynptr(btf, key_type))
>>>> +               map->key_record = btf_new_bpf_dynptr_record();
>>>> +       else
>>>> +               map->key_record = btf_parse_fields(btf, key_type, BPF_DYNPTR, map->key_size);
>>>> +       if (!IS_ERR_OR_NULL(map->key_record)) {
>>>> +               if (map->key_record->cnt > MAX_DYNPTR_CNT_IN_MAP_KEY) {
>>>> +                       ret = -E2BIG;
>>>> +                       goto free_map_tab;
>>> Took me a while to grasp that map->key_record is only for dynptr fields
>>> and map->record is for the rest except dynptr fields.
>>>
>>> Maybe rename key_record to dynptr_fields ?
>>> Or at least add a comment to struct bpf_map to explain
>>> what each btf_record is for.
>> I was trying to rename map->record to map->value_record, however, I was
>> afraid that it may introduce too much churn, so I didn't do that. But I
>> think it is a good idea to add comments for both btf_record. And
>> considering that only bpf_dynptr is enabled for map key, renaming it to
>> dynptr_fields seems reasonable as well.
>>> It's kinda arbitrary decision to support multiple dynptr-s per key
>>> while other fields are not.
>>> Maybe worth looking at generalizing it a bit so single btf_record
>>> can have multiple of certain field kinds?
>>> In addition to btf_record->cnt you'd need btf_record->dynptr_cnt
>>> but that would be easier to extend in the future ?
>> Map value has already supported multiple kptrs or bpf_list_node.
> fwiw I believe we reached the dead end there.
> The whole support for bpf_list and bpf_rb_tree may get deprecated
> and removed. The expected users didn't materialize.

OK.
>
>> And in
>> the discussion [1], I thought multiple dynptr support in map key is
>> necessary, so I enabled it.
>>
>> [1]:
>> https://lore.kernel.org/bpf/CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com/
> Sure. That's a different reasoning and use case.
> I'm proposing to use a single btf_record with different cnt-s.
> The current btf_record->cnt will stay as-is indicating total number of fields
> while btf_record->dynptr_cnt will be just for these dynptrs you're introducing.
> Then you won't need two top level btf_record-s.

I misunderstood your suggestion yesterday. Now I see what you are
suggesting. However, it seems using a separated counter for different
kinds of btf_field will only benefit dynptr field, because other types
doesn't need to iterate all field instead they just need to find one
through binary search. And I don't understand why only one btf_record
will be enough, because these two btf_records are derived from map key
and map value respectively.



