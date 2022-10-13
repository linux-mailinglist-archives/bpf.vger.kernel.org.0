Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE45FD1DC
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 02:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiJMAzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 20:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiJMAyv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 20:54:51 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867093FED2;
        Wed, 12 Oct 2022 17:51:48 -0700 (PDT)
Message-ID: <1e01ab5a-c171-0b7a-751a-9ba7da4cd5dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665622237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/4PQl6S8K8YKQWiw/lI3bN5DKyscYp+FE64FP1WhMc=;
        b=vwmhvq8re7hbiOG4qBRSk4FXZM/nzGus4gj56imZuUUEOGAxRTzr7oem1Nr2XYucFaM8ws
        9tblSdKkJ607zHYuoMz3/+F/LF5zj97zTGnXJS4b8/gu3zTke9pJcpEx3Hyq0nDR7WTSm/
        xIu1wnErkWQRoNRpyICmTSuwHnEpFGM=
Date:   Wed, 12 Oct 2022 17:50:33 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] bpf/btf: Fix is_int_ptr()
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20221012125815.76120-1-zhouchengming@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221012125815.76120-1-zhouchengming@bytedance.com>
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

On 10/12/22 5:58 AM, Chengming Zhou wrote:
> When tracing a kernel function with arg type is u32*, btf_ctx_access()
> would report error: arg2 type INT is not a struct.
> 
> The commit bb6728d75611 ("bpf: Allow access to int pointer arguments
> in tracing programs") added support for int pointer, but don't skip
> modifiers before checking it's type. This patch fixes it.

A selftest is needed.  You can refer to the selftest added in the patch set [0] 
of the commit bb6728d75611.

This belongs to bpf-next.  Please tag it as bpf-next and also v2 in the next 
revision:
Documentation/bpf/bpf_devel_QA.rst  (Q: How do I indicate which tree....)

[0]: https://lore.kernel.org/bpf/20211208193245.172141-2-jolsa@kernel.org/

> 
> Fixes: bb6728d75611 ("bpf: Allow access to int pointer arguments in tracing programs")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   kernel/bpf/btf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index eba603cec2c5..2b343c42ed10 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5316,8 +5316,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
>   	/* t comes in already as a pointer */
>   	t = btf_type_by_id(btf, t->type);
>   
> -	/* allow const */
> -	if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
> +	/* skip modifiers */
> +	while (btf_type_is_modifier(t))

There is btf_type_skip_modifiers() that should be useful here.

>   		t = btf_type_by_id(btf, t->type);
>   
>   	return btf_type_is_int(t);

