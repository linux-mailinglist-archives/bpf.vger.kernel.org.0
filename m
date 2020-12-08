Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F90E2D3234
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 19:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgLHSc1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbgLHSc1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 13:32:27 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43BDC061749;
        Tue,  8 Dec 2020 10:31:46 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id k78so8078541ybf.12;
        Tue, 08 Dec 2020 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yv0AU/YcsITiXZw1huIkAWkR6xhRqThVIfqOGzqf/JQ=;
        b=CBXqKAqyoMu38WmYGr1Y8k3JfN0eKpaU4LePiRbwo+sA5ZJdjF48VLNM9Xxf5E6ZQo
         XXNIIx0a2K453Z3vpLxvRlBOMRlO2y8G6FPzDpU0AQcDkrS7P2CWbCsbn+Cb485uNck8
         r/xPi3+V6Tjj12uUCV+yaU5qvRvsl/v6AHY9Ml/gpOkSH67Irrsyw8BZF3/nT+W9C590
         zfwWrxoNy44WhFqI7FiGpdOSuIOBr59/ervp4+u/KbnvExcquZbKKT9R1hbDa13WHoWp
         /7yuwcO1LVxlhT2aDHQ0tdSX07J/IxQGRlXjb8BEiAziJtkWYOVvlJqAkpArCBuvSeDu
         Eb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yv0AU/YcsITiXZw1huIkAWkR6xhRqThVIfqOGzqf/JQ=;
        b=Bu5lT6qIwf5PX2A5vR1j1sLU2ebDiFj63LPJltPZD3JV9Lp0iZ6+etWi5t010xhlzh
         1ruuxhl5Wg7EjolzURqHuEv4rgx9BLSYLvxrRCqtSZmeyDPOim/Tz+1KaxES3MpHvfoG
         dyxGgSOzZPFDZ+tG183lj3lalJ1cIORgwBsJLB3ykQHacZUW7y2QULsGhLA3MCLLwVf1
         zwwVuIl25XVn3+T3dIll/0eLdg+Oxgmpdseft1SzPrHOSsK8ZI15trV0JRs3GxFj9DD5
         biFvMdZT/fE+bs0cEOXbKbZUNQDx4H+Xy9vxW43OI6CBaQFIVp+WO7Fs+c6YxF8nHoI1
         +yNg==
X-Gm-Message-State: AOAM5318A5mtzjEJYXOaKxkFwb733fjCAgrJbisj/79MP2AjZktvnoO8
        +Y5X2Kh9cJ2ZRDcZJajAjQg+Y9QTrFJvp+4ocGTOl3KfOuI=
X-Google-Smtp-Source: ABdhPJz4kLQkZYPvmUQyiTHbtl8m5yefRpAQ2bYH7VLaeBMHmO5pq3UIpM1gEU8h0Yb/QfFCwgS0Y52HXP3PIQpe61s=
X-Received: by 2002:a25:aea8:: with SMTP id b40mr13150562ybj.347.1607452306014;
 Tue, 08 Dec 2020 10:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com> <20201203160245.1014867-13-jackmanb@google.com>
 <CAEf4BzbEfPScq_qMVJkDxfWBh-oRhY5phFr=517pam80YcpgMg@mail.gmail.com>
 <X8oEOPViOhR8XdH6@google.com> <CAEf4BzaEystdQ3PbaZXhmpTfqbs410BVCEToHfKLgx-3wAm-KA@mail.gmail.com>
 <X84LPVp3PqfESx9U@google.com> <CAEf4BzbQyyN620oOaK4Tc=0tju0-NuOQYESCrsOLPAmBjRD9Zw@mail.gmail.com>
 <X8+yHRxv2g7dXeNP@google.com>
In-Reply-To: <X8+yHRxv2g7dXeNP@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Dec 2020 10:31:35 -0800
Message-ID: <CAEf4BzYhCmahyXbG3mXgfGuSD8T3gvkXXYToTwAuG17MDZwwKQ@mail.gmail.com>
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

On Tue, Dec 8, 2020 at 9:04 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Mon, Dec 07, 2020 at 06:19:12PM -0800, Andrii Nakryiko wrote:
> > On Mon, Dec 7, 2020 at 3:00 AM Brendan Jackman <jackmanb@google.com> wrote:
> > >
> > > On Fri, Dec 04, 2020 at 11:00:24AM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Dec 4, 2020 at 1:41 AM Brendan Jackman <jackmanb@google.com> wrote:
> > > > >
> > > > > On Thu, Dec 03, 2020 at 01:01:27PM -0800, Andrii Nakryiko wrote:
> > > > > > On Thu, Dec 3, 2020 at 8:07 AM Brendan Jackman <jackmanb@google.com> wrote:
> > > > > > >
> [...]
> > >
> > > Ah right gotcha. Then yeah I think we can do this:
> > >
> > >  BPF_ATOMICS_SUPPORTED = $(shell \
> > >         echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
> > >         | $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
> >
> > Looks like it would work, yes.
> /
> > Curious what "-x cpp-output" does?
>
> That's just to tell Clang what language to expect, since it can't infer
> it from a file extension:
>
>   $ echo foo | clang -S -
>   clang-10: error: -E or -x required when input is from standard input
>
> Yonghong pointed out that we can actually just use `-x c`.

yeah, that's what confused me, as we don't really write C++ for BPF
code :) All good.
