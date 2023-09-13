Return-Path: <bpf+bounces-9907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C10E79EA1C
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32FA281F73
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC81EA7F;
	Wed, 13 Sep 2023 13:53:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE231A71E
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 13:53:22 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966C19B6
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:53:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-271d9823cacso5667371a91.1
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694613202; x=1695218002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQRcUm+dicKc2afZ/Gqrj2Fj+ICaKv8eoOYlCIBl2Jw=;
        b=D5KYB4S6gcLaAu83GRJHaFJqDbrrzfCSLigr0qi0Uuh++Ud0ql89lt9tDB/Av0b9Pj
         LAsStbEo7LylOacpTRwkP3t1rQ+qp+15XIokzRGY07a8pnq7rxFBIXvH7cuRAtGMv25T
         cXUDQkgMjO37XQxjZ+p5/HbnUCcRFlyjhpPcfYqs1oGfPQTacRTob28Se3yyUywLBlH6
         CbtPNUgFgvFAVr1dClpwXfMxsYBk/l2V4cbbwCTkz/rQzYNdYuIutAcnKUADQzIY8FWP
         Sz0ORK19LxBmk+11Ql8ithN3/FVlAck8d+5PPYTJFkz9wIBAZfSh/qjL2GcgyS9r96+R
         TIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694613202; x=1695218002;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EQRcUm+dicKc2afZ/Gqrj2Fj+ICaKv8eoOYlCIBl2Jw=;
        b=iLAuGwnwGkg6v+YjDfhP3YZC4hk4MleJOjj+1ttpUV0tbwW3fPQN0TdCwl38sNvYiY
         E2NpGdXvuyoPgltN1an9vWauN7gRjUdisqUdvuEDgJIDHTB7Xzo7ICC881pywd8RUaPi
         9YwieDoMAx9VPEq3ZoTIeXkJM3Q37Jjk2L2jlUmqLf6prmyVsHz/MQUVzsrVEmF4VG7s
         wJlB44GyQcRZdxJiAy5Tql4vht2zoS9zGD9eyNpjI99EeS8ttJAMTH7qkBsUGEmHMbg8
         6g8zTFak3yqjiv7GfuQKY3JKLIifMZgd2QwhIwGZQ/A0DOIQ4DomCi8cAfOLT5n7tjLV
         nQ8Q==
X-Gm-Message-State: AOJu0YwsSzm0QgovqlvosOrHVuuwRmF0ygkoT/9j2QiQTYvhooTMdFtu
	uFfZfkfh0MiGR2zzd9IuI2Twz1G+kHKQltG39P8=
X-Google-Smtp-Source: AGHT+IGpZ2pgKJ/Bn2bXyBiIo5cXiLvpWG/ED0PaWCC2DvmdFgOiT3qeviKRBjNAYEokv8zZXulK6A==
X-Received: by 2002:a17:90b:33cd:b0:26b:280b:d24c with SMTP id lk13-20020a17090b33cd00b0026b280bd24cmr2143873pjb.42.1694613201720;
        Wed, 13 Sep 2023 06:53:21 -0700 (PDT)
Received: from [10.254.99.16] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a74c800b0027360359b70sm1476328pjl.48.2023.09.13.06.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 06:53:21 -0700 (PDT)
Message-ID: <4c15c9fc-7c9f-9695-5c67-d3f214d04bd9@bytedance.com>
Date: Wed, 13 Sep 2023 21:53:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
From: Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next v2 5/6] bpf: teach the verifier to enforce
 css_iter and process_iter in RCU CS
To: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-6-zhouchuyi@bytedance.com>
In-Reply-To: <20230912070149.969939-6-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

在 2023/9/12 15:01, Chuyi Zhou 写道:
> css_iter and process_iter should be used in rcu section. Specifically, in
> sleepable progs explicit bpf_rcu_read_lock() is needed before use these
> iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
> use them directly.
> 
> This patch checks whether we are in rcu cs before we want to invoke
> bpf_iter_process_new and bpf_iter_css_{pre, post}_new in
> mark_stack_slots_iter(). If the rcu protection is guaranteed, we would
> let st->type = PTR_TO_STACK | MEM_RCU. is_iter_reg_valid_init() will
> reject if reg->type is UNTRUSTED.

I use the following BPF Prog to test this patch:

SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
int iter_task_for_each_sleep(void *ctx)
{
	struct task_struct *task;
	struct task_struct *cur_task = bpf_get_current_task_btf();

	if (cur_task->pid != target_pid)
		return 0;
	bpf_rcu_read_lock();
	bpf_for_each(process, task) {
		bpf_rcu_read_unlock();
		if (task->pid == target_pid)
			process_cnt += 1;
		bpf_rcu_read_lock();
	}
	bpf_rcu_read_unlock();
	return 0;
}

Unfortunately, we can pass the verifier.

Then I add some printk-messages before setting/clearing state to help debug:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d151e6b43a5f..35f3fa9471a9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1200,7 +1200,7 @@ static int mark_stack_slots_iter(struct 
bpf_verifier_env *env,
                 __mark_reg_known_zero(st);
                 st->type = PTR_TO_STACK; /* we don't have dedicated reg 
type */
                 if (is_iter_need_rcu(meta)) {
+                       printk("mark reg_addr : %px", st);
                         if (in_rcu_cs(env))
                                 st->type |= MEM_RCU;
                         else
@@ -11472,8 +11472,8 @@ static int check_kfunc_call(struct 
bpf_verifier_env *env, struct bpf_insn *insn,
                         return -EINVAL;
                 } else if (rcu_unlock) {
                         bpf_for_each_reg_in_vstate(env->cur_state, 
state, reg, ({
+                               printk("clear reg_addr : %px MEM_RCU : 
%d PTR_UNTRUSTED : %d\n ", reg, reg->type & MEM_RCU, reg->type & 
PTR_UNTRUSTED);
                                 if (reg->type & MEM_RCU) {
-                                       printk("clear reg addr : %lld", 
reg);
                                         reg->type &= ~(MEM_RCU | 
PTR_MAYBE_NULL);
                                         reg->type |= PTR_UNTRUSTED;
                                 }


The demsg log:

[  393.705324] mark reg_addr : ffff88814e40e200

[  393.706883] clear reg_addr : ffff88814d5f8000 MEM_RCU : 0 
PTR_UNTRUSTED : 0

[  393.707353] clear reg_addr : ffff88814d5f8078 MEM_RCU : 0 
PTR_UNTRUSTED : 0

[  393.708099] clear reg_addr : ffff88814d5f80f0 MEM_RCU : 0 
PTR_UNTRUSTED : 0
....
....

I didn't see ffff88814e40e200 is cleared as expected because 
bpf_for_each_reg_in_vstate didn't find it.

It seems when we are doing bpf_read_unlock() in the middle of iteration 
and want to clearing state through bpf_for_each_reg_in_vstate, we can 
not find the previous reg which we marked MEM_RCU/PTR_UNTRUSTED in 
mark_stack_slots_iter().

I thought maybe the correct answer here is operating the *iter_reg* 
parameter in mark_stack_slots_iter() direcly so we can find it in 
bpf_for_each_reg_in_vstate.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6a6827ba7a18..53330ddf2b3c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1218,6 +1218,12 @@ static int mark_stack_slots_iter(struct 
bpf_verifier_env *env,
                 mark_stack_slot_scratched(env, spi - i);
         }

+       if (is_iter_need_rcu(meta)) {
+               if (in_rcu_cs(env))
+                       reg->type |= MEM_RCU;
+               else
+                       reg->type |= PTR_UNTRUSTED;
+       }
         return 0;
  }

@@ -1307,7 +1315,8 @@ static bool is_iter_reg_valid_init(struct 
bpf_verifier_env *env, struct bpf_reg_
                         if (slot->slot_type[j] != STACK_ITER)
                                 Kumarreturn false;
         }
-
+       if (reg->type & PTR_UNTRUSTED)
+               return false;
         return true;
  }

However, it did not work either. The reason it didn't work is the state 
of iter_reg will be cleared implicitly before the 
is_iter_reg_valid_init() even we don't call bpf_rcu_unlock.

It would be appreciate if you could give some suggestion. Maby it worthy 
to try the solution proposed by Kumar?[1]

[1] 
https://lore.kernel.org/lkml/CAP01T77cWxWNwq5HLr+Woiu7k4-P3QQfJWX1OeQJUkxW3=P4bA@mail.gmail.com/#t




