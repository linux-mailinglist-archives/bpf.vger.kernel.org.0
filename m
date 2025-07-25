Return-Path: <bpf+bounces-64368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB1B11DF3
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7301AC6BB6
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D52E7180;
	Fri, 25 Jul 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3oC6Vwn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7B2405F5
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444399; cv=none; b=uGaWitybL0WCu8vkNSsSRX32Mwrl/kJWDy7yDKMwRgR+2VZnJ8oLtj/ZdLipB0U6e5H1Oxl7IiyeMkRLeWPvC0yzi2BJkTK7UU1UyQugHhmplmpK11P9N5zK9p1rcn34KhH9wH9mU/QcbAD1D6ZXBIv1EA1FVab7e/gF1Oe95Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444399; c=relaxed/simple;
	bh=gGnouHFHwwnkf9PWPq1ym8Ksnmp5xbh5B0OJ22JaTEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZyhX2Dr/+bicgb2PY357PQLbciHr6S8GLp19tFTqMui67skThm6iKXhsjzrHB4d2nD9pGZm/Hk0l14Fbc6jdW0OTbFHrDJCybg9jpeP/hst73RobLu8lzrXQuB0vFfAWN0RQIug/0UHhVjm1xFeuDy7mJZpy+hpLP2Auu6AX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3oC6Vwn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a53359dea5so1070680f8f.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753444396; x=1754049196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcwlyRo5caZOzZALbtf15uUrhpPUQjznMtMQGKLa8YE=;
        b=I3oC6VwntEaq+dB7krQYyFlZSk5+fsPEcfPGoRcDtdh2YQZMJNLhznhIcv0jqeo7Xd
         Savm5kU+J2wI8ozBTw70EYZIkS1TwSawfxttL2xj93fPO6aFS9VySHMks5rfPhi+Mq1D
         nOA3QJkoaOqcoyapDsujYGBtpj+p9kP3piauFrxeDPxvi7ZOsX+PSBj+7u84ewDETi8z
         5Aau0Uq2E+UQ/abMXw7PlJ3RNqAKqFzjU+eJvZNKHiEtlaO8V/SNt21feixrzkJOas/B
         GaqliHADbeLjf2Saj54xfSso2Q1rRUkUe8jBJ/3QpT+lJNDW3pzc7gF/5piXMaCGO5kR
         1HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444396; x=1754049196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcwlyRo5caZOzZALbtf15uUrhpPUQjznMtMQGKLa8YE=;
        b=kWp7D6OGNyTe0+BuXVxv7O+XmFqk4iwGwC3btBUaqCSHs1ks7jJaxF736eNB07N0Hg
         w0KjThTNoBolxj7Yu7dUKTPxlkOgxsbZDxMJ7VFdHRPClU1vjHqNC+mr3EdjGo0fTnk+
         l97zf1l7ACcM2Gb1HU3QJNu+kxFcc8pm4zSAb4O3iVT+YNk32KqhAKSXdk2/C+6bx5kA
         LtA2OSGMhNVL6UyaNBzjAlN9NfAdbjOALitKMJnm1dmW+T/NGWKClk5QSZI2O8OR2kwA
         3gLZi4H0eyLV8sAXtF6q/txRu9N5vfxOt3mf/o3rHdm5tj4a9eX6s4J82YzV7y7wnd0u
         CNmg==
X-Forwarded-Encrypted: i=1; AJvYcCU+4fdEODmYZXcjNXxdeDDTO3nzQc6LQAV52jcAEqUh057rmm1+gBp+aueca7ZIY1OAntg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkv9ba5nKp4BzxaS0CfdvIb5eQ5veQ3+/8AXIHTVvObgwhjfJo
	MULhXinkc0t9bFuAPIBrkB2Rp0lPfNs9CjF40rsMQMYdJU1lC/3N+oH6
X-Gm-Gg: ASbGncvib3/bAPDOq0wpw8Cc13h+ujmm+AzX51UySihXvs77Peq/dylDtm8mE9RDM2h
	Sf7ylPC88IVN36HJGOO2fI4falYY60CdxhwZrcH/Aj5PumMjaE4vtyPFOjm1L6T5WTvUwnpV+m3
	SDE8M2ebJG903WhSFHigdTOFvypgzIaWfGMrURZdVVJKjYIeK5QDPlDjJQqaBrusFajjRdpX6F1
	Ip4jT6HvaSwsuvlpa9en1wfAh4Ors2O3dLSrynB/7CggqEA2rFac8T189Sf+/gC65KVTHiOSrgu
	SyRPd2VfLSMvQsC6VFA5MAtR7rHEOEiPoDPJ/n1FlLu8/Z9oSZ2boHPcMEYq/BDF50iSFrrXORz
	BFa2bN3ml1vmphqyI/ZCtkvebsCgtNdU0Tt1EpGfS0FxSEoAy3Q1CPcMjDpU+Y924YMV9/yysU9
	RcpP1yuA==
X-Google-Smtp-Source: AGHT+IHx4oyndHAgt0fVOWo36TBOw8fTdpduxCrsMJOBa9IuOvQfO/BTzo22VdQ9K5hCr8mYXJO0Ww==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:f900:21c4 with SMTP id ffacd0b85a97d-3b7765f4e4emr1565896f8f.26.1753444395574;
        Fri, 25 Jul 2025 04:53:15 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad219sm4871277f8f.39.2025.07.25.04.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:53:15 -0700 (PDT)
Message-ID: <cb02f1d5-8671-4e22-bd29-b47f4850406a@gmail.com>
Date: Fri, 25 Jul 2025 12:53:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Fix test
 dynptr/test_dynptr_copy_xdp failure
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250725043425.208128-1-yonghong.song@linux.dev>
 <20250725043435.208974-1-yonghong.song@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250725043435.208974-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/25 05:34, Yonghong Song wrote:
> For arm64 64K page size, the bpf_dynptr_copy() in test dynptr/test_dynptr_copy_xdp
> will succeed, but the test will failure with 4K page size. This patch made a change
> so the test will fail expectedly for both 4K and 64K page sizes.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   tools/testing/selftests/bpf/progs/dynptr_success.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index 7d7081d05d47..3094a1e4ee91 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -611,11 +611,12 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
>   	struct bpf_dynptr ptr_buf, ptr_xdp;
>   	char data[] = "qwertyuiopasdfghjkl";
>   	char buf[32] = {'\0'};
> -	__u32 len = sizeof(data);
> +	__u32 len = sizeof(data), xdp_data_size;
>   	int i, chunks = 200;
>   
>   	/* ptr_xdp is backed by non-contiguous memory */
>   	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
> +	xdp_data_size = bpf_dynptr_size(&ptr_xdp);
>   	bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
>   
>   	/* Destination dynptr is backed by non-contiguous memory */
> @@ -673,7 +674,7 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
>   			goto out;
>   	}
>   
> -	if (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len * chunks) != -E2BIG)
> +	if (bpf_dynptr_copy(&ptr_xdp, xdp_data_size - 3000, &ptr_xdp, 0, len * chunks) != -E2BIG)
>   		err = 1;
>   
>   out:
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

