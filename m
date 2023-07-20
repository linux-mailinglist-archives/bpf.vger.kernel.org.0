Return-Path: <bpf+bounces-5564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450B75BB0A
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 01:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959A91C21579
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 23:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CD1BE83;
	Thu, 20 Jul 2023 23:19:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06214011;
	Thu, 20 Jul 2023 23:19:27 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C874B2713;
	Thu, 20 Jul 2023 16:19:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qMcvI-0003Fw-2U; Fri, 21 Jul 2023 01:19:04 +0200
Date: Fri, 21 Jul 2023 01:19:04 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, kadlec@netfilter.org, ast@kernel.org,
	pablo@netfilter.org, kuba@kernel.org, davem@davemloft.net,
	andrii@kernel.org, edumazet@google.com, pabeni@redhat.com,
	fw@strlen.de, alexei.starovoitov@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next v5 2/5] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <20230720231904.GA31372@breakpoint.cc>
References: <cover.1689884827.git.dxu@dxuuu.xyz>
 <690a1b09db84547b0f0c73654df3f4950f1262b7.1689884827.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690a1b09db84547b0f0c73654df3f4950f1262b7.1689884827.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Xu <dxu@dxuuu.xyz> wrote:
> +	const struct nf_defrag_hook __maybe_unused *hook;
> +
> +	switch (link->hook_ops.pf) {
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> +	case NFPROTO_IPV4:
> +		hook = get_proto_defrag_hook(link, nf_defrag_v4_hook, "nf_defrag_ipv4");
> +		if (IS_ERR(hook))
> +			return PTR_ERR(hook);
> +
> +		link->defrag_hook = hook;
> +		return 0;
> +#endif
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> +	case NFPROTO_IPV6:
> +		hook = get_proto_defrag_hook(link, nf_defrag_v6_hook, "nf_defrag_ipv6");
> +		if (IS_ERR(hook))
> +			return PTR_ERR(hook);
> +
> +		link->defrag_hook = hook;
> +		return 0;
> +#endif
> +	default:
> +		return -EAFNOSUPPORT;
> +	}
> +}
> +
> +static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> +{
> +	const struct nf_defrag_hook *hook = link->defrag_hook;
> +
> +	if (!hook)
> +		return;
> +	hook->disable(link->net);
> +	module_put(hook->owner);
> +}
> +
>  static void bpf_nf_link_release(struct bpf_link *link)
>  {
>  	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
> @@ -37,6 +119,8 @@ static void bpf_nf_link_release(struct bpf_link *link)
>  	 */
>  	if (!cmpxchg(&nf_link->dead, 0, 1))
>  		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
> +
> +	bpf_nf_disable_defrag(nf_link);
>  }

I suspect this needs to be within the cmpxchg() branch to avoid
multiple ->disable() calls.

> +	if (attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) {
> +		err = bpf_nf_enable_defrag(link);
> +		if (err) {
> +			bpf_link_cleanup(&link_primer);
> +			return err;
> +		}
> +	}
> +
>  	err = nf_register_net_hook(net, &link->hook_ops);
>  	if (err) {
		bpf_nf_disable_defrag(link);

Other than those nits this lgtm, thanks!

