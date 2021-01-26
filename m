Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA93046D7
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 19:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbhAZRTJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 12:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbhAZGKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 01:10:09 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E945C061786
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 22:07:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p21so16158330lfu.11
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 22:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCbMLWW5bVffrqr9um5oYecFlM1kbr4873eHTOb2t48=;
        b=PAN+lkXniUPYfDHH11kDGA73xk4k9o2VjzkUq5HpajDLtyhOajaMp6/cNvKUN1HU+o
         PlqrReYYQJh9XFtJb45NHmcMZ/WVSWMS5cfSOtWEAC5SnWq8rhRG/nOQebgNfNYAmwWs
         gsDfDUcx1AkYPrLc/rQsgD8SjJBpCUkUg5K17smIhaMIKAaMBFdysB4l/txEYY/mCl43
         Nj1KkQGNyGmuXhYTMvCahqmsdpp5QPxCxAA6IGEYuU/uqe2mSHjwgKIY+fD8BalveiIN
         5XjV/F9eauY/lT4XtbsF7uAPv9sGD5lUp1MEHJ0zVnS0d64pSxOhXV6yfQ/lo/4iTP9z
         qDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCbMLWW5bVffrqr9um5oYecFlM1kbr4873eHTOb2t48=;
        b=j+7eag3CP9+uZXCmBYSS/yM696+aKspw8BF0eKSe5IVQz+3MfbPkYEpZKFDtsx7TJE
         ZEeQeuKEnKbqai9KQihw/U6lqN+kUeBKXCqFW2fTy0Of+cMh6Dip4QG4mHBuUT+amTI4
         zpsIKVd2kCo8xv8x1f5uyc7rjGeyAUk9srxjE5BZKc3gRNyCRv1jysHTabGp4l6Am2fM
         JGyL0qM2RSLtARimH/Z5CuOIkhzPO7w9XeTNKH2K98kWpYmSuO1G//nHFs+OPNpRZXmk
         /DWwvljqOgoiLYeZuCApBLvyz8tsEyuOSzxho/QMMHNvGQClNf2Q4HdplnmdeTvjc0lL
         ZKWg==
X-Gm-Message-State: AOAM531BR/EyYjLiQvhSg3r48MmNs6Tgwxy+sN5piW0nqZ7G/3++XXEr
        Z2sa6j/YuXAXkntJJBzHtE6kE6Vrpc0TUPW2IW8ixw==
X-Google-Smtp-Source: ABdhPJyTKRyBk8XKzykbg5u2jKjrYFjDG7fe6dvuGWjSH15tC/W1Z3swZInyvNclf1S/ewZvoIv06IiKYi20LUeniik=
X-Received: by 2002:a19:c20b:: with SMTP id l11mr1813705lfc.47.1611641268394;
 Mon, 25 Jan 2021 22:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20210125154938.40504-1-quentin@isovalent.com>
In-Reply-To: <20210125154938.40504-1-quentin@isovalent.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 26 Jan 2021 14:07:36 +0800
Message-ID: <CABVgOSmr7xKAS-L+=fA9QnECv76bwLnTt_+kP6VnxSTmZ3Bx3A@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix build for BPF preload when $(O) points to a
 relative path
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 11:49 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Building the kernel with CONFIG_BPF_PRELOAD, and by providing a relative
> path for the output directory, may fail with the following error:
>
>   $ make O=build bindeb-pkg
>   ...
>   /.../linux/tools/scripts/Makefile.include:5: *** O=build does not exist.  Stop.
>   make[7]: *** [/.../linux/kernel/bpf/preload/Makefile:9: kernel/bpf/preload/libbpf.a] Error 2
>   make[6]: *** [/.../linux/scripts/Makefile.build:500: kernel/bpf/preload] Error 2
>   make[5]: *** [/.../linux/scripts/Makefile.build:500: kernel/bpf] Error 2
>   make[4]: *** [/.../linux/Makefile:1799: kernel] Error 2
>   make[4]: *** Waiting for unfinished jobs....
>
> In the case above, for the "bindeb-pkg" target, the error is produced by
> the "dummy" check in Makefile.include, called from libbpf's Makefile.
> This check changes directory to $(PWD) before checking for the existence
> of $(O). But at this step we have $(PWD) pointing to "/.../linux/build",
> and $(O) pointing to "build". So the Makefile.include tries in fact to
> assert the existence of a directory named "/.../linux/build/build",
> which does not exist.
>
> By contrast, other tools called from the main Linux Makefile get the
> variable set to $(abspath $(objtree)), where $(objtree) is ".". We can
> update the Makefile for kernel/bpf/preload to set $(O) to the same
> value, to permit compiling with a relative path for output. Note that
> apart from the Makefile.include, the variable $(O) is not used in
> libbpf's build system.
>
> Note that the error does not occur for all make targets and
> architectures combinations.
>
> - On x86, "make O=build vmlinux" appears to work fine.
>   $(PWD) points to "/.../linux/tools", but $(O) points to the absolute
>   path "/.../linux/build" and the test succeeds.
> - On UML, it has been reported to fail with a message similar to the
>   above (see [0]).
> - On x86, "make O=build bindeb-pkg" fails, as described above.
>
> It is unsure where the different values for $(O) and $(PWD) come from
> (likely some recursive make with different arguments at some point), and
> because several targets are broken, it feels safer to fix the $(O) value
> passed to libbpf rather than to hunt down all changes to the variable.
>
> David Gow previously posted a slightly different version of this patch
> as a RFC [0], two months ago or so.
>
> [0] https://lore.kernel.org/bpf/20201119085022.3606135-1-davidgow@google.com/t/#u
>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Reported-by: David Gow <davidgow@google.com>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---

Thanks for following up on this. I've tested it against my usecase
(allyesconfig with ARCH=um), and it fixes the issue nicely.

Tested-by: David Gow <davidgow@google.com>

While I tend to agree it'd be nicer to track down the place $(O) and
$(PWD) are broken, too, given that there seem to be a number of
different ways to trigger this (bindeb-pkg and ARCH=um), I'm not sure
there's only one breakage to find.

Cheers,
-- David
