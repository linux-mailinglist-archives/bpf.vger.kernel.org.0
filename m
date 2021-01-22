Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC10330020D
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 12:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhAVLyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 06:54:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:44619 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbhAVLBH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 06:01:07 -0500
IronPort-SDR: wYblF9y6z1+ji/z5qkRCVh3pzsN+445kXG8/F+w1n0GQkVFzUO3JENiP3TCo3ntU1YtHUNDYGd
 ps9UAFNfJOeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264249316"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264249316"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:00:26 -0800
IronPort-SDR: elHPdDEsr0VJS1U+olnkeJgEo8i9U3fi1y0AdgAuFClmFHh8/o9aiNKNlekulPeHGa8UY4xARs
 W69v6iYzPfmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="367381107"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2021 03:00:21 -0800
Date:   Fri, 22 Jan 2021 11:50:43 +0100
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCHv16 bpf-next 1/6] bpf: run devmap xdp_prog on flush
 instead of bulk enqueue
Message-ID: <20210122105043.GB52373@ranger.igk.intel.com>
References: <20210120022514.2862872-1-liuhangbin@gmail.com>
 <20210122074652.2981711-1-liuhangbin@gmail.com>
 <20210122074652.2981711-2-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122074652.2981711-2-liuhangbin@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 22, 2021 at 03:46:47PM +0800, Hangbin Liu wrote:
> From: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> This changes the devmap XDP program support to run the program when the
> bulk queue is flushed instead of before the frame is enqueued. This has
> a couple of benefits:
> 
> - It "sorts" the packets by destination devmap entry, and then runs the
>   same BPF program on all the packets in sequence. This ensures that we
>   keep the XDP program and destination device properties hot in I-cache.
> 
> - It makes the multicast implementation simpler because it can just
>   enqueue packets using bq_enqueue() without having to deal with the
>   devmap program at all.
> 
> The drawback is that if the devmap program drops the packet, the enqueue
> step is redundant. However, arguably this is mostly visible in a
> micro-benchmark, and with more mixed traffic the I-cache benefit should
> win out. The performance impact of just this patch is as follows:
> 
> Using xdp_redirect_map(with a 2nd xdp_prog patch[1]) in sample/bpf and send
> pkts via pktgen cmd:
> ./pktgen_sample03_burst_single_flow.sh -i eno1 -d $dst_ip -m $dst_mac -t 10 -s 64
> 
> There are about +/- 0.1M deviation for native testing, the performance
> improved for the base-case, but some drop back with xdp devmap prog attached.
> 
> Version          | Test                           | Generic | Native | Native + 2nd xdp_prog
> 5.10 rc6         | xdp_redirect_map   i40e->i40e  |    2.0M |   9.1M |  8.0M
> 5.10 rc6         | xdp_redirect_map   i40e->veth  |    1.7M |  11.0M |  9.7M
> 5.10 rc6 + patch | xdp_redirect_map   i40e->i40e  |    2.0M |   9.5M |  7.5M
> 5.10 rc6 + patch | xdp_redirect_map   i40e->veth  |    1.7M |  11.6M |  9.1M
> 
> [1] https://lore.kernel.org/bpf/20210122025007.2968381-1-liuhangbin@gmail.com
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> ---
> v16:
> a) refactor bq_xmit_all logic and remove error label
> 
> v15:
> a) do not use unlikely when checking bq->xdp_prog
> b) return sent frames for dev_map_bpf_prog_run()
> 
> v14: no update, only rebase the code
> v13: pass in xdp_prog through __xdp_enqueue()
> v2-v12: no this patch
> ---
>  kernel/bpf/devmap.c | 136 ++++++++++++++++++++++++++------------------
>  1 file changed, 81 insertions(+), 55 deletions(-)
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index f6e9c68afdd4..c24fcffbbfad 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -57,6 +57,7 @@ struct xdp_dev_bulk_queue {
>  	struct list_head flush_node;
>  	struct net_device *dev;
>  	struct net_device *dev_rx;
> +	struct bpf_prog *xdp_prog;
>  	unsigned int count;
>  };
>  
> @@ -327,46 +328,95 @@ bool dev_map_can_have_prog(struct bpf_map *map)
>  	return false;
>  }
>  
> +static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
> +				struct xdp_frame **frames, int n,
> +				struct net_device *dev)
> +{
> +	struct xdp_txq_info txq = { .dev = dev };
> +	struct xdp_buff xdp;
> +	int i, nframes = 0;
> +
> +	for (i = 0; i < n; i++) {
> +		struct xdp_frame *xdpf = frames[i];
> +		u32 act;
> +		int err;
> +
> +		xdp_convert_frame_to_buff(xdpf, &xdp);
> +		xdp.txq = &txq;
> +
> +		act = bpf_prog_run_xdp(xdp_prog, &xdp);
> +		switch (act) {
> +		case XDP_PASS:
> +			err = xdp_update_frame_from_buff(&xdp, xdpf);
> +			if (unlikely(err < 0))
> +				xdp_return_frame_rx_napi(xdpf);
> +			else
> +				frames[nframes++] = xdpf;
> +			break;
> +		default:
> +			bpf_warn_invalid_xdp_action(act);
> +			fallthrough;
> +		case XDP_ABORTED:
> +			trace_xdp_exception(dev, xdp_prog, act);
> +			fallthrough;
> +		case XDP_DROP:
> +			xdp_return_frame_rx_napi(xdpf);
> +			break;
> +		}
> +	}
> +	return nframes; /* sent frames count */
> +}
> +
>  static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>  {
>  	struct net_device *dev = bq->dev;
> -	int sent = 0, drops = 0, err = 0;
> +	unsigned int cnt = bq->count;
> +	int drops = 0, err = 0;
> +	int to_sent = cnt;

Hmm if I would be super picky then I'd like to have this variable as
"to_send", as we spoke. Could you change that?

With that, you can add my:

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

to next revision.

> +	int sent = cnt;
>  	int i;
>  
> -	if (unlikely(!bq->count))
> +	if (unlikely(!cnt))
>  		return;
>  
> -	for (i = 0; i < bq->count; i++) {
> +	for (i = 0; i < cnt; i++) {
>  		struct xdp_frame *xdpf = bq->q[i];
>  
>  		prefetch(xdpf);
>  	}
>  
> -	sent = dev->netdev_ops->ndo_xdp_xmit(dev, bq->count, bq->q, flags);
> +	if (bq->xdp_prog) {
> +		to_sent = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev);
> +		if (!to_sent) {
> +			sent = 0;
> +			goto out;
> +		}
> +		drops = cnt - to_sent;
> +	}
> +
> +	sent = dev->netdev_ops->ndo_xdp_xmit(dev, to_sent, bq->q, flags);
>  	if (sent < 0) {
>  		err = sent;
>  		sent = 0;
> -		goto error;
> +
> +		/* If ndo_xdp_xmit fails with an errno, no frames have been
> +		 * xmit'ed and it's our responsibility to them free all.
> +		 */
> +		for (i = 0; i < cnt - drops; i++) {
> +			struct xdp_frame *xdpf = bq->q[i];
> +
> +			xdp_return_frame_rx_napi(xdpf);
> +		}
>  	}
> -	drops = bq->count - sent;
>  out:
> +	drops = cnt - sent;
>  	bq->count = 0;
>  
>  	trace_xdp_devmap_xmit(bq->dev_rx, dev, sent, drops, err);
>  	bq->dev_rx = NULL;
> +	bq->xdp_prog = NULL;

One more question, do you really have to do that per each bq_xmit_all
call? Couldn't you clear it in __dev_flush ?

Or IOW - what's the rationale behind storing xdp_prog in
xdp_dev_bulk_queue. Why can't you propagate the dst->xdp_prog and rely on
that without that local pointer?

You probably have an answer for that, so maybe include it in commit
message.

BTW same question for clearing dev_rx. To me this will be the same for all
bq_xmit_all() calls that will happen within same napi.

>  	__list_del_clearprev(&bq->flush_node);
>  	return;
> -error:
> -	/* If ndo_xdp_xmit fails with an errno, no frames have been
> -	 * xmit'ed and it's our responsibility to them free all.
> -	 */
> -	for (i = 0; i < bq->count; i++) {
> -		struct xdp_frame *xdpf = bq->q[i];
> -
> -		xdp_return_frame_rx_napi(xdpf);
> -		drops++;
> -	}
> -	goto out;
>  }
>  
>  /* __dev_flush is called from xdp_do_flush() which _must_ be signaled
> @@ -408,7 +458,7 @@ struct bpf_dtab_netdev *__dev_map_lookup_elem(struct bpf_map *map, u32 key)
>   * Thus, safe percpu variable access.
>   */
>  static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
> -		       struct net_device *dev_rx)
> +		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
>  {
>  	struct list_head *flush_list = this_cpu_ptr(&dev_flush_list);
>  	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
> @@ -423,6 +473,14 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
>  	if (!bq->dev_rx)
>  		bq->dev_rx = dev_rx;
>  
> +	/* Store (potential) xdp_prog that run before egress to dev as
> +	 * part of bulk_queue.  This will be same xdp_prog for all
> +	 * xdp_frame's in bulk_queue, because this per-CPU store must
> +	 * be flushed from net_device drivers NAPI func end.
> +	 */
> +	if (!bq->xdp_prog)
> +		bq->xdp_prog = xdp_prog;
> +
>  	bq->q[bq->count++] = xdpf;
>  
>  	if (!bq->flush_node.prev)
> @@ -430,7 +488,8 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
>  }
>  
>  static inline int __xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
> -			       struct net_device *dev_rx)
> +				struct net_device *dev_rx,
> +				struct bpf_prog *xdp_prog)
>  {
>  	struct xdp_frame *xdpf;
>  	int err;
> @@ -446,42 +505,14 @@ static inline int __xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
>  	if (unlikely(!xdpf))
>  		return -EOVERFLOW;
>  
> -	bq_enqueue(dev, xdpf, dev_rx);
> +	bq_enqueue(dev, xdpf, dev_rx, xdp_prog);
>  	return 0;
>  }
>  
> -static struct xdp_buff *dev_map_run_prog(struct net_device *dev,
> -					 struct xdp_buff *xdp,
> -					 struct bpf_prog *xdp_prog)
> -{
> -	struct xdp_txq_info txq = { .dev = dev };
> -	u32 act;
> -
> -	xdp_set_data_meta_invalid(xdp);
> -	xdp->txq = &txq;
> -
> -	act = bpf_prog_run_xdp(xdp_prog, xdp);
> -	switch (act) {
> -	case XDP_PASS:
> -		return xdp;
> -	case XDP_DROP:
> -		break;
> -	default:
> -		bpf_warn_invalid_xdp_action(act);
> -		fallthrough;
> -	case XDP_ABORTED:
> -		trace_xdp_exception(dev, xdp_prog, act);
> -		break;
> -	}
> -
> -	xdp_return_buff(xdp);
> -	return NULL;
> -}
> -
>  int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
>  		    struct net_device *dev_rx)
>  {
> -	return __xdp_enqueue(dev, xdp, dev_rx);
> +	return __xdp_enqueue(dev, xdp, dev_rx, NULL);
>  }
>  
>  int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
> @@ -489,12 +520,7 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
>  {
>  	struct net_device *dev = dst->dev;
>  
> -	if (dst->xdp_prog) {
> -		xdp = dev_map_run_prog(dev, xdp, dst->xdp_prog);
> -		if (!xdp)
> -			return 0;
> -	}
> -	return __xdp_enqueue(dev, xdp, dev_rx);
> +	return __xdp_enqueue(dev, xdp, dev_rx, dst->xdp_prog);
>  }
>  
>  int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
> -- 
> 2.26.2
> 
