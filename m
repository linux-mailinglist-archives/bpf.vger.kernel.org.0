Return-Path: <bpf+bounces-16862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46250806A25
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8441C20863
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DC919BA8;
	Wed,  6 Dec 2023 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgDT3i0O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264230328;
	Wed,  6 Dec 2023 08:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD3BC433C8;
	Wed,  6 Dec 2023 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701852780;
	bh=+IYtOVz2kpJEotnMQz4EXG/tnUgNLWhkym3WPDE4lXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GgDT3i0OlekoCxB5sVlO8sTPlPzrV570smvS4HkJRh+Yh43IL0xY6KPzg65uO5aou
	 0PHre4gbSrYnFJd1XJFIyiLLVTWG9PYvHC+5nKbNmG7RXYcD9h5Hg1FxvtBB5sI9Pf
	 ZgqdvFKQEqxIfcu8uqJ9glVpnO5zI6OIKJ8PXrQOv7JZ9fZZldSbSCtwsEEJ5WmOQS
	 lXHo1IIKtUzmEccWZebnu0x3l8H8YybCKFGSXzVUSdavrBy9+xQHgU6NB935RcOlvk
	 PMbvrvnYCRvzqh0uv9HfG/A5deLne5vFE9sl+wR1gOWkYFSbHyMCwOif2MvpDtSdn2
	 WfMxOjIZuviUw==
Message-ID: <bc0abb00-73bf-42ae-ab86-26174f5c6c84@kernel.org>
Date: Wed, 6 Dec 2023 09:52:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 14/18] mlx5: implement VLAN tag XDP hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
 <20231205210847.28460-15-larysa.zaremba@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231205210847.28460-15-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/5/23 22:08, Larysa Zaremba wrote:
> Implement the newly added .xmo_rx_vlan_tag() hint function.
> 
> Reviewed-by: Tariq Toukan<tariqt@nvidia.com>
> Signed-off-by: Larysa Zaremba<larysa.zaremba@intel.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 15 +++++++++++++++
>   include/linux/mlx5/device.h                      |  2 +-
>   2 files changed, 16 insertions(+), 1 deletion(-)

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

