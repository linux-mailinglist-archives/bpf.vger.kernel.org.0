Return-Path: <bpf+bounces-14610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479AD7E70EC
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4BAB20CDF
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE630FB4;
	Thu,  9 Nov 2023 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2UVzcks"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3430675
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:54:31 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AAC3A81
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:54:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d10f94f70bso194297466b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699552469; x=1700157269; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NN3sQjeBLNhc3lJ7MNaSMaZM6ZBOosxASZAPTnfnCDk=;
        b=P2UVzcksxbcj9crHqXgQIDzA7wbkyvqLFAd0eo1lRhgJD6HZ/5tgtjN0hUtuB7jngL
         SIEivvqP512aw5iy9khutqy5MdpQEomjKUGLx6iJynM+IgZuq1Bd09HT98fVzCiKM45x
         LIjwIWiqcFgaChIv9M8FDFr/iBhJQq06m0Ka5cp7QspkiBWEQ6gxYBQvZgP6J4bU/xRM
         UJVvVcF7t6Jwd5Q5KcAxYRa6NdhDH3IE4R2r0hdgB3RKJL7KfyNfgJc0EhEVypPe+tKu
         w5gOiioTR61WCn9uI7px18SXvFZ9KVgIRg6NYvURIA9X3uil/Jf4JpETtA/tfRK2I7K7
         YAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552469; x=1700157269;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NN3sQjeBLNhc3lJ7MNaSMaZM6ZBOosxASZAPTnfnCDk=;
        b=uTKkfQbTRQ9bmKuJy516mz/EXFqNuhQEbUw+IqSyrpKR5FcCIIb0P6huRvdPtjYVFE
         tfhcPu/+HHlMGhQSdul9hAACd1UmBXn/HZ2WVsNQUlsxT6YiKlqVWNpAp8Tjkq5kB3T5
         HkbRg+mBygiYxbpl9v1iUhAk1gUPgDfI+XucmvLbVSq//3OKzqQd0Eynsip5mhZ5UuWj
         nlCMde55GgOVv4a1c/KzmeHliYZgHPPGS8nqYoVz0zN2dN2LB3nonpUstvEcnsWwLBaT
         3fqHczg9cq1sxdtZsuqMoWhuFKxgzBi/rqc6v5mS7ZR+6kfWyxu0nmTUtraZ/qMicmsx
         G6OA==
X-Gm-Message-State: AOJu0YzpBczfJs+whbPlOP8X/txH1qTt/j6m5g69hVuUKHuYzya7V+Tt
	4/tkq5M5nt2AAtNo6LKugNU=
X-Google-Smtp-Source: AGHT+IFj8ADRUhLTiXyUJkFlvplERC37r6qQh4xYrDf5ptNFZPD2K9WbylKn52g8Y/sfqsyhmzAmlg==
X-Received: by 2002:a17:907:2cc7:b0:9ae:6a60:81a2 with SMTP id hg7-20020a1709072cc700b009ae6a6081a2mr4700033ejc.25.1699552468695;
        Thu, 09 Nov 2023 09:54:28 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jz6-20020a170906bb0600b009df5d874ca7sm2823012ejb.23.2023.11.09.09.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:54:28 -0800 (PST)
Message-ID: <a004428f6884acf4bf1dbdb7aede9ca5a15cc7d6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: preserve STACK_ZERO slots on partial
 reg spills
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Thu, 09 Nov 2023 19:54:27 +0200
In-Reply-To: <CAEf4Bzb0SY9uoc268qanOcCQ0_8k21WzLtHzj-KM6U_=9W8XXQ@mail.gmail.com>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-6-andrii@kernel.org>
	 <8163041bb608879cee598cb6262c04fc18bf226f.camel@gmail.com>
	 <CAEf4Bzb0SY9uoc268qanOcCQ0_8k21WzLtHzj-KM6U_=9W8XXQ@mail.gmail.com>
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

On Thu, 2023-11-09 at 09:37 -0800, Andrii Nakryiko wrote:
[...]
> > > @@ -1355,6 +1355,21 @@ static void scrub_spilled_slot(u8 *stype)
> > >               *stype =3D STACK_MISC;
> > >  }
> > >=20
> > > +/* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID=
, in which
> > > + * case they are equivalent, or it's STACK_ZERO, in which case we pr=
eserve
> > > + * more precise STACK_ZERO.
> > > + * Note, in uprivileged mode leaving STACK_INVALID is wrong, so we t=
ake
> > > + * env->allow_ptr_leaks into account and force STACK_MISC, if necess=
ary.
> > > + */
> > > +static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *s=
type)
> >=20
> > Nitpick: I find this name misleading, maybe something like "remove_spil=
l_mark"?
>=20
> remove_spill_mark is even more misleading, no? there is also DYNPTR
> and ITER stack slots?

Right, forgot about those...

>=20
> maybe mark_stack_slot_scalar (though that's a bit misleading as well,
> as can be understood as marking slot as spilled SCALAR_VALUE
> register)? not sure, I think "slot_misc" is close enough as an
> approximation of what it's doing, modulo ZERO/INVALID

maybe_mark_stack_slot_misc?
The other similar function is named 'scrub_spilled_slot'.=20


