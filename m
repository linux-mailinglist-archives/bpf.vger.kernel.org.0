Return-Path: <bpf+bounces-20157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3B839E6E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 02:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970841F2A2F4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 01:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F140C17CD;
	Wed, 24 Jan 2024 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5uHJrNT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599E15A8;
	Wed, 24 Jan 2024 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061199; cv=none; b=lv59mDnjFSVZsk7K6LuyanhV2a91/ojA+KkYDl4sD5E49RMhxRWFR4FTWdOaAzQfibxzbm72ESMUuMSqbYeCYJV3BNhtfLbCXnFcuS31hGjG3VGT2wjq2jUNhPM63ViYrJTWP0xVeMuYJZ5wU2GRQL2erPTB1Nq8o+0no4dgeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061199; c=relaxed/simple;
	bh=j7t27oDh4HaoBk4FY5/kZ5s13IHwgzwGRrYuqruPWvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W63Y8tJKDa1nZjDTEl1kd2KERPA8lT0/gA1RjgdbvEx6HrLjNg3jAIsGok4HaDP5cYgbFihxJLtGpZGIbGKWxN2qqUM071PPp4mpbA3Bcl8Kcl3cWxKN8Jh8R3oAjEUHGHqwdg+NEaYs3CGRcnTAvqEhuq0S86lxDyhfYNRfW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5uHJrNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6449BC433F1;
	Wed, 24 Jan 2024 01:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706061199;
	bh=j7t27oDh4HaoBk4FY5/kZ5s13IHwgzwGRrYuqruPWvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B5uHJrNTvjF5HvVIugTHGBxI9nLqYC/rqpC9F5gZFUgGvPgGbEgEYUAOPS7gAxvcN
	 3BymLIhn7JRSGm7BOgxMcMvbZUHSvJojMvPxTRXZIUutj/OhY84/e2W7TVAkZaWDLK
	 4vtGnEPk9ItHuXdYMcgpU3nmFzJBfUxEdZrma5EzV3x3fKekUegd8YNh3QDnCyxgvJ
	 hn/iv9uNYsO6byDoho3gUCrqiIUbx/jAFlD/sdAUGrlYrBsal2Ft9TjvAJYuPAZuVk
	 UiL8HJ5ga0q+eNk5SbaMhveZrcGjRiCGhlnkZpFxPJ7uWm99uUxeB+OhZEXhH4yJrd
	 xrj7N9OMhsFAg==
Date: Tue, 23 Jan 2024 17:53:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org,
 martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com,
 horms@kernel.org
Subject: Re: [PATCH v5 bpf 03/11] xsk: fix usage of multi-buffer BPF helpers
 for ZC XDP
Message-ID: <20240123175317.730c2e21@kernel.org>
In-Reply-To: <20240122221610.556746-4-maciej.fijalkowski@intel.com>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
	<20240122221610.556746-4-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 23:16:02 +0100 Maciej Fijalkowski wrote:
>  
> +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> +			  skb_frag_t *frag, int shrink)
> +{
> +	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL)
> +		xsk_buff_get_tail(xdp)->data_end -= shrink;
> +	skb_frag_size_sub(frag, shrink);

nit: this has just one caller, why not inline these 3 lines?

> +}
> +
> +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)

nit: prefix the function name, please

> +{
> +	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> +
> +	if (skb_frag_size(frag) == shrink) {
> +		struct page *page = skb_frag_page(frag);
> +		struct xdp_buff *zc_frag = NULL;
> +
> +		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> +			zc_frag = xsk_buff_get_tail(xdp);
> +
> +			xsk_buff_del_tail(zc_frag);
> +		}
> +
> +		__xdp_return(page_address(page), mem_info, false, zc_frag);
> +		return true;
> +	}
> +	__shrink_data(xdp, mem_info, frag, shrink);
> +	return false;

