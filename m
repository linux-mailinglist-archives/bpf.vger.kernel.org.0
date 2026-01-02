Return-Path: <bpf+bounces-77669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B183BCED994
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 02:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D73300818B
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62082010EE;
	Fri,  2 Jan 2026 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="15IyVUbp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5C1C68F
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767318321; cv=none; b=j7mCUYG+z2fhkhrtOANaMwawnFbViHNcPyUEE/pnAMs8AeiIv1yAzR334lkgsqkC5mWZOj7OwWakhvyCm9sV5e56yv4mwxtI7ERc+YNKyO4TFOM7s5JiVkH4h2KM2HLd1mGyMm74+bSoIzKYpD7O4aDtFv7g8MaIa6Ae/cBXDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767318321; c=relaxed/simple;
	bh=3BMhu4nUttguVo6ZiCBNVyMGRo818MBTpD9+2PVI2qE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=slel3Ex286Wb5OihinPJhsxEL9S6dEKuPni6slRGgXbBpko+14sj/JrHTBlc5m0yiXwbu0DBN1dWrgVcwpuCAFdcVBpyHhelksK2c3l6XTBHyhTiq6lJiUpFZYd8MRjbzAElWmFQcqOsZrwlQ0zifq1IM8BYXw3xDBfG+9StLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=15IyVUbp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b23b6d9f11so1332415985a.3
        for <bpf@vger.kernel.org>; Thu, 01 Jan 2026 17:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767318319; x=1767923119; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hWGyIUp4A3/Oq4xnw5aLs/tdnbUNeWO7GU9/qEiGbA=;
        b=15IyVUbpbkBEN130ptfIexLfbSPLU7Z/1JaFTJsIIpzEL3gUytMlb6Mng5/80NeB68
         Z/88iUH3VhUWiDSbbVN8vfNHXoVEwJxmLDA7RplC9CLohpG99n9wswqqQo/V3l71kuLH
         m1swJ68WJ62y+obzMtSqPahCLtl6Jl7ridTlqPlbMIOLoEtXtGV1OFRw17kTOt+0snth
         1JBufotrejvNIlT7hx9Ty8CdMaxDX8xx91hO7MmBk+DpK851zqZyy9iInr3cVzNMoh2N
         ClOUxZz4c+CEkiSBEV1YwmFDqtYIUqcauUiZ2307itpkTAKGayqf6iaKmJJH03BatP29
         FKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767318319; x=1767923119;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hWGyIUp4A3/Oq4xnw5aLs/tdnbUNeWO7GU9/qEiGbA=;
        b=a3rjKsZUncNucCSbGdXRTnowSoOtWH2T7zgFG5WV0SbOs79NDbyxOEelGz/3z29ncS
         ejNItEt3vEpb9Zxxp793uyCj/O47ih18ZYUf0Rlrk3KtH98MBuKw0wCzAEjeQoztq1J6
         tNOhv8BIMhXv1Tv44ihnaaRcGXC9AaJgeOmqcRcupEpUY44Z0gs3U8LYU3Yht75lb6+n
         giHJ8jmt9z8r31dxXga/MXfFmNrhVDHULXWQdrrPpkRdOCoMSrKAMpUkFA/TNrs3XMaR
         2XVy93O7e4SFjsmffMmPsHLB6MI60vpWfC7h9cDWAiXTFZF1x8VtZhcd1zHvNHVVFizE
         zwHw==
X-Forwarded-Encrypted: i=1; AJvYcCXLw/lz+70Dy01V0KDHycRIYz6tN10kcqkPUZLNuK+gPbFEraSF4JLl9WHr2yPvxCpe7V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRTfFLUwgfW9vr70S+d02L8z72pplFWKweLFBHGRuUGDgm7Ol
	bKaxqeEiqFzg7Pq5nc9tSzdIWRDeeBGaMraWIZyVSEekRBeaqlwbxuFfhJu87i9jBew=
X-Gm-Gg: AY/fxX49QnauP+AUUNkst1ic68Rkp0ZPwrmwtHYJWckt1TqX+w/MvqIpHCil4WFu5VP
	2i6URukVLo+Bc1l3LoFB15dsoyN/deQURGjlHq4NnWBE62VyOd3O7pzlLQog+kFqG5fDeP9XWWV
	qk0Eow6sX7XlOwEzIcOYHZh8VyHnLd94PJONeebTdxjWltsnMl7ckDQOqK6Z9CP1QracbfflvQu
	4hN6tlG+PJMTh8ZHMPfa3mSBKeG9gCh34AFu8R9Qwx2KmgjuyqGNvl2S8dDh5nriAKctlqCDt4m
	s11knZEZ8qhK30kUl3ilgWHQHrNRGBqXtRTvYvaAER0tFC5lKtePeuzGH9+z581FHlKcpjsRsyw
	B9KcCwNfBi6rL6W5XIAzdWt5wExJeYjyQRDJmgRHybEndHwdxQzxeT3pfqSGlEaqkpdDgKOt2de
	yVYipeyfjmh+8=
X-Google-Smtp-Source: AGHT+IHtmuzqiq8URvi0BnGrd3OcHRDAkGKs8ULCZSAZJ8GamMLM9XQkkB+xfaylfjfifyqkaSDDfA==
X-Received: by 2002:a05:620a:4609:b0:891:d993:1bdb with SMTP id af79cd13be357-8c08fbc81a3mr5702438585a.86.1767318318404;
        Thu, 01 Jan 2026 17:45:18 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975eeb4bsm3156865485a.52.2026.01.01.17.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 17:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Jan 2026 20:45:16 -0500
Message-Id: <DFDQ22FEZ6GZ.KVTC2B3CAZM6@etsalapatis.com>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 4/9] selftests: bpf: Update
 kfunc_param_nullable test for new error message
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251231171118.1174007-1-puranjay@kernel.org>
 <20251231171118.1174007-5-puranjay@kernel.org>
In-Reply-To: <20251231171118.1174007-5-puranjay@kernel.org>

On Wed Dec 31, 2025 at 12:08 PM EST, Puranjay Mohan wrote:
> With trusted args now being the default, the NULL pointer check runs
> before type-specific validation. Update test3 to expect the new error
> message "Possibly NULL pointer passed to trusted arg0" instead of the
> old dynptr-specific error message.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.=
c b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
> index 0ad1bf1ede8d..967081bbcfe1 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
> @@ -29,7 +29,7 @@ int kfunc_dynptr_nullable_test2(struct __sk_buff *skb)
>  }
> =20
>  SEC("tc")
> -__failure __msg("expected pointer to stack or const struct bpf_dynptr")
> +__failure __msg("Possibly NULL pointer passed to trusted arg0")
>  int kfunc_dynptr_nullable_test3(struct __sk_buff *skb)
>  {
>  	struct bpf_dynptr data;


