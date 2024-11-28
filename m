Return-Path: <bpf+bounces-45805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BC9DB1ED
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264A7B20CE3
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2154652;
	Thu, 28 Nov 2024 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5G3Ee0y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9832CAB
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764763; cv=none; b=AItC14HgSPXRuZ5bQGS2rFllUdQBzzMVAK/GQC8h30qAtHJEvyNK9w0UMOfn9WEvGZR7wP4K8NBsQg4Ntx0Y0HvZCi6AoADbVUSA76ZlkvJ6O47++y8myT/JzTlyHBgh9DryzOr8OJ1RA9tvxS9tP0THT9vcnFuhQ3IOamZjRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764763; c=relaxed/simple;
	bh=zx2x008TigOin6aWAgkMPa8mCgayg1ACYsOs1ZGf8WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1g0hmvFPVWAsMVjqHX+RAmEtBsVrAzh2yoFJM6Z30VJr2mz6tqoB2WRoF0/YCupvQOOn8CV2UQjpEsq7U8QGsVc6DvTbgYvqaeUUxad7v3mvyI89Xr55qn16x/o82Eb8bzJhSnym10ouGXVbm7pWB5dR97Yg/dIXP4f/DcyIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5G3Ee0y; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso48262266b.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 19:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732764760; x=1733369560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BgwWPlGV7qr7k42vUzpaN0+X1MRbtjayj5WPlmUXbVU=;
        b=g5G3Ee0yRlTV/99kr5bxWG7HLkKuGDxyiNRGy92if7x5wnGcDOBxvDPOpXz28T5Hss
         3ixfFIUMicoRSyTjIoBB5/4G4rx0PEorUUYmKWSGTUtgOTB+vDau9taHeItjPKKbucJo
         C9he0sj7DVIQXNITSdAftGSJNYV1vZEny6uW1oa6jKcXLWQrunqraM6D61Ud5KBA2TiD
         QxfJGEBBAv28tLt7hIwDNPYtb0RDRUB5Bw2qCLojML7R8bzkmebNX+Qr9u3W33QhwPNG
         tiVn2Ray15USSOnLYfw6hu1576Lv+SgaS25JBD1DlIuEQwj+Cm2Usc3Vijem2sEcO9YW
         c81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732764760; x=1733369560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgwWPlGV7qr7k42vUzpaN0+X1MRbtjayj5WPlmUXbVU=;
        b=EaZxsB7hvYB1bXulduMtdZkcdFT7X3TNC33WExS5Y36qvAuncoAfVC82GB+JcM70a4
         ye4tdcUwR6d2GjfAtw0LbRJdW84u9t82vIWYHiwusrOGvz1Eys7doFnqlqWZg/uwFDIX
         gZYCPxQn9y+DF4M/G2PM1Z2QW2X05oK0/BsoSbY7HgUP9gbTj7NitiJM5xmNog8ebkd+
         rdPwLz9+8+r8rGMeRv6s/vsdq77rOh6nORMSiiiDjr4uvsGlQHhnrGAp8z++KxFHospn
         zZjofbjx4rbeH2jBjh1eoAD0xF73p91WzQ3shmXVvl/maoT4m5qAnvktp3m+saUq+NHX
         gQDA==
X-Gm-Message-State: AOJu0YzCF6brsiBYY3Rrya28j52Rwqr0IYg4b4hV6Ec6D84Pu1mZqb5W
	t/fJ6Nfzq/FTFhK2KqHigR5Av0gvu8oFhuln0qHb5d8UP6Hoipdsq4k5tTCjApYsp2PxCT5kv89
	GU6Oy4hC0zKZ+YdjzMsbTuCgyh+k=
X-Gm-Gg: ASbGncuP61FjtXVWQjmh9LaNK/RlkPABjJdw8h6EfNonlatFEUD+wQJ+lNhAu8ozktG
	/Vtrf2EoeVdFzUyi8BiXzIU/adfSB3GcX
X-Google-Smtp-Source: AGHT+IHuv5VIZT3GqgrZW3Vzf5MVukb/dYWG4Buj9EgLRmVqnB0yGjk9pBUDlnofX3K+y54VTi4R+ZXxuYbnLj0tNZs=
X-Received: by 2002:a17:907:7781:b0:aa5:451c:ce22 with SMTP id
 a640c23a62f3a-aa580f4c958mr406384166b.31.1732764760197; Wed, 27 Nov 2024
 19:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165846.2001009-1-memxor@gmail.com> <20241127165846.2001009-2-memxor@gmail.com>
 <a4690c29ca3b5f34945cd507def7e0c6ecdec9e1.camel@gmail.com>
 <CAP01T77t=FmvzyeCJ_3Bp+8D0-Z4GGUHNeGbNBmSY6xFXi-ZgA@mail.gmail.com>
 <3cc26b1923426203b3d0df91ebb1638c0e492696.camel@gmail.com>
 <CAP01T76RCf1oHmWhhE8MzUYgJhkxkkqW7gRFCAPGiAgv8v7WkA@mail.gmail.com> <68eadb6b1c51707be249af9bacc7afcbfa16df0f.camel@gmail.com>
In-Reply-To: <68eadb6b1c51707be249af9bacc7afcbfa16df0f.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 04:32:04 +0100
Message-ID: <CAP01T74EUr6aiLSfFn0kzvfjTPgZMLYXo-jpChdwtZyaM3tkgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Consolidate locks and reference
 state in verifier state
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 04:22, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-11-28 at 04:18 +0100, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 28 Nov 2024 at 04:03, Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Thu, 2024-11-28 at 03:54 +0100, Kumar Kartikeya Dwivedi wrote:
> > >
> > > [...]
> > >
> > > > > > --- a/kernel/bpf/log.c
> > > > > > +++ b/kernel/bpf/log.c
> > > > > > @@ -756,6 +756,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
> > > > > >  void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_func_state *state,
> > > > > >                         bool print_all)
> > > > > >  {
> > > > > > +     struct bpf_verifier_state *vstate = env->cur_state;
> > > > >
> > > > > This is not always true.
> > > > > For example, __mark_chain_precision does 'print_verifier_state(env, func, true)'
> > > > > for func obtained as 'func = st->frame[fr];' where 'st' iterates over parents
> > > > > of env->cur_state.
> > > >
> > > > Looking through the code, I'm thinking the only proper fix is
> > > > explicitly passing in the verifier state, I was hoping there would be
> > > > a link from func_state -> verifier_state but it is not the case.
> > > > Regardless, explicitly passing in the verifier state is probably cleaner. WDYT?
> > >
> > > Seems like it is (I'd also pass the frame number, instead of function
> > > state pointer, just to make it clear where the function state comes from,
> > > but feel free to ignore this suggestion).
> >
> > I made this change, but not passing the frame number: while most call
> > sites have the frame number (or pass curframe), it needs to be
> > obtained explicitly for some, so I think it won't be worth it.
>
> Understood, thank you.
>

Ok, scratch the previous reply, I forgot you can actually do
func->frameno to get it, I was trying dumb things (like func -
st->frame).
I do agree it's better to pass the frameno, just for the off chance
that you end up passing vstate and funcs that mismatch.
So I ended up making the change in the end. Sorry for the confusion.

