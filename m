Return-Path: <bpf+bounces-56507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF209A99561
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B6465436
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9C284B4E;
	Wed, 23 Apr 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc1t/qwZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC42580EC;
	Wed, 23 Apr 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426175; cv=none; b=aNvFjvN6rbrUkXYUHS0VvJ/mNGZBK0s+uQxvsJ8zp0YiaXJjsUVQ8wRlDQ1SxiiVg6MbeA2EcwdJMbVt3C+YCoRnYv13Jc1uN/F+Nz75bROiM6mJbym4WyzpusA8T7ZZcJ682TVmVZ+PmH8UTCRvue0XFGsDoFkdIGenPhbzM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426175; c=relaxed/simple;
	bh=HOTPxIV7oY2bFAVFMFQtXUDVmtsXrhSSoLJeftJCRpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwV4Qi3J2QKNqBAYiCt3UYLceLW35R05MrmQ+Z46iedKmqUXsTLRDUh55uJbYMs9ypT6xoJ/STDQ1vxiCanmKaD/heR+uscTdAIO6Jo6L7kuph/DP5HeRbmL2aZQ3bC7uzxDK6qT0EU8BarYKRp9JBVA2ej9ffmLNgwY9O+Tywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc1t/qwZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5952187b3a.2;
        Wed, 23 Apr 2025 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745426173; x=1746030973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCCYjEmMzP3gi7G70FORIHySUzwzkQLv5W+jbyiZR9s=;
        b=Yc1t/qwZUGaIXXj9OMeci6K8xwa4m9SacIv1O3ZI4iJBbYjP71OWrF7+j7y2anfmk3
         u2eTM5KJyDqKxn28q0aGDPXsaP/iSLUmv3rzjR+f9WFx+rKWrY4nXMpwDERe/dN1M5I9
         /SA7Y1cthiB4Fs2UEaSc4jYMqlPxP6xDb7BXM7VTnNhKT/h61MgHYewU0BfrjsAzB6Ut
         lc+9DR2yoTnlRYIjJc4N6LfdmmUbrfCJHDvhRGyc5YveGH5AKEc5Wps1MVqeFMA8+nyP
         2aqQFKIFYH9Jt+RrMZrVY5R1473YKKOf5XU96KSyE37CD8weesDnvnEL57Okxr+UIUxI
         T6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745426173; x=1746030973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCCYjEmMzP3gi7G70FORIHySUzwzkQLv5W+jbyiZR9s=;
        b=EoLLk+7J7dVWjWsZ1s1pM2za4atQnwtHqvgXWpJofXSZPJNmcal0+brIL5wvchYQ6T
         SCrzMvXsLxl0SeBLo37RT6+V6NVGrqR6/NLIKTobekYXiJ1HzILcR24njzcuPhM9r+nd
         0/KJHwIYkVIlBo5uRlVIMLcaaFc6vZrptSztInzm6Q6bFu1FFDIF147gP03vrbHAyc3s
         tsvuxMFM98m3FCGomb+FJrY5BjRc2j5395XNvuzOnU1i7T+7WDP0v6jkAoe/LVtuhQUo
         0Tnp4Wr87KjsNwRtfuC5Pzl8jg81/L1tgVRSRY55vnFwToPVqqZ9UFd/8cNPNDhGQWLQ
         4Mhg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ocn14tICDTRPoGBBj1bO4IC4gvyNonDUFcZhOhzi5amX82Ez8itX+HqxFndFLdh3UoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLjpQTwypykNMD9jrLTIHCF5eGeNc07kulyuaK2E2s2qAUhYN
	UbP+5VYVjXRhjLrYpafxpQbtKGOvy0dbhWdJ4LIbSJtAtyYXG+OcdOg1
X-Gm-Gg: ASbGnctSWrfTNvVQJyUrWra3mcMSRiQhR3B/LnS+PiKAa11dS+hAgzgt5c2PP4oTTlR
	3nulhUK/J2fLWgbDVlTmHCJf6JDv5LhXmWjQdMDGTl9y6T6mF4+xa7V/JTVigTAiDMZ19cHrq96
	LMarAKgCneCRV97B1MN9A0ubFsCyceg9mSA0F2trypNBcSLHqjR+OQmyrJHaYZTmFKL3TnrEmOL
	/aDgZz2xyD6G4pE0/WG8kycNTgmAfvICGslxwrZp4ymdxBrmqXbuiD6M4SEGzfdr5U+ZiQoeZDf
	DkPuOb2mdSlbXqzY/Ok156eEtIxMlkbhFQDsHzos
X-Google-Smtp-Source: AGHT+IEhhYzGrqNdp5/f81q3ZA2hRHb/OEfEbMrxA1i7OTo44dzyzvBEEaF6MUV943bzseEzEmzxWA==
X-Received: by 2002:a05:6a00:18a5:b0:730:9946:5973 with SMTP id d2e1a72fcca58-73dc144bbdamr25018885b3a.5.1745426173006;
        Wed, 23 Apr 2025 09:36:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8be3fasm10793171b3a.30.2025.04.23.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:36:12 -0700 (PDT)
Date: Wed, 23 Apr 2025 09:36:11 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Arthur Fabre <arthur@arthurfabre.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	hawk@kernel.org, yan@cloudflare.com, jbrandeburg@cloudflare.com,
	thoiland@redhat.com, lbiancon@redhat.com, ast@kernel.org,
	kuba@kernel.org, edumazet@google.com
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
Message-ID: <aAkW--LAm5L2oNNn@mini-arch>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>

On 04/22, Arthur Fabre wrote:
> Call the common xdp_buff_update_skb() helper.
> 
> Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c8e3468eee612ad622bfbecfd7cc1ae3396061fd..0eba3e307a3edbc5fe1abf2fa45e6256d98574c2 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2297,6 +2297,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  			}
>  		}
>  	}
> +
> +	if (xdp_active)
> +		xdp_buff_update_skb(&xdp, skb);

For me, the preference for reusing existing metadata area was
because of the patches 10-16: we now need to care about two types of
metadata explicitly.

If you insist on placing it into the headroom, can we at least have some
common helper to finish xdp->skb conversion? It can call skb_ext_from_headroom
and/or skb_metadata_set:

xdp_buff_done(*xdp, *skb) {
	if (have traits) {
		skb_ext_from_headroom
		return
	}

	metasize = xdp->data - xdp->data_meta;
	if (metasize)
		skb_metadata_set
}

And then we'll have some common rules for the drivers: call xdp_buff_done
when you're done with the xdp_buff to take care of metadata/traits. And
it might be easier to review: you're gonna (mostly) change existing
calls to skb_metadata_set to your new helper. Maybe we can even
eventually fold all xdp_update_skb_shared_info stuff into that as
well...

