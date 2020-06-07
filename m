Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4B81F0952
	for <lists+bpf@lfdr.de>; Sun,  7 Jun 2020 04:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFGCUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Jun 2020 22:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgFGCUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Jun 2020 22:20:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4103C08C5C2
        for <bpf@vger.kernel.org>; Sat,  6 Jun 2020 19:20:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so8105434lfc.10
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2020 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51iWnw7TQ15fY1kqPFRmgdYzxxDaa8IYfxj8y/f2dbc=;
        b=Fa9C96BrOkF8Mp36aE9dZUdxb+L91izCo02AVJBy8+w7CvW/5CHQKm+nfuPz9HqtBJ
         b6cWyIm7p5VwTgPsS6XKtwJ6JELQVUMuyNSx5YqRdtJ6gC8Glk+Vy7cL1qtrOyE6PaNv
         kB63jRH9vXjZz/7d/xnpFb7WEDG5a8iGv7qfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51iWnw7TQ15fY1kqPFRmgdYzxxDaa8IYfxj8y/f2dbc=;
        b=WjiM5PeMM4umf/Gb1y5h8n7QB/1Q0bc6IM659nDwLhL36Y44JoXy7nLlI0E0mQWGsL
         M7ZxLFW+mwpDJvSFd+j9JtyqvXitoLpWcxMqbA5ju5xI7t/S+RXP6nrI84+HTyVn9O9N
         VwjQZmdCCOKJREDGDVIBiwCMCWp3ARW0/eyfcewI04af3yDLY6irrOBWrUNxICjUgGHs
         QDi8Vn2pcW7MvYYUYygSsW6nXDacmJjqdd5zrBRWmrnjmelJJ/KtX/idcFzgMbdbsUfQ
         gD3cDOu16h/USAbpshNWdBHaiLzn2/aCKrDhW0JIsWvyEZF12E2fKHf1YTFvHm2aX5/f
         3JXg==
X-Gm-Message-State: AOAM533RERXdqnKItu/yk0Mw4L3UREMnzPMlDLZVt6zKBPHn4KPZcBd4
        BeS9QAN4jNlpa0b9SVmXOSTJxI8ScKM=
X-Google-Smtp-Source: ABdhPJyspMuA/iZgDsnEtF3Srn/dU2ZU2aCHCdaVjs4m9+5EY+Gq9njRKKtTyx3vXsTluUv1n9WnOQ==
X-Received: by 2002:a05:6512:6ca:: with SMTP id u10mr9458234lff.184.1591496414593;
        Sat, 06 Jun 2020 19:20:14 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r7sm2402811ljc.62.2020.06.06.19.20.12
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 19:20:13 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id d7so8100827lfi.12
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2020 19:20:12 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr8998314lfo.152.1591496412422;
 Sat, 06 Jun 2020 19:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook> <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp> <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
In-Reply-To: <20200607014935.vhd3scr4qmawq7no@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Jun 2020 19:19:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
Message-ID: <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
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

On Sat, Jun 6, 2020 at 6:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>>
> I'm not aware of execve issues. I don't remember being cc-ed on them.
> To me this 'lets remove everything' patch comes out of nowhere with
> a link to three month old patch as a justification.

Well, it's out of nowhere as far as bpf is concerned, but we've had a
fair amount of discussions about execve cleanups (and a fair amount of
work too, not just discussion) lately

So it comes out of "execve is rather grotty", and trying to make it
simpler have fewer special cases.

> So far we had two attempts at converting netfilter rules to bpf. Both ended up
> with user space implementation and short cuts.

So I have a question: are we convinced that doing this "netfilter
conversion" in user space is required at all?

I realize that yes, running clang is not something we'd want to do in
kernel space, that's not what I'm asking.

But how much might be doable at kernel compile time (run clang to
generate bpf statically when building the kernel) together with some
simplistic run-time parameterized JITting for the table details that
the kernel could do on its own without a real compiler?

Because the problem with this code isn't the "use bpf for netfilter
rules", it's the "run a user mode helper". The execve thing is
actually only incidental, it also ends up being a somewhat interesting
issue wrt namespacing and security (and bootstrapping - I'm not
convinced people want to have a clang bpf compiler in initrd etc).

So particularly if we accept the fact that we won't necessarily need
all of netfilter converted in general - some will be just translated
entirely independently in user space and not use netfilter at all
(just bpf loaded normally)

IOW there would potentially only be a (fairly small?) core set that
the kernel would need to be able to handle "natively".

Am I just blathering?

                  Linus
