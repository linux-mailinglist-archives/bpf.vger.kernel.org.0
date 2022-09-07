Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED25B0BC8
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiIGRuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiIGRuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 13:50:18 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB2C3FA32;
        Wed,  7 Sep 2022 10:50:15 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-128121a9851so2546916fac.13;
        Wed, 07 Sep 2022 10:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o+vZIo7vWZhi9jMgze8rEVP2MoMz8p7K3ku8PnOZlC8=;
        b=lm69WbKrY8Bc9Ld41bUCgd3UT0V7yUOFQRcTERfXiO3LEmNMfZAd5LhtBy21sgBYb7
         BEIy86MQwz0B9H2cz8sdy/b0SlKBgOKzWAUTdm9jT3lBuZBY93zD7ESztyyzTjOdWEQX
         WQSPZAzIgyTCmhHm5OVXvfOIMilU9kLBMJ5sSJPdGwsl4Ldcoad59vbx0srlAYSpw3nY
         EiS5z1huJOjr7IBUp5oRzgcRbmfe1iQ/XSh4jwtTt+MxgDSgVUdNE2CLgsdv705+rfsW
         t4G7cB/p1WCyEAkjiX/3VIwNR6TZC3TOscQpYmycWXz69xBpZeZqfF23ALrqpgj4gRgh
         daEQ==
X-Gm-Message-State: ACgBeo2kQzfuFFENVEV3TUfFdMgQFE8PMxdZOHUdgIDf+U0ykJSBU5n3
        MkFbZnqThplnxPzQ17kxL4yGc88B2hiIhDr4P4Kna7pg
X-Google-Smtp-Source: AA6agR4BYQ2Nvxvc6Z+g6x+cYOlhaVE7imQ4sWWJnPFXNtCfQC0Oe5T49sOEGO4NWqXLBAts7C0xFWV+JSOdhYXCQPk=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr15334457oaf.5.1662573014962; Wed, 07 Sep
 2022 10:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220907050407.2711513-1-namhyung@kernel.org> <YxhXLQ9aOuLRLrAJ@krava>
In-Reply-To: <YxhXLQ9aOuLRLrAJ@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 10:50:04 -0700
Message-ID: <CAM9d7chVuOyY0Nhecj0J=AU6iRkFoKY6hQ5mAMrS8k=-26WeCg@mail.gmail.com>
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

On Wed, Sep 7, 2022 at 1:32 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Sep 06, 2022 at 10:04:07PM -0700, Namhyung Kim wrote:
> > If it runs on an old kernel, perf_event_open would fail because of the
> > new fields sigtrap and sig_data.  Just skipping the test could miss an
> > actual bug in the kernel.
> >
> > Let's check BTF if it has the perf_event_attr.sigtrap field.
> >
> > Cc: Marco Elver <elver@google.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/sigtrap.c | 46 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > index e32ece90e164..32f08ce0f2b0 100644
> > --- a/tools/perf/tests/sigtrap.c
> > +++ b/tools/perf/tests/sigtrap.c
> > @@ -16,6 +16,8 @@
> >  #include <sys/syscall.h>
> >  #include <unistd.h>
> >
> > +#include <bpf/btf.h>
> > +
> >  #include "cloexec.h"
> >  #include "debug.h"
> >  #include "event.h"
> > @@ -54,6 +56,42 @@ static struct perf_event_attr make_event_attr(void)
> >       return attr;
> >  }
> >
> > +static bool attr_has_sigtrap(void)
> > +{
> > +     bool ret = false;
> > +
> > +#ifdef HAVE_BPF_SKEL
> > +
> > +     struct btf *btf;
> > +     const struct btf_type *t;
> > +     const struct btf_member *m;
> > +     const char *name;
> > +     int i, id;
> > +
> > +     /* just assume it doesn't have the field */
> > +     btf = btf__load_vmlinux_btf();
> > +     if (btf == NULL)
> > +             return false;
> > +
> > +     id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
> > +     if (id < 0)
> > +             goto out;
> > +
> > +     t = btf__type_by_id(btf, id);
> > +     for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> > +             name = btf__name_by_offset(btf, m->name_off);
> > +             if (!strcmp(name, "sigtrap")) {
> > +                     ret = true;
> > +                     break;
> > +             }
> > +     }
> > +out:
> > +     btf__free(btf);
> > +#endif
>
> would it be easier to call perf_event_open for simple event with
> sigtrap set (and perhaps remove_on_exec) ? perf_copy_attr checks
> on reserved fields

Hmm.. right.  we could do that too.  But it might still fail if there's a
bug in the path handling in sigtrap even for the simple case.  I'm not
sure if it's a realistic concern though. :)

Thanks,
Namhyung

>
>
> > +
> > +     return ret;
> > +}
> > +
> >  static void
> >  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
> >  {
> > @@ -139,7 +177,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
> >
> >       fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> >       if (fd < 0) {
> > -             pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> > +             if (attr_has_sigtrap()) {
> > +                     pr_debug("FAILED sys_perf_event_open(): %s\n",
> > +                              str_error_r(errno, sbuf, sizeof(sbuf)));
> > +             } else {
> > +                     pr_debug("perf_event_attr doesn't have sigtrap\n");
> > +                     ret = TEST_SKIP;
> > +             }
> >               goto out_restore_sigaction;
> >       }
> >
> > --
> > 2.37.2.789.g6183377224-goog
> >
