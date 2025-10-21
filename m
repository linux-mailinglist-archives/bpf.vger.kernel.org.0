Return-Path: <bpf+bounces-71617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37015BF8318
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38141425AA3
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973634B67B;
	Tue, 21 Oct 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1Vp6E2C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7A346E5F
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073641; cv=none; b=igTehFWCrbMltlDg5EDWr5W5y9kcMhVBI2K+bP5WQ71akY2/NKCILas2A1ibuLPEqbbKIxG895sDMTMimHeX1GWuYSkLBbKvgo840GpWxASkSHFYyipPgHH5Az9pKY3EzLIXdt9i4/2Z9l4ExXBo161eGZli8ep1bQo9/oexsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073641; c=relaxed/simple;
	bh=FOAAwsJ9Uj8bAGD7DkfGOjFD264cHJeaIqipN113e60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+omJHXl971tZlMosL0tIxQZjr98drp6bzXVUJ/gRjeZ308V80bDv0VFXB0grh33Yc51wbrw9iZLEqYgwbJ7JJH39s6xB5PABt1eo7LL0UrZfE8eoM6ph26D0+1dIKCLv8DYmyrkzwtrMtYw9Q+Zu937ZUc6uDV6rS6kU3cI/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1Vp6E2C; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-273a0aeed57so2415075ad.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761073639; x=1761678439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmEFJU8Be01bge6hq/DhNSCmREuRRM1yp/lMgJNVP3M=;
        b=N1Vp6E2CkZ4YCHc0tiRUdsN0fR0wsbClBn+nGS1nuMmbdK1B+6XKYBYFjkZSt1TLVx
         oRdihRUouheKA8tn03qYl4t6zMmfS5BpmXoyJk3a0W+4H9cDcoYG5G7ew620fOU6C0yZ
         VHCZtoIhPev3QFpibg1WBU/7J5ZnI55xlZw0u4XzuhNpw9IWyJ8tKl9mpkn83lUGz23m
         bAmM1fpqoiCUlosO/t7Gza+SjIJg6gRANptJbo82MpxZSvqY6PTs/cDE1vw1Bdc3Z3Ao
         rgAvqHkAEVTpHL3ThwzVynzr63JymYH4UiuIYqg+xWwVo/towuPtAp7NFOtWnIYY0G+1
         Hi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073639; x=1761678439;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmEFJU8Be01bge6hq/DhNSCmREuRRM1yp/lMgJNVP3M=;
        b=j6orpClA1NmhZ7svR34uClIEOFBMnUjyYAUoBMiTNE5LIWi5ifaG9cdEnd1PExXZwM
         pV2kotxHyFi1Kz/nKgGJR04vQi1Y84kAh0vbKb4sQg6hPwqs2A0PFRlsba8LWHEQZpB3
         +rQmDDWIW0p7QMfUTKXb7dCj8sT3k/A8Z0oOeBnbsaW5N+UZA1GK1TY18eqxRSM9meB5
         IZP7wWsydm1dhXtzERaxPvBgv0E1mrNlzsanVSbSYYOxayXUQOG4i1dCs+eng+AHuMMK
         oQHcGDUh4Es/Ik3oOl3ks8q8jMbv6g7dFBIDXIRcAv/ayoCeVCc0TcTswgpgXQQTzGsE
         XtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWta/RMMoGvnq1DEjn4wrw+lEPsTNl7jE52MuMGOPkyC/Cz7mc+7N/f5jtVC4+B2VFIl24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfjlyjRp5xpBDrqS6NXEMtr01iDNHRJhjhUQKsAj9k2JdYRMO
	u3M5cesLf9mulYJ/n44pWB9JZPTk0xS2dQw9H6VNrcROw8zLvBkgC77vh/aa+5gu
X-Gm-Gg: ASbGnctc/o3JUG2W9WAknydwzTgduKy/6itb30EwLIXIpgf1ns34WTByF1BdD8zgXmv
	kJC0xnBztb5wxAzOiAmRuhoS++SlqFD96p/fhSna3WH5D6T8G5rTssqBZWh4q0y9XjeWeBJ2Y7N
	w9TGsIq3kLND7qfuxPBy5wQ6OYl22/DnO1UI3oIapoQ6Nbb1LdwSkBPqaLt+c9JeHzH1wOmjAkR
	L85P9wq0YO73N067L79wG2KVCCGRx7WNWliEM4bT7teLcqWuq9cE5ft1S5w1UefAj+CXt+HCN09
	Nn7ZZJ7qkoyTotJBlems4O7b1aylroJWQ7X2IZYTBMvEgTPUXf746yhxzD9/4Ut9tLgQNBc0h71
	Lx4k0cemW1+z6cAgzrFM3Xxe8+6Bp6jyn7nbODr827IITwNm0X80lAUWKK7IquixzFD5vghh6Zp
	Pdpeynca9w/X5dUbEMRebjx+eYO86Bri4r4kY=
X-Google-Smtp-Source: AGHT+IE5LQZFO6UFhsWNvu30idBG2vvaKxgsnI32qmbtsRvHFk6H4FUtrwCBgpU/tnj4k/GVfT3eZA==
X-Received: by 2002:a17:903:1103:b0:26a:6d5a:944e with SMTP id d9443c01a7336-292ffc714f1mr8437925ad.24.1761073639315;
        Tue, 21 Oct 2025 12:07:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fde15sm116578435ad.84.2025.10.21.12.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:07:19 -0700 (PDT)
Message-ID: <ec7ecc7d47540bba04f6a0b7e0cf74f4ef7a84bb.camel@gmail.com>
Subject: Re: [RFC PATCH v2 4/5] selftests/bpf: add tests for BTF
 deduplication and sorting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 21 Oct 2025 12:07:17 -0700
In-Reply-To: <20251020093941.548058-5-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-5-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:

[...]

> +{
> +	.descr =3D "dedup_sort: strings deduplication",
> +	.input =3D {
> +		.raw_types =3D {
> +			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
> +			BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, 64, 8),
> +			BTF_TYPE_INT_ENC(NAME_NTH(3), BTF_INT_SIGNED, 0, 32, 4),
> +			BTF_TYPE_INT_ENC(NAME_NTH(4), BTF_INT_SIGNED, 0, 64, 8),
> +			BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, 32, 4),
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0int\0long int\0int\0long int\0int"),
> +	},
> +	.expect =3D {
> +		.raw_types =3D {
> +			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
> +			BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, 64, 8),
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0int\0long int"),
> +	},
> +	.opts =3D {
> +		.sort_by_kind_name =3D true,
> +	},
> +},

I think that having so many tests for this feature is redundant.
E.g. above strings handling test does not seem necessary,
as btf__dedup_compact_and_sort_types() does not really change anything
with regards to strings handling.
I'd say that a single test including elements with and without names,
and elements of different kind should suffice.

[...]

