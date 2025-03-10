Return-Path: <bpf+bounces-53764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD12BA5A6CC
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 23:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE58E3AC0D9
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899C1E411C;
	Mon, 10 Mar 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khmFllzp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE60382;
	Mon, 10 Mar 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644954; cv=none; b=Dd9m0dSgltvYdgPBSrHSbsUdgMa+frUXZiPxdK6n3MgBwGEb+H2y+FuiTAfWKCfTiW8SHsN9rLohPF9ra7Zye96x1w1qUx5wCVt3TcMw6kQO+3C8ye2LBh0mqu8Dszz3JMi0Zar6qFe2/4+JD/1dbcyi9pBRGlFx6MpBgawIc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644954; c=relaxed/simple;
	bh=MF4s2eEn3ZdqFBAAjM18R0r3cdwRqtwQDWZrbQK3364=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL9Sdc4enteIsjiZQmVSkRssqfMeC+ncxqDTXzCEo2CYG5iIe+W16HnfHrqiEVoDamzDejDTCPlqf+Aly4ytXiZx+4sZQ+/WERytTHpfvHw6jEPYZ78yf5ay6siTmGHcCUegotxp1ETwEa6Vq/amruL6QZmYPOkcH39VlUUrwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khmFllzp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so15232695e9.3;
        Mon, 10 Mar 2025 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741644951; x=1742249751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc2ZWPVagd462p4IcOz1KfXDbsfsbpoLN4uqC4LzTDw=;
        b=khmFllzpR4v9dWrIHpae6TiePj53x/gQB3xiu0Qj5fbzi0uc+wml+NB0ptJD8cl+vk
         5dAXUNQnjDnfDiApxcmRB4Gh75Ye1ToomcD+J0Mt8DF1GQ+UscB2K7diuSNyDF8DJ9mA
         tJJx02QM1wNbEqD3lx3W3E0mFGxICBtrp6HRBUsgJUGMZifMpgTmfaF6+miyEIEAuj+1
         C8i+LBwB/w83NiNgC2gzHtIt/Sbwaj8THX37QmfYzugExIFvA53NfOQSW8J9fs6HZJVS
         pxoeJY9AdOZmV4pHg6t11WLR5EeKawoq/tV90U9Y6B2fm4X98q5C4L0KVWOTDdF0lxyq
         ckdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644951; x=1742249751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc2ZWPVagd462p4IcOz1KfXDbsfsbpoLN4uqC4LzTDw=;
        b=q9qFF7XycYIRxxBUW40hlQOH5DNPLd6ZPwNb/54LoYuZ6pHgGZsWSBU9IzCH2xSLGU
         lj3gi4HGlQduno+Kz/BxQyUFQetDpSfPf7Rfk/wNw41irI5HpeJefp/o6x782J5jVgYx
         qSCO6IYibRGJKsNIjLqGsQXhRKJADcAChJCo0WZl1qP8sZOqStyfnIQrv95OE/iZKCLp
         1OKmS6032NsNJExIMvuEtdnfVHiC9xXqJi5ieBQLRFXSP+G8SfHr9EYWI52xRWdeHfXi
         uCFGxIqCT25iQC1cdPltrkGMi1Um8c89/aMGts1sHxkRpPheUwPg6gVahpK3Z1y6pgqs
         tZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUANR0ETUZphJ1iVidNI/uO08u3d4U7pq20SwAaIWbFIAbPJRyCcHOQDpGKDtqru6BbE6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlTlmLbtpCKoFT6C0ds8PDi5XwoNJzJSM2r3WdgII09OxxS6p
	MZ6BiR5FwACYQwMHSZ7bonZHlkR1UjZaKEo282h4Qb2wX8l4zU5I
X-Gm-Gg: ASbGnctO6FSinOcXbB0c6xUyU245xf0Z4GoLNxmFo9wa5BA4nfRvy44kw8iDBd0FlBJ
	+ZNvXRH6kvmP3DYO7EgYgtEVnzR2y0qOaCpI1RDFNGo81P/ZG9LuyhrlUiFY5GlTcCDdUpsM5qC
	otrgUZxqAf0H8wjATD0u0TxEh5s00/9anhT8kBXv2CQcJTTi47XyEbqBwsCi9F+xZMlMaYpfbnC
	YxCy0CQtmNYhGdp1p6U4viLvIN+Gu9ZnnDDWg36QnDOdNf6SoOJFIkC9zZkYabDqAkY1sCrHE1R
	zOE5BZj6WgNuIjzrjYD1hLFhLowv/IJhXStfZUBu1T5Tn0ANZYSeuMFovhSYhsUis1NA5X8lDzz
	qp/4Xkj0=
X-Google-Smtp-Source: AGHT+IHzVimTg7b3GFrOvWnyocg9mMANFRC04CWs1WvwAmBZ9h6Jr06n15+O+9cFdqmAiq1PLlJOyQ==
X-Received: by 2002:a5d:59a8:0:b0:391:2d76:baaa with SMTP id ffacd0b85a97d-39132db1be7mr13345620f8f.46.1741644950648;
        Mon, 10 Mar 2025 15:15:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf515c580sm60622075e9.15.2025.03.10.15.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 15:15:50 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:15:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: arthur@arthurfabre.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
 hawk@kernel.org, yan@cloudflare.com, jbrandeburg@cloudflare.com,
 thoiland@redhat.com, lbiancon@redhat.com, Arthur Fabre
 <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 05/20] trait: Replace memcpy calls with
 inline copies
Message-ID: <20250310221548.1c198a2b@pumpkin>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-5-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
	<20250305-afabre-traits-010-rfc2-v1-5-d0ecfb869797@cloudflare.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Mar 2025 15:32:02 +0100
arthur@arthurfabre.com wrote:

> From: Arthur Fabre <afabre@cloudflare.com>
> 
> When copying trait values to or from the caller, the size isn't a
> constant so memcpy() ends up being a function call.
> 
> Replace it with an inline implementation that only handles the sizes we
> support.
> 
> We store values "packed", so they won't necessarily be 4 or 8 byte
> aligned.
> 
> Setting and getting traits is roughly ~40% faster.
> 
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---
>  include/net/trait.h | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/trait.h b/include/net/trait.h
> index 536b8a17dbbc091b4d1a4d7b4b21c1e36adea86a..d4581a877bd57a32e2ad032147c906764d6d37f8 100644
> --- a/include/net/trait.h
> +++ b/include/net/trait.h
> @@ -7,6 +7,7 @@
>  #include <linux/errno.h>
>  #include <linux/string.h>
>  #include <linux/bitops.h>
> +#include <linux/unaligned.h>
>  
>  /* Traits are a very limited KV store, with:
>   * - 64 keys (0-63).
> @@ -145,23 +146,23 @@ int trait_set(void *traits, void *hard_end, u64 key, const void *val, u64 len, u
>  			memmove(traits + off + len, traits + off, traits_size(traits) - off);
>  	}
>  
> -	/* Set our value. */
> -	memcpy(traits + off, val, len);
> -
> -	/* Store our length in header. */
>  	u64 encode_len = 0;
> -
>  	switch (len) {
>  	case 2:
> +		/* Values are least two bytes, so they'll be two byte aligned */
> +		*(u16 *)(traits + off) = *(u16 *)val;
>  		encode_len = 1;
>  		break;
>  	case 4:
> +		put_unaligned(*(u32 *)val, (u32 *)(traits + off));
>  		encode_len = 2;
>  		break;
>  	case 8:
> +		put_unaligned(*(u64 *)val, (u64 *)(traits + off));
>  		encode_len = 3;
>  		break;
>  	}
> +
>  	h->high |= (encode_len >> 1) << key;
>  	h->low |= (encode_len & 1) << key;
>  	return 0;
> @@ -201,7 +202,19 @@ int trait_get(void *traits, u64 key, void *val, u64 val_len)
>  	if (real_len > val_len)
>  		return -ENOSPC;
>  
> -	memcpy(val, traits + off, real_len);
> +	switch (real_len) {
> +	case 2:
> +		/* Values are least two bytes, so they'll be two byte aligned */
> +		*(u16 *)val = *(u16 *)(traits + off);
> +		break;
> +	case 4:
> +		*(u32 *)val = get_unaligned((u32 *)(traits + off));
> +		break;
> +	case 8:
> +		*(u64 *)val = get_unaligned((u64 *)(traits + off));
> +		break;

Should there be a 'default' in here?
Possibly just 'return 0'?

> +	}
> +
>  	return real_len;
>  }
>  
> 


