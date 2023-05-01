Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4C6F2EA3
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 07:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjEAFwD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 01:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjEAFwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 01:52:03 -0400
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [91.218.175.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AFFE55
        for <bpf@vger.kernel.org>; Sun, 30 Apr 2023 22:52:01 -0700 (PDT)
Message-ID: <5ebd6775-2be4-76b3-d364-a4462663e32d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682920319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xd7o/8ktb31YJTb5UY/dFFJd1hUOFy4bCbYvmpp3wic=;
        b=V3GjdEZg60heAS2JfjjgYwONwqSmOv30SkzJxSsYbC1/yzaIREpVKEUYd4fPAE6mSmT9Jy
        XRrCGfU7UOEPkSEHZVcCnEbNMoTeU4k8G0lz3VcL6HLpTZcLDdk5Vl/h0OeKSuTvlpw5y0
        RwvB3W+yXrp95O3CXzjHXA2n8s9Ujik=
Date:   Sun, 30 Apr 2023 22:51:51 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Don't EFAULT for {g,s}setsockopt
 with wrong optlen
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230427200409.1785263-1-sdf@google.com>
 <20230427200409.1785263-2-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230427200409.1785263-2-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/27/23 1:04 PM, Stanislav Fomichev wrote:
> @@ -1881,8 +1886,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>   		.optname = optname,
>   		.current_task = current,
>   	};
> +	int orig_optlen;
>   	int ret;
>   
> +	orig_optlen = max_optlen;

For getsockopt, when the kernel's getsockopt finished successfully (the 
following 'if (!retval)' case), how about also setting orig_optlen to the kernel 
returned 'optlen'. For example, the user's orig_optlen is 8096 and the kernel 
returned optlen is 1024. If the bpf prog still sets the ctx.optlen to something 
 > PAGE_SIZE, -EFAULT will be returned.

>   	ctx.optlen = max_optlen;
>   	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
>   	if (max_optlen < 0)
> @@ -1922,6 +1929,11 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>   		goto out;
>   
>   	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
> +		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
> +			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
> +				     ctx.optlen, max_optlen);
> +			goto out;
> +		}
>   		ret = -EFAULT;
>   		goto out;
>   	}

