Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067D61C786A
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgEFRor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 13:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgEFRof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 13:44:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F1C061A41
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 10:44:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so3310238ljl.6
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNt2KHwB8PiMSyUUcvWbb3LmQf/yl99wmVRwAMCe6Sw=;
        b=QfIhp8bnkHziXy45j6AZQvnQuPZVCBRmkYNh4Qk1yBWY/AbDih3c468GHPPi0NxUWC
         +RsQItHsCm4TW5y+JMWQZhOFGKrkw/OMHO8k0Ff3ChO35z8KVI8vHTXhfxO6dpDN2zOT
         R/3GLd58rAk/zgyKNOtvPikt/JEPwM8VJVw+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNt2KHwB8PiMSyUUcvWbb3LmQf/yl99wmVRwAMCe6Sw=;
        b=LaY7Y5pdOJgt4OgDgSuqBi/fymqR2BBcxntgqIzkuaccLS9e1HZKkUJN+c22hKO9fB
         hImXBXxgEiND6xMQuYGezFEQHNpADW31VbjsHSwtXjjSHH4LrxS2m+DGZReC6xz4iIOc
         oFjypw7UiX219gVSDvI5XTQgBeIig3pOxLYo7AejEIl64imADAkYlp31arLq1tQdyC/u
         NVs2boX6FPsE8hsQMjADlzUyVqbTi2d4sJLxGch6ZpGUISBf/ZRIhYH3sqgbjFfZiSkh
         6eo1yWxx+FZKSW3jLWCDbmgSsqrGbiG5c3HI/6HNeTNDxa9sHdY1l+9LfjBQPr3JZQrV
         x2Yw==
X-Gm-Message-State: AGi0PuaQJ1BrXMmcVhC8i7QgpFFTNVI6d7rWrMSBODNKId7+GCjgp6wy
        Ih+a1bZhx6Z8v/vykVm3Ho69boP/Q/4=
X-Google-Smtp-Source: APiQypKkGc502NXvxRp6NQ0zrQiaFlhZYDzA2A3SSWKImmcxLEzuzBlVFsKHsJxz/NNth2Vwma0kIA==
X-Received: by 2002:a2e:9818:: with SMTP id a24mr5825936ljj.126.1588787072941;
        Wed, 06 May 2020 10:44:32 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o204sm2071082lff.64.2020.05.06.10.44.31
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 10:44:32 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x73so2088743lfa.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 10:44:31 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr5836440lfk.192.1588787071388;
 Wed, 06 May 2020 10:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200506062223.30032-1-hch@lst.de> <20200506062223.30032-9-hch@lst.de>
In-Reply-To: <20200506062223.30032-9-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 May 2020 10:44:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3T6u_kj8r9f3aGXCjuyN210_gJC=AXPFm9=wL-dGALA@mail.gmail.com>
Message-ID: <CAHk-=wj3T6u_kj8r9f3aGXCjuyN210_gJC=AXPFm9=wL-dGALA@mail.gmail.com>
Subject: Re: [PATCH 08/15] maccess: rename strnlen_unsafe_user to strnlen_user_unsafe
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

On Tue, May 5, 2020 at 11:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This matches the convention of always having _unsafe as a suffix, as
> well as match the naming of strncpy_from_user_unsafe.

Hmm. While renaming them, can we perhaps clarify what the rules are?

We now have two different kinds of "unsafe". We have the
"unsafe_get_user()" kind of unsafe: the user pointer itself is unsafe
because it isn't checked, and you need to use a "user_access_begin()"
to verify.

It's the new form of "__get_user()".

And then we have the strncpy_from_user_unsafe(), which is really more
like the "probe_kernel_read()" kind of funtion, in that it's about the
context, and not faulting.

Honestly, I don't like the "unsafe" in the second case, because
there's nothing "unsafe" about the function. It's used in odd
contexts. I guess to some degree those are "unsafe" contexts, but I
think it might be better to clarify.

So while I think using a consistent convention is good, and it's true
that there is a difference in the convention between the two cases
("unsafe" at the beginning vs end), one of them is actually about the
safety and security of the operation (and we have automated logic
these days to verify it on x86), the other has nothing to do with
"safety", really.

Would it be better to standardize around a "probe_xyz()" naming?

Or perhaps a "xyz_nofault()" naming?

I'm not a huge fan of the "probe" naming, but it sure is descriptive,
which is a really good thing.

Another option would be to make it explicitly about _what_ is
"unsafe", ie that it's about not having a process context that can be
faulted in. But "xyz_unsafe_context()" is much too verbose.
"xyz_noctx()" might work.

I realize this is nit-picky, and I think the patch series as-is is
already an improvement, but I do think our naming in this area is
really quite bad.

The fact that we have "probe_kernel_read()" but then
"strncpy_from_user_unsafe()" for the _same_ conceptual difference
really tells me how inconsistent the naming for these kinds of "we
can't take page faults" is. No?

                   Linus
