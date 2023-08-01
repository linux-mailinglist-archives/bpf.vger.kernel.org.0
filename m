Return-Path: <bpf+bounces-6630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9F76BFB5
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 23:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6785E1C21070
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C40275B0;
	Tue,  1 Aug 2023 21:57:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16220F9A;
	Tue,  1 Aug 2023 21:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21991C433C8;
	Tue,  1 Aug 2023 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927044;
	bh=1zkqubEp693ty9VDXEnLFMNBXktoPzOqeY6em4mcsBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mSJmmFwTIK1f3qjDv2+Be05QntUSJk3XdeJZV0zBsLuNLIECiDpRKr7K5o1y7Xa1M
	 dBWUQAa7dpGZ461KXdxHBBMyfRq20Hzwl8koKlYxZnazkorzpDP5RGhXOlHNkaMki7
	 yujhhJupHhv38SRstlQ0L7adI0sp6DPnvWPk2hqlScYcW276A/wOv2F6DfW8EAYUBH
	 fIkp6xDwBFCZ9u1deCxGl5txyHchxyuTQUaCgnPRVoxG3jaWGqwij/51NMIYjVK2GG
	 o7CfvTKVSbR3nHzEGADMzx9H2QIN9CLFgmcVNEI/OvLfJo8IUr04MSFWrBr8Ijh8a/
	 8m/NSlh8Lw3ww==
Date: Tue, 1 Aug 2023 14:57:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230801145723.7ddc2dba@kernel.org>
In-Reply-To: <20230731060025.3117343-1-wei.fang@nxp.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 14:00:25 +0800 Wei Fang wrote:
>  	case XDP_TX:
> +		err = fec_enet_xdp_tx_xmit(fep->netdev, xdp);
> +		if (err) {
> +			ret = FEC_ENET_XDP_CONSUMED;
> +			page = virt_to_head_page(xdp->data);
> +			page_pool_put_page(rxq->page_pool, page, sync, true);

The error path should call trace_xdp_exception().
-- 
pw-bot: cr

