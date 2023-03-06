Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6566C6AB8D8
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 09:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCFIx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 03:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCFIx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 03:53:57 -0500
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [IPv6:2001:41d0:203:375::17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F89C660
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 00:53:56 -0800 (PST)
Message-ID: <7d5b8ac9-3c40-f4f2-2e6e-723bbfeb37c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678092834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lFKYPp8V2Hqz+Hep49bYiJD2z/1sqpG+QaVF39qOKTE=;
        b=AMbjiZRwiATLKy7lF8WaMzWQhFcILpJUGNE0v96f6x0wX432OX9Sv2gCaXUCyl0i0r70vF
        B9bvP2e1JPUWPNl5win9rydiLtlx964HOBHhe23M11YDlPCII95oS3UrSzhUNjfConQU3b
        S5TAhCI08tqRIW07jb8MRzjmiaC4358=
Date:   Mon, 6 Mar 2023 00:53:52 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 09/16] bpf: Add bpf_selem_free()
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20230306084216.3186830-1-martin.lau@linux.dev>
 <20230306084216.3186830-10-martin.lau@linux.dev>
In-Reply-To: <20230306084216.3186830-10-martin.lau@linux.dev>
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

On 3/6/23 12:42 AM, Martin KaFai Lau wrote:
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 8b0c9e4341eb..4fc078e8e9ca 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -197,7 +197,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>   		} else {
>   			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
>   			if (ret) {
> -				kfree(copy_selem);
> +				bpf_selem_free(selem, smap, true);
noticed there is a bug here, should be copy_selem. will fix.

>   				atomic_sub(smap->elem_size,
>   					   &newsk->sk_omem_alloc);
>   				bpf_map_put(map);

