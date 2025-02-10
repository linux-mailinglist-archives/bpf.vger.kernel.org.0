Return-Path: <bpf+bounces-51031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CADAA2F61F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62745188800C
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A118D63E;
	Mon, 10 Feb 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHL1flr0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB725B663;
	Mon, 10 Feb 2025 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210238; cv=none; b=kaDR3VG42rpLac3Gt2gleJ4UZRG9F+3xgajDyFFBk6xLClNMGNr00wzcorJl7RU+Vc+qmbGByLKiRZKVdmALtYRwQXrIn1agzi5Sqet5B6NqrCIpZoRRFONth9Jzmu5r0vn54vYjU9Xx6SgLRKy9Sb32BfuDbseuHpUQSO7dkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210238; c=relaxed/simple;
	bh=1Gw8pKhzOJPQX/wKu8IXgYD/BO0YpZULMK1Qxi3Jn6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw8mSlkZNgD6BcKKRUPaCX0Ds8Mpxy8TNPjPDDgXzpRf4EhvLhRMp1o6C82v0yJ9L/WLhizPgzNEdRgDtGyq4kTpNL38jZlYLO/pZwv+KJ97leiMh6Ee9CsEIxqBDOvbSc6FnaQqllnSVPixRJ2UvCGXN+9lkuhS5xmZCPwJOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHL1flr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C9FC4CED1;
	Mon, 10 Feb 2025 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739210238;
	bh=1Gw8pKhzOJPQX/wKu8IXgYD/BO0YpZULMK1Qxi3Jn6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHL1flr0VLVPWMFOIAM3xSz2kRgOVAA32LCdE20N4bnk8uqwU+8bzrNaWGrYaDbY6
	 CHPv5DuPD2S0GLseN5t47wfh2wbbBsztFyxwNyY49a5PmNl5guSiPOOZtz7Osqn0Kd
	 S4csx+e0Avg6Tz3nITfCGA57TDHb7eCkclgholB90zwiThR2SqLgmwIGoRJWmOb5lh
	 IDAyq8lhjxBzjLspuNXysphlxg1LU5acUd1l8F5qLUQiahgkVWmRTZgHYKvbrA31km
	 b1FThUBSUz9hO7ehNvZY5hqezTCCrSb/Vlf0kCEnrTfoMT+z5FNWVsfL23gS2TGbIV
	 Q//WbzFpzLuUQ==
Date: Mon, 10 Feb 2025 17:57:12 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, larysa.zaremba@intel.com
Subject: Re: [net-next PATCH v5 5/6] octeontx2-pf: Prepare for AF_XDP
Message-ID: <20250210175712.GK554665@kernel.org>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-6-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206085034.1978172-6-sumang@marvell.com>

On Thu, Feb 06, 2025 at 02:20:33PM +0530, Suman Ghosh wrote:
> Implement necessary APIs required for AF_XDP transmit.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 44137160bdf6..b012d8794f18 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -22,6 +22,12 @@
>  #include "cn10k.h"
>  
>  #define CQE_ADDR(CQ, idx) ((CQ)->cqe_base + ((CQ)->cqe_size * (idx)))
> +#define READ_FREE_SQE(SQ, free_sqe)						   \
> +	do {							                   \
> +		typeof(SQ) _SQ = (SQ);						   \
> +		free_sqe = (((_SQ)->cons_head - (_SQ)->head - 1 + (_SQ)->sqe_cnt)  \
> +			   & ((_SQ)->sqe_cnt - 1));                                \
> +	} while (0)

It looks like READ_FREE_SQE() could be a function rather than a macro.
And, as an aside, CQE_ADDR could be too.

>  #define PTP_PORT	        0x13F
>  /* PTPv2 header Original Timestamp starts at byte offset 34 and
>   * contains 6 byte seconds field and 4 byte nano seconds field.

...

