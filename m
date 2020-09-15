Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2110126A6F2
	for <lists+bpf@lfdr.de>; Tue, 15 Sep 2020 16:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgIOOUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgIOOTe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 10:19:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FBAC061354
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 06:53:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so3542634wmj.5
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mpt5/mY5yPLcWPN5dAxKWZ1iKOvnWN/naNw5pxswiPQ=;
        b=pWfAOQepoqKVe8FVv3PSRnE2yNbCHL5v9IqR0LbagyAtChnGvMpbyFpYy+ah7a+MDp
         VHUKM4CuzkFAiSoTN8zgTwkV2aT3nxZP2r7v/FxeCqfIP5gfpAe3HZlsnuuGZ9ccjvYm
         S1AH7wlrJhWUXEGlA4ipsYAl+ChToZ9akzjOnAQ8MMRU8odgwXVqgE37YELU22uOWKgn
         3mAKu2tw8898QfUe05BFKktyMTRrAoo+3ySa3XY0iN33XUiOL7EFVniVk43BB6B7R48Q
         uVfXKufART+6oiSDUqycqChiI70DAA7zh61WEJ+0JYLEv9ZnvNfbLHoOFVh4eNbifNUu
         QVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mpt5/mY5yPLcWPN5dAxKWZ1iKOvnWN/naNw5pxswiPQ=;
        b=K657lF4bdvTxWaJtEo1SA/jHwydinGEXc40GEecf4m9wM68dNYgpfe2GRn4c8rUWgf
         B8OO7lVnH6cHlHm/Bx6R6HpVTii4hOP+k0CAIzwakGsVKZIOI4tYVhAX4liQn7q1bn2E
         6l43iEC0Fk5X4yWGFQURd7g9Ag4U1WAUstxXXfQft2GvqdmbiFDyO1g42Yx3EvYz3ApY
         +EPjE0BJMjzStQ/xu6DifQzlX+5M5mMEnolW+CTMT5KlKTcuyYkAETwC3k+D9f+8TsCu
         St2Qopk1yzZLLf+cW3sOv8GDtfX0yXfv+rIe7y+qSMzyN4/7vITqUMOPKIcVKk/AFmnn
         gzug==
X-Gm-Message-State: AOAM5320uHVjRDABV+TbZCYVsSddLERcDw2Gr7A76qU222vwnnaTCtzk
        DPNJoD9Uum9JBOiE2LVw3g+hsw==
X-Google-Smtp-Source: ABdhPJzm5SHWJFNWCUa7kV3RRw1MZ+vh7bUDJxal2VMBlb8NwYHz0xngZah25PvZFFKwKcpd4oT0Kw==
X-Received: by 2002:a1c:2bc7:: with SMTP id r190mr4993218wmr.116.1600178027842;
        Tue, 15 Sep 2020 06:53:47 -0700 (PDT)
Received: from apalos.home (athedsl-246545.home.otenet.gr. [85.73.10.175])
        by smtp.gmail.com with ESMTPSA id a10sm23545590wmj.38.2020.09.15.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:53:47 -0700 (PDT)
Date:   Tue, 15 Sep 2020 16:53:44 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     bpf@vger.kernel.org, ardb@kernel.org, naresh.kamboju@linaro.org,
        Jiri Olsa <jolsa@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: bpf: Fix branch offset in JIT
Message-ID: <20200915135344.GA113966@apalos.home>
References: <20200914160355.19179-1-ilias.apalodimas@linaro.org>
 <20200915131102.GA26439@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915131102.GA26439@willie-the-truck>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 02:11:03PM +0100, Will Deacon wrote:
> Hi Ilias,
> 
> On Mon, Sep 14, 2020 at 07:03:55PM +0300, Ilias Apalodimas wrote:
> > Running the eBPF test_verifier leads to random errors looking like this:
> > 
> > [ 6525.735488] Unexpected kernel BRK exception at EL1
> > [ 6525.735502] Internal error: ptrace BRK handler: f2000100 [#1] SMP
> 
> Does this happen because we poison the BPF memory with BRK instructions?
> Maybe we should look at using a special immediate so we can detect this,
> rather than end up in the ptrace handler.

As discussed offline this is what aarch64_insn_gen_branch_imm() will return for
offsets > 128M and yes replacing the handler with a more suitable message would 
be good.

> 
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index f8912e45be7a..0974effff58c 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -143,9 +143,13 @@ static inline void emit_addr_mov_i64(const int reg, const u64 val,
> >  	}
> >  }
> >  
> > -static inline int bpf2a64_offset(int bpf_to, int bpf_from,
> > +static inline int bpf2a64_offset(int bpf_insn, int off,
> >  				 const struct jit_ctx *ctx)
> >  {
> > +	/* arm64 offset is relative to the branch instruction */
> > +	int bpf_from = bpf_insn + 1;
> > +	/* BPF JMP offset is relative to the next instruction */
> > +	int bpf_to = bpf_insn + off + 1;
> >  	int to = ctx->offset[bpf_to];
> >  	/* -1 to account for the Branch instruction */
> >  	int from = ctx->offset[bpf_from] - 1;
> 
> I think this is a bit confusing with all the variables. How about just
> doing:
> 
> 	/* BPF JMP offset is relative to the next BPF instruction */
> 	bpf_insn++;
> 
> 	/*
> 	 * Whereas arm64 branch instructions encode the offset from the
> 	 * branch itself, so we must subtract 1 from the instruction offset.
> 	 */
> 	return ctx->offset[bpf_insn + off] - ctx->offset[bpf_insn] - 1;
> 

Sure

> > @@ -642,7 +646,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
> >  
> >  	/* JUMP off */
> >  	case BPF_JMP | BPF_JA:
> > -		jmp_offset = bpf2a64_offset(i + off, i, ctx);
> > +		jmp_offset = bpf2a64_offset(i, off, ctx);
> >  		check_imm26(jmp_offset);
> >  		emit(A64_B(jmp_offset), ctx);
> >  		break;
> > @@ -669,7 +673,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
> >  	case BPF_JMP32 | BPF_JSLE | BPF_X:
> >  		emit(A64_CMP(is64, dst, src), ctx);
> >  emit_cond_jmp:
> > -		jmp_offset = bpf2a64_offset(i + off, i, ctx);
> > +		jmp_offset = bpf2a64_offset(i, off, ctx);
> >  		check_imm19(jmp_offset);
> >  		switch (BPF_OP(code)) {
> >  		case BPF_JEQ:
> > @@ -912,18 +916,26 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
> >  		const struct bpf_insn *insn = &prog->insnsi[i];
> >  		int ret;
> >  
> > +		/*
> > +		 * offset[0] offset of the end of prologue, start of the
> > +		 * first insn.
> > +		 * offset[x] - offset of the end of x insn.
> 
> So does offset[1] point at the last arm64 instruction for the first BPF
> instruction, or does it point to the first arm64 instruction for the second
> BPF instruction?
> 

Right this isn't exactly a good comment. 
I'll change it to something like:

offset[0] - offset of the end of prologue, start of the 1st insn.
offset[1] - offset of the end of 1st insn.

> > +		 */
> > +		if (ctx->image == NULL)
> > +			ctx->offset[i] = ctx->idx;
> > +
> >  		ret = build_insn(insn, ctx, extra_pass);
> >  		if (ret > 0) {
> >  			i++;
> >  			if (ctx->image == NULL)
> > -				ctx->offset[i] = ctx->idx;
> > +				ctx->offset[i] = ctx->offset[i - 1];
> 
> Does it matter that we set the offset for both halves of a 16-byte BPF
> instruction? I think that's a change in behaviour here.

Yes it is, but from reading around that's what I understood.
for 16-byte eBPF instructions both should point to the start of 
the corresponding jited arm64 instruction.
If I am horribly wrong about this, please shout.

> 
> >  			continue;
> >  		}
> > -		if (ctx->image == NULL)
> > -			ctx->offset[i] = ctx->idx;
> >  		if (ret)
> >  			return ret;
> >  	}
> > +	if (ctx->image == NULL)
> > +		ctx->offset[i] = ctx->idx;
> 
> I think it would be cleared to set ctx->offset[0] before the for loop (with
> a comment about what it is) and then change the for loop to iterate from 1
> all the way to prog->len.
> 

Sure

> Will

Thanks
/Ilias
