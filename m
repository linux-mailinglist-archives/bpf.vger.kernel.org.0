Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202EA2CB4B3
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 06:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgLBFtb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 00:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgLBFtb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 00:49:31 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D03C0613CF;
        Tue,  1 Dec 2020 21:48:50 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t6so1700729lfl.13;
        Tue, 01 Dec 2020 21:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNDxyrqIGgFLv57oHNLRb1qMbcd3Zb2laVpkQBPvLOA=;
        b=iN+bP8C3kNaCEQaMZWryt4Vx44HH8j8Iv31TpO4sZ5OkQP8bfbyA+1czyK0oRclazO
         Jq2TUY5MxAcAi7+udumMyuMidTUEMdiQufSkNKFjDjbD6+8vuQiov3rUYGXFfZsuI3HC
         0lT112wBOGS/AbnixLIrmu53BsvGrry/pWlvvK9jqprIB2r0tIQzPkgZDiyZ/sjO4PQU
         i4JMwjvgDiMtHAKQ6Ca7tu6osPnOpJXj+ssYgdeajFD0LWubbit+X9ipVtVO6m1UJ5dj
         3tZ27WcdKmFh6zjRme9X3OeyXatt0jKVA8yDD3J+XmQPF86rWJjT252LIFdLzyoOjVFQ
         ohqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNDxyrqIGgFLv57oHNLRb1qMbcd3Zb2laVpkQBPvLOA=;
        b=okOjatD1Zv7f5s4tM8840svRSzHgU2eIEYCoLzDMGSGtSN7bBpSMH9MjcBnALET0+Q
         dHfzoZ5ns9QxKITc7WKhhbQCZjdGs944zaXzGBKkZLhLF9xDYAI0Tou7gJloACZZuSg4
         Aw9BdwMTP3CCHHIr/PIVGfXql0w5bFGSzVkYiEDJByQUKlHPSQe9IL8+wUpqlErua7tc
         oZNFbxCjvmvW27goea1n3lH0VqP++j5zCPzz4Wuyd0gL/32JKwaPUy1plUodbpgOHNAX
         1nV285LonJZYfXhvrhiIONmTu9SNOd/Tr8kWzQ26dtOhdlYNY2GLv8wZ+nlziSn8QuRO
         KW7Q==
X-Gm-Message-State: AOAM531KnJy5PyWAcw/m0ojsT9XdB2rvIzeQdZisJBRcFaigMc2dalmx
        9uYcVw+ZFa+pM+97SOU9Jixt2b9Wz2oG6uz+2gU=
X-Google-Smtp-Source: ABdhPJxXRs8Gf5dbTVdeV6GA86m4KRy3D59UGd8vRybMqbZrbufcbaqimTIshfDoG5SZtnER0xwGhM7Eu6eFLlcTlUw=
X-Received: by 2002:a05:6512:3384:: with SMTP id h4mr479941lfg.554.1606888127993;
 Tue, 01 Dec 2020 21:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com> <20201127175738.1085417-3-jackmanb@google.com>
 <20201129011405.vai66tyexpphpacb@ast-mbp> <20201201121249.GA2114905@google.com>
In-Reply-To: <20201201121249.GA2114905@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Dec 2020 21:48:36 -0800
Message-ID: <CAADnVQK63=5XyGxMVe1xuLmQ6NZ5LtCHSVizOUtd1iZ=z747OQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: x86: Factor out emission of REX byte
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 1, 2020 at 4:12 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Sat, Nov 28, 2020 at 05:14:05PM -0800, Alexei Starovoitov wrote:
> > On Fri, Nov 27, 2020 at 05:57:27PM +0000, Brendan Jackman wrote:
> > > The JIT case for encoding atomic ops is about to get more
> > > complicated. In order to make the review & resulting code easier,
> > > let's factor out some shared helpers.
> > >
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
> > >  1 file changed, 23 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index 94b17bd30e00..a839c1a54276 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -702,6 +702,21 @@ static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
> > >     *pprog = prog;
> > >  }
> > >
> > > +/*
> > > + * Emit a REX byte if it will be necessary to address these registers
> >
> > What is "REX byte" ?
> > May be rename it to maybe_emit_mod() ?
>
> Er, this is the REX prefix as described in
> https://wiki.osdev.org/X86-64_Instruction_Encoding#REX_prefix
>
> Would maybe_emit_mod be accurate? In my mind "mod" is a field in the
> ModR/M byte which comes _after_ the opcode. Before developing this
> patchset I knew almost nothing about x86, so maybe I'm missing something
> about the general terminology?

I wrote the JIT without looking into the manual and without studying
the terminology.
Why? Because it was not necessary. I still don't see a reason why
that obscure terminology needs to be brought in into the code.
'mod' to me is a 'modifier'. Nothing to do with intel's modrm thing.
