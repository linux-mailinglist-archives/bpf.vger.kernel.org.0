Return-Path: <bpf+bounces-72095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED7C06817
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FD018912F7
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ACE31D366;
	Fri, 24 Oct 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULoqiPtI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F360315D33;
	Fri, 24 Oct 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312608; cv=none; b=L/rRUuf3mK/jvHryBHrmp2EfPKQHwQeOxXjbrFRHcaDLSK/U//UpLwHtU4z18v6l/dD/B257zPGJajf3CsWQRUh4jhIV5geZ5UalaQLbLQ1FO/Risq2I4iIvPotvMYKp2WBUiz84+tL59VHn6ihsxZUFvhIu9eyb3Lr1kWOzfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312608; c=relaxed/simple;
	bh=FZMqJ8vLerAohSPBj3F9Rf1fou27rkcO54jPIHUN1JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJEGo3XKFLDe9T0Quvl9y1PnmRjPvLd4DPRgTpXvRd6bJJQmn1C+fB3b0x8pbaSnWpRkMFsEN02/YnpNABaelv4LhcS4UUbIx+OoHk/hX4Vwytk3jxZagPrgDlwJ3UaEuU+QvNEjL3mnUUYq/SW6FvMrTqYzYat2HQ2rdun6wJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULoqiPtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1FC4CEF1;
	Fri, 24 Oct 2025 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312606;
	bh=FZMqJ8vLerAohSPBj3F9Rf1fou27rkcO54jPIHUN1JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULoqiPtI/5Z6J+3rgCRlGkfDtb07dy8maI8bEKRPq6TJKWlCoT3aB6GkAyFSRizol
	 px88/i9HAOA56byTVLyYh82H8ZrClfm8CjLjetikyNlHOe0cYjFZIqKIk5VxcGZEFm
	 /vpgYR8kq9Mi4c3Rs45W4azUHK70qLbvIx9n/nhvDi6WU/G/qv4cfheWY51a+ILysJ
	 UI3MWuAbpA6SHieklXk9NvpxwYCZt2VgUJxcofuhC9NP9LNuBDhUimyuNIVicSpf58
	 PPNYzH0SI8ZfTm0By9+rLne0bgrfHGNQpU1IiNtZjVadAppfCR9OBfKFyD+PagG5Gv
	 9Kixm6jYK2C6g==
Date: Fri, 24 Oct 2025 14:30:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 1/9] xsk: introduce XDP_GENERIC_XMIT_BATCH
 setsockopt
Message-ID: <aPt_WLQXPDOcmd1M@horms.kernel.org>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021131209.41491-2-kerneljasonxing@gmail.com>

On Tue, Oct 21, 2025 at 09:12:01PM +0800, Jason Xing wrote:

...

> index 7b0c68a70888..ace91800c447 100644

...

> @@ -1544,6 +1546,55 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  		WRITE_ONCE(xs->max_tx_budget, budget);
>  		return 0;
>  	}
> +	case XDP_GENERIC_XMIT_BATCH:
> +	{
> +		struct xsk_buff_pool *pool = xs->pool;
> +		struct xsk_batch *batch = &xs->batch;
> +		struct xdp_desc *descs;
> +		struct sk_buff **skbs;
> +		unsigned int size;
> +		int ret = 0;
> +
> +		if (optlen != sizeof(size))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&size, optval, sizeof(size)))
> +			return -EFAULT;
> +		if (size == batch->generic_xmit_batch)
> +			return 0;
> +		if (size > xs->max_tx_budget || !pool)
> +			return -EACCES;
> +
> +		mutex_lock(&xs->mutex);
> +		if (!size) {
> +			kfree(batch->skb_cache);
> +			kvfree(batch->desc_cache);
> +			batch->generic_xmit_batch = 0;
> +			goto out;
> +		}
> +
> +		skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
> +		if (!skbs) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
> +		if (!descs) {
> +			kfree(skbs);
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		if (batch->skb_cache)
> +			kfree(batch->skb_cache);
> +		if (batch->desc_cache)
> +			kvfree(batch->desc_cache);

Hi Jason,

nit: kfree and kvfree are no-ops when passed NULL,
     so the conditions above seem unnecessary.

> +
> +		batch->skb_cache = skbs;
> +		batch->desc_cache = descs;
> +		batch->generic_xmit_batch = size;
> +out:
> +		mutex_unlock(&xs->mutex);
> +		return ret;
> +	}
>  	default:
>  		break;
>  	}

...

