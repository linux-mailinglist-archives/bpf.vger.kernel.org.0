Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04506632D18
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKUTlR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 14:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUTlQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 14:41:16 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C7CC8CA2
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 11:41:14 -0800 (PST)
Message-ID: <ee7248b9-50ae-f4cf-5592-49634913b6ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669059673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bF0DzFuDya5CpgRdrCXNCLLobVQZXE8HQS2KxM57zRY=;
        b=vrwU2jIL9TQuOlB/575mCIFsIT9Ag00BFAtMLKXOJm4uA3jlf/ltD3TFcBHktZoX8SGw5D
        8gX+EIXAx/EpQVM72hkg5Uu4WG/5Wvl1DsoX9qJd+HUxuLV17Qr7fXUuNddX8nPdhl9BIr
        oWRbvZl7yTmDy/TCjauR1Uwk1o2rlRs=
Date:   Mon, 21 Nov 2022 11:41:09 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170530.1196341-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221121170530.1196341-1-yhs@fb.com>
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

On 11/21/22 9:05 AM, Yonghong Song wrote:
> @@ -4704,6 +4715,15 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>   		return -EACCES;
>   	}
>   
> +	/* Access rcu protected memory */
> +	if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
> +	    !env->cur_state->active_rcu_lock) {
> +		verbose(env,
> +			"R%d is ptr_%s access rcu-protected memory with off=%d, not rcu protected\n",
> +			regno, tname, off);
> +		return -EACCES;
> +	}
> +
>   	if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
>   		if (!btf_is_kernel(reg->btf)) {
>   			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
> @@ -4731,12 +4751,27 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>   	if (ret < 0)
>   		return ret;
>   
> +	/* The value is a rcu pointer. The load needs to be in a rcu lock region,
> +	 * similar to rcu_dereference().
> +	 */
> +	if ((flag & MEM_RCU) && env->prog->aux->sleepable && !env->cur_state->active_rcu_lock) {
> +		verbose(env,
> +			"R%d is rcu dereference ptr_%s with off=%d, not in rcu_read_lock region\n",
> +			regno, tname, off);
> +		return -EACCES;
> +	}

Would this make the existing rdonly use case fail?

SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
int task_real_parent(void *ctx)
{
	struct task_struct *task, *real_parent;

	task = bpf_get_current_task_btf();
         real_parent = task->real_parent;
         bpf_printk("pid %u\n", real_parent->pid);
         return 0;
}


