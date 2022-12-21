Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DB56535A4
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 18:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLURzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 12:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLURzF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 12:55:05 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7422BDA;
        Wed, 21 Dec 2022 09:55:04 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id m2so15446474vsv.9;
        Wed, 21 Dec 2022 09:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+EHTg950OODgm5W0yafui8aHdMJusC0dH+4uJ44Jio=;
        b=PiHbb0brrZGhKpSMiZU9LB9N5Y1sDCugXgD8KA5r+NYclSeowpfCcwHOymIUuB3AkA
         srjF9oWxk0Jh6tmo0FIwqNTRX46h+KWPXs9Dt0GqEbF1BsI+IJ8I26VMHQ3Sz8ReoMrd
         VgGpmlxJjVRwQgc8pQpdCG8OJotMhEOQY4tJjNUIt+HQAWPJ/5AGy2CFuaSVjoP0/LG/
         W7L+Al+ofKYUkf1lajwqCBARCIIm9FJt7cyHPuuvTkPyMq0dygCo7QqlD//n7NKNBQzR
         Vna4dnYx7grnk7UuR5ZYn5H+zK0KTzVCSXq2RpsG573pbcJiq6YFfIl3D3blNQxCz9zH
         wH0w==
X-Gm-Message-State: AFqh2kp+rWm7G2ASsA9z+IMBzEFDM3wmnJ2jAopiN5c9fFZGtce9+Q/x
        Hg8VD2Rdln5vBo0d4GLX9tyquog9idfkenI/2YM=
X-Google-Smtp-Source: AMrXdXvcjo0kdtXNWnF54g6kqUsDb5GUgL1NC6uyXp7BWEmYvCktUq9ySLvg1y8r5oY9vEpuDaN2+x++rcuIPJnq7jw=
X-Received: by 2002:a05:6102:126c:b0:3b3:4691:f37e with SMTP id
 q12-20020a056102126c00b003b34691f37emr312369vsg.70.1671645303271; Wed, 21 Dec
 2022 09:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20221219201732.460111-1-namhyung@kernel.org> <20221219201732.460111-3-namhyung@kernel.org>
 <Y6NHf1h2BKOw9J3Q@kernel.org>
In-Reply-To: <Y6NHf1h2BKOw9J3Q@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Dec 2022 09:54:51 -0800
Message-ID: <CAM9d7chFP6LAJS0_PkThRBNk9KN6HRCyWJK=PoXMTyY92Di7YA@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf lock contention: Add -Y/--type-filter option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Wed, Dec 21, 2022 at 9:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Dec 19, 2022 at 12:17:28PM -0800, Namhyung Kim escreveu:

[SNIP]
> > @@ -1465,6 +1483,21 @@ static const char *get_type_str(unsigned int flags)
> >       return "unknown";
> >  }
> >
> > +static unsigned int get_type_flag(const char *str)
> > +{
> > +     for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> > +             if (!strcmp(lock_type_table[i].name, str))
> > +                     return lock_type_table[i].flags;
> > +     }
> > +     return -1U;
> > +}
> > +
> > +static void lock_filter_finish(void)
> > +{
> > +     zfree(&filters.types);
> > +     filters.nr_types = 0;
> > +}
> > +
> >  static void sort_contention_result(void)
> >  {
> >       sort_result();
> > @@ -1507,6 +1540,9 @@ static void print_contention_result(struct lock_contention *con)
> >               if (st->broken)
> >                       bad++;
> >
> > +             if (!st->wait_time_total)
> > +                     continue;
> > +
> >               list_for_each_entry(key, &lock_keys, list) {
> >                       key->print(key, st);
> >                       pr_info(" ");
> > @@ -1753,6 +1789,7 @@ static int __cmd_contention(int argc, const char **argv)
> >       print_contention_result(&con);
> >
> >  out_delete:
> > +     lock_filter_finish();
> >       evlist__delete(con.evlist);
> >       lock_contention_finish();
> >       perf_session__delete(session);
> > @@ -1884,6 +1921,79 @@ static int parse_max_stack(const struct option *opt, const char *str,
> >       return 0;
> >  }
> >
> > +static bool add_lock_type(unsigned int flags)
> > +{
> > +     unsigned int *tmp;
> > +
> > +     tmp = realloc(filters.types, (filters.nr_types + 1) * sizeof(*filters.types));
> > +     if (tmp == NULL)
> > +             return false;
> > +
> > +     tmp[filters.nr_types++] = flags;
> > +     filters.types = tmp;
> > +     return true;
> > +}
> > +
> > +static int parse_lock_type(const struct option *opt __maybe_unused, const char *str,
> > +                        int unset __maybe_unused)
> > +{
> > +     char *s, *tmp, *tok;
> > +     int ret = 0;
> > +
> > +     s = strdup(str);
> > +     if (s == NULL)
> > +             return -1;
> > +
> > +     for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> > +             unsigned int flags = get_type_flag(tok);
> > +
> > +             if (flags == -1U) {
> > +                     char buf[32];
> > +
> > +                     if (strchr(tok, ':'))
> > +                         continue;
> > +
> > +                     /* try :R and :W suffixes for rwlock, rwsem, ... */
> > +                     scnprintf(buf, sizeof(buf), "%s:R", tok);
> > +                     flags = get_type_flag(buf);
> > +                     if (flags != -1UL) {
> > +                             if (!add_lock_type(flags)) {
> > +                                     ret = -1;
> > +                                     break;
> > +                             }
> > +                     }
>
>
> clang doesn't like this:
>
>   34    97.97 fedora:36                     : FAIL clang version 14.0.5 (Fedora 14.0.5-2.fc36)
>     builtin-lock.c:2012:14: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned int' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
>                             if (flags != -1UL) {
>                                 ~~~~~ ^  ~~~~
>     builtin-lock.c:2021:14: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned int' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
>                             if (flags != -1UL) {
>                                 ~~~~~ ^  ~~~~
>     builtin-lock.c:2037:14: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned int' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
>                             if (flags != -1UL) {
>                                 ~~~~~ ^  ~~~~
>     3 errors generated.
>
> I applied this on top, Ack?

Oh.. sorry for that.  It could be just -1U.  But I'm ok with UINT_MAX too.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
