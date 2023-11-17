Return-Path: <bpf+bounces-15256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670187EF792
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 19:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD391F25A25
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF723C46B;
	Fri, 17 Nov 2023 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlAuWuQ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115EFC5
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:52:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so3471625a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700247163; x=1700851963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yJdVE58ZkrGx3LpwiMIjqvUbgxffOxrvqiWoCVSTe7s=;
        b=YlAuWuQ7KYaolWFbN1r03/ZTTxZyNUTwmTLDfE1F/e4w6YCrSxwLGUFf8iHC4xMB0A
         IUoMC0a7JBr5uhqIw2avJXvVQ3t9bCMGNvCa34TiUsc/w6XTNzw4MYa0CD2T4KzstTUj
         zmpEgJ1LTJ4Nsi7myIUc9JAx/Y7PyUXD0Mq/MKnzVbRu9btfTZrkMGlOBqXQykvsNZqN
         04ZMYiZACXmL+kH5z0INOFZ1f+ez0NCE8Lh7bR0H2GW2V4C8oIXhcWaFzUMsDnbm16PZ
         dVgp1eqPS1yDxseF/v+pNtJMBWuPwVH0MY0ypQgRTzZNsLEq9/tOrqjyonTGuuyO+ZWG
         VrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247163; x=1700851963;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJdVE58ZkrGx3LpwiMIjqvUbgxffOxrvqiWoCVSTe7s=;
        b=BoGGIusCZZT6Qtj89toeKNsoowOHP5sR5Tja3yizapne3x+PQWMc5Um5dz4jKBU0Wl
         cXvO+sAr4828DJE+pyxZeAFXSyXQgeRawqm/RSU7MfQai7mDwNfs0uu462ImN7Z5vJm7
         i92vw1f4Hv6gyjdOnklbrwluR8imidyf6ZamNiL9Lb8zufBmUHxm8ZtSgnAs3mSLRzfV
         vS+zCxOMsPdsJPRM+SPQFNDW4XFEfcITcp7iM1NFUsUqSauiO1WAkl7U/xUJUSFZqtW5
         XuP5IXfR+cBAX4A69msAMYey/FGGOcPTY8i3StkEazhSHPZema9aWSKsqLyI6oxxZrPF
         l8Eg==
X-Gm-Message-State: AOJu0YySH41/4VXUIu9aOOUU/A9lJK/NLsWAuKIcghql8imR2zrr4AmN
	7yIUM+GOsi+oKy9zd8Cqi3o=
X-Google-Smtp-Source: AGHT+IFfYQ3KZVvaumr3aOR6AJJo7Aohmkw2Ci90u43210C2GgvEv7dvxF54TlMCYAIQvFCt+a009g==
X-Received: by 2002:a05:6402:358c:b0:542:f328:5671 with SMTP id y12-20020a056402358c00b00542f3285671mr18237541edc.31.1700247163369;
        Fri, 17 Nov 2023 10:52:43 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020aa7cd5b000000b0053e43492ef1sm950469edw.65.2023.11.17.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:52:43 -0800 (PST)
Message-ID: <a2e55bf0b299df0453789a79755c0c4369c5c046.camel@gmail.com>
Subject: Re: [PATCH bpf 03/12] selftests/bpf: fix bpf_loop_bench for new
 callback verification scheme
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 20:52:41 +0200
In-Reply-To: <CAEf4Bza=+t8aS+mfaywe6ozkzYfo-DjH01qicfks4rsYCQs_Dw@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-4-eddyz87@gmail.com>
	 <CAEf4Bza=+t8aS+mfaywe6ozkzYfo-DjH01qicfks4rsYCQs_Dw@mail.gmail.com>
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

On Fri, 2023-11-17 at 11:46 -0500, Andrii Nakryiko wrote:
[...]
> > This has dire implications for bpf_loop_bench:
> >=20
> >     SEC("fentry/" SYS_PREFIX "sys_getpgid")
> >     int benchmark(void *ctx)
> >     {
> >             for (int i =3D 0; i < 1000; i++) {
> >                     bpf_loop(nr_loops, empty_callback, NULL, 0);
> >                     __sync_add_and_fetch(&hits, nr_loops);
> >             }
> >             return 0;
> >     }
> >=20
> > W/o callbacks change for verifier it merely represents 1000 calls to
> > empty_callback(). However, with callbacks change things become
> > exponential:
> > - i=3D0: state exploring empty_callback is scheduled with i=3D0 (a);
> > - i=3D1: state exploring empty_callback is scheduled with i=3D1;
> >   ...
> > - i=3D999: state exploring empty_callback is scheduled with i=3D999;
> > - state (a) is popped from stack;
> > - i=3D1: state exploring empty_callback is scheduled with i=3D1;
> >   ...
>=20
> would this still happen if you use an obfuscated zero initializer for i?
>=20
> int zero =3D 0; /* global var */
>=20
> ...
>=20
>=20
> for (i =3D zero; i < 1000; i++) {
>      ...
> }

In that case it fails with jump limit.
Mechanism for states explosion is similar, as far as I understand.



