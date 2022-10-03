Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6EF5F363A
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJCTVH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 15:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJCTVG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 15:21:06 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4236869;
        Mon,  3 Oct 2022 12:21:05 -0700 (PDT)
Message-ID: <b27deaa1-7ab2-a969-3475-4fa78db34f86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664824864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yRC3Hkc9Z0h2NdPQjTAEhCGDMQ/X2ETmgZ80q74nG8=;
        b=jfyH+cpjjSbDDS4oHbkZQdB17nEumLrcPT6OacVW7WQVGk5zfgw9Qsse+fTHUV6TC4b2rS
        qReiub1bK+fjsUsenFGQUMNOVaP9M0H0v05NaiILyLENYf9RjF/8z985cZACEtg9n4BzyP
        XleHP++iG6QDCBRaZC0uUH2/9eX88eg=
Date:   Mon, 3 Oct 2022 12:20:57 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] bpf: Add kfuncs for storing struct task_struct *
 as a kptr
Content-Language: en-US
To:     David Vernet <void@manifault.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        memxor@gmail.com
References: <20221001144716.3403120-1-void@manifault.com>
 <20221001144716.3403120-2-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221001144716.3403120-2-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/1/22 7:47 AM, David Vernet wrote:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b069517a3da0..36cbe1b8f8b1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1700,20 +1700,93 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>   	}
>   }
>   
> -BTF_SET8_START(tracing_btf_ids)
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in vmlinux BTF");
> +
> +/**
> + * bpf_task_acquire - Acquire a reference to a task. A task acquired by this
> + * kfunc which is not stored in a map as a kptr, must be released by calling
> + * bpf_task_release().
> + * @p: The task on which a reference is being acquired.
> + */
> +__used noinline
> +struct task_struct *bpf_task_acquire(struct task_struct *p)
> +{
> +	refcount_inc(&p->rcu_users);

This probably needs to be refcount_inc_not_zero() also for the cases like during 
the task free tracepoint ?
