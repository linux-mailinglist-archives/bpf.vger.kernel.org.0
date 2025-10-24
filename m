Return-Path: <bpf+bounces-71980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9E2C041D5
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 04:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE1B3AA310
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE39241696;
	Fri, 24 Oct 2025 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biLt8+iI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C72288CB;
	Fri, 24 Oct 2025 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272925; cv=none; b=A0PJrlvZmVvp2awye5Gl9Rbqq9zYkhmANrxt+RoKRXLTsXgPImA23qajQZ8ZkpzgaSD1VRC2N69b66g/j9Akx0inYIaVBKsxtO2Ktu6dpD88jLRx5rqRREfYVkizTWhkv0/SahmYocFxtmxVb6SxDF8sw54VJXcneOO3Rphnzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272925; c=relaxed/simple;
	bh=qcWpSJpnvwW5Bdea8Eat881m5aAkhS4so/TAMpDJhHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Na542qE6ICfNbWAPpYezVxmWrnHJAExmzFvKKt+6v1peMyw1KFoTz0XZsT5T+AktjRHeJgI/BKN/Www+EqVyQJBZwPuDzMFS/j5ZVwZGj3mjxH0BL1pV6o8lgiLIhBF0195yNcfUFAKS/2KF+zeic5y+FGk8nniKv/+EFaXB9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biLt8+iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC9CC4CEE7;
	Fri, 24 Oct 2025 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761272924;
	bh=qcWpSJpnvwW5Bdea8Eat881m5aAkhS4so/TAMpDJhHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=biLt8+iIS7V5COE0EEtRUqEDXv4weiSb+S6tcekJlSzU2x2KFPNwLVBaHBMZpPHUl
	 KcCv6gjMF0QXYscQp+FpX5QAUzcK7v5dPTcIczlTNIhEvH4/EIK12fdwmTRiqDskAE
	 R+a8Kro+QE3+6L39w6PxCQ9AIf6jLZUUjdRDF9sQJDHI+8X4aQEBcuWIkT2o0YcCTS
	 NWCaRKdcTR6bFfJtvBbJqbQ9s8OHfApmgxB2dZynbFJwMxa5AU057eK/2FMRugha4r
	 ZYT/aQwFtmMEmsgEKU7b+BatJ2VkERaaVwWxPjy08NeFUEOLLe8kcPjNZJGJX0qMul
	 G6u5DoM7+je4g==
Date: Thu, 23 Oct 2025 19:28:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
Message-ID: <20251023192842.31a2efc0@kernel.org>
In-Reply-To: <20251020162355.136118-3-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
	<20251020162355.136118-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 18:23:42 +0200 Daniel Borkmann wrote:
> +void netdev_rx_queue_peer(struct net_device *src_dev,
> +			  struct netdev_rx_queue *src_rxq,
> +			  struct netdev_rx_queue *dst_rxq)
> +{
> +	netdev_assert_locked(src_dev);
> +	netdev_assert_locked(dst_rxq->dev);
> +
> +	netdev_hold(src_dev, &src_rxq->dev_tracker, GFP_KERNEL);

Isn't ->dev_tracker already used by sysfs?

Are you handling the underlying device going away?

> +	__netdev_rx_queue_peer(src_rxq, dst_rxq);
> +}

