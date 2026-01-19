Return-Path: <bpf+bounces-79389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9C8D39C09
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDB313002D3E
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E9212D7C;
	Mon, 19 Jan 2026 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkLpbSPG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81E205E26
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787082; cv=none; b=r7NqtWlKpB/v0p7TIxnbcT47TU7UJIQKMRrCGyeMFl3y479nkkO+q1vjLIfGPcyjwo6U+oYOJMk3vWY5QtL8NT9N0DYxbPoeVgiM/8CPnORVg+HFtZui1srILlAXdZ8+ZP5v3J+WPfFDuyLiBbh1B35fl6BoqeDRKg69BM67X98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787082; c=relaxed/simple;
	bh=imMIwrXigzI5vwbukz8WWxz2ySwfpRZI8TdfhUe9VeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXNKdAK5H3zgAh7CQCz9I5Gwgm1pMvVO0mG22h8xssfozSCJU8Wp0/Ni7CJCtnUviV4uQWTzWgwTl9JqQ+JKMIxHYD6H0uMT4Eyfu5u0nIAYWtttQOQZwUflbO4SADfDRvQo3rOEi08NFpxXK7kzhURn4LLPRCHtFBJs8HwUqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkLpbSPG; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b453b17e41so2490126eec.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787080; x=1769391880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3th0y0cIznxHYM7wgGa8mBjjcrfa760dKMtxGCo2pgA=;
        b=AkLpbSPG8XltAouD4xqG6o4l2ur/0jQUDpokh2GJn1OyZ2/6CqWi+/0hCQvaKULX6d
         3gsseOJD9ZXe7KyJ/bNo8zJzAMTlLvJC+mmxZzkND1zUb+0xEdJodFm9uDxFJwSCwJrK
         PPP/4dMCw0u3be6nlM5UNXM4zJYtbCrUBsWopdL9DG/uxdUf8ChmX5JfHUNs5VhrV1GX
         dZ6Wg4X9aHv1zotaoy/Z8UKCcClzQjqQDediZ8L/dgCyCtsjO599g55/IAxpZAPPDXO4
         N7vAUuVXh4xt00OeUh/CfDrKqBsHAhNWy1brYXb0e2vKSE/wXqP/ztZLbvnvLnc51n7u
         fZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787080; x=1769391880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3th0y0cIznxHYM7wgGa8mBjjcrfa760dKMtxGCo2pgA=;
        b=vbzaMqmj+f83lR0sSxLGvuaxVKCKVot5i3BWTdjqYP6aVgzGhyHq7FZAWTjJP3BZ2S
         wIEEY60pfIGXWNlKC4oDZlYx1M6AGkou065ku75z45kLfyLWyme1YdnakwENYBRpxTAi
         gYZGDlu2F36tacmVxmuUTfDgSCfEO4aKMX5h0EcOh3EvhIsF8G52JmVildDAg20oLg3e
         tt2ce8UPDclt7Y4QJnenbC+Den9q6T1zLSRq6Qu8nnyfj6klUUTKnu21LHgynAKjJbR6
         5EHIKoMzwqF1dnkcTBF58ZwFIzqba4n050+WZXa0XmSeltrJgmasxu9ycseLpFczTBpg
         FvUw==
X-Forwarded-Encrypted: i=1; AJvYcCWm4JTevc25MqvTfOOuejEps6rV2cVX0lCVTSmrnZWYhOqsH/3ZkRBwQJi3qHLEb9di3/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv37fYOnmbuA+vVj06PwYVP24eacVeY+pDEo4IsYY9Pm49L7th
	X8DbELuypomJ6Gwzny+pZ5iONkypgZR/S+9riWK+2LIRgh4X1rkiflQ=
X-Gm-Gg: AY/fxX7QHaJyf2DOrl0yeWVgOFk5el+V5869pBGshqMoHuHC7oBm32QkjquNAp8jhOS
	N7Z6CwWNvkl8KhBX6LVXBfXmu/4eZyFUUcyy5vQgmhSO3kDU/KB2CmSR88lYSTi1KKtFZ09GyMx
	w4yPQUggEKnDnyi0LB8PH5Brt6g6jF1nQ9/56+ByqaiAV8Na6KU/DrnnOuOCEoCM4gW1lVFjuuP
	tx+3rkpop/vEcFVpE4J1SqvM1TLJTi8rmC1iZxGdubeRVUK8i4vnTeoM1g+gpn/tEzS1qZwpIBC
	GTkbsI6ByhH38bsGUmdO+YgXn+el+GqVI/h6NR/YMhUgh4OL5S5G26z4bVX9Kb32Iktdc/ByVqz
	ihsbdiU+Mz6zTAOrhkJIXloopMSUNC8vxmaebw8g1bK3F8spANiFrmhMnN1crWwcK3/F5+Pmd5c
	WyVbTJ0HkPxs5+7xSk/g786Xu+2eR6E+Kli2AndJpH3ITwwv4caRyebUbz9fAwo43Ik5txVXGna
	MnDxA==
X-Received: by 2002:a05:7301:9e43:b0:2ae:56ef:c85d with SMTP id 5a478bee46e88-2b6b34b2b47mr6917311eec.9.1768787079909;
        Sun, 18 Jan 2026 17:44:39 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6bd8e7cd9sm10075828eec.16.2026.01.18.17.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:44:39 -0800 (PST)
Date: Sun, 18 Jan 2026 17:44:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 04/16] net, ethtool: Disallow leased real
 rxqs to be resized
Message-ID: <aW2MhiZrE8MU0CCC@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-5-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Similar to AF_XDP, do not allow queues in a physical netdev to be
> resized by ethtool -L when they are leased.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

