Return-Path: <bpf+bounces-6734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE6376D5E6
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3775F281DF3
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63CC100CD;
	Wed,  2 Aug 2023 17:47:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01ADF58;
	Wed,  2 Aug 2023 17:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50900C433C7;
	Wed,  2 Aug 2023 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690998428;
	bh=sE6AgUQ0F8B532TRUZLvOvqkjOvFLzeZinak6Pnz2BQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cj3wlW0o4CuBFv2vgVAJKJx0C5RTeD92PotxBduWEsCb2JeCdBxIzPOE0e1kGDABR
	 Ruu2Id3g5aUv4LzY8w+SmaQp4ti4eZ/ETrNKOCg7RsDsAJ+oyoeMMyvQCULrCJDoMn
	 UrZVHWJYRpLHmmNuAhI3BK70A8+dvC1m5LdMTd0wCuunpNqzmQ7NQ+wbMOJkErT2kA
	 tpi0F7OOB6xp8FyK5w4Gs7315AkjZ8B1oKLq1YLnSAAcEk4HBeUSsdq1RNRXo09idd
	 XztNeB9fxfB6g3w08n6s7VYnnTPL5Szu1KttO5DNUX0H0dYMNoqAH1jeYlnnR7oe19
	 qUT1O6TbWF7IQ==
Date: Wed, 2 Aug 2023 10:47:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230802104706.5ce541e9@kernel.org>
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
>  		} else {
> -			xdp_return_frame(xdpf);
> +			xdp_return_frame_rx_napi(xdpf);

If you implement Jesper's syncing suggestions, I think you can use

	page_pool_put_page(pool, page, 0, true);

for XDP_TX here to avoid the DMA sync on page recycle.

