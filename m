Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0B413DDD
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 01:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhIUXMj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhIUXMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 19:12:39 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76777C061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:11:10 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f22so3159882qkm.5
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBAtyYXvQl3dEZfQAN86obyi/fpO3g14Vy4MTm82m1o=;
        b=q4JtRxy6pbWisz3JyW0L36rpuNgs77gzzrA3YbwhAX5z8WtKQNXc4IT8SCT22Yd+6q
         SLomjkBdkZ8oqDPEegDkjy8zE3NB4QNM0sZJ6H+3yAcZX1RNs/VmE3uE0pVO0jvtJXMO
         hmY4ydFahFBvqbuBmJUt31mrxbrMYkqCBbx9jtyflaNAT3ilLR4uxHmGVKn9SYzN+CrY
         FhAEdKEdpS6rUh2BHW/Qm/PSGvTCsN7s1pZd3CH8l6OOTadDcMdikX24ihJz8bqtfOG5
         xxclGNVEPGZUaQ19ArT3jV9pVSNuEnigDrFv4s6emjl7BdH+JyHTOCnkIqNA71D9nWR3
         UCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBAtyYXvQl3dEZfQAN86obyi/fpO3g14Vy4MTm82m1o=;
        b=7g940EIgROoDmtpd0ya1Hlx9IhX2Gbem5wf7xUJZJ7bXwMIblrxHrEGtQRiBpza3ys
         4xgpnS/40GKrw6WllYYGTureDPwPRe/ZXF2UyBpoZAkEDIb4XHFSU1cNDnx2E3p1HoXu
         dV2MU+XNLmVTQqGn9Ag1wVhkPfAsgY3LInFZ1K64jNJoVNpFKhFoUp3+vR0OcGKMpzTe
         XJcPLfzMX9yfexMBIWNs/4QWPvPq0AEJz416fRc5aZ6WETnzpB8EClvpMVezzH+xiRCy
         r4c//uR+BeaSLjVCSe/QDtB3OwEA5399cuPVSgIAnf7ZK7YK+RlpPTtMbe+M7srowaqm
         TlYg==
X-Gm-Message-State: AOAM532PnjtvURZKw4I7c+QuKb9PTy3A4ONGdtCUoHRWOLLzMe1SSXhk
        Tcrtx5XieX+EZIYELWN7g0Me7gEg/xOsh17EM00=
X-Google-Smtp-Source: ABdhPJxyumEHFFhjUQvzY1w6DrOAKrvXRva5YBMYuKUdxqxB8DuLVt9HVjqQ/7+tWtKsN3sthj8FpeJkxBnoKUrZH+4=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr40925712ybb.267.1632265869669;
 Tue, 21 Sep 2021 16:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210920234320.3312820-1-andrii@kernel.org> <20210920234320.3312820-3-andrii@kernel.org>
 <f89e5325-0096-6239-98bf-0da6a489e3fd@fb.com>
In-Reply-To: <f89e5325-0096-6239-98bf-0da6a489e3fd@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 16:10:58 -0700
Message-ID: <CAEf4BzZZXZuHWqYpVRzPa8OPDMe50gmnM8c2kmshg7DCqw-MrQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/9] selftests/bpf: normalize
 SEC("classifier") usage
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 20, 2021 at 10:21 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/20/21 7:43 PM, Andrii Nakryiko wrote:
> > Convert all SEC("classifier*") uses to strict SEC("classifier") with no
> > extra characters. In reference_tracking selftests also drop the usage of
> > broken bpf_program__load(). Along the way switch from ambiguous searching by
> > program title (section name) to non-ambiguous searching by name in some
> > selftests, getting closer to completely removing
> > bpf_object__find_program_by_title().
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Looks like you feel similarly about the SEC("version") comment from patch 1.
>
> >  .../bpf/prog_tests/reference_tracking.c       | 22 ++++---
> >  .../selftests/bpf/prog_tests/sk_assign.c      |  2 +-
> >  .../selftests/bpf/prog_tests/tailcalls.c      | 58 +++++++++----------
> >  .../testing/selftests/bpf/progs/skb_pkt_end.c |  2 +-
> >  tools/testing/selftests/bpf/progs/tailcall1.c |  5 +-
> >  tools/testing/selftests/bpf/progs/tailcall2.c | 21 ++++---
> >  tools/testing/selftests/bpf/progs/tailcall3.c |  5 +-
> >  tools/testing/selftests/bpf/progs/tailcall4.c |  5 +-
> >  tools/testing/selftests/bpf/progs/tailcall5.c |  5 +-
> >  tools/testing/selftests/bpf/progs/tailcall6.c |  4 +-
> >  .../selftests/bpf/progs/tailcall_bpf2bpf1.c   |  5 +-
> >  .../selftests/bpf/progs/tailcall_bpf2bpf2.c   |  5 +-
> >  .../selftests/bpf/progs/tailcall_bpf2bpf3.c   |  9 ++-
> >  .../selftests/bpf/progs/tailcall_bpf2bpf4.c   | 13 ++---
> >  .../bpf/progs/test_btf_skc_cls_ingress.c      |  2 +-
> >  .../selftests/bpf/progs/test_cls_redirect.c   |  2 +-
> >  .../selftests/bpf/progs/test_global_data.c    |  2 +-
> >  .../selftests/bpf/progs/test_global_func1.c   |  2 +-
> >  .../selftests/bpf/progs/test_global_func3.c   |  2 +-
> >  .../selftests/bpf/progs/test_global_func5.c   |  2 +-
> >  .../selftests/bpf/progs/test_global_func6.c   |  2 +-
> >  .../selftests/bpf/progs/test_global_func7.c   |  2 +-
> >  .../selftests/bpf/progs/test_pkt_access.c     |  2 +-
> >  .../selftests/bpf/progs/test_pkt_md_access.c  |  4 +-
> >  .../selftests/bpf/progs/test_sk_assign.c      |  3 +-
> >  .../selftests/bpf/progs/test_sk_lookup_kern.c | 37 ++++++------
> >  .../selftests/bpf/progs/test_skb_helpers.c    |  2 +-
> >  .../selftests/bpf/progs/test_sockmap_update.c |  2 +-
> >  .../selftests/bpf/progs/test_tc_neigh.c       |  6 +-
> >  .../selftests/bpf/progs/test_tc_neigh_fib.c   |  6 +-
> >  .../selftests/bpf/progs/test_tc_peer.c        | 10 ++--
> >  31 files changed, 117 insertions(+), 132 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> > index ded2dc8ddd79..836b8bf17fff 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> > @@ -2,14 +2,14 @@
> >  #include <test_progs.h>
> >
> >  static void toggle_object_autoload_progs(const struct bpf_object *obj,
> > -                                      const char *title_load)
> > +                                      const char *name_load)
> >  {
> >       struct bpf_program *prog;
> >
> >       bpf_object__for_each_program(prog, obj) {
> > -             const char *title = bpf_program__section_name(prog);
> > +             const char *name = bpf_program__name(prog);
> >
> > -             if (!strcmp(title_load, title))
> > +             if (!strcmp(name_load, name))
> >                       bpf_program__set_autoload(prog, true);
> >               else
> >                       bpf_program__set_autoload(prog, false);
> > @@ -39,23 +39,20 @@ void test_reference_tracking(void)
> >               goto cleanup;
> >
> >       bpf_object__for_each_program(prog, obj_iter) {
> > -             const char *title;
> > +             const char *name;
> >
> >               /* Ignore .text sections */
>
> I think this comment should go as well, no longer helps understand the test

yep, I originally removed it but then it was accidentally resurrected
when I was resolving merge conflict with your vprintk() patches. I'll
drop if I need to re-spin, but otherwise we can get to this in follow
up patches.
