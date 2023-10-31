Return-Path: <bpf+bounces-13710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED07DD0A6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0071C20CB7
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A01E52E;
	Tue, 31 Oct 2023 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIBUoUs/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5510F3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:37:28 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD35C1
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:37:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso9326828a12.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766646; x=1699371446; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kRNSSNn652z6GX8ZOUJ1Eq0Chm8pYEIvQdpZsUXBVUg=;
        b=SIBUoUs/Qd9Fh7XcoSO972nH4tf8Lz/HHv9RlWt5JGVNNyU9u2VmAM9UQKQ1mZQ+eL
         1GPCBd21qdC5bgJ/FcHzQez+79FLIJ73Fp0/MmS4yyv5//P5RPJ4RND6pG6xhG8vttKU
         oxQIrAprlD7mj2ZjfI1gk84ghxHepO/AJzmFbdHb4WgG7pgzipsadSgYfrgaXYYPWP4Z
         Hz1SdMYIa4XV5N9ohgfEIJDOBVKv7tVyyS7y6dHzR1ZThcRpG2Ps2+W2xD+JQ3scM92v
         CoIQAc2ZX5PP2CMrgSLgdNOmA+woiQfi6XDfMGprctitVl/9xkZAgVon5ELY0rzKXko1
         ddgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766646; x=1699371446;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRNSSNn652z6GX8ZOUJ1Eq0Chm8pYEIvQdpZsUXBVUg=;
        b=wYDZlpEre6fJtY0J3cr3KV3ef3SHrTnTVn9gl3FEFK69olg9gZ6098CfoeH8jNe0Hr
         D/sS9/gpTR8FQ8rJZ0I+RaOiox0eFcXGSdBZgPVo5pFVHJUGjuL/tCn2Qwvj7cQWfR9f
         63P3e+GNeWr5IhK0X4bGx1gNh1KvmK2O+c7mQ/qpzIErGDXlAndrAusDG9/m2CRqOz45
         7ritctDMTUg9sV0vOH+XI2rxyhgsKTNc8zW1r/0vUAVv9eAiEFvVxXHzEUgBdN3r7/1O
         A9vjKv9aAVe4Q/iV4TuTXIMbiahbcIyOkI4leQwDKaUW9LcnT0YIm50U5d5U64sqFuZX
         dIog==
X-Gm-Message-State: AOJu0YyEQXLh2IHimJWKr/k4hMFpepF90gVTePed3ZTT9WRocH72/1/C
	0dE64mjlGZ4s6lvaJ+shvW0=
X-Google-Smtp-Source: AGHT+IHwBAYgFK36aX9Y+zEJb+X06f7CxxDFJzk+uEBkGlOfg1Z26DAZOL61GcdGrmVEhUaX7tPHlw==
X-Received: by 2002:aa7:d74c:0:b0:53e:332e:3e03 with SMTP id a12-20020aa7d74c000000b0053e332e3e03mr11515119eds.4.1698766645488;
        Tue, 31 Oct 2023 08:37:25 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t20-20020aa7d714000000b00530a9488623sm1334611edq.46.2023.10.31.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:37:25 -0700 (PDT)
Message-ID: <56e7fd84fb29491b69a53b31acbdcaf4eea39cc5.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 04/23] bpf: derive smin32/smax32 from
 umin32/umax32 bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Tue, 31 Oct 2023 17:37:24 +0200
In-Reply-To: <20231027181346.4019398-5-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-5-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > All the logic that applies to u64 vs s64, equally applies for u32 vs s3=
2
> > relationships (just taken in a smaller 32-bit numeric space). So do the
> > same deduction of smin32/smax32 from umin32/umax32, if we can.
> >=20
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> > ---
> >  kernel/bpf/verifier.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bf4193706744..0f66e9092c38 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2324,6 +2324,13 @@ static void __update_reg_bounds(struct bpf_reg_s=
tate *reg)
> >  /* Uses signed min/max values to inform unsigned, and vice-versa */
> >  static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
> >  {
> > +	/* if u32 range forms a valid s32 range (due to matching sign bit),
> > +	 * try to learn from that
> > +	 */
> > +	if ((s32)reg->u32_min_value <=3D (s32)reg->u32_max_value) {
> > +		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, reg->u32_min_v=
alue);
> > +		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, reg->u32_max_v=
alue);
> > +	}
> >  	/* Learn sign from signed bounds.
> >  	 * If we cannot cross the sign boundary, then signed and unsigned bou=
nds
> >  	 * are the same, so combine.  This works even in the negative case, e=
.g.


