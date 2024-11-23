Return-Path: <bpf+bounces-45512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AC39D6ADA
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C4F281FDC
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5CD14B942;
	Sat, 23 Nov 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCX8AIto"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95751862A;
	Sat, 23 Nov 2024 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732387373; cv=none; b=GO1NDTw6PYYT5dWaXViV6J1GueIwCO0xbM+FD60QfdFlsykU2nVvGNLfTssNsd0xsjKAZA7NR4cqlIeUaYKxJU7qUJF9ofylFttBFbYYiR8DBH8Mf1R2rfqcBXf3VqDy9+DJR89hQulkQz5OYwObFoDaejMokzFS5uzcQEeQE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732387373; c=relaxed/simple;
	bh=EWE2QeYT48sgxCezCrTx7aEEa/s+hftqG2brakcgRY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5Z0Fx9kysGaphFTAzwfufpKuGQwmpqrq8oloT3XkiXt3T1gUi7z8h+/kohcnwKOLbif2/iPQ+3qBzDtQSf39zKzcHQzDyTGRhTlsEE8yhq4o1BBBHYt1OFN0J66iXNdBGkDvY5XeesmVtZvlcyAszxOF3HuRJ1jxzltxj0xwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCX8AIto; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso26799695e9.1;
        Sat, 23 Nov 2024 10:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732387370; x=1732992170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeQpM+MdLH9rnwsrFxX05BQzAa2vTvwmG9Z9WaXtr4Y=;
        b=JCX8AItoF+91gzJNFtpsjL4TgdYlirkO1lWWveNVk0Zkvygw33c8nbSIgMAXm/ZgZH
         0ZB97iuDJwWD5u8fOUC82myaOPvyIc6hF2sbs92QyX3F5+H7s28iHNHaG3BaUly2Rxh1
         5gNbc+iO+774cHja+rfiUNxfEpmVQQf3/F+GC1I9yNd2PTrcFM8BaWChWjDzuC2BcaUL
         ltwByr9zzTYOrcQ/gdwsG9R8RS7IiwLN/aknsrFEOhC6ygoEZcrDYrNaHf0vHrwNkGDy
         6UUhXw+JJsJITsB6w09paaNpzO0psLhl7nVBiFTfP48L2m2gK0jfvu0JKS6EFOD+fzA3
         kAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732387370; x=1732992170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeQpM+MdLH9rnwsrFxX05BQzAa2vTvwmG9Z9WaXtr4Y=;
        b=NV8UAfbi/x1BBakJP93PDt2ySZRRG41rfisIXBdGt2y6JhRiTx5iTHX1dfYWj1AN7k
         8a52739jJ8p1t4najO9fGA2lo2OwHfksqXZ7EWoGDBi8UCZWlbkqGILwqKFh+Ersj3jd
         a6WM+IGodFzi91mI0XJ94EjP7eAIqduY6m9e4PexPabMrj6e7Pg/T1uq9vXSRKuTDSeo
         +baLMVLx5BFAFiWcuGBft9OSK7F74ssTzCEnecFnrSqWvfRb3zDW61AOFY5fQytyvcqB
         j/iAsoHX1NgM9x+Xq9x8lEOvci3mFYhVyE44oQkLGWvINunEZ1BXbYw3zZAAEmBQT2jM
         Jyhw==
X-Forwarded-Encrypted: i=1; AJvYcCVMh0xiGfTPEQSIOf24ev6QOdFEA+BOaE/a7BVawv84VImK6s+JiDwYVZ4QR9mLCyl+i/mOPjCr/msz16NT@vger.kernel.org, AJvYcCVv/0TeorXUh6xpBp2bHndbX6X0YCZUgeVs2cql3uQNTqJQY9+t+8pq6STQBvgpmmhGS3s3afMXReSt1g==@vger.kernel.org, AJvYcCWDS/ha7eHYzMsPhwQ6RdIWhc7SiKfEbb+9L45JrjkuEesgN/YF7EQYSaszEGqcfCBmZCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhnmsZowL7EZ8hFJf+ImTcN5wSPlTlWWT8UAeg1lgQhxGsSbf
	Ec7DxoKk0DcEL+4i/mNPZo4joHvAF1s9NqpaOazPPQ0xDl6/NyYV70hNVn2dJsjGv9MRkReEt62
	Ck6YZXJT/EoqNZukjo9YkGmjq1fQ=
X-Gm-Gg: ASbGnctZ44imUcbN71nIlDNl4VhouwHehA8N1/v6slZO9dYCrTHaEhzZjKoANmb37jZ
	QDJLuPaiozsm7ChI2kzvnvh7DsGmtYPk=
X-Google-Smtp-Source: AGHT+IE7ABGrwEDD3CIezt92ArUMYLU7G1TBgyrPiB6VL340nwSUCO4u3iLamC2z7mqmOPGpW2QjVwDFGezOSVvzSO4=
X-Received: by 2002:a5d:6c69:0:b0:382:31ca:4dca with SMTP id
 ffacd0b85a97d-38260b4d679mr5698702f8f.7.1732387369769; Sat, 23 Nov 2024
 10:42:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123113116.1983-1-ayushsatyam146@gmail.com>
In-Reply-To: <20241123113116.1983-1-ayushsatyam146@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Nov 2024 10:42:38 -0800
Message-ID: <CAADnVQ+ptV+YdjL3YTxwwqfhCcBQn-NRnci6_19GE0De9LkQwQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: sparc64: fix typo dont->don't
To: Ayush Satyam <ayushsatyam146@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 3:31=E2=80=AFAM Ayush Satyam <ayushsatyam146@gmail.=
com> wrote:
>
> Signed-off-by: Ayush Satyam <ayushsatyam146@gmail.com>
> ---
>  arch/sparc/net/bpf_jit_comp_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_co=
mp_64.c
> index 73bf0aea8..0f850bbe7 100644
> --- a/arch/sparc/net/bpf_jit_comp_64.c
> +++ b/arch/sparc/net/bpf_jit_comp_64.c
> @@ -732,7 +732,7 @@ static int emit_compare_and_branch(const u8 code, con=
st u8 dst, u8 src,
>                         br_opcode =3D BLE;
>                         break;
>                 default:
> -                       /* Make sure we dont leak kernel information to t=
he
> +                       /* Make sure we don't leak kernel information to =
the

Sorry. We're not applying pure comment churn.

pw-bot: cr

