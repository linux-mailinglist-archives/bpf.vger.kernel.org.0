Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7824E3413
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiCUXOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiCUXOU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:14:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76683EBAB
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:02:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g24so20654764lja.7
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBwRJ7GvCh4HtlZQddJMPuKbvebn+hY/0aFRZGnCyYw=;
        b=RM2ROADzKcYZGbkgNThMWejZQKWAdtKsOo5GYb0Nbw9kcwMn7+aoDS82B5mu+F+MvP
         neUMee81Lurcv6z5MROmZ4/LuNOvF073FfdHZeoP0m+zA75pI0bqsqApnXq35iu/nnAA
         SwI/+2l8/2ufeXsFybX2V0dOUOj5T0tD4i3VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBwRJ7GvCh4HtlZQddJMPuKbvebn+hY/0aFRZGnCyYw=;
        b=Nuofe0zzPsNFklr899BNYVp+rRvJtFU999mS9t5jxhS/Do3vje9lgMjMv5am5vUpUk
         5Kn0IJvqS217h9WZ5rYk/eVt9xqpqi+avU1fLdShm/Qpqz9r6VULGmmDKEsnfjmuOrkI
         yl/hqY8yOaC1m56pMxT0pTqVIZN0tyH0crM4jLr3kUVJ11vFF0qAjSEUbZXaAx8Jpdga
         NAF0jRHBHjxTju/6+7VmuIAhRgnMS9C9EvrLC4O5gfDTC5HU0Zs/1WcfFMyObajvU5jr
         dCJL50PgRh4Rk9iqDLnsMO93RogDCeptEzc6DJE3lOZnQQIdTG5POClso/y5Jfl2KRaW
         HBPA==
X-Gm-Message-State: AOAM530dBIA4f2i7yTk70hwFmZuVRuEStSwnyCHw1RTQVhUQ3+Qq8+LA
        KLCs6zPwOIGA6k24CHpqh03+5poFsFMKeUeEdHE=
X-Google-Smtp-Source: ABdhPJwQF6jGpNNxej8asCb6RSFI4CqHvgn5in8CkxDkFuoghgILObIW0Rnwh1gm0pUGpphfyvrl4g==
X-Received: by 2002:a2e:8952:0:b0:249:786c:bb5d with SMTP id b18-20020a2e8952000000b00249786cbb5dmr9589873ljk.242.1647903724156;
        Mon, 21 Mar 2022 16:02:04 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id d25-20020a194f19000000b0044a2ad98dcasm486901lfb.167.2022.03.21.16.02.01
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 16:02:02 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id a26so8999704lfg.10
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:02:01 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr16491603lfj.449.1647903721198; Mon, 21
 Mar 2022 16:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220321224608.55798-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220321224608.55798-1-alexei.starovoitov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 16:01:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheGrBxOfMpWhQg1iswCKYig8vADnFVsA4oFWTY9NU5jA@mail.gmail.com>
Message-ID: <CAHk-=wheGrBxOfMpWhQg1iswCKYig8vADnFVsA4oFWTY9NU5jA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2022-03-21
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 21, 2022 at 3:46 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> The following pull-request contains BPF updates for your *net-next* tree.

No

This is the tree that contains bad architecture code that was NAK'ed
by both x86 and arm64 people respectively.

In particular, I think it's this part:

> Masami Hiramatsu (11):
>       fprobe: Add ftrace based probe APIs
>       rethook: Add a generic return hook
>       rethook: x86: Add rethook x86 implementation
>       arm64: rethook: Add arm64 rethook implementation
>       powerpc: Add rethook support
>       ARM: rethook: Add rethook arm implementation
>       fprobe: Add exit_handler support
>       fprobe: Add sample program for fprobe
>       fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe
>       docs: fprobe: Add fprobe description to ftrace-use.rst
>       fprobe: Add a selftest for fprobe

That was added very late to the linux-next tree, and that causes build
warnings because of interactions with other changes.

Not ok.

                   Linus
