Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463521D252B
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 04:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgENCno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 22:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbgENCno (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 22:43:44 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A228AC061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 19:43:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v5so1235092lfp.13
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3In83ZNtvhCqrpK0vVjzsKNvprMyvL+zJ9ohua4z10=;
        b=RJxI7nc5/+qicT+av7MVnCPyCWQNYqEmo+1I8aEDjYrcgsKm1JO+ximEumc2BGCHG6
         IRKjgEiRjwQuoza3oL4WOrhIpbRc8zh7pT5r3iUQzrEjc7+dcHsaKetaMFqukCgIbr+Y
         1swtCFlefWtGVUfsLBR/jTXuJr1SgZ0x45QhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3In83ZNtvhCqrpK0vVjzsKNvprMyvL+zJ9ohua4z10=;
        b=rnbkRks9vZYxlX6XmkMCh+oSBdrqarDZZNPmIQyL8dzlK4k9kAXqxHiodoZb8wq+CP
         w6h6IL0Y6BebT020gtS1kjG1wNDxyhNtOws38q7VrAW+oyGAt6j9bsKgTqNJL39JX1YD
         /H8rSIT4yJbNtBV9AGjd6GemCeDhVFuP/Xu5s+Qf4hSa9bEZ96IP2isfum74t+m++/FK
         qxWxMqFB/QPOWetnbdjQgujlRTEab6W051hF/XIrmNpFLU1luam2bkE3zhmNDz6M0+B7
         LjztDHBdeZz3n8QEJ1JUw8ZLl8CldENMrfAsM1fZX2JB6zmh0DL7A1j8zd8jNgLx1cQa
         FiaQ==
X-Gm-Message-State: AOAM531v5WDbtibGTl1RrLG6lCqvOZI/6H0dMjHBvLUJ9r1s41SM0Oo0
        6XZzPj13EEr6HR4SwF13a5/Vw/Moo+k=
X-Google-Smtp-Source: ABdhPJw3+jMVKygwWNAEYbbDY2LmlXyV5aUs0L1OIQurtaYHG+jD50XlWG1sMXkAbA/X0rcokNzWYA==
X-Received: by 2002:ac2:4304:: with SMTP id l4mr1627893lfh.87.1589424221667;
        Wed, 13 May 2020 19:43:41 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y16sm800328lfe.17.2020.05.13.19.43.40
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 19:43:40 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id z22so1315693lfd.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 19:43:40 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr1567307lfk.192.1589424220085;
 Wed, 13 May 2020 19:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de> <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
 <20200514082054.f817721ce196f134e6820644@kernel.org> <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
 <20200514100009.a8e6aa001f0ace5553c7904f@kernel.org>
In-Reply-To: <20200514100009.a8e6aa001f0ace5553c7904f@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 19:43:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP8ysEZnNFi_+E1ZEFGpcbAN8kbYHrCnC93TX6XX+jEQ@mail.gmail.com>
Message-ID: <CAHk-=wjP8ysEZnNFi_+E1ZEFGpcbAN8kbYHrCnC93TX6XX+jEQ@mail.gmail.com>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 6:00 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > But we should likely at least disallow it entirely on platforms where
> > we really can't - or pick one hardcoded choice. On sparc, you really
> > _have_ to specify one or the other.
>
> OK. BTW, is there any way to detect the kernel/user space overlap on
> memory layout statically? If there, I can do it. (I don't like
> "if (CONFIG_X86)" thing....)
> Or, maybe we need CONFIG_ARCH_OVERLAP_ADDRESS_SPACE?

I think it would be better to have a CONFIG variable that
architectures can just 'select' to show that they are ok with separate
kernel and user addresses.

Because I don't think we have any way to say that right now as-is. You
can probably come up with hacky ways to approximate it, ie something
like

    if (TASK_SIZE_MAX > PAGE_OFFSET)
        .... they overlap ..

which would almost work, but..

                 Linus
