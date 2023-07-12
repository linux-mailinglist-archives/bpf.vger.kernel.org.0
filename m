Return-Path: <bpf+bounces-4813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E374FC23
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 02:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB69D1C20E10
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 00:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E99394;
	Wed, 12 Jul 2023 00:32:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DBD362;
	Wed, 12 Jul 2023 00:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65862C433C7;
	Wed, 12 Jul 2023 00:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689121948;
	bh=PTOTcpcxaw8WH84nNL7V6AheHGo/Ep2KZo1K6pljj0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bJCHI/nEmegoQi3lZtuJO8xmipR7Sq5ohXo+8/EEv3dBX4OEtMAjgwM4ZT1xe/hWq
	 XkaFK8qbis4J4tuO+IB0Lri7g0lMuIac+AM7MHH+vYPzbAaov4RF6LhnXbiIr+UWCf
	 mskmKeLInQdXt6e/i0tPpZ5duSE6dNkoQtI9vfCmWV9pfg+L88awR7PhMcOTaEQWZG
	 vQef/tQeC/CldkjcTi2RBEihWBR+5HBHpzd8UVRZCNOj6gEbzWAg3odS3HGXttPkrA
	 1ZUrsighM82qTD0+7YTZ3GMcxDM1zBPkXrFGuVMShSyWr84wDhGxKhnaC7sKzxC15R
	 jJTrfjj0jSpHg==
Date: Tue, 11 Jul 2023 17:32:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
Message-ID: <20230711173226.7e9cca4a@kernel.org>
In-Reply-To: <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
References: <20230707193006.1309662-1-sdf@google.com>
	<20230707193006.1309662-10-sdf@google.com>
	<20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 15:56:57 -0700 Alexei Starovoitov wrote:
> I think this proves my point: csum is not generalizable even across veth and mlx5.
> Above is a square peg that tries to fit csum_start/offset api (that makes sense from SW pov)
> into HW that has different ideas about csum-ing.
> 
> Here is what mlx5 does:
> mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>                             struct mlx5e_accel_tx_state *accel,
>                             struct mlx5_wqe_eth_seg *eseg)
> {
>         if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, eseg)))
>                 return;
> 
>         if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
>                 eseg->cs_flags = MLX5_ETH_WQE_L3_CSUM;
>                 if (skb->encapsulation) {

This should be irrelevant today, as LCO exists?

>                         eseg->cs_flags |= MLX5_ETH_WQE_L3_INNER_CSUM |
>                                           MLX5_ETH_WQE_L4_INNER_CSUM;
>                         sq->stats->csum_partial_inner++;
>                 } else {
>                         eseg->cs_flags |= MLX5_ETH_WQE_L4_CSUM;
>                         sq->stats->csum_partial++;
>                 }
> 
> How would you generalize that into csum api that will work across NICs ?
> 
> My answer stands: you cannot.
> 
> My proposal again:
> add driver specifc kfuncs and hooks for things like csum.
> 
> Kuba,
> since you nacked driver specific stuff please suggest a way to unblock this stalemate.

I hope I'm not misremembering but I think I suggested at the beginning
to create a structure describing packet geometry and requested offloads,
and for the prog fill that in.

All operating systems I know end up doing that, we'll end up doing
that as well. The question is whether we're willing to learn from
experience or prefer to go on a wild ride first...

