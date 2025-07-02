Return-Path: <bpf+bounces-62173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B991DAF601B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188911C2837C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA44309A59;
	Wed,  2 Jul 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsBeu8Fa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C7309A4D
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477783; cv=none; b=ADKRthvJyao4R3OFnO5FbyHpHY6Iye+kE9iwOwrete15vn+hjhK+Z8AX2caZaP8Qtug1iElvB5ixqEfEes8k9eF2q/TKCTo7mLPJXlg2EaXp5qW9SsAtWhnFLWvMYCvlS93J31+mB5YVD1hWnI/rCVG7X+tr1NE1uxHbVdsopsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477783; c=relaxed/simple;
	bh=iNEqxIRxFkZ2tOPGuk1X+VRy4cuwlJPyq0+aynJtr6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gohRsoEnzG3Xa9Fja2b839/u1GU/L6n//t3ys9AgsnRcwMwvAi/S4MuMz+GHPP1zF/QpTYhbCTv36RWqmmfSo5KO06XOombgibedccS3YDuhRioWhD4+kv81rzNUveoRo99CQSbpmAOwnGXh1/8Vrde/TrKbE91WwxChi4MGPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsBeu8Fa; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so171908a91.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477781; x=1752082581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRuSZiUGwx2zyiDVB/m0YShR1/ErtnRTVPH3a5MtW4E=;
        b=NsBeu8Fa2HQedKwGS+dPPIVjpXhRShsBuzQ6zacSJcPdkcMi+fN/iAitwZmdHu3eMp
         39omvsyBUKCCgySkjOrvIlitOIYOFDnfk4IbKyBf2JbVBFoJf4c2dzVRZaEBRhzQ+OMp
         n3DiWB1gnudNzW2xFtggHFC3Pz7c1cg451tJZiXUScGojq7U4/rdgxD3qAbO5zX91y5r
         YyUaboxUCHccNo7mcW4JaGkcZxpKZjkkDKAqu1ZoislhEWfwM8gQIIDEN5Lv2Rku5Jot
         WBaExnmdzIqwJwzJ99USelsECtXxbi8ObEeE5shKGxw3qwBG258TDAJwjkPChKANC8c1
         jjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477781; x=1752082581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRuSZiUGwx2zyiDVB/m0YShR1/ErtnRTVPH3a5MtW4E=;
        b=h3zvQJ114IPX5CLr6M7/59toX+HqbNGrIJepGMpcrDxE+SN4oX95MJbC0cPEVnYVOp
         hFwWhgXo7A+bVBEtNGQXb2VcEVEWtp9HF/afZmsZqR3zLMQbeqBI1L4kOleUe4P0fFSt
         Qa/vykjXCjtBifqmKvtY9zPYH1WFoo6b2vxVXrNTN378yqSFv+yRDMAek39IpC3y9sg8
         C7NqUZ/M+yTBJf1iIiwd3LXkFuSAZJ1VqT1/nPF8HD8CTjtkUVrLafY4PcorQ1MkbkE7
         9IxfNQydip6Wgz7+65/PmO8ueGv7icTWYF10kkym3jMDDzCWVeY+dBNkB2JC+bRkBB11
         S+OQ==
X-Gm-Message-State: AOJu0YzzeUDNDntxYihiP4Qbwhvh8ZRCeEm4MyWROOh5Hu3IsCM2xapv
	lYJU9m2QU5mqRzJbp0snb1a8j7RBLjV7pkHjnf+YyR5Kg3P7dIFkZgHGtO++LYlm5lbqML8YTBz
	Y7yEqKQ4rnK+6R4g2fT0xHmCYRJIoGnQ=
X-Gm-Gg: ASbGncvmzebMVjV3NZ6lPXusGL7apP+Kk90QISX7g5UIB/o6UyTIjqvhP34xEQJS3Fm
	Y/Yz4ruMYSTOcA6TK4POcJLuatqH0+lBqwMn9LdZ5TgHNNIrZmlfQzuM6FeD0LuUMvg+e7V5IV1
	JEbj4p0iMaSRHtb8yoVFtO9f7gagFlQPkHzKon26jMmB1pWkcBdZtMS+Zu8Ms=
X-Google-Smtp-Source: AGHT+IFUK2fcaK5X1BW+GK0uS1TTKK+QEJ9Pi8frGdeNrqCSbywdqSByBa4B9c/zwVGiwQQ5DFxq7S37rb3W7azFfOM=
X-Received: by 2002:a17:90b:5147:b0:313:f995:91cc with SMTP id
 98e67ed59e1d1-31a9d08a64cmr597183a91.2.1751477780961; Wed, 02 Jul 2025
 10:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702142621.295207-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250702142621.295207-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Jul 2025 10:36:08 -0700
X-Gm-Features: Ac12FXzot4rqxnBRGLrR6OLOdwDzVTm6mKvdb5VJVQatjzLUMXJS7ouyDp1sSLk
Message-ID: <CAEf4BzarHgqhm8UNiviDCgVeo8bRJw_iCaFtTD395W0gDPKrpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: allow veristat compile standalone
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 7:27=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Veristat is synced into the standalone repo, where it compiles without
> kernel private dependencies. This patch fixes compilation errors in
> standalone veristat.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 09cfbd486f92..4b79f00b0a9c 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -23,6 +23,7 @@
>  #include <float.h>
>  #include <math.h>
>  #include <limits.h>
> +#include <assert.h>
>
>  #ifndef ARRAY_SIZE
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> @@ -239,6 +240,14 @@ static int libbpf_print_fn(enum libbpf_print_level l=
evel, const char *format, va
>
>  #define log_errno(fmt, ...) log_errno_aux(__FILE__, __LINE__, fmt, ##__V=
A_ARGS__)
>
> +#ifndef __printf
> +#define __printf(a, b) __attribute__((format(printf, a, b)))
> +#endif
> +
> +#ifndef __scanf
> +#define __scanf(a, b)  __attribute__((format(scanf, a, b)))
> +#endif
> +

let's maybe just use __attribute__ directly instead of __printf and
__scanf, to rely less on kernel-internal convenience macros (instead
of redefining them)?

pw-bot: cr


>  __printf(3, 4)
>  static int log_errno_aux(const char *file, int line, const char *fmt, ..=
.)
>  {
> --
> 2.50.0
>

