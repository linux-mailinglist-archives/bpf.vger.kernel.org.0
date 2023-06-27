Return-Path: <bpf+bounces-3557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A45673FAD6
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 13:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABD21C20AD9
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8F17748;
	Tue, 27 Jun 2023 11:13:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B7416427;
	Tue, 27 Jun 2023 11:13:00 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08181FF3;
	Tue, 27 Jun 2023 04:12:58 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qE6cq-0003Sm-6H; Tue, 27 Jun 2023 13:12:48 +0200
Date: Tue, 27 Jun 2023 13:12:48 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org,
	fw@strlen.de, pabeni@redhat.com, pablo@netfilter.org,
	andrii@kernel.org, davem@davemloft.net, ast@kernel.org,
	kadlec@netfilter.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 4/7] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <20230627111248.GH3207@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <242c66138bf4ec8aa26b29d736fb48242b4164ce.1687819413.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242c66138bf4ec8aa26b29d736fb48242b4164ce.1687819413.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Xu <dxu@dxuuu.xyz> wrote:
> +static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
> +{
> +	int err;
> +
> +	switch (link->hook_ops.pf) {
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> +	case NFPROTO_IPV4:
> +		const struct nf_defrag_v4_hook *v4_hook;
> +
> +		err = request_module("nf_defrag_ipv4");
> +		if (err)
> +			return err;
> +
> +		rcu_read_lock();
> +		v4_hook = rcu_dereference(nf_defrag_v4_hook);
> +		err = v4_hook->enable(link->net);
> +		rcu_read_unlock();

I'd reverse this, first try rcu_dereference(), then modprobe
if thats returned NULL.

> +static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> +{
> +	switch (link->hook_ops.pf) {
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> +	case NFPROTO_IPV4:
> +		const struct nf_defrag_v4_hook *v4_hook;
> +
> +		rcu_read_lock();
> +		v4_hook = rcu_dereference(nf_defrag_v4_hook);
> +		v4_hook->disable(link->net);
> +		rcu_read_unlock();

if (v4_hook)
	v4_hook->disable()

Else we get trouble on manual 'rmmod'.

> +	/* make sure conntrack confirm is always last */
> +	prio = attr->link_create.netfilter.priority;
> +	if (prio == NF_IP_PRI_FIRST)
> +		return -ERANGE;  /* sabotage_in and other warts */
> +	else if (prio == NF_IP_PRI_LAST)
> +		return -ERANGE;  /* e.g. conntrack confirm */
> +	else if ((attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) &&
> +		 (prio > NF_IP_PRI_FIRST && prio <= NF_IP_PRI_CONNTRACK_DEFRAG))
> +		return -ERANGE;  /* cannot use defrag if prog runs before nf_defrag */

You could elide the (prio > NF_IP_PRI_FIRST, its already handled by
first conditional.  Otherwise this looks good to me.

