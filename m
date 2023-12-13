Return-Path: <bpf+bounces-17699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1332B811C13
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9EF7B211AF
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C355955B;
	Wed, 13 Dec 2023 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC0ubvUU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AFA7
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:14:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2718a768so71445425e9.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702491268; x=1703096068; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tln1zyHl2HRT08KBy1TLu/ERpqUiQLZtzQDb6fujez8=;
        b=kC0ubvUUPqpaXUk7EgdV24CrrNi6sqQhVv1/vUOrm4UKDLeQvB5deYjvr6F1j9g0vB
         9vVfWs1g0qsuxZ12WbQpn2h9LNb/TOUPLREhVrb8z1Xa65hqvrejN1gQD+zMJSnbwHzs
         r1dfyMDSvtVOY3oMVazHsTyimXp/r4InoWLcn5Klw52su7ODj8qp1biJ8lJXFsOOCoXp
         xk50G4K3uB9rbOKvifvvvdsa3wDu3kZs8ZTGFPNEm8lb4QJowTMymuuky3EVvkOY51Ck
         K5rxAZHCNgJ1Y1xepkUmjfjQsYI5vmfafhkyqJCUU6Wb1812emHJ0L19hBe2+js5apgk
         J+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491268; x=1703096068;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tln1zyHl2HRT08KBy1TLu/ERpqUiQLZtzQDb6fujez8=;
        b=hXH1pNPBinI96wRLkk/bxnxjl+QgUli+lNeMM9TWFQYm5hrhZ/ztv8ruPxRQhyyQ5U
         nIetmS78hw2DN7qDJhJMy0fqnQyu20ATFr8Ap2JYTHgrjIP9ILqMV7SFiOeUkJnvqHDf
         OQZmaAGVfqlERvrXBES/Tm1dKtXbUzLQi4R/taUkz/swd5XdaVrkOdjRVawV+5wn1bpv
         9X317tBlyY6ct5NQlnC7dGAHoJSrqmsR0Z2ns6ocX/q52+fEIeWYGpQNu4rlUw0OyKdC
         K/oVmWYaN/qfS7KMB8uY8EHWz63RwWLBYtmE1F1Q0tYInD+7JKouflQ7ok9DrGjxQrcl
         Jjcw==
X-Gm-Message-State: AOJu0YwGhei/CeIFWSVdfFuR1l+nimKvtVo0V1IxxbtNFfT5FbyUv7Qa
	8nxmEnk+Pt80RzwmVHis6cY=
X-Google-Smtp-Source: AGHT+IFCKhT1qkThjU0WuBQAExFh4/KCb9F0NoTTzhKdMNifpL173I5slmUzbWTyCrbtSZwdyJCG+A==
X-Received: by 2002:a05:600c:1913:b0:40c:9d9:b87a with SMTP id j19-20020a05600c191300b0040c09d9b87amr4647650wmq.93.1702491267869;
        Wed, 13 Dec 2023 10:14:27 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id az23-20020a05600c601700b0040c0902dc22sm21793803wmb.31.2023.12.13.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:14:27 -0800 (PST)
Message-ID: <a23e5753192f152fbb09b98137fd0ecd8932efe5.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/10] bpf: reuse btf_prepare_func_args()
 check for main program BTF validation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Wed, 13 Dec 2023 20:14:26 +0200
In-Reply-To: <CAEf4Bza2v4=nwkV8BtLd7KvANtz1+j+GahFGYJCyKW93XPqF-A@mail.gmail.com>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-3-andrii@kernel.org>
	 <75137376329b7afe4dae0f3ae8fe0036c790198c.camel@gmail.com>
	 <CAEf4Bza2v4=nwkV8BtLd7KvANtz1+j+GahFGYJCyKW93XPqF-A@mail.gmail.com>
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

On Wed, 2023-12-13 at 10:06 -0800, Andrii Nakryiko wrote:
[...]

> > > @@ -19944,21 +19945,19 @@ static int do_check_common(struct bpf_verif=
ier_env *env, int subprog)
> > >                       }
> > >               }
> > >       } else {
> > > +             /* if main BPF program has associated BTF info, validat=
e that
> > > +              * it's matching expected signature, and otherwise mark=
 BTF
> > > +              * info for main program as unreliable
> > > +              */
> > > +             if (env->prog->aux->func_info_aux) {
> > > +                     ret =3D btf_prepare_func_args(env, 0);
> > > +                     if (ret || sub->arg_cnt !=3D 1 || sub->args[0].=
arg_type !=3D ARG_PTR_TO_CTX)
> > > +                             env->prog->aux->func_info_aux[0].unreli=
able =3D true;
> > > +             }
> >=20
> > Nit: should this return if ret =3D=3D -EFAULT?
> >=20
> >=20
>=20
> no, why? I think the old behavior also didn't fail in this case

I think it did, here is an excerpt from the current patch:

-		ret =3D btf_check_subprog_arg_match(env, subprog, regs);
-		if (ret =3D=3D -EFAULT)
-			/* unlikely verifier bug. abort.
-			 * ret =3D=3D 0 and ret < 0 are sadly acceptable for
-			 * main() function due to backward compatibility.
-			 * Like socket filter program may be written as:
-			 * int bpf_prog(struct pt_regs *ctx)
-			 * and never dereference that ctx in the program.
-			 * 'struct pt_regs' is a type mismatch for socket
-			 * filter that should be using 'struct __sk_buff'.
-			 */
-			goto out;

