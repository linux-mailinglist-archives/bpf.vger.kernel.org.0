Return-Path: <bpf+bounces-22971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A186BC82
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C23AB2465F
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9C77E5;
	Thu, 29 Feb 2024 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7HoO3m+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7C160
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165188; cv=none; b=Az4hVo60U4juBF94n3GveZB7eTGLTeJ8y0hXW0GcaotSm3UoXzpQY0QUV3tO8hPlwGV52jUewWzEIUQltgry6zvGqCd4zb0l4tX6QFyWwu23wQxXWpKT4fMb7noSJ9/BvZXCkweqJmcECJNoXHQkcJaud+mjeHjpNx9pqGmzYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165188; c=relaxed/simple;
	bh=1xWHLLvuiRcHRE8DYeyR12IHd4Epz5HzGAB+SVFH4RM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAYdMvomtYcOWPUAXvIh3l6a7cDBic9zoUmr1N6PyYF9/Ox6ruiqv1Di3F1wCo80avVIQxTMtlIp9NnYokbP2YqpCyu0Md9vMnnrww6qHu1zn1u7Bufc1tkXx3MTEnSLWrnzSAYK6IxsJ+XNVhugetb0js8YZu6Vo27pdZ8BXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7HoO3m+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51320ca689aso302364e87.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709165185; x=1709769985; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xWHLLvuiRcHRE8DYeyR12IHd4Epz5HzGAB+SVFH4RM=;
        b=Y7HoO3m+gcr+JWEbcn4UiQp2b5w5KiKJaVqe4B3i9C8qGGoiNOVd3fsggoOsJwF/kn
         q+TvyacO/xmK0Ye1ZOmUQ5kFbtRqYJXTEBP0f2MHFRC+KaQT3XbcR4ZsSfUhimJi2cNX
         X6izDjlix4mPb4zGOv5tU4iIIvsDvMy1wXfr65va+66fG2y4MX2J17Sa9Jbv+QnGHBI6
         MK3ZLWRltIe61TedcwK4vUyAuN3CvAMEVUaUpUnYdUruMnElebRsxXQaczRzj/yz94z/
         Fexvl7ytDxu4cv0WBPX4q7sFDc8mcqhu6k2yyMXhQ6XWqdsS8WOmBLiET+uFdKQQbAH1
         svRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165185; x=1709769985;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xWHLLvuiRcHRE8DYeyR12IHd4Epz5HzGAB+SVFH4RM=;
        b=qAhm7RjkfA6l0ELvvUDAC+1JwKMjj07FmaXf9WmV7g/yujygPmx5qV3EFxwgQ+wtGy
         anQ/GuXPsEuKaqXydaKB0Svqy+b+1WI8JqSEVjczE9T8HyllE87PRC/HRmSvrIzw79yp
         42TUwHBg/k+tWqPaPtHg+suf5px+c3sHxQfPdlT1WPuWaJoMMLgZKTRY7h8Z5hc+f3vs
         80yyomU9e8o4p77wS/qGLTS2CYI/DB/3S6dmwVPDVJ81p+OAsIHkDG8IWXNwQZcqRNLo
         2C8uIqDbrlsTSI/Dg+5TscFL6bnCFoaIYN31f6H0hQY1sPLTcYSE81s2juYnKoHHpKsc
         ow8g==
X-Gm-Message-State: AOJu0YzeJqh45PTJPC/l482j9/buRFN73p+5F/hP2P54uif8WUsZFRHt
	pATfUprkl7gpG/wbC58Tcqy0AsE007Eo1yetfesxsXg3JwQK4K5d
X-Google-Smtp-Source: AGHT+IHaJo9KqBs0SijQsCBd3KmlkIGYbyev0RWwyZtGVWFE9Y6h0CjLm3SUdHIKuzJ4nn1TwRkFZQ==
X-Received: by 2002:ac2:456a:0:b0:512:d907:3161 with SMTP id k10-20020ac2456a000000b00512d9073161mr249873lfm.66.1709165185317;
        Wed, 28 Feb 2024 16:06:25 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t1-20020a19ad01000000b0051325c703ccsm7468lfc.77.2024.02.28.16.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:06:24 -0800 (PST)
Message-ID: <06c3ea3af4992ba5ebb5c7cb7066ca031945a44e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: bad_struct_ops test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com
Date: Thu, 29 Feb 2024 02:06:18 +0200
In-Reply-To: <CAEf4BzZfPnWr-=q_9kSxsow4XdHeEXg__k3tPrwLfck9jn_p=A@mail.gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-6-eddyz87@gmail.com>
	 <CAEf4BzaDwpTVwc_wTT74EthE5g11URiysNeuu6V+HDKrWXEnfQ@mail.gmail.com>
	 <81fd7d298578b2bbc3d7a117c8e2144adbd0fb4b.camel@gmail.com>
	 <CAEf4BzZfPnWr-=q_9kSxsow4XdHeEXg__k3tPrwLfck9jn_p=A@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 15:56 -0800, Andrii Nakryiko wrote:
[...]

> each non-serial test runs in its own *process*, there is no
> multi-threading here, so it's fine if non-serial test temporarily
> hijacks print callback, as long as it restores it properly before
> finishing

I missed this detail, thanks.

