Return-Path: <bpf+bounces-6743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BDD76D7A6
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D34A281962
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D545107B2;
	Wed,  2 Aug 2023 19:23:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92D101DD
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 19:23:10 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A13103
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:23:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63d4f1cb5a9so263796d6.1
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691004188; x=1691608988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrZkXKUzJBxZJE5P9xQ1/tyjeF6B+g/d/Mzie4Zdojo=;
        b=rl4QSDmQikFMrky2QpfmQlTJxRUuwYZZ/QxXx3udpO0+bEviyZmJbfWTnZjweX+NPw
         PyzYYTVv8mRuZiMLx1ZVd178ahXT7/gmEgHEaqZZT4z72YnDJFB/MvDAXJBWBHS7nJgp
         RV8ZviOr9cju6ps3reM3axd/ZBiTqjBHL0rPcy7CHhamU5AvUX9HOZvzqKQ2qfowUgQN
         TYzXw0NFFKkqUSMlbmTWoMLF/lulFRYbJEcVzcXWUhWxlxqCTOFE3wd1Csxu5Q5q+a9P
         3UWhZPzECslWfKTe7Uq8zIxQa7D7k00zW8LkNINEFzw5w22yLfmcvCPYAQQPGU9U/dvZ
         szsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691004188; x=1691608988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrZkXKUzJBxZJE5P9xQ1/tyjeF6B+g/d/Mzie4Zdojo=;
        b=hIRE96jjQ3V15w3Ho5EbNkMoWP1wGTNEnhidcsIKAFtPDYBYP7d/3+zZR6iUtuyAbv
         vKE1bsdI+4teVbe0evo6QeL+6CiAcpl3qTQYvEE3nInWskJ46+iXIoCBSe+h1q7lT8EQ
         VFJurtLCXU+eal7x5U+ceLtX6A269Q+hC7oM70PLaMTR8TQjXjczhZxRL1gdHBs99goi
         2zQ7RMghmuvxQvrznFsuYVYyJFqxPkI2fbQKlItOOK37dri52KjXvWiO+5Vuk0bvcscI
         ceJ2+4tlr055YZV/q+q7bRqj6SF5XRdsNQ4KPybW+F9dH6W5MdKmwHznyAvYS7ijhIih
         y3Xg==
X-Gm-Message-State: ABy/qLavpa/8m3If+ePMIAV1GKt6/aUaGCxTISpeIHGRPM7P2umQR5Zu
	fxy2o5hnmN+FctIFC/zJYow=
X-Google-Smtp-Source: APBJJlFo1Mm+z4zHfBT4z582NlPilfvLC608/eQfYdrW0j9I6znN6yaxWPwkTuCo5qC+hIz2YGku+Q==
X-Received: by 2002:a05:6214:2521:b0:616:870c:96b8 with SMTP id gg1-20020a056214252100b00616870c96b8mr17455037qvb.3.1691004188052;
        Wed, 02 Aug 2023 12:23:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1245:9:cc8:9dd5:89e:9c52? ([2620:10d:c091:500::5:c6ed])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0063d0f1db105sm5837672qvm.32.2023.08.02.12.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 12:23:07 -0700 (PDT)
Message-ID: <a139645d-7949-30c7-5a6d-00f288babd81@gmail.com>
Date: Wed, 2 Aug 2023 15:23:06 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 bpf-next 1/7] bpf: Ensure kptr_struct_meta is non-NULL
 for collection insert and refcount_acquire
Content-Language: en-US
To: yonghong.song@linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-2-davemarchevsky@fb.com>
 <9643d04f-8102-b5b3-1edf-34b4e08485df@linux.dev>
From: Dave Marchevsky <davemarchevsky@gmail.com>
In-Reply-To: <9643d04f-8102-b5b3-1edf-34b4e08485df@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 11:57 PM, Yonghong Song wrote:
> 
> 
> On 8/1/23 1:36 PM, Dave Marchevsky wrote:
>> It's straightforward to prove that kptr_struct_meta must be non-NULL for
>> any valid call to these kfuncs:
>>
>>    * btf_parse_struct_metas in btf.c creates a btf_struct_meta for any
>>      struct in user BTF with a special field (e.g. bpf_refcount,
>>      {rb,list}_node). These are stored in that BTF's struct_meta_tab.
>>
>>    * __process_kf_arg_ptr_to_graph_node in verifier.c ensures that nodes
>>      have {rb,list}_node field and that it's at the correct offset.
>>      Similarly, check_kfunc_args ensures bpf_refcount field existence for
>>      node param to bpf_refcount_acquire.
>>
>>    * So a btf_struct_meta must have been created for the struct type of
>>      node param to these kfuncs
>>
>>    * That BTF and its struct_meta_tab are guaranteed to still be around.
>>      Any arbitrary {rb,list} node the BPF program interacts with either:
>>      came from bpf_obj_new or a collection removal kfunc in the same
>>      program, in which case the BTF is associated with the program and
>>      still around; or came from bpf_kptr_xchg, in which case the BTF was
>>      associated with the map and is still around
>>
>> Instead of silently continuing with NULL struct_meta, which caused
>> confusing bugs such as those addressed by commit 2140a6e3422d ("bpf: Set
>> kptr_struct_meta for node param to list and rbtree insert funcs"), let's
>> error out. Then, at runtime, we can confidently say that the
>> implementations of these kfuncs were given a non-NULL kptr_struct_meta,
>> meaning that special-field-specific functionality like
>> bpf_obj_free_fields and the bpf_obj_drop change introduced later in this
>> series are guaranteed to execute.
> 
> The subject says '... for collection insert and refcount_acquire'.
> Why picks these? We could check for all kptr_struct_meta use cases?
> 

fixup_kfunc_call sets kptr_struct_meta arg for the following kfuncs:

  - bpf_obj_new_impl
  - bpf_obj_drop_impl
  - collection insert kfuncs
    - bpf_rbtree_add_impl
    - bpf_list_push_{front,back}_impl
  - bpf_refcount_acquire_impl

A ﻿btf_struct_meta is only created for a struct if it has a non-null btf_record,
which in turn only happens if the struct has any special fields (spin_lock,
refcount, {rb,list}_node, etc.). Since it's valid to call bpf_obj_new on a
struct type without any special fields, the kptr_struct_meta arg can be
NULL. The result of such bpf_obj_new allocation must be bpf_obj_drop-able, so
the same holds for that kfunc.

By definition rbtree and list nodes must be some struct type w/
struct bpf_{rb,list}_node field, and similar logic for refcounted, so if there's
no kptr_struct_meta for their node arg, there was some verifier-internal issue.


>>
>> This patch doesn't change functionality, just makes it easier to reason
>> about existing functionality.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e7b1af016841..ec37e84a11c6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18271,6 +18271,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>           struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>>           struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>>   +        if (desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
> 
> Why check for KF_bpf_refcount_acquire_impl? We can cover all cases in this 'if' branch, right?
> 

The body of this 'else if' also handles kptr_struct_meta setup for bpf_obj_drop,
for which NULL kptr_struct_meta is valid. 

>> +            !kptr_struct_meta) {
>> +            verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
>> +                insn_idx);
>> +            return -EFAULT;
>> +        }
>> +
>>           insn_buf[0] = addr[0];
>>           insn_buf[1] = addr[1];
>>           insn_buf[2] = *insn;
>> @@ -18278,6 +18285,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>       } else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>>              desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>>              desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>> +        struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>>           int struct_meta_reg = BPF_REG_3;
>>           int node_offset_reg = BPF_REG_4;
>>   @@ -18287,6 +18295,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>               node_offset_reg = BPF_REG_5;
>>           }
>>   +        if (!kptr_struct_meta) {
>> +            verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
>> +                insn_idx);
>> +            return -EFAULT;
>> +        }
>> +
>>           __fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
>>                           node_offset_reg, insn, insn_buf, cnt);
>>       } else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
> 
> In my opinion, such selective defensive programming is not necessary. By searching kptr_struct_meta in the code, it is reasonably easy to find
> whether we have any mismatch or not. Also self test coverage should
> cover these cases (probably already) right?
> 
> If the defensive programming here is still desirable to warn at verification time, I think we should just check all of uses for kptr_struct_meta.

Something like this patch probably should've been included with the series
containing 2140a6e3422d ("bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs"),
since that commit found that kptr_struct_meta wasn't being set for collection
insert kfuncs and fixed the issue. It was annoyingly hard to root-cause
because, among other things, many of these kfunc impls check that
the btf_struct_meta is non-NULL before using it, with some fallback logic.
I don't like those unnecessary NULL checks either, and considered removing
them in this patch, but decided to leave them in since we already had
a case where struct_meta wasn't being set.

On second thought, maybe it's better to take the unnecessary runtime checks
out and leave these verification-time checks in. If, at runtime, those kfuncs
see a NULL btf_struct_meta, I'd rather they fail loudly in the future
with a NULL deref splat, than potentially leaking memory or similarly
subtle failures. WDYT?

I don't feel particularly strongly about these verification-time checks,
but the level of 'selective defensive programming' here feels similar to
other 'verifier internal error' checks sprinkled throughout verifier.c,
so that argument doesn't feel very persuasive to me.



