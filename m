Return-Path: <bpf+bounces-72166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608DC083AA
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 00:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 891844E0396
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 22:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346B31B823;
	Fri, 24 Oct 2025 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emuYPj35"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF121C7009
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343976; cv=none; b=clCxR/u1xifNEXPCX5npPgBco1YJPOXZ8DHkmVu0PKoExm+OPQM5OcxGmFGrdpLbdwkAClxw6MdyAE5/ascbK+t6J+bcxn4HadPlhpG4hwA0QIL2h7QzMe/D4O35vNr2+w5NCa89ysHgmF0WJyqA7hV2GUk9VU89gkFRy9Ik6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343976; c=relaxed/simple;
	bh=9zqC5lF20ypXQgHpvGiMsN5q05WsxjG5ouI2iXTn//Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgCM1iFlYjp/uIbdP8Xn4+BN6xC6eTJqQVBqw9VLHBYaYSZn9M7NGgnCuJ5KqluG09GyCQZmf4HsdetZtwlguvHRzCaA5qKIgrdOioIm/zjAGyKzkMjumzcN04CjCtAJqjhT5n17gspjxiN1XVf2ywVNUtyvo7wvvyfKOL97iYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emuYPj35; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2394866f8f.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761343973; x=1761948773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xonPBObzcHZQK7C5nkSGfFwmUilJrGYg705NMOQjwXY=;
        b=emuYPj35sIqaCL19eGllwvvNudFrTEmWs3Nu6QnF8iczQ6VfvpwXGZt72vQu2OjZOP
         8cysBVKCKecuE9aHxhnXIVm5FFyMDbAzzJ4TjcQa60Y88pH0Y7vQ06E7JyiZWSIRmDq2
         f22FTjeHtvnMbDag7hZ0+RtLZj26jwi5rlMCxqT5/EbFcvvFxadPZNrfo8Q4XICvXUjw
         B8p+kO2dIVB1sR5D76bikXphXXh7Iu8zLyUN5WOvR7/96hN+bwq0RN+jGddO2IdTLgfD
         qN0T3GqsQjV4HzpHsfAQz0ABzrQaSjsh+1Ee7cgC/0tJsNR0gPYS2xrbFcQNP0YFGkkK
         O36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761343973; x=1761948773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xonPBObzcHZQK7C5nkSGfFwmUilJrGYg705NMOQjwXY=;
        b=nwWeCS+vrGT4bEBRCHjakLqc87y3iEV+qVINEDqSUUAS/s6CrknsEbl/GkdILQEdnw
         zDj9q2wWShmwQOoL/5xZkr3GZFAH4TYi3YPqvRYhoUL6V9RAKuiBjKzpSydzUjsVFY61
         sMSosf6ILAwae3Ph/STp8jWkSgDOJ0bhGNa5s/paaJXxqKnuHwBrfG3ytwWZtV3wli16
         EXmo9pYJoB3XJrpXWwAlvfcTtIG1th5sceYym8sebY6JwivgqdXuV0bK48y2aDrfbLec
         Sfj8wkHCI2BUcDUgrEt1ekJ00CBytw989Kj0uYNbed68Pz5JXVWdKiFzSQDPD/ezuZ24
         JN1w==
X-Forwarded-Encrypted: i=1; AJvYcCU41SC1fBx1oQwM76/44T2v95P1AWdkRn/BZVw+7w7cycw8cD9iYjQTdi/sKa9PjBft2+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0lJJZqHXF9Key4r6eEeCDbs/abM7xkbu09BBGYPVLR2u345z
	dzA9KNaTUDIBvMn6Aiz1HTUSkpGBKR1N2lIeNv3TisvO71bmzcCuYYHLalS4Ggd0qTK28hAxRjH
	lijQ8gtHV2r5yJs/Mu9Pd6A61/3+rpKA=
X-Gm-Gg: ASbGncvqRM5ny6JrwmOPOlJi2FD5EUalcDUBXuPAehwMDvTI7fOo8Z7qxYi5vQkDSvZ
	qFzk1DjZIb9hUDMfCiFSPLvowxa34dMQS3KJQhsBOkoJjHdtvXAD+KeFcyU+GM3jt2k9GTzAz7A
	6/SeK4LcozVvjgIha/1mNWN8fyVK2t29+TgS8o38wW2H2CR1pwyRuUb3HrizeFh2EydVl76kir6
	vOeaGP0V0gFtRyhA8lVs88hAJOVm6Q6CQ8W8wQihzNUl8xZIMfx4G4E0/bDwQT8459Ldx4usUzx
	MBM2z4tBtUvM7qvHJA==
X-Google-Smtp-Source: AGHT+IHz7aBErep/owoxCI2Z1jdJZCXEI2iRuMOXjf6MfItdu+GtbngaEmbBGmyf/AoUB+RXDGTOVIqDInOQ451rY0M=
X-Received: by 2002:adf:e3c8:0:b0:429:8d74:4b16 with SMTP id
 ffacd0b85a97d-4298f59482cmr2389238f8f.20.1761343972846; Fri, 24 Oct 2025
 15:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
 <20251021200334.220542-9-mykyta.yatsenko5@gmail.com> <5f873de5d22d95133aedf31e4b2e1d81cfca4647.camel@gmail.com>
In-Reply-To: <5f873de5d22d95133aedf31e4b2e1d81cfca4647.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 15:12:41 -0700
X-Gm-Features: AWmQ_bmsle1rc-ln2E6fcoSFSD5q5gVuNKBKtG9tb7hx1p4GtuW8mZp_wq_szfM
Message-ID: <CAADnVQ+M=gsfwA4bUqFRYoZwSPO=sHpMKmieAfpa9MYWNbv5Qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/10] bpf: verifier: refactor kfunc specialization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-10-21 at 21:03 +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Move kfunc specialization (function address substitution) to later stag=
e
> > of verification to support a new use case, where we need to take into
> > consideration whether kfunc is called in sleepable context.
> >
> > Minor refactoring in add_kfunc_call(), making sure that if function
> > fails, kfunc desc is not added to tab->descs (previously it could be
> > added or not, depending on what failed).
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -3126,6 +3124,10 @@ struct bpf_kfunc_btf_tab {
> >       u32 nr_descs;
> >  };
> >
> > +static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_=
id);
> > +
>
> Nit: this prototype is no longer necessary.
>
> > +static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_k=
func_desc *desc);
> > +
> >  static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
> >  {
> >       const struct bpf_kfunc_desc *d0 =3D a;
>
> [...]
>
> > @@ -21861,47 +21852,62 @@ static int fixup_call_args(struct bpf_verifie=
r_env *env)
> >       return err;
> >  }
> >
> > +static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_=
id)
> > +{
> > +     if (bpf_jit_supports_far_kfunc_call())
> > +             return func_id;
> > +
> > +     return BPF_CALL_IMM(func_addr);
> > +}
> > +
>
> Nit: this can now be inlined in specialize_kfunc().

+1

especially considering that
if ((unsigned long)(s32)call_imm !=3D call_imm)
check right after is necessary only for !bpf_jit_supports_far_kfunc_call().

> > +     call_imm =3D kfunc_call_imm(addr, func_id);
> > +     /* Check whether the relative offset overflows desc->imm */
> > +     if ((unsigned long)(s32)call_imm !=3D call_imm) {
> > +             verbose(env, "address of kernel func_id %u is out of rang=
e\n", func_id);
> > +             return -EINVAL;
> >       }

pw-bot: cr

