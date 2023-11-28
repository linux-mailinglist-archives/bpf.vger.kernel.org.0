Return-Path: <bpf+bounces-16016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74427FAF7D
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 02:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DC6281B66
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 01:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BC1852;
	Tue, 28 Nov 2023 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPufXj2S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE10E6
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 17:23:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a02ba1f500fso702420566b.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 17:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701134594; x=1701739394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJaGsnOUlNC+YxZW3Te9LmaiyYsySgUr7OhEEYLIeSw=;
        b=HPufXj2SusZsdvC4dz1TU/tQKX6ibNYOepE8HYTdcdUEWkEwP3L+KU9twpfBtMoGUJ
         MlgcmDE4V5Ds1iG41dm7++tDeuBYvCDs8A97BngGwta0GiqiGGwNOXI91StULc2Alqkg
         7NZx4/YSBVeYL/V/nGdGokZ4YMk4MHJp6ZXCQfcVQhZpcaCFuSM900ocNxlvKeiKGVqK
         Rj5vyzvYxs+cuLGY1gxMitVjzTKeS7S2pEGtuyXOWrKDlbQ3w+8r+RI6OOMIadoObEZM
         71W0IAZHAiubT1m0WEyQzTZ468NALfkNsOA9z7AtVDS/Gix9jZWa5MJ6E8oxaUxDBCtD
         qyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701134594; x=1701739394;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJaGsnOUlNC+YxZW3Te9LmaiyYsySgUr7OhEEYLIeSw=;
        b=aUEaeJJ93VJjlp1UKyU2zDRi8Nd2DwQ2qlsBPJcLOI2Et5TFwTtvrNOQJ7aVYSc/3L
         Y8Ec4K7DlK9M2hS98fqTxsrWR20rlZQpIMdaEDzdoeGI6ivhssgv7wHG/RDJczBZkeOb
         reYbYOtv1HiwXgaP+3mfT4xyCLacghCcGyecpEWd8W+uRSVpGcrNpDt3YGiinKNCA78w
         rHQoVbD7IDYs0N6R7mod4u44DszXFbND3DsLJSL0FxK8xddutEjQuui6YruDKTtikxDW
         I2BMv5ec1JKJKjld/d+reR99MQvBiPwyU5YvtZuLc5hNtEdwNp2Plp0BKzcxBhk9/DSI
         croQ==
X-Gm-Message-State: AOJu0YwCVSb/mptmMIyxs1jMRzmAQsgHHDon4ct6xv+VIHaCOI2iCnVm
	VkKMkFA8xJy+POJQC/HzI1o=
X-Google-Smtp-Source: AGHT+IHe6c3NK9x8ZyHrIuANzrfE2ZtlOqDaLC2zWOp0K5qd0aV988nQWLRlHs4eBs/K6TE16JH+zg==
X-Received: by 2002:a17:906:6d48:b0:a00:4866:4f90 with SMTP id a8-20020a1709066d4800b00a0048664f90mr10546677ejt.22.1701134593448;
        Mon, 27 Nov 2023 17:23:13 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bk21-20020a170906b0d500b00a0451802b3csm6233776ejb.4.2023.11.27.17.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 17:23:12 -0800 (PST)
Message-ID: <de2946da3720afdde07aadcda1992e3f877cca70.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: new verifier tests for stack access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com, kernel-team@dataexmachina.dev
Date: Tue, 28 Nov 2023 03:23:11 +0200
In-Reply-To: <20231126015045.1092826-3-andreimatei1@gmail.com>
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
	 <20231126015045.1092826-3-andreimatei1@gmail.com>
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

On Sat, 2023-11-25 at 20:50 -0500, Andrei Matei wrote:
> This patch adds tests for the previous patch, checking the tracking of
> the maximum stack size and checking that accesses to uninit stack memory
> are allowed.
>=20
> They are a separate patch for review purposes; whoever merges them can
> consider squashing.
>=20
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---

I think the strategy now is to add new tests using inline assembly,
e.g. as a part of verifier_* tests in test_progs.

