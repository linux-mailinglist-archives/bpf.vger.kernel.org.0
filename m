Return-Path: <bpf+bounces-66527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C62B3567C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 10:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A21120092B
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE5D2F7453;
	Tue, 26 Aug 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVuMTRfv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426922F7443
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196055; cv=none; b=FGRRkGQh1NCoGymPxoGtcQ05rMxxWGfIiqvUzqrSA8FT3rXuAE2z9i5uTi+OnjcteiZ2NoVuzbasf3yfBAotJvf50X+pvOh+UuMIpFbioPVTSfpSLTdoO9HxK/mtNaZ74Nre+/O5LMMS6sW94cbrtJdlOhnehpX+wXEo6HzAiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196055; c=relaxed/simple;
	bh=h9u7C3pqJnM4zMdMnReRGZ/HSmB+17GO3ew7kK7JkGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqfwff1yxgvIGRlJ/sQUgICWDI/fbe3SMkaByU7SGlAxF04HJ0zf0/4i0nnlK1b4x+lNv+VuNzk74ecIMHLBCryUj3bkM6ENB1ufm9eTiCSnSSVXmcAHiuDSksu7/3o2BV13W7YMHeQiyWcqg9wKQ1eie41Iold6hk7EmoXx/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVuMTRfv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so43466375e9.3
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 01:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756196051; x=1756800851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htJocjFCbY0wQ75QkTSmsj/N5xHgBbkFNdLz93b0Td0=;
        b=bVuMTRfvNT6Nd/XoPZDgckoqxjbbpew+NVXLtXdZQtL8tDZcMf67niLfrMFEdzBIPv
         Jw+vL79zNlvW3QSxbwGf65HfhVRbhS9KuOi+6AlJrEgBerEJqfKTDcmsPvf4WgRzBnEh
         YDMcx3xqAhFBxt8nJQWqI5BRQLRAw2Brd2HAfNIkMQmOuTICknMY0NDYXNPfzGguGhoo
         6zHduYFlfw67yd6D0bCD+g6GdnaDBQIePWFOAiDD4FhU9ctet1iDGQLvsTmU4QgZ6I1i
         XBuwrh1HYHvh9zEuVuj8i1x5t13IRaAicmNi2m3U3ogjiG3wXzVFr6UqM+y94oo2jO5U
         Ac6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196051; x=1756800851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htJocjFCbY0wQ75QkTSmsj/N5xHgBbkFNdLz93b0Td0=;
        b=JRnoeYHVB3IfavA5jTe8BMdAyX+53fNnQbK3OzPo3QMiKZHusjGGigfNYYv0wWI0Vl
         1lVWKae2Rd7+RtBfhjK7Sx3rKng2vYOMqyT7a4h08+Yw4kX+9yagil4T7YbbzpTtukub
         VAFsNXRvVfy+ANw2IJ53eIqFSL+AAWJerOa77VElmxv5n0zUf4t/t2W+i3cOcHe4nXrO
         nxtqr8wtZ7hvIg4pDB8rSUvXKjjf4euoSTss5GoouAB6zV+bF/qGH2er0bKcLwAfeFkj
         xk854/SpFNOXY/N3voP7Oluo7VS6FgGNJ26VFCoglfuCueEgMaFHDUfxNcn7uEvyJKy0
         +45w==
X-Gm-Message-State: AOJu0YzPqSrnEbvLMGgtE+AGp7Oo12fujUzZZGr+vMVTyBAvzBJhIYna
	y8ZOov29HpB3M21yOdup8wFV4BM82XndeAHm4sRO/GRz2RNqbXB8XFTYWkD3NCyPvlk=
X-Gm-Gg: ASbGncvcjA1PdJ+Xw0Y80n+Yre5+1RiX3FcDpF5/kFMuLKHCpbwDKF4Ep4VfWyQhCyi
	pBkvaxx3UuEeaqKrxhU6Bs/kRPy7gunWXY+3z1K+jXQo/8nH9HQsIv+ob5Wb7DoC7L/OH0veUZU
	kkSzMhU1mDwuCqOW+oxERDepoBjP0XpAx0Rm7oRqHCVRFAMTN57yBjbvG68o5bi7r8bsuHKK/mm
	GYIUDRbWQ70K1aeTWhsUL+ifUV8l93yJ0mAyjwROcT4a1VII+i61RPskwJRZkhnwDAqBHjuuwk3
	+3FaRQBPdgSfGGxFhaINQ7QcIEU6AQaClv2CVx/2p/xx00csRSKTD45FtqEj9/jGLkSVHrB1gha
	v12dftwsjy2HSLSyrTh7dHPZTaxk=
X-Google-Smtp-Source: AGHT+IEbKxCrV/crYXvaOYg+DOzSnDljX8XhhperEq+dcEo354TQCGi1v3zOaG9kMQNx5o6N4Me2oQ==
X-Received: by 2002:a5d:5f8e:0:b0:3c8:443:4066 with SMTP id ffacd0b85a97d-3c804434575mr6485502f8f.61.1756196051410;
        Tue, 26 Aug 2025 01:14:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ca8f2811d9sm4480136f8f.20.2025.08.26.01.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:14:10 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:14:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, stfomichev@gmail.com,
	aleksander.lobakin@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
Message-ID: <aK1sz42QLX42u6Eo@stanley.mountain>
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>

On Wed, Aug 20, 2025 at 05:44:16PM +0200, Maciej Fijalkowski wrote:
>  			return ERR_PTR(err);
>  
>  		skb_reserve(skb, hr);
> +
> +		addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> +		if (!addrs) {
> +			kfree(skb);

This needs to be kfree_skb(skb);

regards,
dan carpenter

> +			return ERR_PTR(-ENOMEM);
> +		}
> +
> +		xsk_set_destructor_arg(skb, addrs);
>  	}
>  
>  	addr = desc->addr;

