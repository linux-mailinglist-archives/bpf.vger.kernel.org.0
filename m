Return-Path: <bpf+bounces-48414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA8A07D1B
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6991188D223
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704D221D86;
	Thu,  9 Jan 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOVP5l4W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680121A45C;
	Thu,  9 Jan 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439246; cv=none; b=BuZFOl172lQA6/FtNZtNrDE+ek/RjCHj7FOvFvmZWEmmFrXWwWV2wGnxu+gvp2OiL51euhMybNsoaTJjxCCDF+u/sp1a5632M5gNfogdBZx89UrvAqW7VcWHQ9Rr2WjN+zJME2qjUVr+1mXrHYVJGTFksTzABsCrj/GFbJ/XgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439246; c=relaxed/simple;
	bh=8AW2JBM9p7hPaetzgChckRCvgTEi/URlyTvd+dPc5Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr51wbBVOusnWfxPyycXJ4u6U4gYVZ3StA2rkKn/HOI+3icK4yjYXQwfbe8ncS7qZm5LwF51PL1FpiaMjC/gKEbt3i13EAP4f7/Q7EJlTTJSdTn9QOC0fMd9lxvITY+LclVg8nYZ8BvhXORR+sBcGVLEhc+pP/J1Pd3R9srnXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOVP5l4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E485C4CED2;
	Thu,  9 Jan 2025 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439246;
	bh=8AW2JBM9p7hPaetzgChckRCvgTEi/URlyTvd+dPc5Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOVP5l4WvoKrafD6oNo3GwJl8ddzDNF9T6fRhcd0mLjzdQHHpBZnJqMfF889IghkU
	 AnC/CmkjhcvaCDMbfZA8XKXMMpiqUQyqZlGFW3Fx49HbKYxHRSwSumheUU38S97VsB
	 L75dsEyNWNDBcza+d6uaKBi224ICHGqLRmzXdop6rsmrDOFmXISjwxhoBXhBc4gFQD
	 mOD2SveLpRZpvScTZhq5X86mTk18quIHKgxZ0WM0YYmONab213oiMlviyyzw5lmNBT
	 Gqyeixeo0eupnXjcKaHWez4P5KNCmwLMLNJrNr+FWmLgAL7zl9ZzTWQ0OebKynMi9z
	 VPMdCPFOsXmhA==
Date: Thu, 9 Jan 2025 16:14:00 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/6] octeontx2-pf: Add AF_XDP zero copy
 support for rx side
Message-ID: <20250109161400.GK7706@kernel.org>
References: <20250108183329.2207738-1-sumang@marvell.com>
 <20250108183329.2207738-4-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108183329.2207738-4-sumang@marvell.com>

On Thu, Jan 09, 2025 at 12:03:26AM +0530, Suman Ghosh wrote:
> This patch adds support to AF_XDP zero copy for CN10K.
> This patch specifically adds receive side support. In this approach once
> a xdp program with zero copy support on a specific rx queue is enabled,
> then that receive quse is disabled/detached from the existing kernel
> queue and re-assigned to the umem memory.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

...

> @@ -572,20 +575,31 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
>  		if (pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED)
>  			otx2_adjust_adaptive_coalese(pfvf, cq_poll);
>  
> +		if (likely(cq))
> +			pool = &pfvf->qset.pool[cq->cq_idx];
> +

Hi Suman,

FWIIW, Smatch is still concerned that cq may be used uninitialised here.

...

> @@ -1429,13 +1447,24 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  	unsigned char *hard_start;
>  	struct otx2_pool *pool;
>  	int qidx = cq->cq_idx;
> -	struct xdp_buff xdp;
> +	struct xdp_buff xdp, *xsk_buff = NULL;
>  	struct page *page;
>  	u64 iova, pa;
>  	u32 act;
>  	int err;

Please consider preserving reverse xmas tree order - longest line to
shortest - for local variable declarations.

...

