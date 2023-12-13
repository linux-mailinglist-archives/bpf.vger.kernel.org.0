Return-Path: <bpf+bounces-17701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FDD811C82
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278781C2118F
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512424B3D;
	Wed, 13 Dec 2023 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKHUnM4x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4731A1
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:29:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so6634126f8f.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702492182; x=1703096982; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0qOLfmn684JOvfVqsqaoINkNM4bfROPm9AK8q7aRdRU=;
        b=eKHUnM4xCar8838wJdTnwuWU7REIdsbEKONxYEOGEcrFEQMZCiREsbwWLY66+lmeGJ
         bTlReFuP0uAA1tcT5824ivx/xizKZWaPqTPYAQwROvAnv1LaRCnHWTdyibkuhyoHWxTC
         Ql+FBnxVzsGf7qtmAWEXUYhF5A6ZgrTyqVjLQCyhiZZ9ZUSTcB+UwakGQlEQl8EdsNYl
         56J6Sm0QmWCaBYiz9Ni1pAzqkgdplN0II8OKXJao/drRNAarEai5PLkoOmS7H44GIX20
         GG1v9a8UUX1QDaXUqr9vo3VEoRv6e/PGlCtYrjxKBNMcPfX5ZrtXD59bth+RfUfbdEnQ
         maKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492182; x=1703096982;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qOLfmn684JOvfVqsqaoINkNM4bfROPm9AK8q7aRdRU=;
        b=Cq1E60u98tDiT//1OaD0ylm/nHCUKNfClcJh73fuuMIgh9HygT/f2qoDcZn2xJw6+I
         /50S7jYa8x6MKgM+4tcDkd+ME2xqLxRSvAZcTSOc0Gj8qXZq2knfjyLaFVL+nINhayve
         HlENPO3LJdFLOlUrYOWKma+n0SKBv73ypaVOmuPlT3YxxVpsJ3+Td3KVEXspOA+E5Fkg
         3BaHg06OJCb0nyS2esGfv3Zw8Vxfg4Cc0Ks+OJM/61j9G1CEIYry+9LWD39nni/zjoti
         p+Z7K1L6tPPZvZ9IkzP5ILSKO1+5J6p9q7WZjn/RXUT3iiGT7KsPU6GXB8VlIm3ZI8eX
         fVHg==
X-Gm-Message-State: AOJu0YxJhFthKAN+TLsR3BjIIiUXddNj/Ro4liKeKXIV3tLAPZSO3OTE
	6OKLgvobfYlXNon70mPEo9A=
X-Google-Smtp-Source: AGHT+IFWW+00rVMLfFGggf4n7DdJ/HfWG4ftpiMLy3TaM0dCNRgQ4Kq15lYL7nXR0rb5qG4PS/yVSw==
X-Received: by 2002:adf:da43:0:b0:333:5d14:458 with SMTP id r3-20020adfda43000000b003335d140458mr4207917wrl.86.1702492181888;
        Wed, 13 Dec 2023 10:29:41 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q10-20020adf9dca000000b0033636a04ee8sm3103045wre.32.2023.12.13.10.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:29:41 -0800 (PST)
Message-ID: <7cbd569c3693655021096c775bf8d77a518b585d.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/10] bpf: reuse btf_prepare_func_args()
 check for main program BTF validation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Wed, 13 Dec 2023 20:29:35 +0200
In-Reply-To: <CAEf4Bzbbi3kqMtt5QARD76N0FM6S0avgZjXHm9o=o4Bv4G+kYA@mail.gmail.com>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-3-andrii@kernel.org>
	 <75137376329b7afe4dae0f3ae8fe0036c790198c.camel@gmail.com>
	 <CAEf4Bza2v4=nwkV8BtLd7KvANtz1+j+GahFGYJCyKW93XPqF-A@mail.gmail.com>
	 <a23e5753192f152fbb09b98137fd0ecd8932efe5.camel@gmail.com>
	 <CAEf4Bzbbi3kqMtt5QARD76N0FM6S0avgZjXHm9o=o4Bv4G+kYA@mail.gmail.com>
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

On Wed, 2023-12-13 at 10:23 -0800, Andrii Nakryiko wrote:
> On Wed, Dec 13, 2023 at 10:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Wed, 2023-12-13 at 10:06 -0800, Andrii Nakryiko wrote:
> > [...]
> >=20
> > > > > @@ -19944,21 +19945,19 @@ static int do_check_common(struct bpf_v=
erifier_env *env, int subprog)
> > > > >                       }
> > > > >               }
> > > > >       } else {
> > > > > +             /* if main BPF program has associated BTF info, val=
idate that
> > > > > +              * it's matching expected signature, and otherwise =
mark BTF
> > > > > +              * info for main program as unreliable
> > > > > +              */
> > > > > +             if (env->prog->aux->func_info_aux) {
> > > > > +                     ret =3D btf_prepare_func_args(env, 0);
> > > > > +                     if (ret || sub->arg_cnt !=3D 1 || sub->args=
[0].arg_type !=3D ARG_PTR_TO_CTX)
> > > > > +                             env->prog->aux->func_info_aux[0].un=
reliable =3D true;
> > > > > +             }
> > > >=20
> > > > Nit: should this return if ret =3D=3D -EFAULT?
> > > >=20
> > > >=20
> > >=20
> > > no, why? I think the old behavior also didn't fail in this case
> >=20
> > I think it did, here is an excerpt from the current patch:
>=20
> Ah, sorry, you meant exit if -EFAULT is returned, not on any error.
> Yes, that was old behavior, but I don't think those conditions can
> ever happen because if func_info_aux is non-null, then we successfully
> passed check_btf_func_early() and check_btf_func() checks, which will
> fail early if those conditions are not satisfied.
>=20
> So instead of a scary-looking check, I figured it's simpler to just
> mark BTF unreliable and move on with the rest of the logic. The whole
> idea of this check is to do basically optional BTF check, but
> otherwise ignore BTF if it doesn't match our expectation.

Oh, right, all checks are covered indeed.
All good then, sorry for the noise.

