Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3712C7732
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 02:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgK2BfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 20:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgK2BfE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Nov 2020 20:35:04 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05BBC0613D1;
        Sat, 28 Nov 2020 17:34:23 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o4so5159435pgj.0;
        Sat, 28 Nov 2020 17:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ttPLTTBmL5lyt/l4F7Vja8rn7hRJ/Lh3KZZj4jbsdgY=;
        b=sAwdjeNG4hcfAJrp413kmjgI8Rt76cPs3INtJpK0zZCtpybZCkD0FhkOgg+1KwsL5k
         MiMvFDbEmhtGeWaQ8F/wVpXWXxGo44M3RVLNOSwFlz5bAfEZc+7J5BFgSYFiflHy0dbs
         DYcrCG2GxGRIKLBP7J2EWOrWKkUySvY7J9ZOq0yti5WQ0x9G/Ijfv3998SVEaijYq3Lq
         dOqiBkwfn0R5FxAmkg/Fl3XeDsFybHwsuOh+bCPRIdFfu4TpZxammYt0xIzQUIDsmDV9
         NGZwGUeySuDavIxZGTyM39gGjaiwQCAhYkk5rpvDRNLOzZB/Dki+blCy8FqM9IgeWrpi
         VVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ttPLTTBmL5lyt/l4F7Vja8rn7hRJ/Lh3KZZj4jbsdgY=;
        b=N1S73g2QMxrY+AWQmONQKwHdNJHP05pbVoaNKuOuGEAVx2osg1Ghe7LIqkZhe3R9wq
         YeCTwLrvLNVXGl/Z7ZXud2wcLP1cOyWJscfblahOFAdggGMJpk3Ue436WrwJsYUIiwrJ
         sw9D26rN9PpaQrQR5Uj4AggNpxivft+vuectWzPME0cm39LycgkuULxv7QAaLSkTnesz
         IvXdzxGJai81heZLOZDWlQZn4WSrKaY2/dvGbcPn7TnmjJqlgws9iHkvuQE5pd/0/phr
         3yicG6ML1kYO230WoM6A7NIV3YwpzU4iXFxtFhKO7ci1krsl48cofFqdpgZ1B0V1MH0y
         2/tQ==
X-Gm-Message-State: AOAM532/ri0lT+Wz2474MHtJYkSlvzx2GajKpRyIutxODtdqV8jtn89G
        yJz6XrOTVMKgrfYq8sOpLQxMFXBIgFE=
X-Google-Smtp-Source: ABdhPJwrwmpJwwCGAf6otrQrfT2/lYlHi6s1W0xCb7eKLAxDP1ZbPAXX/JVBKv1GF4w1EGpqnjcUbw==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr18354892pja.132.1606613663274;
        Sat, 28 Nov 2020 17:34:23 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5925])
        by smtp.gmail.com with ESMTPSA id h11sm12020174pfn.27.2020.11.28.17.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 17:34:22 -0800 (PST)
Date:   Sat, 28 Nov 2020 17:34:20 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 10/13] bpf: Add instructions for
 atomic[64]_[fetch_]sub
Message-ID: <20201129013420.yi7ehnseawm5hsb7@ast-mbp>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-11-jackmanb@google.com>
 <0fd52966-24b2-c50c-4f23-93428d8993c4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd52966-24b2-c50c-4f23-93428d8993c4@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 09:35:07PM -0800, Yonghong Song wrote:
> 
> 
> On 11/27/20 9:57 AM, Brendan Jackman wrote:
> > Including only interpreter and x86 JIT support.
> > 
> > x86 doesn't provide an atomic exchange-and-subtract instruction that
> > could be used for BPF_SUB | BPF_FETCH, however we can just emit a NEG
> > followed by an XADD to get the same effect.
> > 
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >   arch/x86/net/bpf_jit_comp.c  | 16 ++++++++++++++--
> >   include/linux/filter.h       | 20 ++++++++++++++++++++
> >   kernel/bpf/core.c            |  1 +
> >   kernel/bpf/disasm.c          | 16 ++++++++++++----
> >   kernel/bpf/verifier.c        |  2 ++
> >   tools/include/linux/filter.h | 20 ++++++++++++++++++++
> >   6 files changed, 69 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 7431b2937157..a8a9fab13fcf 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -823,6 +823,7 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
> >   	/* emit opcode */
> >   	switch (atomic_op) {
> > +	case BPF_SUB:
> >   	case BPF_ADD:
> >   		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
> >   		EMIT1(simple_alu_opcodes[atomic_op]);
> > @@ -1306,8 +1307,19 @@ st:			if (is_imm8(insn->off))
> >   		case BPF_STX | BPF_ATOMIC | BPF_W:
> >   		case BPF_STX | BPF_ATOMIC | BPF_DW:
> > -			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
> > -					  insn->off, BPF_SIZE(insn->code));
> > +			if (insn->imm == (BPF_SUB | BPF_FETCH)) {
> > +				/*
> > +				 * x86 doesn't have an XSUB insn, so we negate
> > +				 * and XADD instead.
> > +				 */
> > +				emit_neg(&prog, src_reg, BPF_SIZE(insn->code) == BPF_DW);
> > +				err = emit_atomic(&prog, BPF_ADD | BPF_FETCH,
> > +						  dst_reg, src_reg, insn->off,
> > +						  BPF_SIZE(insn->code));
> > +			} else {
> > +				err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
> > +						  insn->off, BPF_SIZE(insn->code));
> > +			}
> >   			if (err)
> >   				return err;
> >   			break;
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 6186280715ed..a20a3a536bf5 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -280,6 +280,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
> >   		.off   = OFF,					\
> >   		.imm   = BPF_ADD | BPF_FETCH })
> > +/* Atomic memory sub, *(uint *)(dst_reg + off16) -= src_reg */
> > +
> > +#define BPF_ATOMIC_SUB(SIZE, DST, SRC, OFF)			\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = BPF_SUB })
> 
> Currently, llvm does not support XSUB, should we support it in llvm?
> At source code, as implemented in JIT, user can just do a negate
> followed by xadd.

I forgot we have BPF_NEG insn :)
Indeed it's probably easier to handle atomic_fetch_sub() builtin
completely on llvm side. It can generate bpf_neg followed by atomic_fetch_add.
No need to burden verifier, interpreter and JITs with it.
