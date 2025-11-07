Return-Path: <bpf+bounces-73920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C1C3E209
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 02:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA813ADB4A
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 01:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481912F616F;
	Fri,  7 Nov 2025 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxJdsgmg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD3286D64;
	Fri,  7 Nov 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478961; cv=none; b=bIAMra/PACckhOcvdGuUkHWRtL/d+jnwWZ85KD8sTD/OgfTJfA0WXpBTUgmShFOAvJGZyOPRAc7eaU7KvuKIEZEWQM8vIBmI/3QrRV7XnPP/MYKT0m2fedDcwi43Icy+sE9+gsy3sy6d6eCH0rJ9FAGVDNCbxGF831c03Ugoo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478961; c=relaxed/simple;
	bh=GbsyoaoMgC5ugJX7CDMoP2LUinPt69SQz5ZnttGKylU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNY8uomGM6fdXslApabJvf4JJISNCHre0seBBpCasebFau3xqfETcXCyxG3lu83qCedFxNS9rdKZrGvgeId1hxkKJyat47PnryPvFSuc13ZAaqPI+iI/rJ3znOEHHDEmbu66NjIjoS4ukgXe8ZJF3HLRduCzQuzalZya0M0WmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxJdsgmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FB4C4CEF7;
	Fri,  7 Nov 2025 01:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762478961;
	bh=GbsyoaoMgC5ugJX7CDMoP2LUinPt69SQz5ZnttGKylU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PxJdsgmg+BdMKGKF2RoB25bnZSE0JPB5UXZySz2/x9cQ0eoqEhJnzGsNRM/PP8VeU
	 PiNLzTIlwkEPxzPBSo2GYUzwS386Ix8S+rTuRI5WpGxNtWvL1fZiuoGjNxqCmkwopq
	 gDXGmXV79vMnoz9xJrSJXllSV0IDpLB4pBfm7tdh7BGni0nha6IaCK9d488cLTzUNn
	 +qa+fUhUgjYHsLBpMkQT83JZtN1UZLzbUrf4Wznb4Puh6wu1EQ9GKndEerhXX++2/p
	 03UWY8xFnLtf7xh4zjhiSkSVai5Fi9ex/qBu3giLMObs1+tMvXCHOrDXloA0xGdvSx
	 M0a1B0E33uiag==
Date: Thu, 6 Nov 2025 17:29:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V3 1/2] veth: enable dev_watchdog for detecting
 stalled TXQs
Message-ID: <20251106172919.24540443@kernel.org>
In-Reply-To: <176236369293.30034.1875162194564877560.stgit@firesoul>
References: <176236363962.30034.10275956147958212569.stgit@firesoul>
	<176236369293.30034.1875162194564877560.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 05 Nov 2025 18:28:12 +0100 Jesper Dangaard Brouer wrote:
> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
> backpressure on full ptr_ring to reduce TX drops") have been found to cau=
se
> a race condition in production environments.
>=20
> Under specific circumstances, observed exclusively on ARM64 (aarch64)
> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
> permanently stalled. This happens when the race condition leads to the TXQ
> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue wak=
e-up,
> preventing the attached qdisc from dequeueing packets and causing the
> network link to halt.
>=20
> As a first step towards resolving this issue, this patch introduces a
> failsafe mechanism. It enables the net device watchdog by setting a timeo=
ut
> value and implements the .ndo_tx_timeout callback.
>=20
> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() function,
> which logs a warning and calls netif_tx_wake_queue() to unstall the queue
> and allow traffic to resume.
>=20
> The log message will look like this:
>=20
>  veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>  veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>=20
> This provides a necessary recovery mechanism while the underlying race
> condition is investigated further. Subsequent patches will address the ro=
ot
> cause and add more robust state handling.
>=20
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to =
reduce TX drops")
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

I think this belongs in net-next.. Fail safe is not really a bug fix.
I'm slightly worried we're missing a corner case and will cause
timeouts to get printed for someone's config.

> +static void veth_tx_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct netdev_queue *txq =3D netdev_get_tx_queue(dev, txqueue);
> +
> +	netdev_err(dev, "veth backpressure stalled(n:%ld) TXQ(%u) re-enable\n",
> +		   atomic_long_read(&txq->trans_timeout), txqueue);

If you think the trans_timeout is useful, let's add it to the message
core prints? And then we can make this msg just veth specific, I don't
think we should be repeating what core already printed.

> +	netif_tx_wake_queue(txq);
> +}
> +
>  static int veth_open(struct net_device *dev)
>  {
>  	struct veth_priv *priv =3D netdev_priv(dev);
> @@ -1711,6 +1723,7 @@ static const struct net_device_ops veth_netdev_ops =
=3D {
>  	.ndo_bpf		=3D veth_xdp,
>  	.ndo_xdp_xmit		=3D veth_ndo_xdp_xmit,
>  	.ndo_get_peer_dev	=3D veth_peer_dev,
> +	.ndo_tx_timeout		=3D veth_tx_timeout,
>  };
> =20
>  static const struct xdp_metadata_ops veth_xdp_metadata_ops =3D {
> @@ -1749,6 +1762,7 @@ static void veth_setup(struct net_device *dev)
>  	dev->priv_destructor =3D veth_dev_free;
>  	dev->pcpu_stat_type =3D NETDEV_PCPU_STAT_TSTATS;
>  	dev->max_mtu =3D ETH_MAX_MTU;
> +	dev->watchdog_timeo =3D msecs_to_jiffies(5000);
> =20
>  	dev->hw_features =3D VETH_FEATURES;
>  	dev->hw_enc_features =3D VETH_FEATURES;
>=20
>=20


