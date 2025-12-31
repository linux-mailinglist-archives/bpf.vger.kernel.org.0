Return-Path: <bpf+bounces-77635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39BCEC7DD
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF0AC3009F88
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B902309DC5;
	Wed, 31 Dec 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC4Uqq8H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918252DC35A
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767208924; cv=none; b=gtjKo/ZhfheoQN4rW2WwQJzgaF0JtEfif5nPGmm504TJZUA4EB58RfAseD3xYUfqbTLBPL3GvKyBcWLqtI1KGe9CHr7B9nhgrLkXhKmZuKqIvt2A2LOpvlcTg/gFjioFEQN+77sOfNBJ8vqUAJVFoRn7gEAMuKnbPxnel0PotTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767208924; c=relaxed/simple;
	bh=WJjm+EBt1ojvPsoYr//i9SKy4IIs1JEwR4Ju7klM1ow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eF3GyfJnDx931LZ6k1jwd00dyVCMt7QKN58nmygX3zm+Ad2wZGMF/vFCEOU06Ncew7om7Y0k6ud/2MchRoenSEZxfAD5JJEGDG604qjlnKNPKFbpr42XFg6vlgEoxGTThQZYUGB0ItvwAiedYCXgrldseAn73JWtxFySNoKBRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC4Uqq8H; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34e90f7b49cso8625004a91.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767208923; x=1767813723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WJjm+EBt1ojvPsoYr//i9SKy4IIs1JEwR4Ju7klM1ow=;
        b=SC4Uqq8HCbW2IUiCjk23UW/hgo3C98hmhcS2SkXxwhm9CXn1ryieB2V0wTj5bN2/rT
         tVa1BUkXulMCb2Q4T4LjcJ/7BZMPoLSkAxCeqJlEok+SD/MEzNdWQkK++TJvYw/JPh2L
         foo9nEcAiCnCro21DwbY0bpnkwIEIWTVxA967F5qvwDBfi5IJPeO/5KZmraHZM+oHxvl
         4D7FsmV9uXbmF2TatQz0IE+J+KFsww/4qcDJiBiMJJjrdKZqUjUiT1c03xEK3pICCwE4
         L9t0LLKbeOba0dF5FIKx7vsLmB64C/lBHzWZic42wN7agOwj2ni0k05YocUM0Fb1Vq2r
         TzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767208923; x=1767813723;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJjm+EBt1ojvPsoYr//i9SKy4IIs1JEwR4Ju7klM1ow=;
        b=lGGqfcVaImpkU2DY61fUU4oecLrxzdrehS0kMdxAs7brLQQiZcPBJiNjHTd6iA0NOU
         aCRcmsHG8GFlijXIMt5fcgm7x+fR5pC+ccNDSWPJH/OQLZ10mv3mD3BZjtdijQTmvhy2
         r7BjJVYCgEE2GWm6vLE2Bystqvro1l+veTvQPqGUYh/+rlK5pYN/MX1mgT6dITycGtz+
         YEXLtCnogwqb4xgMNYJuWhQSSA/0An3DDWF0hsoczjb6UJsThmBizg/lgby2BdRW2P14
         hfXNqA/rPJYfi0M5pEj8IQGgV+kmcg2eIuyWNHibPprTfbM6Yym3vHMTSl9bg8ZUM6O+
         EOkg==
X-Forwarded-Encrypted: i=1; AJvYcCVuWCTb3KoEqXHEYenefbhHCBdRsHj+g9Z5j1EVUgZemdet5hq8YFkwA6PPxUQNQjPTqWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykc6xry6BWov7WDiVqCrifxrRWvdSUi9DKSPdU5GSdNdjgsp0e
	hSj3oQHwqh/WckT53p79KoY5J3VgykRoulg6YbGqBVxS5W+7sXUskbhb
X-Gm-Gg: AY/fxX4FV5fwA+98TzECruTPl6kLXxsH4l/QaH9wKpMuVD2eZAmw17DcdfNh6S6L+0p
	Fk1QOLNiLYZfhcyn268LiMeuSkAN/t9r2O8fuc75dIfQhWN0D2bd/t495DFf/FLaEBuaEmowSL9
	SvgG/3bTq/sMW5CaIdIzupv+/d2qdFC9aTK5MNOkFqOh7BzWxf4CT6ZmFP2igoPCAY9iCrc5GSx
	Axq1fty3POf5HEwFReSZYIOaW0alECVtCa2v9bV0LYVpj1mJxSDAlB6IPJpoiuBjSpsVxc/lfQn
	wspFawOFIDxQgz8PFmgAl0tBZjX7s6J7xZAZpYk6HdYylftryiF3/ZGmbuttpAUZKOAspiDTDsm
	xv1UqiGgMJ92jwkaiMPE3jluZQnr9AuVbJmMEvu7GCkM93DIbhghibPwPfeoTdoBfHDc4e3lEGZ
	n5/HY2L6Wh
X-Google-Smtp-Source: AGHT+IGquymufGEH4VAIWjVSceCJEm5YlwQIlYSt/U34W3q2lYsPc3uPUdkE1MQTNpR+wLkiexWO0A==
X-Received: by 2002:a17:90b:4c06:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-34e9212f712mr28601621a91.1.1767208922858;
        Wed, 31 Dec 2025 11:22:02 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223adf5sm33349523a91.14.2025.12.31.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:22:02 -0800 (PST)
Message-ID: <ef460fd3175dfb93e0e72ef0e9e0b5e917fdf854.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] selftests: bpf: Update
 kfunc_param_nullable test for new error message
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:21:59 -0800
In-Reply-To: <20251231171118.1174007-5-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-5-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> With trusted args now being the default, the NULL pointer check runs
> before type-specific validation. Update test3 to expect the new error
> message "Possibly NULL pointer passed to trusted arg0" instead of the
> old dynptr-specific error message.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

