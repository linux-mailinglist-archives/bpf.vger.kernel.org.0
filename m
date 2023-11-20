Return-Path: <bpf+bounces-15336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7857F0A47
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 02:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172FE280C1A
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128151855;
	Mon, 20 Nov 2023 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1s5M8Qg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E3FB9;
	Sun, 19 Nov 2023 17:14:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083f613272so14422425e9.1;
        Sun, 19 Nov 2023 17:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700442841; x=1701047641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umj4itHltkRsbkQLxGQmBEgTrbiiFmAkKZvhOW9+joE=;
        b=A1s5M8Qg9GKNuQ9rq+7ybvAUGE0R+tqk7oqX5k8NPN06gGcf448frdF02HUa11kO6t
         BSaFE5QDIsEWsqSo0l2byfZMHKSukPs8BAMwl+O0DW8/3CwzKCocTB45UPykqsYpOraY
         z2f33zAhIMdhQQyR8zevqI/gpGJds1Sa4J0yccgEXPlLvimev/VBO1FQ0mAVwhZTOtQq
         uMhXF+/1U4Nb6k7tTmzZS7wE4qHOhm5I9fiqXwRQsa88klHhpZxu8MGPM0fe18blQp5F
         jfHOfbYT+Hb2iCvN3uWZzz0Cr31IG1PLkDFErudxCVbBZy3S7UmjWo7H4gq/V2it/tuf
         E+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700442841; x=1701047641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umj4itHltkRsbkQLxGQmBEgTrbiiFmAkKZvhOW9+joE=;
        b=bHQ118j6l1wga+SOp6TX3a/jAyq9b43K/Elgi70Tt0n3h5YGmV0xmhQtI8wL8zy85i
         szh6HMz8JsYZhyWN8db66wf46yomwTiZgLSWWWJKRJetnZkr1/eCsiHWiziwKbZSpZkJ
         LRs5NR3BuFJYn2exoJlsAn5joTX9eM6ve2ChA0VuBtzXxdKdkyPCJ65NDJh98CK7RHbU
         PfHIRQVHo5Roa9O8E/L20lCePtWDHkR9SSFji7/MW6Xk/d1vdKajJvd1uOuKQVbk0m8O
         ptZ7BouClrmxV5vRc+wdUx9hT7NvoGnIkvWBi4Jxb+/nyfi5CuDpCfH782UgbLwEQbOj
         WJ7w==
X-Gm-Message-State: AOJu0YzrtMpBOXL9yO4HkIYj9+EYml0+wvo8/lRw230yataWUjn5iYis
	0szahDa3OUK4AMHvCZyxmxrVHxuukEu87mMhnms=
X-Google-Smtp-Source: AGHT+IETSG+CuLZ6K94BN3RnzBo09ErtUg0dKmBuYD46494P/G4h0oOZMSHKgFfqEfjy4qhRJT2Nqt62331fi7Da8i0=
X-Received: by 2002:a5d:64e8:0:b0:332:c9e7:3d28 with SMTP id
 g8-20020a5d64e8000000b00332c9e73d28mr237114wri.10.1700442840452; Sun, 19 Nov
 2023 17:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118225451.2132137-1-vadfed@meta.com> <CAADnVQLBE1ex-B=F07R0xQKo-r22M0L6eiS8DjOAtsur-hEbFQ@mail.gmail.com>
 <862c832a-da98-4bef-80ef-8294be1d4601@linux.dev> <CAADnVQJ7__C06a=v0RfMvGQ_ohT21n=-1EUuaxqBe3aYU1izEg@mail.gmail.com>
 <312531ec-aba5-4050-b236-dc9b456c7280@linux.dev> <CAADnVQLKsOs7LSFWGbAtJ8WfZjnQ0B_7gwFA-ZMdLPmukMGZ1A@mail.gmail.com>
 <c1e3db50-50bd-d728-a911-58fa1c77506a@linux.dev>
In-Reply-To: <c1e3db50-50bd-d728-a911-58fa1c77506a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Nov 2023 17:13:49 -0800
Message-ID: <CAADnVQJvfdPh7YXj30vsqkUF7a9M5SCaAkaB9qkmndS892Fu+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add skcipher API support to TC/XDP programs
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Network Development <netdev@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 4:22=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 19.11.2023 16:56, Alexei Starovoitov wrote:
> > On Sat, Nov 18, 2023 at 3:46=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 18/11/2023 18:35, Alexei Starovoitov wrote:
> >>> On Sat, Nov 18, 2023 at 3:32=E2=80=AFPM Vadim Fedorenko
> >>> <vadim.fedorenko@linux.dev> wrote:
> >>>>
> >>>> On 18/11/2023 18:23, Alexei Starovoitov wrote:
> >>>>> On Sat, Nov 18, 2023 at 2:55=E2=80=AFPM Vadim Fedorenko <vadfed@met=
a.com> wrote:
> >>>>>>
> >>>>>> +/**
> >>>>>> + * struct bpf_crypto_lskcipher_ctx - refcounted BPF sync skcipher=
 context structure
> >>>>>> + * @tfm:       The pointer to crypto_sync_skcipher struct.
> >>>>>> + * @rcu:       The RCU head used to free the crypto context with =
RCU safety.
> >>>>>> + * @usage:     Object reference counter. When the refcount goes t=
o 0, the
> >>>>>> + *             memory is released back to the BPF allocator, whic=
h provides
> >>>>>> + *             RCU safety.
> >>>>>> + */
> >>>>>> +struct bpf_crypto_lskcipher_ctx {
> >>>>>> +       struct crypto_lskcipher *tfm;
> >>>>>> +       struct rcu_head rcu;
> >>>>>> +       refcount_t usage;
> >>>>>> +};
> >>>>>> +
> >>>>>> +__bpf_kfunc_start_defs();
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * bpf_crypto_lskcipher_ctx_create() - Create a mutable BPF crypt=
o context.
> >>>>>
> >>>>> Let's drop 'lskcipher' from the kfunc names and ctx struct.
> >>>>> bpf users don't need to know the internal implementation details.
> >>>>> bpf_crypto_encrypt/decrypt() is clear enough.
> >>>>
> >>>> The only reason I added it was the existence of AEAD subset of crypt=
o
> >>>> API. And this subset can also be implemented in bpf later, and there
> >>>> will be inconsistency in naming then if we add aead in future names.
> >>>> WDYT?
> >>>
> >>> You mean future async apis ? Just bpf_crypto_encrypt_async() ?
> >>
> >> Well, not only async. It's about Authenticated Encryption With
> >> Associated Data (AEAD) Cipher API defined in crypto/aead.h. It's
> >> ciphers with additional hmac function, like
> >> 'authenc(hmac(sha256),cbc(aes))'. It has very similar API with only
> >> difference of having Authenticated data in the encrypted block.
> >
> > and ? I'm not following what you're trying to say.
> > Where is the inconsistency ?
> > My point again is that lskcipher vs skcipher vs foo is an implementatio=
n
> > detail that shouldn't be exposed in the name.
>
> Well, I was trying to follow crypto subsystem naming. It might be easier =
for
> users to understand what part of crypto API is supported by BPF kfuncs.
>
> At the same we can agree that current implementation will be used for sim=
ple
> buffer encryption/decryption and any further implementations will have ad=
ditions
> in the name of functions (like
> bpf_crypto_aead_crypt/bpf_crypto_shash_final/bpf_crypto_scomp_compress).
> It will be slightly inconsistent, but we will have to expose some impleme=
ntation
> details unfortunately. If you are ok with this way, I'm ok to implement i=
t.

but shash vs scomp is the name of the algo ? Didn't you use it as
the 1st arg to bpf_crypto_create() ?
Take a look at AF_ALG. It's able to express all kinds of cryptos
through the same socket abstraction without creating a new name for
every algo. Everything is read/write through the socket fd.
In our case it will be bpf_crypto_encrypt/decrypt() kfuncs.

