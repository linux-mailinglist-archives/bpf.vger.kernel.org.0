Return-Path: <bpf+bounces-18738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6D81FDFE
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 09:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132152824AF
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478E747B;
	Fri, 29 Dec 2023 08:03:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5308BE7;
	Fri, 29 Dec 2023 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VzQtt.u_1703837012;
Received: from 30.221.145.217(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VzQtt.u_1703837012)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 16:03:33 +0800
Message-ID: <00d390f3-1d92-43e5-adec-b7d0b8885fdc@linux.alibaba.com>
Date: Fri, 29 Dec 2023 16:03:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC nf-next v4 1/2] netfilter: bpf: support prog update
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org
References: <1703836449-88705-1-git-send-email-alibuda@linux.alibaba.com>
 <1703836449-88705-2-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1703836449-88705-2-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/23 3:54 PM, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> To support the prog update, we need to ensure that the prog seen
> within the hook is always valid. Considering that hooks are always
> protected by rcu_read_lock(), which provide us the ability to
> access the prog under rcu.
>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/netfilter/nf_bpf_link.c | 50 ++++++++++++++++++++++++++++++---------------
>   1 file changed, 34 insertions(+), 16 deletions(-)
>
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index e502ec0..7c32ccb 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -8,26 +8,26 @@
>   #include <net/netfilter/nf_bpf_link.h>
>   #include <uapi/linux/netfilter_ipv4.h>
>   
> -static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
> -				    const struct nf_hook_state *s)
> -{
> -	const struct bpf_prog *prog = bpf_prog;
> -	struct bpf_nf_ctx ctx = {
> -		.state = s,
> -		.skb = skb,
> -	};
> -
> -	return bpf_prog_run(prog, &ctx);
> -}
> -
>   struct bpf_nf_link {
>   	struct bpf_link link;
>   	struct nf_hook_ops hook_ops;
>   	struct net *net;
>   	u32 dead;
>   	const struct nf_defrag_hook *defrag_hook;
> +	struct rcu_head head;
>   };
>   
> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
> +				    const struct nf_hook_state *s)
> +{
> +	const struct bpf_nf_link *nf_link = bpf_link;
> +	struct bpf_nf_ctx ctx = {
> +		.state = s,
> +		.skb = skb,
> +	};
> +	return bpf_prog_run(rcu_dereference_raw(nf_link->link.prog), &ctx);
> +}
> +
>   #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>   static const struct nf_defrag_hook *
>   get_proto_defrag_hook(struct bpf_nf_link *link,
> @@ -126,8 +126,7 @@ static void bpf_nf_link_release(struct bpf_link *link)
>   static void bpf_nf_link_dealloc(struct bpf_link *link)
>   {
>   	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
> -
> -	kfree(nf_link);
> +	kfree_rcu(nf_link, head);
>   }
>   
>   static int bpf_nf_link_detach(struct bpf_link *link)
> @@ -162,7 +161,22 @@ static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
>   static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
>   			      struct bpf_prog *old_prog)
>   {
> -	return -EOPNOTSUPP;
> +	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
> +	int err = 0;
> +
> +	if (nf_link->dead)
> +		return -EPERM;
> +
> +	if (old_prog) {
> +		/* target old_prog mismatch */
> +		if (!cmpxchg(&link->prog, old_prog, new_prog))
> +			return -EPERM;
> +	} else {
> +		old_prog = xchg(&link->prog, new_prog);
> +	}
> +
> +	bpf_prog_put(old_prog);
> +	return err;
>   }

I made a mistake here, and I will fix it in the next version.
Sorry for that.

D. Wythe

>   
>   static const struct bpf_link_ops bpf_nf_link_lops = {
> @@ -226,7 +240,11 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>   
>   	link->hook_ops.hook = nf_hook_run_bpf;
>   	link->hook_ops.hook_ops_type = NF_HOOK_OP_BPF;
> -	link->hook_ops.priv = prog;
> +
> +	/* bpf_nf_link_release & bpf_nf_link_dealloc() can ensures that link remains
> +	 * valid at all times within nf_hook_run_bpf().
> +	 */
> +	link->hook_ops.priv = link;
>   
>   	link->hook_ops.pf = attr->link_create.netfilter.pf;
>   	link->hook_ops.priority = attr->link_create.netfilter.priority;


