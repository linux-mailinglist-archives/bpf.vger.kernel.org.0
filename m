Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4705D49B33B
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 12:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381751AbiAYLwP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 06:52:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:24661 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354551AbiAYLtm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 06:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643111382; x=1674647382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XgPBEn+pv0EEtiEI4b0vg2zPYktvxuIAfYsv/F36xPA=;
  b=LQmOQ3yNBdovCKJMOZho65stmA29CfLXtkyoXH0VfNVNlbEj9ZaBbJJB
   FMiwXeQTtCy4vnvYAWG/L4F0a+DEYnArVN9DxZLjxRmqshTiVztpDQk7F
   gnMkRXybZtyVx1PC+s5zPokZSdqNktIOiM9G6Vn/VCIVUIfBhczUvaXEm
   RAEeQyxM3BsxTljeEwYLs1F3zhcb8w/oc6+xbY5CJ/1jdrDu5YMMoA4+j
   ad1PowAQjdMnwWsRbe5GK51SJ1nELv1ZZlP0ovTBr9AA9wHvV1D4+0ZPk
   tj1RvA26J5MDJ+KAIMj2krBrgpSmkcs8dKthyMB62QGjfxEtnp76XJyXT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="270728189"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="270728189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 03:49:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="673965569"
Received: from boxer.igk.intel.com (HELO boxer) ([10.102.20.173])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2022 03:49:37 -0800
Date:   Tue, 25 Jan 2022 12:49:36 +0100
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, magnus.karlsson@intel.com
Subject: Re: [PATCH bpf-next v4 2/8] ice: xsk: force rings to be sized to
 power of 2
Message-ID: <Ye/j0FjYCeJlbWR/@boxer>
References: <20220124165547.74412-1-maciej.fijalkowski@intel.com>
 <20220124165547.74412-3-maciej.fijalkowski@intel.com>
 <20220125112306.746139-1-alexandr.lobakin@intel.com>
 <Ye/e9GqLkuekqFos@boxer>
 <20220125114202.748079-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125114202.748079-1-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 12:42:02PM +0100, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Tue, 25 Jan 2022 12:28:52 +0100
> 
> > On Tue, Jan 25, 2022 at 12:23:06PM +0100, Alexander Lobakin wrote:
> > > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Date: Mon, 24 Jan 2022 17:55:41 +0100
> > > 
> > > > With the upcoming introduction of batching to XSK data path,
> > > > performance wise it will be the best to have the ring descriptor count
> > > > to be aligned to power of 2.
> > > > 
> > > > Check if rings sizes that user is going to attach the XSK socket fulfill
> > > > the condition above. For Tx side, although check is being done against
> > > > the Tx queue and in the end the socket will be attached to the XDP
> > > > queue, it is fine since XDP queues get the ring->count setting from Tx
> > > > queues.
> > > > 
> > > > Suggested-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/ice/ice_xsk.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > index 2388837d6d6c..0350f9c22c62 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > @@ -327,6 +327,14 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> > > >  	bool if_running, pool_present = !!pool;
> > > >  	int ret = 0, pool_failure = 0;
> > > >  
> > > > +	if (!is_power_of_2(vsi->rx_rings[qid]->count) ||
> > > > +	    !is_power_of_2(vsi->tx_rings[qid]->count)) {
> > > > +		netdev_err(vsi->netdev,
> > > > +			   "Please align ring sizes at idx %d to power of 2\n", qid);
> > > 
> > > Ideally I'd pass xdp->extack from ice_xdp() to print this message
> > > directly in userspace (note that NL_SET_ERR_MSG{,_MOD}() don't
> > > support string formatting, but the user already knows QID at this
> > > point).
> > 
> > I thought about that as well but it seemed to me kinda off to have a
> > single extack usage in here. Updating the rest of error paths in
> > ice_xsk_pool_setup() to make use of extack is a candidate for a separate
> > patch to me.
> > 
> > WDYT?
> 
> The rest uses string formatting to print the error code, and thus
> would lose their meaning. This one to me is more of the same kind
> as let's say "MTU too large for XDP" message, i.e. user config
> constraints check fail. But I'm fine if you'd prefer to keep a
> single source of output messages throughout the function.

Doubling the logs wouldn't hurt - keep current netdev_err with ret codes
and have more meaningful messages carried up to userspace via
NL_SET_ERR_MSG_MOD.

> 
> > 
> > > 
> > > > +		pool_failure = -EINVAL;
> > > > +		goto failure;
> > > > +	}
> > > > +
> > > >  	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
> > > >  
> > > >  	if (if_running) {
> > > > @@ -349,6 +357,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> > > >  			netdev_err(vsi->netdev, "ice_qp_ena error = %d\n", ret);
> > > >  	}
> > > >  
> > > > +failure:
> > > >  	if (pool_failure) {
> > > >  		netdev_err(vsi->netdev, "Could not %sable buffer pool, error = %d\n",
> > > >  			   pool_present ? "en" : "dis", pool_failure);
> > > > -- 
> > > > 2.33.1
> > > 
> > > Thanks,
> > > Al
> 
> Al
