Return-Path: <bpf+bounces-8223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87993783923
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 07:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5B31C209F6
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD31FD7;
	Tue, 22 Aug 2023 05:15:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB11861
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:15:17 +0000 (UTC)
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [IPv6:2001:41d0:1004:224b::18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCADCDB
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:15:15 -0700 (PDT)
Message-ID: <c7ce55e7-b462-5d02-768c-f817212d0194@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692681313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mg0mEb4QvWGBtKw6lCdrSQjdodUcti7YvNXeGY5ZbbM=;
	b=UQKisKffWILKung15AOq7BpNIMDs9ZH6S0RPJECr1eX4Ug8Oyamm0Dl91JR+zu6kBMmTV2
	zMgwJOk7wekBeSqffHYmrQVB7a0fHd3Bma8TLvG5WJBrGYsPvcCo0hjepYmKNX4s5FRCtP
	4vTBMP+NCHFZO9pwgD8wG/ts4eeDoe0=
Date: Tue, 22 Aug 2023 01:15:08 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230821000230.3108635-1-yonghong.song@linux.dev>
 <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/21/23 4:36 AM, Kumar Kartikeya Dwivedi wrote:
> On Mon, 21 Aug 2023 at 05:33, Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> When reviewing local percpu kptr support, Alexei discovered a bug
>> wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
>> locally allocated obj type do not match ([1]). Missed struct btf_id
>> comparison is the reason for the bug. This patch added such struct btf_id
>> comparison and will flag verification failure if types do not match.
>>
>>   [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
>>
>> Reported-by: Alexei Starovoitov <ast@kernel.org>
>> Fixes: 738c96d5e2e3 ("bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg")
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> But some comments below...
> 
>>  kernel/bpf/verifier.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 02a021c524ab..4e1ecd4b8497 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -7745,7 +7745,18 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>>                         verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
>>                         return -EFAULT;
>>                 }
>> -               /* Handled by helper specific checks */
>> +               if (meta->func_id == BPF_FUNC_kptr_xchg) {
>> +                       struct btf_field *kptr_field = meta->kptr_field;
>> +
>> +                       if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
>> +                                                 kptr_field->kptr.btf, kptr_field->kptr.btf_id,
>> +                                                 true)) {
>> +                               verbose(env, "R%d is of type %s but %s is expected\n",
>> +                                       regno, btf_type_name(reg->btf, reg->btf_id),
>> +                                       btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id));
>> +                               return -EACCES;
>> +                       }
>> +               }
> 
> The fix on its own looks ok to me, but any reason you'd not like to
> delegate to map_kptr_match_type?
> Just to collect kptr related type matching logic in its own place.  It
> doesn't matter too much though.
> 
> While looking at the code, I noticed one more problem.
> 
> I don't think the current code is enforcing that 'reg->off is zero'
> assumption when releasing MEM_ALLOC types. We are only saved because
> you passed strict=true which makes passing non-zero reg->off a noop
> and returns false.
> The hunk was added to check_func_arg_reg_off in
> 6a3cd3318ff6 ("bpf: Migrate release_on_unlock logic to non-owning ref
> semantics")
> which bypasses in case type is MEM_ALLOC and offset points to some
> graph root or node.
> 
> I am not sure why this check exists, IIUC rbtree release helpers are
> not tagged KF_RELEASE, and no release helper can type match on them
> either. Dave, can you confirm? I think it might be an accidental
> leftover of some refactoring.

I think you're correct, that's probably leftover from when
helpers were tagged KF_RELEASE in earlier rbtree impl revisions.

I also think it's reasonable to delete the hunk as you've done
in attached patches.

> 
> In fact, it seems bpf_obj_drop is already broken because reg->off
> assumption is violated.
> For node_data type:
> 
> bpf_obj_drop(&res->data);
> returns
> R1 must have zero offset when passed to release func
> No graph node or root found at R1 type:node_data off:8
> 
> but bpf_obj_drop(&res->node);
> passes verifier.
> 
> 15: (bf) r1 = r0                      ;
> R0_w=ptr_node_data(ref_obj_id=3,off=16,imm=0)
> R1_w=ptr_node_data(ref_obj_id=3,off=16,imm=0) refs=3
> 16: (b7) r2 = 0                       ; R2_w=0 refs=3
> 17: (85) call bpf_obj_drop_impl#74867      ;
> safe
> 
> I have attached a tentative fix and selftest to this patch, let me
> know what you think.

