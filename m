Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22B72D20B6
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 03:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLHCUE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 21:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgLHCUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 21:20:04 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7FEC061749;
        Mon,  7 Dec 2020 18:19:24 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id r127so14765351yba.10;
        Mon, 07 Dec 2020 18:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3e5yK6qRaJSts87vr4iK+gogcjS5ZNykHJ/giIrEtNo=;
        b=JerUqYVWOu2O7kPpeTO+IvwVCdjr7P6wLGRCrIt1JJ1d6iAReD8EDq3NH7MSIs2ySi
         /MYDCAC+/SHl181jQ0097cb+z0iB8gLnRvS20/ArRfF3pD/JoQ6T3MEVEtr5hQOmbHqV
         cNRjXGz/IwdHoHFqeNaChqlEz8/3LKjygf6XbiDqAyAmit3uI/4yhrMUvjluCBK782Ma
         YuF9xdTZsEJKW/MsjopsRhsE15nw/intfObdxInLtsJgA0spzFTIiZa0WlypMXvrtFtu
         1ULLNtArSk9t3nRdVQp6KEsuX2qa78hH4aLF/jRUotRPRFsktg+vosbA/1JXjbcDdXe9
         lI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3e5yK6qRaJSts87vr4iK+gogcjS5ZNykHJ/giIrEtNo=;
        b=SuKB/JbRrpSYdOfSVeXxvD7W/5nLv1FqZdsyneKE/RwNALa4CBwVJ67hL87XOglIhK
         fX4k8frAyIO0QauYIW1t0RXZeJu3eBfY8zgfOsRFNyXc9VVKBGN5WBvI9lx2hUqVvgRe
         +/FwS9/VzWeLnDTbo1DOSv8lqU5Q2+2bBiJ7OcNd+s8RzMudc246sQ8+09cr3Q86ncGw
         /Pw4HxsrSy/5QLJGrijd2AFmirAzpAaTdfllY5pG2sITbPL+4Q96RKaG4yrI6ERuFiIH
         FObu0RbwqE9w+i5XD3XSjl0rk83hHfP1ge4s5dw2fJWu4bqkDGhbtIIjXs/fWZifZQ/x
         s6kA==
X-Gm-Message-State: AOAM532ZNTfzX5VF0TNHda03eNL6TvucheBM63uBTDylfx7LH4m24ZZK
        8/7kn492UYkc++ffXQNlLzkgP/EUOAc+7uhnIXk=
X-Google-Smtp-Source: ABdhPJyncWwteByh29hl2Y7yQYcwAPlMmJncRXGd8NWQMXIcujJHZUTJwuHSGpoxDAKxgfAyhkbMIcz38bHIhJCdY9M=
X-Received: by 2002:a25:d6d0:: with SMTP id n199mr10005932ybg.27.1607393963407;
 Mon, 07 Dec 2020 18:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com> <20201203160245.1014867-13-jackmanb@google.com>
 <CAEf4BzbEfPScq_qMVJkDxfWBh-oRhY5phFr=517pam80YcpgMg@mail.gmail.com>
 <X8oEOPViOhR8XdH6@google.com> <CAEf4BzaEystdQ3PbaZXhmpTfqbs410BVCEToHfKLgx-3wAm-KA@mail.gmail.com>
 <X84LPVp3PqfESx9U@google.com>
In-Reply-To: <X84LPVp3PqfESx9U@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Dec 2020 18:19:12 -0800
Message-ID: <CAEf4BzbQyyN620oOaK4Tc=0tju0-NuOQYESCrsOLPAmBjRD9Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/14] bpf: Pull tools/build/feature biz into
 selftests Makefile
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 3:00 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Fri, Dec 04, 2020 at 11:00:24AM -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 4, 2020 at 1:41 AM Brendan Jackman <jackmanb@google.com> wrote:
> > >
> > > On Thu, Dec 03, 2020 at 01:01:27PM -0800, Andrii Nakryiko wrote:
> > > > On Thu, Dec 3, 2020 at 8:07 AM Brendan Jackman <jackmanb@google.com> wrote:
> > > > >
> > > > > This is somewhat cargo-culted from the libbpf build. It will be used
> > > > > in a subsequent patch to query for Clang BPF atomics support.
> > > > >
> > > > > Change-Id: I9318a1702170eb752acced35acbb33f45126c44c
> > > >
> > > > Haven't seen this before. What's this Change-Id business?
> > >
> > > Argh, apologies. Looks like it's time for me to adopt a less error-prone
> > > workflow for sending patches.
> > >
> > > (This is noise from Gerrit, which we sometimes use for internal reviews)
> > >
> > > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/.gitignore |  1 +
> > > > >  tools/testing/selftests/bpf/Makefile   | 38 ++++++++++++++++++++++++++
> > > > >  2 files changed, 39 insertions(+)
> > > >
> > > > All this just to detect the support for clang atomics?... Let's not
> > > > pull in the entire feature-detection framework unnecessarily,
> > > > selftests Makefile is complicated enough without that.
> > >
> > > Then the test build would break for people who haven't updated Clang.
> > > Is that acceptable?
> > >
> > > I'm aware of cases where you need to be on a pretty fresh Clang for
> > > tests to _pass_ so maybe it's fine.
> >
> > I didn't mean to drop any detection of this new feature. I just didn't
> > want a new dependency on tools' feature probing framework. See
> > IS_LITTLE_ENDIAN and get_sys_includes, we already have various feature
> > detection-like stuff in there. So we can do this with a one-liner. I
> > just want to keep it simple. Thanks.
>
> Ah right gotcha. Then yeah I think we can do this:
>
>  BPF_ATOMICS_SUPPORTED = $(shell \
>         echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
>         | $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)

Looks like it would work, yes. Curious what "-x cpp-output" does?
