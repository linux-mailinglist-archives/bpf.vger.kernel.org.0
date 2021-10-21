Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578EE436E72
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJUXol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 19:44:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A3C061764;
        Thu, 21 Oct 2021 16:42:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so654400pje.0;
        Thu, 21 Oct 2021 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbHn1t4w6ii4qOpK6OASHe+IZF0/K00mQ93D+vSWtbo=;
        b=lvGYdZSiEg4NpLU4xu1JfC695jBAeKaDJyQRvBLH7sXDxR1zs75zHAZO3eX6CtqDvi
         8h0TPWtdf1wXybZ2M/sXA7d3uDPgamYDnTWPItuq+jnlhTzsmG5znGqndIZJfbd7bpPP
         nDYBZdTtvQCvNB1+785SB9Y9lKDxklk28yPQd7DgLgmpCZLaZBxAM0fs4iRIQ6OFz+/n
         1l6ppu9LBFTrVr/7/ApXbNRAEQ0/ESRpqEjIsGf1Qypbp4sNWze5gaom9bLMg991xqAQ
         /wgc57su+aGZS/WT7xD8dpfLj0kaySi/d+1POyxclnbj75SNF/uyiudy1gk5RqMLIIOj
         M0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbHn1t4w6ii4qOpK6OASHe+IZF0/K00mQ93D+vSWtbo=;
        b=NhnljbeYtwQ5zeKjLGSbfuH+uC4dgz8GmQwUt8pU9rrS/oSmYfXBAGmfEwEUCjuT7m
         EwLhBELkP/qVxbfQDwDzPE0+uLH+x2e4ct2jg4So4NnwTF4QGO04b9Z2O5VUqIufiP+G
         ifYf1fqG6PujZSDWKw2zpHyPgyUs1lENsolaZDQrCj0r1bKtuOmLXokJfX8qorJwc+KS
         S+sDhiWwF3BSBDuU2qhscbpTN7iF0QiuN3RAEXSdVvd9esEeeu5+T/W/MRojHbsfElEu
         ifV36PCKMRqEZ47GoJb3WgzkRfZB/JRrDUTMbXeLbyjss6qpc9N5a6ZLJlN4xtMUcjYY
         jvVg==
X-Gm-Message-State: AOAM53148HGCFgB6YxynYrsRVB+jaNkXvfoZmMfv5CuON9ndMe9pRRrp
        TTN6rbe0s/4po6E+nVxLNUOlosjDJ9hpE2U2p1E=
X-Google-Smtp-Source: ABdhPJyN1hj8+a29/Eln8HV/7A9HIu2b2dNAOWP+8PY8PSa0FHgdibcOhjSMsnanb3r1CSC/5MNpSvbXo0JiT8/CLf4=
X-Received: by 2002:a17:902:ea09:b0:13f:ac2:c5ae with SMTP id
 s9-20020a170902ea0900b0013f0ac2c5aemr8052334plg.3.1634859743484; Thu, 21 Oct
 2021 16:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211020104442.021802560@infradead.org> <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net> <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net> <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
 <20211021223719.GY174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com> <20211021233852.gbkyl7wpunyyq4y5@treble>
In-Reply-To: <20211021233852.gbkyl7wpunyyq4y5@treble>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Oct 2021 16:42:12 -0700
Message-ID: <CAADnVQ+iMysKSKBGzx7Wa+ygpr9nTJbRo4eGYADLFDE4PmtjOQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 4:38 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Oct 21, 2021 at 04:24:33PM -0700, Alexei Starovoitov wrote:
> > On Thu, Oct 21, 2021 at 3:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Oct 21, 2021 at 11:03:33AM -0700, Alexei Starovoitov wrote:
> > >
> > > > > I nicked it from emit_bpf_tail_call() in the 32bit jit :-) It seemed a
> > > > > lot more robust than the 64bit one and I couldn't figure out why the
> > > > > difference.
> > > >
> > > > Interesting. Daniel will recognize that trick then :)
> > >
> > > > > Is there concurrency on the jit?
> > > >
> > > > The JIT of different progs can happen in parallel.
> > >
> > > In that case I don't think the patch is safe. I'll see if I can find a
> > > variant that doesn't use static storage.
> >
> > The variable can only change from one fixed value to another fixed value.
> > Different threads will compute the same value. So I think it's safe
> > as-is. READ_ONCE/WRITE_ONCE won't hurt though.
>
> But the size of the generated code differs based on the
> emit_bpf_tail_call_indirect() args: 'callee_regs_used' and
> 'stack_depth'.  So the fixed value can change.

Ahh. Right. It's potentially a different offset for every prog.
Let's put it into struct jit_context then.
