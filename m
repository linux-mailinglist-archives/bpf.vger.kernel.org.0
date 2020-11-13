Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2042B24E2
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 20:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKMTq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 14:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgKMTq4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 14:46:56 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3E5C0617A7
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 11:46:55 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id p12so12189189ljc.9
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 11:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsABYu4fiHtPfsyj03E4PvSaOqgBaRQivbPyU1cy34A=;
        b=cMNc6fXdDKF/qTr3R323Nz73YQEzMHyOvf8fPTz8pwE791It5ltCdQRmumuyS1+HzL
         xFxPusKNldryA4c1IkUZnCMVZINvoXDY4zzgX8drrQfyYcx6nzLCRzrTI6tA8WQ8bVmo
         uMOboLvLcpDAG6eUsq773dhlTVXXZW1pFMtVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsABYu4fiHtPfsyj03E4PvSaOqgBaRQivbPyU1cy34A=;
        b=sxphgdJUISuVkeFwwuUjP/tmhyIQH3BawvyMDJKGiOy6AumHw1x6XM5Zj1NtMufy1R
         Anps2eVWmeZ6pBT3xnieaqqsMzuY2eK6Z2HQvUiaIV02X/UAhecKogN3yJqDv1/IMDFn
         Zz+V4WgUsOysNqFCC3TWpfaXc4zHEJ+mIKgeIIm0ixkifut2FJDrQnKKy/JHTkmT7KJz
         iF9XIP7a/uu2Mkdc+Am04BUljbcZy7/9/2ogy7BnYOzShj8xTjItc8l+9DdNqFVgrJbT
         fJi1jcgjrTmausq+9mu0YQgipzltoo2MtZdw5YEDH+l4EnkHjZBm4SDv8SROAD4oRzKO
         HMLA==
X-Gm-Message-State: AOAM531dJhf7BHgzABif5rj6yJNYyNzbRO+VgO66W0fyjQEGu9CCD7bN
        F+rAYB6vofqg5YnWar5Fe+0z1rF4HAva7A==
X-Google-Smtp-Source: ABdhPJyIs1IMgOmYfj4NwZ6E/W73zh2nMeHmzGsmELdThsa9+z4JSVVjytuU+qOwZfgkL/n+oiP4TQ==
X-Received: by 2002:a05:651c:cc:: with SMTP id 12mr1837216ljr.191.1605296813681;
        Fri, 13 Nov 2020 11:46:53 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id x11sm1658289lfe.96.2020.11.13.11.46.52
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:46:52 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id p12so12189024ljc.9
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 11:46:52 -0800 (PST)
X-Received: by 2002:a2e:a375:: with SMTP id i21mr1527056ljn.421.1605296811879;
 Fri, 13 Nov 2020 11:46:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz> <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp> <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
 <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
In-Reply-To: <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 11:46:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4EjAq=bN1aKUyfVR4xTM9K1QO-99+N0132V1DHs1XBQ@mail.gmail.com>
Message-ID: <CAHk-=wj4EjAq=bN1aKUyfVR4xTM9K1QO-99+N0132V1DHs1XBQ@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 11:17 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> The destination buffer was already initialized with zeros before the call.

Side note: this is another example of you using the interface incorrectly.

You should *not* initialize the buffer with zeroes. That's just extra
work. One of the points of the strncpy_from_user() interface is that
it is *not* the incredibly broken garbage that "strncpy()" is.

strncpy_from_user() returns the size of the resulting string,
*EXACTLY* so that people who care can then use that information
directly and efficiently.

Most of the time it's to avoid a strlen() on the result (and check for
overflow), of course, but the other use-case is exactly that "maybe I
need to pad out the result", so that you don't need to initialize the
buffer beforehand.

I'm not sure exactly which strncpy_from_user() user you have issues
with, but I did a

     git grep strncpy_from_user -- '*bpf*'

and several of them look quite questionable.

All of the ones in kernel/bpf/syscall.c seem to handle overflow
incorrectly, for example, with a silent truncation instead of error.
Maybe that's fine,  but it's questionable.

And the bpf_trace_copy_string() thing doesn't check the result at all,
so the end result may not be NUL-terminated. Maybe that's ok. I didn't
check the call chain.

              Linus
