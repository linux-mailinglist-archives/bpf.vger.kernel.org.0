Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B038F475
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhEXUhO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 16:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbhEXUhO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 16:37:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81213C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 13:35:44 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c20so28331589qkm.3
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3HUVPypsO5GIDe8+tguSTECPYWl3w+4jMCW6QoDHso=;
        b=GtLTAkkd6+TTXtSQ9Mw7i5qRNMwH5AbjBogaLZRjAx/WBdkPL08HdgQlLjAW5vtj/s
         vaIfmIiyxzY5huuXmBydaWNoM11Sv104Xd9LrPPhfFDiNKqPmcWDRAuh4Bv0DS9LffQW
         4dH9hezYvh9poCO5fiWA8Zph330wejsrjXO7+9nV7IkPj+1910wkS/X09ngsWwVZzH+q
         A16Yfy3X5vz1iRv5sRdroBNj1gOPd+vXWssUrG9gsBs+iQa0UbKrwGr6KDtYXz9YAvwA
         c6SHz5QW7myMhphVoPpR0JH0Vc3/MOF96L8FDhYbPjAU/uBk64n/XkrQ8MQ8LDOvms9l
         A0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3HUVPypsO5GIDe8+tguSTECPYWl3w+4jMCW6QoDHso=;
        b=KNjeP5uByB2NL4zqwWPUGJFtlVO6RG1OYwKnMbcjTJ52PnYPGeCnHOGr1pwInMWXdi
         5vST5XfgqP+rK9cMcWB10QjqAX5XfVhGa4gqnvfbZ/CoQRCP7XPnN/WVZVGQzx2xck/k
         QvZD8P1GjyYLtA/o4tF8Ns34KUhEOsv/KcHezQypYHHwT5pw6MvPeed75jycPn2/t9ZB
         cRk2tBKOotMrpGcnHLvx/mKtSt7bFepu3gzFfOjHZ7WMt8/FnpljieYrtEVAPygliSfY
         y5/TO+i1Lz/O/Frm8FfMW9VmqPBrzXjSszmyxqsWWbgHHxd4ijJy7nz/t56w++eZ4Egn
         gYQA==
X-Gm-Message-State: AOAM533c376DhozWH2lbqG5gbPWmb4dznibBjQDrFIfk8tFqqvIR00y+
        gAafX7qG/VOG/Hh4PclfVDqM/Uyi3vFgbY8kuuQgeA==
X-Google-Smtp-Source: ABdhPJypT8+OAPGiSPjiqNlC3XUOhcfKTeckvvI9VlZbYdwdmGp45pMN/9lPXcM5/u22GAjtdLRzMP2+hy9bgpalqb8=
X-Received: by 2002:a05:620a:e82:: with SMTP id w2mr29964587qkm.422.1621888543403;
 Mon, 24 May 2021 13:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210521234203.1283033-1-andrii@kernel.org> <60ab496e3e211_2a2cf208d2@john-XPS-13-9370.notmuch>
 <CAEf4BzY0=J1KP4txDSVJdS93YVLxO8LLQTn0UCJ0RKDL_XzpYw@mail.gmail.com>
In-Reply-To: <CAEf4BzY0=J1KP4txDSVJdS93YVLxO8LLQTn0UCJ0RKDL_XzpYw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 24 May 2021 13:35:32 -0700
Message-ID: <CAKH8qBtvhP6KqhPy+J6YktdcojsQJhjrz3SsD9ocKuiZ-+U9Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] libbpf: error reporting changes for v1.0
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 24, 2021 at 12:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, May 23, 2021 at 11:36 PM John Fastabend
> <john.fastabend@gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > Implement error reporting changes discussed in "Libbpf: the road to v1.0"
> > > ([0]) document.
> > >
> > > Libbpf gets a new API, libbpf_set_strict_mode() which accepts a set of flags
> > > that turn on a set of libbpf 1.0 changes, that might be potentially breaking.
> > > It's possible to opt-in into all current and future 1.0 features by specifying
> > > LIBBPF_STRICT_ALL flag.
> > >
> > > When some of the 1.0 "features" are requested, libbpf APIs might behave
> > > differently. In this patch set a first set of changes are implemented, all
> > > related to the way libbpf returns errors. See individual patches for details.
> > >
> > > Patch #1 adds a no-op libbpf_set_strict_mode() functionality to enable
> > > updating selftests.
> > >
> > > Patch #2 gets rid of all the bad code patterns that will break in libbpf 1.0
> > > (exact -1 comparison for low-level APIs, direct IS_ERR() macro usage to check
> > > pointer-returning APIs for error, etc). These changes make selftest work in
> > > both legacy and 1.0 libbpf modes. Selftests also opt-in into 100% libbpf 1.0
> > > mode to automatically gain all the subsequent changes, which will come in
> > > follow up patches.
> > >
> > > Patch #3 streamlines error reporting for low-level APIs wrapping bpf() syscall.
> > >
> > > Patch #4 streamlines errors for all the rest APIs.
> > >
> > > Patch #5 ensures that BPF skeletons propagate errors properly as well, as
> > > currently on error some APIs will return NULL with no way of checking exact
> > > error code.
> > >
> > >   [0] https://docs.google.com/document/d/1UyjTZuPFWiPFyKk1tV5an11_iaRuec6U-ZESZ54nNTY
> > >
> > > Andrii Nakryiko (5):
> > >   libbpf: add libbpf_set_strict_mode() API to turn on libbpf 1.0
> > >     behaviors
> > >   selftests/bpf: turn on libbpf 1.0 mode and fix all IS_ERR checks
> > >   libbpf: streamline error reporting for low-level APIs
> > >   libbpf: streamline error reporting for high-level APIs
> > >   bpftool: set errno on skeleton failures and propagate errors
> > >
> >
> > LGTM for the series,
> >
> > Acked-by: John Fastabend <john.fastabend@gmail.com>
>
> Thanks, John!
>
> Toke, Stanislav, you cared about these aspects of libbpf 1.0 (by
> commenting on the doc itself), do you mind also taking a brief look
> and letting me know if this works for your use cases? Thanks!

I took a quick look earlier today and everything looks good, thanks!
I'll try to enable strict mode in our codebase in the coming weeks to
see how it goes.
