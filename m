Return-Path: <bpf+bounces-78657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA29D16914
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641153043A6E
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908F30AAC2;
	Tue, 13 Jan 2026 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNlV8uQ9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB701301001;
	Tue, 13 Jan 2026 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276443; cv=none; b=LZDcLkOC4ZoxgV1+++EWIImjUzHHTauhsT/CqLRveRta6ArOHggZkjXUFXD4qIg2G1ce6jGS7QU7yFyMGfECafgMwn+WuhBGtSDhgA+YpQbwkeOkkd965hLRuZE6LDJheTUwFis8AF+qe3+iQF39f+7E5y9Mq1pylPz7GOTXWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276443; c=relaxed/simple;
	bh=Vee+ZF4k+QI3gKNh7q25EdKoVHMSaSBX0gMhQ6wi0Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ek8eh6QFJMnSzEPTOAY+GLEIPEohA2pAYsRMSXW24jyUauN+adcg2wZvUqHmynZcunWOf7/Pmo14AbNvNfFZikiVTUfpIlQSCrTtnFPJq2IB+2DYCQ+w6CSAgEHtjyZ7FXS8VAfzj4DT3XSpfvFvGN3cwhuqjzDH7vz0yNZiNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNlV8uQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0673C116C6;
	Tue, 13 Jan 2026 03:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768276442;
	bh=Vee+ZF4k+QI3gKNh7q25EdKoVHMSaSBX0gMhQ6wi0Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNlV8uQ9rSI2CeOwmffhHunueb3BSa4dDsq8sE1YAxF5d675Qh4oQVOFYFJra4hzJ
	 wOG4jc92DcT2bQx+wS+lYpF5xgyfHiR3ZuFeqVk9qvnzJrrdZzmog0cc8hkvIT0DsB
	 pnEqh8tJ//VGWNRlTnfhprvPLvSZDmGdgED6F9JdgVUJrAul+TKAl8zeX193tVNZAn
	 Q/w+M1nRRZ3Pps2s9T9TZk5j7J8tQgZRYkHmuHZPoR3397Z8sMvjsjIV33cQNKdbZ4
	 +G0xjc/1o3qTuOSvnzYAFI47z8AG0i0cM/5wkpskGJ4lxxsf/OHyxcNrLsM3M+Vf+x
	 mUF2zvIWH1o0A==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@iogearbox.net
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	willemb@google.com,
	yangzhenze@bytedance.com,
	razor@blackwall.org,
	dw@davidwei.uk,
	pabeni@redhat.com,
	sdf@fomichev.me,
	wangdongdong.6@bytedance.com,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	magnus.karlsson@intel.com,
	toke@redhat.com,
	davem@davemloft.net
Subject: Re: [net-next,v5,11/16] netkit: Add netkit notifier to check for unregistering devices
Date: Mon, 12 Jan 2026 19:53:58 -0800
Message-ID: <20260113035358.405484-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109212632.146920-12-daniel@iogearbox.net>
References: <20260109212632.146920-12-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
netkit: Add netkit notifier to check for unregistering devices

This commit adds a netdevice notifier to watch for NETDEV_UNREGISTER
events and unregister netkit devices that have leased queues from a
physical device being unregistered.

> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 9d9d74a7e589..d4426c30e0fd 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -1037,6 +1037,49 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
>  	return 0;
>  }
>
> +static void netkit_check_lease_unregister(struct net_device *dev)
> +{
> +	LIST_HEAD(list_kill);
> +	u32 q_idx;
> +
> +	if (READ_ONCE(dev->reg_state) != NETREG_UNREGISTERING ||
> +	    !dev->dev.parent)
> +		return;
> +
> +	for (q_idx = 0; q_idx < dev->real_num_rx_queues; q_idx++) {
> +		struct net_device *tmp = dev;
> +		u32 tmp_q_idx = q_idx;
> +
> +		netdev_lock_ops(dev);
> +		if (netif_rx_queue_lease_get_owner(&tmp, &tmp_q_idx)) {
> +			if (tmp->netdev_ops != &netkit_netdev_ops)
> +				continue;
                                ^^^^^^^^

Can this continue leak the lock acquired by netdev_lock_ops(dev) above? The
netdev_unlock_ops(dev) call is outside this if block, so continuing here
would skip the unlock and potentially deadlock on the next loop iteration
when netdev_lock_ops(dev) is called again.

> +			/* A single phys device can have multiple queues leased
> +			 * to one netkit device. We can only queue that netkit
> +			 * device once to the list_kill. Queues of that phys
> +			 * device can be leased with different individual netkit
> +			 * devices, hence we batch via list_kill.
> +			 */
> +			if (unregister_netdevice_queued(tmp))
> +				continue;
                                ^^^^^^^^

Same issue here - this continue also skips netdev_unlock_ops(dev).

> +			netkit_del_link(tmp, &list_kill);
> +		}
> +		netdev_unlock_ops(dev);
> +	}

[ ... ]

