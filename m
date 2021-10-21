Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511B3436E4A
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJUX1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUX1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 19:27:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9F0C061764;
        Thu, 21 Oct 2021 16:24:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso1714641pjw.2;
        Thu, 21 Oct 2021 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fY2hV8XRVOO2z6eSx2Sa3uH+I+pPPBEbHLcYZ/x3/M=;
        b=KC+C/tSlTIUK8G8bDPyCVtQPfsEG2oni8sQ+e9CPl8yiAk1NQd/dtP8yibo2BygPd9
         4WbDgVPBIaG5s9KSFacVVxTLUb31PHRGSde1XHUyr0EFvMpcEKXiN8daXLOGXO0qm6Se
         A09LELqTjoKB2JsQnY/tjIJlsLItY75/jmLU73JCZy+a5E8aiLLoXeB8737xT8riyOhu
         ga5STNGShJZpHZ0IsBVhUwJ1PzgupV9ZWtZLXqL8vMX0Nk8k7zJPIVPL23GM2tAp2S3Q
         DAvwooFkWhE+czkzwKAxur3Vu5EaX6dDLVptTdkl0HrbUXxaMK5HD1bmcETTyvRfRRS/
         5teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fY2hV8XRVOO2z6eSx2Sa3uH+I+pPPBEbHLcYZ/x3/M=;
        b=iIKoa4O4snGw/dfLFDiyFmuD24J2PbWDsCIHSJSLnZ89wQLM2OLXtrsvq84nPIZnj9
         EM7xlQh0oLlNjtUbvoIZ6n4cHbcX6CQ9jImK20yKb3AfXP0yy6gp2FsSir/aV96zfEgt
         hm7d+EBpzNihFPnXKFhi9Nf05PnbW9qKtqoNq98aqRcf5lQlGurgPryRGhQFbwT7y4ES
         HKRnXMofpohDe6KG262gVJXiVeiZTkfVwYCFSekuKY+9top/Fln/v/s0eJKih5agVDEJ
         +36SRRLA+DyAjCa/kq2zubQ15y/LcpVuuef/2ax9V+TrKTlhHIP5msh3DhIgEagw7SEw
         gBdw==
X-Gm-Message-State: AOAM533SmDfqasYrX12nbYBZ06gMnBaddjC/tuA3THdon3laSsbtZU4e
        9AyQzbyShDJBXfNQ2FF2XznPlyCiVKDzRRpKSy4=
X-Google-Smtp-Source: ABdhPJzUOIu/reLJA0RsJ0HzkMLCAnvLuGWpjuidUuwEwHgFcQ9+E5YtyRmfG1HULCXpw+DmppaLUTVeLfe50KNFevg=
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr10054997pjj.138.1634858684224;
 Thu, 21 Oct 2021 16:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211020104442.021802560@infradead.org> <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net> <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net> <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
 <20211021223719.GY174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211021223719.GY174703@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Oct 2021 16:24:33 -0700
Message-ID: <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 3:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 21, 2021 at 11:03:33AM -0700, Alexei Starovoitov wrote:
>
> > > I nicked it from emit_bpf_tail_call() in the 32bit jit :-) It seemed a
> > > lot more robust than the 64bit one and I couldn't figure out why the
> > > difference.
> >
> > Interesting. Daniel will recognize that trick then :)
>
> > > Is there concurrency on the jit?
> >
> > The JIT of different progs can happen in parallel.
>
> In that case I don't think the patch is safe. I'll see if I can find a
> variant that doesn't use static storage.

The variable can only change from one fixed value to another fixed value.
Different threads will compute the same value. So I think it's safe
as-is. READ_ONCE/WRITE_ONCE won't hurt though.
