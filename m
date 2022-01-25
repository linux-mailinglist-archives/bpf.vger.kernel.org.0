Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA4349BFC3
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 00:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiAYXyk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 18:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiAYXyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 18:54:38 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3698C06161C
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 15:54:38 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id r14so6079825qtt.5
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 15:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mi0Q8WQvhL64eujn43o9araRQ9PmZV6oTtIkZaqBYj0=;
        b=Pj23Ifpq3NXEUmdJWFASfN/tfOWg323SUwogg6VIXUgj5Wzr/NZHhnHEDUtaS0yqFL
         NVzF23imTw0GBMm4Bn4U306sZ8MrqfbOeFnBw2xNhqCSNpvnBPn23Une71DqKajKhU/Z
         wZunmuixgHbAq8TTLaJj3GZLgf8le8TLPXWt6wprE5ru0n15Kri8gSGu+rKQGxCzetlp
         oUFZyD4KU7BWVm07Jql2mgqpSLzGraf+xDlIcJOJEk83KfVTKG1NZ6JsY+SSP4Z3tif0
         FU/4YubKbvZpup4UYob6J1IA6cRLaHvv3lJS0G4TZmtz0x+pUDu3wthjfUFc+kr1lxGr
         81Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mi0Q8WQvhL64eujn43o9araRQ9PmZV6oTtIkZaqBYj0=;
        b=jmil0Ij32B/Wyn08fprSb7JCqYI9p0OC0/OlNxrbXY5ko4CW5nazsWChgcb848WvEZ
         KLOBqeAA+Q5BrTe7WwyOrgtFvYn+wWnrwgf2GvghDI7fWHSBmGCQcOSX7MgKubgfDCXb
         HxqLEo0EvK85WsXBjYETFRJ9mmioBQ9I7N1oJiYoEAj0FvTokysj7NhzhRvUDJwFZlkL
         IQETg6ikCDo37jxwDt8IJKRO6dI6mB89Dvfn97QfbrRTHDyLD5KBJXgk09kfygtqhf3w
         1cZjrBPnGcq65DAHqnXKJs6L6vU/3lgPUpMMvWnuB1XYzafLsTb4o7/RqhgOoiRYda2i
         Qv+Q==
X-Gm-Message-State: AOAM532bG5AvR+Qv9NA73AlfIptgjHJe1UiojU06Rc0+MWukAAL5wtvQ
        E4U66NeVxj+FjKTvdQPoUCfx+bA5x4dpEudo/wnaCA==
X-Google-Smtp-Source: ABdhPJwJCVoeaf/sSkHJaEYC6MJtl9CWc3DEmrcpIvdHHYy3jOVqdK+2CyJFrczBtduGqa7HhqsT36CE+rSvpeZmsTs=
X-Received: by 2002:ac8:5fd1:: with SMTP id k17mr3647351qta.566.1643154877635;
 Tue, 25 Jan 2022 15:54:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7gh=vO8m-_SVnwWwj7kv+EDeUPcuWFqebf2Zmi9T_oEAQ@mail.gmail.com>
 <CAPhsuW7F4KritXPXixoPSw4zbCsqpfZaYBuw5BgD+KKXaoeGxg@mail.gmail.com>
In-Reply-To: <CAPhsuW7F4KritXPXixoPSw4zbCsqpfZaYBuw5BgD+KKXaoeGxg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 25 Jan 2022 15:54:26 -0800
Message-ID: <CA+khW7jx_4K46gH+tyZZn9ApSYGMqYpxCm0ywmuWdSiogv7dqw@mail.gmail.com>
Subject: Re: [Question] How to reliably get BuildIDs from bpf prog
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Blake Jones <blakejones@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Namhyung Kim <namhyung@google.com>,
        Ian Rogers <irogers@google.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks Song for your suggestion.

On Mon, Jan 24, 2022 at 11:08 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 2:43 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Dear BPF experts,
> >
> > I'm working on collecting some kernel performance data using BPF
> > tracing prog. Our performance profiling team wants to associate the
> > data with user stack information. One of the requirements is to
> > reliably get BuildIDs from bpf_get_stackid() and other similar helpers
> > [1].
> >
> > As part of an early investigation, we found that there are a couple
> > issues that make bpf_get_stackid() much less reliable than we'd like
> > for our use:
> >
> > 1. The first page of many binaries (which contains the ELF headers and
> > thus the BuildID that we need) is often not in memory. The failure of
> > find_get_page() (called from build_id_parse()) is higher than we would
> > want.
>
> Our top use case of bpf_get_stack() is called from NMI, so there isn't
> much we can do. Maybe it is possible to improve it by changing the
> layout of the binary and the libraries? Specifically, if the text is
> also in the first page, it is likely to stay in memory?
>

We are seeing 30-40% of stack frames not able to get build ids due to
this. This is a place where we could improve the reliability of build
id.

There were a few proposals coming up when we found this issue. One of
them is to have userspace mlock the first page. This would be the
easiest fix, if it works. Another proposal from Ian Rogers (cc'ed) is
to embed build id in vma. This is an idea similar to [1], but it's
unclear (at least to me) where to store the string. I'm wondering if
we can introduce a sleepable version of bpf_get_stack() if it helps.
When a page is not present, sleepable bpf_get_stack() can bring in the
page.

[1] https://lwn.net/Articles/867818/

> > 2. When anonymous huge pages are used to hold some regions of process
> > text, build_id_parse() also fails to get a BuildID because
> > vma->vm_file is NULL.
>
> How did the text get in anonymous memory? I guess it is NOT from JIT?
> We had a hack to use transparent huge page for application text. The
> hack looks like:
>
> "At run time, the application creates an 8MB temporary buffer and the
> hot section of the executable memory is copied to it. The 8MB region in
> the executable memory is then converted to a huge page (by way of an
> mmap() to anonymous pages and an madvise() to create a huge page), the
> data is copied back to it, and it is made executable again using
> mprotect()."
>
> If your case is the same (or similar), it can probably be fixed with
> CONFIG_READ_ONLY_THP_FOR_FS, and modified user space.
>

In our use cases, we have text mapped to huge pages that are not
backed by files. vma->vm_file could be null or points some fake file.
This causes challenges for us on getting build id for these code text.

> Thanks,
> Song
