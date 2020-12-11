Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC81F2D7811
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgLKOlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 09:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390595AbgLKOlX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 09:41:23 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B193AC0613D3
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 06:40:42 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id 2so8974853ilg.9
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 06:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1h5XSPlxBUAGIpDD6oUcqWJAS8gNOKHKgcM+M6tRgfA=;
        b=daMZ90XZ7NG9OuBhNiKSIaPPKcnzqc9MvC3Id1B4HJXdiIHI9KemCaJ0p3X8Qh05TG
         FXFS0Da7TeaP8i2IrkytZR86/ZlzVPRT0yNtqmcNv6EADPQBCc/WWX+gzaRdgcj6Dice
         Y2+dal9jJKpRBuGcmVDkwb1XNu2ZYyHFuk1VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1h5XSPlxBUAGIpDD6oUcqWJAS8gNOKHKgcM+M6tRgfA=;
        b=nNy6Lx5H03Eegr6xie1rTeT6iuviu+w7cR7SqqKGMCiChDtcnb9e98Y1SMiDRrh4e7
         M+eeAew5ZAiyl4BWA9oAyVb5YwrNyFRlnEdMXQ/ypW3gCpe3XnDqKC8EGOvltUiOeihR
         nL6cNyoCi9uioKVHZMW0KC0wVc2FsH2Sx241znwTzNnq3w33hIBaOyPLpcbcmoEk27in
         XlFuK1D+DYZBVxLKAkuilIDbabzexfF7OynzPM6xvCm5l07fjQm4xOLAcZ9gClUri5rK
         hU3vN1ayZCjawhXfEug9J7eJEoNCau1JQRLUbfYTGUsYu1rQb6DoGZV/53thFOlez7M9
         0MWw==
X-Gm-Message-State: AOAM532UWfpkf0y4ZgYu+7Y5fepob1hegpkZfPT+ZxONjEGR1E7OsWTR
        kBLntiQwHxiBwX0LXJ/j3zoZP4auJxMxTN/9oZUUWQ==
X-Google-Smtp-Source: ABdhPJxMxAwoDrQ6WmfAUhMT6vbLfOVSSwnGLmm7h16NDjK3Yp28r0rrGoHwWnJ2Hpc52fwYKDGABrMegdr0d2OIh9g=
X-Received: by 2002:a92:4c3:: with SMTP id 186mr16661316ile.177.1607697642071;
 Fri, 11 Dec 2020 06:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com> <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org> <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
In-Reply-To: <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 11 Dec 2020 15:40:31 +0100
Message-ID: <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> I still think that adopting printk/vsnprintf for this instead of
> reinventing the wheel
> is more flexible and easier to maintain long term.
> Almost the same layout can be done with vsnprintf
> with exception of \0 char.
> More meaningful names, etc.
> See Documentation/core-api/printk-formats.rst

I agree this would be nice. I finally got a bit of time to experiment
with this and I noticed a few things:

First of all, because helpers only have 5 arguments, if we use two for
the output buffer and its size and two for the format string and its
size, we are only left with one argument for a modifier. This is still
enough for our usecase (where we'd only use "%ps" for example) but it
does not strictly-speaking allow for the same layout that Andrii
proposed.

> If we force fmt to come from readonly map then bpf_trace_printk()-like
> run-time check of fmt string can be moved into load time check
> and performance won't suffer.

Regarding this bit, I have the impression that this would not be
possible, but maybe I'm missing something ? :)

The iteration that bpf_trace_printk does over the format string
argument is not only used for validation. It is also used to remember
what extra operations need to be done based on the modifier types. For
example, it remembers whether an arg should be interpreted as 32bits or
64bits. In the case of string printing, it also remembers whether it is
a kernel-space or user-space pointer so that bpf_trace_copy_string can
be called with the right arg. If we were to run the iteration over the format
string in the verifier, how would you recommend that we
"remember" the modifier type until the helper gets called ?
