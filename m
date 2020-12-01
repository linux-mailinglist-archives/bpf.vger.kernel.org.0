Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422BD2CA262
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 13:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgLAMNg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 07:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLAMNf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 07:13:35 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83749C0613CF
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 04:12:55 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so4490902wmb.2
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q9xNYsurg8tUrmhS/POPnYw5rzjzbx9PM3GUTI+w9RM=;
        b=A8U2XECwZEW1vywh9Omw2nN0K3L+9mRqoZDyxs8yCspWtZiE2SGBa+o8w7JNjDpedv
         gYZI55pGokZUDbRz691sp4t6Bz05YW6aZFVZwbgV4567mSh6f7NdmoUjxskCNMyYhX7T
         oGCjPHSHW7hr7w7vZZ9iWiXwS+mVGwQ2RenJal+lMnjLZ1tkMVmXXroDqueE/5mIj7uh
         QR1IlI0C7Na1/JZufeggsC4Taa/NucaPZZkwQtDvPIra2iKXOu908CJgi3pHTUzdarWu
         BB9s6/N0DRhKQziCzguwXC+I9sZthITt0qyBe+LoE9ZAuxjXN9wKWwKgwl5BHgw3E245
         6LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9xNYsurg8tUrmhS/POPnYw5rzjzbx9PM3GUTI+w9RM=;
        b=o1JcvHE8pERnD2/2X56IXzApykA/TiU4O4EKOP8XbmbrqMbJ0BamvR0XSjyBXB3UtJ
         SLTMevCdoZwoopoRRsGkPCQoj6b+E58wwPh4Haj5iDX1eRXqqjHx/spaeliIx9EL4/R1
         F/faZ4w0/QzzGtVGYjQzgACwjYG+nhRjzc7063tczO6RE7qFJU+/ancUN9Qh/zhqF+Jl
         zNwtND95zEId9jVxn6TzdJk0Eu/OB7NjM2Xek2t9sslvmP+d6JKriWiaj2e4ic7bwW5N
         7ZgG0duXQPjP65JefVrRpLvTAgZNr/rAw8Z/i194/KI3tAdufE53Eb+fUonygQZNgJzT
         s/7g==
X-Gm-Message-State: AOAM530bHs1g6tvzM52t3emIxwlTB4DejWekTV2AMU/AIQpV3e27NFu8
        BOm9n0nvgIQ8uAH3ot8zLbX50Q==
X-Google-Smtp-Source: ABdhPJxtKGABUeXKrRLMAivuvzIHHbr5Cr6HFHg7ffYCvHZFK0dOxYUSjGr6F9C88rGR+UY95V4PtA==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr2400163wmj.11.1606824774025;
        Tue, 01 Dec 2020 04:12:54 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id z21sm2461850wmk.20.2020.12.01.04.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:12:53 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:12:49 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: x86: Factor out emission of REX
 byte
Message-ID: <20201201121249.GA2114905@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-3-jackmanb@google.com>
 <20201129011405.vai66tyexpphpacb@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129011405.vai66tyexpphpacb@ast-mbp>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 28, 2020 at 05:14:05PM -0800, Alexei Starovoitov wrote:
> On Fri, Nov 27, 2020 at 05:57:27PM +0000, Brendan Jackman wrote:
> > The JIT case for encoding atomic ops is about to get more
> > complicated. In order to make the review & resulting code easier,
> > let's factor out some shared helpers.
> > 
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
> >  1 file changed, 23 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 94b17bd30e00..a839c1a54276 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -702,6 +702,21 @@ static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
> >  	*pprog = prog;
> >  }
> >  
> > +/*
> > + * Emit a REX byte if it will be necessary to address these registers
> 
> What is "REX byte" ?
> May be rename it to maybe_emit_mod() ?

Er, this is the REX prefix as described in
https://wiki.osdev.org/X86-64_Instruction_Encoding#REX_prefix

Would maybe_emit_mod be accurate? In my mind "mod" is a field in the
ModR/M byte which comes _after_ the opcode. Before developing this
patchset I knew almost nothing about x86, so maybe I'm missing something
about the general terminology?

> > + */
> > +static void maybe_emit_rex(u8 **pprog, u32 reg_rm, u32 reg_reg, bool wide)
> 
> could you please keep original names as dst_reg/src_reg instead of reg_rm/reg_reg ?
> reg_reg reads really odd and reg_rm is equally puzzling unless the reader studied
> intel's manual. I didn't. All these new abbreviations are challenging for me.

OK. I originally changed it to use the x86 names because in theory you
could do:

  maybe_emit_rex(&prog, src_reg, dst_reg);

so the names would look backwards when you jump into the function
implementation.

> > +{
> > +	u8 *prog = *pprog;
> > +	int cnt = 0;
> > +
> > +	if (wide)
> 
> what is 'wide' ? Why not to call it 'bool is_alu64' ?

Ack - there's precedent in the file for 'is64' so I'll go with that.
