Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E401C1F08FA
	for <lists+bpf@lfdr.de>; Sun,  7 Jun 2020 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgFFWdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Jun 2020 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgFFWdh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Jun 2020 18:33:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C89DC03E96A
        for <bpf@vger.kernel.org>; Sat,  6 Jun 2020 15:33:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r125so7932239lff.13
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2020 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3v5Kt8eWKoj8/dfeikK8krF25svghEw3lMoiT9ZcXk0=;
        b=eu2j1Y6krpt/zk9nzog/RgFPJNYImb6WDJAJ4Q3BH2EbU7xXBVn59g7FwqPU7fkIYd
         nIA7YYAmqf6rZR72RWPdr1NiipocRqwcLnHtA/zm37ImiNm+JzA4cfKk1HKQ1WYq9g67
         mbfsgYhy8HsrX6T9EiQ6x5XUQF2CJ7Kna5Yl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3v5Kt8eWKoj8/dfeikK8krF25svghEw3lMoiT9ZcXk0=;
        b=XbTsUaT1Prl4uIWKSnCLJZEhIrgQQV1SXD1GrnCsR1FgsOy4P22y0tTOytIDkwNR8L
         fxZCRI54boYDmt6ffze/zsXVUZirNrPL2OQRskfMmMgs6iSAsbynLNjLpxL8u0O9aX8x
         ZgZDosC+O6c/Nd2p0l+I8DC168+L5nOlqtVsczd7LbfOpSoZ8U3nfS4iWZS8f0lGa5TD
         CwGwRho5e964ojSJLNzOJxkpJJxUflMSFw4oiqhlmMZHhtJk5P1llrs3dLdGVWZ0aFVn
         U4/TwfCYfEvB8kJiu4EuKf/bkH9Eoh6ceu8cluj9pA5U6lHgqyv8u3odEyt52xZQLe/x
         hdZw==
X-Gm-Message-State: AOAM531AbrmarJKWSko+fdA/5caoJDqRgAHKVWf2mNbQWuu4psATKTRC
        Y5Lmr3Nci/PqAE4cNDYnDvicWANsRjE=
X-Google-Smtp-Source: ABdhPJxNh6Pm6txabejzRGvEoUH2iK7kgF8FfyKRpQH7NRAMvoHdguuoRVdCYm3QadhmA4o7ztf5/g==
X-Received: by 2002:a19:7714:: with SMTP id s20mr8686824lfc.161.1591482813391;
        Sat, 06 Jun 2020 15:33:33 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id k15sm2280727lji.26.2020.06.06.15.33.30
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 15:33:31 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d7so7955707lfi.12
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2020 15:33:30 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr8657693lfo.152.1591482810474;
 Sat, 06 Jun 2020 15:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook> <875zc4c86z.fsf_-_@x220.int.ebiederm.org> <20200606201956.rvfanoqkevjcptfl@ast-mbp>
In-Reply-To: <20200606201956.rvfanoqkevjcptfl@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Jun 2020 15:33:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
Message-ID: <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 6, 2020 at 1:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Please mention specific bugs and let's fix them.

Well, Eric did mention one explicit bug, and several "looks dodgy" bugs.

And the fact is, this isn't used.

It's clever, and I like the concept, but it was probably a mistake to
do this as a user-mode-helper thing.

If people really convert netfilter rules to bpf, they'll likely do so
in user space. This bpfilter thing hasn't gone anywhere, and it _has_
caused problems.

So Alexei, I think the burden of proof is not on Eric, but on you.

Eric's claim is that

 (a) it has bugs (and yes, he pointed to at lelast one)

 (b) it's not doing anything useful

 (b) it's a maintenance issue for execve, which is what Eric maintains.

So you can't just dismiss this, ignore the reported bug, and say
"we'll fix them".

That only answers (a) (well, it _would_ have answered (a)., except you
actually didn't even read Eric's report of existing bugs).

What is your answer to (b)-(c)?

             Linus
