Return-Path: <bpf+bounces-27867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE4D8B2D93
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 01:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EDDB22FB2
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 23:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93264156886;
	Thu, 25 Apr 2024 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HnMLW7PF"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35781156644;
	Thu, 25 Apr 2024 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087656; cv=none; b=Kk/tNwe3VuxbVBy4mFmlPMqLMrfrKp9+gmYcfuM9hvOyIxkGn1bzd+3sdfFR4K0+bzmapjUqXw7PH9tbCu0sH7Cx6LAjVdT/NTckAgPb/Hjv2xajRryHf2BDWVTE+js3yiZAEQNOVVNgZy8Y1tjAItY5UV6izONBPoRe7GRp4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087656; c=relaxed/simple;
	bh=0tFieE+HQ5I3pw7gyPPOiTeceDGOdd5tINy//LbG6nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPmZ7/ki6roY3f4sXvXvuY01v6a4eMJc7M184rCeAfIgEZY+xgI1G0LNZljIey+Pqm2/QFjED1/dI2UQZgV+RpL/F78Ffrmi1tczvUfzwBQqlJs2RgyOcn1Ea84gt1vd2KId6b7jE45hHSxQ4doFCmXqzXbAWP/a0H666osPj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HnMLW7PF; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <463c8ea7-08cf-412e-bb31-6fbb15b4df8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714087652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHcXWetchZJOkIfTIAeJVtrEZuK6N84YVH9u3Y+Js74=;
	b=HnMLW7PFQlxBSyuTCwvWv3+PEtXswZsQRrKEhDtKU7v/I12Vv+HaxnheElL4Ja7nbJiZZQ
	cQL6TfSNkc7iQ1Zron1IqcTfTkNk0vqbwaNRWpAWXxfqjDSr0RanJt9aT0q0OP4Obj6XF6
	i4Auhc31EXATV11uBAoSLwD9qg3/bOo=
Date: Thu, 25 Apr 2024 16:27:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] net: netfilter: Make ct zone opts
 configurable for bpf ct helpers
To: Brad Cowie <brad@faucet.nz>
Cc: lorenzo@kernel.org, memxor@gmail.com, pablo@netfilter.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240424030027.3932184-1-brad@faucet.nz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240424030027.3932184-1-brad@faucet.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/23/24 8:00 PM, Brad Cowie wrote:
> Add ct zone id/flags/dir to bpf_ct_opts so that arbitrary ct zones
> can be used for xdp/tc bpf ct helper functions bpf_{xdp,skb}_ct_alloc
> and bpf_{xdp,skb}_ct_lookup.
> 
> Signed-off-by: Brad Cowie <brad@faucet.nz>
> ---
> v1 -> v2:
>    - Make ct zone flags/dir configurable
> ---
>   net/netfilter/nf_conntrack_bpf.c | 97 ++++++++++++++++++++------------
>   1 file changed, 61 insertions(+), 36 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
> index d2492d050fe6..67f73b57089b 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -21,41 +21,44 @@
>   /* bpf_ct_opts - Options for CT lookup helpers
>    *
>    * Members:
> - * @netns_id   - Specify the network namespace for lookup
> - *		 Values:
> - *		   BPF_F_CURRENT_NETNS (-1)
> - *		     Use namespace associated with ctx (xdp_md, __sk_buff)
> - *		   [0, S32_MAX]
> - *		     Network Namespace ID
> - * @error      - Out parameter, set for any errors encountered
> - *		 Values:
> - *		   -EINVAL - Passed NULL for bpf_tuple pointer
> - *		   -EINVAL - opts->reserved is not 0
> - *		   -EINVAL - netns_id is less than -1
> - *		   -EINVAL - opts__sz isn't NF_BPF_CT_OPTS_SZ (12)
> - *		   -EPROTO - l4proto isn't one of IPPROTO_TCP or IPPROTO_UDP
> - *		   -ENONET - No network namespace found for netns_id
> - *		   -ENOENT - Conntrack lookup could not find entry for tuple
> - *		   -EAFNOSUPPORT - tuple__sz isn't one of sizeof(tuple->ipv4)
> - *				   or sizeof(tuple->ipv6)
> - * @l4proto    - Layer 4 protocol
> - *		 Values:
> - *		   IPPROTO_TCP, IPPROTO_UDP
> - * @dir:       - connection tracking tuple direction.
> - * @reserved   - Reserved member, will be reused for more options in future
> - *		 Values:
> - *		   0
> + * @netns_id	  - Specify the network namespace for lookup
> + *		    Values:
> + *		      BPF_F_CURRENT_NETNS (-1)
> + *		        Use namespace associated with ctx (xdp_md, __sk_buff)
> + *		      [0, S32_MAX]
> + *		        Network Namespace ID
> + * @error	  - Out parameter, set for any errors encountered
> + *		    Values:
> + *		      -EINVAL - Passed NULL for bpf_tuple pointer
> + *		      -EINVAL - netns_id is less than -1
> + *		      -EINVAL - opts__sz isn't NF_BPF_CT_OPTS_SZ (16)
> + *			        or NF_BPF_CT_OPTS_OLD_SZ (12)
> + *		      -EPROTO - l4proto isn't one of IPPROTO_TCP or IPPROTO_UDP
> + *		      -ENONET - No network namespace found for netns_id
> + *		      -ENOENT - Conntrack lookup could not find entry for tuple
> + *		      -EAFNOSUPPORT - tuple__sz isn't one of sizeof(tuple->ipv4)
> + *				      or sizeof(tuple->ipv6)
> + * @l4proto	  - Layer 4 protocol
> + *		    Values:
> + *		      IPPROTO_TCP, IPPROTO_UDP
> + * @dir:	  - connection tracking tuple direction.

Please avoid whitespace changes. It is unnecessary code churns.

> + * @ct_zone_id	  - connection tracking zone id.
> + * @ct_zone_flags - connection tracking zone flags.
> + * @ct_zone_dir   - connection tracking zone direction.
>    */
>   struct bpf_ct_opts {
>   	s32 netns_id;
>   	s32 error;
>   	u8 l4proto;
>   	u8 dir;
> -	u8 reserved[2];
> +	u16 ct_zone_id;
> +	u8 ct_zone_flags;
> +	u8 ct_zone_dir;

The size is 16 now with 2 tail paddings.
It needs a "u8 reserved[2];" at the end and need to check its 0.


>   };
>   
>   enum {
> -	NF_BPF_CT_OPTS_SZ = 12,
> +	NF_BPF_CT_OPTS_SZ = 16,
> +	NF_BPF_CT_OPTS_OLD_SZ = 12,

Avoid adding NF_BPF_CT_OPTS_OLD_SZ for now. I don't see how it may be useful.

>   };
>   
>   static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
> @@ -104,11 +107,13 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
>   			u32 timeout)
>   {
>   	struct nf_conntrack_tuple otuple, rtuple;
> +	struct nf_conntrack_zone ct_zone;
>   	struct nf_conn *ct;
>   	int err;
>   
> -	if (!opts || !bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
> -	    opts_len != NF_BPF_CT_OPTS_SZ)
> +	if (!opts || !bpf_tuple)
> +		return ERR_PTR(-EINVAL);
> +	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == NF_BPF_CT_OPTS_OLD_SZ))
>   		return ERR_PTR(-EINVAL);
>   
>   	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
> @@ -130,7 +135,16 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
>   			return ERR_PTR(-ENONET);
>   	}
>   
> -	ct = nf_conntrack_alloc(net, &nf_ct_zone_dflt, &otuple, &rtuple,
> +	if (opts_len == NF_BPF_CT_OPTS_SZ) {
> +		if (opts->ct_zone_dir == 0)

I don't know the details about the dir in ct_zone, so a question: a 0 
ct_zone_dir is invalid and can be reused to mean NF_CT_DEFAULT_ZONE_DIR?

> +			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
> +		nf_ct_zone_init(&ct_zone,
> +				opts->ct_zone_id, opts->ct_zone_dir, opts->ct_zone_flags);
> +	} else {

Better enforce "ct_zone_id == 0" also instead of ignoring it.

> +		ct_zone = nf_ct_zone_dflt;
> +	}
> +
> +	ct = nf_conntrack_alloc(net, &ct_zone, &otuple, &rtuple,
>   				GFP_ATOMIC);
>   	if (IS_ERR(ct))
>   		goto out;
> @@ -152,11 +166,13 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
>   {
>   	struct nf_conntrack_tuple_hash *hash;
>   	struct nf_conntrack_tuple tuple;
> +	struct nf_conntrack_zone ct_zone;
>   	struct nf_conn *ct;
>   	int err;
>   
> -	if (!opts || !bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
> -	    opts_len != NF_BPF_CT_OPTS_SZ)
> +	if (!opts || !bpf_tuple)
> +		return ERR_PTR(-EINVAL);
> +	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == NF_BPF_CT_OPTS_OLD_SZ))
>   		return ERR_PTR(-EINVAL);
>   	if (unlikely(opts->l4proto != IPPROTO_TCP && opts->l4proto != IPPROTO_UDP))
>   		return ERR_PTR(-EPROTO);
> @@ -174,7 +190,16 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
>   			return ERR_PTR(-ENONET);
>   	}
>   
> -	hash = nf_conntrack_find_get(net, &nf_ct_zone_dflt, &tuple);
> +	if (opts_len == NF_BPF_CT_OPTS_SZ) {
> +		if (opts->ct_zone_dir == 0)
> +			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
> +		nf_ct_zone_init(&ct_zone,
> +				opts->ct_zone_id, opts->ct_zone_dir, opts->ct_zone_flags);
> +	} else {
> +		ct_zone = nf_ct_zone_dflt;
> +	}
> +
> +	hash = nf_conntrack_find_get(net, &ct_zone, &tuple);
>   	if (opts->netns_id >= 0)
>   		put_net(net);
>   	if (!hash)
> @@ -245,7 +270,7 @@ __bpf_kfunc_start_defs();
>    * @opts	- Additional options for allocation (documented above)
>    *		    Cannot be NULL
>    * @opts__sz	- Length of the bpf_ct_opts structure
> - *		    Must be NF_BPF_CT_OPTS_SZ (12)
> + *		    Must be NF_BPF_CT_OPTS_SZ (16)
>    */
>   __bpf_kfunc struct nf_conn___init *
>   bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
> @@ -279,7 +304,7 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
>    * @opts	- Additional options for lookup (documented above)
>    *		    Cannot be NULL
>    * @opts__sz	- Length of the bpf_ct_opts structure
> - *		    Must be NF_BPF_CT_OPTS_SZ (12)
> + *		    Must be NF_BPF_CT_OPTS_SZ (16)

Either 16 or 12. Same for below.

>    */
>   __bpf_kfunc struct nf_conn *
>   bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
> @@ -312,7 +337,7 @@ bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
>    * @opts	- Additional options for allocation (documented above)
>    *		    Cannot be NULL
>    * @opts__sz	- Length of the bpf_ct_opts structure
> - *		    Must be NF_BPF_CT_OPTS_SZ (12)
> + *		    Must be NF_BPF_CT_OPTS_SZ (16)
>    */
>   __bpf_kfunc struct nf_conn___init *
>   bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
> @@ -347,7 +372,7 @@ bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
>    * @opts	- Additional options for lookup (documented above)
>    *		    Cannot be NULL
>    * @opts__sz	- Length of the bpf_ct_opts structure
> - *		    Must be NF_BPF_CT_OPTS_SZ (12)
> + *		    Must be NF_BPF_CT_OPTS_SZ (16)
>    */
>   __bpf_kfunc struct nf_conn *
>   bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,


