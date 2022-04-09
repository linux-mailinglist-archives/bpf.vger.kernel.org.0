Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682B14FA062
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 02:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiDIADu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 20:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiDIADt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 20:03:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D18363B25
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 17:01:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p25so3036518pfn.13
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h0GEIsJZYFuXMDkUeE7uZ8U8h/iIIfC+GRVVaV3xMnE=;
        b=RzfqwKGm5tVdVM64DgYd8zK7uAkIXkI9kfjPyEtlEte2uF/wwzBQMX1brw4gJwcV2/
         8vIKewoUEZmKWPJbnNj6YkvKEbYHCI7uLfHIbo2mL85n7NvRfM4FgEE787BMnKDh6fcc
         3qkhvowH3PmfxY3UofAVK3Q945pmSfa2rCrJqWHOw2VC2ONlNg4ZjVmy+rEB0tSYgCUQ
         FxJO4RaQXoNRcVjEh/YvLBMFu/9hHaLOA2sAgoRNDqmzN/cLrzRYkibzlHIADqyEFS0m
         gA8NgKMqjl4u0vJVGsDzOi4iNv5gcSBXOGPFSvu5Ql53PxobVxgq0rVHyKO6E89SeeDT
         QYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h0GEIsJZYFuXMDkUeE7uZ8U8h/iIIfC+GRVVaV3xMnE=;
        b=vsJcNlVWd6FpDvqKEZJBuW2kIUfXE8WOH0ztN41n+lNYiJCJ9MfaaYbaBeUR4LLwaV
         4cTUDBQagqWdsvi58JeOGcM2PTUtHElrh3hxnsS1Bk26byaF5/NbnWg1fqd2Cl09DQ/Z
         lTCPYznvT+u+Z9n2jmN2Fpoxp2uFCU1kD+H2eCaZ1/Likl3sLt/9RXzVljPmscf+wVg5
         HxPqfBfCSA4tYcQjxCyK+ZTMBKbTqHGBVjkRobuVRkQPz3L66LuWdzn3AOzck8E3AL8n
         0u9NYujvB0dLaJICa1hJjHL/UCCVVbYrB5ICh93PZPLBHHKoKmr5OqES8mWcrOQkFvKk
         xyKQ==
X-Gm-Message-State: AOAM531DoGd8w44Gt6KuZ0dHP6LmBocxI+O6oO7lD0Q2R3EQvSi4wJH4
        C3C8cHgDxzOlP/lSHVk/I00=
X-Google-Smtp-Source: ABdhPJz/XlnV1gqHnkZVryIcO/Xdk8Y6KL300ovTU3wkqTsMe6ryOmshaH6lxKJfzkSnT/qsuFoEmQ==
X-Received: by 2002:a63:a804:0:b0:398:e7d7:29ab with SMTP id o4-20020a63a804000000b00398e7d729abmr17272207pgf.138.1649462503459;
        Fri, 08 Apr 2022 17:01:43 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:4c4c])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a390d00b001c995e0a481sm13274065pjb.30.2022.04.08.17.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 17:01:43 -0700 (PDT)
Date:   Fri, 8 Apr 2022 17:01:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 2/5] bpf, x86: Create bpf_tramp_run_ctx on
 the caller thread's stack
Message-ID: <20220409000140.ldyzwtj7wepwgfox@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220407192552.2343076-1-kuifeng@fb.com>
 <20220407192552.2343076-3-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407192552.2343076-3-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 07, 2022 at 12:25:49PM -0700, Kui-Feng Lee wrote:
> -		if (!__bpf_prog_enter_sleepable(prog)) {
> +		if (!__bpf_prog_enter_sleepable(prog, NULL)) {
>  			/* recursion detected */
>  			bpf_prog_put(prog);
>  			return -EBUSY;
>  		}
>  		attr->test.retval = bpf_prog_run(prog, (void *) (long) attr->test.ctx_in);
> -		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats */);
> +		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats */, NULL);

Did you miss my comment from the previous review?
Please replace NULL with actual ctx and remove below checks:

> +
> +	if (run_ctx)
> +		run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
...
> -void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
> +void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_tramp_run_ctx *run_ctx)
>  	__releases(RCU)
>  {
> +	if (run_ctx)
> +		bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> +
...
> -u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
> +u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
>  {
>  	rcu_read_lock_trace();
>  	migrate_disable();
>  	might_fault();
> +
> +	if (run_ctx)
> +		run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);

Such 'if' in critical path should be avoided.
