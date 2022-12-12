Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93AA64A9A2
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLLVnx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 16:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLLVnw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 16:43:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2D13CCA
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:43:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4749461242
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 21:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B53C4339B
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 21:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670881430;
        bh=cEIYgBCk1jS2CNgVDh3B0JExa8+XC/aNPD8hEMVh3es=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GKkfNM8626cQ1r/eXVnIHYg8cv+wJm9dQrh0MC4gWydIEdzhgVm9lZrzlZvXbHoQY
         8/hs+syeFz2deFZunRNLsghite3pILkWglx6M69aFOa8DnEAm0slbpoX05rRuBL+8n
         P31MqOe/IxCecZw3hlQ/Mxhnh+5Qt1e1ZX3/I/cp1vsLXhcDKPNZkDSBg8Go6pfxXO
         wwD8f3hXxF6pfzsFJeN/gP1nIU6zX2MsIwFxrW+OsgafpFpxdPg/SprW2AbkTlkIXq
         HF8Oc2tI+njzdXG1EGVRpU25oJ3wznPla7Q3xV/J1VgmFDMv18qHNnrCb3F8vHw0eu
         zxF5fqspavO2Q==
Received: by mail-ej1-f41.google.com with SMTP id ud5so31702027ejc.4
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:43:50 -0800 (PST)
X-Gm-Message-State: ANoB5pktMmKnECro3c+wAbe9dJ4TPB+3m7ohugF5NjAfCkmq6ZKc/T2b
        TglwlJrxvX2NQi+HCrzhKRuh3QsZRPE9s3WOK5wu/w==
X-Google-Smtp-Source: AA0mqf7LEsNKArTwMWs9R9Mcrt4pnu+mxjZL757j0/V1mmWQShIkjYAgHdHWjoBIlNB0BM6pbB+7EEshSMWO/siB7OQ=
X-Received: by 2002:a17:906:402:b0:7a6:fc0f:6fe6 with SMTP id
 d2-20020a170906040200b007a6fc0f6fe6mr77481275eja.694.1670881428767; Mon, 12
 Dec 2022 13:43:48 -0800 (PST)
MIME-Version: 1.0
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
 <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
 <20221205075921.02edfe6b54abc5c2f9831875@kernel.org> <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
 <20221206162035.97ae19674d6d17108bed1910@kernel.org> <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
 <20221206233947.4c27cc9d@gandalf.local.home> <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
 <20221207074806.6f869be2@gandalf.local.home> <20221208043628.el5yykpjr4j45zqx@macbook-pro-6.dhcp.thefacebook.com>
 <20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org> <CACYkzJ72-hJweZoFN_YN8u3NOmp5x82M2xA-ZKBi5ubt6yrzZA@mail.gmail.com>
 <20221211120226.11c97578@rorschach.local.home>
In-Reply-To: <20221211120226.11c97578@rorschach.local.home>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 12 Dec 2022 22:43:37 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6xpapuN9attJzNaX3iuhLjH2bB4uBgGUNrZvwTWV9Yew@mail.gmail.com>
Message-ID: <CACYkzJ6xpapuN9attJzNaX3iuhLjH2bB4uBgGUNrZvwTWV9Yew@mail.gmail.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 11, 2022 at 6:02 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 11 Dec 2022 08:49:01 +0100
> KP Singh <kpsingh@kernel.org> wrote:
>
> > Let's take a step back and focus on solving debuggability and
> > introspection as we clearly have some perception issues about taints
> > in the community. (distro maintainers, users) before we go and add
> > more taints.
>
> Note, you will likely get the same push back if the dump includes bpf
> programs known to change the return of a function that may be involved
> with the bug report. That is, if a crash is reported to code I
> maintain, and I see that the bug report includes a list of BPF programs
> that can modify the return of a function, and one of those functions
> could affect the place that crashed, I'd push back and ask if the crash
> could be done without that BPF program loaded, regardless of taints.
>

I think this is already better as it gives the recipient of the stack
trace more information to ask more questions and see if the BPF
programs are relevant to the stack trace and engage further.

> I agree that a taint is just a hint and it can include something that
> caused the bug or it may not. I would like to see more details in how
> the crashed kernel was configured. That includes loaded BPF programs
> (just like we include loaded modules). And if any BPF program modifies
> a core function (outside of syscall returns) I'd be a bit suspect of
> what happened.

Agreed.

>
> I also agree that if a function that checks error paths fails, it
> should be fixed, but knowing that the error path was caused by fault
> injection will prevent the wasted effort that most developers will go
> through to find out why the error path was hit in the first place.

Agreed.

>
> -- Steve
