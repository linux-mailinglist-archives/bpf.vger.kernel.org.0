Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E967634CDC
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 02:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiKWBTt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 20:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiKWBTe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 20:19:34 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51884DD3
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:19:32 -0800 (PST)
Message-ID: <dd614512-762d-d5e0-adb0-4ab480a03e69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669166370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYWMvRO4Ot1oUzMsqj9QBKuVbCjl55+bNajOab4CCwE=;
        b=JZjhRE9GsGTZ+3oUSs/YL+pTspuM9FuMfStK3fHlw2cCMqevhRbx3rFRSn85j5cAEFXxEl
        KufGOGLZ18XuSzeMt3ECVzVO0azKerECZjrpKXGDbTmYdnC60L6n7q9j7hUkcD71N/0jrs
        DgA7z8u19f2d0YJdeQu/jk2tamKMaF8=
Date:   Tue, 22 Nov 2022 17:19:28 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195335.1782147-1-yhs@fb.com>
 <3ee3af12-0542-e33c-2e9b-c6838de6ba64@linux.dev>
 <200910d3-23f2-e7e0-a03a-85d781d7341a@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <200910d3-23f2-e7e0-a03a-85d781d7341a@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/22/22 5:06 PM, Yonghong Song wrote:
> We should be okay here. flag is a local variable. It is used in
> below function when reg_type is not SCALAR_VALUE.
> 
> static void mark_btf_ld_reg(struct bpf_verifier_env *env,
>                              struct bpf_reg_state *regs, u32 regno,
>                              enum bpf_reg_type reg_type,
>                              struct btf *btf, u32 btf_id,
>                              enum bpf_type_flag flag)
> {
>          if (reg_type == SCALAR_VALUE) {
>                  mark_reg_unknown(env, regs, regno);

Ah, got it.

>>> @@ -11754,6 +11840,11 @@ static int check_ld_abs(struct bpf_verifier_env 
>>> *env, struct bpf_insn *insn)
>>>           return -EINVAL;
>>>       }
>>> +    if (env->prog->aux->sleepable && env->cur_state->active_rcu_lock) {
>>
>> I don't know the details about ld_abs :).  Why sleepable check is needed here?
> 
> Do we still care about ld_abs??
> 
> Actually I added this since spin_lock excludes this. But taking a deep

 From looking at check_ld_abs() again, I just noticed this comment:

         /* Disallow usage of BPF_LD_[ABS|IND] with reference tracking, as
          * gen_ld_abs() may terminate the program at runtime, leading to
          * reference leak.
          */

I think active_rcu_lock should be tested.  My question was more on why the 
env->prog->aux->sleepable test is also needed.

