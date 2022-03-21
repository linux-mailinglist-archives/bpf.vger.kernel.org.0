Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2A4E350B
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 01:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiCVACQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiCVACP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 20:02:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F311162
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:59:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w27so27160115lfa.5
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsaOnWeCk13QKDyhf3nL2sin+v7saq6qTmMyDRnRO0s=;
        b=PA4K5DpJZJPyZoq08+2m1Ta5kU++fe9CSmd7d03tsb0o+XzW6Nc6afVNH7zUGDSLvQ
         RjETIhnTo1kVtc/aN309Xg7bLDtEJsUEGehitZxyuNZ28YbiUKR750wPmFFIYk/95/oj
         mbH7WMqIptneasA/oXnP2Fwi6u5YybjqGQS5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsaOnWeCk13QKDyhf3nL2sin+v7saq6qTmMyDRnRO0s=;
        b=THPxLHB5JEsNTuYUayctpGAhFYRbwaSuZ8Tw0tcUyoRGsdboaprIvUgDBqGtmqO5M1
         qIJZEOMMP8Qtmn1u+SckhHn2+nmToV3KugKztbl0pClJtIkWjCziuHXQH2GInIcT9Cxw
         YmW+WrrxjucBCtbyCkVig33RdFzL1ZVgK63nkTJ406PHWPI7X+Ygl1OFUoOkKn6W1csE
         Cz1bkHvForXr/CAZnqVFXKr4W+nMHCDC0GzCUzR2j2ve7CNnvVmXuzAMXdarN/tmBKD7
         JGcjU1Xxvf5XP1NA+hFa8E3jUFofJ5urfh8QKAmke5KT2vdNhpwm07VJZo3ncuF4MRuW
         B/3Q==
X-Gm-Message-State: AOAM5331n/x5KpdkCdVcihqgBtIFKMKxN8dafNkczTezVNUzNwvGOb1e
        K29RqliXa5ocdilnrABRg51sOGTmZpsf7O0tZ7E=
X-Google-Smtp-Source: ABdhPJwX+pATjpX+AEItj0y4Bee3sP4cLVeFuIkb8Pj9nvU27b3TzHXiEm/37NhXHnvYq4WMEZFs6A==
X-Received: by 2002:a05:6512:31c2:b0:448:746e:6440 with SMTP id j2-20020a05651231c200b00448746e6440mr16596757lfe.353.1647907186256;
        Mon, 21 Mar 2022 16:59:46 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f1-20020a2e1f01000000b0024602522b5dsm2223515ljf.120.2022.03.21.16.59.45
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 16:59:45 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id e16so12962967lfc.13
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:59:45 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr16827759lfu.542.1647907185334; Mon, 21
 Mar 2022 16:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220321224608.55798-1-alexei.starovoitov@gmail.com>
 <CAHk-=wheGrBxOfMpWhQg1iswCKYig8vADnFVsA4oFWTY9NU5jA@mail.gmail.com> <CAADnVQK=JsytH_OtT6Q6fnijkTyv7NANV2902woQ6XT-fwWXQA@mail.gmail.com>
In-Reply-To: <CAADnVQK=JsytH_OtT6Q6fnijkTyv7NANV2902woQ6XT-fwWXQA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 16:59:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0fNH+FS-ng2Nvq2p1Jbfn+-G1AsK-XY7MD4gTJZg5ZA@mail.gmail.com>
Message-ID: <CAHk-=wi0fNH+FS-ng2Nvq2p1Jbfn+-G1AsK-XY7MD4gTJZg5ZA@mail.gmail.com>
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

On Mon, Mar 21, 2022 at 4:11 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Did you look at the code?
> In particular:
> https://lore.kernel.org/bpf/164735286243.1084943.7477055110527046644.stgit@devnote2/
>
> it's a copy paste of arch/x86/kernel/kprobes/core.c
>
> How is it "bad architecture code" ?

It's "bad architecture code" because the architecture maintainers have
made changes to check ENDBR in the meantime.

So it used to be perfectly fine. It's not any longer - and the
architecture maintainers were clearly never actually cc'd on the
changes, so they didn't find out until much too late.

Think of it this way: what if somebody started messing with your BPF
code, never told you, and then merged the BPF changes on the basis of
"hey, I used old BPF code as a base for it". In the meantime, you'd
changed the calling convention for BPF, so that code - that used to be
ok - now no longer actually works properly.

Would you think it's ok to bypass you as a maintainer on the basis
that it was based on a copy of code you maintained, and never even cc
you on the changes?

Or would you be unhappy?

             Linus
