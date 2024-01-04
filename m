Return-Path: <bpf+bounces-19009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C69823BC1
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 06:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE321B23C4C
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 05:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCAB154AD;
	Thu,  4 Jan 2024 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhJdvj02"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD71862D
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5d8a6730so1243545e9.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 21:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704345716; x=1704950516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USbteRFcAP1waCJ9q4tmqcMDno8SwpXvhOc9Le47mMc=;
        b=BhJdvj02saCD/h9AmaswP1BFeVvBp1BKw5FE4E1Nw/7Oer0Ay9PbTiR8sJyqMxVuVy
         HgtQUXBMuKcFT+srM+tFMTsSQRMgYEQ/csgJ+fFv6rk4hBxIWywm/8OylDaxhQwOl0aW
         VtpXBrr3Ny6N9D2LULke8zIjbnxlBD/HTLUoIqoAOks356RNT6CBkGb3bq7xvRSPbQpJ
         OIBEkLwS7Q128odYtF7vsvJ6q2pFckLUEKdkYWR9uKouTAPK8U48AiXCv6mRBPRfGHEf
         200UaOkyW3BM2wXBzeJAR2FaliZ5xf29PSP/xzt2jkIMwK6GizoBlIbF8pVw5Fi4ekvC
         2r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704345716; x=1704950516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USbteRFcAP1waCJ9q4tmqcMDno8SwpXvhOc9Le47mMc=;
        b=ks6c6Fi7nfFdXBKqPDg1SL4t+F7D9wpKqbgGMwQS/oy5URS7s51ynpu5+kMA35wnUt
         Pk5ss1aoCG83uGVxI6LPH42nKnUtsgwEoBKg9T7yaXfKMhXYwOOSfcC3Ws4QvFPapCd8
         iccKOeyZcsgxSQST3PqOk9huq5sKG/i5LdBfZBqx/mXXcGSpGcI5X1P9AGRAET0wTIbH
         JRqZbZjCy3bIEriroZxP/XX0m0pSLvEuMob7r1FjyDKvMMGepmTUi3mDh1vefigyx61D
         3lRCQd7BRptJtcfp8pJqPWmwq0IjgYxxvhQexD0svmTT4+oW62Om3ijwdpWAABHFwl4X
         x3AQ==
X-Gm-Message-State: AOJu0Yyoi0cz9FQPPo7WZLyx//Aa/SNQktwcdq0OqDGxyuz16P9tqZY/
	JJEWI9cLt3WFeOtBn96RqCbAUlUKjvkG4yVp9oo=
X-Google-Smtp-Source: AGHT+IGhdcK/D8TDcmmKpWbg7nOtIqGeIWDu1PU0U1nvG6xkcTK5vYkZvuOff/KspbLkBKicZUrA3p9FEhXdifJ8iz4=
X-Received: by 2002:a05:600c:310d:b0:40d:8914:cee3 with SMTP id
 g13-20020a05600c310d00b0040d8914cee3mr22359wmo.108.1704345716332; Wed, 03 Jan
 2024 21:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222031729.1287957-1-yonghong.song@linux.dev> <20231222031745.1289082-1-yonghong.song@linux.dev>
In-Reply-To: <20231222031745.1289082-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jan 2024 21:21:45 -0800
Message-ID: <CAADnVQJTFo0tgZRhgv7k28zNAvgnqjWaLvNNhcy+oiqdfvTvpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/8] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 7:18=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> Later on, Commit 1fda5bb66ad8 ("bpf: Do not allocate percpu memory
> at init stage") moved the non-fix-size percpu memory allocation
> to bpf verificaiton stage.

Only noticed after already applying and didn't want to force push
to fix it up.
But in the future please do not break commit one-liner into
multiple lines. Commit should be lower case as well.

spellcheck is a good idea as well.

> +
> +       for_each_possible_cpu(cpu) {
> +               cc =3D per_cpu_ptr(pcc, cpu);
> +               c =3D &cc->cache[i];
> +               if (cpu =3D=3D 0 && c->unit_size)
> +                       break;

I think this part ensures that repeated
bpf_percpu_obj_new() in a bpf prog don't keep prefilling,
right?
I think it works, but cpu =3D=3D 0 part is confusing.
It will work with just: if (c->unit_size) break;
right?

> +
> +               c->unit_size =3D unit_size;
> +               c->objcg =3D objcg;
> +               c->percpu_size =3D percpu_size;
> +               c->tgt =3D c;
> +
> +               init_refill_work(c);
> +               prefill_mem_cache(c, cpu);
> +       }
> +
> +       return 0;
> +}

