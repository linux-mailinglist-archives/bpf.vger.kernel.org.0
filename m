Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13C668948
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 02:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjAMBx3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 20:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjAMBx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 20:53:27 -0500
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583A61445
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 17:53:25 -0800 (PST)
Message-ID: <7e6d02ea-f9f7-2d09-bf10-ccd41b16a671@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673574803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33Ku8g/h4myxf2UTWuqY4sRCItNB1UVhMBs8WSvSEuE=;
        b=mCwR0Vm4mZ1nqSGgqju1K3rW340ihXvH6LXcqGEMqxa2ZXTrepriGReeuYvzoyZICi6plY
        5yclT87TQ9Gp4XoUk8lUfzLS8Su9YLPqsNKDCkv42PmzoDvZzy1U6JdngVUiKy0pJhI0hH
        e9ltXYPXk1wv8XXKSGGT4BC2k9Ew0uQ=
Date:   Thu, 12 Jan 2023 17:53:18 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v5 3/3] bpf: hash map, suppress false lockdep warning
To:     tong@infragraf.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org
References: <20230111092903.92389-1-tong@infragraf.org>
 <20230111092903.92389-3-tong@infragraf.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230111092903.92389-3-tong@infragraf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/11/23 1:29 AM, tong@infragraf.org wrote:
> +	/*
> +	 * The lock may be taken in both NMI and non-NMI contexts.
> +	 * There is a false lockdep warning (inconsistent lock state),
> +	 * if lockdep enabled. The potential deadlock happens when the
> +	 * lock is contended from the same cpu. map_locked rejects
> +	 * concurrent access to the same bucket from the same CPU.
> +	 * When the lock is contended from a remote cpu, we would
> +	 * like the remote cpu to spin and wait, instead of giving
> +	 * up immediately. As this gives better throughput. So replacing
> +	 * the current raw_spin_lock_irqsave() with trylock sacrifices
> +	 * this performance gain. atomic map_locked is necessary.
> +	 * lockdep_off is invoked temporarily to fix the false warning.
> +	 */
> +	lockdep_off();
>   	raw_spin_lock_irqsave(&b->raw_lock, flags);
> -	*pflags = flags;
> +	lockdep_on();

I am not very sure about the lockdep_off/on. Other than the false warning when 
using the very same htab map by both NMI and non-NMI context, I think the 
lockdep will still be useful to catch other potential issues. The commit 
c50eb518e262 ("bpf: Use separate lockdep class for each hashtab") has already 
solved this false alarm when NMI happens on one map and non-NMI happens on 
another map.

Alexei, what do you think? May be only land the patch 1 fix for now.

>   
> +	*pflags = flags;
>   	return 0;
>   }
>   
> @@ -172,7 +187,11 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>   				      unsigned long flags)
>   {
>   	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets - 1);
> +
> +	lockdep_off();
>   	raw_spin_unlock_irqrestore(&b->raw_lock, flags);
> +	lockdep_on();
> +
>   	__this_cpu_dec(*(htab->map_locked[hash]));
>   	preempt_enable();
>   }

