Return-Path: <bpf+bounces-15851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E467F8ED1
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 21:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961FF1C20B72
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE192E64E;
	Sat, 25 Nov 2023 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cycg1aGm"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7148115
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 12:36:38 -0800 (PST)
Message-ID: <0e72fb5b-2e26-4c28-b139-68203cd72e59@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700944597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eBoHR8/A62oBsXECF6u1cAZaG2rFtPrgNTihuCv6uE=;
	b=Cycg1aGm/2qPhziPZwVmTw4E4Wh7mdEsvmqpZuW9xYWOUR7xc2qGepm/cV2K9SQarycFKp
	1O7qhNX6C/OuL56iFwMBBgC//htea6aBPUC/qLcHR75acm13z9cPLGapJGtGMpnzraITe5
	U8GfyHuYLRPZbvf1uZfB0YZhUDwXRos=
Date: Sat, 25 Nov 2023 12:36:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next v1 1/7] bpf: xfrm: Add bpf_xdp_get_xfrm_state()
 kfunc
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>, john.fastabend@gmail.com,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 ast@kernel.org, daniel@iogearbox.net, pabeni@redhat.com, hawk@kernel.org,
 kuba@kernel.org, edumazet@google.com, steffen.klassert@secunet.com,
 antony.antony@secunet.com, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, devel@linux-ipsec.org
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <2443b6093691c7ae9dace98b0257f61ff2ff30ec.1700676682.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2443b6093691c7ae9dace98b0257f61ff2ff30ec.1700676682.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/22/23 1:20 PM, Daniel Xu wrote:
> This commit adds an unstable kfunc helper to access internal xfrm_state
> associated with an SA. This is intended to be used for the upcoming
> IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
> words: for custom software RSS.
>
> That being said, the function that this kfunc wraps is fairly generic
> and used for a lot of xfrm tasks. I'm sure people will find uses
> elsewhere over time.
>
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>   include/net/xfrm.h        |   9 ++++
>   net/xfrm/Makefile         |   1 +
>   net/xfrm/xfrm_policy.c    |   2 +
>   net/xfrm/xfrm_state_bpf.c | 111 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 123 insertions(+)
>   create mode 100644 net/xfrm/xfrm_state_bpf.c
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index c9bb0f892f55..1d107241b901 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -2190,4 +2190,13 @@ static inline int register_xfrm_interface_bpf(void)
>   
>   #endif
>   
> +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
> +int register_xfrm_state_bpf(void);
> +#else
> +static inline int register_xfrm_state_bpf(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>   #endif	/* _NET_XFRM_H */
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index cd47f88921f5..547cec77ba03 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>   obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>   obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
>   obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
> +obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index c13dc3ef7910..1b7e75159727 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4218,6 +4218,8 @@ void __init xfrm_init(void)
>   #ifdef CONFIG_XFRM_ESPINTCP
>   	espintcp_init();
>   #endif
> +
> +	register_xfrm_state_bpf();
>   }
>   
>   #ifdef CONFIG_AUDITSYSCALL
> diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
> new file mode 100644
> index 000000000000..0c1f2f91125c
> --- /dev/null
> +++ b/net/xfrm/xfrm_state_bpf.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Unstable XFRM state BPF helpers.
> + *
> + * Note that it is allowed to break compatibility for these functions since the
> + * interface they are exposed through to BPF programs is explicitly unstable.
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <net/xdp.h>
> +#include <net/xfrm.h>
> +
> +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
> + *
> + * Members:
> + * @error      - Out parameter, set for any errors encountered
> + *		 Values:
> + *		   -EINVAL - netns_id is less than -1
> + *		   -EINVAL - Passed NULL for opts
> + *		   -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> + *		   -ENONET - No network namespace found for netns_id
> + * @netns_id	- Specify the network namespace for lookup
> + *		 Values:
> + *		   BPF_F_CURRENT_NETNS (-1)
> + *		     Use namespace associated with ctx
> + *		   [0, S32_MAX]
> + *		     Network Namespace ID
> + * @mark	- XFRM mark to match on
> + * @daddr	- Destination address to match on
> + * @spi		- Security parameter index to match on
> + * @proto	- L3 protocol to match on
> + * @family	- L3 protocol family to match on
> + */
> +struct bpf_xfrm_state_opts {
> +	s32 error;
> +	s32 netns_id;
> +	u32 mark;
> +	xfrm_address_t daddr;
> +	__be32 spi;
> +	u8 proto;
> +	u16 family;
> +};
> +
> +enum {
> +	BPF_XFRM_STATE_OPTS_SZ = sizeof(struct bpf_xfrm_state_opts),
> +};
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in xfrm_state BTF");
> +
> +/* bpf_xdp_get_xfrm_state - Get XFRM state
> + *
> + * Parameters:
> + * @ctx 	- Pointer to ctx (xdp_md) in XDP program
> + *		    Cannot be NULL
> + * @opts	- Options for lookup (documented above)
> + *		    Cannot be NULL
> + * @opts__sz	- Length of the bpf_xfrm_state_opts structure
> + *		    Must be BPF_XFRM_STATE_OPTS_SZ
> + */
> +__bpf_kfunc struct xfrm_state *
> +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32 opts__sz)
> +{
> +	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> +	struct net *net = dev_net(xdp->rxq->dev);
> +	struct xfrm_state *x;
> +
> +	if (!opts || opts__sz != BPF_XFRM_STATE_OPTS_SZ) {
> +		opts->error = -EINVAL;

If opts is NULL, obvious we have issue opts->error access.
If opts is not NULL and opts_sz < 4, we also have issue with
opts->error access since it may override some other stuff
on the stack.

In such cases, we do not need to do 'opts->error = -EINVAL'
and can simply 'return NULL'. bpf program won't be able
to check opts->error anyway since the opts is either NULL
or opts_sz < 4.

> +		return NULL;
> +	}
> +
> +	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
> +		opts->error = -EINVAL;
> +		return NULL;
> +	}
> +
> +	if (opts->netns_id >= 0) {
> +		net = get_net_ns_by_id(net, opts->netns_id);
> +		if (unlikely(!net)) {
> +			opts->error = -ENONET;
> +			return NULL;
> +		}
> +	}
> +
> +	x = xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi,
> +			      opts->proto, opts->family);
> +
> +	if (opts->netns_id >= 0)
> +		put_net(net);
> +
> +	return x;
> +}
> +
> +__diag_pop()

[...]


