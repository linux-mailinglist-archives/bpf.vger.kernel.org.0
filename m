Return-Path: <bpf+bounces-66301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFFDB3225F
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 20:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972B3B2170F
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397E2BEC2C;
	Fri, 22 Aug 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIdmWRBq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB972BDC03
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888219; cv=none; b=EUNahK5+HVMLux/e7bUFMegg+DiZS5E9CBetFR/M22w45sbrr2OS7GehQPP9JLB5+Ib/+QHg3zKYOn2n4uFZk9quTggKiY6r6yKthc2J9rN+tXqviOHRQ9LLofe2UBCs48NjTEYk5sE74aoTiL1bYMzO7PnBMuRhyZ45V5i9M3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888219; c=relaxed/simple;
	bh=dxkVD+b4M1nrUZ2Whc+sjYjTzOsWbtuFCZNW0FlJnoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hW0CV3w0lzlBcKzIDqTKh1Uofvz482e6mOCvXpj5OtGCEztvHKAN86eATVIwHo8FqZwIYgg63MJFaLEnQvA8/AwViKrfiMgyhT/yGaUFqIJ094y5APaXvWoDM/nPqfvdW5CBu1MU8TKhkpvOE/MdYmI4TLMXWG/HKi6WKG8X5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIdmWRBq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326793a85so1677445a91.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755888215; x=1756493015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yrP3A2wc1sdHVj0Mjd5Q9CFRSUAOQeMpXsZFVELhAE=;
        b=YIdmWRBqVRn10i9HjhHYMM6uHLfnPvNzNACp4qurdL6XfT2g+zRkDqsOQEBkLHjc/B
         MpHFkRsjwtnas+axbbhKo2DZKnu4RDxQPR3zBVHXjCgKf2NNL2KCQyhfRB/0wKDZL8Ds
         J3f8y2tQDDlzSUVHub9WagTGGbm/AXGj2ZovIuqszmpOkN09y0aSVD1mTQMHALopx/wi
         QQSSClDFXZRRxuhsffPNV+jeYAm01qDW08Dcshwzf0VTKKSjGUTpwkG+qUyZHqa7b9sD
         BQ5/g9+Wct5HYtsdjOftdX+Jj0qxXB7BOa0eYyryyjPbEzwSTxct30C246eeFjNItbwq
         lALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888215; x=1756493015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yrP3A2wc1sdHVj0Mjd5Q9CFRSUAOQeMpXsZFVELhAE=;
        b=PgKFeBCgILpzBklLOoOIaI9E7J3tf0w6sMbrf55fZ5MYNLO8eQFVw2mGI4vzXumlay
         VXSjOxnfLSW5CrSvUlEeZQSDGXkSO0Fu/2If6q/+sHMCgt0TRsU8ATFQH+Xmu5DNBtie
         niFNFLTUAVbC6QghXsyCiUrkbszRrp8drM2HvAa1aZfJg43225+nN1hYZb6AvNKYT1Jz
         W8PukT0l9sclLwCDULYVqCLSyHV9gI7MXk2X2jkAcAsqJtgaClCEIeErep31Rxw5+NEu
         KozPl9x+reJc3sVGWLDHu5ybepBCT/9mRfxk5SO+cjX4DBJMle3ciZD5q3EkuqsfJpbf
         57mw==
X-Forwarded-Encrypted: i=1; AJvYcCUnMnyVozjPU6q+Xs/0Y2BptqN+HbzhQryP2/kYwAH8rJoXk+JuInB2ziy6/UciNgtQ1Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jMx/udajtvq2Q1fLvPm4c9YPIO6/Ww+8CqjsSI0Og5w+dG9z
	qCIuLLV74OML1w0Ym7e0xXNK6Eunfjj4ZMLjFccFtLVQnYcO4w2tz2LeeI15VSp6K5ufhx45zk7
	NGqrcNIKn3rCy4Eik5pWkR0Oo2SKwTSs=
X-Gm-Gg: ASbGnctzMnjPBcC8iQRipEZVgbPvJVsvCx4YWC3Gtc2qazAOlPQeCxys0s/KHF7Tzi0
	R4+ZrIJ5ARPgAIbh9GdEeo3YW3dEXO9v7A3kok5cdFuIReDQCNl39yJx6SC6q6EPbYPew62yQ1e
	LzVnzmGA/rylcAhCkpAn0dccYodHhyP++LU7dB3c7Hs9OyWPI3FsSAGN6CRIvkRgaegaj+Mu/RA
	7tTFjQnja/fvx3TYcX5qVk=
X-Google-Smtp-Source: AGHT+IEUXODzWS3pCnGwThbAnGSrXVApyosNmeapYZtj6MDSpkysw2w1jLflsuKy2DvUUmRQ0vvEUuK351S2Mcttzog=
X-Received: by 2002:a17:90b:3f88:b0:31c:36f5:d95 with SMTP id
 98e67ed59e1d1-32515e2b881mr4766831a91.2.1755888215349; Fri, 22 Aug 2025
 11:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819111953.3197428-1-chenhuacai@loongson.cn>
In-Reply-To: <20250819111953.3197428-1-chenhuacai@loongson.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 11:43:19 -0700
X-Gm-Features: Ac12FXzrYOzfj7i2cMKRVyTzQec3hNJbudkkDPYSdzi9TGgGm2mcwIbyXDmRGsw
Message-ID: <CAEf4BzajrMOkdOX5fn=bzWVTLbObPM9=_4Nh9rm5oc_4377Pfw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix uninitialized symbol 'retval_off'
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Huacai Chen <chenhuacai@gmail.com>, George Guo <guodongtai@kylinos.cn>, 
	Chenghao Duan <duanchenghao@kylinos.cn>, loongarch@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:21=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> In __arch_prepare_bpf_trampoline(), retval_off is meaningful only when
> save_ret is not 0, so the current logic is correct. But it may cause a
> build warning:
>
> arch/loongarch/net/bpf_jit.c:1547 __arch_prepare_bpf_trampoline() error: =
uninitialized symbol 'retval_off'.
>
> So initialize retval_off unconditionally to fix it.
>
> Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support")
> Closes: https://lore.kernel.org/r/202508191020.PBBh07cK-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>

Is this something that should go through loongarch-specific tree?

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..a73f6ea4ed4a 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1504,11 +1504,10 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
>         stack_size +=3D 16;
>
>         save_ret =3D flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FEN=
TRY_RET);
> -       if (save_ret) {
> -               /* Save BPF R0 and A0 */
> -               stack_size +=3D 16;
> -               retval_off =3D stack_size;
> -       }
> +       if (save_ret)
> +               stack_size +=3D 16; /* Save BPF R0 and A0 */
> +
> +       retval_off =3D stack_size;
>
>         /* Room of trampoline frame to store args */
>         nargs =3D m->nr_args;
> --
> 2.47.3
>
>

