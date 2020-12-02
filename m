Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE42CBB1E
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 11:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgLBKz2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 05:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgLBKz1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 05:55:27 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9FC0613CF
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 02:54:47 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so3236263wrc.8
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 02:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RixZqmygwe75ld9h4YE6V1AUIoGFZr6xHCaO+XnrUrU=;
        b=peKLYy67KH2tSYs3VixHq9W5p5eswBJe46+Qy6CMP9w0QPW46POBEMLeOciK9OPmeT
         9vElfwlV+2/Sho48PlM/PUKsI60bA8NWVV5PidDl9m8tsEuiN5fuaERrUcRJLph3V/NH
         Dt1xx3HWxPWF8kmuxdhoBFPCqjc1JVFR2D57lUwsrK3GnLUzP3rTlMKfALL5dgLTB2Fy
         1R2rWLyV47wzZh64bh77aBBU6PsucKoQ/jAoiZ/dxnV24WNvg2ymTn8FLbwlwcR1icT0
         XOaYzTLnQXbZYjzcW6szSHuaAzHXqgCxeeSQJMW6RZC5ah13hzZ7nRPwtV7qGuUNJJPz
         GgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RixZqmygwe75ld9h4YE6V1AUIoGFZr6xHCaO+XnrUrU=;
        b=LXvlRqkd4U8UzJu5+IJkBycz8yyidk7l9XcR7K3SzMn2G6N98Lqu7CbcfpocxeMk/4
         pEWWhAMO4uw+NEP1f33wokgtswjTkd6EWxdjG2T0fi8xIBDsYogUOeAqsNyqBX1pErMT
         PE8gRAyOMrrduJ8reK8rCfwkMQD++czUrjps5mcueHVOMVfcZyYN1eFrq+DuW2ODOp2t
         Z8PR+iyVSE/m3mLKBHAVhm/aQ0W/Hgs68If1+GY1uT2ZnK2l5gZhR2J+77jBbVxuQYSx
         o75jAeoG/6GBd4n0rF+ArUA8B6SRZqwjhFC92BKYWQ5ysUCH5X9NvybqCPlCrIgf28XD
         Yhbg==
X-Gm-Message-State: AOAM531RHnG8Y/qHRCsl4TbbXaOjkSPa8zacJiy+3zyeoI8eKwLPmJ2C
        u9BR8eJfHP0w59XV0kqP+tP4vQ==
X-Google-Smtp-Source: ABdhPJxsstDjT5B61t9p7jydnQIdxAK+CDY3hBboQUE7puAaJs3lKgWbjXudiRJp3ns1wWM3a4FoDQ==
X-Received: by 2002:adf:fb06:: with SMTP id c6mr2664491wrr.117.1606906486006;
        Wed, 02 Dec 2020 02:54:46 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id y18sm1700423wrr.67.2020.12.02.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 02:54:45 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:54:41 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: x86: Factor out emission of REX
 byte
Message-ID: <20201202105441.GB9710@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-3-jackmanb@google.com>
 <20201129011405.vai66tyexpphpacb@ast-mbp>
 <20201201121249.GA2114905@google.com>
 <CAADnVQK63=5XyGxMVe1xuLmQ6NZ5LtCHSVizOUtd1iZ=z747OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK63=5XyGxMVe1xuLmQ6NZ5LtCHSVizOUtd1iZ=z747OQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 01, 2020 at 09:48:36PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 1, 2020 at 4:12 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > On Sat, Nov 28, 2020 at 05:14:05PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Nov 27, 2020 at 05:57:27PM +0000, Brendan Jackman wrote:
> > > > The JIT case for encoding atomic ops is about to get more
> > > > complicated. In order to make the review & resulting code easier,
> > > > let's factor out some shared helpers.
> > > >
> > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
> > > >  1 file changed, 23 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > > index 94b17bd30e00..a839c1a54276 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -702,6 +702,21 @@ static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
> > > >     *pprog = prog;
> > > >  }
> > > >
> > > > +/*
> > > > + * Emit a REX byte if it will be necessary to address these registers
> > >
> > > What is "REX byte" ?
> > > May be rename it to maybe_emit_mod() ?
> >
> > Er, this is the REX prefix as described in
> > https://wiki.osdev.org/X86-64_Instruction_Encoding#REX_prefix
> >
> > Would maybe_emit_mod be accurate? In my mind "mod" is a field in the
> > ModR/M byte which comes _after_ the opcode. Before developing this
> > patchset I knew almost nothing about x86, so maybe I'm missing something
> > about the general terminology?
> 
> I wrote the JIT without looking into the manual and without studying
> the terminology.
> Why? Because it was not necessary. I still don't see a reason why
> that obscure terminology needs to be brought in into the code.
> 'mod' to me is a 'modifier'. Nothing to do with intel's modrm thing.

OK, calling it maybe_emit_mod(pprog, dst_reg, src_reg)
