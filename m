Return-Path: <bpf+bounces-61173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD73AE1D11
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 16:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DC4A6558
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48162951BA;
	Fri, 20 Jun 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9CCFKsu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F828F51C;
	Fri, 20 Jun 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428655; cv=none; b=naKFdotCt2V6HlkVEG90O7K8vnZrZG2eHI44q+mUkdCuOhTFKBfa3PVVrxK63jgMVhcmz/Ef6mo8QRRYWBlYmtshFKu1yUhshGa7mCdlS+V/lFjVdAqXIzfQFYi9ucdp6dN5h2++8ukg7cdGO+S1uKWXcM1/jKe0Xec02gAqY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428655; c=relaxed/simple;
	bh=GL50W4CAzr7lMp7WSXLe/G7ojtPN2HkR1M4KvG9PoqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCbDRjIQjgWVnheQrbet/A3Qxt9BNQbiviZBPkr1F6lm1sLuOs+hgAiXU0fXtGIYput2GXN/i7FWKJp5YQcTaTY2MJWE+GViRthh5esEf6xpbScq86yNYaPryFWTa7mDVaGAkr9ea8zKpP980ywHi9tjXvGmTy7n2eC1gCSZJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9CCFKsu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b31f22d706aso655784a12.0;
        Fri, 20 Jun 2025 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750428653; x=1751033453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OtaAZotoZbAmUCqV04nGyV/X1A2T8LT4Vme2bmNP5JA=;
        b=h9CCFKsuwmr9l9/AABhDYMCGW9ubqTocBp3zN1L/OS3DM/vpr374a9i5OBa4E6KNNq
         6IHX7R7Blp4FiJRWeA5onuKKt5G4IDJ3mgBhzSh6or5lPp2i5NuD7Witt9GSKElBmpjO
         waXNgJZDb93WXHKQsCRs4KijNzpiiB9f7zPEbT5bCUCDScEnP6pEEx46RC9wT2RnnZ95
         Rx99qevYkfTITpiY1TShHnqefew+LtGZdZ4sbO4HGCRmkzQ/f889BO3d9AkOuMreVfAu
         44VJOUa2wIe53lJtu63lCB/EfbseUNfQgmOYSyY7Hq7Ujbf/6Fmgosn8n2/KqvYouO3X
         vp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750428653; x=1751033453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtaAZotoZbAmUCqV04nGyV/X1A2T8LT4Vme2bmNP5JA=;
        b=ejTpp+V9+/Uj/awLu/6Nt3cigqe63o2QIrRrUCDt2aBgtuoO09pqbP5SlzmNh7FEPC
         XKJ5tAA6DIgvvziG9B5KOJ91FALVIbwob9MDVO1dQLN0Bbf+RtnXQE2fatImLIhsyAsZ
         U0pz3rJvwOxXRyvbBceDQ/AdL2xrzlJ7mAJqOnP1wugy/gR2zmeivlfkLErNdUQKzQ7V
         IzNvPFFEwzXK8sVQ8TxhhyUY2NzWcmVUHifVfGfcWgxOwtxo9ZPo1WbBMmi4bTFRPyQ1
         2AnenkwU8eMuHUxfokIHLqL0WF9c86CFatdFGWn4fqilxmTEJKFNIdHe2XaXvPcLOIkD
         CCMw==
X-Forwarded-Encrypted: i=1; AJvYcCUqlRxYYyZD2I9BlOpURa/IFekMfYOFJ/r1vVLPfu7Eo46kAd8TkC7XFtpL5fRmsW0SCpM=@vger.kernel.org, AJvYcCX3WLLEPt+VqTI/564zjBQh2gxCJDu28Qdd/GVCSeOtGVpljZTiqj/3MBdL3OtUcrrTWw3gLGl3@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4weTlet60Wk7lZGme6reDngwCtxxMMiL66owbD6XhUWOsPRI
	MS1tEM1iHvMO03BM3M+Rbra0shxlAy624BWtJ/p/YecrkkR3Gev/EdQ=
X-Gm-Gg: ASbGncuPaLXEgCvytm0TdGxOb2em/KQ7lPQfP9beRTwtLJelWEV7DxWtHVgVZKgmbZA
	TS8X13f5hzgNAvwKq2fD8WTIbVBDsckVOiOlou4+D/VdZ99KlUddCAqK7gHzFsrTBBIgx7rQuC8
	q2PnlD61e7b6jiU3icwxg39udxDuo2oexbm3OG2dIWrBG6kunFrtORAGzG6eRfngVhlpk8KHSTo
	60/tlYADlowtU2rKDX5LrAODpXwy/Gl3uekECR3vFkZT88fN6qc4NAqOAnM9N5L/yWXJ1kckl09
	iVOvBIGS33LlUo79GW290p3R/qJzvbUcTT+bfen9tgULgCYlv9UxuEpmLxKpDHOkreyWW3W/IMk
	lbIVn2SHhdeS14EuZj7gA8y8=
X-Google-Smtp-Source: AGHT+IEXi1orG63ESahh7V/mf0IgIv1CI0C+U+SlRZHDDFhuLCWsWhgvSv8Pw27b4STyMf7wyRyvnw==
X-Received: by 2002:a17:90b:3952:b0:311:ea13:2e6e with SMTP id 98e67ed59e1d1-3159d8dfbd4mr5140205a91.28.1750428652821;
        Fri, 20 Jun 2025 07:10:52 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3158a23e5a0sm4328356a91.17.2025.06.20.07.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 07:10:52 -0700 (PDT)
Date: Fri, 20 Jun 2025 07:10:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: xsk: update tx queue consumer immdiately
 after transmission
Message-ID: <aFVr60tw3QJopcOo@mini-arch>
References: <20250619093641.70700-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619093641.70700-1-kerneljasonxing@gmail.com>

On 06/19, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For afxdp, the return value of sendto() syscall doesn't reflect how many
> descs handled in the kernel. One of use cases is that when user-space
> application tries to know the number of transmitted skbs and then decides
> if it continues to send, say, is it stopped due to max tx budget?
> 
> The following formular can be used after sending to learn how many
> skbs/descs the kernel takes care of:
> 
>   tx_queue.consumers_before - tx_queue.consumers_after
> 
> Prior to the current patch, the consumer of tx queue is not immdiately
> updated at the end of each sendto syscall, which leads the consumer
> value out-of-dated from the perspective of user space. So this patch
> requires store operation to pass the cached value to the shared value
> to handle the problem.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7c47f665e9d1..3288ab2d67b4 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -856,6 +856,8 @@ static int __xsk_generic_xmit(struct sock *sk)
>  	}
>  
>  out:
> +	__xskq_cons_release(xs->tx);
> +
>  	if (sent_frame)
>  		if (xsk_tx_writeable(xs))
>  			sk->sk_write_space(sk);

So for the "good" case we are going to write the cons twice? From
xskq_cons_peek_desc and from here? Maybe make this __xskq_cons_release
conditional ('if (err)')?

I also wonder whether we should add a test for that? Should be easy to
verify by sending more than 32 packets. Is there a place in
tools/testing/selftests/bpf/xskxceiver.c to add that?

