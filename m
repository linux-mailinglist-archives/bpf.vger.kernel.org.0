Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A813940B6F5
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhINSaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 14:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhINS35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 14:29:57 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDADEC061762;
        Tue, 14 Sep 2021 11:28:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i12so29652ybq.9;
        Tue, 14 Sep 2021 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEvqLv6X16yOCtJhNGxWIu7j2z7pZWFhkq1CXx8QZpo=;
        b=VpWu6WBS67S7wLv0QZPjBGeVZzES3Vnn/M1q4zgIzf+8dss2OYTsnoU1nSp6L18KeY
         KGz0lHhWUaKhEuFAjCB0sTWsu6akjP1CdOuLkAGiDSKamLeHATycmsJXyC9EMikXNSRj
         Nja9cY0P2mUfmyAqVTQUW1qNcDzhpl6heVU7W74yVbeGuESvZJtBShPCTMqfkVIrDVvC
         ZA1LDttPEFlo1HBc9mokHRDQCUAaUGegb85W907JaVSLpQm8w56M54CZiZYmcbxiuFah
         DqINzp844XK3ah9flnY7DmpFhpfX1xleZ1ue7zYQgqhBS4bA2PUSBjwmlfVcs7xG/s4y
         rmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEvqLv6X16yOCtJhNGxWIu7j2z7pZWFhkq1CXx8QZpo=;
        b=wa+M2BfubSb51Jp7h1feAZUGakLq/ya6mkwRIGLcHNNyO2ifCMHwYFXzkuJHjVF1c7
         x+7tIgFB8a3Nq6YMMiJm5ztrLVaX6YHtM8HPgmQjstJ0xxlFHDcAZikZpvQhm7be8p4V
         hdjTmvryrp2LBSchClcA6ViMQpngVkcxVtUKtrjiNL9IfPBr0zTvyfZaqjdsHG8rRsIA
         DVto5mcpY3iR/1fIE6qLfh+KdEiMBkV7NRJKZcydm6M1S9b8Fse6r9TAWW7aqV0ozDZ5
         kXMUe/8VdIuYKtm2/qNAPpRbQ9a06HAIFDhYK5J0Na2eWCyquoR1YYntTMmgTec7GVUg
         TnBA==
X-Gm-Message-State: AOAM53395/rqP4vQLYQMUtaY5ny9XhNH6VjGU2TVv5u63jW1H59OfhOL
        G90ApPaQMcpxf4zFf2m6dTOXCvpD4mnhgF8Xf77hTOuxC8g=
X-Google-Smtp-Source: ABdhPJzpyFYufZHv7YTg/3XhkJXpSZlJtLPUIC2cxPYa0nxWvWA4r6b3txGgTm0VS0fso6oLvH+mJVUQTl55C3x/ijY=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr684779ybb.267.1631644119056;
 Tue, 14 Sep 2021 11:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210914170004.4185659-1-andrii@kernel.org> <YUDoNX0eUndsPCu+@krava>
In-Reply-To: <YUDoNX0eUndsPCu+@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 11:28:28 -0700
Message-ID: <CAEf4BzbU8Ok-7Fsp1uGZ4F6b5GPb58fk1YKgnGwx9+sUBq71tA@mail.gmail.com>
Subject: Re: [PATCH perf] perf: ignore deprecation warning when using libbpf's btf__get_from_id()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 11:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Sep 14, 2021 at 10:00:04AM -0700, Andrii Nakryiko wrote:
> > Perf code re-implements libbpf's btf__load_from_kernel_by_id() API as
> > a weak function, presumably to dynamically link against old version of
> > libbpf shared library. Unfortunately this causes compilation warning
> > when perf is compiled against libbpf v0.6+.
> >
> > For now, just ignore deprecation warning, but there might be a better
> > solution, depending on perf's needs.
>
> HI,
> the problem we tried to solve is when perf is using symbols
> which are not yet available in released libbpf.. but it all
> linkes in default perf build because it's linked statically
> libbpf.a in the tree
>

If you are always statically linking libbpf into perf, there is no
need to implement this __weak shim. Libbpf is never going to deprecate
an API if a new/replacement API hasn't been at least in a previous
released version. So in this case btf__load_from_kernel_by_id() was
added in libbpf 0.5, and btf__get_from_id() was marked deprecated in
libbpf 0.6 (not yet released, of course). So with that, do you still
think we need this __weak re-implementation?

I was wondering if this was done to make latest perf code compile
against some old libbpf source code or dynamically linked against old
libbpf. But if that's not the case, the fix should be a removal of
__weak btf__load_from_kernel_by_id().

> so now we have weak function with that warning disabled locally,
> which I guess could work?  also for future cases like that
>
> jirka
>
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/perf/util/bpf-event.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index 683f6d63560e..1a7112a87736 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -24,7 +24,10 @@
> >  struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> >  {
> >         struct btf *btf;
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> >         int err = btf__get_from_id(id, &btf);
> > +#pragma GCC diagnostic pop
> >
> >         return err ? ERR_PTR(err) : btf;
> >  }
> > --
> > 2.30.2
> >
>
