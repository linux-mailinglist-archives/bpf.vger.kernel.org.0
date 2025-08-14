Return-Path: <bpf+bounces-65592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE66B258C7
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 03:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A884B585BC6
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 01:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CEF184540;
	Thu, 14 Aug 2025 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WwNUwWBr"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F92D23B0;
	Thu, 14 Aug 2025 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133894; cv=none; b=aufsGPEzvLQroLlihJ21qMbnLt2it5l575tkSmhE4b7RY6N/mCkVUB8KoAC7ua4guF5F5frJxo/V0Fm/Mg85wGzr2+1stdaBz9gyH1JuT1FSqR45x/1dXHF1EoO+03RSgw3PZ5dcIGRENssd8tX0tj3Pz/0PO7NrhyiZcRjSpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133894; c=relaxed/simple;
	bh=XJIig21WqK4b4EcBXflRF2hKoC3oV/jWqdwFWSgYtLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7YsK7q/J15ZegcERd4PbMQj5As6x6jycluXCJZsF8Ar+baNNF7mv6fED9bXVeBRfPFiH4OmkGG3U6x90NnAQm+fP/sxdLw1DpZ2bvIDgNG4WZoi76aTRygAXSdcBgo+z19FFbpNl6g+Qrc1K62aHbTtLkciuBvKFttDGrLHINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WwNUwWBr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 902422015E5E; Wed, 13 Aug 2025 18:11:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 902422015E5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755133892;
	bh=LPV047bXOThMstCe4e8lAmvOoRt4u5HfZm/JlOTqLoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwNUwWBrWNB0B7vHZXCOOXkTTMZUOr/Yd4JX2nARAru4D+FgsfQTxuQVqlRhSJaq6
	 vX3AGd8ENZVjl9ZsBXI0W435pGpFGIvl4fEJHXbSH+vR5BrcIXHKAWVS/x2aLjIb/k
	 3z/tAUDJQdupkiyAdoJW7MEZKGlDATyZxVn/9AzE=
Date: Wed, 13 Aug 2025 18:11:32 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
	ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com, rosenp@gmail.com,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v4] net: mana: Use page pool fragments for RX
 buffers instead of full pages to improve memory efficiency.
Message-ID: <20250814011132.GA30001@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250811222919.GA25951@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250813164847.62ade421@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813164847.62ade421@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jakub,

Thank you for the review comments,

On Wed, Aug 13, 2025 at 04:48:47PM -0700, Jakub Kicinski wrote:
> On Mon, 11 Aug 2025 15:29:19 -0700 Dipayaan Roy wrote:
> > -	if (apc->port_is_up)
> > +	if (apc->port_is_up) {
> > +		/* Re-create rxq's after xdp prog was loaded or unloaded.
> > +		 * Ex: re create rxq's to switch from full pages to smaller
> > +		 * size page fragments when xdp prog is unloaded and
> > +		 * vice-versa.
> > +		 */
> > +
> > +		/* Pre-allocate buffers to prevent failure in mana_attach */
> > +		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> > +		if (err) {
> > +			NL_SET_ERR_MSG_MOD
> > +			    (extack,
> > +			    "XDP: Insufficient memory for tx/rx re-config");
> 
> This weird line breaking is not necessary, checkpatch understands that
> string can go over line limit:
> 
> 			NL_SET_ERR_MSG_MOD(extack,
> 					   "XDP: Insufficient memory for tx/rx re-config");
> 
Ok, I willl rectify this in v5.

> > +			return err;
> 
> I think you already replaced the bpf program at this point? 
> So the allocation should happen earlier. On failure changes
> to the driver state should be undone.
The bpf prog gets completely replaced in mana_chn_setxdp,
I suggest these changes below to address your point on alloc failure
and will work on a v5:

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index e616f4239294..0000c1dd7aa2 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -196,9 +196,6 @@ static int mana_xdp_set(struct net_device *ndev,
struct bpf_prog *prog,
         */
        apc->bpf_prog = prog;
 
-       if (old_prog)
-               bpf_prog_put(old_prog);
-
        if (apc->port_is_up) {
                /* Re-create rxq's after xdp prog was loaded or
 * unloaded.
                 * Ex: re create rxq's to switch from full pages to
                 * smaller
@@ -237,6 +234,9 @@ static int mana_xdp_set(struct net_device *ndev,
struct bpf_prog *prog,
                mana_pre_dealloc_rxbufs(apc);
        }
 
+       if (old_prog)
+               bpf_prog_put(old_prog);
+
        if (prog)
                ndev->max_mtu = MANA_XDP_MTU_MAX;
        else
@@ -245,6 +245,7 @@ static int mana_xdp_set(struct net_device *ndev,
struct bpf_prog *prog,
        return 0;
 
 err_dealloc_rxbuffs:
+       apc->bpf_prog = old_prog;
        mana_pre_dealloc_rxbufs(apc);
        return err;
 }

> -- 
> pw-bot: cr

Thanks
Dipayaan Roy

