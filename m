Return-Path: <bpf+bounces-58281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4BDAB81D9
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 11:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9E3175EED
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DBE2980BC;
	Thu, 15 May 2025 08:59:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FA297A6D;
	Thu, 15 May 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299567; cv=none; b=EeJaVIrwUjS8wA4e6t4owVBvawBPtl+JhAC0CQgUHcz4231RTPkW3lOSD/R0hC/xo5M3mE11UAJj7tXhXJpVYY0DwmNQ3b+AbpQ2vjMYF5/faP0UtOb0trBRNHS6s51IsAXBMSeSg+3xy2aG41ZyKT4C50cuZlVKI3u7k8yWHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299567; c=relaxed/simple;
	bh=U8Gms1unVLaYGMPmJgh5mvgST4RNp4pyfwxfbuqpqZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIWf8Vp/lPJAQtV2OTHPC3IjrPlk22rT5d6Ie3fFU0nO7JiY0VvpWSeio0E6nn9METq8zLLwFalIVVgs2I3owxjgqNKNb6OBF/um63TofmnWuwPOgHIdI77QpbPd7ORDVqsTCcNuNXrI1DgSn5m8c/jdMCd2T25fpDsGcjoTWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441ab63a415so7022885e9.3;
        Thu, 15 May 2025 01:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299563; x=1747904363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wY3EMb5JxEbCY3HNeRXG9ydmvJmQVNydYXnk83cuGg=;
        b=qBN4E3ORgyDjGyN5X7r2BqybCfqi0NH9FpRqzqXKYzoIWd+cM7kNJDU7eMDiiPYPWY
         9f3m1JIunUfDwENp8rT9d3RZV/eQM2IGXn1HlMQswpdA8dAMa5IXSQZF2wDNCSFSjilK
         pY5Tau8gDo0VMs5jz6H9TBjfm/4BkqoPNbr47W42p9130XbMa9xBIKtSAkwFeJ0mbzfs
         oBRSEyjrgez88eOP/hFTaDYs/Xr9Gt8Tlg9XXxozOo7FoObQ0aRXbgizcAhO1CRVko+k
         rQ7+S6IvePN1f42/Q0RsNzvNPv7I/Vzwa7v+csSJv5ynROFROUZLf/u+HDXOwaILOYXR
         rqoA==
X-Forwarded-Encrypted: i=1; AJvYcCUw9k2YqkGItpVhYsMm/LihhEOUrCr6nyLGktP/VsGU11I7y2T+66RVDVtGcjGzBXHkqgmFf/3mi37nk3s2@vger.kernel.org, AJvYcCWWBBOA+zQA9DMkWALf4ah+BnPxlwJDUNlNrS2T4O1CppH85V6M3HF8n76iCOJTblj7ckI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl3/LChk947W48u2FHn3+Tf949S9kvDY1nTpedCjTRYLHBEaBI
	LTEi1I+/hh/TWU69LVUOS3HYAFnyNS0IDHtfMyVPvxzLXNNZqOgo
X-Gm-Gg: ASbGncuVvhhobDr+wc3RHXyMPQcPPmRU/CBydTS7Yr3q6G82yraHmCiSIBQAxQHt56M
	YVDsH102Y0O+wf/oq5W4PB3KTX5bzTWFHul/ZR5WdTua/yCdysggwTt/lJDC2UvPCwJGAzIYNfa
	IFJNnIIOAgDysymockqC61eOekXAqKW9WsW0PxlJutGx1QPvm9pXrBAF5AzHmB4sQbViHRwErZE
	rMGbPnbx5MY7HmdM0TOSa7qq97QeB6cIFD4yi5dGMyCMKyzLbN4j5Yd3Wq8+/dOg/VOLaQfyUFC
	gsnYbCicYTthCDxbo9y8HOFJunTu03dWzbPfV9F8G973BwE0PZrNh9BrOtnreGU6JRv0gGQj1un
	H06U64RD//9AwkgI4I4VB6/8A1g==
X-Google-Smtp-Source: AGHT+IHSMBOis1LN9zZB8Ns1QMfbY61wSCNeknS/nXCa2UvoEyCLR8YwmUUu5xG/+nbb3Bg0E/FFdQ==
X-Received: by 2002:a05:600d:1b:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-442f4735a8bmr43794115e9.27.1747299563102;
        Thu, 15 May 2025 01:59:23 -0700 (PDT)
Received: from [10.148.85.1] (business-89-135-192-225.business.broadband.hu. [89.135.192.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f337db8asm62665355e9.9.2025.05.15.01.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:59:22 -0700 (PDT)
Message-ID: <eefad549e3d0568b523305252b6ec3a468502d2d.camel@fejes.dev>
Subject: Re: [PATCHv2] bpf: add bpf_msleep_interruptible() kfunc
From: Ferenc Fejes <ferenc@fejes.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	 <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Matt Bobrowski
	 <mattbobrowski@google.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 May 2025 10:59:21 +0200
In-Reply-To: <20250515064800.2201498-1-senozhatsky@chromium.org>
References: <20250515064800.2201498-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2025-05-15 at 15:47 +0900, Sergey Senozhatsky wrote:
> bpf_msleep_interruptible() puts a calling context into an
> interruptible sleep.=C2=A0 This function is expected to be used
> for testing only (perhaps in conjunction with fault-injection)
> to simulate various execution delays or timeouts.
>=20
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>=20
> v2:
> -- switched to kfunc (Matt)
>=20
> =C2=A0kernel/bpf/helpers.c | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fed53da75025..a7404ab3b0b8 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -24,6 +24,7 @@
> =C2=A0#include <linux/bpf_mem_alloc.h>
> =C2=A0#include <linux/kasan.h>
> =C2=A0#include <linux/bpf_verifier.h>
> +#include <linux/delay.h>
> =C2=A0
> =C2=A0#include "../../lib/kstrtox.h"
> =C2=A0
> @@ -3283,6 +3284,11 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lo=
ng
> *flags__irq_flag)
> =C2=A0	local_irq_restore(*flags__irq_flag);
> =C2=A0}
> =C2=A0
> +__bpf_kfunc unsigned long bpf_msleep_interruptible(unsigned int msecs)
> +{
> +	return msleep_interruptible(msecs);

Perhaps exposing fsleep instead of msleep? fsleep might fallback to msleep =
if no
better mechanism exists or if the sleep duration is >1000us.

> +}
> +
> =C2=A0__bpf_kfunc_end_defs();
> =C2=A0
> =C2=A0BTF_KFUNCS_START(generic_btf_ids)
> @@ -3388,6 +3394,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next,
> KF_ITER_NEXT | KF_RET_NULL | KF_SLE
> =C2=A0BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY |
> KF_SLEEPABLE)
> =C2=A0BTF_ID_FLAGS(func, bpf_local_irq_save)
> =C2=A0BTF_ID_FLAGS(func, bpf_local_irq_restore)
> +BTF_ID_FLAGS(func, bpf_msleep_interruptible, KF_SLEEPABLE)
> =C2=A0BTF_KFUNCS_END(common_btf_ids)
> =C2=A0
> =C2=A0static const struct btf_kfunc_id_set common_kfunc_set =3D {

