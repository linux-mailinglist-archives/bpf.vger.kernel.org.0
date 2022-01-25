Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2842749B7A3
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 16:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353326AbiAYPa6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 10:30:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:27223 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349233AbiAYP3A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 10:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643124540; x=1674660540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ULg4leY6X8BAN2e9AP3dMu8QMfm9aWcndEJARw1vmoQ=;
  b=IkpErf0R2WQNmrkrbHj98KZEw60oDWKJsGslha4CZ3HjNRAybnED+Hj0
   xbOLH791CJ+tq/phPJioOnFOXsx5B9p6d4GDJ67ns29mPSiowmHAiA6EV
   gwXlHp76GKgHTzI5Gv1eIpAC6yrCrTmDRxRKaHrcjZO4FYG0ItkTzCRe2
   t5pHLJ6L3Dj/OaD5kW+Acomrr3joQLQq2eDB7PxjqJ+NeKaBlW42AiZ41
   0FJdqiBxfMSi2C9IUXM9vwvmhVGrr1Re0XGFB6cJ0qS8rLZTOjig1dIMb
   5CaLBa5MO1OWTr5sXI9RlG5lYS+MYZ2L/KD5SOy1AMOorNlV3ZNPYXeFS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246108417"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246108417"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:26:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="627965453"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2022 07:26:32 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 20PFQVdg014105;
        Tue, 25 Jan 2022 15:26:31 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, magnus.karlsson@intel.com
Subject: Re: [PATCH bpf-next v4 2/8] ice: xsk: force rings to be sized to power of 2
Date:   Tue, 25 Jan 2022 16:24:39 +0100
Message-Id: <20220125152439.831365-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YfAQrME95s758ITD@boxer>
References: <20220124165547.74412-1-maciej.fijalkowski@intel.com> <20220124165547.74412-3-maciej.fijalkowski@intel.com> <20220125112306.746139-1-alexandr.lobakin@intel.com> <Ye/e9GqLkuekqFos@boxer> <20220125114202.748079-1-alexandr.lobakin@intel.com> <Ye/j0FjYCeJlbWR/@boxer> <20220125120033.748345-1-alexandr.lobakin@intel.com> <YfAQrME95s758ITD@boxer>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 25 Jan 2022 16:01:00 +0100

> On Tue, Jan 25, 2022 at 01:00:33PM +0100, Alexander Lobakin wrote:
> > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Date: Tue, 25 Jan 2022 12:49:36 +0100
> > 
> > > On Tue, Jan 25, 2022 at 12:42:02PM +0100, Alexander Lobakin wrote:
> > > > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > Date: Tue, 25 Jan 2022 12:28:52 +0100
> > > > 
> > > > > On Tue, Jan 25, 2022 at 12:23:06PM +0100, Alexander Lobakin wrote:
> > > > > > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > > Date: Mon, 24 Jan 2022 17:55:41 +0100
> > > > > > 
> > > > > > > With the upcoming introduction of batching to XSK data path,
> > > > > > > performance wise it will be the best to have the ring descriptor count
> > > > > > > to be aligned to power of 2.
> > > > > > > 
> > > > > > > Check if rings sizes that user is going to attach the XSK socket fulfill
> > > > > > > the condition above. For Tx side, although check is being done against
> > > > > > > the Tx queue and in the end the socket will be attached to the XDP
> > > > > > > queue, it is fine since XDP queues get the ring->count setting from Tx
> > > > > > > queues.
> > > > > > > 
> > > > > > > Suggested-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > > > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > > > ---
> > > > > > >  drivers/net/ethernet/intel/ice/ice_xsk.c | 9 +++++++++
> > > > > > >  1 file changed, 9 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > > > index 2388837d6d6c..0350f9c22c62 100644
> > > > > > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > > > @@ -327,6 +327,14 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> > > > > > >  	bool if_running, pool_present = !!pool;
> > > > > > >  	int ret = 0, pool_failure = 0;
> > > > > > >  
> > > > > > > +	if (!is_power_of_2(vsi->rx_rings[qid]->count) ||
> > > > > > > +	    !is_power_of_2(vsi->tx_rings[qid]->count)) {
> > > > > > > +		netdev_err(vsi->netdev,
> > > > > > > +			   "Please align ring sizes at idx %d to power of 2\n", qid);
> > > > > > 
> > > > > > Ideally I'd pass xdp->extack from ice_xdp() to print this message
> > > > > > directly in userspace (note that NL_SET_ERR_MSG{,_MOD}() don't
> > > > > > support string formatting, but the user already knows QID at this
> > > > > > point).
> > > > > 
> > > > > I thought about that as well but it seemed to me kinda off to have a
> > > > > single extack usage in here. Updating the rest of error paths in
> > > > > ice_xsk_pool_setup() to make use of extack is a candidate for a separate
> > > > > patch to me.
> > > > > 
> > > > > WDYT?
> > > > 
> > > > The rest uses string formatting to print the error code, and thus
> > > > would lose their meaning. This one to me is more of the same kind
> > > > as let's say "MTU too large for XDP" message, i.e. user config
> > > > constraints check fail. But I'm fine if you'd prefer to keep a
> > > > single source of output messages throughout the function.
> > > 
> > > Doubling the logs wouldn't hurt - keep current netdev_err with ret codes
> > > and have more meaningful messages carried up to userspace via
> > > NL_SET_ERR_MSG_MOD.
> > 
> > Ah, right, this works as well. Let's leave it as it is for now then.
> 
> Well, I had a feeling that we don't utilize extack for a reason. Turns out
> for XDP_SETUP_XSK_POOL we simply don't provide it.
> 
> struct netdev_bpf {
> 	enum bpf_netdev_command command;
> 	union {
> 		/* XDP_SETUP_PROG */
> 		struct {
> 			u32 flags;
> 			struct bpf_prog *prog;
> 			struct netlink_ext_ack *extack;
> 		};
> 		/* BPF_OFFLOAD_MAP_ALLOC, BPF_OFFLOAD_MAP_FREE */
> 		struct {
> 			struct bpf_offloaded_map *offmap;
> 		};
> 		/* XDP_SETUP_XSK_POOL */
> 		struct {
> 			struct xsk_buff_pool *pool;
> 			u16 queue_id;
> 		} xsk;
> 	};
> 
> I forgot about that :<

Wooh, I missed it completely at some point. I thought it's always
there and available.

From me for the series (writing it here instead of replying to 0/8
since you're going to drop v5 soon anyways :p):

Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>

> 
> };
> > 
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > +		pool_failure = -EINVAL;
> > > > > > > +		goto failure;
> > > > > > > +	}
> > > > > > > +
> > > > > > >  	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
> > > > > > >  
> > > > > > >  	if (if_running) {
> > > > > > > @@ -349,6 +357,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> > > > > > >  			netdev_err(vsi->netdev, "ice_qp_ena error = %d\n", ret);
> > > > > > >  	}
> > > > > > >  
> > > > > > > +failure:
> > > > > > >  	if (pool_failure) {
> > > > > > >  		netdev_err(vsi->netdev, "Could not %sable buffer pool, error = %d\n",
> > > > > > >  			   pool_present ? "en" : "dis", pool_failure);
> > > > > > > -- 
> > > > > > > 2.33.1
> > > > > > 
> > > > > > Thanks,
> > > > > > Al
> > > > 
> > > > Al
> > 
> > Al

Thanks!
Al
