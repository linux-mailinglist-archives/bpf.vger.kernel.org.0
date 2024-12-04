Return-Path: <bpf+bounces-46109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB89E4721
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81FA7B3C305
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758B01F541F;
	Wed,  4 Dec 2024 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZARDYtRz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624851F540C
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343600; cv=none; b=HiWcy0nYIcGJwLpbj+wcNevBa5ZUlN5aUTspQ6+amrlFcStPuFqkWyx9hJmv9y6AWUMBILgpHYitN69Dq4Mdht6KLVD8k13kC4TyAWMR2/JznrYBKO4Yy7H2wNNWaCtXSjisjrSjMwt/uz05U0rqI0J/Nkyp3HKdockfgHrVQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343600; c=relaxed/simple;
	bh=TGkYHWLC/rPgS3NuSQiwXSMCMLfHD6/iE2s1qvtlNd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUaxEiVXFDPirsNXHquGhRiHNFxh7dRz8amHMpMcbn7vrq5coM7YJzW8Fp6vb1pfyU+92sWyNNtyq3rGHZlX5ldgzZWAcaOnhPi14zQ1vWo3RHX7EXCr3m7k3i2FJlgZZeE6Z3WMC/WYfm+o1qeS0Zon+cdeTHTyJpYaI848DAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZARDYtRz; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aa549d9dffdso14636566b.2
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 12:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343597; x=1733948397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QdfvIUyQ4oaN+bErdtBtL+OQMcaGwwxmrBKD9Hh6xEU=;
        b=ZARDYtRzZFO3/boiECeFdizNzvAtppHBuK99cSupvq7SemUejL84wDI/LXsCQIU4xX
         x5GJx6+TrORvxllvU21BGDc5RicNHJ1hycgSpcjFbkZvd3d96agIrtjU6mwCxxxvwrDr
         f+sgSVuUjc8NehmTr7O4vzmEj0xjaYJtFLx/ey527LxAy14PUplHPNhMIWIXxBjono+0
         nLE+fwc8FRLrmtUlvGseWU7cULGIypf4fGI0yEFJ/FvowW9SF553euPgWiH8Pfk9lzio
         xoQ61Jdnw36DCuFPs6Lpb7oDhCtqwC5OM14SooA+kMJ+YoT1XxHEaxynqevZ+l7aiOd7
         U+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343597; x=1733948397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdfvIUyQ4oaN+bErdtBtL+OQMcaGwwxmrBKD9Hh6xEU=;
        b=cW0mDDXhR1C4WgYX4Bhs82k5Mkuw9cL2WKEaifn0xEQ1p2RBmGfbh/vlLRMOLE8a3z
         qZQIfSscZMxyhcNQior6ouY3FTWC4tRNVEPQ7RggahAjVeza/o4OrPv9FHmqZSxsexc8
         iT7UEx5N0+cwmsgHXXG0qL+igJzNCY/bMj7IswQuzCf4okjvy3hbue/8cJZV1welPS8F
         KHj0hGamSmbrItg4wNIHmWIk2RIvDfErAPzdrMXb2kDlISsOZxC1YMAILJw8Vaxw4EvR
         5yiZJQaBuaT5lHjcfkir9nfL7RLEz62/HNPp2rolojTLczqxzf1715Sm9nYzkxNZ56XL
         ziiA==
X-Gm-Message-State: AOJu0YwvmR4XukYqz9olrUtPHoJDIqEEPlkbTX0XVIro7k73/b2hD356
	qAPw1i+LDPmOtvFiGO3LlUHX2LS9hupn/J3ow4kx2S+tZkux0nfcYLONGucas1E1R7RYvGloJE5
	gMN/xkc9XgVZMCAM37YO0rjtIZW8=
X-Gm-Gg: ASbGncvWTZuZAIA5GP2ic5tZClkK+3KTzlkRfsddKwE6zGpJwAjnBa+R6VX6/+2mD5h
	p2muvIC78vT8w4yjnfji2VHeKX4cn/p+nftLaDE2a0ufcD9Lx1hAi9ZHSXwSG8wd6
X-Google-Smtp-Source: AGHT+IHyPZ+GEc7tGco/Cv1kU46BU00z/klEtqfYno3NqDdu8tOV4fVQjDmq+IBI84aMqQ6W9197opFNAdRn8DNL2/k=
X-Received: by 2002:a17:907:a088:b0:a9a:129a:1862 with SMTP id
 a640c23a62f3a-aa5f7f4acddmr602731366b.60.1733343596558; Wed, 04 Dec 2024
 12:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204024154.21386-1-memxor@gmail.com> <20241204024154.21386-3-memxor@gmail.com>
 <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
In-Reply-To: <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 4 Dec 2024 21:19:20 +0100
Message-ID: <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Manu Bretelle <chantra@meta.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 21:12, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2024-12-03 at 18:41 -0800, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > +/* r2 with offset is checked, which marks r1 with off=0 as non-NULL */
> > +SEC("tp_btf/bpf_testmod_test_raw_tp_null")
> > +__failure
> > +__msg("3: (07) r2 += 8                       ; R2_w=trusted_ptr_or_null_sk_buff(id=1,off=8)")
> > +__msg("4: (15) if r2 == 0x0 goto pc+2        ; R2_w=trusted_ptr_or_null_sk_buff(id=2,off=8)")
> > +__msg("5: (bf) r1 = r1                       ; R1_w=trusted_ptr_sk_buff()")
>
> This looks like a bug.
> 'r1 != 0' does not follow from 'r2 == r1 + 8 and r2 != 0'.
>

Hmm, yes, it's broken.
I am realizing where we do it now will walk r1 first and we'll not see
r2 off != 0 until after we mark it already.
I guess we need to do the check sooner outside this function in
mark_ptr_or_null_regs.
There we have the register being operated on, so if off != 0 we don't
walk all regs in state.

Do you think that should fix this?

> > +int BPF_PROG(test_raw_tp_null_copy_check_with_off, struct sk_buff *skb)
> > +{
> > +     asm volatile (
> > +             "r1 = *(u64 *)(r1 +0);                  \
> > +              r2 = r1;                               \
> > +              r3 = 0;                                \
> > +              r2 += 8;                               \
> > +              if r2 == 0 goto jmp2;                  \
> > +              r1 = r1;                               \
> > +              *(u64 *)(r3 +0) = r3;                  \
> > +              jmp2:                                  "
> > +             ::
> > +             : __clobber_all
> > +     );
> > +     return 0;
> > +}
>
> [...]

