Return-Path: <bpf+bounces-60892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA39ADE363
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DAB3B769C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 06:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C161EA7C4;
	Wed, 18 Jun 2025 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aw9b2FQ7"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B018FC86
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226838; cv=none; b=fCLjvXRX/gDQaQSXvhQ98NTLSeglKHe0YPolmrTwBHFMdR/SRTdwbC/ksR75dNRsS3X39vHWWKGNCzlWTBkbuPNOvt3yRg3JJyiyzwHeOPA+EaacNqk5+LC7DAz4L9ul9KepILQjNQfEUK+dYT1a8Jkn6XjAE0ky4Ew1Fd3P7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226838; c=relaxed/simple;
	bh=gVpRGpWbvK2l2EgWkUdriQt0Z8wJ5SQFwm0/UlJCZCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G368T3r9U7kSn387tfDBYXyMnjniibDDFGFCMT5E37SjaSMuXKYzNmyH6pgGgHZvHu3JLZUl/nt+YTP6TUqFSQPZRO8srvTrL8XPGfhsg+8K9al+WyyqFi2TgEwG2zfR62dut8UntaL5SZZnAk+OfEMa+H6YQDNK0mMPF4uJNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aw9b2FQ7; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <325ab9a0-44d1-44a2-aefe-9cd49dcd12f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750226827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NkuFePhrx7gFmJOrw5AAMhKELjMHQfD+AdCkLnFiRGI=;
	b=aw9b2FQ7pNugXJV0VcM6mLYbw5VWRu7wvN+6UUWbwbPdlWLsDYLiwI6KgDtMGuzIpy8nW3
	2NBbXpHvUFxO9U7iE2frkLEYATSmZ6ODBNCYhLpOUIlXQmYLj2uJ34QHWIA4wSucCXacT0
	nZWvDmjbsLGMme3pBGyRInNwmZuxNTk=
Date: Tue, 17 Jun 2025 23:06:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 10/12] net/mlx5e: Implement queue mgmt ops and
 single channel swap
To: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>
Cc: saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>
References: <20250616141441.1243044-1-mbloch@nvidia.com>
 <20250616141441.1243044-11-mbloch@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250616141441.1243044-11-mbloch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/16 7:14, Mark Bloch 写道:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> The bulk of the work is done in mlx5e_queue_mem_alloc, where we allocate
> and create the new channel resources, similar to
> mlx5e_safe_switch_params, but here we do it for a single channel using
> existing params, sort of a clone channel.
> To swap the old channel with the new one, we deactivate and close the
> old channel then replace it with the new one, since the swap procedure
> doesn't fail in mlx5, we do it all in one place (mlx5e_queue_start).
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 98 +++++++++++++++++++
>   1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index a51e204bd364..873a42b4a82d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5494,6 +5494,103 @@ static const struct netdev_stat_ops mlx5e_stat_ops = {
>   	.get_base_stats      = mlx5e_get_base_stats,
>   };
>   
> +struct mlx5_qmgmt_data {
> +	struct mlx5e_channel *c;
> +	struct mlx5e_channel_param cparam;
> +};
> +
> +static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
> +				 int queue_index)
> +{
> +	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +	struct mlx5e_channels *chs = &priv->channels;
> +	struct mlx5e_params params = chs->params;

RCT (Reverse Christmas Tree) ?

Yanjun.Zhu

> +	struct mlx5_core_dev *mdev;
> +	int err;
> +
> +	mutex_lock(&priv->state_lock);
> +	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
> +		err = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	if (queue_index >= chs->num) {
> +		err = -ERANGE;
> +		goto unlock;
> +	}
> +
> +	if (MLX5E_GET_PFLAG(&chs->params, MLX5E_PFLAG_TX_PORT_TS) ||
> +	    chs->params.ptp_rx   ||
> +	    chs->params.xdp_prog ||
> +	    priv->htb) {
> +		netdev_err(priv->netdev,
> +			   "Cloning channels with Port/rx PTP, XDP or HTB is not supported\n");
> +		err = -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
> +	mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, queue_index);
> +	err = mlx5e_build_channel_param(mdev, &params, &new->cparam);
> +	if (err)
> +		goto unlock;
> +
> +	err = mlx5e_open_channel(priv, queue_index, &params, NULL, &new->c);
> +unlock:
> +	mutex_unlock(&priv->state_lock);
> +	return err;
> +}
> +
> +static void mlx5e_queue_mem_free(struct net_device *dev, void *mem)
> +{
> +	struct mlx5_qmgmt_data *data = (struct mlx5_qmgmt_data *)mem;
> +
> +	/* not supposed to happen since mlx5e_queue_start never fails
> +	 * but this is how this should be implemented just in case
> +	 */
> +	if (data->c)
> +		mlx5e_close_channel(data->c);
> +}
> +
> +static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queue_index)
> +{
> +	/* In mlx5 a txq cannot be simply stopped in isolation, only restarted.
> +	 * mlx5e_queue_start does not fail, we stop the old queue there.
> +	 * TODO: Improve this.
> +	 */
> +	return 0;
> +}
> +
> +static int mlx5e_queue_start(struct net_device *dev, void *newq,
> +			     int queue_index)
> +{
> +	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +	struct mlx5e_channel *old;
> +
> +	mutex_lock(&priv->state_lock);
> +
> +	/* stop and close the old */
> +	old = priv->channels.c[queue_index];
> +	mlx5e_deactivate_priv_channels(priv);
> +	/* close old before activating new, to avoid napi conflict */
> +	mlx5e_close_channel(old);
> +
> +	/* start the new */
> +	priv->channels.c[queue_index] = new->c;
> +	mlx5e_activate_priv_channels(priv);
> +	mutex_unlock(&priv->state_lock);
> +	return 0;
> +}
> +
> +static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
> +	.ndo_queue_mem_size	=	sizeof(struct mlx5_qmgmt_data),
> +	.ndo_queue_mem_alloc	=	mlx5e_queue_mem_alloc,
> +	.ndo_queue_mem_free	=	mlx5e_queue_mem_free,
> +	.ndo_queue_start	=	mlx5e_queue_start,
> +	.ndo_queue_stop		=	mlx5e_queue_stop,
> +};
> +
>   static void mlx5e_build_nic_netdev(struct net_device *netdev)
>   {
>   	struct mlx5e_priv *priv = netdev_priv(netdev);
> @@ -5504,6 +5601,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
>   	SET_NETDEV_DEV(netdev, mdev->device);
>   
>   	netdev->netdev_ops = &mlx5e_netdev_ops;
> +	netdev->queue_mgmt_ops = &mlx5e_queue_mgmt_ops;
>   	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
>   	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
>   	netdev->request_ops_lock = true;


