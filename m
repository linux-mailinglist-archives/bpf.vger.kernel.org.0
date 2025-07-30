Return-Path: <bpf+bounces-64708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91CB162A2
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBA317799F
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4E02D9EE5;
	Wed, 30 Jul 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ49GT34"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229C2D8368;
	Wed, 30 Jul 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885412; cv=none; b=X/9DVeYaN9IG0GMptM5TqDlcXgOjaYhzi3D9ao9/S5AIHhhOIqmshCKVOVlePXdO7IA09ZCq3WMbsOScr+rkxZF9ar9/q2OsZT1le6pgjxDzMROHa1jHrd65gbOG5QKIX2XVjumj+Rp7ViXWglxmENF7zkjrKbaYTRX7ho+cG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885412; c=relaxed/simple;
	bh=bN3kpeBwpOhmVfqJEu1+fLesJgASyi+hPMoIHv1PTnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPWXe9Dvr7civRF68CC7DqtcyidUrnp/qoH3hQOdBoM6nGhnjLbuxfwGh+1M3Zx3aEUvhPh3uM0+O49eLmnQm41b/YNlHXah86TXvhGkTIX8GYeQy2TCRdHhsU4u3MHW6Mix2XV1kN1J1arCMAoX8af2eNqRkBI+MdhRki5LNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ49GT34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6230C4CEE7;
	Wed, 30 Jul 2025 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753885412;
	bh=bN3kpeBwpOhmVfqJEu1+fLesJgASyi+hPMoIHv1PTnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZ49GT34bpU+9OBIrS+aROiM26mkG8ip1uscxtH0VTiL2gvHo0MoT+8TL4ZWbIwyb
	 +cw78Y0gveoSajUbNFKLl3wNEc5dL5Qo4FAGloVvopdsXizatNaCONWvomJ0xbiqCl
	 KyQWVhERFfiSigWxCG45a2/skTYrn+ESmrScseOh/rC1mNKoWGZHXEvECn7cXjFiqz
	 rAU99WbFZTaS0RsjzEOTbreNZVJcuS+ae9SRG/5oL8tPPsgZ+2MNveymVbrs2x0sA5
	 78WxI7dnDE7ZTFohCIAv1eQ7AzRBv138vhy4itHbLDjyYL0s5OKkSlMJtVo47zrZcB
	 lRkhCpakvILIA==
Date: Wed, 30 Jul 2025 15:23:24 +0100
From: Simon Horman <horms@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kuba@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
	ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com, rosenp@gmail.com,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
	dipayanroy@microsoft.com
Subject: Re: [PATCH v3] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
Message-ID: <20250730142324.GH1877762@horms.kernel.org>
References: <20250729201410.GA4555@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729201410.GA4555@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Jul 29, 2025 at 01:14:10PM -0700, Dipayaan Roy wrote:
> This patch enhances RX buffer handling in the mana driver by allocating
> pages from a page pool and slicing them into MTU-sized fragments, rather
> than dedicating a full page per packet. This approach is especially
> beneficial on systems with large page sizes like 64KB.
> 
> Key improvements:
> 
> - Proper integration of page pool for RX buffer allocations.
> - MTU-sized buffer slicing to improve memory utilization.
> - Reduce overall per Rx queue memory footprint.
> - Automatic fallback to full-page buffers when:
>    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
>    * The XDP path is active, to avoid complexities with fragment reuse.
> 
> Testing on VMs with 64KB pages shows around 200% throughput improvement.
> Memory efficiency is significantly improved due to reduced wastage in page
> allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
> page for MTU size of 1500, instead of 1 rx buffer per page previously.
> 
> Tested:
> 
> - iperf3, iperf2, and nttcp benchmarks.
> - Jumbo frames with MTU 9000.
> - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
>   testing the XDP path in driver.
> - Memory leak detection (kmemleak).
> - Driver load/unload, reboot, and stress scenarios.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> 

nit: I'd have put your signed-off-by last,
     as your're posting it after the Reviewed-by tags were provided

     Also, no blank line between tags please.

> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

...

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> index d30721d4516f..1cf470b25167 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> @@ -174,6 +174,8 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
>  	struct mana_port_context *apc = netdev_priv(ndev);
>  	struct bpf_prog *old_prog;
>  	struct gdma_context *gc;
> +	int err = 0;
> +	bool dealloc_rxbufs_pre = false;

Please arrange local variables in Networking code in reverse xmas tree
order - longest line to shortest.

Edward Cree's tool can be of assistance in this area:
https://github.com/ecree-solarflare/xmastree

>  
>  	gc = apc->ac->gdma_dev->gdma_context;
>  
> @@ -198,15 +200,45 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
>  
> -	if (apc->port_is_up)
> +	if (apc->port_is_up) {
> +		/* Re-create rxq's after xdp prog was loaded or unloaded.
> +		 * Ex: re create rxq's to switch from full pages to smaller
> +		 * size page fragments when xdp prog is unloaded and vice-versa.
> +		 */
> +
> +		/* Pre-allocate buffers to prevent failure in mana_attach later */

As is still preferred for Networking code, please line wrap code so that it
is 80 columns wide or less, where it can be done without reducing
readability. This is the case for the line above. But not the netdev_err()
call below.

Flagged by: checkpatch.pl --max-line-length=80

> +		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> +		if (err) {
> +			netdev_err(ndev,
> +				   "Insufficient memory for rx buf config change\n");

I believe that any errors in mana_pre_alloc_rxbufs() will
relate to memory allocation. And that errors will be logged by
the mm subsustem. So no log is needed here.

But I do wonder if here, and elsewhere, extack should be set on error.

> +			goto out;
> +		}
> +		dealloc_rxbufs_pre = true;
> +
> +		err = mana_detach(ndev, false);
> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed at xdp set: %d\n", err);
> +			goto out;
> +		}
> +
> +		err = mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed at xdp set: %d\n", err);
> +			goto out;
> +		}
> +
>  		mana_chn_setxdp(apc, prog);
> +	}
>  
>  	if (prog)
>  		ndev->max_mtu = MANA_XDP_MTU_MAX;
>  	else
>  		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
>  
> -	return 0;
> +out:
> +	if (dealloc_rxbufs_pre)
> +		mana_pre_dealloc_rxbufs(apc);
> +	return err;
>  }

It's subjective to be sure, but I would suggest separating the
error and non-error paths wrt calling mana_pre_dealloc_rxbufs().
I feel this is an easier flow to parse (is my proposal correct?),
and more idiomatic.

I'm suggesting something like this incremental change (compile tested only!).

Suggestion #1

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index b6cbe853dc98..bbe64330a3e1 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -174,8 +174,7 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	struct mana_port_context *apc = netdev_priv(ndev);
 	struct bpf_prog *old_prog;
 	struct gdma_context *gc;
-	int err = 0;
-	bool dealloc_rxbufs_pre = false;
+	int err;
 
 	gc = apc->ac->gdma_dev->gdma_context;
 
@@ -211,23 +210,23 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 		if (err) {
 			netdev_err(ndev,
 				   "Insufficient memory for rx buf config change\n");
-			goto out;
+			return err;
 		}
-		dealloc_rxbufs_pre = true;
 
 		err = mana_detach(ndev, false);
 		if (err) {
 			netdev_err(ndev, "mana_detach failed at xdp set: %d\n", err);
-			goto out;
+			goto err_dealloc_rxbuffs;
 		}
 
 		err = mana_attach(ndev);
 		if (err) {
 			netdev_err(ndev, "mana_attach failed at xdp set: %d\n", err);
-			goto out;
+			goto err_dealloc_rxbuffs;
 		}
 
 		mana_chn_setxdp(apc, prog);
+		mana_pre_dealloc_rxbufs(apc);
 	}
 
 	if (prog)
@@ -235,9 +234,10 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	else
 		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
 
-out:
-	if (dealloc_rxbufs_pre)
-		mana_pre_dealloc_rxbufs(apc);
+	return 0;
+
+err_dealloc_rxbuffs:
+	mana_pre_dealloc_rxbufs(apc);
 	return err;
 }

Suggestion #2

Looking at the scope of the mana_pre_alloc_rxbufs() allocation,
it seems to me that it would be nicer to move the rxq recreation
to a separate function.

Something like this (also compile tested only):

/* Re-create rxq's after xdp prog was loaded or unloaded.
 * Ex: re create rxq's to switch from full pages to smaller size page
 * fragments when xdp prog is unloaded and vice-versa.
 */
static int mana_recreate_rxqs(struct net_device *ndev, struct bpf_prog *prog)
{
	struct mana_port_context *apc = netdev_priv(ndev);
	int err;

	if (!apc->port_is_up)
		return 0;

	/* Pre-allocate buffers to prevent failure in mana_attach later */
	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
	if (err) {
		netdev_err(ndev,
			   "Insufficient memory for rx buf config change\n");
		return err;
	}

	err = mana_detach(ndev, false);
	if (err) {
		netdev_err(ndev, "mana_detach failed at xdp set: %d\n", err);
		goto err_dealloc_rxbuffs;
	}

	err = mana_attach(ndev);
	if (err) {
		netdev_err(ndev, "mana_attach failed at xdp set: %d\n", err);
		goto err_dealloc_rxbuffs;
	}

	mana_chn_setxdp(apc, prog);
	mana_pre_dealloc_rxbufs(apc);

	return 0;

err_dealloc_rxbuffs:
	mana_pre_dealloc_rxbufs(apc);
	return err;
}

Note, I still think some thought should be given to setting extack on
error.  But I didn't address that in my suggestions above.


On process, this appears to be an enhancement targeted at net-next.
It would be best to set the target tree in the subject, like this:

	Subject [PATCH net-next v4] ...

And if so, net-next is currently closed for the merge-window.

## Form letter - net-next-closed

The merge window for v6.17 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after 11th August.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: defer

