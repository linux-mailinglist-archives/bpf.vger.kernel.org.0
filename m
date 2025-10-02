Return-Path: <bpf+bounces-70186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F325BB2CA7
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 10:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235041C7AE5
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C62D239B;
	Thu,  2 Oct 2025 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2onl3SG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFF277003
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392763; cv=none; b=OnO9maL4jt19L7SIIS8WkJydDTI9Tv/TvjBS3g22zKu+2OkpNX38BJfMqkTQCHgKDWSPMqic1AOUv55+Mq0kSkH0NL5/vnbS/wI4GQYUxOH3EdTMOtD6wEnHSzIx8LxWSs4zdA57U5WAtyiLduTd0KqHRbbKucYulPI2WijqzTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392763; c=relaxed/simple;
	bh=RNhms0z7l5+MEaFJFk/yjDJmePyNscJ/euEIKLtlEQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkiwrek59bQrmKPGc2ugw0Axq9PogRkptE0B1r7hvtyzx4d01/xvCWHEki4Z8OhsXpSxLw5WDc6a/yx/zAVHEO6WKENZvy4PU+AHwpEr3IFyugfaFk4oM3wu/wgVCpgvtB4zSEw6Y5G0imGvmMGYyaaVzi0UGAkgQpsb4EMFL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2onl3SG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3fa528f127fso483216f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759392760; x=1759997560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Vs8mHKOO8sRV2/Jm+CYIgifOv40NmK0RboN7qu9q/M=;
        b=J2onl3SGtFYkn5Bog3/V/MNXOF5uLLoeIhpqwFYvwOXY31/t0yzd9E+tZJu/FHbYpp
         iNDQ1IBlXOOYnCiRIbFMmvFuSNYzY578+YdNb+jaHUMEvTZWR/JVof9OUow1cf8+qDkR
         obr9WXYJ2AJo1TUTwEexPV26LF3wG45cNF3aYRZI31BkA/3CCXzOpg0jeWZ3Vtkakemj
         WT6vwMXwA+yCZsZB4AIwug2LoWBcBZoLGsA0k+fmKGtaQGBnUJnEn7tphKXl7AL2mpAS
         TO+F3FbGG41FE6NBY1H0EoV2/VCDl7MU4oDdw++RmgTQB9CZK2aSAYpP0t5+MtIZQaD9
         BRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759392760; x=1759997560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vs8mHKOO8sRV2/Jm+CYIgifOv40NmK0RboN7qu9q/M=;
        b=DHr1t+o2BtoPjEUbkQHIWwX3D+TpkPidBYilGLxhRZGDBB4Cyg3tAv2cJ9ZL1TQdAE
         eb0GlDJ83Un0VRECX7PjGHVZ+R4oEzSfJVSl6G29CW73pxTQZe024T0YMePTV58HhCPV
         Sbmz5VaXt/krgktaIWGDtmkOqZP8kFCYbIMMCeuwG+3PAExrLoJdhFfj1oB6c/6ff2L2
         Sh7Ta6iRKMwhWLM88rHOvJHtf3/KXbSo40SvYEg1p5dGFiiD0bWNfpfZXcGzrT+otemq
         LEddHDULL2XFe6dqJApQDZvq27o2T+m3kyp7Q3uFwvjlIVi8+rItGoGvNkRxomtgipmJ
         Yk4w==
X-Forwarded-Encrypted: i=1; AJvYcCXH/XG/K0Eh4gCoVnPz8mEZHuVDiPQrv7CifDVicZ9E+gnUAKurLUQakcU84WHcFzjL13k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFt7wbUPdMA1aJ4XB2ogFlgIuSctDEL5h1ABtHGtR49T5QXxod
	KktSUwzZsgbBnPSHDmgWM+JZ8ANwwE7gHvZmjMvNJeY8LCaQEox3iXeB
X-Gm-Gg: ASbGnctpkQb2ntHbFJuBnYmD4OR/7G6jieom8NoCqvlZZWOziH262+RI0/Ot5j1Ch6+
	u7Ynw8mRIRowMlAASNoi+6pYFggdCJIBIrv94tXaU13Nmq0bu/iYDCEIsJ8p75rTJxfPkUYi3TH
	s8hibjKWDuqDC6x1X6WUB0v+BYtE5sgDS6U0+wXinJuZei/oH2Trkd2cpRDIkZL413n1oApy6lk
	TCyr4cDPw+ofLrpL1Nf8faDWIOsxhCeOyLsjeGWq3ZjL0TQU9r1w976KJqhepMzyITrlau9eaJx
	LJk4WyBdma0ukb2Jbg13cYx+cBxniaHwgXiOkehMxs+paFUYG7uTqA9qJpz/Y7iOL0mDVCVrs7x
	ng3uv0akbutd79U1ulZdmsTJu5DmOjnhukn60kANEEtnrd7sR9iZALHZ9wCVf3pbGW7U=
X-Google-Smtp-Source: AGHT+IHV8IBi0OpfZzc8d17Y77kqT34SIbEnp+NKiEpVgwVmKxT/TOnn0M9ipGjQS+r/r2ZtBBQymA==
X-Received: by 2002:a05:6000:428a:b0:410:f600:c35e with SMTP id ffacd0b85a97d-4255d299f1cmr1492563f8f.8.1759392760226;
        Thu, 02 Oct 2025 01:12:40 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f50b2sm2483655f8f.56.2025.10.02.01.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:12:39 -0700 (PDT)
Date: Thu, 2 Oct 2025 08:19:01 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 09/15] bpf: make bpf_insn_successors to
 return a pointer
Message-ID: <aN41dbxNPIUrKzNz@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-10-a.s.protopopov@gmail.com>
 <eddce884140f3df9e6c3c7e1b873a570b163ce1d.camel@gmail.com>
 <CAADnVQ+K9hYhwxLO3+2xAcm04=SeyCQuYZtHmKMkmkKTUDQG4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+K9hYhwxLO3+2xAcm04=SeyCQuYZtHmKMkmkKTUDQG4Q@mail.gmail.com>

On 25/10/01 04:49PM, Alexei Starovoitov wrote:
> On Wed, Oct 1, 2025 at 3:39 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> > > The bpf_insn_successors() function is used to return successors
> > > to a BPF instruction. So far, an instruction could have 0, 1 or 2
> > > successors. Prepare the verifier code to introduction of instructions
> > > with more than 2 successors (namely, indirect jumps).
> > >
> > > To do this, introduce a new struct, struct bpf_iarray, containing
> > > an array of bpf instruction indexes and make bpf_insn_successors
> > > to return a pointer of that type. The storage for all instructions
> > > is allocated in the env->succ, which holds an array of size 2,
> > > to be used for all instructions.
> > >
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > (but please fix the IS_ERR things, see below).
> >
> > [...]
> >
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -509,6 +509,15 @@ struct bpf_map_ptr_state {
> > >  #define BPF_ALU_SANITIZE             (BPF_ALU_SANITIZE_SRC | \
> > >                                        BPF_ALU_SANITIZE_DST)
> > >
> > > +/*
> > > + * An array of BPF instructions.
> > > + * Primary usage: return value of bpf_insn_successors.
> > > + */
> > > +struct bpf_iarray {
> > > +     int off_cnt;
> > > +     u32 off[];
> > > +};
> > > +
> >
> > Tbh, the names `off` and `off_cnt` are a bit strange in context of
> > instruction successors.
> >
> > [...]
> >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 705535711d10..6c742d2f4c04 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -17770,6 +17770,22 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
> > >       return 0;
> > >  }
> > >
> > > +static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
> > > +{
> > > +     size_t new_size = sizeof(struct bpf_iarray) + n_elem * 4;
> >
> > Nit: n_elem * 4 -> n_elem * sizeof(*old->off) ?
> >
> > > +     struct bpf_iarray *new;
> > > +
> > > +     new = kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
> > > +     if (!new) {
> > > +             /* this is what callers always want, so simplify the call site */
> > > +             kvfree(old);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     new->off_cnt = n_elem;
> > > +     return new;
> > > +}
> >
> > [...]
> >
> > > @@ -24325,14 +24342,18 @@ static int compute_live_registers(struct bpf_verifier_env *env)
> > >               for (i = 0; i < env->cfg.cur_postorder; ++i) {
> > >                       int insn_idx = env->cfg.insn_postorder[i];
> > >                       struct insn_live_regs *live = &state[insn_idx];
> > > -                     int succ_num;
> > > -                     u32 succ[2];
> > > +                     struct bpf_iarray *succ;
> > >                       u16 new_out = 0;
> > >                       u16 new_in = 0;
> > >
> > > -                     succ_num = bpf_insn_successors(env->prog, insn_idx, succ);
> > > -                     for (int s = 0; s < succ_num; ++s)
> > > -                             new_out |= state[succ[s]].in;
> > > +                     succ = bpf_insn_successors(env, insn_idx);
> > > +                     if (IS_ERR(succ)) {
> >
> > This error check is no longer necessary.
> 
> Speaking of IS_ERR checks...
> https://github.com/kernel-patches/bpf/pull/9895#issuecomment-3352016682
> 
> AI for-the-win!

Nice! Won't be surprised if it was trained just based on Eduard's reviews :)

(Actually, are there any details anywhere about this AI?)

