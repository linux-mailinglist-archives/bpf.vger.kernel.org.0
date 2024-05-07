Return-Path: <bpf+bounces-28895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD6B8BE994
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7541C21AE2
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133B17799B;
	Tue,  7 May 2024 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egeU03Qw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02716D304
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100122; cv=none; b=UrAWyy2FN1LHX1bjjbf0MD4C9IIqWvbXFGS04/sinaiBTSXh0usM2t8kx3wRv6hl2NiSMgsVeQRlYes2/WVqt2Lb0r0FfUMxMb2a2Zqe94WH9PHvbHcbnp11oVOZX2NbAjjMBMV5l5y2li69KuPXHij/QwMajDEtVDTHv0L5p/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100122; c=relaxed/simple;
	bh=qwLC5cBEd3Rp+u+f16eiuFja4w0IZlh93r+rs+D4dcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezSutX85oXgW5XRuzNnt9sqqAu0wGjHxjUcJUiNtrmFh7Gq0uVgTotkC/Cc3LSTkfvEimvERFJR+NfUtT0mXdZMnYyfsZN84LpTNOgkOU9D9L0HPUTCXPk4bpVJd4+Kqp0aQZ5gUoftnhW343aDzp2enm+vHF/B4MzqGYFMQNRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egeU03Qw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so29739125ad.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715100120; x=1715704920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu+lGDBpGzq9v1NMqEEDXxvCQ38ypf4jopzyPJIzoiU=;
        b=egeU03Qw+XA1GofQHQQOcf440xbZhHwm2qrIBDt3EArUh02jDxcYsAZpylJndFUKEB
         sAfDNVru4z9FppYk1/1VwPTydmWoKxJ7S9MIOKP5JJLo3Udb0u0NdLa/U5/Pg+zAVpgC
         tvBwSALFJhrGC2oFMLuRf6a2BHH0GxknXvGkafWYjgSvkXW8YtaehDbTdWYbn4zyYZhl
         m4R6gniMd2jzQICwE8MuycqoEP3+bmzJz5yin3ig2AtkD/L+hkkjQmGBRskQHml8Yt0F
         d18Yr07Xu6YgIOYXrAKuAaZ6G2o3oyU48gcqU1iVq+9d+KI5buN8mYWCRY27Je0+Ub1E
         hbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100120; x=1715704920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qu+lGDBpGzq9v1NMqEEDXxvCQ38ypf4jopzyPJIzoiU=;
        b=poWPbse4QpEta41mw2GzvpsBKlnyfBDLRwjkES8x7e48ZXWsUsuJHaZd3VwFRoaQ1G
         N1l/f+0xoKd7Nkg5I0mvW7XCivguTYuv0x5XmuS/c7noP/3AB0Sjx+M7kLVjgMOYhJYH
         22Fg+Ugd+6tOhibbK+1Aa+z15dUz+nYdKI8LQs5nUwCV+RtkvWxXHFtKwVzJB1Xo0AMI
         gnDuvJN8inUpmN6whzdMvUxIIX2kRieIjTQe8eWxciydfv7DVhXJI88hXExDOmbjxTPR
         vviE7V7hNTfAqXeLCmQ33knlyE4yC9bCpL5GHEmOOLDvaiqn08CTb0Nwtjo14IqUtax8
         g8fQ==
X-Gm-Message-State: AOJu0Yy82onuGkOMhUpAC1eg7M9hknbVNN8Fkq5BhMac9iUvUhLwK37h
	NKnxMJWI6RsFYtaMIsUZVaVhHfsBSwKV/w32CKaaveVQ/+reZ+x6JkCx3yGJJ9SWwA+J/UZeA8M
	I7HFKynY9iq/g79NCUha1Y7/I6nM=
X-Google-Smtp-Source: AGHT+IE+LIUE1AUihTHW0R+1wqdyTgsVw+2u6a9qokXD6K/SUxmvP9KRxbPngazoD1ft53xryeYnVv3dTYqIfEPH6Q4=
X-Received: by 2002:a17:903:228f:b0:1e8:a63b:d427 with SMTP id
 d9443c01a7336-1eeb0791c73mr1743755ad.49.1715100120550; Tue, 07 May 2024
 09:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507113950.28208-1-jose.marchesi@oracle.com>
In-Reply-To: <20240507113950.28208-1-jose.marchesi@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 09:41:47 -0700
Message-ID: <CAEf4BzZ259J6M+y5xVakycqVPgU3vjP3_qWFMuyZKDkVn68ysg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid uninitialized value in BPF_CORE_READ_BITFIELD
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 4:40=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> GCC warns that `val' may be used uninitialized in the
> BPF_CORE_READ_BITFIELD macro, defined in bpf_core_read.h as:
>
>         [...]
>         unsigned long long val;                                          =
     \
>         [...]                                                            =
     \
>         switch (__CORE_RELO(s, field, BYTE_SIZE)) {                      =
     \
>         case 1: val =3D *(const unsigned char *)p; break;                =
       \
>         case 2: val =3D *(const unsigned short *)p; break;               =
       \
>         case 4: val =3D *(const unsigned int *)p; break;                 =
       \
>         case 8: val =3D *(const unsigned long long *)p; break;           =
       \
>         }                                                                =
     \
>         [...]
>         val;                                                             =
     \
>         }                                                                =
     \
>
> This patch initializes `val' to zero in order to avoid the warning,
> and random values to be used in case __builtin_preserve_field_info
> returns unexpected values for BPF_FIELD_BYTE_SIZE.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/bpf_core_read.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
> index b5c7ce5c243a..88d129b5f0a1 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -89,7 +89,7 @@ enum bpf_enum_value_kind {
>   */
>  #define BPF_CORE_READ_BITFIELD(s, field) ({                             =
     \
>         const void *p =3D (const void *)s + __CORE_RELO(s, field, BYTE_OF=
FSET); \
> -       unsigned long long val;                                          =
     \
> +       unsigned long long val =3D 0;                                    =
       \

let's add instead `default: val =3D 0; break;`

as Yonghong mentioned, it's not expected to have invalid byte size
value in the relocation

pw-bot: cr

>                                                                          =
     \
>         /* This is a so-called barrier_var() operation that makes specifi=
ed   \
>          * variable "a black box" for optimizing compiler.               =
     \
> --
> 2.30.2
>
>

