Return-Path: <bpf+bounces-15322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114927F03A2
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 00:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90FE1C2094A
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 23:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B888208B1;
	Sat, 18 Nov 2023 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4+xPbLr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83ED49;
	Sat, 18 Nov 2023 15:35:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so2413164f8f.0;
        Sat, 18 Nov 2023 15:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700350536; x=1700955336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o1oNmaFZ0ntKwjXKoCN526PrPN6jcZ6l3gzfiJBit4=;
        b=Y4+xPbLr6jZ2upM3IdZ4w1Bfl/rKBCOraENVwNQIPkOCmTjV9buBbv5Cwv5QD0hdQX
         CB8Rg6wNobyIgBrARRCT7Outig9u/+ASpYwnvKXG8ddQuyrzV058Pd1s69bBIMGaBRN7
         VnwOsrbbgYjlhbUml6NklSCnVeWgZJagQYcgIjvSW3NGfA0HjMk+0ZCFm6pc6jVHM/ha
         eymOvpt4b8SWL3W4muHRnBr3/ANWDHx8MZw/DgfkmZsQayROJIaeYkOkws7jEawXUHRK
         tK5LcnYlwjvSXG2pOp2g9BXs86uTWWNHJx4hTrXAE/TBIYex/Y6PyeOHV2/Gbup2CUmo
         mMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700350536; x=1700955336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o1oNmaFZ0ntKwjXKoCN526PrPN6jcZ6l3gzfiJBit4=;
        b=MHKQ+1YbIVN1IozZ2ur777aBZBzuOr6vIU8dnfDyGpAnMXGFp9pUxtuVw2Ko048rS+
         EGLtygOpjiK3wGcphyutA3k5SHqGEivQ81Kx7rhQcZyV0j+61RnJRk/OXy8MM4L57IqS
         aHmHKkYGjV2esfNmOw0q49Vw64cxGXyeik8plLACTiUjJ3e2fe5fQ8dpaERo8mWmN0Wi
         yuSv9dvl1APy76A68GjlYeLR9n0wkMDMO4ryM6t618LCEqttjQjbwGfcUE9rCes0helc
         QNGP3t32CGGP1KFoMhmJv6WFwHUWt5wUVRNIqH8OlbfmYhvo1RKNlUH5Ar2eId+3sEkH
         i4kg==
X-Gm-Message-State: AOJu0YynZX3ZY4yiejhsdccTwFrmVhq2KjYz8WkNTVlHZ7BRlo2eYcr9
	ZJS2ilxEUjz8RLReuy2Ax8Cyl5s/J0BiBpFKwSdSaimp
X-Google-Smtp-Source: AGHT+IFGCLI2g4xaA5FosNg3UmOsfKQOUXe0xgeb8Kz33n4UrM/r9mfIeJAq1/HIXEMbJsQWtZDf4zK5fFad0Q/pVNM=
X-Received: by 2002:adf:fa44:0:b0:32f:ad68:7474 with SMTP id
 y4-20020adffa44000000b0032fad687474mr2400325wrr.20.1700350535999; Sat, 18 Nov
 2023 15:35:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118225451.2132137-1-vadfed@meta.com> <CAADnVQLBE1ex-B=F07R0xQKo-r22M0L6eiS8DjOAtsur-hEbFQ@mail.gmail.com>
 <862c832a-da98-4bef-80ef-8294be1d4601@linux.dev>
In-Reply-To: <862c832a-da98-4bef-80ef-8294be1d4601@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 18 Nov 2023 15:35:24 -0800
Message-ID: <CAADnVQJ7__C06a=v0RfMvGQ_ohT21n=-1EUuaxqBe3aYU1izEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add skcipher API support to TC/XDP programs
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Network Development <netdev@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 3:32=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 18/11/2023 18:23, Alexei Starovoitov wrote:
> > On Sat, Nov 18, 2023 at 2:55=E2=80=AFPM Vadim Fedorenko <vadfed@meta.co=
m> wrote:
> >>
> >> +/**
> >> + * struct bpf_crypto_lskcipher_ctx - refcounted BPF sync skcipher con=
text structure
> >> + * @tfm:       The pointer to crypto_sync_skcipher struct.
> >> + * @rcu:       The RCU head used to free the crypto context with RCU =
safety.
> >> + * @usage:     Object reference counter. When the refcount goes to 0,=
 the
> >> + *             memory is released back to the BPF allocator, which pr=
ovides
> >> + *             RCU safety.
> >> + */
> >> +struct bpf_crypto_lskcipher_ctx {
> >> +       struct crypto_lskcipher *tfm;
> >> +       struct rcu_head rcu;
> >> +       refcount_t usage;
> >> +};
> >> +
> >> +__bpf_kfunc_start_defs();
> >> +
> >> +/**
> >> + * bpf_crypto_lskcipher_ctx_create() - Create a mutable BPF crypto co=
ntext.
> >
> > Let's drop 'lskcipher' from the kfunc names and ctx struct.
> > bpf users don't need to know the internal implementation details.
> > bpf_crypto_encrypt/decrypt() is clear enough.
>
> The only reason I added it was the existence of AEAD subset of crypto
> API. And this subset can also be implemented in bpf later, and there
> will be inconsistency in naming then if we add aead in future names.
> WDYT?

You mean future async apis ? Just bpf_crypto_encrypt_async() ?

