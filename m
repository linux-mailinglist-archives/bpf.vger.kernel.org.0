Return-Path: <bpf+bounces-52471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F985A4323A
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B47616F026
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C015E96;
	Tue, 25 Feb 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApBjI4dQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82978F45
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445450; cv=none; b=iYZTAUt5kZYCN4Hdf5+VVzh4vPeZfU5VB522pn2dN95B7EUbNnutnzDbrAEapkOn6BZfy+9yL07KgTcmgQdR6s/adcwHf15SocVHVLDTLSFbwdrCbfsyttpBqkUqQHE5m3OojFkE+OxowM78qhABPjPBDYBQ0Sip+7AA5AUdONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445450; c=relaxed/simple;
	bh=sA9qxMGfft8asaBiBLeKwN1m/XArVRSyWnuemql+Krs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjnoCiBTYHNRxVDa87yCT0o3d7Gaw5568ibSS4eHN5gRhe7jC5uRN9tM+PzfKYFKOxGKn9lNOrXe6d3qb7bWQEUkcED1LJCAx23H3M+zkDB5RVjfGUepvZXFPM4CKmXHtUDfoQoUuB1CNE+R3/GltKan0v/Bch3ZgJKF+auH76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApBjI4dQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso7685129a91.3
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740445448; x=1741050248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu2p90DGFVlepmbpDO8IFYTqTzx8qavHR+MblmdPsy4=;
        b=ApBjI4dQAWrTe3FYMY934N3uVofp2kPNgMv07ld+MpJZsk8WQCXjfOz6b5AFYq0laS
         jyYl78ppQ1eSiRTrMCKSxgsT/4LT0yIediXg3u/VXW5TfcY5DiR9eY7fAIzkm5o5nCtx
         WjFM6yU19NRt2AG6Jcl1S0XQInTikCTzxJFp2RyLZp/0iJjdnV7ts6kNOnWQ+4YyxMJq
         cEnAG/LZu2SIQP32Dh6uGxe37NBZFXSnsZVlEQD8cRrfzGZ4bgZ26NuT1S2EyicdKe7n
         MPwP8TJt+fN65txNnz3PtdKcCsC4mK1gBP3VOWv0UfdZE9ku6tQBrUvur/7UZVApaMUv
         VR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740445448; x=1741050248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu2p90DGFVlepmbpDO8IFYTqTzx8qavHR+MblmdPsy4=;
        b=BEAWBFl38CMWX3VdYV3LQnzfsgP4Af58VCmkHzQhW7racmO2MdyLofkCIyeniRpJEd
         Xlf06wt6JiaTLKdbHI92m1qvpXagBhyJR4imNZ7lKeRUlBDfijDptw9okQvd3sO118fD
         eh7X3NJdpdkClRq9T62pHz31e3d+IoXLnk41ToaciT/T0b6+7rjf9DodhAcEwl8xsbfY
         NUtc3ZDgALwSS29oOELIVV9cWcqGiTFv/28NFU2kuJt5bQqT00/ZFpTEy+SbZCygu/Lk
         vd0ffr01U5QSXRd9KfOaVooBdvNq38o/5672Y4Vwbho2DNKLU6mn9TyGeT+bxxyE4ope
         tRCg==
X-Gm-Message-State: AOJu0YwZmo+ReRGeiQcC1W2uSelGOVi/E2MfhZAlZtSmSnEW0KXJQb4K
	HTTW1gmXKTFUZ6QatndwdwLFL+tsadeWcPz0HeZydE8MRZ6Kc4Bi6D/eWnu3aJJSqTEArjplDyX
	mHkTIBeDrOrMq/hRnfqGkj6aVuPD3d7pS
X-Gm-Gg: ASbGnctam+6I2p2HDEYsXCmbXKT6fqmBxHn6XUuqTOndkB19vCTdidHneVoDh0CwjcC
	LSjAy0IHOuazS/mNlFVkAYqGyNNwkcV7SnxVlF8+hgkk+jaV+59D4LCN9xErcE5qbbRuSyE2+Nx
	x0q4foirNsY6PrXPyw5CzvniE=
X-Google-Smtp-Source: AGHT+IEAisVGiCHlV0cLQCxcbSYefdC5rWSZLYrFpGCpIq5uUFrlyAzoZRCzXeU0vaIC1yc2v/VAiDSlP+Tg9x0A58E=
X-Received: by 2002:a17:90b:1b44:b0:2f2:3efd:96da with SMTP id
 98e67ed59e1d1-2fce7b1129fmr27458686a91.24.1740445447745; Mon, 24 Feb 2025
 17:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225003838.135319-1-eddyz87@gmail.com>
In-Reply-To: <20250225003838.135319-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 17:03:55 -0800
X-Gm-Features: AQ5f1Jr_CtIoxkRlThVI7Ek-R1CD-O7isBmxsXQ5RknCqPPfZJKZ1-wYBsSyw30
Message-ID: <CAEf4BzYC9-w6HvRfkkC_kLpizfNTYJLgVTh84ptOO7ncS3QRwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: abort verification if
 env->cur_state->loop_entry != NULL
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> In addition to warning abort verification with -EFAULT.
> If env->cur_state->loop_entry !=3D NULL something is irrecoverably
> buggy.
>
> Fixes: bbbc02b7445e ("bpf: copy_verifier_state() should copy 'loop_entry'=
 field")
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

that works as well, thanks

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5c9b7464ec2c..942c0d2df258 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19340,8 +19340,10 @@ static int do_check(struct bpf_verifier_env *env=
)
>                                                 return err;
>                                         break;
>                                 } else {
> -                                       if (WARN_ON_ONCE(env->cur_state->=
loop_entry))
> -                                               env->cur_state->loop_entr=
y =3D NULL;
> +                                       if (WARN_ON_ONCE(env->cur_state->=
loop_entry)) {
> +                                               verbose(env, "verifier bu=
g: env->cur_state->loop_entry !=3D NULL\n");
> +                                               return -EFAULT;
> +                                       }
>                                         do_print_state =3D true;
>                                         continue;
>                                 }
> --
> 2.48.1
>

