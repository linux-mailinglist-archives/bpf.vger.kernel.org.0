Return-Path: <bpf+bounces-15293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B27EFD2A
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 03:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09A12812F9
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13491EBC;
	Sat, 18 Nov 2023 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z09nZbTj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D23C19AA
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 18:33:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32deb2809daso1690492f8f.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 18:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700274812; x=1700879612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo/s8UsqT38en0Ud4+9YY9/2TtWpzDola0ISY4LOqFY=;
        b=Z09nZbTj/TF3kmuweVTgDqlnG0eOQxgLH94hLKkz+Ghvm7ukrSiA1qgxU0A2qKal5b
         4EwbLSKNWYHQXY1H928Cy+PGoNvqGpGaoioNKCTUShFxs6ICPuxXuOQ7myqEzZiuqnf3
         /AK3ImrVMLw/yrhTOlUJf/m9k7Cor4RyPJi6VGQiMzZT7LfW5Ej8LTtINCTdhtAVx0JQ
         w82XPZwNZd3yiKKTGZXDadWcx7O6AZG/G6U1xgR8+jG7bndE4PSGUzF/3V/vBZwm8Ao8
         kToesp12Pkx7Mt8Mp/sZgU4zbHCTfHd5Z93AE2eIrydYAybRNVp+/PZ4BoEDspw1ugXH
         Tdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700274812; x=1700879612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo/s8UsqT38en0Ud4+9YY9/2TtWpzDola0ISY4LOqFY=;
        b=bHzU0H7BHtuLV/mlzOHf9s90UyyX5z/pPnYXh5D/lC6CV7EUPhK6PUoad1B9zWR7kI
         q8rvY4nIJtM5fCMEr/iajizZGuaVcmPulgg5UZ8AuAvlyNsg/9KWYQUVzaevje7D+7zn
         EomOz+yY+0ox3uo2+Kp2SQSoUMyHRn9EMRAPM9f9cC9CANEJwuGuRwM52zVIKWpE70Bk
         0YdddMMYwyGQAgztPGcb3R0tEWcA3NorIwAyLjgaWqdfknCsslYiUERkoEKgb5Ojmlfe
         us/gNiPjB4AqhtAaZhWQzUgRU1tWdh8629aYSO/2D8p1dvFvA/xZRGdEfwZIivae08/L
         XMww==
X-Gm-Message-State: AOJu0Yw85jmUuJWfVyLHRQwFTfhOzvEO1sS2z9f07cfZOgalW3ocYAlD
	ZKGCZyJXu3p9MkW1z4Gp5KaImEPeBE0ElVZcZ9A=
X-Google-Smtp-Source: AGHT+IFsrPJT77y+NPypsS/dlmrAYnZAssQNORV1uxKGAEvthMfhu+VKqUyMqA/x05+Gp59fZG2qNkEzlMlk+Gm+hog=
X-Received: by 2002:a5d:6d05:0:b0:32f:89fb:771d with SMTP id
 e5-20020a5d6d05000000b0032f89fb771dmr807954wrq.12.1700274812346; Fri, 17 Nov
 2023 18:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111201633.3434794-1-andrii@kernel.org> <20231111201633.3434794-8-andrii@kernel.org>
In-Reply-To: <20231111201633.3434794-8-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Nov 2023 18:33:20 -0800
Message-ID: <CAADnVQJT_On7dbs8_KZt8otZfVZBUerJfTBJpLE2_CmbbiNvdA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: smarter verifier log number printing logic
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 12:17=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> +static void verbose_unum(struct bpf_verifier_env *env, u64 num)
> +{
> +       if (is_unum_decimal(num))
> +               verbose(env, "%llu", num);
> +       else
> +               verbose(env, "%#llx", num);

I didn't know about %#.
The kernel printk doc doesn't describe it.
Great find.
Curious, how did you discover this modifier?
Not sure whether it's worth adding a comment here
that # adds 0x. Probably not ?

> +       if (type_is_pkt_pointer(t)) {
> +               verbose_a("r=3D");
> +               verbose_snum(env, reg->range);
> +       }

A tiny nit...
The pkt range cannot be negative, so using Snum here
begs the question... why?
The rest looks great.
If you're ok I can fix it up to unum while applying or respin?

