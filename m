Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C139403F
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE1JpV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 05:45:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:64173 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235361AbhE1JpV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 05:45:21 -0400
IronPort-SDR: uurXjxXlJ+mzLG0UqhTj2e3WNZmPPD40O7YA48Y9s6XDROpO55fCYcJHI+eu2GtBbC/3a2DjEF
 eh5qDUlw4scw==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202964589"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="202964589"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 02:43:46 -0700
IronPort-SDR: jubDGELzN0s5/K8MTF35vCrEawXQF+OIwdUyz61BCaRL2QJN+f1rU+7CvbdAZPAkTSKPjzE5UW
 RPNybSr8SjDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="480983011"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2021 02:43:43 -0700
Date:   Fri, 28 May 2021 11:30:43 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: support input xdp_md context in
 BPF_PROG_TEST_RUN
Message-ID: <20210528093043.GA46923@ranger.igk.intel.com>
References: <20210527201341.7128-1-zeffron@riotgames.com>
 <20210527201341.7128-2-zeffron@riotgames.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527201341.7128-2-zeffron@riotgames.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 08:13:39PM +0000, Zvi Effron wrote:
> Support passing a xdp_md via ctx_in/ctx_out in bpf_attr for
> BPF_PROG_TEST_RUN.
> 
> The intended use case is to pass some XDP meta data to the test runs of
> XDP programs that are used as tail calls.

How about providing an actual selftests that will showcase the above so
reviewers could get in an easier way a grasp of what this set is about?

> 
> For programs that use bpf_prog_test_run_xdp, support xdp_md input and
> output. Unlike with an actual xdp_md during a non-test run, data_meta must
> be 0 because it must point to the start of the provided user data. From
> the initial xdp_md, use data and data_end to adjust the pointers in the
> generated xdp_buff. All other non-zero fields are prohibited (with
> EINVAL). If the user has set ctx_out/ctx_size_out, copy the (potentially
> different) xdp_md back to the userspace.
> 
> We require all fields of input xdp_md except the ones we explicitly
> support to be set to zero. The expectation is that in the future we might
> add support for more fields and we want to fail explicitly if the user
> runs the program on the kernel where we don't yet support them.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> ---
>  include/uapi/linux/bpf.h |  3 --
>  net/bpf/test_run.c       | 84 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 77 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2c1ba70abbf1..a9dcf3d8c85a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -324,9 +324,6 @@ union bpf_iter_link_info {
>   *		**BPF_PROG_TYPE_SK_LOOKUP**
>   *			*data_in* and *data_out* must be NULL.
>   *
> - *		**BPF_PROG_TYPE_XDP**
> - *			*ctx_in* and *ctx_out* must be NULL.
> - *
>   *		**BPF_PROG_TYPE_RAW_TRACEPOINT**,
>   *		**BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE**
>   *
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index aa47af349ba8..3718c8a331dc 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -687,6 +687,45 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	return ret;
>  }
>  
> +static int convert_xdpmd_to_xdpb(struct xdp_buff *xdp, struct xdp_md *xdp_md)

Maybe xdp_convert_md_to_buff ?

> +{
> +	void *data;
> +	u32 metalen;
> +	struct net_device *device;
> +	struct netdev_rx_queue *rxqueue;

rxqueue is unused in here, maybe it with 2nd patch?

> +
> +	if (!xdp_md)
> +		return 0;
> +
> +	if (xdp_md->egress_ifindex != 0)
> +		return -EINVAL;
> +
> +	metalen = xdp_md->data - xdp_md->data_meta;
> +	data = xdp->data_meta + metalen;
> +	if (data > xdp->data_end)
> +		return -EINVAL;
> +	xdp->data = data;
> +
> +	if (xdp_md->data_end - xdp_md->data != xdp->data_end - xdp->data)
> +		return -EINVAL;
> +
> +	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void convert_xdpb_to_xdpmd(struct xdp_buff *xdp, struct xdp_md *xdp_md)
> +{
> +	if (!xdp_md)
> +		return;
> +
> +	/* xdp_md->data_meta must always point to the start of the out buffer */
> +	xdp_md->data_meta = 0;
> +	xdp_md->data = xdp->data - xdp->data_meta;
> +	xdp_md->data_end = xdp->data_end - xdp->data_meta;
> +}
> +
>  int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  			  union bpf_attr __user *uattr)
>  {
> @@ -696,36 +735,68 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	u32 repeat = kattr->test.repeat;
>  	struct netdev_rx_queue *rxqueue;
>  	struct xdp_buff xdp = {};
> +	struct xdp_md *ctx = NULL;
>  	u32 retval, duration;
>  	u32 max_data_sz;
> +	u32 metalen;
>  	void *data;
>  	int ret;
>  
> -	if (kattr->test.ctx_in || kattr->test.ctx_out)
> -		return -EINVAL;
> +	ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	/* There can't be user provided data before the metadata */
> +	if (ctx) {
> +		if (ctx->data_meta != 0)
> +			return -EINVAL;
> +		metalen = ctx->data - ctx->data_meta;
> +		if (unlikely((metalen & (sizeof(__u32) - 1)) ||
> +			     metalen > 32))
> +			return -EINVAL;
> +		/* Metadata is allocated from the headroom */
> +		headroom -= metalen;
> +	}
>  
>  	/* XDP have extra tailroom as (most) drivers use full page */
>  	max_data_sz = 4096 - headroom - tailroom;
>  
>  	data = bpf_test_init(kattr, max_data_sz, headroom, tailroom);
> -	if (IS_ERR(data))
> +	if (IS_ERR(data)) {
> +		kfree(ctx);
>  		return PTR_ERR(data);
> +	}
>  
>  	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
>  	xdp_init_buff(&xdp, headroom + max_data_sz + tailroom,
>  		      &rxqueue->xdp_rxq);
>  	xdp_prepare_buff(&xdp, data, headroom, size, true);
>  
> +	ret = convert_xdpmd_to_xdpb(&xdp, ctx);
> +	if (ret) {
> +		kfree(data);
> +		kfree(ctx);
> +		return ret;
> +	}
> +
>  	bpf_prog_change_xdp(NULL, prog);
>  	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
>  	if (ret)
>  		goto out;
> -	if (xdp.data != data + headroom || xdp.data_end != xdp.data + size)
> -		size = xdp.data_end - xdp.data;
> -	ret = bpf_test_finish(kattr, uattr, xdp.data, size, retval, duration);
> +
> +	if (xdp.data_meta != data + headroom || xdp.data_end != xdp.data_meta + size)
> +		size = xdp.data_end - xdp.data_meta;
> +
> +	convert_xdpb_to_xdpmd(&xdp, ctx);
> +
> +	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, size, retval, duration);
> +	if (!ret)
> +		ret = bpf_ctx_finish(kattr, uattr, ctx,
> +				     sizeof(struct xdp_md));
>  out:
>  	bpf_prog_change_xdp(prog, NULL);
>  	kfree(data);
> +	kfree(ctx);
>  	return ret;
>  }
>  
> @@ -809,7 +880,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>  	if (!ret)
>  		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
>  				     sizeof(struct bpf_flow_keys));
> -
>  out:
>  	kfree(user_ctx);
>  	kfree(data);
> -- 
> 2.31.1
> 
