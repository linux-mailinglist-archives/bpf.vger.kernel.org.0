Return-Path: <bpf+bounces-15477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08377F22E4
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCFA1C21766
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF994C7E;
	Tue, 21 Nov 2023 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnJaRBTt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6AFBC
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:09:08 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ff26d7c0a6so182354766b.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700528947; x=1701133747; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qeounJIIEIC1t62jzC4Ie73na35eoaLYZV5dIzTEWp0=;
        b=bnJaRBTtcVh5JFpsNvF7mGHHMPdxpQtydr+7LAWnzm1+zVwT1igWSaC8VMf+3VZu4R
         6z9Z0T+rp1t9+ea87QismzalvyQ9DzdJdEWdg0pbINzz5jbpVxGc7pHnBX2L47754r5E
         37ur7MSvmi2HXSj3GsV91uO3hC9IHfw/21xb1NCampU/Sn6MmGZSS9ber+kI8uc3iKg3
         wWQ5dobmpXXwBAZaiRXqN6KyPlGP715uzeuo2QfWwPAFG2zxrx5H+wPGlc+2kqBR5kYo
         OXFuibzUODWVo0+ve2qPZxB6AZNX7J8WdICL1YQTo8COsyPaI4hVtg99WS5Z/9jJQp7q
         JKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700528947; x=1701133747;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeounJIIEIC1t62jzC4Ie73na35eoaLYZV5dIzTEWp0=;
        b=hZC5UzQR6JvWzhdPzM6WajArYrmSiKAhryjARRpGiC1doOqltNJcS/nDNxYenJOdRV
         coNsLDi3tLSeuAoR2cQUmXSqpc+nbjhoomXYyYqHno80ddiDO3g5cUpGHqE9HMk/JiXw
         2PiVEJbva/ePQTJFZZStThzqbvBjieCiMHPpXGefDD/HlphZtosxmc+W/Yect7MgGBDa
         VzAgUVhUcsHXaXApZmEo+oCznjwSD2y5yPL02E6QeiS+OwoMuRJRytu3KgbPxqHIzz4V
         SDIqAIvgtdqojUc2YrFYdsKn84H4Z1fr0QYP8TNpGInxzhsCv9hWmDBK256bB6Cnb676
         wQlw==
X-Gm-Message-State: AOJu0Yycr/mh2s6A22Tcab05rLluD9sobZTmFh4mtnqfR3TMhyk9W/PX
	SeTq+c5zqD4FJhqmSdyGV6U=
X-Google-Smtp-Source: AGHT+IFmuRyH/1n0RiAFznIRvTubdFHsGe7FzUT64nfAkYd/mEbEFvJ9UUekFB13cZEySRA/UQjJqw==
X-Received: by 2002:a17:906:e293:b0:9fe:1fbd:4c0b with SMTP id gg19-20020a170906e29300b009fe1fbd4c0bmr3903686ejb.68.1700528947234;
        Mon, 20 Nov 2023 17:09:07 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b009c921a8aae2sm4430456ejd.7.2023.11.20.17.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:09:06 -0800 (PST)
Message-ID: <b0d346784ff3aac63927f1798cf1fcd14ebfde1e.camel@gmail.com>
Subject: Re: [PATCH bpf v3 10/11] bpf: keep track of max number of bpf_loop
 callback iterations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Tue, 21 Nov 2023 03:09:05 +0200
In-Reply-To: <CAEf4BzZc8eCQ=2qCqWD9+LHobrSA3cxQ-yHpVFm4zRQ0Phn1bg@mail.gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
	 <20231120225945.11741-11-eddyz87@gmail.com>
	 <CAEf4BzZc8eCQ=2qCqWD9+LHobrSA3cxQ-yHpVFm4zRQ0Phn1bg@mail.gmail.com>
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

On Mon, 2023-11-20 at 17:04 -0800, Andrii Nakryiko wrote:
[...]
> > @@ -10309,8 +10311,19 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >                 break;
> >         case BPF_FUNC_loop:
> >                 update_loop_inline_state(env, meta.subprogno);
> > -               err =3D push_callback_call(env, insn, insn_idx, meta.su=
bprogno,
> > -                                        set_loop_callback_state);
> > +               /* Verifier relies on R1 value to determine if bpf_loop=
() iteration
> > +                * is finished, thus mark it precise.
> > +                */
> > +               mark_chain_precision(env, BPF_REG_1);
>=20
> huh? What about error handling?

My bad.
Should I fix and re-send as V4 immediately or wait till tomorrow?

