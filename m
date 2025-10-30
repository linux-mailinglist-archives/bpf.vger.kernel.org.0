Return-Path: <bpf+bounces-72951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87342C1DEB6
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E51634E47CA
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B61E47C5;
	Thu, 30 Oct 2025 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReVLycyQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853E1AAE13
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784481; cv=none; b=gEUZAJ/b7RttEy2hf2qvprEioFRQHeVFsNPnEp+7nX+XHUSOAchHV9gKSwGMRilM6gIzIhrj2N9M//zeT5ZICkNHv5NNwmKmdl22YNafqEkddeMFcXkkYyOPWoUVDqXK0lkh4c3JJkxvP+Y3Be+N2dS/lyHKYXi0uzyPmHe+soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784481; c=relaxed/simple;
	bh=1qxVsSAIwaVyOEGI2OzLBsOB6lwwmuHHlXNB1Q2DNOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F5ilwd9BWVsaHjh3PhLHA+TlJP5EHMWpZyXptpAuHEknbz6ij6czZclcMexi4vY9XC+deYTwaBrhsK9yYdrGjBcVE/1T4tc4b3b3eMqRsEcrTadRKOOgJy+Vsd9eNtUxzhPNgSYRjPxIzTMfhOmKDLfa08DYas62Ihd2BuYRaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReVLycyQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so765280b3a.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761784479; x=1762389279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kAeb6/jvvRZTFeWvAwgm6jZ0gcxQ5BaYTvlVtG3eXaM=;
        b=ReVLycyQBj6D8hsbrstid2X9PI3m1JvcBkOgknj6aGsbArHndzEUkYaHVLidHVOOsJ
         4I60E65Xf+9Vv/y92CWrtYzA7sBMIqpnUIuO4o1/wFuHw/O2xmDG+8v8qzXlvlSoW4RQ
         bSpAeiUAnYSOFVOFLEBR9mDpT3pyDWiYCaXaBkOe58Y3IgpHTZlhZDsy9T/OO38Nd+aK
         /WuSWoUx4oCaGdJOp4UXX82d5XH/spcRhPB3bEQ5L4tEuVTVanLUVQZCadKGEpUp3jQv
         mLAbzVyiM0TMfj5cmJvBsTL3o6xIXAEekAFvBEAB7YkAcJpL+nFDtd+UiOOvTupEMaG3
         jRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784479; x=1762389279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAeb6/jvvRZTFeWvAwgm6jZ0gcxQ5BaYTvlVtG3eXaM=;
        b=SsY6+HvM68h8gKTcdSVZAiAhx4JDv27tskGXgYqUwnpGY0nkmbH5bjFq4N0W2sskNz
         sp1KbOJzzQ4sO30n9g7ruB2HnQHX/XvbQfc6iKVdDO4tV5ECcd/2fXUhpWgajnoVkO/0
         kF4vXLHCtF9KE0sLP0Q8hscR78frNJpPxE72L+W0oGhii0Srs/jBq2LkxysCswRDWQbT
         YRdfAmic9YGL5ygWXvJDB9xn7x6Q2C3CpkaTaigSn4l1Fy3gKw+vJWB4wKMSOgEGHEpL
         h4wS/xNIDnY/R3zqS0XgwHEVSQI1gdCWKW4ZjVGtxbCrj2LhNXs5q+GJzcOYvBSDyRWc
         df8Q==
X-Gm-Message-State: AOJu0YxJjWf+TJON4/vpJijHf+8EZ/mitaFvEUWIqHt+YVBN20aRD6pP
	PvnubQJDkh6LNmOsQK3X7M3xVSnpQAPaVLtwuNUFiUsij8iw70zJ41S2x1fXvzfj
X-Gm-Gg: ASbGncugZdMoRb2dYpAdLWZr0gf4UxW0UrpynHbW+txkD6WLOQnOqlzdu32di8bgMwd
	KSlxjrzep1inoKEur8PmwwzhBrWN9Mscgj9ouS5d5wCzJP+LORRcppNEXTJG9iH9e95ASZxBYI9
	ZZsowr2oAeoOYIbPIBlbHAorJxEE7fSDQt2HFmCJ6xHho9C5iKqw3VjwliRSbTUeRC2d9hvm49X
	qdciohHWWdz/8WkReUkEo6pEYJOBlAOMs56d2PjSp9v7cdyV2InHFRcmxl8cvCQcX9JqysrrsU7
	z1qm6j9o6V90cfx5gUJ5FufzFCNxv9075hv0dI/Cy2GpxbX/+B4oMPuP33cWuXYFoNafR8UBkV7
	5CfhCbCGQjvLBRauDenEwlNbLbeThTXEWQphJfs5HTPC4cYmss1UJt6Ov8sRZNRZJ9poM3QoiqR
	idYYoHMBwAvRtLgxjXvyrt/YF8tQ==
X-Google-Smtp-Source: AGHT+IEF9TKCc2e0ZQgR3jSC3BE4yFhJUMwpQPTJSa/qncQWobsemJejfV6zQ1oz6uG9JsEIyMI1TQ==
X-Received: by 2002:a05:6a00:14c7:b0:7a2:8111:7807 with SMTP id d2e1a72fcca58-7a4e2cf5221mr5924534b3a.5.1761784478761;
        Wed, 29 Oct 2025 17:34:38 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068f0fsm16848252b3a.46.2025.10.29.17.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:34:38 -0700 (PDT)
Message-ID: <ae1669b250a3e5532741e18f70f73e4e98a3bb48.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 1/3] btf_encoder: refactor
 btf_encoder__add_func_proto
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, tj@kernel.org, 
	kernel-team@meta.com
Date: Wed, 29 Oct 2025 17:34:37 -0700
In-Reply-To: <20251029190249.3323752-2-ihor.solodrai@linux.dev>
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
	 <20251029190249.3323752-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:02 -0700, Ihor Solodrai wrote:
> btf_encoder__add_func_proto() essentially implements two independent
> code paths depending on input arguments: one for struct ftype and the
> other for struct btf_encoder_func_state.
>=20
> Split btf_encoder__add_func_proto() into two variants:
>   * btf_encoder__add_func_proto_for_ftype()
>   * btf_encoder__add_func_proto_for_state()
>=20
> And factor out common btf_encoder__emit_func_proto() subroutine.
>=20
> No functional changes.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Ha, check this out:
https://lore.kernel.org/bpf/18bee370c4804e666eb7d5360c47439c246e1cb7.camel@=
gmail.com/
Wrote same thing to Alan on Friday :)

> ---
>  btf_encoder.c | 135 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 79 insertions(+), 56 deletions(-)
>=20
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 03bc3c7..0416824 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c

[...]

> +static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder =
*encoder, struct btf_encoder_func_state *state)

You can get rid of the `encoder` parameter here.
See https://github.com/acmel/dwarves/commit/080d1f27ae71e30c269a1e26e85bb86=
c3683f195 .

[...]

