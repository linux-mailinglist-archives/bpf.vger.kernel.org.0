Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7A6A89F5
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 21:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCBUBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 15:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBUBr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 15:01:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3CF4AFC1;
        Thu,  2 Mar 2023 12:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D1AE615FE;
        Thu,  2 Mar 2023 19:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9CBC433EF;
        Thu,  2 Mar 2023 19:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677787171;
        bh=NXLN0yCp+u/4afS6d7RtO524UIGXkLZf8f9v/XiFsrM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SKM64j5BTkAjauEKaSAmg7GpOBiwfx79sqdmL7fmI9glR2mYB730MiL9V8+A0TmpY
         ONZ7lX5PkBA+7zoGblzfoxTKkx1W6lPoHArrZw6qP440MPqCb/VY773u1qLSD+kNqq
         iIrcwVRYYPUO9DrmCzt7ohQL4rnuHYA7a3rRYUnPqa/NG0P5yFuCdpP6ztNY6v8FO4
         OkyXPY0dlhfz9a4EM6RLMd3LlJfRN+PbmqQ7c2GgPhb5HBMubBlJ5s9OhGy7zNv6TR
         UwUgwJBMvyEwbJu7zvLG0vtfokgW8tsXP/tKP6/L5er5zJdeGyfboa8eurL1oiCygP
         xk3YV2sRDfm6g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 89C91976265; Thu,  2 Mar 2023 20:59:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH RFC v2 bpf-next 3/3] bpf: minimal support for programs
 hooked into netfilter framework
In-Reply-To: <20230302172757.9548-4-fw@strlen.de>
References: <20230302172757.9548-1-fw@strlen.de>
 <20230302172757.9548-4-fw@strlen.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 02 Mar 2023 20:59:28 +0100
Message-ID: <87sfemexgf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> This adds minimal support for BPF_PROG_TYPE_NETFILTER bpf programs
> that will be invoked via the NF_HOOK() points in the ip stack.
>
> Invocation incurs an indirect call.  This is not a necessity: Its
> possible to add 'DEFINE_BPF_DISPATCHER(nf_progs)' and handle the
> program invocation with the same method already done for xdp progs.
>
> This isn't done here to keep the size of this chunk down.
>
> Verifier restricts verdicts to either DROP or ACCEPT.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  include/linux/bpf_types.h           |  4 ++
>  include/net/netfilter/nf_hook_bpf.h |  6 +++
>  kernel/bpf/btf.c                    |  5 ++
>  kernel/bpf/verifier.c               |  3 ++
>  net/netfilter/nf_bpf_link.c         | 78 ++++++++++++++++++++++++++++-
>  5 files changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index d4ee3ccd3753..39a999abb0ce 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -79,6 +79,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
>  #endif
>  BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
>  	      void *, void *)
> +#ifdef CONFIG_NETFILTER
> +BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
> +	      struct bpf_nf_ctx, struct bpf_nf_ctx)
> +#endif
>  
>  BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
> diff --git a/include/net/netfilter/nf_hook_bpf.h b/include/net/netfilter/nf_hook_bpf.h
> index 9d1b338e89d7..863cbbcc66f9 100644
> --- a/include/net/netfilter/nf_hook_bpf.h
> +++ b/include/net/netfilter/nf_hook_bpf.h
> @@ -1,2 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +
> +struct bpf_nf_ctx {
> +	const struct nf_hook_state *state;
> +	struct sk_buff *skb;
> +};
> +
>  int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ef2d8969ed1f..ec6eb78b9aec 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -25,6 +25,9 @@
>  #include <linux/bsearch.h>
>  #include <linux/kobject.h>
>  #include <linux/sysfs.h>
> +
> +#include <net/netfilter/nf_hook_bpf.h>
> +
>  #include <net/sock.h>
>  #include "../tools/lib/bpf/relo_core.h"
>  
> @@ -7726,6 +7729,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>  	case BPF_PROG_TYPE_LWT_XMIT:
>  	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
>  		return BTF_KFUNC_HOOK_LWT;
> +	case BPF_PROG_TYPE_NETFILTER:
> +		return BTF_KFUNC_HOOK_SOCKET_FILTER;

The dynptr patch reuses the actual set between the different IDs, so
this should probably define a new BTF_KFUNC_HOOK_NETFILTER, with an
associated register_btf_kfunc_id_set() call?

-Toke
