Return-Path: <bpf+bounces-78969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDDCD21A70
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 23:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31C3B301F004
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51538F24D;
	Wed, 14 Jan 2026 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH+Z8ZVO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D637F735
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430928; cv=none; b=SM1tI8aKIX7fkgbGU3HQwaCAmBrknrhdr3W4SGVUHumf77wEdpacp8UFqL3u8vFAJgnIKgWTV8SK6rYR/IHiiV6idPdD3vvgr+305JhK8DYzLkdAhpqYVu/3VLEJX/T4sutHUP0un9SBV7AXDUNSI6talguKo8glI6n2V93r/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430928; c=relaxed/simple;
	bh=7WsxJU7FKkp41RYPPQz3X32Ge44pP2VLnRmModcDNf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAgpcCueSSwGQ9fJd+c0zG0nfkDBnUBTQeh292/7kFkRzqgjOLB5RNmy/HRUTH70BF0e3RlIa96jPQuHECMrZ84Rr+YEORm/Xfnkcm/dMz4XpE6mepyVUmDEYmSM7icfVLkEhb9ZM2TLxB10qFzV+qK1a8Sb+i5btE4VN6h7Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH+Z8ZVO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4f822b2df7aso4387431cf.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768430919; x=1769035719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLgCsqyyIABS0s1NbINga0N29+Yya9EPm6l3UVkUqlk=;
        b=SH+Z8ZVO+gEYiRbW/DFwsTu4HC1Pyo6i3OlR/UASdP0xdZ+hX9WUh97uHGoS+7y6U6
         K+lU2FpbQ2Q9XEz8CxBYQu8UJ4jXRVkBV1iTleqPRB162CMSG4xk2lmKOdIG+Rs3i7an
         UcZSKA8XrsKQJKxFBc5xTnkaZiErufMwI8zS7U9wKG+23KjyVKaUEUbYXkeIiXlNJXtJ
         WP02Dosly5AMFyG1uijWKppaeqrPj9uIOWILppG24w+DeUCiyTBp7Y8HOLaWrvMLv0PB
         l8Dk/IhupwoS7c2EUAAC1TwtJCupEPjnMJIVDB0loyROC+5AF8QWM1u3joM840OOVIbk
         WAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768430919; x=1769035719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLgCsqyyIABS0s1NbINga0N29+Yya9EPm6l3UVkUqlk=;
        b=bfC0IKBqJD6u9tUbXM6thvVArfNZHDb5rVpFLEFHoTl/9onk5+0Iaigzvgr+IXtEqy
         WnecJKPScsbpbof7oxONbIJWlU5Gjaz4pmgUFRNTpOssS9ftDkgJBPzV8bOnIY1MQNOP
         VRLh9gmawgXk2d6Iw7HngKFTZvuT6Dp/Mps7YzRDg+Eq/8FFyRSvUYadm0KkKQqZcSX3
         083rF4vyxq0HxAa+cjMoPDdgf2S1anaQE7JNOlhxrMz+ULxIilgqT701VgE2azBl3/Cp
         ZfQwGgW9+qRiyHpJIFOLl1UYeqXpzNxIb6c8yZyYjKYABUV7JVANOP3JdRjpSiPrAvmh
         dfDA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2kCjNsP3qoOdPrg2k8EHJmv1JG81xCP9v6M+/jvmnne+RC2KD4KBgQePdU2psx49Bxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz929t1i2wAuC+ienzvBwHG/QLum8z5/AgCPPws2OMhK9mJriK2
	QzMdEsYQlOk65NVMO6TSsgC2DzCX6CFLKQnewgVAO8x5fZhO0W7oLSMrIunN
X-Gm-Gg: AY/fxX5WO5C2a2S3GQaAjd9rDz8sf62WZ9b3wjXQEhbEeKvUKjB4309hs/lMdZAfTwS
	dWPtaV2z9BrTveAX0EjnXGAMSi/0wMJsaGPC1gvn+LOE4GFf4nbO7AMxVzJ4QkhWl1C/qU+GlOH
	q6vHLuVz5cdBxYPdNipBvcb1TC31TCSzeZIBcmi5KMSuyiop5V6+3iOZuqdL4PDTvrvmcmPIYQ5
	Zq1LrSL3YoNd+1Rhsf36Iw3nM9GhS3Qiya1yJCQbmwMr3JM3yNjqXUylIigaaG5LcETaK8GwO4t
	cq1rJASbSbaFhEnmGgeNzIIgM49rzQKAs0om8OqQL0Ko7HXGqYjaB6ItmAG22G0Kh5wRQhZ/U/d
	e+yT9s3JMFbBSrci28eXwmtkFu5/pHkObi0GTinRUVecgDkI5eGANWtTzdeoLMEmzhJBuJIFyaP
	4VHrIAbpciTaw/+bruN1GNdFMrDe0K/E/WSgl4n8n1WOOcWYOmTBJYdku+JgCiAoQ3W66gJg3ZU
	dzlpQ==
X-Received: by 2002:a05:7022:1582:b0:123:34e8:ae8e with SMTP id a92af1059eb24-12336ae5ca6mr4266670c88.50.1768424199264;
        Wed, 14 Jan 2026 12:56:39 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c246sm32065044c88.11.2026.01.14.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 12:56:38 -0800 (PST)
Date: Wed, 14 Jan 2026 12:56:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6 0/2] xsk: move cq_cached_prod_lock
Message-ID: <aWgDBtepjbGNSA0z@mini-arch>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260104012125.44003-1-kerneljasonxing@gmail.com>

On 01/04, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Move cq_cached_prod_lock to avoid touching new cacheline.
> 
> ---
> V6
> Link: https://lore.kernel.org/all/20251216025047.67553-1-kerneljasonxing@gmail.com/
> 1. only rebase

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

