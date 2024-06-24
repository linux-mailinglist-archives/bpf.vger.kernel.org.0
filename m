Return-Path: <bpf+bounces-32941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1BC9157B4
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D11F1C21ECA
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B11A01DD;
	Mon, 24 Jun 2024 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuCX+Mj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859A567D;
	Mon, 24 Jun 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260126; cv=none; b=hSDXd54Io0UaQTRoACbgxB3EqUhBhY9KnrHxSfoQF3LwewTjoxJqSXlXf+PpsGRZUnMsivriYAc30E40wl/rxViY0cvYaU32RBWx1GKLpMXb8MFrbNJAEkKPnCXLxThDHvOh+MPVN+13C9dB/Lk21BZpTbw9I9K2HMfvBkXl3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260126; c=relaxed/simple;
	bh=aVkOK88AkhLmTVM6VEAF1SVUngOXxAhrap9TMQSyhOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+cB5TKggY96A20ACXT21cn9zHMXx5YSbx2cGaYFH9HeuzDAyEQS2GHNA03CXPB+r11BLMcPQBwosMuDiU/+8RAbI9AixI4xw8lmeNXOw9NiPLTnl4dCXNbLUbm+7vkuwRI67om3oz27CyDKqQoCxPgAOFJROxBKf/2ovOprQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuCX+Mj7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-364a39824baso3497794f8f.1;
        Mon, 24 Jun 2024 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719260122; x=1719864922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XoPGrz+J640jf8Qz52xgWMn9YkrrI8mbi/FnE4/1pA=;
        b=TuCX+Mj7jnvHHdQbece9WssB/rUpJGX0vewYpCf1jNFw1wKQ4pxXj3SOvWYI710+nv
         7LWVqieMERpGur34lltb9jNplhFFHghgmJwH7nQEl7u8r5FmMOuGLMnCawZ4+ywCXGwj
         EKP187OM+oqBgVx2iK1/nbs9Fnii6P/wTq0hSshDU41q+XZtTQNoIGpPGqrxEOElXMyv
         LSdLPt8QvxU+KNIMoHSfZf+2ZnIuV7To5ze9smCTk/FEPcWDkUY3+WbC0EEA2FEoQepn
         6FXb6FOrC0VolgCjRrVsC5eH7jA/w8w5pCaV54yd95azv9LeguxSn2H/nNokNWpTHMCS
         dpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260122; x=1719864922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XoPGrz+J640jf8Qz52xgWMn9YkrrI8mbi/FnE4/1pA=;
        b=ot1y+u/ljAd3pgLqy5aaBCzm0evpIG2a5YF2Tk1VcxWs6BTzKBHFtelxqDjT3y7dyr
         PIwMEQcL8Rydh6eDcjEM4ssy8/H9nfN3PoDDBqIF7fZksqoXa6hIMvpBG5VjAJ8IK9PO
         z5JiL1WJycJ3VKJAepz7p1xyKHQmPRckI+6L7I5dOzGKpFv3EcjESmyItxeqBBcPzKJb
         /9/ov/SEyBkqLClZrroMunhW9icT47HH/IOs3l07UQ2YvzjgPD5NLiRmk8JabnOAiuPD
         x0bU4SFs2X5DC2+PYKOyv9EltjRmvoCuXm9EDU8GtdIJj+KpIdj+BXFS+vDxeeemE1i0
         roUw==
X-Forwarded-Encrypted: i=1; AJvYcCUGZHd57itBfe1T8kD2nu9nhS3SOTQuwF+4g/+PT4etFa+Fob3aU11wji0Uq9QE/NKo1tUcWtS24TZUohXXLmufrajHLYA5TZZTHgd72b9fz7t5wkl/l16fOVnXMlwMf0Dj
X-Gm-Message-State: AOJu0YxK6aClXu2AYpmhRj11Pg5Tb8kOWKA4HtRDX5kf2V3+YpK0rU23
	De/PwmSzyN21L2sxCg3lfHJ4x1deqOvzqivec1AIIJaYiNOMcp5eX8PGsN/dfawJ8t/HRObEfzL
	mpvbPZi4lfqQi9iZEx4suIq8Gyqc=
X-Google-Smtp-Source: AGHT+IHag9dlexMIAnzbwEYQHNUn7hDAVMEOkIXphuPM28zMNtn2XzmpEHyqSZXarRr6Zz5PEtyw4tnEhEnnh6R7qkI=
X-Received: by 2002:adf:e412:0:b0:35f:2366:12c5 with SMTP id
 ffacd0b85a97d-366e79fe9f5mr3827971f8f.23.1719260121970; Mon, 24 Jun 2024
 13:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624195426.176827-2-thorsten.blum@toblux.com>
In-Reply-To: <20240624195426.176827-2-thorsten.blum@toblux.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Jun 2024 13:15:10 -0700
Message-ID: <CAADnVQJ6A-BUwa85-4Fg7vn1vWb9e_mVgvegtd6WKYM0Opysmw@mail.gmail.com>
Subject: Re: [PATCH] bpf, btf: Make if test explicit to fix Coccinelle error
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 12:56=E2=80=AFPM Thorsten Blum <thorsten.blum@toblu=
x.com> wrote:
>
> Explicitly test the iterator variable i > 0 to fix the following
> Coccinelle/coccicheck error reported by itnull.cocci:
>
>         ERROR: iterator variable bound on line 4688 cannot be NULL
>
> Compile-tested only.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 821063660d9f..7720f8967814 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4687,7 +4687,7 @@ static void btf_datasec_show(const struct btf *btf,
>                             __btf_name_by_offset(btf, t->name_off));
>         for_each_vsi(i, t, vsi) {
>                 var =3D btf_type_by_id(btf, vsi->type);
> -               if (i)
> +               if (i > 0)
>                         btf_show(show, ",");

Sorry, I don't think this is a sustainable approach.
We cannot fix such things all over the kernel.
Pls make cocci smarter instead.

pw-bot: cr

