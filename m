Return-Path: <bpf+bounces-79396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524ED39C1F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4E8B300BD97
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC4FCA4E;
	Mon, 19 Jan 2026 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryn4QC1p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9211F4CBB
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787180; cv=none; b=U89Oamz+k1OdyyJ/4zifwlwmSzO8ox9eLe/vG0jdwBE7XjbYW82VSbmuehYmsvR7UOG5PVHiqu9IoB+GZgXh+EO4MOuNrhS+sPzZnRMBhHaOX5Xwpe5GqVgfmSFNiQduQh03sbuA3UmyuhTIIaTJV4aJtoAWMHlTPMsqLE8+h3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787180; c=relaxed/simple;
	bh=wrgcs+IqYacF1AlDyVVm/ck42vuv/KZDBpOO6H4e3og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8gGEM5MVAA60fCVGWPY+oMjiI2f662GivCcGQuNpIaAOJ12QU/R7QXxM8wqe3E7Vr/k8aIIBGffTnY5/Xxjr9MjvDA2nHVZgSeSohoJMsseeBR3sGRTdaVBIlzzXddP1dzr4ULs8E3Fp+wm0fyg58mOFz+Np5Q+9ug0UXaityQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ryn4QC1p; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so2303123eec.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787178; x=1769391978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9FVgCq+6TGX4ndZB+uUL0x/i+U6FGafIrPf+7RfhaA=;
        b=Ryn4QC1pao+GHyVc9qcZTw4469hYKwDpmIJObB8focFDrGFq4LjzYa6Ui1WTKX5z0V
         1bwVPa8+eyGjG9fx45OKyzvw3WD8v60NOe1TYv2g11fOkcUwrvi/ldJJ4B3C3/6q0y4d
         Jfnz+Hu/Um7eU/WEVu+K0BnPTMY58Yzkab3YoR553ulbi9fTv74Gz0rRxnOXYQL1JkGG
         O9P2wh4oQtDv9L6iH5PTXXTEtBSYErSh5SIvt+/u4gkn90Jq319UkuA0zFleCI8pC1dc
         x88lEtMTAYz623LxpCylN4wQ2rriBlulZkFRPwduZLTldZpjT9MlV3sgm9f9mefOysoX
         w73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787178; x=1769391978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9FVgCq+6TGX4ndZB+uUL0x/i+U6FGafIrPf+7RfhaA=;
        b=UDSy8TvCDzhxgra8NaxUvYkETiGXOzwQ7ri4A23sTbOLx1QNE22HxRwGAgva83kOUT
         D98/s3nQnsA+7kUiaqa+N3GbzWkvO/kDI3RqC7eyC6S41BFyQdBtcHxnjMbZIy0MNZoZ
         8QWQyrLyV3o1VD5/mKnWAP1OwGQMl0DRpI2kbFQXBGIkdB2K0J3n18s9Bt7N8Ske/8LL
         C99qfBKUXUUFrCbJ0gD0Tn2se1MHJG9nhuIA/damQtS+7M62FE8Qg/UTnU9W7d/P7PXG
         0NlyLcfLv/WiRhaNKg6Dw3A6iDaPbJ910p2kw90r2G44noVRPGvYRI6Cs+3Uc82YgYKz
         rGzg==
X-Forwarded-Encrypted: i=1; AJvYcCVJPvb9HcwiEXWQJqTzbPKkRtxSAFITA6Axhk1UAQcEzQXoSseDy5niURV3zc/j7EWvLoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsT6hdFvY/LmtPtkHYV9Jlh6xADYOaSKsN/VEKFfg4+z5c6x/m
	gyIjRROwn+FtvQWkIWQ6QvITy63UheS+U3Z+yOsPfnKMz4uOJ/Elh9k=
X-Gm-Gg: AY/fxX6Iz1GtYeDnkDH5Q+nndkz7jYb/r70BW/i8HKXIgK0FgU2rNNht/6lwXiEZgKo
	TabD8ZuyLjlxX2+5UenCk8kjbVCbG+Ugzt9ha3h41dX2USd0QlhCSYflz5DFOsmwfwYKrZL9spU
	N8Oyd77SAXTM8+D+oEWCWsdrROY4+qlSaniToaCrfx9cdB4AT8YOMOrOGVJ618hfyLV1IlOT+w6
	8IenqRexo2hMsDDmN27x3/OBF0tJ/4Cw4GbKseXsrakQyTA+Cbv2q4kmrwZJ7YdSk+/ECMc5mQW
	cr+zXuPKZEzI8xKqkD0jdswPgcBn6Jds07VCjU84JhrKBc6jaI89EbrMR+zYEcQ2Xm+Zoh15aSw
	21AkTN7QMXd39kYzQ/HeJXnDlqWrmN55roTVptx6dXQWgIPN1HZrXiPlJj2ENOyNvxG+WvqG0oB
	LoNSOKsVjaDpmme+JxUmc3PdlvwslNHz1SgNQHncYKHqvz479qTVZZMuT1f2GJcNXRZCzg7CGkD
	mCK+Q==
X-Received: by 2002:a05:7300:5353:b0:2ab:f490:79f9 with SMTP id 5a478bee46e88-2b6b35a1060mr8727080eec.21.1768787177749;
        Sun, 18 Jan 2026 17:46:17 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a7bsm10870916eec.19.2026.01.18.17.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:46:17 -0800 (PST)
Date: Sun, 18 Jan 2026 17:46:16 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
Message-ID: <aW2M6DZn8lhy7H3G@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-16-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-16-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a new parameter `lease` to NetDrvContEnv that sets up queue leasing
> in the env.
> 
> The NETIF also has some ethtool parameters changed to support memory
> provider tests. This is needed in NetDrvContEnv rather than individual
> test cases since the cleanup to restore NETIF can't be done, until the
> netns in the env is gone.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

