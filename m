Return-Path: <bpf+bounces-15328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551317F07AC
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E6C1F224AF
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B914F70;
	Sun, 19 Nov 2023 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULIuyBBp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3978911A;
	Sun, 19 Nov 2023 08:56:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so2687591f8f.1;
        Sun, 19 Nov 2023 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700413009; x=1701017809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wIX8ORXLGy4iPlNpzgFGE4EPRBwYYYCdBAHOnzVq8k=;
        b=ULIuyBBpng4LRBCxeJ3S8O0R19NZ1zZOS4e43Q7u5u4KJW+bSpKZfdKFpfRyHRptcr
         XDuewq3gKMwAU3APLNtexDxZ2hWfYXJ0VgnhiHlX6XFUTYran58dL26lMwVGU9wr9dFr
         BeXYTIHwlgST0bb6PeH9gTUT545Gqn6uakC5WZzjOLx0TC6KPqd4g3aLNEDx8sX+26lt
         Gdd0bDToKRRa8ygjTHnXAhyZx0mXig0uo70tJn9xxv7MEfMTT2Fwnd5RxtuA+HbyP/DB
         ZwstDQVMJpSecnBaAgmPKUJTrpNXqtsInH4P48DCAyM6kJQMGmcg9QJi+zUwulH8w9K6
         pcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700413009; x=1701017809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wIX8ORXLGy4iPlNpzgFGE4EPRBwYYYCdBAHOnzVq8k=;
        b=a6KKiqg0LbRSSUjRNSHfjvCdU57O/TJ2JJhq6uo6chSql8vxEWTC0ik54W/Awx37en
         l6tDPY1ttWMc/pzDgCIMSaNZb+c0k3V63Qow9sNssYGQK3oTqynz7MoDL3n5nW55yGhO
         Qgd1AW+pl9yvrkxIf9rbRHiwrO2k2fFPf3fM4f8JGBnmdtJ5XwOruQvnbhA3cGmUR6Yy
         RS4WgVIpLF4t5xWn7Hd1XdM1DzngmajHlduAbpeC4ok6bG3xDT1sE2X0kDFuvfXY0kA2
         avQHCHt87TQVykaSNFrznEZGt4dNBvvdTbpVfIUBAzOUhgDDgOfkQhkIwnRo1ZhXZunS
         uI+w==
X-Gm-Message-State: AOJu0YxztpIqyIR61Z2lMbh3Na1Zc4TmRC8slYLN9RM/VKVnkXvquyI7
	QLqeOqVM/Qk8AN+cNCbCxRvGb5A8ZlzCJZfsG1M=
X-Google-Smtp-Source: AGHT+IFulNsssn+l6xqU9rqBq3L25Id628JbtMByDUp68JRj97BiSucEGCH6QTStb+jPqIiCUJQ2iAedBfKWlYdWxNc=
X-Received: by 2002:a5d:5886:0:b0:32d:ad05:906c with SMTP id
 n6-20020a5d5886000000b0032dad05906cmr4403585wrf.3.1700413009333; Sun, 19 Nov
 2023 08:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118225451.2132137-1-vadfed@meta.com> <CAADnVQLBE1ex-B=F07R0xQKo-r22M0L6eiS8DjOAtsur-hEbFQ@mail.gmail.com>
 <862c832a-da98-4bef-80ef-8294be1d4601@linux.dev> <CAADnVQJ7__C06a=v0RfMvGQ_ohT21n=-1EUuaxqBe3aYU1izEg@mail.gmail.com>
 <312531ec-aba5-4050-b236-dc9b456c7280@linux.dev>
In-Reply-To: <312531ec-aba5-4050-b236-dc9b456c7280@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Nov 2023 08:56:37 -0800
Message-ID: <CAADnVQLKsOs7LSFWGbAtJ8WfZjnQ0B_7gwFA-ZMdLPmukMGZ1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add skcipher API support to TC/XDP programs
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Network Development <netdev@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 3:46=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 18/11/2023 18:35, Alexei Starovoitov wrote:
> > On Sat, Nov 18, 2023 at 3:32=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 18/11/2023 18:23, Alexei Starovoitov wrote:
> >>> On Sat, Nov 18, 2023 at 2:55=E2=80=AFPM Vadim Fedorenko <vadfed@meta.=
com> wrote:
> >>>>
> >>>> +/**
> >>>> + * struct bpf_crypto_lskcipher_ctx - refcounted BPF sync skcipher c=
ontext structure
> >>>> + * @tfm:       The pointer to crypto_sync_skcipher struct.
> >>>> + * @rcu:       The RCU head used to free the crypto context with RC=
U safety.
> >>>> + * @usage:     Object reference counter. When the refcount goes to =
0, the
> >>>> + *             memory is released back to the BPF allocator, which =
provides
> >>>> + *             RCU safety.
> >>>> + */
> >>>> +struct bpf_crypto_lskcipher_ctx {
> >>>> +       struct crypto_lskcipher *tfm;
> >>>> +       struct rcu_head rcu;
> >>>> +       refcount_t usage;
> >>>> +};
> >>>> +
> >>>> +__bpf_kfunc_start_defs();
> >>>> +
> >>>> +/**
> >>>> + * bpf_crypto_lskcipher_ctx_create() - Create a mutable BPF crypto =
context.
> >>>
> >>> Let's drop 'lskcipher' from the kfunc names and ctx struct.
> >>> bpf users don't need to know the internal implementation details.
> >>> bpf_crypto_encrypt/decrypt() is clear enough.
> >>
> >> The only reason I added it was the existence of AEAD subset of crypto
> >> API. And this subset can also be implemented in bpf later, and there
> >> will be inconsistency in naming then if we add aead in future names.
> >> WDYT?
> >
> > You mean future async apis ? Just bpf_crypto_encrypt_async() ?
>
> Well, not only async. It's about Authenticated Encryption With
> Associated Data (AEAD) Cipher API defined in crypto/aead.h. It's
> ciphers with additional hmac function, like
> 'authenc(hmac(sha256),cbc(aes))'. It has very similar API with only
> difference of having Authenticated data in the encrypted block.

and ? I'm not following what you're trying to say.
Where is the inconsistency ?
My point again is that lskcipher vs skcipher vs foo is an implementation
detail that shouldn't be exposed in the name.

