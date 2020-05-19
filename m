Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF43F1D9D26
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgESQq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgESQqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 12:46:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3865C08C5C3
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:46:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g1so444823ljk.7
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TC0qAtFd13O2JOLCB7SFLNnsJ0TrRRfShJMVEYLbwy0=;
        b=BM7rNRUOZPJu6CqIZoTyNHsH3OhfbJ7v4lyTa1sXCfThZdyIW2MAwpqUoVdCrwYJYJ
         M+8yUvqSB1mogas+2iJO8jLleH/wb+mxdAsp/6H+RxHZ44GfbLZBQMjsb0UkWlV6SNKA
         VToCUizM9QTTj9Opl/oBOtfqOQD3JZAH4FWEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TC0qAtFd13O2JOLCB7SFLNnsJ0TrRRfShJMVEYLbwy0=;
        b=EydA9w2xb5icpHlsCwRzzGXPKWff/RxYtRkhOiyScRSrFKkL5njkBy/FDU0kOPbZBW
         4hJhU9b0rQiTQrBAsUy+1wSQKxhhdrN5ShR9UJEgM06Eb93B7c8vxUPVasZSUK5slsH3
         31O/8f4L5ng4zU91yMRsYBaBnaPO732Ac3s1qiCwAK3VZdYIMAwiQ8zDZuuh9Te7bCwV
         aXwRGl1HM270MlGeJI1UvoeONzOmAnxb1eJwtQQ1YGNR3rMfAB91d/ZEilqBAu5VCJH4
         8C25WcV7Pg2sS9+UfF8pvviT3HqBsL6de6PEnjw+Cs5xjz4WCJKAYUKEBS6XX65mX21a
         O39w==
X-Gm-Message-State: AOAM531t2Fuo63nT3ezP1DgfblwnP/F9zcGcVa9k6b/QYTTkQR8zWqxe
        +vohqh1jPPOAMIvk/c8C2mZOv09IjqY=
X-Google-Smtp-Source: ABdhPJwlydXGXtryzIEhKXiIsSCo2i4I9bnLa33vqeAndedVgpaCMz3DKESpSYUPplYpD0l2mUaECQ==
X-Received: by 2002:a2e:711c:: with SMTP id m28mr215857ljc.104.1589906781612;
        Tue, 19 May 2020 09:46:21 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f11sm7441225lfj.91.2020.05.19.09.46.18
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:46:19 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id g4so477669ljl.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:46:18 -0700 (PDT)
X-Received: by 2002:a2e:8956:: with SMTP id b22mr218841ljk.16.1589906778412;
 Tue, 19 May 2020 09:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-13-hch@lst.de>
 <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com> <20200519164146.GA28313@lst.de>
In-Reply-To: <20200519164146.GA28313@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:46:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVd4evLe-pi7VNrh4Htp1SjogWtEqgot6Ta+kavyqamg@mail.gmail.com>
Message-ID: <CAHk-=whVd4evLe-pi7VNrh4Htp1SjogWtEqgot6Ta+kavyqamg@mail.gmail.com>
Subject: Re: [PATCH 12/20] maccess: remove strncpy_from_unsafe
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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

On Tue, May 19, 2020 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I had a lot of folks complaining about things like:
>
> #ifdef CONFIG_FOO
>         if (foo)
>                 do_stuff();
>         else
> #endif
>                 do_something_else();
>
> which I personally don't mind at all, so I switched to this style.

Well, I don't particularly like that style either, it is _very_ easy
to get wrong when you edit it later (and various indentation checkers
tend to be very unhappy about it too).

But that's why I like trying to just make simple helper functions instead.

Yeah, it's often a few more lines of code (if only because of the
extra function definition etc), but with good naming and sane
arguments those few extra lines can also help make it much more
understandable in the process, and it gives you a nice place to add
commentary for the really odd cases (comments inside code that then
does other things often make things just harder to see).

             Linus
