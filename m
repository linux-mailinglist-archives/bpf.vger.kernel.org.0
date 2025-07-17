Return-Path: <bpf+bounces-63598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A0B08C8F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDF01A61CB6
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF529E0F5;
	Thu, 17 Jul 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YqFTEXi9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19D29DB78
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754288; cv=none; b=AfHTNonixedWbRQj/hfH5nu7WtxaGgZ6bMvIMTcyrfocrRR0BRfjjGnMukZFjzdwPLsBzzHbhmVt/As+efxTL2vvn6XsEVZz6BverYZkLvxrlj3C4GF8f+6gXWz+PPw1yIQQo3NhRAKtZzOycZbarSf/Xz8Ikjd+fjjXNfAdMlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754288; c=relaxed/simple;
	bh=P8vk5Hgw1tgxUgUlGpEEfcEnINzDHJTtnJgc36ojQPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jw08QcmpUHQXkIBSloakRmwhmfDyJjDMTicwNPaDhSD6/Uv+kIMY1l4YA/dH8MUYgCnSX3W1gYwztqbKBGQIH5vE7HSq7DuJCIUutBmvqkOcpVooX+mpd8dQZKxZwDXMhvWv1XKJiiZcIbpcZkldWrlSlINpPL6kIT+lAO3NulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YqFTEXi9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo1430703a12.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752754285; x=1753359085; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+OKtnDxQN1rQvgUExQEfgNocGu+aFrd+PlVCR98yHgE=;
        b=YqFTEXi9NAioggDzwMmOxhXF0esWRaJQp+X1D+N2LPEXYvu9GqKzZk7bUEvUCTtOod
         ynH8hRlTzFZYjizI6fW3wwHrAKfG97UpbSiPMF0PeqNbh/pt755++LAEs7UnaaQg19eM
         NoJpZzfLWmogNw00UlOUSxf2U+Je1zkF45GBnQo1axme5ZD9e8y7QdErJRhQf9uv0Pmj
         KWLR8BDtueSEv5lGDy0pfnV7ftkg2Ej9jIFifIUKo+dDjXTEs1JjAmqTp2F93B5xDOpQ
         eOLr1wDZn8s1SwnYiYviJsEd+697LnDBCa1Yb1uXncQxGyu3bEp50AGlkRe48ztysmZ3
         3T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752754285; x=1753359085;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OKtnDxQN1rQvgUExQEfgNocGu+aFrd+PlVCR98yHgE=;
        b=VEYnPevgMCPMKFwnMX0/fzrgJj9mgpISdG8udnKHGyucog/UYHAicD8K2dPGkkjesi
         WKz6jC//2KY4eFfevCeW05zH/K8iSLIGV9mLO7KXllLWwFlSqWhfDTq4n7EwKnbePdm/
         1aC91kBFO8ZhtiaXxeaoTJbh8ou0aioQfO5ytQ+igd27COzCGua5sqLU4o5FvElioWrU
         2v/QlCun+gUBGfhCcmgc+xrQAaDHIp2tynyyeegtiKrH/6SVAzMXXANMQRkrLYKiCIuT
         S5FNQGriJT/mrJ8j8AKPJ3le0JY3o0Wce3ljRpxCWwAJv1+jeIpGBG/MDhZjkqq8Yt6C
         PsLw==
X-Gm-Message-State: AOJu0YzSEQDu8wvQ9lXeniinI+2LVCjiPojnniQupchbMW+ze7UOGiV8
	VSKK8IuS7RpymTKp6owti5Uc89S5yAmr3zmuaKL8TqSwnsVYYUu0GN48w25o+P8fUNU=
X-Gm-Gg: ASbGncsFz7XeQHQFC+D/NmDQUppuksdGVxC636Pe/5nHwa6te43DgV1wfiVmpp5CnW6
	G/C7NrlzHBH2lV7EN0k9O2l+RAtyplJdg85Gop1jvieM7P0YVcDenNoLnBIDQwwT+vPLg0+NVs5
	XQ9gYyZWLM2cSoZCInUdKmAio5YsT6O2BPUhaTD2PlXmeFHN4YZLsisvXydIF4VNQheLCCk6TCE
	8vdbrVFCaGsKof0JRRS5HGnMNYhKdih7cbngjRyBpob/z2GMJ9nv1xnvMFtXoqJmCy1WQHKdTTj
	4PgZephoiQxnxhWM9jfSRzOjRdx7j6HRZRroZfS45avk8tAQpYDGnyrzdr2HC9UUroaGL5gpsnu
	sHnUYvRvXHYSkhoY=
X-Google-Smtp-Source: AGHT+IEQBx5AReVAmevU1wjvhgFcUY3uymJWzKp1I9F2AG1oQKieVEeU4QVXRXuh/1fjL6QehswnJA==
X-Received: by 2002:a17:907:b1a:b0:ae3:cc60:8cf0 with SMTP id a640c23a62f3a-ae9ce0b938cmr429270066b.34.1752754284873;
        Thu, 17 Jul 2025 05:11:24 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee48f6sm1372348366b.55.2025.07.17.05.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:11:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,  Jakub Kicinski
 <kuba@kernel.org>,  lorenzo@kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <borkmann@iogearbox.net>,  Eric Dumazet
 <eric.dumazet@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  sdf@fomichev.me,  kernel-team@cloudflare.com,
  arthur@arthurfabre.com
Subject: Re: [PATCH bpf-next V2 5/7] net: veth: Read xdp metadata from
 rx_meta struct if available
In-Reply-To: <175146832628.1421237.12409230319726025813.stgit@firesoul>
	(Jesper Dangaard Brouer's message of "Wed, 02 Jul 2025 16:58:46
	+0200")
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
	<175146832628.1421237.12409230319726025813.stgit@firesoul>
Date: Thu, 17 Jul 2025 14:11:21 +0200
Message-ID: <87a553dnkm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 02, 2025 at 04:58 PM +02, Jesper Dangaard Brouer wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Report xdp_rx_meta info if available in xdp_buff struct in
> xdp_metadata_ops callbacks for veth driver
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/veth.c |   12 +++++++++++
>  include/net/xdp.h  |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)

[...]

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 3d1a9711fe82..2b495feedfb0 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -158,6 +158,23 @@ static __always_inline bool xdp_buff_has_valid_meta_area(struct xdp_buff *xdp)
>  	return !!(xdp->flags & XDP_FLAGS_META_AREA);
>  }
>  
> +static __always_inline bool
> +xdp_buff_has_rx_meta_hash(const struct xdp_buff *xdp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_META_RX_HASH);
> +}
> +
> +static __always_inline bool
> +xdp_buff_has_rx_meta_vlan(const struct xdp_buff *xdp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_META_RX_VLAN);
> +}
> +
> +static __always_inline bool xdp_buff_has_rx_meta_ts(const struct xdp_buff *xdp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_META_RX_TS);
> +}
> +
>  static __always_inline void
>  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
>  {

Nit: Why not have one set of generic helpers (macros) for checking if
the flags are set? If you want strict type checking, you can
additionally use _Generic type dispatch.

[...]

