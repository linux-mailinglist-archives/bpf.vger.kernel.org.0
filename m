Return-Path: <bpf+bounces-63995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D388B0D0C2
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 06:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AAB5444B5
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 04:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B535A1E32C6;
	Tue, 22 Jul 2025 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSmU0Fcu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8765223
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156915; cv=none; b=Yj2+E8RfuT74F+vYFg2fbQYQLN8W9anz63ly128djRMZ+1mNKAYYEKhb/x43l67UL1vvpVom/Vb5y9RpM3lNXpbkDfcayLABowWyU8eWFBc62c9idTtFXQszgvat1ktuixsit9s545fMRqX1kEBmSj4mCxVCjiFTXUig1vRYLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156915; c=relaxed/simple;
	bh=SRrCYBQ1RzCqPB5TYwMnscFLupwNuYEb7w9ZY6h09E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzjjvlOjD2DElZpzs1MLpOP7k52FyiQ1Ff2HvceO/LWp3TfNH2RJMMNGC93p5MiBCSr4FzR2XHo+Pm6CHCSQhbjFCGi1D9BO8gSReGoAYgtkc9RVGyMOIuWlc/hT7v8HPM/aNoA6JkKgSAsc4ZLZDALhFclBDuvxZrCS2P6sml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSmU0Fcu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34c068faf8so5182157a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 21:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753156913; x=1753761713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OeQHSgF6AqIvxWeUXGK8OOyj92q/qGDxJ+Ssf8m34Q=;
        b=HSmU0Fcuc38f1IX6Pva4qOXfwhADMHA4F78dbRAxvhxORFw4UvidXp3eInjajOWYQz
         6FLI31SWJQ0H1Y5f0UEJN9mDlFmcuGASWOBExMjgPjY99m2ZHVtAteArJGUwT9CDs8PG
         h+PVguAOWdEoO0nNblU/yojBe1hmubOsok7lJvtgEj8T585ASYrtLKrF53hXSDoxO0NB
         BVZldFciB0mgYcBUeukG8nuCR1ufv3SBrqyTD8A1VLavWzd5cE3B0Zm13n5Y1Klg9zWF
         3Pms+wAi+CMWipJ+eqouEObcCkwdElgQoPOvp52/xJJSsp5DxnSEoIQCqWkOmdp/VJQ4
         l7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156913; x=1753761713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OeQHSgF6AqIvxWeUXGK8OOyj92q/qGDxJ+Ssf8m34Q=;
        b=cnKuGZCdYqdmeUMcdDjZ3hUfiv1i6c4mufk4qpRBrt6g0e3oHsZjBqc5jjosvAvIzD
         7SN+CY91J7gWY0XKAcDvXYiOIhm1cih41uQ9cCB82iagk0XB4w3RfImoIUMBdwzdO4bT
         QScEPgIsDKpXP2jOX1ICeWWkZEL+XiUZJZ5/NPHY1s56TOR7cs0I02ENl6J8Av3FeuM5
         1A4W/4AUodUeKlSK5uXnaiBs4y9cv0XknkcbKAmvL5H3BjDbs7ACkfYNWn2hBPDO5on/
         PMEY0/wQoqvJuJPtoa9fybrpa7yBnIVoi7kiW+QSc/vRLlA4EHqN0wGxiZSeYnFkFEjP
         1DOQ==
X-Gm-Message-State: AOJu0YxNop+jydOJTgYU7mEZu8SGIYzb/3nEE87jTxGNcG89qO6UYogY
	Ju/+3h8yzNFFA8+z6NFOz1LjWR3VEjuifh5xWfnu2EoJCjk1SSk25ZFH
X-Gm-Gg: ASbGncvAclC3ho4XLaLklhdYV0/lc5ZbizBhVSVl/ZXaNRwBWVcPWNoO0CeXSaGWgyv
	WtxnFMMjcbgd4PuENo7zh5i6dxkhXUsYG4jixIP5XnIeoiBIMzQWpTsrbqBDZj3YLIaz9oZ1SnJ
	/T/fkDWsHUcoOwVK8NrXdaZCPxuNnZMj3RDaxVi6SwVZCWcLzXd4KQX4YJ9lZjme09kWX9vtyqX
	cYMZH+fSaeyBBzQUqUHG4A/7iOClDmNT+3+ioa1BOAtVX2T9NRisYpDcDKwkhnPGaFvTLuTgTtS
	S/IgnHx264G4Anq/aAuOMnPUnuxXQ4cTSBZ09Nn/0I9wXottYIA/e8HSWZ/r+lf+PWicxUfSzOf
	b4Hos+IdvLPHOBNNOWzuKeA==
X-Google-Smtp-Source: AGHT+IGvqmeaxEJSA/I2/xhoYD5HN0aKmmeRRfyYqONw12SO+WxbVlW6FaFVB/3/DE1xX5cf/Lgc4Q==
X-Received: by 2002:a17:90b:5823:b0:311:f05b:86a5 with SMTP id 98e67ed59e1d1-31caf72a0dbmr29816161a91.0.1753156913193;
        Mon, 21 Jul 2025 21:01:53 -0700 (PDT)
Received: from gmail.com ([98.97.38.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f162d5sm6906116a91.22.2025.07.21.21.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 21:01:52 -0700 (PDT)
Date: Mon, 21 Jul 2025 21:01:34 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: Use ERR_CAST instead of
 ERR_PTR(PTR_ERR(...))
Message-ID: <20250722040134.loagr4rrvd44tzgb@gmail.com>
References: <20250720164754.3999140-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720164754.3999140-1-yonghong.song@linux.dev>

On 2025-07-20 09:47:54, Yonghong Song wrote:
> Intel linux test robot reported a warning that ERR_CAST can be used
> for error pointer casting instead of more-complicated/rarely-used
> ERR_PTR(PTR_ERR(...)) style.
> 
> There is no functionality change, but still let us replace two such
> instances as it improves consistency and readability.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507201048.bceHy8zX-lkp@intel.com/
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
 
Acked-by: John Fastabend <john.fastabend@gmail.com>

