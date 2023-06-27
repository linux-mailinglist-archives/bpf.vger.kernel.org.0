Return-Path: <bpf+bounces-3556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4373FAB8
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 13:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FF81C203B3
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF23F17732;
	Tue, 27 Jun 2023 11:04:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02C16427;
	Tue, 27 Jun 2023 11:04:13 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF91BE8;
	Tue, 27 Jun 2023 04:04:12 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qE6UK-0003PI-Kq; Tue, 27 Jun 2023 13:04:00 +0200
Date: Tue, 27 Jun 2023 13:04:00 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org, fw@strlen.de,
	pabeni@redhat.com, pablo@netfilter.org, davem@davemloft.net,
	kadlec@netfilter.org, daniel@iogearbox.net,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/7] netfilter: defrag: Add glue hooks for
 enabling/disabling defrag
Message-ID: <20230627110400.GG3207@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <66d1eaeb17721b1274eb4c1991a3725e47c912c5.1687819413.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d1eaeb17721b1274eb4c1991a3725e47c912c5.1687819413.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Xu <dxu@dxuuu.xyz> wrote:
> diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
> index e61ea428ea18..436e629b0969 100644
> --- a/net/ipv4/netfilter/nf_defrag_ipv4.c
> +++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
> @@ -7,6 +7,7 @@
>  #include <linux/ip.h>
>  #include <linux/netfilter.h>
>  #include <linux/module.h>
> +#include <linux/rcupdate.h>
>  #include <linux/skbuff.h>
>  #include <net/netns/generic.h>
>  #include <net/route.h>
> @@ -113,17 +114,24 @@ static void __net_exit defrag4_net_exit(struct net *net)
>  	}
>  }
>  
> +static struct nf_defrag_v4_hook defrag_hook = {
> +	.enable = nf_defrag_ipv4_enable,
> +	.disable = nf_defrag_ipv4_disable,
> +};

Nit: static const, same for v6.

>  static struct pernet_operations defrag4_net_ops = {
>  	.exit = defrag4_net_exit,
>  };
>  
>  static int __init nf_defrag_init(void)
>  {
> +	rcu_assign_pointer(nf_defrag_v4_hook, &defrag_hook);
>  	return register_pernet_subsys(&defrag4_net_ops);

register_pernet failure results in nf_defrag_v4_hook pointing to
garbage.

