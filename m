Return-Path: <bpf+bounces-27782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957428B19AD
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 05:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52404284779
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 03:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E7229D05;
	Thu, 25 Apr 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQsLg63v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF02199BC;
	Thu, 25 Apr 2024 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016664; cv=none; b=O+ZsrIKBu5hrPWdzI/3243wPZCrgNN28YQjWYdGizlLi+fzDiz5FWDzqPrIrSHxkWc6OATQoGnuiHl3Hr48PO6JwvK3m3r18885GrVKCNfe8gaod6y8W0vVM6NjSArInxXB2PAszkSOcAboiznAMku2jpaFPv+voTMqya7cpm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016664; c=relaxed/simple;
	bh=QUkDy7HxFx/R/yI3SFwb/lZxpKbpJkJeekaDPGaTPKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Htr595Cp3NZsLVLtSCAqYd2bAH3bDs39rojU2G20TkiwcbRDh2qP3ARo4GOpKPz9prwplJsucnosE4MVJCV0DROPq3wsuyTaoGdD0x5nBSknlU6zhG0CpR5IbsG9y1U+TNQYLUMkMzxWfpUdy0FajiT73o+GHoWzUyXc6+CYENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQsLg63v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F8FC113CC;
	Thu, 25 Apr 2024 03:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016664;
	bh=QUkDy7HxFx/R/yI3SFwb/lZxpKbpJkJeekaDPGaTPKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SQsLg63vr83HMJ/mecA4wR3M3bOrQxHvfg2zyl+6p2XKZbtH+rhfS7/TvamV7tSV8
	 8KsFvLAFDGgPuuyoXIksOSeqnodDrKdIto7PwrwUaic4PKetZ+XbbSpb4Cg62RcOU6
	 XsXmpRvSSJc5XW4O9oWTL4dl4bB3u3MjCpsZBn3VsROmLlUS7vs9/31gqmVH7vL3MO
	 4s0VwKLiFYXkbPdcOmxA9aKjLoQ5O0ZbcUdEQud+UHCQ/BYXJZtt+NGb4fjGWBPOrg
	 rWEcb+6BM3DT5LbZ83UG0ibpdoe+oLusrjHwIQO7ECvbsRsBtMbc0dxkkZ1RtBetKH
	 kgPbjLonqizuA==
Date: Wed, 24 Apr 2024 20:44:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Amritha
 Nambiar <amritha.nambiar@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 8/8] virtio-net: support queue stat
Message-ID: <20240424204422.71c20b3f@kernel.org>
In-Reply-To: <20240423113141.1752-9-xuanzhuo@linux.alibaba.com>
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
	<20240423113141.1752-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 19:31:41 +0800 Xuan Zhuo wrote:
> +static void virtnet_get_base_stats(struct net_device *dev,
> +				   struct netdev_queue_stats_rx *rx,
> +				   struct netdev_queue_stats_tx *tx)
> +{
> +	/* The queue stats of the virtio-net will not be reset. So here we
> +	 * return 0.
> +	 */
> +	rx->bytes = 0;
> +	rx->packets = 0;
> +	rx->alloc_fail = 0;
> +	rx->hw_drops = 0;
> +	rx->hw_drop_overruns = 0;
> +	rx->csum_unnecessary = 0;
> +	rx->csum_none = 0;
> +	rx->csum_bad = 0;
> +	rx->hw_gro_packets = 0;
> +	rx->hw_gro_bytes = 0;
> +	rx->hw_gro_wire_packets = 0;
> +	rx->hw_gro_wire_bytes = 0;
> +	rx->hw_drop_ratelimits = 0;
> +
> +	tx->bytes = 0;
> +	tx->packets = 0;
> +	tx->hw_drops = 0;
> +	tx->hw_drop_errors = 0;
> +	tx->csum_none = 0;
> +	tx->needs_csum = 0;
> +	tx->hw_gso_packets = 0;
> +	tx->hw_gso_bytes = 0;
> +	tx->hw_gso_wire_packets = 0;
> +	tx->hw_gso_wire_bytes = 0;
> +	tx->hw_drop_ratelimits = 0;

Doesn't this need to be conditional based on device capabilities?
We should only assign the stats that the device is collecting
(both in base stats and per-queue).

