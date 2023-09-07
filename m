Return-Path: <bpf+bounces-9427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD7D797737
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72AA1C20CA5
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A46134C2;
	Thu,  7 Sep 2023 16:23:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3E12B6A
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:23:27 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8838C4C0A
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 09:23:12 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76f0807acb6so66132185a.1
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694103720; x=1694708520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFJeWKSBFQ9s+pM6/GAF1JD2E7z5XbK3jeVcGgIky0s=;
        b=TbSeG260GTPT4qAqiyuC9DujTu/lyrTPYAj01s1Eg+yS0JO+ljQS49Y0mqFcofVC6w
         uN1Fy13QM5ezmS+uueDpNikDCSrL3LpeI5rFCWtTUJlTX9VfPXCVvcZCPkB5Y06zC6dw
         A4ZUSZvaqlE+rz56R0VTIfYatk/KkbyzH/no5+hmr6F9jY5Ct0GlTxdpFV+aA1Cyz2M/
         heFgrn6v+DvzM9muLzUsw5gdYSSJzyu7PU44FPEElATrYYXsy310trQiIT7VJfcKKS8i
         ZijKgst2/bvwW8X0Jcj4ienPg1Otfd1FDwD7FyPgYCR9fYpH0hlJbaCZO9QeGbnOq+gy
         tZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103720; x=1694708520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zFJeWKSBFQ9s+pM6/GAF1JD2E7z5XbK3jeVcGgIky0s=;
        b=dv26d9ltnwRobjtQmLEKnk16JA9Y7FnroshZ7zeUueyWVeRJoGJcPcXZeEhbXFBB8F
         b7g/VQ8IiIPwuDxHbWzwwxIMjsGlhGKnZejv6Nr97AdiMB2UjgICofdfoCjgvo8v4DGy
         z/yC3TiZv/k6+VGi55EMjHpYhnyhexG6Qcs8SBxnIkLal37rvbbi3gLTHtT5HSZWUU4F
         Uvn8BAt/N5v92wOVUGW4YpLCW9als7JkOFtbls5Ja99sOshLfwk4GUCWPTmy0+bGzE4O
         iNm777IxABZcxV86LYf22EKYqhmO5+YBazViOZXxfNyfcZy08bazPYX8kFrFnPbXztlH
         S6jQ==
X-Gm-Message-State: AOJu0YxHk8qloWeCXYSdm7DgY4kD2q8AbSgxJhOo2SrNFMuqhXOvAjK8
	MoRfkM68XjpLoS4mwcC8ZhZXH7piZvKerx5tSDE=
X-Google-Smtp-Source: AGHT+IG+rSvacO9rHqr6N1+W3lw5GRcqJOtCUKh0uMMSa4vqE7HuDQQ6tp0Ol/iFld40s6YJ50eLuw==
X-Received: by 2002:a17:90b:212:b0:271:ae19:c608 with SMTP id fy18-20020a17090b021200b00271ae19c608mr17569510pjb.41.1694088146743;
        Thu, 07 Sep 2023 05:02:26 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ik21-20020a170902ab1500b001b9f032bb3dsm12934327plb.3.2023.09.07.05.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 05:02:26 -0700 (PDT)
Message-ID: <c24a5de1-33c6-0469-9902-27292660654e@bytedance.com>
Date: Thu, 7 Sep 2023 20:02:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-3-zhouchuyi@bytedance.com>
 <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
 <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com>
 <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,
在 2023/9/7 01:17, Alexei Starovoitov 写道:
[...cut...]
>>> This iter can be used in all ctx-s which is nice, but let's
>>> make the verifier enforce rcu_read_lock/unlock done by bpf prog
>>> instead of doing in the ctor/dtor of iter, since
>>> in sleepable progs the verifier won't recognize that body is RCU CS.
>>> We'd need to teach the verifier to allow bpf_iter_process_new()
>>> inside in_rcu_cs() and make sure there is no rcu_read_unlock
>>> while BPF_ITER_STATE_ACTIVE.
>>> bpf_iter_process_destroy() would become a nop.
>>
>> Thanks for your review!
>>
>> I think bpf_iter_process_{new, next, destroy} should be protected by
>> bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable or
>> not, right?
> 
> Correct. By explicit bpf_rcu_read_lock() in case of sleepable progs
> or just by using them in normal bpf progs that have implicit rcu_read_lock()
> done before calling into them.
Thanks for your explanation, I missed the latter.
> 
>> I'm not very familiar with the BPF verifier, but I believe
>> there is still a risk in directly calling these kfuns even if
>> in_rcu_cs() is true.
>>
>> Maby what we actually need here is to enforce BPF verifier to check
>> env->cur_state->active_rcu_lock is true when we want to call these kfuncs.
> 
> active_rcu_lock means explicit bpf_rcu_read_lock.
> Currently we do allow bpf_rcu_read_lock in non-sleepable, but it's pointless.
> 
> Technically we can extend the check:
>                  if (in_rbtree_lock_required_cb(env) && (rcu_lock ||
> rcu_unlock)) {
>                          verbose(env, "Calling
> bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
>                          return -EACCES;
>                  }
> to discourage their use in all non-sleepable, but it will break some progs.
> 
> I think it's ok to check in_rcu_cs() to allow bpf_iter_process_*().
> If bpf prog adds explicit and unnecessary bpf_rcu_read_lock() around
> the iter ops it won't do any harm.
> Just need to make sure that rcu unlock logic:
>                  } else if (rcu_unlock) {
>                          bpf_for_each_reg_in_vstate(env->cur_state,
> state, reg, ({
>                                  if (reg->type & MEM_RCU) {
>                                          reg->type &= ~(MEM_RCU |
> PTR_MAYBE_NULL);
>                                          reg->type |= PTR_UNTRUSTED;
>                                  }
>                          }));
> clears iter state that depends on rcu.
> 
> I thought about changing mark_stack_slots_iter() to do
> st->type = PTR_TO_STACK | MEM_RCU;
> so that the above clearing logic kicks in,
> but it might be better to have something iter specific.
> is_iter_reg_valid_init() should probably be changed to
> make sure reg->type is not UNTRUSTED.
> 
Maybe it's something looks like the following?

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..9185c4a40a21 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1172,7 +1172,15 @@ static bool is_dynptr_type_expected(struct 
bpf_verifier_env *env, struct bpf_reg

  static void __mark_reg_known_zero(struct bpf_reg_state *reg);

+static bool in_rcu_cs(struct bpf_verifier_env *env);
+
+/* check whether we are using bpf_iter_process_*() or bpf_iter_css_*() */
+static bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta)
+{
+
+}
  static int mark_stack_slots_iter(struct bpf_verifier_env *env,
+                                struct bpf_kfunc_call_arg_meta *meta,
                                  struct bpf_reg_state *reg, int insn_idx,
                                  struct btf *btf, u32 btf_id, int nr_slots)
  {
@@ -1193,6 +1201,12 @@ static int mark_stack_slots_iter(struct 
bpf_verifier_env *env,

                 __mark_reg_known_zero(st);
                 st->type = PTR_TO_STACK; /* we don't have dedicated reg 
type */
+               if (is_iter_need_rcu(meta)) {
+                       if (in_rcu_cs(env))
+                               st->type |= MEM_RCU;
+                       else
+                               st->type |= PTR_UNTRUSTED;
+               }
                 st->live |= REG_LIVE_WRITTEN;
                 st->ref_obj_id = i == 0 ? id : 0;
                 st->iter.btf = btf;
@@ -1281,6 +1295,8 @@ static bool is_iter_reg_valid_init(struct 
bpf_verifier_env *env, struct bpf_reg_
                 struct bpf_stack_state *slot = &state->stack[spi - i];
                 struct bpf_reg_state *st = &slot->spilled_ptr;

+               if (st->type & PTR_UNTRUSTED)
+                       return false;
                 /* only main (first) slot has ref_obj_id set */
                 if (i == 0 && !st->ref_obj_id)
                         return false;

> Andrii,
> do you have better suggestions?

