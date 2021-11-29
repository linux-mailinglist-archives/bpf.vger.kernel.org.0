Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BDC4627EB
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 00:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhK2XPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 18:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbhK2XPW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 18:15:22 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE3C093B4A
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:49:01 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id f186so46736820ybg.2
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMeOjq3uZFbMCrZ/IY5jlFIGJmkOFlXN4wha0+gpr58=;
        b=h5OglxqRQ5xbETaJG4du+E/hwc1eG0KqW3WqJcehdO9ZyLM5vgKBMM3BAbdJC8iT4B
         WgxbMCif1DrYhllrtWAH9GEYhOOsiJHcP6mlrlyFwPfpbeosco9fV7SYlVdPIDZPtB6s
         ilhRrW73gGLNLOI3LI0Vjd5KaR7l8i55r0Adbv3xbA3HgizOeNK0k6ngjbWgD0V9U3hr
         zcrG0nacBBAfLPJ2feiOMl+TdwPerqQJf+Jb0Rqak794QgE3IGZOndaM8xzczV728tZV
         ebvLFStCq4sAJfEJarLEjnIIqayCGdgiPxDPwHyNjxLw5/L7DFSQIZa5ZJ8+UsJUe40N
         bdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMeOjq3uZFbMCrZ/IY5jlFIGJmkOFlXN4wha0+gpr58=;
        b=tHC2h/5aHIQTue56SGyIwsi7WffKlX7Hot0pp7BXvnYVSeDLSaweTw656ZcO/i4aMz
         s4V8amI9Gg73PTGmeOpXm3IFVj2cA7n2YvpxcKvTaobDCo+8te7jeKqPZEbivEQgKZIg
         5qCPF8Nmt/fAcDyhK8zqC8zXulBfpFAFVBOcmmrky84FfFLJsHinLRHWTmGf4aonXGH5
         wk4uAh1bzr27XxQQ+wQlk5Ptya0whiulDXost/H0zUT0nMDU7eWT7FdmnM5v/oWWFaYL
         /oqA82/IGNhE/jja1OwJhgSb4OzSTvBbngCQ7K4EhDgnApNMfQmr5Vhwlh5nfhBsK25M
         FIJg==
X-Gm-Message-State: AOAM531ANnTi4x0j330uFYqvb0kZjSe+Xm2Ab7NOgs5KSgA+PGDBf7M9
        Eg7PKXY7S12ux8dhMPNxGYI00vbslDvSyuZR9cs=
X-Google-Smtp-Source: ABdhPJzW3svQTl4ZRZz5GxFWu7nr7Z0/PnnAUXXcdNRXKvEiEy5B03/k4RGXV/WSFQmQ1raOlMO2fV1IvgbD0HsPuco=
X-Received: by 2002:a25:e617:: with SMTP id d23mr9417881ybh.555.1638226140815;
 Mon, 29 Nov 2021 14:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20211129223725.2770730-1-joannekoong@fb.com> <20211129223725.2770730-2-joannekoong@fb.com>
In-Reply-To: <20211129223725.2770730-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 14:48:49 -0800
Message-ID: <CAEf4BzbUireNxV4Dcv4ZTz7YbZ7B3RHjNjTo-Y2sfBEohmBQbg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: Add bpf_loop helper
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 2:39 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the kernel-side and API changes for a new helper
> function, bpf_loop:
>
> long bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx,
> u64 flags);
>
> where long (*callback_fn)(u32 index, void *ctx);
>
> bpf_loop invokes the "callback_fn" **nr_loops** times or until the
> callback_fn returns 1. The callback_fn can only return 0 or 1, and
> this is enforced by the verifier. The callback_fn index is zero-indexed.
>
> A few things to please note:
> ~ The "u64 flags" parameter is currently unused but is included in
> case a future use case for it arises.
> ~ In the kernel-side implementation of bpf_loop (kernel/bpf/bpf_iter.c),
> bpf_callback_t is used as the callback function cast.
> ~ A program can have nested bpf_loop calls but the program must
> still adhere to the verifier constraint of its stack depth (the stack depth
> cannot exceed MAX_BPF_STACK))
> ~ Recursive callback_fns do not pass the verifier, due to the call stack
> for these being too deep.
> ~ The next patch will include the tests and benchmark
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 25 ++++++++++
>  kernel/bpf/bpf_iter.c          | 35 ++++++++++++++
>  kernel/bpf/helpers.c           |  2 +
>  kernel/bpf/verifier.c          | 88 +++++++++++++++++++++-------------
>  tools/include/uapi/linux/bpf.h | 25 ++++++++++
>  6 files changed, 142 insertions(+), 34 deletions(-)
>

[...]
