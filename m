Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB413636E6A
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 00:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKWXcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 18:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKWXcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 18:32:09 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18898A6581
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 15:32:09 -0800 (PST)
Message-ID: <7bcdf377-59e9-a774-2882-d53e494b37cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669246327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rrAwgHZ8XRFDVxHv+/cHHRy5aTlfeEpi6rVHqFq8Ug=;
        b=oHNHkiQL7JfogPC7kVF/VXcnp46egd6Vyok6oL/jiO8DF0gCnmkDSs+qIAJynou3XL5zzV
        +Y+LPPrUzA6bPtPZWg0Q8zMCPbRdgB5yFzBnBGBZMQVBsdyauVavr90sWYsXhoGvedR6eV
        LYsILVQIYgFCAK5MwYukxoEWbfb9quE=
Date:   Wed, 23 Nov 2022 15:32:05 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221123045350.2322811-1-yhs@fb.com>
 <20221123045406.2324479-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221123045406.2324479-1-yhs@fb.com>
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

On 11/22/22 8:54 PM, Yonghong Song wrote:
> @@ -7539,6 +7590,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>   		return err;
>   	}
>   
> +	if (env->cur_state->active_rcu_lock) {
> +		if (fn->might_sleep) {
> +			verbose(env, "sleepable helper %s#%din rcu_read_lock region\n",

A nit.  Missing a space before "in".

> +				func_id_name(func_id), func_id);
> +			return -EINVAL;
> +		}

