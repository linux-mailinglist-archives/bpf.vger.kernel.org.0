Return-Path: <bpf+bounces-17719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A4811EF6
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9300F1F214C1
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE668276;
	Wed, 13 Dec 2023 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px21Vfp8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4CAAD
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:33:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c32df9174so65111995e9.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702496003; x=1703100803; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3gS6lWquzqyGOE4EKD96r8FMC3zqBJLgjycrPfBwLw=;
        b=Px21Vfp8RsNN819qFHt4kZnbLHGT+unHhVCvT/DiDwB9hdezhX7IKlb74Tx4kd/WBk
         Ifopg5gyuwJMXjjS9X7mJ2823hooJAakuepCyt1eRL41ZnYjFQpBq9X4ny2vTmGrY1hg
         uLYfHecZD19g1r1XbeSA9FO8bSlTH4TRAAplYi8cYvkONDR3XID1jwWAeNAHVVgJKgRy
         ixapnz0OPZlxUXccv7I5NZhAYiC29WJreUiAqFsW7g4e+AvzxrBknWWgpl3MrPWSO3aZ
         YbV5o/fM5r868amXCr+TAOCDr+9C3bz6I9CWfFrxAsik0iJSl5PmHavPskgal94XZ1/X
         6fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496003; x=1703100803;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3gS6lWquzqyGOE4EKD96r8FMC3zqBJLgjycrPfBwLw=;
        b=qDVb5XByllMHLkuMW+bLPqJN5Kr/ky/VbuWPCZ7WCeBM4NyV5KiPwGq64etnmLtNWm
         3CLY0yadF4i6Dw53l6zs3yRMOg/gp67G0YfAe+ELoMlS0ZUSw307Y4LwJfD8TZDkVGoB
         96J9zLT8dHx8yI5D0ZN3EDfOS9CypFgXDDXdugsXP7+571E0JUYkr62fIZ2sJ7RNW0Er
         9AzFb8V46GI7ASnco5MhswYwvTAAUwBDNFRKL1Lq0AQzLVG70Rlsp3znNej/P4l2oP95
         T0/DXndP55SVOZP5S2bkDN2scp8i3fg6GBWPi+3Qhd69SE2ZJiN+8z5l4knjtAkeaUMB
         z6iQ==
X-Gm-Message-State: AOJu0Yw6rApeArhexpMW5AYCH657MDt3CTf8BYP6Pl8F7W0HHsKj9rhj
	qtVfWYZPt5hRx+KZMJLS/vQ=
X-Google-Smtp-Source: AGHT+IH92AGBlZZxIFAoN0Hsh7cKbQEOimPP3F+i7stftVMqb/nF3eEFT2lr9T9k0poroTeRME8L3w==
X-Received: by 2002:a05:600c:4da1:b0:40c:3107:7735 with SMTP id v33-20020a05600c4da100b0040c31077735mr3186004wmp.232.1702496003291;
        Wed, 13 Dec 2023 11:33:23 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004053e9276easm23854076wmb.32.2023.12.13.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:33:22 -0800 (PST)
Message-ID: <fe6ecc7ca2cf4516f9658609c53796670c05adf5.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/10] bpf: support 'arg:xxx'
 btf_decl_tag-based hints for global subprog args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Wed, 13 Dec 2023 21:33:21 +0200
In-Reply-To: <CAEf4BzYMkTouSBADH8x6Xx8DRYRtkFUOxG6cmGEa4rpi2xUZAg@mail.gmail.com>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-7-andrii@kernel.org>
	 <bb0885d8a86c2b03be918ef506466e6a2f90f294.camel@gmail.com>
	 <CAEf4BzYMkTouSBADH8x6Xx8DRYRtkFUOxG6cmGEa4rpi2xUZAg@mail.gmail.com>
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

On Wed, 2023-12-13 at 11:18 -0800, Andrii Nakryiko wrote:
[...]

> > > @@ -6846,7 +6846,35 @@ int btf_prepare_func_args(struct bpf_verifier_=
env *env, int subprog)
[...]
> > > +             if (tag) {
> > > +                     /* disallow arg tags in static subprogs */
> > > +                     if (!is_global) {
> > > +                             bpf_log(log, "arg#%d type tag is not su=
pported in static functions\n", i);
> > > +                             return -EOPNOTSUPP;
> > > +                     }
> > > +                     if (strcmp(tag, "ctx") =3D=3D 0) {
> > > +                             sub->args[i].arg_type =3D ARG_PTR_TO_CT=
X;
> > > +                             continue;
> >=20
> > Nit: personally, I'd keep tags parsing and processing logically separat=
e:
> >      - at this point set a flag 'is_ctx'
> >      - and modify the check below as follows:
> >=20
> >                 if (is_ctx || (btf_type_is_ptr(t) && btf_get_prog_ctx_t=
ype(log, btf, t, prog_type, i))) {
> >                         sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
> >                         continue;
> >                 }
> >=20
> >      So that there is only one place where ARG_PTR_TO_CTX is assigned.
> >      Feel free to ignore.
>=20
> I think it's actually more convoluted and error-prone with the is_ctx
> flag. Tag is overriding whatever BTF type information we have. But if
> we delay ARG_PTR_TO_CTX setting to later, we need to make sure that
> post-tag BTF processing is aware of is_ctx (and potentially other)
> flags and doesn't freak out. We might add more BTF processing before
> ARG_PTR_TO_CTX, etc. Having to worry about not overriding tag-based
> decisions seems very error-prone.
>=20
> Also, btf_prepare_func_args() really simplifies the "definition" of an
> argument to one enum (and in some cases maybe an extra argument like
> memory size). It should be fine to just set this enum in two places
> separately, doesn't seem like a hindrance for maintainability.

Well, I disagree a bit, but that does not matter.
You are right that after extracting btf_prepare_func_args()
the code is easy enough to follow.

