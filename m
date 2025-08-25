Return-Path: <bpf+bounces-66470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C2B34F1E
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C214871E5
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88729BD83;
	Mon, 25 Aug 2025 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSu8CIsP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217A2DF68;
	Mon, 25 Aug 2025 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161564; cv=none; b=XDNd0iCrnlNn6VOs5wqobtok3vfIgPfuFdkQ7sZjvxjRKMCiF0uptyl+wtMdj17xKuUDXp/+4qUiIQtTUpgivb6bMMMGMDQj9dO2AxZ3bXWTRjZ1zEgteu8Y0gOOIi1ZHdFgPsOfD/tcKde707DSR+5dGBVxoBxwCJGgSRBzols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161564; c=relaxed/simple;
	bh=w0bh5d8ur4+Vy5aki54Tx8HWsofvlXOLwGcif9mbEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiPX3iFbCvbFmORk2Qh6l8vtwtQ87vJPEouVxH8FmlSjI7a/E2AYVZGkyw/69eZUUvGXjjE2B49CbiMiVzQW+6jv0V2Re5LCT/w15CCZ82hjKBhECkaMw/S++X6WfqCMuqLdSF2edjN+9Iyr9Sw68BQqz0+AoPx5KaIf1ldOPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSu8CIsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA424C4CEED;
	Mon, 25 Aug 2025 22:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756161564;
	bh=w0bh5d8ur4+Vy5aki54Tx8HWsofvlXOLwGcif9mbEEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qSu8CIsPD0fXfA62oY80LM9Zp6YCgQ+ch7EYx9yMHy4XRwl70ZcPz8VR9fsOIefWD
	 3926slpT14EMas8hVLnBD32Z7tFnO61JGc2BW/NLPDSdnZz/hHZPTPE7G/IQzEibPR
	 rdfdXtmF6Q2HhOS3EFyUXoZPuyE0s927A4YMsdLeZbXFOecEj8MTTzhBrRP08VuWTl
	 B537XYz6UMD9vNPdBm9Hs4MKgZ5jHzB1/oLKJRPFwAkeaCEhem90c8xxUFONRNLl6G
	 G7z36B7y09JsV0SYMdiijGMfNcyrtQwkFCebMU5Q+AwaAkVjH3+JPRtEIUrR8aUjIu
	 Taif7SQCrvH2w==
Date: Mon, 25 Aug 2025 15:39:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com,
 kernel-team@meta.com
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Message-ID: <20250825153923.0d98c69d@kernel.org>
In-Reply-To: <20250825193918.3445531-4-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
	<20250825193918.3445531-4-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 12:39:14 -0700 Amery Hung wrote:
> +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags)
> +{
> +	struct xdp_buff *xdp = (struct xdp_buff *)x;
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	void *data_end, *data_hard_end = xdp_data_hard_end(xdp);
> +	int i, delta, buff_len, n_frags_free = 0, len_free = 0;
> +
> +	buff_len = xdp_get_buff_len(xdp);
> +
> +	if (unlikely(len > buff_len))
> +		return -EINVAL;
> +
> +	if (!len)
> +		len = xdp_get_buff_len(xdp);
> +
> +	data_end = xdp->data + len;
> +	delta = data_end - xdp->data_end;
> +
> +	if (delta <= 0)
> +		return 0;
> +
> +	if (unlikely(data_end > data_hard_end))
> +		return -EINVAL;

Is this safe against pointers wrapping on 32b systems?

Maybe it's better to do:

	 if (unlikely(data_hard_end - xdp->data_end < delta))

?

> +	for (i = 0; i < sinfo->nr_frags && delta; i++) {
> +		skb_frag_t *frag = &sinfo->frags[i];
> +		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
> +
> +		memcpy(xdp->data_end + len_free, skb_frag_address(frag), shrink);
> +
> +		len_free += shrink;
> +		delta -= shrink;
> +		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
> +			n_frags_free++;

possibly

		else
			break;

and then you don't have to check delta in the for loop condition?

> +	}
> +
> +	for (i = 0; i < sinfo->nr_frags - n_frags_free; i++) {
> +		memcpy(&sinfo->frags[i], &sinfo->frags[i + n_frags_free],
> +		       sizeof(skb_frag_t));

This feels like it'd really want to be a memmove(), no?

> +	}
> +
> +	sinfo->nr_frags -= n_frags_free;
> +	sinfo->xdp_frags_size -= len_free;
> +	xdp->data_end = data_end;
> +
> +	if (unlikely(!sinfo->nr_frags))
> +		xdp_buff_clear_frags_flag(xdp);
> +
> +	return 0;
> +}

