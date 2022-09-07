Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A135B0C23
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 20:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIGSGT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIGSGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 14:06:12 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0E77EBD;
        Wed,  7 Sep 2022 11:06:10 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so10807149otu.3;
        Wed, 07 Sep 2022 11:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cwQcMikn8PY/begH6mMZDx9ENCQa5sG31sOsvQOo7/o=;
        b=WqQnu6PIEW7n1nUgrcWf63mnUg9vk4d9mU7tffbJbMJb6iLHf+aFoKSxkO2AupGHLQ
         qkDcxsUkMFAynW7Vbt2xEtMRsk5uGgnxJEsGUPdt1bFmLiVqdW6szF8fdiFDx8r7kJcs
         3jrYbtbsBjQg+xkXgW2hw9tBb7iCNJeiubHjLZrXpe5be9mM3F2gKLEZ7buRXdMZ0iBB
         xTVATKUW1JBBDhHbm6lIhQ65d7C5aYYZ4QyAYid8GqyWyjgW1c+okiJ703A3v1B1xR+P
         Nt6Fv06HxXsSuxgdvykMsmgo/V4IXHLjbCL2LYiQQ+sLA8fi+50tofpqa1M1hteNFejm
         HDcw==
X-Gm-Message-State: ACgBeo2HyVItHEix/dC8Hc5fmWC/Ql/DV7JHwmfkvN2HxPvo36zStYcV
        WViJM5xj1/PCOO7qjQXvn5jrDkq62tKarZ1pWhY=
X-Google-Smtp-Source: AA6agR5/jZHCxw7ViqcIaWpsfgM5JHTM8/6JkEPpzd28+g/aL8HtSeYdzEFXej9/DAFCxlF51VWDfeHLWoUSwmZEzYw=
X-Received: by 2002:a9d:6f18:0:b0:638:b4aa:a546 with SMTP id
 n24-20020a9d6f18000000b00638b4aaa546mr1910734otq.124.1662573969481; Wed, 07
 Sep 2022 11:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220907050407.2711513-1-namhyung@kernel.org> <YxhXLQ9aOuLRLrAJ@krava>
 <CAM9d7chVuOyY0Nhecj0J=AU6iRkFoKY6hQ5mAMrS8k=-26WeCg@mail.gmail.com>
In-Reply-To: <CAM9d7chVuOyY0Nhecj0J=AU6iRkFoKY6hQ5mAMrS8k=-26WeCg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 11:05:58 -0700
Message-ID: <CAM9d7cgG_Jwb1Z98svrk0Q1X9RmeodOyHBvbqxGijP3eyBU_uw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Skip sigtrap test on old kernels
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Marco Elver <elver@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 7, 2022 at 10:50 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Sep 7, 2022 at 1:32 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Sep 06, 2022 at 10:04:07PM -0700, Namhyung Kim wrote:
> > > If it runs on an old kernel, perf_event_open would fail because of the
> > > new fields sigtrap and sig_data.  Just skipping the test could miss an
> > > actual bug in the kernel.
> > >
> > > Let's check BTF if it has the perf_event_attr.sigtrap field.
> > >
> > > Cc: Marco Elver <elver@google.com>
> > > Cc: Song Liu <songliubraving@fb.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/tests/sigtrap.c | 46 +++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 45 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > > index e32ece90e164..32f08ce0f2b0 100644
> > > --- a/tools/perf/tests/sigtrap.c
> > > +++ b/tools/perf/tests/sigtrap.c
> > > @@ -16,6 +16,8 @@
> > >  #include <sys/syscall.h>
> > >  #include <unistd.h>
> > >
> > > +#include <bpf/btf.h>
> > > +
> > >  #include "cloexec.h"
> > >  #include "debug.h"
> > >  #include "event.h"
> > > @@ -54,6 +56,42 @@ static struct perf_event_attr make_event_attr(void)
> > >       return attr;
> > >  }
> > >
> > > +static bool attr_has_sigtrap(void)
> > > +{
> > > +     bool ret = false;
> > > +
> > > +#ifdef HAVE_BPF_SKEL
> > > +
> > > +     struct btf *btf;
> > > +     const struct btf_type *t;
> > > +     const struct btf_member *m;
> > > +     const char *name;
> > > +     int i, id;
> > > +
> > > +     /* just assume it doesn't have the field */
> > > +     btf = btf__load_vmlinux_btf();
> > > +     if (btf == NULL)
> > > +             return false;
> > > +
> > > +     id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
> > > +     if (id < 0)
> > > +             goto out;
> > > +
> > > +     t = btf__type_by_id(btf, id);
> > > +     for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> > > +             name = btf__name_by_offset(btf, m->name_off);
> > > +             if (!strcmp(name, "sigtrap")) {
> > > +                     ret = true;
> > > +                     break;
> > > +             }
> > > +     }
> > > +out:
> > > +     btf__free(btf);
> > > +#endif
> >
> > would it be easier to call perf_event_open for simple event with
> > sigtrap set (and perhaps remove_on_exec) ? perf_copy_attr checks
> > on reserved fields
>
> Hmm.. right.  we could do that too.  But it might still fail if there's a
> bug in the path handling in sigtrap even for the simple case.  I'm not
> sure if it's a realistic concern though. :)

I think we can do that when libbpf is not available.

Thanks,
Namhyung
