Return-Path: <bpf+bounces-15658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B27F49F6
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B4AB20DD9
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210004C3D6;
	Wed, 22 Nov 2023 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asBXh0Vu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA019E
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:12:50 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c871890c12so62490141fa.2
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700665969; x=1701270769; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=neNptG4eNYDtPzQRd7toLTzIZq5iWECPXun6CS5Wp4U=;
        b=asBXh0VuB9/El/XN0IVS1GgK/OipKGSvSC8rBUrJTMZEc+GcqdRuuTw3erEc7G5HM7
         SZcChVYAoX1JX6qwdWdQD4o/Joc+EDYW7KzhEi3g4J5IT/+kqOjFu74lO/OxL7MIBMSF
         kIthFft+mYUzK0VhlQ8FYi7Z81dF+9KEvJRQWyQcdDp14FqIdKbsAOEzsJZQgLYI3eCM
         APARzw+qYlTHx7gCrDwxfMkaRFsXU/ddZ7Ewck01y+vfmMLAFRCE06VjhSqWFnevCxMg
         IXWr+mJAtu2SYgqjhe4587AdjeKjol7FOAqOAWe1Tg2DnAsCi0q9WF08loi/SBdbpGw2
         YNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665969; x=1701270769;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neNptG4eNYDtPzQRd7toLTzIZq5iWECPXun6CS5Wp4U=;
        b=NoQzHln6dOoN9vfT3yHHbHRcvCdL8IHjGX2kfoeSTIy9p50Z5AnVq970oEc4bXo5n+
         p+TzNpb3+FGe8xrVrbGjxIjgnhbPg9vL0vmPPn0dwCl6zvmWJYLOQFwArHr8h1+lWqfH
         i6shH6pGkAKE2SgeStT3o676e2qLNELoZidAIO8MwaHTwmJDDj5DIzLetmzNfsr83f67
         4O+KqUbKumMqPPd22FaCM9mLcfGQZE+zJic/OPQFq3nrQUh0IxjDxaojSujrCD2hfOCY
         Ad4iK/3Z55SIxs8+kxD78ERbmI43QzCiXjIyw3T//fYN6ZuX8NMe831IUkaNorTwbd09
         H3kg==
X-Gm-Message-State: AOJu0Ywna5d34RlC5LQrtCUOoLoS4rGdYzeDxEHCaGIYd/+xkeG5teCT
	xzUQxMdkHsCZZC0PUj/79X7cH9IT+lo=
X-Google-Smtp-Source: AGHT+IFNrafUdMxF716YWXSuiKiKsbQ1dvKGwFHnBVgcwL6ZUFJkd+s8cyJdsqMMuYcYeFRyKHYRdw==
X-Received: by 2002:a05:651c:19a4:b0:2c8:3888:bbb2 with SMTP id bx36-20020a05651c19a400b002c83888bbb2mr2129045ljb.38.1700665968784;
        Wed, 22 Nov 2023 07:12:48 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b4-20020a2e9884000000b002c27cd20711sm1570418ljj.3.2023.11.22.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:12:48 -0800 (PST)
Message-ID: <b45d944e09b98584f9844242904e4aec537b5491.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/10] bpf: rearrange bpf_func_state fields to
 save a bit of memory
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 22 Nov 2023 17:12:47 +0200
In-Reply-To: <20231122011656.1105943-2-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
	 <20231122011656.1105943-2-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> It's a trivial rearrangement saving 8 bytes. We have 4 bytes of padding
> at the end which can be filled with another field without increasing
> struct bpf_func_state.
>=20
[...]
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]



