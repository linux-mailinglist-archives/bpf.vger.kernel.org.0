Return-Path: <bpf+bounces-14220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257B7E135A
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 13:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5F21C20A53
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26398F51;
	Sun,  5 Nov 2023 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZea+uBL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5823B3;
	Sun,  5 Nov 2023 12:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AB8C433C8;
	Sun,  5 Nov 2023 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699188318;
	bh=sUPYWoPAlcR31U354ashcPSOlMA+P31V4flT2OTwJBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZea+uBLSlu7QJ5oxBZe+s0MUCWa+ghyf62K0CBVWK/sTGPmesOTsZf+01JPfGrDQ
	 gy7bX/XZTVJefkbH4sm+dsaubYvhAv4JFMKBWMVq6rvKYIWUtEsVnt58nkxrG+A+iO
	 78CrFtHNfzf3bUqo8STV0gv3Ao7Rx93uj8kl6mvzu3j6QFOA3w454aCjmVcbztbNxl
	 HcZ6uUsR2vAQa+xLaz2AzCwVW5ZOdGWrOYxVuKMl0xYz8UfJShM843X4p/ERPEB2n2
	 NK2qiJw2ZX6KNjNMggKK1SCFUBDXKbQau+trDHpI29SefRuF0a3+enCwTFrYUVZjgT
	 EG1gx/WMw7+7A==
Date: Sun, 5 Nov 2023 07:45:14 -0500
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
	toke@kernel.org, willemb@google.com, dsahern@kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	yoong.siang.song@intel.com, netdev@vger.kernel.org,
	xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v5 06/13] xsk: Document tx_metadata_len layout
Message-ID: <20231105124514.GD3579@kernel.org>
References: <20231102225837.1141915-1-sdf@google.com>
 <20231102225837.1141915-7-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102225837.1141915-7-sdf@google.com>

On Thu, Nov 02, 2023 at 03:58:30PM -0700, Stanislav Fomichev wrote:
> - how to use
> - how to query features
> - pointers to the examples
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

...

> diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> new file mode 100644
> index 000000000000..4f376560b23f
> --- /dev/null
> +++ b/Documentation/networking/xsk-tx-metadata.rst
> @@ -0,0 +1,70 @@

Hi Stan,

a minor nit from my side: an SPDX licence identifier tag should probably go
here.

> +==================
> +AF_XDP TX Metadata
> +==================
> +
> +This document describes how to enable offloads when transmitting packets
> +via :doc:`af_xdp`. Refer to :doc:`xdp-rx-metadata` on how to access similar
> +metadata on the receive side.

...

