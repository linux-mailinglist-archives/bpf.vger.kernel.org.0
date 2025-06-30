Return-Path: <bpf+bounces-61856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD73AEE474
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78561164662
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642F28EA67;
	Mon, 30 Jun 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hiax92g0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15571E5702;
	Mon, 30 Jun 2025 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300745; cv=none; b=iwygodKEA22IdrOv3/fFtTVElKiIr3WDAAXdw6eX+BED0HLCNtLr+LBxTeMqOfqpzdxCiyz2ZRFd5E0QOQ5J3fftDJJngVU8S3yJ74I31aW9jG3LkbGdYL8PrpUAicYZ3xucagW1fwM7nfBGbXY5DIe2lSQQ/KKIcY3K3SVAiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300745; c=relaxed/simple;
	bh=XW+WWVck9kz3OMZWPmfOuSuttGjJiXsduO8GKguxcTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlqC9b+tqLjORR4kjpKnWoGA+1FGNDGlCF7GFXQ+wMRfPhOIbRTTSuQL+PHs5kMn1Bs5zibdxtEOrGzKaTEWEK4Wa5ge4Ay8MPOI61CQQtIu+jQuLy1IIP4rpicvU+qbFWc9XFqioiGakopsqtj13q0kRMAvREs0hHc/ZNtuANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hiax92g0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-749248d06faso4856307b3a.2;
        Mon, 30 Jun 2025 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751300743; x=1751905543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qrA45bUKjRioH7bxqknUl5fWCUoEQgL2jH/yd/+s+A=;
        b=Hiax92g0rk0uUh7NScR8uW6ZQTz6svsbCbp3jccTpkF71dUtqlWWEEyjM1wv5ln+tY
         j72cKFUhydadRsY8IrxhOPJXFULdPu55vDNRYnsmqx29xTyuYfu2IIBv5He91vz+56zG
         Hp3pwHmopcmCPhFdt3g8I+Ne9OE2AOr0mSlO2q1yeT+3n923TxYOUw9RPn11/840N5gt
         cL4NYvFQ79XEJIzzBMCfQyhLBRCLmC+hkhfWry4VdjRdWVRKUnNgG3QR3CIJPDiVOT7L
         2OVRUNNILiUDog2MSbst4A/swXn6Jzw3yzmM/bBKCestIiF6h/tWiHwxvd0FyAGXtZ4P
         mAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300743; x=1751905543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qrA45bUKjRioH7bxqknUl5fWCUoEQgL2jH/yd/+s+A=;
        b=Q2Qw6m2z7bAt6NnQ7sZCzvjeuHvtIGb1ZLhFLVRR/SmfOuPah6h/weKDZ5kmx/ldyg
         5N9dVsPVUpd/KxF480XyAhQ11hb+hyMoo7FSrRoBHehlESCtKmgm91NYHMdg3lcmJgDR
         TS4DjridqDJWMlcDwdErqL9v3xK/2FzxbiIbcABqsNUBeXrztfMGpDlCXHLazFush7Xh
         IWfRc4HKw2F4A71Ct/ZAzFw3ZqzY575oTSqEpvFNKL6xiEZ8mCQBamoxy9oEBHiqnlc5
         ePUvxgLfogM2G07R+HRsrxAhk/p4FbkMrkI3/MihxV0/HVuHOomM4Droyw8fCfZpJ09p
         rDAw==
X-Forwarded-Encrypted: i=1; AJvYcCVQCl5EacHiiUCr7b9QKGCJAf0HvvDAHZlXWHxKrhM9sbZFn2Pou5dK0OPIjX7wm4Wz6joPkHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45UbFuH9ieZqgVEUMRVZ+hTXuclj07I6Y/V0mbf4VQCKEGt63
	FIlKdjA3mzSvBCr3xbW/XlMm4fndY+Imn6W+wNqTfAbLs/u1mGAYMQU=
X-Gm-Gg: ASbGncsUpbQ7/i5KBrwA+UOan1KwPcAJyUAOjPFHRj5eoFsN13BFTc/Rb+wt7gSgsnK
	oiJcOBu5NxTAtyPWTE4I+B6J0DLqOlf1vu7jnW3RsxR7U/GAacyzAwDcWZcbYhz0VV2aoao2w32
	JVfN3PQyM2I7ZtPJJDP6rQWrdpuTl8Tnx6XMx51yja/F6KZy3vQlBItgIaGGWFe+rWa5pTLlTvB
	ONgvY5LH2to8TYtOyWnxkuf/VFH2Bw7a7NSP/Cuu/FCoEC4lNSPantkVE8iu23YLrBOrhDjb0uQ
	80U0kp30fMno9T9gJXzQTNBFHw62AYkkhXeGmrvBl1+wSKB+ufe2TtI6VakPnkjwKAK9UJryflj
	CfJ64Kh4wexKTj5YxOthxGHY=
X-Google-Smtp-Source: AGHT+IG5L1whRSKQfhbJR88m/Xw7nLZnaSQcKDoEd0wHp5ZbXql5acZjhznqaf1nLLZqBFPBTMlzAw==
X-Received: by 2002:a05:6a00:3d55:b0:740:67aa:94ab with SMTP id d2e1a72fcca58-74af6ccf0a6mr18663882b3a.0.1751300743068;
        Mon, 30 Jun 2025 09:25:43 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af56cb98asm9499219b3a.126.2025.06.30.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:25:42 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:25:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Arthur Fabre <arthur@arthurfabre.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,
	Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 07/13] net: Clear skb metadata on handover from
 device to protocol
Message-ID: <aGK6hdOwBSC7r4gF@mini-arch>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
 <20250630-skb-metadata-thru-dynptr-v1-7-f17da13625d8@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-7-f17da13625d8@cloudflare.com>

On 06/30, Jakub Sitnicki wrote:
> With the extension of bpf_dynptr_from_skb(BPF_DYNPTR_F_SKB_METADATA), all
> BPF programs authorized to call this kfunc now have access to the skb
> metadata area.
> 
> These programs can read up to skb_shinfo(skb)->meta_len bytes located just
> before skb_mac_header(skb), regardless of what data is currently there.
> 
> However, as the network stack processes the skb, headers may be added or
> removed. Hence, we cannot assume that skb_mac_header() always marks the end
> of the metadata area.
> 
> To avoid potential pitfalls, reset the skb metadata length to zero before
> passing the skb to the protocol layers. This is a temporary measure until
> we can make metadata persist through protocol processing.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  net/core/dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index be97c440ecd5..4a2389997535 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5839,6 +5839,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  	}
>  #endif
>  	skb_reset_redirect(skb);
> +	skb_metadata_clear(skb);

And the assumption that it's not gonna break the existing cases is
because there is currently no way to read that metadata out afterwards?

