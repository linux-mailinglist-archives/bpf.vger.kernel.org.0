Return-Path: <bpf+bounces-17793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46A181282C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713FB282626
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8DD277;
	Thu, 14 Dec 2023 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a2q7GCsy"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2245D51
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 22:31:03 -0800 (PST)
Message-ID: <50044158-c732-4ca5-8a3c-d06d693f1c85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702535461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5AyKFSpvntyx/5OyjYFpaQ1dHlEleuSN5SB3CjJAhs=;
	b=a2q7GCsyTGMJu/ohqprDkFWe8tKcuAhJYuxz3PDBU4g0fwy/AyOuyFE3vDB8XCDOIDQn4J
	KT/5IlLmMXHraI07/bPxS3FtFAhVua+rkhZBJr3F/1d4FDJmo2QsynjDQP3w5gcgZ4862+
	5tNpxCQFj0znmX9VNy+siaSx4p9zGaQ=
Date: Wed, 13 Dec 2023 22:30:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] bpf: Fix a race condition between btf_put()
 and map_free()
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 bpf <bpf@vger.kernel.org>
References: <20231206210959.1035724-1-yonghong.song@linux.dev>
 <d1c0232c-a41c-4cce-9bdf-3a1e8850ed05@linux.dev>
 <969852f3-34f8-45d9-bf2d-f6a4d5167e55@linux.dev>
 <ad71a99d-8b5f-44b4-99ee-5afb31c60bff@linux.dev>
 <0b3a96bd-4dfc-6d23-d473-f4351fbe84c2@huaweicloud.com>
 <0e657fc3-d932-4bd6-9d74-54eff22d3641@linux.dev>
 <CAADnVQJ3FiXUhZJwX_81sjZvSYYKCFB3BT6P8D59RS2Gu+0Z7g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ3FiXUhZJwX_81sjZvSYYKCFB3BT6P8D59RS2Gu+0Z7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/13/23 8:17 PM, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 9:07 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 12/8/23 12:30 AM, Hou Tao wrote:
>>> Hi,
>>>
>>> On 12/8/2023 12:02 PM, Yonghong Song wrote:
>>>> On 12/7/23 7:59 PM, Yonghong Song wrote:
>>>>> On 12/7/23 5:23 PM, Martin KaFai Lau wrote:
>>>>>> On 12/6/23 1:09 PM, Yonghong Song wrote:
>>>>>>> When running `./test_progs -j` in my local vm with latest kernel,
>>>>>>> I once hit a kasan error like below:
>>>>>>>
>>>>>>>
>>> SNIP
>>>>>>> Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with
>>>>>>> following code:
>>>>>>>
>>>>>>>      meta = btf_find_struct_meta(btf, btf_id);
>>>>>>>      if (!meta)
>>>>>>>        return -EFAULT;
>>>>>>>      rec->fields[i].graph_root.value_rec = meta->record;
>>>>>>>
>>>>>>> So basically, 'value_rec' is a pointer to the record in
>>>>>>> struct_metas_tab.
>>>>>>> And it is possible that that particular record has been freed by
>>>>>>> btf_struct_metas_free() and hence we have a kasan error here.
>>>>>>>
>>>>>>> Actually it is very hard to reproduce the failure with current
>>>>>>> bpf/bpf-next
>>>>>>> code, I only got the above error once. To increase reproducibility,
>>>>>>> I added
>>>>>>> a delay in bpf_map_free_deferred() to delay map->ops->map_free(),
>>>>>>> which
>>>>>>> significantly increased reproducibility.
>>>>>>>
>>>>>>>      diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>>>>>      index 5e43ddd1b83f..aae5b5213e93 100644
>>>>>>>      --- a/kernel/bpf/syscall.c
>>>>>>>      +++ b/kernel/bpf/syscall.c
>>>>>>>      @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct
>>>>>>> work_struct *work)
>>>>>>>            struct bpf_map *map = container_of(work, struct bpf_map,
>>>>>>> work);
>>>>>>>            struct btf_record *rec = map->record;
>>>>>>>
>>>>>>>      +     mdelay(100);
>>>>>>>            security_bpf_map_free(map);
>>>>>>>            bpf_map_release_memcg(map);
>>>>>>>            /* implementation dependent freeing */
>>>>>>>
>>>>>>> To fix the problem, we need to have a reference on btf in order to
>>>>>>> safeguard accessing field->graph_root.value_rec in
>>>>>>> map->ops->map_free().
>>>>>>> The function btf_parse_graph_root() is the place to get a btf
>>>>>>> reference.
>>>>>>> The following are rough call stacks reaching bpf_parse_graph_root():
>>>>>>>
>>>>>>>       btf_parse
>>>>>>>         ...
>>>>>>>           btf_parse_fields
>>>>>>>             ...
>>>>>>>               btf_parse_graph_root
>>>>>>>
>>>>>>>       map_check_btf
>>>>>>>         btf_parse_fields
>>>>>>>           ...
>>>>>>>             btf_parse_graph_root
>>>>>>>
>>>>>>> Looking at the above call stack, the btf_parse_graph_root() is
>>>>>>> indirectly
>>>>>>> called from btf_parse() or map_check_btf().
>>>>>>>
>>>>>>> We cannot take a reference in btf_parse() case since at that moment,
>>>>>>> btf is still in the middle to self-validation and initial reference
>>>>>>> (refcount_set(&btf->refcnt, 1)) has not been triggered yet.
>>>>>> Thanks for the details analysis and clear explanation. It helps a lot.
>>>>>>
>>>>>> Sorry for jumping in late.
>>>>>>
>>>>>> I am trying to avoid making a special case for "bool has_btf_ref;"
>>>>>> and "bool from_map_check". It seems to a bit too much to deal with
>>>>>> the error path for btf_parse().
>>> Maybe we could move the common btf used by kptr and graph_root into
>>> bpf_record and let the callers of btf_parse_fields()  and
>>> btf_record_free() to decide the life cycle of btf in btf_record, so
>>> there will be less intrusive and less special case. The following is the
>> I didn't fully check the code but looks like we took a
>> btf reference at map_check_btf() and free it at the end
>> of bpf_map_free_deferred(). This is similar to my v1 patch,
>> not exactly the same but similar since they all do
>> btf_put() at the end of bpf_map_free_deferred().
>>
>> Through discussion, doing on-demand btf_get()/btf_put()
>> approach, similar to kptr approach, seems more favored.
>> This also has advantage to free btf at its earlist possible
>> point.
> Sorry. Looks like I recommended the wrong path.
>
> The approach of btf_parse_fields(... false | true)
> depending on where it's called and whether returned struct btf_record *
> will be kept within a type or within a map
> is pushing complexity too far.
> A year from now we'll forget these subtle details.
> There is an advantage to do btf_put() earli in bpf_map_put(),
> but in the common case it would be delayed just after queue_work.
> Which is a minor time delay.
> And for free_after_mult_rcu_gp much longer,
> but saving from freeing btf are minor compared to the map itself.
>
> I think it's cleaner to go back to v1 and simply move btf_put
> to bpf_map_free_deferred().
> A lot less things to worry about.
> Especially considering that BPF_RB_ROOT may not be the last such special
> record keeping type and every new type would need to think
> hard whether it's BPF_RB_ROOT-like or BPF_LIST_NODE-like.
> v1 avoids this future complexity.

No problem. Will send v6 tomorrow with v1.


