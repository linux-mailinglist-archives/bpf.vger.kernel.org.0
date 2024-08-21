Return-Path: <bpf+bounces-37743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A195A320
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59071F242CE
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2BB199FD6;
	Wed, 21 Aug 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hanbpWg9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C33F52F6F
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258821; cv=none; b=ZtHxENKhKGvoBdqTLt2W5AlR1fftIeJHBMsPHuGZOdlOjnn08lnuf76b9FrnMZ0t21BcDFG4Yq1HzV6bG6TcvHrPtzT3vCX24lRDVVo3I4I55xKkyJZ54ZhOTLA61VodvHwmnc1SIeLDG7cwbQbFwypmo+QuYIl+eRo4BWxT5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258821; c=relaxed/simple;
	bh=f+vuucxLAED5W3z/rb9SlKuMT45vcRMYwbh+kcs8IAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLPDb1DdQfTGfsp2YXcG2BilATA5tX2TmFJLqLDc82/O2ny2sgKgBnkN1bqI0FL3wTUVWCyHoxtrm4Ruru5rbWind+j41JuU0ZUbohjUM8mON58JeHT7QiAUTJlUiEj+bi7fggBmrUh77x/7Ge2xjeKAcTcwVtZphduQUFYpCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hanbpWg9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724258817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f+vuucxLAED5W3z/rb9SlKuMT45vcRMYwbh+kcs8IAo=;
	b=hanbpWg9HJyoQIiDKZl/8ZLumfKONEskHx/bH/s28Wi5rKgd4WAfUrN8JdAiYGamq2iz9+
	+mDKQssLJ8jiwjdgG/XYN0/25yofcC2BiLPaifHtgboa1Y7ncx1EAC7jcYE/e5/BFDk+D/
	6dfGA8elyeN603M1p+d5dcWZSiqe+6U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-sTaej5e5PJud3F8lRCUQtg-1; Wed, 21 Aug 2024 12:46:56 -0400
X-MC-Unique: sTaej5e5PJud3F8lRCUQtg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4282164fcbcso60029735e9.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 09:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258815; x=1724863615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+vuucxLAED5W3z/rb9SlKuMT45vcRMYwbh+kcs8IAo=;
        b=ac6PVdqEzx2mZHIGOZdFJhiDG+b+dzQdHp+m7xHouEgw5CY4JiVg4Prp1LFnXzPXQJ
         STbyhJsTrR109mzPtIfP7J+lb4aGtmOQvLgyHy3a00CtQvSg/dXJLqSEXSh0y2RnRZvq
         D5XOCGflTbD7YOePHAZrC8jH9HlM5SzWivcUA6p+k0PE61pRJH5jB8IRyVe8B5A1SzMB
         6fPPSKb7YT7r24LPoPLBu3nRQRY69w6PHmYPXRah4jlzPgUwOKr7R4xVke8JeIzHo/pj
         GsZjdFSvBtqFRufk3P66CE470MN1y0XxIQzm5ZRRNNsjNMOR9e7h75qs8Mz/BuczwHPp
         9odA==
X-Forwarded-Encrypted: i=1; AJvYcCX+TtUrVJKJZS+FjZHjxi44hC0pXNtdfLbJCT8CAPAqxVtxl0yaSeS9xGd5tIVDs2z7tEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgrGHH66ts1mFWKqeMte44Z6SbmuWkgUKp2ImHALYT/i4pQMD
	oHxZ+rS2GoSvYpj0uQJbvsEf1jJ/R7fjtdiwne77U9oU9AU1LaO9CUQXu47cidihbvBoHgOkLD9
	X4rIsgwpZCoi436SlHWeffXfbedfpYpn1KrmGfwjmuj3fsEGajbncRMSETxSt
X-Received: by 2002:a05:600c:4e93:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-42abd21f736mr22608155e9.21.1724258814890;
        Wed, 21 Aug 2024 09:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+7ndXO7p17x6jiJjkerLBS07RQUf5DqDJRNUzQnYm9da6dNkYwy11xXsLMYPR7RQfvAw24A==
X-Received: by 2002:a05:600c:4e93:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-42abd21f736mr22607695e9.21.1724258814073;
        Wed, 21 Aug 2024 09:46:54 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897128sm16122725f8f.81.2024.08.21.09.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:46:53 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:46:51 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 11/12] ipv4: udp: Unmask upper DSCP bits during
 early demux
Message-ID: <ZsYZ+1PsNUMcT9Bp@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-12-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-12-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:50PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when performing source validation for
> multicast packets during early demux. In the future, this will allow us
> to perform the FIB lookup which is performed as part of source
> validation according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


