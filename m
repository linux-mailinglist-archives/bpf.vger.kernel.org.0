Return-Path: <bpf+bounces-17244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8B580AE52
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A73FB20B25
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ABC46BBF;
	Fri,  8 Dec 2023 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACqkbmLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C3198A
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 12:54:48 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so14307125e9.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 12:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702068887; x=1702673687; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5URQpBfpvhJb95He/3/e48fBeQtPA7dq38FeTTEwlJI=;
        b=ACqkbmLn8QBQrGiZ2V4gEe8xS72nWIxLc4eRU6volb75f3XGLX4zZbnwEMWywygkcy
         mAU5E2jDAF+nqswh84iirU0BGH0BScguIBgwVpXca8t244JXRteZ8DZKvl+VyLZDjmMT
         mJdgBd/JUuGZrqxKoNgEMOixP37FUVdHUNqz8GCMZ5c3Ht/0blAVy2mQhVqodIFvmbH+
         bvqsI+y/NWWcoBOpUVvkXumx3USvnB5dYMkz5JaCDFyqqPqP1yC5MnT9w/thFNRA2dg6
         Qn81lUAfYm23HbrtN8GwmvPReCdgPmC+0/Bn5p/f0Ld2zuVzke1h+7m20PQWme0LQ8gT
         vYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702068887; x=1702673687;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5URQpBfpvhJb95He/3/e48fBeQtPA7dq38FeTTEwlJI=;
        b=Pej63ZTg3HOgbkqMojkuDggrg1vEoca3mEa+KwGGEYQT/sVUuABxC2yiy14guuqeMR
         hsPhYBDMzn5Z6V2qfdWqPzAoTqjgQkXcG/49nNBFbgzsCLbXDoM4+CpH46CtEm9OLY7Q
         da2ZjqdZezgqtnuHaFGvPTvN/s2rQWH2wXbQj3NowxiLdnPtyMMC7a5mP474SzqCDm+H
         e/yK4leRYR2EL7cOp4Jk7xD+cBJm51LOj2ZWnzvzf3a875qAoC1A5OKzwQuwNB/fllkM
         DWfh3XD1awNe1Mj1czLGLeqLRFA1L/bCSG/dhTAqjMmUHGyQdYqc4vUqKnAZh3uBbr2n
         Ml5g==
X-Gm-Message-State: AOJu0YyVSPMNbInMhVM54H+iWXFN+Ehe9XsalvblQCzUdqy7Jh7wV3Ks
	iJF8iKmV+iEt1fKKWRyMF7hxjuebbj6BuQ==
X-Google-Smtp-Source: AGHT+IG+U81Vc2OAWuOWuJeaArjSRjYeX2phelud/vY4giLXeBNomxy7Rg3P4mIIX29lKJ2K9O7uYw==
X-Received: by 2002:a05:600c:287:b0:40b:5e4a:2379 with SMTP id 7-20020a05600c028700b0040b5e4a2379mr371829wmk.123.1702068886668;
        Fri, 08 Dec 2023 12:54:46 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b0033350f5f94dsm2741038wrt.101.2023.12.08.12.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:54:46 -0800 (PST)
Message-ID: <dca277be58dc7e86ffd16e10c1e49370aa48eda2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, jose.marchesi@oracle.com
Date: Fri, 08 Dec 2023 22:54:45 +0200
In-Reply-To: <9e4e70d9-aeda-4100-a879-1b7413db567d@linux.dev>
References: <20231208000531.19179-1-eddyz87@gmail.com>
	 <012efc61-e067-4c21-8cab-47dec9bbaf0c@linux.dev>
	 <0275c6985bcb299890da7ea7fb96642802cdcdbe.camel@gmail.com>
	 <9e4e70d9-aeda-4100-a879-1b7413db567d@linux.dev>
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

On Fri, 2023-12-08 at 09:19 -0800, Yonghong Song wrote:
> On 12/8/23 6:34 AM, Eduard Zingerman wrote:
> > On Thu, 2023-12-07 at 18:28 -0800, Yonghong Song wrote:
> > [...]
> > > All context types are defined in include/linux/bpf_types.h.
> > > The context type bpf_nf_ctx is missing.
[...]
> The error message should happen here:
>=20
> check_mem_access
>   ...
>   } else if (reg->type =3D=3D PTR_TO_CTX) {
>    check_ptr_off_reg
>     __check_ptr_off_reg
>          if (!fixed_off_ok && reg->off) {
>                  verbose(env, "dereference of modified %s ptr R%d off=3D%=
d disallowed\n",
>                          reg_type_str(env, reg->type), regno, reg->off);
>                  return -EACCES;
>          }
>    ...
>=20
> So the verification error message will be emitted earlier, before convert=
_ctx_access.
> Could you double check?

You are correct and I was unaware of this check. A simple test
"r1 +=3D 8; r0 =3D *(u64 *)(r1 + 0);" does indeed report an error.
I'll make sure that every context type is annotated with
preserve static offset, thank you for pointing this out.

[...]

