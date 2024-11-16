Return-Path: <bpf+bounces-45005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B344C9CFC60
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 03:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A43B27C21
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 02:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9BC23C9;
	Sat, 16 Nov 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND8xm/n7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40982A1BF;
	Sat, 16 Nov 2024 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731724862; cv=none; b=kHTnwVYFzlbNWl4zPGqMi5dFfuz+ySjGJ4Bu57qkmQFJUkiNpwl3MiBxF8Qgn9LpWI++NhcDZlGbgaKfsGZL94CeAGUIU5NQky8789SdZMFLvyEsEVg/E/vM5A80C11XRFqaA80VhJXH38IgNvrTXAwf0DQGRxktY32Nc1tC8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731724862; c=relaxed/simple;
	bh=QzEHm+NBAWswWMxRYSx9ZLwy0c7HR2Yt/M1ynYrRliw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5h1uqFNF2398XZshxcU69/V+mepAI2JZ5xrszQOaxAspW8woJ7QBEqXclbQQxZ2RIbK9XLBDUreKqIC9i31VA+AmaVNH8eRd4+0jGG460wNxWreJFmmeJNI7sd/fRH4+UGCchTFGyX8o93YSQXinwxsyPEAPg/zKDVsWixpuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND8xm/n7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87381C4CECF;
	Sat, 16 Nov 2024 02:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731724861;
	bh=QzEHm+NBAWswWMxRYSx9ZLwy0c7HR2Yt/M1ynYrRliw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ND8xm/n7S2+0ZAGq4sFr07MqYAhobzXnr5eI23h0NhDtEOwQR/ckxTR21T6xB3TOj
	 sTzHawDMHwGn3yva8JL6jxOPvHHtKyztscn+p/iNzO8VM7fIxQ6EgZgiRi68JSc6jX
	 2J5OEXK58oACR2WltOp8u6AL5mYUBevftFr0avh2uPubuG6WpfIzNb0jSoOnYD8kb4
	 qbTjto4PpAo0o8vd0wUAbmVQYrKg/u12yK53kDQ7I0sBDcMxvSxktFckSSO+CQ7E5a
	 7jVWZGB4pxirv75KR9DmVttbAsvuXxz9a2HhduhqXf+rSBk2qtG+cGTYtMjyZa8VSi
	 MIas3fLw4CLbQ==
Date: Fri, 15 Nov 2024 18:40:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/19] xdp: add generic xdp_buff_add_frag()
Message-ID: <20241115184059.3b369970@kernel.org>
In-Reply-To: <20241113152442.4000468-12-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
	<20241113152442.4000468-12-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 16:24:34 +0100 Alexander Lobakin wrote:
> +static inline bool __xdp_buff_add_frag(struct xdp_buff *xdp, struct page *page,
> +				       u32 offset, u32 size, u32 truesize,
> +				       bool try_coalesce)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	skb_frag_t *prev;
> +	u32 nr_frags;
> +
> +	if (!xdp_buff_has_frags(xdp)) {
> +		xdp_buff_set_frags_flag(xdp);
> +
> +		nr_frags = 0;
> +		sinfo->xdp_frags_size = 0;
> +		sinfo->xdp_frags_truesize = 0;
> +
> +		goto fill;
> +	}
> +
> +	nr_frags = sinfo->nr_frags;
> +	if (unlikely(nr_frags == MAX_SKB_FRAGS))
> +		return false;
> +
> +	prev = &sinfo->frags[nr_frags - 1];
> +	if (try_coalesce && page == skb_frag_page(prev) &&
> +	    offset == skb_frag_off(prev) + skb_frag_size(prev))
> +		skb_frag_size_add(prev, size);

don't we have to release the reference if we coalesced?

> +	else
> +fill:
> +		__skb_fill_page_desc_noacc(sinfo, nr_frags++, page,
> +					   offset, size);
> +
> +	sinfo->nr_frags = nr_frags;
> +	sinfo->xdp_frags_size += size;
> +	sinfo->xdp_frags_truesize += truesize;
> +
> +	return true;
> +}


