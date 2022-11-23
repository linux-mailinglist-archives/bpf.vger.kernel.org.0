Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2F1636E66
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 00:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKWXau (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 18:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKWXak (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 18:30:40 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422540923
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 15:30:38 -0800 (PST)
Message-ID: <0bb01f0e-c19f-ad96-80e8-a51679f170c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669246237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZlM3yDTVqwg1bt0gabISXrqQft0gDdRvFIXzk8Hnug=;
        b=Bm9hyZ7FVtopzW+ohmg/CmKvrWIkBtWwnz5ziE5XjNsKUU1kb3Mf30okRagK9hWXd5NzDM
        QeTbH2sKIJapIa5tBcFxNKcfHEDU4MorCx+SAZznRakt2Sk2LikaWyNxR9F8ZQoXIZc7S2
        FvI7Rgb4TOEhezc9gpDjNfe0gLWxuB4=
Date:   Wed, 23 Nov 2022 15:30:33 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 0/4] bpf: Add bpf_rcu_read_lock() support
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221123045350.2322811-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221123045350.2322811-1-yhs@fb.com>
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

On 11/22/22 8:53 PM, Yonghong Song wrote:
> Currently, without rcu attribute info in BTF, the verifier treats
> rcu tagged pointer as a normal pointer. This might be a problem
> for sleepable program where rcu_read_lock()/unlock() is not available.
> For example, for a sleepable fentry program, if rcu protected memory
> access is interleaved with a sleepable helper/kfunc, it is possible
> the memory access after the sleepable helper/kfunc might be invalid
> since the object might have been freed then. Even without
> a sleepable helper/kfunc, without rcu_read_lock() protection,
> it is possible that the rcu protected object might be release
> in the middle of bpf program execution which may cause incorrect
> result.
> 
> To prevent above cases, enable btf_type_tag("rcu") attributes,
> introduce new bpf_rcu_read_lock/unlock() kfuncs and add verifier support.
> 
> In the rest of patch set, Patch 1 enabled btf_type_tag for __rcu
> attribute. Patche 2 added might_sleep in bpf_func_proto. Patch 3 added new
> bpf_rcu_read_lock/unlock() kfuncs and verifier support.
> Patch 4 added some tests for these two new kfuncs.
> 
> Changelogs:
>    v8 -> v9:
>      . remove sleepable prog check for ld_abs/ind checking in rcu read
>        lock region.
>      . fix a test failure with gcc-compiled kernel.
>      . a couple of other minor fixes.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

