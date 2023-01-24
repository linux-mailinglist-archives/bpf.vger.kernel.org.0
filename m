Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F467A368
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 20:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjAXTw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 14:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjAXTw1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 14:52:27 -0500
Received: from out-120.mta0.migadu.com (out-120.mta0.migadu.com [91.218.175.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B7A246
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 11:52:25 -0800 (PST)
Message-ID: <57a2e223-6fe8-7b7b-1b02-800665673ad1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674589942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPvGC2hjaO++BXZiINbs+zndP1/Wv/zj1n82glt9rFs=;
        b=OsXzY8BZkhWo9zklBPTbt7YwWYaKFVV7IiMJlyM6awVivxHXEbocqMQ6s5VgLU3lUMDErb
        OxRsNdTbbqyymzYrPcx+KCutDs3Lj3raBELStZNnYJRTLm58S85j9xvzdHPzn3vlykrd5d
        /pIKTPH2j9PsgSTV1CrZha8xbJkNkds=
Date:   Tue, 24 Jan 2023 11:52:17 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] bpf/selftests: Verify struct_ops prog
 sleepable behavior
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@meta.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, bpf@vger.kernel.org
References: <20230124160802.1122124-1-void@manifault.com>
 <20230124160802.1122124-5-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230124160802.1122124-5-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/23 8:08 AM, David Vernet wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 50123afab9bf..64034311c5f7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1474,6 +1474,7 @@ struct bpf_dummy_ops {
>   	int (*test_1)(struct bpf_dummy_ops_state *cb);
>   	int (*test_2)(struct bpf_dummy_ops_state *cb, int a1, unsigned short a2,
>   		      char a3, unsigned long a4);
> +	int (*test_3)(struct bpf_dummy_ops_state *cb);

nit. May be a self describe name like test_sleepable().

>   };
>   
>   int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index 1ac4467928a9..46099737d1da 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -154,6 +154,23 @@ static bool bpf_dummy_ops_is_valid_access(int off, int size,
>   	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
>   }
>   
> +static int bpf_dummy_ops_check_member(const struct btf_type *t,
> +				      const struct btf_member *member,
> +				      const struct bpf_prog *prog)
> +{
> +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> +
> +	switch (moff) {
> +	case offsetof(struct bpf_dummy_ops, test_3):
> +		break;
> +	default:
> +		if (prog->aux->sleepable)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
>   					   const struct bpf_reg_state *reg,
>   					   int off, int size, enum bpf_access_type atype,
> @@ -208,6 +225,7 @@ static void bpf_dummy_unreg(void *kdata)
>   struct bpf_struct_ops bpf_bpf_dummy_ops = {
>   	.verifier_ops = &bpf_dummy_verifier_ops,
>   	.init = bpf_dummy_init,
> +	.check_member = bpf_dummy_ops_check_member,
>   	.init_member = bpf_dummy_init_member,
>   	.reg = bpf_dummy_reg,
>   	.unreg = bpf_dummy_unreg,
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 8da0d73b368e..33ea57d34c0b 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -730,6 +730,10 @@ noinline void bpf_kfunc_call_test_destructive(void)
>   {
>   }
>   
> +noinline void bpf_kfunc_call_test_sleepable(void)
> +{
> +}
> +
>   __diag_pop();
>   
>   BTF_SET8_START(bpf_test_modify_return_ids)
> @@ -767,6 +771,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)

KF_SLEEPABLE kfunc is not specific to the struct_ops prog. I hope a test has 
already covered that KF_SLEEPABLE kfunc can only be called from sleepable prog. 
eg. there is bpf_fentry_test1.

This new kfunc could then be omitted and make the test simpler. There is no need 
to add the test to the DENYLIST.s390x: 
https://github.com/kernel-patches/bpf/actions/runs/3998188872/jobs/6861920516

> diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h b/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h
> new file mode 100644
> index 000000000000..7d0761594b69
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#ifndef _DUMMY_ST_OPS_COMMON_H
> +#define _DUMMY_ST_OPS_COMMON_H
> +
> +struct bpf_dummy_ops_state {
> +	int val;
> +} __attribute__((preserve_access_index));
> +
> +struct bpf_dummy_ops {
> +	int (*test_1)(struct bpf_dummy_ops_state *state);
> +	int (*test_2)(struct bpf_dummy_ops_state *state, int a1, unsigned short a2,
> +		      char a3, unsigned long a4);
> +	int (*test_3)(struct bpf_dummy_ops_state *state);
> +};

Instead of adding a new dummy_st_ops_common.h header, try to directly include 
vmlinux.h in the dummy_st_ops_{success,fail}.c.

> +
> +void bpf_kfunc_call_test_sleepable(void) __ksym;

