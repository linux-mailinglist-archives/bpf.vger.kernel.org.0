Return-Path: <bpf+bounces-21083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E69847B80
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1538928C151
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A973B81758;
	Fri,  2 Feb 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMkHU/Gx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902E210E0
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909250; cv=none; b=rzSap73Tbo6Yf5D9DTZg9kTMhX2Kai1uzItQ/GNr1/8pUc606LqBrtF6CgPRInMJ6z6MtLT4umJsHcryrmv3fDdAbw5NPQ2fl4R4AxLy7GeYoMuUQWy5FUyogKN6B4Vxpzwl91K8VtFu1Nq5Zuyx/8v58BDRtO3I9SG1MEkjKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909250; c=relaxed/simple;
	bh=46XolDwZvT2CKwOjhWAL1zosfONeLfpya+G0UrHCfwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YNzCGIvH0jEBYzjqudjP9/jjn6xkDy/FtmUb+1fJAME7+8tRYUD5a9l1LKQqAaMyI2YFsg8E/0a0FYg8SnNFozkxmRnWZt/KUul1FU5NlaCQU4oLB05Kuhu0f2V0Fiv5iLGEoRismZIAnw+it2dyPSSSp6KXO5RQ5tLNfSTIals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMkHU/Gx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a35e9161b8cso348095466b.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 13:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706909247; x=1707514047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=46XolDwZvT2CKwOjhWAL1zosfONeLfpya+G0UrHCfwk=;
        b=hMkHU/GxtoRhTGbdKYaYNgSCcZLs7ftUdIRcWG3BJIhprBbw4qfMQetVH6BYdz4KoL
         GkE89t4qnvTvMwhgAM2+vmj8ovIJrXC0hLUTiNGGbOiOn3aSdnUFD1UpPlNF71Z/6oxL
         OUDWZ3ekMTkPqGMTsHfgPybtVb5dDtv6ySsrNAlDSzxbTpErlmF527tU8wqSEpkoWgfx
         FXNL1vggtFWCEDQu1oCACTGupZaIvzqX6xuKEcKkRNtSgeUhmQrl0r34VMqlCEwQzhzx
         /HBPRNiV0NGsaLzzK3ocXrZk+RjBNyAV9ZZSlHAcLSuSWspfqmR/KhS1/fRK+zee6YQC
         y7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909247; x=1707514047;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46XolDwZvT2CKwOjhWAL1zosfONeLfpya+G0UrHCfwk=;
        b=D0G3HvleHJMOfpxROB/31uKaxv+1SGsjGsbMqx9j2CSKmBd7nDr63wj4gG2UH/w2bd
         uHP3LACeB6eGUE3qAwH4ZVaTSZ49Fje1sz97WRhKdJ/4O7AKvUQU8SBBLmxPrPIS2Fe6
         +odBMWTvGdUsnpnJJH6R3UadZTdDguh982pZHWRLIbSr8rXiI6/gbzTuqmDrG4UO/iqW
         qnzlxWp/Z4kMnWt0Kn3fz28QOb5xZRgOlMGY/xtQai8uSyITdHWz8XyvCSQ1c8dpBaTA
         RS+rsp+48Bciesn7KTvEQdcf6V+D1/4og7ZhfYa1p/glGmLUNxLv9ez5amUpyeC0Tjtg
         lEtg==
X-Gm-Message-State: AOJu0YxLtbp05UHmcF51H2awAIPyYTDz1qze5Zt1KEWKEVhK3aivbEYf
	awkuBHTWzTTnnsPpsP46QFLODelYzg8RR9HJY3KtZc9YuW5SpeQk/0qB9Pj5
X-Google-Smtp-Source: AGHT+IHxRWg7GPL1A+FzrUQnTuEzCy+m/k0lrKs7aor68s96zsj87dvJSHHoT9E4WcMSPrPepOCILg==
X-Received: by 2002:a17:906:2296:b0:a26:98ee:9fc0 with SMTP id p22-20020a170906229600b00a2698ee9fc0mr2250247eja.43.1706909246542;
        Fri, 02 Feb 2024 13:27:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJrVSESNg+QL5DB1Mjp+2Iz0QyVSfjTIwZJ9AkJoOYAz0kXzbw998XaKUuXT1yBEGqhB7HnNZLyRyVJmKqmmRWNTD0eLbjNXluv8WyS4eVp1yfEhTVHewmJeIpXomrnh8w0hC+e3D9chGtT5JeK7SomMbDbGq5J0rhQL2GgqibWA==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906180c00b00a356c0fdd2csm1259402eje.26.2024.02.02.13.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:27:26 -0800 (PST)
Message-ID: <259aafd6cd17cd489236188aa32539b504f71d3c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Two small fixes for global subprog tagging
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Fri, 02 Feb 2024 23:27:25 +0200
In-Reply-To: <20240202190529.2374377-1-andrii@kernel.org>
References: <20240202190529.2374377-1-andrii@kernel.org>
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

On Fri, 2024-02-02 at 11:05 -0800, Andrii Nakryiko wrote:
> Fix a bug with passing trusted PTR_TO_BTF_ID_OR_NULL register into global
> subprog that expects `__arg_trusted __arg_nullable` arguments, which was
> discovered when adopting production BPF application.
>=20
> Also fix annoying warnings that are irrelevant for static subprogs, which=
 are
> just an artifact of using btf_prepare_func_args() for both static and glo=
bal
> subprogs.

Full patch-set looks good to me.
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

