Return-Path: <bpf+bounces-46110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336BA9E4715
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E959CB45648
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1911F5433;
	Wed,  4 Dec 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZSOk2gt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36051F5415
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343772; cv=none; b=OhlPnzlN6JkPwBbNR32xy6HTgf3wweaSjMi6vjHk1sUP4lUWRAVcvcKsh1xwQlTFGgxcjz1OtAJwPCKjsNUIznWkLB+AzdTk1aV9LyYQ1JBjaDQG9dVPatEhwYU3Giu5vUeFU7VQMrsHrfISdIM0DgB2YOWbkjQRTvr8vehTwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343772; c=relaxed/simple;
	bh=Qmy25N6CuU37YdHgaqBQ2F7NB9C4uR9yIN/9WYd1s/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGXxRMs+QRSVKmdV0AE8aQ452i1ctjM1NmYwZ2HIfnXOSRM4eJ/u4MbBNQdkSyOMFRIS7Ek5bhnjtnNbY+6e/d2t+P6YyzR/YTFkZ9pzeykiJpwV2AsmIxassNyZIghv5lX0quL9kqjtulJpdJaDzyAlRJ+ItCOKJc8O46ZpvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZSOk2gt; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so208456a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343769; x=1733948569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+R20hSUCeQlbN9mrVdtGmaKKSteaYXNQKWECrH9wFpU=;
        b=cZSOk2gtUzqp3C30LgdO584PNNXsHz9fHDsy2FwIlojLnYNRziIZI7r4cBIQEyZQlZ
         qgx3v+N4uqV9bAPM3nLibScMaxs9eIwqEalllUb3ENqX+kgJF1naRTrtDTFZBzY7azUa
         7imnjIokfP3WccYzNFAKOv4gIcKJwKn3B7/p7RFcPUwJ8l5IsrymaImQMzj4KaczOKgU
         xr8MinK7iW4fIhRMh0XkZ8PyItt/xf7Ev3zkGkbF7FublaSzr5s3izIJnTy8W8yEFFMH
         SCYvxctfRjOfLIwmmJMUaF6utmyk70Ke+SxTNKiIuC1yPc03ePsqXuPlWnNPC0IYKaE+
         Z9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343769; x=1733948569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+R20hSUCeQlbN9mrVdtGmaKKSteaYXNQKWECrH9wFpU=;
        b=WzX5DIqrfVq9hYcahtLPubCHl/YeejIMqTboN6k2uyw6mEZ1HzB2JirV7/QKZBwuBN
         V2Z/wf9MjjAvaO1duQoUBPNjTV+Vr0JRr1RDCV1HCDY2EeMeLX2lOPms4u72bbi8a5AO
         Tx1QfXoTKbFEbcR8vivVTpO+4ivyrHY2doaE0/rso309A/FFp/JpAoiY4Gif/Jcmbn5n
         hMPAURB6VlZO1jaDsLDnQEPoOiMwzIHTrYRv6FwNi3x8zQWKiFlZA+Xco14Ir10zsigy
         CEs2DHc5gLneygqzGziZJ0IF5vW04LhFBwx6CIPAkj3L+VQFRfI+GbnVap/4yisNdITH
         0iYQ==
X-Gm-Message-State: AOJu0YyFjnAyXy/J/wFSCC9gVYbEP6oistvcE5lJ7PN8GfZm83g2zzml
	sOaQN5wefeqz3HRyI6Y1oiphTDbMKbJkGsBIjANDwANsBH4d9qXu/5o8HbKhPVKjV3yJcU1Qqt9
	LdSugG89gM+QHUpohl7E4Gk1XL3Y=
X-Gm-Gg: ASbGncsO2Wu5GZeqHmwMgb6HaaPl5spKJ+g6oP/o5/7g4NmyfNEHo3W45bvmbGBz2IB
	Bu+SHW35rJtJIrnaJzuqgd3PdHMbr+jA2fqlwl+y3kUQ6gUDyRal1S6MPJQqFwczE
X-Google-Smtp-Source: AGHT+IEZnBzbmuGQn2B9Z6XrGFrtAA7Rp3+EIAbVzRsITScFiCFW0eSNTp5nPiTyzzbGSmWS5ntGqnNKVUNZhVogU3o=
X-Received: by 2002:a17:906:cc2:b0:aa5:3663:64bd with SMTP id
 a640c23a62f3a-aa5f7dc92e9mr843010266b.36.1733343768745; Wed, 04 Dec 2024
 12:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204024154.21386-1-memxor@gmail.com> <20241204024154.21386-3-memxor@gmail.com>
 <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com> <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com>
In-Reply-To: <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 4 Dec 2024 21:22:12 +0100
Message-ID: <CAP01T770rUveB4Toj_gU7Fy-SyyTr0EvaCBDTxdkGBz2bBBAzw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Manu Bretelle <chantra@meta.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 21:19, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 4 Dec 2024 at 21:12, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Tue, 2024-12-03 at 18:41 -0800, Kumar Kartikeya Dwivedi wrote:
> >
> > [...]
> >
> > > +/* r2 with offset is checked, which marks r1 with off=0 as non-NULL */
> > > +SEC("tp_btf/bpf_testmod_test_raw_tp_null")
> > > +__failure
> > > +__msg("3: (07) r2 += 8                       ; R2_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
> > > +__msg("4: (15) if r2 == 0x0 goto pc+2        ; R2_w=trusted_ptr_or_null_sk_buff(id=2,off=8)")
> > > +__msg("5: (bf) r1 = r1                       ; R1_w=trusted_ptr_sk_buff()")
> >
> > This looks like a bug.
> > 'r1 != 0' does not follow from 'r2 == r1 + 8 and r2 != 0'.
> >
>
> Hmm, yes, it's broken.
> I am realizing where we do it now will walk r1 first and we'll not see
> r2 off != 0 until after we mark it already.
> I guess we need to do the check sooner outside this function in
> mark_ptr_or_null_regs.
> There we have the register being operated on, so if off != 0 we don't
> walk all regs in state.

What this will do in both cases::
First, avoid walking states when off != 0, and reset id.
If off == 0, go inside mark_ptr_or_null_reg and walk all regs, and
remove marks for those with off != 0.

>
> Do you think that should fix this?
>
> > > +int BPF_PROG(test_raw_tp_null_copy_check_with_off, struct sk_buff *skb)
> > > +{
> > > +     asm volatile (
> > > +             "r1 = *(u64 *)(r1 +0);                  \
> > > +              r2 = r1;                               \
> > > +              r3 = 0;                                \
> > > +              r2 += 8;                               \
> > > +              if r2 == 0 goto jmp2;                  \
> > > +              r1 = r1;                               \
> > > +              *(u64 *)(r3 +0) = r3;                  \
> > > +              jmp2:                                  "
> > > +             ::
> > > +             : __clobber_all
> > > +     );
> > > +     return 0;
> > > +}
> >
> > [...]

