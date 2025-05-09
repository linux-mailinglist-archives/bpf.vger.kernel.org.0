Return-Path: <bpf+bounces-57921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4178FAB1DA5
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EE71B60400
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828725DD02;
	Fri,  9 May 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dguMgswd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165F1DE4D8
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820945; cv=none; b=jEPbUOF9oW9goMk+RllujRmy3jjLRW8IPyinSvbRWlMoVf4o+spNIAFNO+U+bTIKeAQJg2fPPaQfGH0yOPprKl7lOgYjgI7stnZ4KUB/44m8dPh7u31SrakE6m95IUeqJhu9oC5fXfREEEzOvrdiDs51bq+E+mfwughHxXoAEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820945; c=relaxed/simple;
	bh=0LshcjwmP4jPv2jvPYqFFSf2F7J0ovYBeI3gNRKd3Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuwLIs/VNfNrTPs6lx6o6wCXZTlqqZSpXD8LvpXvFn1r7dwJ3aZDuiwvKTMgb8p8DZcCD7AjqcbpR+3QZg4nPo8jrRPFz2NMW0R8TXxiY/kkaV6qW8EmL4V23TluIKTJpHxNLSaoGDzzzCgoRp9YLeHOTl0PgZXTNEPy5Qxaa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dguMgswd; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so462889766b.2
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820942; x=1747425742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AMORSS017AUu8+Fhj8zTUYZmtOFCl6e5o9PQ+qk7lmM=;
        b=dguMgswdT4nKTL0NaNoEV1xi1OMC6iPRGRXd9ssFzHy+7WxYkxR2x538KaTnTQuVc4
         5tqLr0OGM6/F95gQrC0A3quD5RlW0gbsPDC91vHWhtMSNha/I635dy/uW+8KgG1S7oyM
         MXQR3rwZZHFKdH6XaYeT5BvFrS7EAyILI5hn19ta3O9hGJfKAtlhDV5dcuoZ4Hd7EuOi
         BgV3DAr0XCEkEgd4g/q7FJvd2033jsHVox5SuzFq/KRFHUZ/JuAWDy4vKXysZkpqtjYv
         TXBmWPNFVG7at/caUhjfWWJ87NsF7PGy4pEysO+sOCL7lqemOTa6E/hN34B45rT6Nyqa
         6PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820942; x=1747425742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMORSS017AUu8+Fhj8zTUYZmtOFCl6e5o9PQ+qk7lmM=;
        b=h837q/RzqhitvVJUEvQQuNldA6GSER8PMCE1UJuFTqFhbHZZX/SOLYT2Dd87Ex4pwi
         o3NdSqpd5wxeUDHGSw42cwyfFN+Oq/1FV2fomjsJFQIQtKw3J1wwwUdLSJZqVAHHElx0
         YPd7iimeG5uEYynL5TLiwrsTXRX0ohOR6QSJHk6SRWIJErfv2vOYJTqdamANPrAOOXiw
         Pjsd63PhwhX7nkHgFf/FVulsYR6V6rAlNBcLK7HnxT9sSjTSKjB4dc7++QEucIpA/Eg2
         5ZxprmbtF0/Af6q+VWRXX2tBpHv8/brGAQZMKgiIcPEpHaIYVZOwS5d+PP17p7vKHQGv
         yOoQ==
X-Gm-Message-State: AOJu0Yx85Y6MrKF+WBiJ6srZSVKBfsPd6KtX0U+jlps6Zm3RrVuetIvb
	L5i9qOtDLrBigjxmZcxn1YOieTnTIAxeWhw09xGwt+GGdVl6lOl2lhMUo28aATnM2DjwCMfZMhS
	2ZBepwlk3eWUZXEwap6slgbRAifsUL1WiyLXLbw==
X-Gm-Gg: ASbGnctTimoDJwh3Wetk8anRGCFehXQHlC+/ndOvrwmi1jfMl1jpgdQr1j3Uq3Ed0dU
	+pJj6BTDBhAWbY0qXio5JNFYqSYPc64+ihxYYJRyN/Ipb8o95qs8fO+tj5o7SYIANDYabmGk6b8
	Bg6zBFWf89/bXJCf9isQRLOQu0pzAv+p+tdipzyT2UmxpUfQk0DG9mcghZt2Bkrx/o42WpRgFh3
	k24dw==
X-Google-Smtp-Source: AGHT+IEVYqdPBKUH9/WFIk1I/5ltX+JnEGOsls9qHaHcx3N2YVBsGlVQJycK21RjeIw0z4SqQhJLH/UKc6XP+dtFFGw=
X-Received: by 2002:a17:907:3d92:b0:ace:cf44:28c7 with SMTP id
 a640c23a62f3a-ad2192c5d15mr558642166b.57.1746820941424; Fri, 09 May 2025
 13:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-9-memxor@gmail.com>
 <a071c33a195642de5530f897880e44bc1416a86b.camel@gmail.com>
In-Reply-To: <a071c33a195642de5530f897880e44bc1416a86b.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 22:01:45 +0200
X-Gm-Features: AX0GCFuh4Fb9QGxM3s44qRUDsdeLC6gD8BQSHzEfKUmAHrptJlCwb9bKaDeesTY
Message-ID: <CAP01T74uq5Uyy6VHXyA_yVeO9rdU7svnQv90Z7auerApjbRfQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/11] bpf: Report arena faults to BPF stderr
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 21:28, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> > Begin reporting arena page faults and the faulting address to BPF
> > program's stderr, for now limited to x86, but arm64 support should
> > be easy to add.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> I think this needs a corresponding test case that would check
> backtrace structure and address in the message.

Makes sense, will do.

>
> >  arch/x86/net/bpf_jit_comp.c | 21 ++++++++++++++++++---
> >  include/linux/bpf.h         |  1 +
> >  kernel/bpf/arena.c          | 14 ++++++++++++++
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 17693ee6bb1a..dbb0feeec701 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1384,15 +1384,27 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
> >  }
> >
> >  #define DONT_CLEAR 1
> > +#define ARENA_FAULT (1 << 8)
> >
> >  bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
> >  {
> > -     u32 reg = x->fixup >> 8;
> > +     u32 arena_reg = (x->fixup >> 8) & 0xff;
> > +     bool is_arena = !!arena_reg;
> > +     u32 reg = x->fixup >> 16;
> > +     unsigned long addr;
> > +
> > +     /* Read here, if src_reg is dst_reg for load, we'll write 0 to it. */
> > +     if (is_arena)
> > +             addr = *(unsigned long *)((void *)regs + arena_reg);
>
> Is it necessary to also take offset into account when calculating address?
>

Not sure what you mean? "arena_reg" is basically the offset of the
register holding the arena address within pt_regs.

> >
> >       /* jump over faulting load and clear dest register */
> >       if (reg != DONT_CLEAR)
> >               *(unsigned long *)((void *)regs + reg) = 0;
> >       regs->ip += x->fixup & 0xff;
> > +
> > +     if (is_arena)
> > +             bpf_prog_report_arena_violation(reg == DONT_CLEAR, addr);
> > +
> >       return true;
> >  }
> >
> > @@ -2043,7 +2055,10 @@ st:                    if (is_imm8(insn->off))
> >                               ex->data = EX_TYPE_BPF;
> >
> >                               ex->fixup = (prog - start_of_ldx) |
> > -                                     ((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
> > +                                     ((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 16)
> > +                                     | ((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[src_reg] : reg2pt_regs[dst_reg])<< 8);
> > +                             /* Ensure src_reg offset fits in 1 byte. */
> > +                             BUILD_BUG_ON(sizeof(struct pt_regs) > U8_MAX);
>
> The ex->fixup field structure should be better documented, at the
> moment docstring does not say anything about registers being encoded
> within it. Also, maybe add a comment why `prog - start_of_ldx` is
> guaranteed to be small.

Ack, will add comments.

>
> >                       }
> >                       break;
> >
>
> [...]
>

