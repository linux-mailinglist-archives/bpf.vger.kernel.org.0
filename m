Return-Path: <bpf+bounces-30834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E868D35B3
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77F9282AEA
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785CA1802DD;
	Wed, 29 May 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft/nY9Uu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0E13DDB1;
	Wed, 29 May 2024 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982757; cv=none; b=tnTkWp4PSc6ucZT6FnyCjj43HqrRfKRUIjMxK4lI3uajPHz0CaTFhgG9nb1KMgbeDZGKFWSbdzDy5K63axROB88SaELszW6Vvc5reb8T/RqWfAgwx+EReqHPDN3W9yea2nZTBQyGdlGJ1TMlby5h7eGCNiGLQ1cHas9MyxpLG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982757; c=relaxed/simple;
	bh=ABNoG0fHjxK7+Y4VtVxmK4PT7HekVb+DSJ6wavwbP0c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amKHvUriEYW6I4DLE9hFir1KLRBzgSxGiCVeGj4Sj8LsgqcLxd7KwS/nVGgV04n9Hnb5ywb5V6+5/7+Hj0qd5DMkulgME0cDZMgc/cBMJlkbeF+PLcZwHNp0BFxNLm0zbV9hflrZC2UUwdPea+ihft3JUdZ3fbEWUzhAB/wJmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft/nY9Uu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42011507a54so4845445e9.0;
        Wed, 29 May 2024 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716982754; x=1717587554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bk03fDdTOYoIQcRERwwO8FkerBoy75MUxyZZ7yDSjco=;
        b=ft/nY9UuxBLkBeStLTjy+s+vQrRnMzKdKWY2px1DGxY9ZumrGW/73wtI8PFsxsXsGj
         rg0DphCOsCMX+X504tg8/XxMrY8sgtnqheOd5/lCHRN7dqjUmqZuKx3JeeD1jo6yA/cv
         jkbMe8eIaz8VrQLI/x3P8uJ/SZE57l659lVTVpI7qVFIXWalTPriVpcjgoNiRIye5P1V
         ycxcwpOqXcAQhxWpX5iMLtRFAxkCv5lr6t71jdwt5+GO6DS3wceUoZkjDzrHdNlZt5MQ
         1tIX//UHuw9v9pG5rtmowO1omGn31aq47DrNCX4BzmGfitd5WN9U9GofU3iBVOYJG2hK
         BhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716982754; x=1717587554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk03fDdTOYoIQcRERwwO8FkerBoy75MUxyZZ7yDSjco=;
        b=F+zGI5crcmmKhv7xUhVYkHN71yT16euCrzXHrqUZRxoUlIIHOP6klbJk74McVgjgl2
         JRsE9anSkkeT9cpHhCorY4jGGgRCdfEWmkLTv5WViaPrbH9UsVYFDKiqk6lewFyJ1jnD
         az6yqqWwuk3gutlA+Zuf+Wef0/91K3F/17xtK2tfBGSQAp4XCKEuavCqJNRpH/J+s6XQ
         IAFf7iw08C270lzokN10erBBUnLfpXKhPTa/GKmFcbiHywpDQDeA+8uOXYrWETrf3Fzm
         bame3i1x5/ZCTbycAWeI+1lXbypBaWpW1UbARmK98TucNtEMFk0KA+12jRwghiVW8C01
         J0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW2SXuqab+2mrfQ9Ja0xo+1SFbFi9rzZBsle4FGc8nx6XoA3X9J7KJRt+T90tno0TE/QY+GVYRENCZrUHZA3yJydkxOo0FwQmz0nBE1i1vQ05XAW4djaBcRXjskvIsxM0DA814ohscLiynHabeijHfrhpgl266aZ8mG
X-Gm-Message-State: AOJu0YzrIgnT7mLV+XQxTC6I0lpBMi77MP2oCpdlNyD2BoPHpfnGXXeP
	aWmPR6dzzC+Yh3GKHvz2TJNByr1Y6tKeLmDCthhRtT1ZXJafgme/
X-Google-Smtp-Source: AGHT+IF6WzHrnFlmNJFIZx83xbCkK3dZou2bN7NunfW2dAuue/OaAdjIKcXvvyVKhoGiq7rxuh5ukw==
X-Received: by 2002:a05:600c:3514:b0:415:ff48:59fc with SMTP id 5b1f17b1804b1-42122ae4462mr14441845e9.8.1716982753497;
        Wed, 29 May 2024 04:39:13 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089cd6f7sm177175905e9.46.2024.05.29.04.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 04:39:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 May 2024 13:39:10 +0200
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf, devmap: Remove unnecessary if check in for loop
Message-ID: <ZlcT3kSfblBDiaTi@krava>
References: <20240529101900.103913-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529101900.103913-2-thorsten.blum@toblux.com>

On Wed, May 29, 2024 at 12:19:01PM +0200, Thorsten Blum wrote:
> The iterator variable dst cannot be NULL and the if check can be
> removed.
> 
> Remove it and fix the following Coccinelle/coccicheck warning reported
> by itnull.cocci:
> 
> 	ERROR: iterator variable bound on line 762 cannot be NULL
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/devmap.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 4e2cdbb5629f..7f3b34452243 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -760,9 +760,6 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
>  		for (i = 0; i < dtab->n_buckets; i++) {
>  			head = dev_map_index_hash(dtab, i);
>  			hlist_for_each_entry_safe(dst, next, head, index_hlist) {
> -				if (!dst)
> -					continue;
> -
>  				if (is_ifindex_excluded(excluded_devices, num_excluded,
>  							dst->dev->ifindex))
>  					continue;
> -- 
> 2.45.1
> 

