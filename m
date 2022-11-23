Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E69634BA3
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 01:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiKWAZC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 19:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiKWAZB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 19:25:01 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E320F7D
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 16:25:00 -0800 (PST)
Message-ID: <3ee3af12-0542-e33c-2e9b-c6838de6ba64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669163097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0p6YX2lvVVrHXUCNbH2MsvJjwf8+ZC5Uw1kuADOzmpM=;
        b=QLYS7D4+BaeKGDymeJbtefOVVmIpAGfZYIaumgMiPtQtA8Vgq/Bo4BV1ymd1lcFaq3ojEd
        9d/oCUFMSgaJ8ulY4rHZZQl1AGYeZW3mtNz8mZNCHwhf2qeWywA7yqoeQW7swS3ghLeswE
        Qi4rgLjUrJbqfCkdGq1EYmt09DCZ0js=
Date:   Tue, 22 Nov 2022 16:24:52 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195335.1782147-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221122195335.1782147-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/22/22 11:53 AM, Yonghong Song wrote:
> +	if (flag & MEM_RCU) {
> +		/* Mark value register as MEM_RCU only if it is protected by
> +		 * bpf_rcu_read_lock() and the ptr reg is trusted (PTR_TRUSTED or
> +		 * ref_obj_id != 0). MEM_RCU itself can already indicate
> +		 * trustedness inside the rcu read lock region. But Mark it
> +		 * as PTR_TRUSTED as well similar to MEM_ALLOC.
> +		 */
> +		if (!env->cur_state->active_rcu_lock ||
> +		    (!(reg->type & PTR_TRUSTED) && !reg->ref_obj_id))

Can is_trusted_reg() be reused or MEM_ALLOC is not applicable here?

> +			flag &= ~MEM_RCU;
> +		else
> +			flag |= PTR_TRUSTED;
> +	} else if (reg->type & MEM_RCU) {
> +		/* ptr (reg) is marked as MEM_RCU, but value reg is not marked as MEM_RCU.
> +		 * Mark the value reg as PTR_UNTRUSTED conservatively.
> +		 */
> +		flag |= PTR_UNTRUSTED;

Should PTR_UNTRUSTED tagging be limited to ret == PTR_TO_BTF_ID instead of 
tagging SCALAR also?

[ ... ]

> @@ -11754,6 +11840,11 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   		return -EINVAL;
>   	}
>   
> +	if (env->prog->aux->sleepable && env->cur_state->active_rcu_lock) {

I don't know the details about ld_abs :).  Why sleepable check is needed here?

Others lgtm.
