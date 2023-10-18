Return-Path: <bpf+bounces-12625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF97CEC70
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF7DB20C37
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7746687;
	Wed, 18 Oct 2023 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBcb3c1d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BF4667C;
	Wed, 18 Oct 2023 23:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE80C433C7;
	Wed, 18 Oct 2023 23:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697673575;
	bh=43wvTMvKEndBuSQzafrBMZPiTVttoGCygda/qQSlXC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBcb3c1d0jAmtXDiJuvO0aqLjTEaDRhSCuOJO2huaNZ4pr6D76JB7CNw+WT2LvBp+
	 YgsVTRqLYWQ1hvIqbPu6MDOuzFGJeYlWC1SKpEpTcAeYwE4fqkzV9ckHh4mS+0K3W7
	 apNCPQOa0xvMbbW9QeH83wNvMmpHiQV0avuMRE8szg/jzJj8MvwTOScQA673jGzuAQ
	 c7jk1uzPxsYjhD1Gu+YZxtrnZfQ0L+tFYGOW7adHM1uAp6wHkLVUbuokvVCrUwM9XO
	 Z4mTxMTQIFtfwz+fn4EpCnZejDQWfhUlaFAXSHzRmIzpy9Qkboomdfw+uSoiDD7Hze
	 6FmAsrEX4nmVw==
Date: Wed, 18 Oct 2023 16:59:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Anatoly Burakov <anatoly.burakov@intel.com>, Alexander
 Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
 xdp-hints@xdp-project.net, netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
 Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next v6 08/18] xdp: Add VLAN tag hint
Message-ID: <20231018165931.1016e6c5@kernel.org>
In-Reply-To: <20231012170524.21085-9-larysa.zaremba@intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
	<20231012170524.21085-9-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 19:05:14 +0200 Larysa Zaremba wrote:
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 2943a151d4f1..661f603e3e43 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -44,13 +44,16 @@ enum netdev_xdp_act {
>   *   timestamp via bpf_xdp_metadata_rx_timestamp().
>   * @NETDEV_XDP_RX_METADATA_HASH: Device is capable of exposing receive packet
>   *   hash via bpf_xdp_metadata_rx_hash().
> + * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing stripped
> + *   receive VLAN tag (proto and TCI) via bpf_xdp_metadata_rx_vlan_tag().
>   */
>  enum netdev_xdp_rx_metadata {
>  	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
>  	NETDEV_XDP_RX_METADATA_HASH = 2,
> +	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
>  
>  	/* private: */
> -	NETDEV_XDP_RX_METADATA_MASK = 3,
> +	NETDEV_XDP_RX_METADATA_MASK = 7,
>  };
>  
>  enum {

Top of this file says:

/* Do not edit directly, auto-generated from: */
/*	Documentation/netlink/specs/netdev.yaml */
/* YNL-GEN uapi header */

Please add your new value in Documentation/netlink/specs/netdev.yaml
and then run ./tools/net/ynl/ynl-regen.sh

