Return-Path: <bpf+bounces-6139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A0766120
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE72282593
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA517CB;
	Fri, 28 Jul 2023 01:16:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E27C;
	Fri, 28 Jul 2023 01:16:27 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D937930E1;
	Thu, 27 Jul 2023 18:16:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686e0213c0bso1209471b3a.1;
        Thu, 27 Jul 2023 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690506985; x=1691111785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvFN6hiDGiGK7bLL2rKPH9uniCD9C1RLgo5XQErJ7mg=;
        b=WNQS724lJFU/8U7drNhRHsl4iM2XrqT1FV0aKjC/uhLfIHNHYairlvvM4qE3F86Wz5
         2ofxJTR69We2Aa+KTi7ZjWWdO9rlbsxRpprU15XR4VGBQPeEO0A2swgBYpCKCRf2TOGa
         j04xrvr/6HijktwqrhB0OFBn3cNuEXqU1/Ke69+Fvqg0KfNy6HwXo+V6SmfMvshXIIDZ
         WwB1UKt0Nu1Se8jQgcVtpap7it47yJ1kHLaI70TjXU3YlPc9fWTK9F4wP57YZgxPnjAZ
         E0vtX/SW+5brPenb8z32j5N1dxxOPQQmp6Mvvj93HBng/fDfxFbNt6oZP3Wnn0MdY+HY
         UbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690506985; x=1691111785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvFN6hiDGiGK7bLL2rKPH9uniCD9C1RLgo5XQErJ7mg=;
        b=e9vpB4b2zjiBaILAacr6oyfNhjMg2SkHPvUun4rExIqlW7B4ejFKgEUzAnRUWf7p9D
         Sq4FNHKz4GJ9wa188V7M+arL5/0nEwFzCIwaz7qsydAgf5uZHDs1/4szed0sScdrjFU8
         pUJkIhlN+EcuxxQnYCek4NIldX7fOJCAUMyjCI16Eb78NiLCAUsfpZ+Od4gEsqYd1ry+
         OfZKaZ1ZHtRMyNu/qvpR9J708GSUv4sI4H2NzNXBmufkqwmRIG5nFK0Fx37Wqp4kWpYw
         TQG62XAkIFZZH2RPXFuBPPZiuYYMQdpJrOqbZ3LPm9psenypr1cICK4g0czKMkknInbV
         iBHA==
X-Gm-Message-State: ABy/qLYDXE2Xgm9dfvyL1UZ6US1K22r2SHYa2ug9PkPMaX4lWl/aZfMi
	r11uQeP3vb2K98suKuZ021I=
X-Google-Smtp-Source: APBJJlEQxj3AXhexx+T1jcS0M1kRwMJQ/M8+DVCgVJU2/umqW4WqnvR5Hudlmguh8vmRTEe8M90YPQ==
X-Received: by 2002:a05:6a20:9494:b0:137:a08b:8c04 with SMTP id hs20-20020a056a20949400b00137a08b8c04mr263393pzb.48.1690506985206;
        Thu, 27 Jul 2023 18:16:25 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:400::5:6cea])
        by smtp.gmail.com with ESMTPSA id y15-20020a637d0f000000b00563b36264besm2187863pgc.85.2023.07.27.18.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 18:16:24 -0700 (PDT)
Date: Thu, 27 Jul 2023 18:16:20 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, kadlec@netfilter.org, edumazet@google.com,
	ast@kernel.org, fw@strlen.de, kuba@kernel.org, pabeni@redhat.com,
	pablo@netfilter.org, andrii@kernel.org, davem@davemloft.net,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next v6 2/5] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <20230728011620.psvselzqdm7ku5e4@macbook-pro-8.dhcp.thefacebook.com>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
 <5cff26f97e55161b7d56b09ddcf5f8888a5add1d.1689970773.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cff26f97e55161b7d56b09ddcf5f8888a5add1d.1689970773.git.dxu@dxuuu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 02:22:46PM -0600, Daniel Xu wrote:
> This commit adds support for enabling IP defrag using pre-existing
> netfilter defrag support. Basically all the flag does is bump a refcnt
> while the link the active. Checks are also added to ensure the prog
> requesting defrag support is run _after_ netfilter defrag hooks.
> 
> We also take care to avoid any issues w.r.t. module unloading -- while
> defrag is active on a link, the module is prevented from unloading.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/uapi/linux/bpf.h       |   5 ++
>  net/netfilter/nf_bpf_link.c    | 123 +++++++++++++++++++++++++++++----
>  tools/include/uapi/linux/bpf.h |   5 ++
>  3 files changed, 118 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 739c15906a65..12a5480314a2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1187,6 +1187,11 @@ enum bpf_perf_event_type {
>   */
>  #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
>  
> +/* link_create.netfilter.flags used in LINK_CREATE command for
> + * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
> + */
> +#define BPF_F_NETFILTER_IP_DEFRAG (1U << 0)
> +
>  /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
>   * the following extensions:
>   *
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index c36da56d756f..8fe594bbc7e2 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/bpf.h>
>  #include <linux/filter.h>
> +#include <linux/kmod.h>
> +#include <linux/module.h>
>  #include <linux/netfilter.h>
>  
>  #include <net/netfilter/nf_bpf_link.h>
> @@ -23,8 +25,88 @@ struct bpf_nf_link {
>  	struct nf_hook_ops hook_ops;
>  	struct net *net;
>  	u32 dead;
> +	const struct nf_defrag_hook *defrag_hook;
>  };
>  
> +static const struct nf_defrag_hook *
> +get_proto_defrag_hook(struct bpf_nf_link *link,
> +		      const struct nf_defrag_hook __rcu *global_hook,
> +		      const char *mod)
> +{
> +	const struct nf_defrag_hook *hook;
> +	int err;
> +
> +	/* RCU protects us from races against module unloading */
> +	rcu_read_lock();
> +	hook = rcu_dereference(global_hook);
> +	if (!hook) {
> +		rcu_read_unlock();
> +		err = request_module(mod);
> +		if (err)
> +			return ERR_PTR(err < 0 ? err : -EINVAL);
> +
> +		rcu_read_lock();
> +		hook = rcu_dereference(global_hook);
> +	}
> +
> +	if (hook && try_module_get(hook->owner)) {
> +		/* Once we have a refcnt on the module, we no longer need RCU */
> +		hook = rcu_pointer_handoff(hook);
> +	} else {
> +		WARN_ONCE(!hook, "%s has bad registration", mod);
> +		hook = ERR_PTR(-ENOENT);
> +	}
> +	rcu_read_unlock();
> +
> +	if (!IS_ERR(hook)) {
> +		err = hook->enable(link->net);
> +		if (err) {
> +			module_put(hook->owner);
> +			hook = ERR_PTR(err);
> +		}
> +	}
> +
> +	return hook;

The rcu + module_get logic looks correct to me, but you've dropped all Florian's acks.
What's going on?

We need explicit acks to merge this through bpf-next.

