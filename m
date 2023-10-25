Return-Path: <bpf+bounces-13254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F857D7131
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 17:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 375D3B212AF
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3BA2C86F;
	Wed, 25 Oct 2023 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y8EYVDDV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD74C8EA
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 15:50:13 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912F9131
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 08:50:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c603e2354fso224647966b.1
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698249010; x=1698853810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MiKqut7+IsASAtGwUDnXgixBgwt88ppzipe0x3p3MR0=;
        b=y8EYVDDVGxiWHskMGcewLVxiZlbzMf6Vk0YzBPj6GujS/Y/o6dWUDsx5mJRErZy7Eg
         Ry6dcZRREA4hUPFERfNGU24Cnh14uW4M8/69Nk4cF7jQXBrTp8qd/lmKlZuoCVf8/xDn
         kM23EJu3Q49Qds9/Ry6YVKnTHOCCGXHecIG47iopVbvH0ABUyRQSUxnxoNofOx/HaFTf
         pq3xv0FOwTkbAck2w+s9dAy7HlPt3yBiognD55IvLkR9GSMZpHULGc/r4fRbRJjLv3yY
         ysQhPTFCRTLnnTG7vh21XBtpSEZJTJpPXLZP6/N6Zo0DR8hu0Swhh96XSPwi57JEP8rm
         f9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698249010; x=1698853810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiKqut7+IsASAtGwUDnXgixBgwt88ppzipe0x3p3MR0=;
        b=jvo0YEgAte2yo0NNH9hDZA9WgVHo30whZP2xb5agsfrjz15HblZ7moKOO4lcpiBrvT
         AyHCBjXgnWtYPar97UUCNH3P40Hiau2IXthgAOi8bc7KVzXIOtBWjKrqTwOr0qdNH64I
         vFuvrlDC5CscFF7soWW131gYhbsYQsZW7L5hV9JVihjAv/jUzPA639vKsuivpj5E2BH3
         DBzxiLYeDvkYvITGntLboXs0+o7pRJU1Meh88AHFah2IYEoaiH8FS+IVwcjfK1UVH4xu
         hVBUG17n1P0ROa6N6MF4QnAmQffq3aDIsPIqBTbhvfAoFuJG7rNZVLNacxwdhbRLTMXF
         8Brw==
X-Gm-Message-State: AOJu0YyO963gE0muzB1KfXYxSKiPf76T+XETAjAVA4Au5VHa3Eqj9DrT
	PM+UCjFS+9wIAEOwGywv4qhIHg==
X-Google-Smtp-Source: AGHT+IEQ/EBlw+L3cEuQpSqoisp8yAS9SumcZuKD4L6epJb5/jJrL/zZghDkkoCnipYff2Cuu8bWtQ==
X-Received: by 2002:a17:907:3f21:b0:9c8:5b61:7bd7 with SMTP id hq33-20020a1709073f2100b009c85b617bd7mr53172ejc.22.1698249009977;
        Wed, 25 Oct 2023 08:50:09 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k2-20020a1709067ac200b0099bcf1c07c6sm10219783ejo.138.2023.10.25.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:50:09 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:50:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
	ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
	sdf@google.com, toke@kernel.org, kuba@kernel.org, andrew@lunn.ch
Subject: Re: [PATCH bpf-next v4 0/7] Add bpf programmable net device
Message-ID: <ZTk5MErTKAK96nO3@nanopsycho>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <169819142514.13417.3415333680978363345.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169819142514.13417.3415333680978363345.git-patchwork-notify@kernel.org>

Wed, Oct 25, 2023 at 01:50:25AM CEST, patchwork-bot+netdevbpf@kernel.org wrote:
>Hello:
>
>This series was applied to bpf/bpf-next.git (master)
>by Martin KaFai Lau <martin.lau@kernel.org>:

Interesting, applied within 2 hours after send. You bpf people don't
care about some 24h timeout?

[..]

