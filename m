Return-Path: <bpf+bounces-63428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D358B0752A
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1384D1C26ED0
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33352248B5;
	Wed, 16 Jul 2025 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOVYVcrw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50832F430D;
	Wed, 16 Jul 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666960; cv=none; b=a/o3uDF8VHTFmuAceJkN+6yxGTmnrlAuzjJrq8w0N6Mz5PjJYkLwEm96w52aJyJYMqaEm7BpmyuetBn+lsOWJ/HloR/19DxL/UaD8Aj5kw4EEFzdH4hjyw7sWliJ5sCZiVJEvMbLH/0CTAvmCBQu1pBzfZbVJGSC4lWfj8Bl1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666960; c=relaxed/simple;
	bh=46KRWc6CL8rDgHI0Ds+dVS1e/7PnwHqn6Cb6seF0cFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=debzadqBzkbcLp1HTKZ46qFuOiQU8dBvbTMRB94Jw62w2vyOnMRY4dGrXMpp3G4x8QUFnvPdkNjkafgpbDM4dLoBkG7cXe6/x7xybQQD6GP3lIUwjswf6tM3Kn58RJSzpmJyTF+sKkOX+KvS7aHOcTz0tUco7p6CEdBNx1H8hxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOVYVcrw; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61598534619so746225eaf.2;
        Wed, 16 Jul 2025 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752666958; x=1753271758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgpuWStD+g9XlsGil0a2qM7CDtMSHNw/qYVDjYHubzs=;
        b=eOVYVcrwbGTJMDixo3OolOWGc3/yHj8Tuh9Kv1DrJrXnEKM73vOenDbZN3Dx3VChNv
         1qv/r/VTUPMOgUxxzw9Q95+J+vLMPTSGrpQqSEnMzSTFyu7FFknQXFIowYZHAWfaznkF
         YKoXPWZzBGCUga9vyhRhL4TFrbiB+7thV61Gf4ykyFCIIUT7wPZxvbAG1uT5BUUc9GZg
         ESwyNVloLs8+ghf983lv6qtG5mSaOy/E9HmPCqrljG5BC3ec+Jacc9rlwdXfJ14If2Dm
         U4GVYc9S05lGwy0JGLXs1ctVkLw4LUgHd/FIkLIxb1z2KiBPseeOSoncq/0zadUhOJ/l
         iILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666958; x=1753271758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgpuWStD+g9XlsGil0a2qM7CDtMSHNw/qYVDjYHubzs=;
        b=gvSpFBPUTt7vHQxNvXEYsbBShUIXhKkjeUdDkdfq9bgO99Jj5n4TYXbs7youHFFZwg
         8kwWktn1i7WM8kiartPJYZp3J7UstGsdqlOdV4UPDnN52sKYDB3AYYnzNWzTorLYoNwz
         gz6gF0SPwzb0BRFWAjDFrMJBe+PJ6I/3NGdEIakYobE4KnDmqzoR6zSCf82zEEdi3jPl
         HZhwpvJPtm16bcCXSieH97Rk3XXPYDmCO++4GBa2khkJt5rE+ntQeJR8OvQXxeb8u8pr
         FsRIs7L1KxD18yDZkyC5kqvUXiR1OloedDlglk8xSA1JhEYOaWfsZ91LiLzK4xoRNo46
         LpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyyL9Hmdw3e0sNrkg0NO2qEyVKVfiIynyTrYJFdrOEBgE9cxE70JZu2NPZ+QW6iu12d0h2R572UsVYPKN3@vger.kernel.org, AJvYcCVxhYmjIsnJb8CFDgbsPv92YRcK+WSkHgM2noKKVOvuyHGCsUvNvQW/VPuH9/5uLhiztn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fxA1pi1oI8jef7p67uGlxM8H1a87FB9Nm3EoSOhM4YMSJnU7
	4jEDzqwZs/NSAAc445HwojDLhoy7ljchVSAvAIf1RdV1+xqoWJ8cXwPH7/QGsmFLDBI9eJDFNgV
	C74ISHO5dFshwyWJAFFdsQMSTIf8wNzs=
X-Gm-Gg: ASbGncsIPb4UBfiDi2mkPlIZ1hsqoCTVITytFV2poB2dC1IyJp7S+Z9dmtI7Mh3/jo8
	a4lcA0mgHPOxfB5rmbYrUlp+SxD+SkFjgK6S7LqsfQ8C9MAVLsBz2jR5IyG8rcaki8OAl/g8ng+
	wpdJtyMeoJDgxqpNtRCar+Qx5TznXFNItsg8EiH6JoqUtbstpg5Ym7UO5oNgej/LKjeAVQMkiLG
	n0pHbE=
X-Google-Smtp-Source: AGHT+IETKnvezmKlq+zmC9uwg6Ch1WE6f4Jt7hYDCbTCtYguhAyXT7+KyCQsYA1VXTT6YMNAqwQVB9dyT+azQ5SC4qs=
X-Received: by 2002:a05:6820:1e03:b0:611:a799:cb65 with SMTP id
 006d021491bc7-615a1ed3996mr1490965eaf.2.1752666957689; Wed, 16 Jul 2025
 04:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709055029.723243-1-duanchenghao@kylinos.cn> <20250709055029.723243-3-duanchenghao@kylinos.cn>
In-Reply-To: <20250709055029.723243-3-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 16 Jul 2025 19:55:46 +0800
X-Gm-Features: Ac12FXz_Ud4KBSmMLY9gQ2gi1DdYRSZe-UgrRD1--igSRHmSf1PEp6zyl_Z6UoY
Message-ID: <CAEyhmHSs5Ev5LBp8KWDnK93NcJnfvVZPy=X80Miy9PnP4rMA=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] LoongArch: BPF: Update the code to rename
 validate_code to validate_ctx.
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:50=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> Update the code to rename validate_code to validate_ctx.
> validate_code is used to check the validity of code.
> validate_ctx is used to check both code validity and table entry
> correctness.
>

The commit message is awkward to read.
Please describe the purpose of this change.
* Rename the existing validate_code() to validate_ctx()
* Factor out the code validation handling into a new helper validate_code()

The new validate_code() will be used in subsequent changes.

> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fa1500d4a..7032f11d3 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1180,6 +1180,14 @@ static int validate_code(struct jit_ctx *ctx)
>                         return -1;
>         }
>
> +       return 0;
> +}
> +
> +static int validate_ctx(struct jit_ctx *ctx)
> +{
> +       if (validate_code(ctx))
> +               return -1;
> +
>         if (WARN_ON_ONCE(ctx->num_exentries !=3D ctx->prog->aux->num_exen=
tries))
>                 return -1;
>
> @@ -1288,7 +1296,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
>         build_epilogue(&ctx);
>
>         /* 3. Extra pass to validate JITed code */
> -       if (validate_code(&ctx)) {
> +       if (validate_ctx(&ctx)) {
>                 bpf_jit_binary_free(header);
>                 prog =3D orig_prog;
>                 goto out_offset;
> --
> 2.43.0
>

