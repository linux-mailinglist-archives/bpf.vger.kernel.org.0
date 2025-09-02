Return-Path: <bpf+bounces-67201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE9B40A5C
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA235E3F98
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06FC2F3602;
	Tue,  2 Sep 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctGbvLP9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651FC1D432D;
	Tue,  2 Sep 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829757; cv=none; b=IYmds/uAWGUbsEgiuFyLMKme5kjqDG2MXRQIvXKaAf9qukpCoBmguD9BLDKJoqrGKWCFYcIehM5nXAl88H7AqrLmHUNptE9laTTOuYIUdGQ2g2e1yLrMu+3SwKZkOdGMfZCZghq33t9lCyOT9K4oPkXpyGiWt4t/1WKUUank574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829757; c=relaxed/simple;
	bh=/lr/agGyTaU3dozEPsQsbMHTjO/nnKIxlQrS46fsdI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkmhRjh0d6HKT7i21F9tkPbGWbf9CH7MEzNNz+8W9EKCJqhB2vBx/ljADYEnUsuCTUf4NBi8w3LpDLkvdR2h7ZxGCXnKrE/Q9Hb5R0/yRsSvwFdTrMH2eihMOyHNsvntJ06IO9NYovbkhUiuihjDlU/+fMSNcBLXsoZyIZJ6h9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctGbvLP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C363FC4CEED;
	Tue,  2 Sep 2025 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756829756;
	bh=/lr/agGyTaU3dozEPsQsbMHTjO/nnKIxlQrS46fsdI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctGbvLP9T1cohg9SSLGcdfNKlZfAhFk0/JXWuPub4Hmp8K7IQdFzZdHBOevgCPRhT
	 2DUocehSAVF32wRz6IUt+iZm3GIzv3h6bBqKrqShgzQ/a0K1aiKKjeLGxfSlw/O+fZ
	 3QZAfxvAgxsWeqfZNDF16wJEyXF1nCPv5ZNVLqDWScmr0N4fAE2MHFTcqBQGUEKX35
	 ob6QcxZQLC2nsoLGbctacW/IKeLhMtInAjxR8J90QyiNbKpVGDfZWrXIv6PAdE/1qO
	 T42adSVB9NUSth0vuSdm/TvBNUhyE+3cWyPrQ7OfaP/hPIVhLUsuT8g1Y8LO/nXcHg
	 HIUvaPJ7Vk47w==
Date: Tue, 2 Sep 2025 09:15:55 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Christoph Paasch <cpaasch@openai.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
Message-ID: <aLcYO4kWn1nMnEJp@x130>
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <aLIs_-lDKHCLTrTy@x130>
 <e0786dbc-4681-4bee-a54a-e58c1b9b7557@gmail.com>
 <CADg4-L8+c+kHHzJhEaxKoNowbONqfMPVuqyOw7_DqhKFqzzLFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg4-L8+c+kHHzJhEaxKoNowbONqfMPVuqyOw7_DqhKFqzzLFw@mail.gmail.com>

On 02 Sep 08:51, Christoph Paasch wrote:
>Hello Tariq,
>
>On Sun, Aug 31, 2025 at 2:28 AM Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>>
>>
>>
>> On 30/08/2025 1:43, Saeed Mahameed wrote:
>> > On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
>> >> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
>> >> copies parts of the payload to the linear part of the skb.
>> >>
>> >> This triggers suboptimal processing in GRO, causing slow throughput,...
>> >>
>> >> This patch series addresses this by using eth_get_headlen to compute the
>> >> size of the protocol headers and only copy those bits. This results in
>> >> a significant throughput improvement (detailled results in the specific
>> >> patch).
>> >>
>> >> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
>> >
>> > LGTM, I would love to take this to net-next-mlx5 and submit it back to
>> > netdev after regression testing if that's ok? Christoph? Anyway I will
>> > wait for Jakub to mark this as "awaiting-upstream" or if he
>> > applies it directly then fine.
>> >
>> >
>> >
>>
>> Hi,
>>
>> I recall trying out similar approach internally a few years ago.
>>
>> eth_get_headlen() function didn't work properly for non-Eth frames
>> (ipoib). I believe this is still the case.
>>
>> Extra care is needed for the ipoib flow, which I assume gets broken here.
>
>Are you actually sure that ipoib goes through
>mlx5e_skb_from_cqe_mpwrq_nonlinear() ? Because, as far as I can see,
>IPoIB disables striding in mlx5i_build_nic_params().
>
>It's rather mlx5e_skb_from_cqe_nonlinear() that handles both, ethernet
>and ipoib.
>
correct,

const struct mlx5e_rx_handlers mlx5i_rx_handlers = {
	.handle_rx_cqe       = mlx5i_handle_rx_cqe,
	.handle_rx_cqe_mpwqe = NULL, /* Not supported */
};

I see that the patches are "awaiting-upstream" so I applied it to our internal
queue, will let you know if we find any issues, otherwise, will repost as
part of our upcoming submissions.

Thanks,
Saeed.



