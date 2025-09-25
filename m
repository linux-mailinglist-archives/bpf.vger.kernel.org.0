Return-Path: <bpf+bounces-69766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62072BA1048
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9611C2262A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F92315D5F;
	Thu, 25 Sep 2025 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLAgERx2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF57302CC0
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824930; cv=none; b=WcXJuN2f4xnX++sgY0AaXvPNzk1KUfIsJ7jhUUu/N9ld/woHQKvcmKZQgIMtjaffsDSsGm1ncQK37hofVsBfxNENKqyA5WqTADtrd0aqDgEPiPYyYP7Lj/xJ6IPH6W/bwP2vw9lY0WHxObp/9baDwyQAHicio4w8mAXvz7Wnb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824930; c=relaxed/simple;
	bh=2bD99g3RCzHS7qpjMvEy6q2h4XoAf2oLQsUNEA2zgng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ8qE+KdyONyUJsiC8O4+NYsj/K+jT+ALEQPtcBSkk3q1IgFLOvgbxttiLKnghc8Mb22xsNvkfazrLfRggoru7bgPIqZGOeN4LLoHM7zBbV3eoUdaKQoybdGlXlFEiPb7cKPRIWtxFi42hPHhyrznLuchhSN7biTrB3PIhbPgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLAgERx2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-269639879c3so12504025ad.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758824929; x=1759429729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+leS/PUM3ARLJL0ftMj2JwrPx3Y3t/3wj//wIwdtcY=;
        b=QLAgERx2tWw7YHK3HgQD8bpWWpQxolw2efmsjlGrBZyFKfUNoqlzgbYWKEYLdxB0TO
         CONDvwVcn6h0CKhJGDr2DKRHrNM+a1UW5lJEjtfjBkxt2cn+6jRKVpQ/NRRjy5AR0uO2
         cj2DrBIIqAzNlTu7c4O2QJlLxeYMJB4Rc3JL5eXdYRbibBecfOf3hsF03WOkQjfPIg7g
         KDXfRy9zJixuH6RW+Hk35shG4R9ejRcEPRqPxB5Mufvj1Tpv0TJdSB+tUcD2Cq6bpoHu
         xkqGEWfeHP+ojkeYVIfIdxzFhoOKaAP8QPbv8gS8jHo1DLAF8pwYFxvztUFNGID0bQWm
         atZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824929; x=1759429729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+leS/PUM3ARLJL0ftMj2JwrPx3Y3t/3wj//wIwdtcY=;
        b=NUf+phXfPTWvb+Ljj9RHi1TZro++n9Fiam2dU+ZoWKNEcV6q6nMVaesDCcILR1IXbY
         4iqqlWFvpPBRRHVkz5J5kGzTMZl5L4/hfY88YkMyp4YZUF0AnOpsPWTdRDpfn8KogYjN
         c5QZd+Twdi96d5NB/y5lfWJ/mjX5IS9vct81dQkA913XlJWF3p8zXXu9evkD6js0ToGB
         ggieLJY7sROpQOtRTsUqQkpEn9l8YcQHQwQDKTtdeiGlP91BrZ6tQ1KIvpCXWETGF0BE
         WM6Wx26PIOKsh/62+97ngmxiRpdBH58YqOzIiBTbjgqNSig9DjAsZhU/bIyIQCkiDOAX
         LwHA==
X-Gm-Message-State: AOJu0YzjKxiRPxYWc7OOaP+1puRwKx9SYOPXIRlT/fvDImFLW08peOZ7
	fwhfKJxlPK2KqH2E483dvk4UgscpLsAWfmiw6h9K/DKH4Exr9OsA4bg=
X-Gm-Gg: ASbGncsCNHwqynqbYnRtlzJglTfenuPXYVFbiD3tUGF+7kIG145qUCUgcio/Ji0bBNn
	FN2Q7SCENh2wnLFcSiSAYFbVI8kud8Ve0xuITIO8qFYnbkBBnT1/Bvd+FFZ1acQTHjbi+cmANiW
	gXOSV/mWmJNC5kP6RgIC/Kch4U0tKncXXwtt3rUzHEB9WvKoMmkQUGgrx+wW7FwA1V68/HxeFUw
	5D+L4NY4z9knx2Uu8kgD51INrj+AIFdJIKE709XlJrC3Zx9bcHB0GNpTlEeyQm3ejsjE61apFzK
	omrhhcKI0PCLRWBM6vOZarc4XX/guHH7+kGP6vkOvHDldNb3qskd6m1ByCLCNSA8z7rZmwVUo19
	sEfJ0FPYS88Wv6TOrdB5DL27Cw//qVRftHbRBO1OsTP4uK6dYyPP1CEjshVrImG+47pqK3ws44k
	TeSNolGmP6hyr2+L1VQL2n+QhpjIWQAI+CIl3pJWV3VkU/UFcwHe2dZdov/QW6/CC+R/V/Jsfd9
	IBg
X-Google-Smtp-Source: AGHT+IHZVugBIgouDtYb9BFWkOqDdBYhyJsuidZA4cBawd32xhG7dw/4osu633h6hZASidRCxIqzeg==
X-Received: by 2002:a17:902:e80b:b0:267:d0fa:5f75 with SMTP id d9443c01a7336-27ed49df282mr59465845ad.1.1758824928291;
        Thu, 25 Sep 2025 11:28:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27ed6733a63sm31851675ad.64.2025.09.25.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:28:47 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:28:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH v2 bpf-next 1/3] xsk: avoid overwriting skb fields for
 multi-buffer traffic
Message-ID: <aNWJ37JhjDf8ExwY@mini-arch>
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
 <20250925160009.2474816-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250925160009.2474816-2-maciej.fijalkowski@intel.com>

On 09/25, Maciej Fijalkowski wrote:
> We are unnecessarily setting a bunch of skb fields per each processed
> descriptor, which is redundant for fragmented frames.
> 
> Let us set these respective members for first fragment only. To address
> both paths that we have within xsk_build_skb(), move assignments onto
> xsk_set_destructor_arg() and rename it to xsk_skb_init_misc().
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

