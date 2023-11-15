Return-Path: <bpf+bounces-15129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21237ED1F4
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 21:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86920280EEC
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCDD446A0;
	Wed, 15 Nov 2023 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGDADwOZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1EDD
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 12:25:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32fa7d15f4eso53839f8f.3
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 12:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700079913; x=1700684713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUHP9AL4gVsfND2YM3oThE2mo1Ynufz44UsMsvpKGt8=;
        b=NGDADwOZYCXmMeAALg/WTDRHApti/WlP1q0S+J/8uMt1zl0JihOycVZxwexBRHHh52
         AOpGsRo3CHavLNWRO//xOMO1GebvvE3BEXlPaMVpkzFh1WSZuy9vfTQQ0yx0OBBId6cs
         6jSDL5T3uWF2duSnnb/s6JkyECsHiKbMP0+AxOpEK8wYveQ/Ov455X1qp1WxDKKdEE55
         EzpIf96Ju6cLetOOmKcovkGMQAoiTE6Md/yuxExR+CceHtx31uEX/OmZxXBPH+5x3Piu
         Zaq2Um4MqDVVPOuQvF34vjFwo4zR/U20kbI07ikLsZjGGHdW2OBix9qr5uiH6iuKJY+c
         LTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700079913; x=1700684713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUHP9AL4gVsfND2YM3oThE2mo1Ynufz44UsMsvpKGt8=;
        b=JRk166FBwM29iPFdUeQMpHA65uey2b92dAn81MAsUxComJaAg5SkL3YVMcedrJv4Sb
         RmoZfhDNKnDo7qwx38wZYRkgwiSvKJztjeCJacmAWNOiTX7VbwcLKnBBfaTMO9sWbehV
         HxQ3ZA4H01KIJzvQWs7tntKiLO/Rf83bMVHDHGlG7ViXTqb16HVA0XImk4H5BHC5V603
         +az2PceOC6+XtqF9vrz+xyLX6ONci9lTaxH/oTO+1iDNeavroJPLRB5PebHjQwMeAF58
         DjpIUDs8f2PVP1WwluvRKlPMXxgMVKpq2w9osnMEPhE3NORHUpjucXTyipIJQAgCW9XJ
         94Fg==
X-Gm-Message-State: AOJu0YwO5XVBKu8ToT5OXybLLgpWtdCeNP7/RzaN/Gm3R1nCN/2x5Ahy
	2iPB9MdkUf/J7zTXSKJfqx+82IigmR/QMRspFGs=
X-Google-Smtp-Source: AGHT+IGRlSTedOjnT5IBsLfsCKLpFuQt8dL51JG2NA0ygxMk6IZrNCvUaabyzqdqqenv56UE4kEC6wjho6VdEzhTWQw=
X-Received: by 2002:a5d:6483:0:b0:32d:ae31:458b with SMTP id
 o3-20020a5d6483000000b0032dae31458bmr9234757wri.52.1700079912764; Wed, 15 Nov
 2023 12:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112010609.848406-1-andrii@kernel.org> <20231112010609.848406-5-andrii@kernel.org>
In-Reply-To: <20231112010609.848406-5-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Nov 2023 12:25:01 -0800
Message-ID: <CAADnVQJZr3Za=oM9VeTeY0BGL6rymSHSsKqEWVSJmkRhSvcsHA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/13] bpf: add register bounds sanity checks
 and sanitization
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 5:06=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
>
> By default, sanity violation will trigger a warning in verifier log and
> resetting register bounds to "unbounded" ones. But to aid development
> and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
> trigger hard failure of verification with -EFAULT on register bounds
> violations. This allows selftests to catch such issues. veristat will
> also gain a CLI option to enable this behavior.
...
> +       bool test_sanity_strict;        /* fail verification on sanity vi=
olations */
...
> +/* The verifier internal test flag. Behavior is undefined */
> +#define BPF_F_TEST_SANITY_STRICT       (1U << 7)

Applied, but please follow up with a rename.

The name of the flag here in uapi and in the "veristat --test-sanity"
will be a subject of bad jokes.
The flag is asking the verifier to test its own sanity?
Can the verifier go insane?
Let's call it TEST_RANGE_ACCOUNTING or something.
I'm guessing you didn't qualify it with 'range' to reuse it
in the future for other 'sanity' checks?
We can add another flag later.
Like BPF_F_TEST_STATE_FREQ is pretty specific and it's a good thing.
I think being specific like BPF_F_TEST_RANGE_TRACKING or
RANGE_ACCOUNTING is better long term.

