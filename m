Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5EC28AE79
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 08:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgJLGqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgJLGqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 02:46:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FAC0613D0
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2020 23:46:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l16so15745311eds.3
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2020 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oV/+pj7Fnm5nZaRHqpOkjT78UAULW7d63AGoeM3lX8=;
        b=TeTWSCEsBYqyE/x1ZaeOkH0jWJEzqZ7ade7Tm1kFTgH31HzCcN0hNCHh62tJU51HXo
         oT1/7SjvVBjHHxKmo/6ioy411q0Lew2Z791SIXZMxKBXgleoTXwKqXOyNNnLsGMHo9d0
         +cTV7LNmhJPh1s7mUi2rqebsCXVI4yUVkSL/drzsPeODDm3sQVnnb5dbXYyhw3hhx/wm
         iS3jYetCXUTdyqg4zYSARhPFq28CXyB+zKkODklGDX6GJO4KkCIAFinOTcE+cmXsNi6Q
         4vs8+0YDkbjqMfOplYJWskfn3CRqo227oSBgHHSaMH6yj8m+JXb+qAeT40KP8PiAX0mW
         HpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oV/+pj7Fnm5nZaRHqpOkjT78UAULW7d63AGoeM3lX8=;
        b=hC9OZHLxcBNN//h5NeozLwQ6IV5yHNI4w3JJcz2k4DTDMJOpH/MSpOQhZH3btQUMCm
         yxmYZa1jz5keNbFlEBSgr9zK4x8+grhPljWW786sLhoXDGxcd2n0PnoV0gL/c3jMB89c
         JoVFRGHhDiZZCADAJGRQywo4fAtGzSRU88tG86OLpyofeenbuwG/JSPgfYrs2dO2A6W0
         luv0+8RiGzFbEOawX+heG9plebJSyB2KcS/sxQ5JBUJ1bQtSsR0Hkucnc1j6AVo4hcZC
         iqoAuHBNOjXU5dUUfu7hsvthpg0VQ2GEeGtwiQp35quRrB9CjgFyNQ3wgWKVbAxgXOMd
         A3Pg==
X-Gm-Message-State: AOAM5302HSUupfdPuakTU/sDFH6+HgW5Ed+E9ZWkaZxUHXetS/o6Fqhv
        pYIddw5WwcGwO1Tx2yCUHILKwPLMU+Eu2l0m4aE3QA==
X-Google-Smtp-Source: ABdhPJwAYFpyF8+D8cV7oXd3QE1aJOiN6i4bqWNX+WYEUPOZPTqnJ6SQkcBzssolp/os/9ZENLm83qg/oBxbASgSqn4=
X-Received: by 2002:aa7:d349:: with SMTP id m9mr12421814edr.51.1602485201449;
 Sun, 11 Oct 2020 23:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602431034.git.yifeifz2@illinois.edu> <71c7be2db5ee08905f41c3be5c1ad6e2601ce88f.1602431034.git.yifeifz2@illinois.edu>
In-Reply-To: <71c7be2db5ee08905f41c3be5c1ad6e2601ce88f.1602431034.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 12 Oct 2020 08:46:15 +0200
Message-ID: <CAG48ez0waTA3+Bs9UWx4HSx3Pktq-6K-z67hmcTV0Fr-NYGdMw@mail.gmail.com>
Subject: Re: [PATCH v5 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 11, 2020 at 5:48 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> SECCOMP_CACHE will only operate on syscalls that do not access
> any syscall arguments or instruction pointer. To facilitate
> this we need a static analyser to know whether a filter will
> return allow regardless of syscall arguments for a given
> architecture number / syscall number pair. This is implemented
> here with a pseudo-emulator, and stored in a per-filter bitmap.
>
> In order to build this bitmap at filter attach time, each filter is
> emulated for every syscall (under each possible architecture), and
> checked for any accesses of struct seccomp_data that are not the "arch"
> nor "nr" (syscall) members. If only "arch" and "nr" are examined, and
> the program returns allow, then we can be sure that the filter must
> return allow independent from syscall arguments.
>
> Nearly all seccomp filters are built from these cBPF instructions:
>
> BPF_LD  | BPF_W    | BPF_ABS
> BPF_JMP | BPF_JEQ  | BPF_K
> BPF_JMP | BPF_JGE  | BPF_K
> BPF_JMP | BPF_JGT  | BPF_K
> BPF_JMP | BPF_JSET | BPF_K
> BPF_JMP | BPF_JA
> BPF_RET | BPF_K
> BPF_ALU | BPF_AND  | BPF_K
>
> Each of these instructions are emulated. Any weirdness or loading
> from a syscall argument will cause the emulator to bail.
>
> The emulation is also halted if it reaches a return. In that case,
> if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.
>
> Emulator structure and comments are from Kees [1] and Jann [2].
>
> Emulation is done at attach time. If a filter depends on more
> filters, and if the dependee does not guarantee to allow the
> syscall, then we skip the emulation of this syscall.
>
> [1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
> [2] https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
>
> Suggested-by: Jann Horn <jannh@google.com>
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

Reviewed-by: Jann Horn <jannh@google.com>
