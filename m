Return-Path: <bpf+bounces-15260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053727EF796
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 19:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCBB1F2458F
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D924315C;
	Fri, 17 Nov 2023 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPLQLexh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C94E6
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9e62f903e88so305169466b.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700247194; x=1700851994; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9hdJkMvWOP3aiVeo7om2Ul92iu2k2DRM0iq7FgTdWv8=;
        b=JPLQLexhS265NZvfi3Om+7dmUIkAQ2//U1smAl2K/kfSjkvzIg04Nyk14+TJB9NQEt
         1/AhQd2MHWnyzDTDAWYtMy1wqyVMFIiuXudntqf4hlPFPlnQiH1sVLVqvuscotbrOV0w
         20KNgrpzs0xAx35vyJspobtblvFcuKYW+mUHjIGlruP0Dk2oOzj2hW4wfJhOGSZwKccL
         fHJ7FgzGtjAKqWz41bzKfJw6jojZS2J4Wh80vVy2EZcE2/AFxZHGBxcpizcElQ9aLe2o
         8rd+LqNCnqwnNXWvMJy5Qu3QzMqApEDbdMZiU+vP+kER+Y1IZq7t0e2fXW4GDGWWbeDW
         L42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247194; x=1700851994;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hdJkMvWOP3aiVeo7om2Ul92iu2k2DRM0iq7FgTdWv8=;
        b=vGHHCdlsePEQxkOXddP+5NsGJbt/xQ+JMOd9tjDKC5yjUZ7oJ3lk0CTEC0E+YBEUEL
         77Y+P5O67E7IL6ceavv8VvX/W9b23bXtnGoF6sJzDTyPl/Zp/voQZoJ00PnNIH8GU5sD
         j7oOaEH7zO2xt9NaX49QjO3JPI3gDAjC15CjNXY9dKvGxP1EWwPVXBibXLJnbFq251jq
         E+fXgeRAsJwYDPYlIYLLvdxZRE8xMdRbTSWl7TmmCvVSQfouEgT9gT8fLXKTNSKkL5fs
         mCGhe+18DC8Z2LKxwlA302g+BKBiMP2tNe11HRO4tvB+6TE9QEjW5MT2Ieqzotd/h5Kl
         o9LA==
X-Gm-Message-State: AOJu0YxrdLYcL93vTu/c8T2kLmJ3frOpuqAXY4vPVQAuQUUW7EBLS/r4
	bi8OAe+9r4IE8JDWZtpXI80=
X-Google-Smtp-Source: AGHT+IEp0e7w5LtsIeT/C5cH/yEn3Hl/u0kFxEz1V34MFVKHJUhpwVbLh47+uj51Kkj57gC0qM8vVA==
X-Received: by 2002:a17:907:7b92:b0:9be:6ccb:6a8f with SMTP id ne18-20020a1709077b9200b009be6ccb6a8fmr36590ejc.48.1700247194042;
        Fri, 17 Nov 2023 10:53:14 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906250900b009ca522853ecsm1058685ejb.58.2023.11.17.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:53:13 -0800 (PST)
Message-ID: <beafc54c685e26b0ac5776f5cc81a0bf7dff3775.camel@gmail.com>
Subject: Re: [PATCH bpf 10/12] bpf: keep track of max number of bpf_loop
 callback iterations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 20:53:12 +0200
In-Reply-To: <CAEf4BzbP9rh1Qb1eyANQn4yrR78q1+VL5R=GGyJihpaZJui0tA@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-11-eddyz87@gmail.com>
	 <CAEf4BzbP9rh1Qb1eyANQn4yrR78q1+VL5R=GGyJihpaZJui0tA@mail.gmail.com>
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

On Fri, 2023-11-17 at 11:47 -0500, Andrii Nakryiko wrote:
[...]
> > @@ -10479,8 +10481,14 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >                 break;
> >         case BPF_FUNC_loop:
> >                 update_loop_inline_state(env, meta.subprogno);
> > -               err =3D push_callback_call(env, insn, insn_idx, meta.su=
bprogno,
> > -                                        set_loop_callback_state);
> > +               if (env->log.level & BPF_LOG_LEVEL2)
> > +                       verbose(env, "frame%d callback_depth=3D%u\n",
> > +                               env->cur_state->curframe, cur_func(env)=
->callback_depth);
>=20
> btw, is this a debugging leftover or intentional? If the latter, why
> is it done only for bpf_loop()? Maybe push_callback_call() be a better
> place for it?

Intentional...

>=20
> > +               if (cur_func(env)->callback_depth < regs[BPF_REG_1].uma=
x_value)
> > +                       err =3D push_callback_call(env, insn, insn_idx,=
 meta.subprogno,
> > +                                                set_loop_callback_stat=
e);
> > +               else
> > +                       cur_func(env)->callback_depth =3D 0;
>=20
> I guess it's actually a bit more interesting to know that we stopped
> iterating because umax is reached. But I'm actually not sure whether
> we should be adding these logs at all, though I don't have a strong
> preference.

... it is not obvious to infer current depth looking at the log, so I
think something should be printed. Note about stopped iteration sounds
good, and it could be placed here, not in the push_callback_call(), e.g.:

               if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_val=
ue)
                       err =3D push_callback_call(env, insn, insn_idx, meta=
.subprogno,
                                                set_loop_callback_state);
               else {
                       cur_func(env)->callback_depth =3D 0;
                       if (env->log.level & BPF_LOG_LEVEL2)
                               verbose(env, "bpf_loop iteration limit reach=
ed\n");
               }

wdyt?



