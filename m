Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA22C2388
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 12:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbgKXLCQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 06:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732447AbgKXLCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 06:02:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66800C0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 03:02:15 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so21920773wrt.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 03:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Euc5EwjSVk1SHf+cwCR/hIXZVX6QyG47jC4qIwR40bA=;
        b=Mn6HIggmYx9Pm8+V89VnKtm03RWPIqKE+7kdfThJ1w0GR0UN07XVEvVcik4Y6lUsO+
         lbBNO/iqHC8Etj2vXfUD++3G64gTDQapkClnhCqhZBpFBhHWzlAGuQykt5xacI22hIA2
         qVTrDoXHx2Drru9TZTNZGO5Ic0bxNzO0HQLleNKGtyXBX1DIduQR0QADRa7eY4ZvJGha
         n8XiMxVZaMiM7l3Qa5Xyb30mV5AsWonFcqH98Ri184RyE5EcRogeo5LAPZJ5iiftgku+
         WtGaVpxUkpAgX4BjSylmd0vHsd1qj3Ec6nRlZr06oNDIc7+5Jx9Uhgok/Ms9s0m4Z58L
         cD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Euc5EwjSVk1SHf+cwCR/hIXZVX6QyG47jC4qIwR40bA=;
        b=gLIHy81T3eXRAzzegGH0M8Rprux0T6Jbhjj+gpnI5chIEE0rL39EUJlo+sWTyY3o2p
         yl4ZzxeBa8PrpNsE2RfjLoIS+fZZZRbBGBn/Vu/vFuXiWX5LQ06GtEn4GeucIgpVnMjQ
         y+dWaxDsg+91xGfwkv8/v+Ues08pVZwGXT2RgZgVBuHuUq02f/8ZrdXtdug1Xihn1WwD
         xRRGwuA5rbvGWkn90cT1+5A1OFTG7Mw8GtAhGyoBAoZGvPuMEvI1G6xmF4pvKa+qkmTW
         kvx+R7OQzJ/r9lbo0UIdJEGGZmbZiwUK/22bpA0Wk3qryFa4ajdCn+UJobbacqrSgD0x
         qpGg==
X-Gm-Message-State: AOAM530BGCCklOL+pxhedrcOuAuPTntpcWqncmFZ7Vl4B3T5LMrNZZnm
        O9G7eEkzRlsUvUeVwiSlojCn/A==
X-Google-Smtp-Source: ABdhPJw+cIknCde/CK/8kdCDoehje8y0AwA5nVzNQxTiTuzQ0kItEFvEhlolva0WR27uVU+bT3xa5g==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr4673881wro.363.1606215734015;
        Tue, 24 Nov 2020 03:02:14 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id b145sm5185939wmd.0.2020.11.24.03.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:02:13 -0800 (PST)
Date:   Tue, 24 Nov 2020 11:02:09 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 3/7] bpf: Rename BPF_XADD and prepare to encode other
 atomics in .imm
Message-ID: <20201124110209.GC1883487@google.com>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-4-jackmanb@google.com>
 <e7d336ab-524f-9d60-e9ec-8c8426cae0d7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d336ab-524f-9d60-e9ec-8c8426cae0d7@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 03:54:38PM -0800, Yonghong Song wrote:
> 
> 
> On 11/23/20 9:31 AM, Brendan Jackman wrote:
...
> > diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> > index 0207b6ea6e8a..897634d0a67c 100644
> > --- a/arch/arm/net/bpf_jit_32.c
> > +++ b/arch/arm/net/bpf_jit_32.c
> > @@ -1620,10 +1620,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
> >   		}
> >   		emit_str_r(dst_lo, tmp2, off, ctx, BPF_SIZE(code));
> >   		break;
> > -	/* STX XADD: lock *(u32 *)(dst + off) += src */
> > -	case BPF_STX | BPF_XADD | BPF_W:
> > -	/* STX XADD: lock *(u64 *)(dst + off) += src */
> > -	case BPF_STX | BPF_XADD | BPF_DW:
> > +	/* Atomic ops */
> > +	case BPF_STX | BPF_ATOMIC | BPF_W:
> > +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> >   		goto notyet;
> >   	/* STX: *(size *)(dst + off) = src */
> >   	case BPF_STX | BPF_MEM | BPF_W:
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index ef9f1d5e989d..f7b194878a99 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -875,10 +875,18 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
> >   		}
> >   		break;
> > -	/* STX XADD: lock *(u32 *)(dst + off) += src */
> > -	case BPF_STX | BPF_XADD | BPF_W:
> > -	/* STX XADD: lock *(u64 *)(dst + off) += src */
> > -	case BPF_STX | BPF_XADD | BPF_DW:
> > +	case BPF_STX | BPF_ATOMIC | BPF_W:
> > +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> > +		if (insn->imm != BPF_ADD) {
> 
> Currently BPF_ADD (although it is 0) is encoded at bit 4-7 of imm.
> Do you think we should encode it in 0-3 to make such a comparision
> and subsequent insn->imm = BPF_ADD making more sense?

Sorry not quite sure what you mean by this... I think encoding in 4-7 is
nice because it lets us use BPF_OP. In this patchset wherever we have
(insn->imm == BPF_ADD) meaning "this is a traditional XADD without
fetch" and (BPF_OP(insn->imm) == BPF_ADD) meaning "this is an atomic
add, either with or without a fetch". 

Does that answer the question...?

> > diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> > index 0a721f6e8676..0767d7b579e9 100644
> > --- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> > +++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> > @@ -3109,13 +3109,19 @@ mem_xadd(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, bool is64)
> >   	return 0;
> >   }
> > -static int mem_xadd4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> > +static int mem_atm4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> >   {
> > +	if (meta->insn.off != BPF_ADD)
> > +		return -EOPNOTSUPP;
> 
> meta->insn.imm?
> 
> > +
> >   	return mem_xadd(nfp_prog, meta, false);
> >   }
> > -static int mem_xadd8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> > +static int mem_atm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> >   {
> > +	if (meta->insn.off != BPF_ADD)
> 
> meta->insn.imm?

Yikes, thanks for spotting these! Apparently I wasn't even compiling
this code.
