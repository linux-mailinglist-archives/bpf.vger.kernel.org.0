Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1515AFC11
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 07:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIGF6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 01:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGF6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 01:58:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F53895F4;
        Tue,  6 Sep 2022 22:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EE46B81B4E;
        Wed,  7 Sep 2022 05:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F32C433C1;
        Wed,  7 Sep 2022 05:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662530327;
        bh=Usb7RB0E/4pZu8ET3H5EzLquGfLSkSzBMYKG6bPNTzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UN//H31Y8ALCcivYHKUF+F5B9ft7nhl9qTcm1cqjCVsXbf4nx+P0FebUGmzQU5vKM
         vbGK0+eASpQJjpuppHcarVZ24213YeaRFzRDW1osNACF0C4ojnNFfS8teBTMLoYxjN
         9bps6/kEJ0TuDOjjj6ORMu59Hh8sL/r4MMY1XFRjp/X+ojM3gkZhU1yk0uhnlUog/Q
         7+CsQlnxbAJL1U44x+OoVanu7CGt88uM5Tfc8ZVTYilf4a8DanXd4sSIbWkpsFGc4H
         jycMA9S/e+N2oS64wWJ7h7SCiYlkOgcX2Q6VCCFzuumsJgoaF0ZN40Cj2VRdPevYXX
         ezzYrO+gUFmiw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1274ec87ad5so18674122fac.0;
        Tue, 06 Sep 2022 22:58:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo1Excr8ZglEHTRa12Rkqj+51sD30PWhkpw+/ob0TAogDnFF3cBz
        LSM/7EoNj0Uxcl28/u2lrx6fJyUEjleRuRQ8yS0=
X-Google-Smtp-Source: AA6agR6RtWs+tc7D5XKa1brovVgMCpoLJSxZbYT4qLoxWFAdV2b9Hb63gLuxccgct1L52t1nUxgJv5AbRnVpvUromAc=
X-Received: by 2002:a05:6870:3127:b0:11c:8c2c:9015 with SMTP id
 v39-20020a056870312700b0011c8c2c9015mr13117547oaa.31.1662530326147; Tue, 06
 Sep 2022 22:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220907050407.2711513-1-namhyung@kernel.org>
In-Reply-To: <20220907050407.2711513-1-namhyung@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 22:58:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4OT3XC8oREZBNreesYyVvU9hSGs5Hgz=r-cwsQSkiXRQ@mail.gmail.com>
Message-ID: <CAPhsuW4OT3XC8oREZBNreesYyVvU9hSGs5Hgz=r-cwsQSkiXRQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Skip sigtrap test on old kernels
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 6, 2022 at 10:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> If it runs on an old kernel, perf_event_open would fail because of the
> new fields sigtrap and sig_data.  Just skipping the test could miss an
> actual bug in the kernel.
>
> Let's check BTF if it has the perf_event_attr.sigtrap field.
>
> Cc: Marco Elver <elver@google.com>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/sigtrap.c | 46 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index e32ece90e164..32f08ce0f2b0 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -16,6 +16,8 @@
>  #include <sys/syscall.h>
>  #include <unistd.h>
>
> +#include <bpf/btf.h>
> +

Do we need "#ifdef HAVE_BPF_SKEL" for the include part?

Other than this, looks good to me.

Acked-by: Song Liu <song@kernel.org>

>  #include "cloexec.h"
>  #include "debug.h"
>  #include "event.h"
> @@ -54,6 +56,42 @@ static struct perf_event_attr make_event_attr(void)
>         return attr;
>  }
>
> +static bool attr_has_sigtrap(void)
> +{
> +       bool ret = false;
> +
> +#ifdef HAVE_BPF_SKEL
> +
> +       struct btf *btf;
> +       const struct btf_type *t;
> +       const struct btf_member *m;
> +       const char *name;
> +       int i, id;
> +
> +       /* just assume it doesn't have the field */
> +       btf = btf__load_vmlinux_btf();
> +       if (btf == NULL)
> +               return false;
> +
> +       id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
> +       if (id < 0)
> +               goto out;
> +
> +       t = btf__type_by_id(btf, id);
> +       for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> +               name = btf__name_by_offset(btf, m->name_off);
> +               if (!strcmp(name, "sigtrap")) {
> +                       ret = true;
> +                       break;
> +               }
> +       }
> +out:
> +       btf__free(btf);
> +#endif
> +
> +       return ret;
> +}
> +
>  static void
>  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
>  {
> @@ -139,7 +177,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>
>         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>         if (fd < 0) {
> -               pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> +               if (attr_has_sigtrap()) {
> +                       pr_debug("FAILED sys_perf_event_open(): %s\n",
> +                                str_error_r(errno, sbuf, sizeof(sbuf)));
> +               } else {
> +                       pr_debug("perf_event_attr doesn't have sigtrap\n");
> +                       ret = TEST_SKIP;
> +               }
>                 goto out_restore_sigaction;
>         }
>
> --
> 2.37.2.789.g6183377224-goog
>
