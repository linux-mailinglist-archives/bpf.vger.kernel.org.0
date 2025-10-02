Return-Path: <bpf+bounces-70241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91600BB5249
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6969E3C6AD2
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB9427A92E;
	Thu,  2 Oct 2025 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyKzBgGo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CB269CE6
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437862; cv=none; b=HtSfLDJTR/L57TxoF4dxDUQ4Jukn6l4kBVZDjWnB51mTVatUWRubWn/D1osXnUHB8q6rHw6DZxS9u14Uq6/lNE6PDqubT4LAC0XjU1G6TZakBvYsYKiRqw0im8JdDsvEDO9PEYcqTvEeXRmVxChNgDCC3aIILpq0QRUuW46JyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437862; c=relaxed/simple;
	bh=zETJF/uPTbm4WMfCwvLk7+X9wnPpJVcJS8EE6fUMgUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Elg0xHpOaUlXiDm4IiCmlJZe0Pu2aKj72fGTEX62fN9rc+XMqLTBvm73xVFgqTbu4oE+o8CKjsJrHzZRkMZ6+iqotx9x3o2roQ5V1j7WdYjUgr5hVm4cbT/EGVzZNSnJTsb5jUxlt7+vDG127/7DvHHD5tsfB4VGsKO7FFF4K68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyKzBgGo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so1889582a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437858; x=1760042658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6krtueAm6AjdG2ziFnmg4cmo6FitK+F1R1PgaaY8Ct0=;
        b=YyKzBgGo37hSdRDQsWYRDIxctHH78oIyaVTXmYcEtDZ7rjsGAqz1M9Nhbc7JyXB4oA
         GomOq6sn+8Y8ziQI1MHbtEAAb0N8hJqA3DZ455DEI1211K45LyfXluLtKh/tLZNpqcyG
         IBq4wsqKaFj4a3nHzhAoOuqaxRiMl7+WACIDpBVg1C8ynH0oLcr/0MNhY1BN5S8algp+
         s5hH6FcGbU/vRGYDSF/RohhAkNWGfemETq3zFD6Chk4FWhdpCrukZj6Mh/X6NDmMJEgc
         PKd3Wyb4twJ6Pwcbq76bcKLw3FCW9hxwSyzqFY8kzJEf5AI/yxuyv6weybrAObBY38fS
         lx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437858; x=1760042658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6krtueAm6AjdG2ziFnmg4cmo6FitK+F1R1PgaaY8Ct0=;
        b=StlEujsDOHPmHAKYCEtEdy7xjI9qyIa9CUQrniqlZnOnfrs3Y4RsTK+al8Q+2NegVp
         ghtx0Aa3mGQJshg8n72Kug2TLth+Fsr1UZlwnz3wOwk99Vvvm+D30AIPPDUb2ajuo3Kf
         Xxx3GF0xO2XAgg/9wOGJRuNcj8FuxKp9Wcuq7CNoe8ihVVWGYAZNkNuhYr/p/eTEsjRW
         UKtq/K/LlDu4KMWjPUBdAWbPQxLh0z05K0uZSW3reG6RZ60Q6FhwkiZ3m1scedUP0JLP
         v73hpQRnlnhkG+us2UgmUrJqlAYZ9LHQypl0dw+P4aCY1HVPLSSWaDzRsjpC53w0RKCJ
         GdaQ==
X-Gm-Message-State: AOJu0YyiAm448rXPgSNPqrqK4XhFAUZ2o2gvNmSqLPKR+0blCsy9TQ8s
	NEpH+TJgXo9Rr5m6zpoReL1hVJciw7bpkAxECPfG39RxlJoSi3AQcgvmHEtBQWhU7/vVMiEeKD5
	JaOgV3bZlpi7A5qcnZQcNr7AeBh0/Q84=
X-Gm-Gg: ASbGnctEnhW9wXPAB7bU9mEUmVT9XF73wEqHy1PkQG8kdKW1vyBiZl5KX5j7FdikAOg
	fQ01SiTr2gfLv8EDKnyKHu4jlpzG58UndUbcch3Q9Qouo6dS4yZvgZo1Wo2hIfzn16youqNaias
	+bZfbp6wt/MKrtftAw1/30NupQiiSQJWewH8yrgejxqzSfMJ7CyjD6pmyZP5k1G9hjTQO3U8zUe
	KIpRQq73+0ZFJTbQUVCkQ/JvoPg/wVitX2PNB0zseJvPXQ=
X-Google-Smtp-Source: AGHT+IG+YpiORgY8tYl3Djm+OMKHL4iazxrZYl3oaGYkZ1hqqfasyxXPimGj5pFxBswyXh6KFofHjV6UCVjbVrbWxts=
X-Received: by 2002:a17:90b:4d0f:b0:32e:c649:e583 with SMTP id
 98e67ed59e1d1-339c27a10e3mr629526a91.22.1759437857671; Thu, 02 Oct 2025
 13:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002203150.1825678-1-tony.ambardar@gmail.com>
In-Reply-To: <20251002203150.1825678-1-tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Oct 2025 13:44:02 -0700
X-Gm-Features: AS18NWBejbhYSaGQrIlBOV8aCMNTvP5FtM2t09hmDtLs_qntiueVdHdCkr1L4zs
Message-ID: <CAEf4BzZF_+0DzKhX8fAH3vT1upq7P_PBonB+LswNPHDNFB+6hg@mail.gmail.com>
Subject: Re: [PATCH bpf v1] libbpf: Fix GCC #pragma usage in libbpf_utils.c
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:32=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail.c=
om> wrote:
>
> The recent sha256 patch uses a GCC pragma to suppress compile errors for
> a packed struct, but omits a needed pragma (see related link) and thus
> still raises errors: (e.g. on GCC 12.3 armhf)
>
> libbpf_utils.c:153:29: error: packed attribute causes inefficient alignme=
nt for =E2=80=98__val=E2=80=99 [-Werror=3Dattributes]
>   153 | struct __packed_u32 { __u32 __val; } __attribute__((packed));
>       |                             ^~~~~
>
> Resolve by adding the GCC diagnostic pragma to ignore "-Wattributes".
>
> Link: https://lore.kernel.org/bpf/CAP-5=3DfXURWoZu2j6Y8xQy23i7=3DDfgThq3W=
C1RkGFBx-4moQKYQ@mail.gmail.com/
>
> Fixes: 4a1c9e544b8d ("libbpf: remove linux/unaligned.h dependency for lib=
bpf_sha256()")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/libbpf_utils.c | 1 +
>  1 file changed, 1 insertion(+)

let's make compiler happy, thanks

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
> index 2bae8cafc077..5d66bc6ff098 100644
> --- a/tools/lib/bpf/libbpf_utils.c
> +++ b/tools/lib/bpf/libbpf_utils.c
> @@ -150,6 +150,7 @@ const char *libbpf_errstr(int err)
>
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wpacked"
> +#pragma GCC diagnostic ignored "-Wattributes"
>  struct __packed_u32 { __u32 __val; } __attribute__((packed));
>  #pragma GCC diagnostic pop
>
> --
> 2.34.1
>

