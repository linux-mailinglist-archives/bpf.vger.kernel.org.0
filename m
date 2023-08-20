Return-Path: <bpf+bounces-8133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFA9781C8C
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 07:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C06281095
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 05:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B91210F0;
	Sun, 20 Aug 2023 05:58:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EC10E1
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 05:58:26 +0000 (UTC)
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [IPv6:2001:41d0:203:375::1b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE285FC4
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 21:20:05 -0700 (PDT)
Message-ID: <e9e1fcb5-3c09-b269-8f28-3808d827c2f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692505203; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlXDz1+tN+G7M+eYjOpKPWr6j4YKli9xnctkaxcLTII=;
	b=YxHep5HB5VamjjR+AzsylPZEhKEIZKh22cHzlDouka1eL60rENMZnqBFgKOuKt+krZahc6
	zjlB+6rHXE0NBnOzeZ55QQflESG2kkruyN0V3QNXrQQrl2P35SjKmNsKbqV8UtE6gMUwmQ
	sl+7wxH0n51/qPM1SFsreiIYoaUx4F8=
Date: Sat, 19 Aug 2023 21:19:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 09/15] bpf: Mark OBJ_RELEASE argument as MEM_RCU
 when possible
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172857.1366162-1-yonghong.song@linux.dev>
 <CAP01T76BxK=OR8es4_GByNpZn_WVBDDQQELgSgkJwUh0=q_CYg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP01T76BxK=OR8es4_GByNpZn_WVBDDQQELgSgkJwUh0=q_CYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 6:44 PM, Kumar Kartikeya Dwivedi wrote:
> On Mon, 14 Aug 2023 at 23:00, Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> In previous selftests/bpf patch, we have
>>    p = bpf_percpu_obj_new(struct val_t);
>>    if (!p)
>>            goto out;
>>
>>    p1 = bpf_kptr_xchg(&e->pc, p);
>>    if (p1) {
>>            /* race condition */
>>            bpf_percpu_obj_drop(p1);
>>    }
>>
>>    p = e->pc;
>>    if (!p)
>>            goto out;
>>
>> After bpf_kptr_xchg(), we need to re-read e->pc into 'p'.
>> This is due to that the second argument of bpf_kptr_xchg() is marked
>> OBJ_RELEASE and it will be marked as invalid after the call.
>> So after bpf_kptr_xchg(), 'p' is an unknown scalar,
>> and the bpf program needs to reread from the map value.
>>
>> This patch checks if the 'p' has type MEM_ALLOC and MEM_PERCPU,
>> and if 'p' is RCU protected. If this is the case, 'p' can be marked
>> as MEM_RCU. MEM_ALLOC needs to be removed since 'p' is not
>> an owning reference any more. Such a change makes re-read
>> from the map value unnecessary.
>>
>> Note that re-reading 'e->pc' after bpf_kptr_xchg() might get
>> a different value from 'p' if immediately before 'p = e->pc',
>> another cpu may do another bpf_kptr_xchg() and swap in another value
>> into 'e->pc'. If this is the case, then 'p = e->pc' may
>> get either 'p' or another value, and race condition already exists.
>> So removing direct re-reading seems fine too.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6fc200cb68b6..6fa458e13bfc 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8854,8 +8854,15 @@ static int release_reference(struct bpf_verifier_env *env,
>>                  return err;
>>
>>          bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
>> -               if (reg->ref_obj_id == ref_obj_id)
>> -                       mark_reg_invalid(env, reg);
>> +               if (reg->ref_obj_id == ref_obj_id) {
>> +                       if (in_rcu_cs(env) && (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
> 
> Wouldn't this check also be true in case of bpf_percpu_obj_drop(p)
> inside RCU CS/non-sleepable prog?
> Do we want to permit access to p after drop in that case? I think it
> will be a bit unintuitive.
> I think we should preserve normal behavior for everything except for
> kptr_xchg of a percpu_kptr.

You are correct. Above condition also applies to bpf_percpu_obj_drop()
and we should should change MEM_ALLOC to MEM_RCU only for
bpf_percpu_obj_new(). Will fix.

> 
>> +                               reg->ref_obj_id = 0;
>> +                               reg->type &= ~MEM_ALLOC;
>> +                               reg->type |= MEM_RCU;
>> +                       } else {
>> +                               mark_reg_invalid(env, reg);
>> +                       }
>> +               }
>>          }));
>>
>>          return 0;
>> --
>> 2.34.1
>>
>>

