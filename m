Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDA8436E5D
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhJUXlP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbhJUXlP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 19:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634859538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqubQX+KjTkC2vCpdxocGaht9394l669HgXzqP3nsGk=;
        b=VKsc7qcgPK7aA616egRCO388Ver8+AylJzhyFpYCDUHd5Facw0xTimlCIOYxcMV4vzEdYD
        pdHPPC3GcajFZ95BUwv/v3ZIJFLAJztBjcseCEVVjS0Nb6V+EYr5G3X8VxCB2pl/exDvcH
        UOqhNekwnWmEoYx0M4endviiQCFLLiw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-z3bO8azxNpeXCVVktvO7mA-1; Thu, 21 Oct 2021 19:38:56 -0400
X-MC-Unique: z3bO8azxNpeXCVVktvO7mA-1
Received: by mail-qk1-f198.google.com with SMTP id l27-20020a05620a211b00b0045fbe374e2dso1678731qkl.10
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 16:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqubQX+KjTkC2vCpdxocGaht9394l669HgXzqP3nsGk=;
        b=CLPi46C9fwVcezEKHzJKieTQ9xil3A4FS7mpyg5z4Um6Wh0g1RFT5Whi7mq32emg1P
         eMf3Osl7O43VVptZIwY/VG8mZry85s2XN5sqeidVReNaX7Ad2aHKEUH0kQsJ2nUiWlSw
         TNmz2YtkhT1ZWSAWvUmS5BgAhEjlLrOliZTeXyMBCq/1WzUmU+1MU590dOyEvZ1yhp8N
         pcONbM/ccxEc0DZ/4bxLhHAy6HX2WC/a9zGoYUTRic8wDld6w2+ge/OGjCY/4HjkKYWU
         al4XsMuZFqbevCkvbg+qMbqFLGnyzfp2POJvSXeRj5YgTpn8cWr6dvi/vJTjGpVbzWrF
         G7wQ==
X-Gm-Message-State: AOAM532LchSYTvV/CmW+3bOvYKLZ+CprHa0CVlDwSiG+JaK77y/bHyro
        kowmRt0CAFD0/k4bSaOlfnNYAPS/E8P3QczJGEnqC8abWo+QWUMWmbrepk8GMfoEpcxcEVYFcYZ
        fEJZpCIq6aNau
X-Received: by 2002:a37:4553:: with SMTP id s80mr7140058qka.489.1634859536392;
        Thu, 21 Oct 2021 16:38:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ50mxqIsbIggxTzTVv0SnbGTeNVj4OaFqzddYueB2tm+JgTb+I/dfqDNynyVSHsbuN/7ANw==
X-Received: by 2002:a37:4553:: with SMTP id s80mr7140037qka.489.1634859536201;
        Thu, 21 Oct 2021 16:38:56 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id s189sm3236528qka.100.2021.10.21.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 16:38:55 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:38:52 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211021233852.gbkyl7wpunyyq4y5@treble>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
 <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
 <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
 <20211021223719.GY174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 04:24:33PM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 21, 2021 at 3:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 21, 2021 at 11:03:33AM -0700, Alexei Starovoitov wrote:
> >
> > > > I nicked it from emit_bpf_tail_call() in the 32bit jit :-) It seemed a
> > > > lot more robust than the 64bit one and I couldn't figure out why the
> > > > difference.
> > >
> > > Interesting. Daniel will recognize that trick then :)
> >
> > > > Is there concurrency on the jit?
> > >
> > > The JIT of different progs can happen in parallel.
> >
> > In that case I don't think the patch is safe. I'll see if I can find a
> > variant that doesn't use static storage.
> 
> The variable can only change from one fixed value to another fixed value.
> Different threads will compute the same value. So I think it's safe
> as-is. READ_ONCE/WRITE_ONCE won't hurt though.

But the size of the generated code differs based on the
emit_bpf_tail_call_indirect() args: 'callee_regs_used' and
'stack_depth'.  So the fixed value can change.

-- 
Josh

