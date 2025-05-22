Return-Path: <bpf+bounces-58795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE757AC18B2
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C8DA40CB0
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21642D29BD;
	Thu, 22 May 2025 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTScGvLH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5E2D193F;
	Thu, 22 May 2025 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958161; cv=none; b=Dge+3klGPEoJZP30GwoXac05Br/ZDLsVZZ2v3ec064fnWggxwUxmxo7Fcz0/ouuD66V4yOWPkUz4gPIosP3O12Zva1Ji/aIYr85jTRI/AjYtXm2MdLKNoQ5fsm7flCZHdImYL3/YKG8ZUOVhe2pLVteok1wB6/ppc4TSIASWS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958161; c=relaxed/simple;
	bh=ozytARQcufzrpU7657itUpFox9gMEymZtSzu+J03I1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhOiVsipwKoPuiNKaZyAckyBrJ/jsKvAqBy4stofXR/IfLLMSxSRuXCEdbtHrtYCO6V8e4a2bT/xCao6eMBxyF/tMJuDZMID0Sz3Q8GebV7OQau/n8ni6EEnEAcE6KT8UyBgCFnjRSawcUSQ/+PfnrUcWXvntN/mI7GmiES5+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTScGvLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C199CC4CEE4;
	Thu, 22 May 2025 23:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747958160;
	bh=ozytARQcufzrpU7657itUpFox9gMEymZtSzu+J03I1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTScGvLHm2Rdx5RsFheTYFr3gJNGAk0xrQVP4vWGLRGSSXgi8m6/Hi8OBZB/4mTue
	 ZqRo34mDGMpxyTQT1jqFes7Y20LxkICnKGDvCcac0a9xxSSLQFXeiVDU6eoThHVnHc
	 yehWCORvqpZNABDlLYvqIPH9Ey0aoy2qxNF01e9VhQrSQtGSzQlGq1Del/+IKoFXio
	 1z3h611OfeZSQil67wDADLjmIiIH7hgn9UKLoBA8BLiUrbTq9xj/PBa4YUD6/gDina
	 gcGpV7mDT5rO41ef7xdMbFDtWGvWYULtKl78RtHr3SM0DqfGGixM0LWLveJ8TwftTk
	 Jl3YGJhdOl2GQ==
Date: Thu, 22 May 2025 16:56:00 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: ""@x130.smtp.subspace.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 09/11] net/mlx5e: Add support for UNREADABLE
 netmem page pools
Message-ID: <aC-5kAFay2JMlz82@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-10-git-send-email-tariqt@nvidia.com>
 <CAHS8izOwPVSKQJBSOjmtfXfA6ZBHVqvWRV=WSYM41XXninsSSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOwPVSKQJBSOjmtfXfA6ZBHVqvWRV=WSYM41XXninsSSw@mail.gmail.com>

On 22 May 16:26, Mina Almasry wrote:
>On Thu, May 22, 2025 at 2:46 PM Tariq Toukan <tariqt@nvidia.com> wrote:
>>
>> From: Saeed Mahameed <saeedm@nvidia.com>
>>
>> On netdev_rx_queue_restart, a special type of page pool maybe expected.
>>
>> In this patch declare support for UNREADABLE netmem iov pages in the
>> pool params only when header data split shampo RQ mode is enabled, also
>> set the queue index in the page pool params struct.
>>
>> Shampo mode requirement: Without header split rx needs to peek at the data,
>> we can't do UNREADABLE_NETMEM.
>>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 9e2975782a82..485b1515ace5 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -952,6 +952,11 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
>>                 pp_params.netdev    = rq->netdev;
>>                 pp_params.dma_dir   = rq->buff.map_dir;
>>                 pp_params.max_len   = PAGE_SIZE;
>> +               pp_params.queue_idx = rq->ix;
>> +
>> +               /* Shampo header data split allow for unreadable netmem */
>> +               if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
>> +                       pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>>
>
>This patch itself looks good to me for FWIW, but unreadable netmem
>will return netmem_address(netmem) == NULL, which from an initial look
>didn't seem like you were handling in the previous patches. Not sure
>if oversight or you are sure you're not going to have unreadable
>netmem in these code paths for some reason.

I think I explained in my other reply to the other comment, we only need to
check in one location (HW_GRO payload handling).. other paths can not
support iov netmem so we are good.

