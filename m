Return-Path: <bpf+bounces-68596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7A2B7EACF
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B64E19C2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0921D3E2;
	Wed, 17 Sep 2025 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpZAAKcF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887AE21CC56
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071350; cv=none; b=AaqlfFT0oLuCf/rJXn3PedFJU7jO2Vfceqgq+5tA8jOngo8MdFZzT3LpCq0Tn15BUix4xKcoJLJ9oDcfwV3htq3v9OqWlj7XhOvWfcTzJyvjGYZmyaNGmku4NN6/rk5VFZq6etqNMa6wjr6APujfl8RCy7hpvDPZa+srYbi2MD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071350; c=relaxed/simple;
	bh=HEZXR3zxNPkHwSm3su/Vtm+Kg3shdJ+8SOTrLmLLygE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPfQFQ5R0gOap8uH1u9XCmnghnowE6nWJ88wzq50IzgWrz0N+4X1KN8wET8I/56rVpQb+OyAyqd7kHCey3YStUCHPOSiR3STfb+R/uI0NRz6UJyrmTt5UaSN9kSA80nRZAdAjmCIYkY44RhOv+4oApBfDgkQLWxbtGV//sNbBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpZAAKcF; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-62f5bfd0502so3178579a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 18:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071347; x=1758676147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dBBlDBVvcfdKcfRRvHSstY441vE8yB8itcKu2PkQc0o=;
        b=NpZAAKcFtUK5vwj6iSU6jIld38nAGHBC2cZKaQga+n40H3M7oFKoc/1lE55KtcE6VQ
         khMNqX1tx491MkW25ga/KXdfFTogKCmrfGf3YCydGneRNxyItGf4bPA6M/mXQ39RNhB5
         rgGQ3AhRtiowwhLkQsIsqrjNsrCv1OccliDDuGVS7jAHftVBkdVQsE9uKKQwMvuoAJ51
         xWwenDh1fPe02nSVv7zHajGMnu6LFCd8akfsbvCFk/HpcNqEwFd7Uopr0AfEyn9qHWmx
         MyFmOXvZs9ERQD50B6zzvlhER3aqaorfJn8+g65KPhbD6nx6tpsOEScSLzPC3qcCFgzG
         3jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071347; x=1758676147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBBlDBVvcfdKcfRRvHSstY441vE8yB8itcKu2PkQc0o=;
        b=SfIl/bjMEAlh+vycPXwk3UK9Gc/aVOX/fqw4GAHnfkI7b1/Z418TIkL5Dhd4DUCmIO
         c1XNJ0W9bf6SBqewq0RMEC2cF2kT2oMKo4rINlBSSAqFkzbVDF8/QVHTka9FunQ4WCWx
         Eioj7MoooEZlyDqSFNtblNgGZquKBxcOkDN/1LMB1NzGJIgzd9wVGznG/Tt+ffDeMdVc
         61xZpC6UpIBpSpRlXDmbjVplpUqjClPzLerhzoYh+3WpuicICN4ek1xdlTTSB1Xo5DgE
         TlZMdeVvw6nMsPbMKEmTalHrC/SH2CkI9WQ31Jvn5fQwWofRisIdTVyuLACYaf2UF+dZ
         T+7w==
X-Forwarded-Encrypted: i=1; AJvYcCVX9rbRVf7LBZ1LK8p8oVc9qwhuS1euqtuakMsHnlfR+V4vpOqCFxx8CWl3JgDa9os5p58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDuqJxxI4LtrVG9K07igVfApccWnHtBg9/9Zsvz17R47yK02f
	ezhnV+QFdQzzHJwCWwMmlaGLb37r7Z1tiseUD1XgN8lvxUvWKXfTz926hbO/rrKUcA+dZSFrP8v
	g3lMFVtXWNJkNC5A7LeCDrj2vpMqZTFI=
X-Gm-Gg: ASbGncvc5s2aENfyYT0mazndFuFvb6+odHO6U6EAjDB0SBVp3ESd542PTOzxttKbNyE
	8MeDO1jmXJv/OiBHIqRy/kZnNBGXSbAKRUM3yecqUGpUeh+3+ecBryYta+jOnq1DzuMSgwLJ6TM
	A1P2dLuhg0mNUKnSBoYaEF6YmWu+G34PRKrvjqZGLkIiRekRvSp9cQV/ZGWPX5ssbWx3drEi2YJ
	Pu5O7+vGw==
X-Google-Smtp-Source: AGHT+IHCssIdbo3+eryK2Z9oHM3H8cWiQXmx1o5lIVStQnFE3Dy4RLYcIqXSVZ5xyyO31m4HfNg2946vq4/8EmsuV9k=
X-Received: by 2002:a05:6402:2709:b0:62f:4f17:bc63 with SMTP id
 4fb4d7f45d1cf-62f83a0f068mr621072a12.2.1758071346772; Tue, 16 Sep 2025
 18:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915162848.54282-1-puranjay@kernel.org> <20250915162848.54282-2-puranjay@kernel.org>
 <ba84c72f4732b0fe180b2ba40cc66577c78c177b.camel@gmail.com>
In-Reply-To: <ba84c72f4732b0fe180b2ba40cc66577c78c177b.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 Sep 2025 03:08:30 +0200
X-Gm-Features: AS18NWDTIEO-cP2PGB9sNl8_jOy2fGlb2KHEY2wsMrNempx4clIBAjlmZyRCr9g
Message-ID: <CAP01T76TMF=x-pPE31+UCAP3c4Gx_C0b_pEWaqp9bUj-mdLTbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf, x86: Add support for signed arena loads
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 03:05, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Mon, 2025-09-15 at 16:28 +0000, Puranjay Mohan wrote:
>
> [...]
>
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index 008273a53e04..f2b85a10add2 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -3064,6 +3064,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
> >               if (!bpf_atomic_is_load_store(insn) &&
> >                   !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
> >                       return false;
> > +             break;
> > +     case BPF_LDX | BPF_MEMSX | BPF_B:
> > +     case BPF_LDX | BPF_MEMSX | BPF_H:
> > +     case BPF_LDX | BPF_MEMSX | BPF_W:
> > +             return false;
> >       }
> >       return true;
> >  }
>
> Is the same hunk necessary in riscv/net/bpf_jit_comp64.c?
>
> [...]
>
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 8d34a9400a5e..a6550da34268 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1152,11 +1152,38 @@ static void emit_ldx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 i
> >       *pprog = prog;
> >  }
> >
> > +static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
> > +{
> > +     u8 *prog = *pprog;
> > +
> > +     switch (size) {
> > +     case BPF_B:
> > +             /* movsx rax, byte ptr [rax + r12 + off] */
> > +             EMIT3(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x0F, 0xBE);
> > +             break;
> > +     case BPF_H:
> > +             /* movsx rax, word ptr [rax + r12 + off] */
> > +             EMIT3(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x0F, 0xBF);
> > +             break;
> > +     case BPF_W:
> > +             /* movsx rax, dword ptr [rax + r12 + off] */
> > +             EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x63);
> > +             break;
> > +     }
> > +     emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
> > +     *pprog = prog;
> > +}
> > +
>
> Encoding looks correct.
>
> [...]
>
> > @@ -2109,13 +2136,19 @@ st:                   if (is_imm8(insn->off))
> >               case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> >               case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> >               case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> > +             case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
> > +             case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
> > +             case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
> >               case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> >               case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
> >               case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
> >               case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
> >                       start_of_ldx = prog;
> >                       if (BPF_CLASS(insn->code) == BPF_LDX)
> > -                             emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
> > +                             if (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
> > +                                     emit_ldsx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
> > +                             else
> > +                                     emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
> >                       else
> >                               emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>
> Heh, apparently this is correct C code. Dangling else is associated
> with the closest 'if' statement. Didn't know that.

I was going to say; let's use braces instead of doing this.

>
>
> [...]

