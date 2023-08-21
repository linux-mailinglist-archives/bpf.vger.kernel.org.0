Return-Path: <bpf+bounces-8169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0E783039
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 20:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78451C20936
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585FF9C1;
	Mon, 21 Aug 2023 18:23:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E405F505
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 18:23:46 +0000 (UTC)
Received: from out-5.mta1.migadu.com (out-5.mta1.migadu.com [95.215.58.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5990125
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 11:23:39 -0700 (PDT)
Message-ID: <ec54dac3-02b1-231a-5a15-e0631812ae49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692642217; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxarciAs/zcYVBNMiKnlnke3RuQMDJzM0/z+7tLBFQ4=;
	b=VCbLnpX7uJ530RcaNeOLJ7pYctERyGn6KJtvGM5yGSkII3X0hl8e9dBlYbRs7IbWBYsavf
	/VdAAMM+MPLvc3AV0dRGYRYAivAYM/xngnH5U2tKx/u8AJNsYYnfVUNABg22FQ3zfTEo9f
	ZGzlya5CdTg8s2rE4Tk3AAEEhojBAo8=
Date: Mon, 21 Aug 2023 11:23:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20230821000230.3108635-1-yonghong.song@linux.dev>
 <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com>
 <4a5a4fbf-fd9d-2723-2a5f-9a9da162bd5b@linux.dev>
 <CAP01T77R=sKccHMc5jrEF2vGyPpAGM25+ompTcT+W8W-mZCk+Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP01T77R=sKccHMc5jrEF2vGyPpAGM25+ompTcT+W8W-mZCk+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 9:03 AM, Kumar Kartikeya Dwivedi wrote:
> On Mon, 21 Aug 2023 at 19:52, Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 8/21/23 1:36 AM, Kumar Kartikeya Dwivedi wrote:
>>> On Mon, 21 Aug 2023 at 05:33, Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>
>>>> When reviewing local percpu kptr support, Alexei discovered a bug
>>>> wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
>>>> locally allocated obj type do not match ([1]). Missed struct btf_id
>>>> comparison is the reason for the bug. This patch added such struct btf_id
>>>> comparison and will flag verification failure if types do not match.
>>>>
>>>>     [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
>>>>
>>>> Reported-by: Alexei Starovoitov <ast@kernel.org>
>>>> Fixes: 738c96d5e2e3 ("bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg")
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>
>>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>>
>>> But some comments below...
>>>
>>>>    kernel/bpf/verifier.c | 13 ++++++++++++-
>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 02a021c524ab..4e1ecd4b8497 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -7745,7 +7745,18 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>>>>                           verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
>>>>                           return -EFAULT;
>>>>                   }
>>>> -               /* Handled by helper specific checks */
>>>> +               if (meta->func_id == BPF_FUNC_kptr_xchg) {
>>>> +                       struct btf_field *kptr_field = meta->kptr_field;
>>>> +
>>>> +                       if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
>>>> +                                                 kptr_field->kptr.btf, kptr_field->kptr.btf_id,
>>>> +                                                 true)) {
>>>> +                               verbose(env, "R%d is of type %s but %s is expected\n",
>>>> +                                       regno, btf_type_name(reg->btf, reg->btf_id),
>>>> +                                       btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id));
>>>> +                               return -EACCES;
>>>> +                       }
>>>> +               }
>>>
>>> The fix on its own looks ok to me, but any reason you'd not like to
>>> delegate to map_kptr_match_type?
>>> Just to collect kptr related type matching logic in its own place.  It
>>> doesn't matter too much though.
>>
>>   From comments from Alexei in
>>
>> https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
>>
>> =====
>> The map_kptr_match_type() should have been used for kptrs pointing to
>> kernel objects only.
>> But you're calling it for MEM_ALLOC object with prog's BTF...
>> =====
>>
>> So looks like map_kptr_match_type() is for kptrs pointing to
>> kernel objects only. So that is why I didn't use it.
>>
> 
> That function was added by me. Back then I added this check as we were
> discussing possibly supporting such local kptr and more thought would
> be needed about the design before just doing type matching. Also it
> was using kernel_type_name which was later renamed as btf_type_name,
> so as a precaution I added the btf_is_kernel check. Apart from that I
> remember no other reason, so I think it should be ok to drop it now
> and use it.
> 
> But as I said, it is up to you, it will in effect do the same thing as
> this patch, so it is ok as-is.
> 
>>>
>>> While looking at the code, I noticed one more problem.
>>>
>>> I don't think the current code is enforcing that 'reg->off is zero'
>>> assumption when releasing MEM_ALLOC types. We are only saved because
>>> you passed strict=true which makes passing non-zero reg->off a noop
>>> and returns false.
>>> The hunk was added to check_func_arg_reg_off in
>>> 6a3cd3318ff6 ("bpf: Migrate release_on_unlock logic to non-owning ref
>>> semantics")
>>> which bypasses in case type is MEM_ALLOC and offset points to some
>>> graph root or node.
>>>
>>> I am not sure why this check exists, IIUC rbtree release helpers are
>>> not tagged KF_RELEASE, and no release helper can type match on them
>>> either. Dave, can you confirm? I think it might be an accidental
>>> leftover of some refactoring.
>>
>> I am sure that Dave will look into this problem. I will take
>> a look as well to be sure my local percpu kptr won't have
>> issues with what you just discovered. Thanks!
>>
> 
> It should be a problem for anything that has the MEM_ALLOC flag set,
> including percpu_kptr.

I suspect that below removed code

```
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fa46e92fe01..c0616c8b676d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7979,17 +7979,6 @@ int check_func_arg_reg_off(struct 
bpf_verifier_env *env,
  		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
  			return 0;

-		if ((type_is_ptr_alloc_obj(type) || type_is_non_owning_ref(type)) && 
reg->off) {
-			if (reg_find_field_offset(reg, reg->off, BPF_GRAPH_NODE_OR_ROOT))
-				return __check_ptr_off_reg(env, reg, regno, true);
-
-			verbose(env, "R%d must have zero offset when passed to release func\n",
-				regno);
-			verbose(env, "No graph node or root found at R%d type:%s off:%d\n", 
regno,
-				btf_type_name(reg->btf, reg->btf_id), reg->off);
-			return -EINVAL;
-		}
-
  		/* Doing check_ptr_off_reg check for the offset will catch this
  		 * because fixed_off_ok is false, but checking here allows us
  		 * to give the user a better error message.
```

intends to check whether there is a graph node or root in a local
kptr. This is to ensure Dave's use case where you can locally
allocate a obj and one of obj's field is a graph node/root.

I agree with you the checking probably should not be here and
it should be somewhere else.

