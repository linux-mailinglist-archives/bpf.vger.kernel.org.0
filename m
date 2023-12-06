Return-Path: <bpf+bounces-16907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4B2807748
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13AB1C20EE1
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075986E2DC;
	Wed,  6 Dec 2023 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeY0Btn8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76C122
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:06:06 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso117693e87.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 10:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701885965; x=1702490765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mP8LnT/ULUeUMm7dMAika3vGnk7qmpUxnUDhqjSeY2E=;
        b=FeY0Btn8RuNEyXgnyVWfn1CnliRwVrDbssxCWEB6p/UsTUY/6KXZ7i1k5/Dzuj64v0
         jeKwiixoy9OmfIt5oLXDItIyvuiZsunkznuOY5qTVCtqGGZtauMlU7EguYBvfJvpYEFI
         tpJVVn48VM22UFpH1jKm5p3I3Ycn0016FkZNSCmx/ANgD6dnh/spDCqzyXa9H73nAaNr
         8UBRh1033/F6advU58FcM25Ly0s1wAXpjNolqm+3loE0mBYooBv9EY+ovdXp6HfXqN/S
         3buT5870Eh4a0X1s67fq2ZpdtNc5pgLrsqs91rPI7Xwpo5URWERfC/hHVDR0qKKTOmnM
         krvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885965; x=1702490765;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mP8LnT/ULUeUMm7dMAika3vGnk7qmpUxnUDhqjSeY2E=;
        b=BtYr2siNmh0uaMSri+XYXjhETB+TU9O1+5QFZ+YRTocDhHO0W48Zv9BKTcf66dvwpM
         jTTd4kKJUbSlLfNH8QL1smyT0vUuOHITN7rePIan83T+jabjfJKXLQCkKT+xdjdQxteS
         Wq1zeUxzOnI0GuTth4FbCun6pdShSA/YYEQtVpq52i8r6x8cVDfzGfhI101h03XzbFlo
         pZeSANnudxPW5ub5pDzJR4MaoJHPRSX+a/RPe9RcpH95iKzzZG0/dmzeLZbS/oEa+Evu
         1knVnLcoxo3zhFYQTWDCpVZ2sqep/Y4wSes7NBHXFeaZWi5IkqfFkOPeKuHr0kFGqh6x
         tPgw==
X-Gm-Message-State: AOJu0YzfGfwP2lKuj6BG1UlpaPtg4bu7j5nvEFnAxEYJe/ycEOQRImQl
	xRw+NAzoyglu0i94P6FbaDI=
X-Google-Smtp-Source: AGHT+IFhgXVK6frC5VZjfam0a0TAG7AVgdrX7Ah24f3KtUcQ25RPNypJ/7YQqj6BsmxsFhg6vXRbhQ==
X-Received: by 2002:a05:6512:3496:b0:509:489f:5b6f with SMTP id v22-20020a056512349600b00509489f5b6fmr781814lfr.11.1701885964960;
        Wed, 06 Dec 2023 10:06:04 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v18-20020ac258f2000000b0050beed5bff1sm1264477lfo.205.2023.12.06.10.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:06:04 -0800 (PST)
Message-ID: <dd98111ffdb0bc8c7367e44b4eb3e895e5813913.camel@gmail.com>
Subject: Re: [PATCH bpf-next 06/13] bpf: remove unnecessary and (mostly)
 ignored BTF check for main program
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Wed, 06 Dec 2023 20:05:58 +0200
In-Reply-To: <CAEf4Bza0oz_qBXO6Xdh5KYAQsLYgCmvPhXeBUxFQOrFGAEudkg@mail.gmail.com>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-7-andrii@kernel.org>
	 <97485a47e88f868da1ad6e42a3b19ad7216391e8.camel@gmail.com>
	 <CAEf4Bza0oz_qBXO6Xdh5KYAQsLYgCmvPhXeBUxFQOrFGAEudkg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 09:59 -0800, Andrii Nakryiko wrote:
[...]
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 16d5550eda4d..642260d277ce 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -19899,18 +19899,6 @@ static int do_check_common(struct bpf_verifi=
er_env *env, int subprog)
> > >               /* 1st arg to a function */
> > >               regs[BPF_REG_1].type =3D PTR_TO_CTX;
> > >               mark_reg_known_zero(env, regs, BPF_REG_1);
> > > -             ret =3D btf_check_subprog_arg_match(env, subprog, regs)=
;
> >=20
> > Not sure if this is important or not. btf_check_subprog_arg_match()
> > might have set 'func_info_aux[subprog].unreliable =3D true'.
> > bpf_check_attach_target() checks this flag for subprograms that are
> > being replaced, and seem to be ok accepting 'subprog =3D=3D 0'.
> > This change makes it so .unreliable is never set for 'subprog =3D=3D 0'=
.
>=20
> True, I missed this corner case. But I'm now wondering if it is
> actually better to have a dedicated check just for entry program which
> explicitly checks that we have one argument and it's a PTR_TO_CTX
> (taking into account tags as well). btf_check_subprog_arg_match()
> business is way too indirect and subtle, IMO.

Dedicated check sounds more direct indeed.

