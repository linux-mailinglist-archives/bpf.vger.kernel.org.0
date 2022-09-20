Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084275BF192
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 01:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiITX7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 19:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiITX7v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 19:59:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B1D10563
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 16:59:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z13so6158061edb.13
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PSajSV60P78/BiS/vMLg4RuhUfDb1pf8NBY6rBcdlPk=;
        b=UlSN052oAdF6otPBqRPDTBO3F/orM+X5MfFAzlYFuqFuGliUIKcunfqKxXd9FgPgxX
         850VC4EAfjYOJn5twcZus6ZWbfa7Q/3blreflR5a9P5RKAMLXKXxXnAnxO1Fd+QFq+b9
         YNlXr8GE5Q9EeawcPx7I3Wo0SzXNTfRj8FCIP6Gf+Z0nV6hbldqHKLd+afvzT/riGl0u
         JwT+EXa864jsQbiro+0d0eK9/slsBxWgcMuwGL17T9cJxO7xZFMCA4ZJRWPo8OPrcSJt
         zT09lrT6aJnVerZNcWnd6bN/pXSTn1XE/D0qyx9EAv0WGPYbSXCGXjhs4O9aXTameE7m
         +4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PSajSV60P78/BiS/vMLg4RuhUfDb1pf8NBY6rBcdlPk=;
        b=oJUesD0TChDYlCSVan1iqgqHaVYgkTwS/FgFE1bG7CVY+pEeBBsSLO3x8pWvDVuyTq
         /Qam24P9cf5bGuxoUcdUXszWx8eUzHkVoBCBbNekzzETQVxER3iGDOj19QMXQmbBb0BB
         ksXbV7mU6qN5RHgX4a3cDJfQvixXaQCo/UxMnk8bxNLTu1SpSJRL3qmB6fzxWOwtSb/X
         T+Ne0tlbjDnxG65fmogWpvQnHXcSpfWD+b8xEyD8bLBY7bLRkevMPHAM+lk6tjG5eFrt
         m0A71RQR1njB57Pla2bEkMOSix2oFoO+33lkApm4w2QtWEy1kbswdFmnGbhatFuw8FxC
         Ui0g==
X-Gm-Message-State: ACrzQf3j8Neahhe1y0o/i7eedhy/othsdQJiJXq77IctrFTfnlM3wT5g
        tyxwEcyrzgt1eA+0aAA2V6zAlu4y/U9Y47+dG9A=
X-Google-Smtp-Source: AMsMyM5yNtORXXTzHnkizg0kmwZUnrI4x8LtylJkel0FO7Iqek0bRQkONiCrX8VWqG7xXRep7xGX7pSIW7QIm4k5iYY=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr22465243edb.333.1663718388932; Tue, 20
 Sep 2022 16:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220920040736.342025-1-andrii@kernel.org> <20220920040736.342025-2-andrii@kernel.org>
 <b0215eb8-1c1b-5321-6c94-fefd214a7138@isovalent.com>
In-Reply-To: <b0215eb8-1c1b-5321-6c94-fefd214a7138@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Sep 2022 16:59:37 -0700
Message-ID: <CAEf4BzZLxQAhU8jGab3_CU6-pHq_=P3DAF126zaXZ6G9Bd3Y-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: add CSV output mode for veristat
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 20, 2022 at 9:23 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Tue Sep 20 2022 05:07:34 GMT+0100 (British Summer Time) ~ Andrii
> Nakryiko <andrii@kernel.org>
> > Teach veristat to output results as CSV table for easier programmatic
> > processing. Change what was --output/-o argument to now be --emit/-e.
> > And then use --output-format/-o <fmt> to specify output format.
> > Currently "table" and "csv" is supported, table being default.
> >
> > For CSV output mode veristat is using spec identifiers as column names.
> > E.g., instead of "Total states" veristat uses "total_states" as a CSV
> > header name.
> >
> > Internally veristat recognizes three formats, one of them
> > (RESFMT_TABLE_CALCLEN) is a special format instructing veristat to
> > calculate column widths for table output. This felt a bit cleaner and
> > more uniform than either creating separate functions just for this.
> >
> > Also fix double-free of bpf_object in process_prog, which didn't feel
> > important enough to have a separate patch for.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/veristat.c | 114 ++++++++++++++++---------
> >  1 file changed, 76 insertions(+), 38 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> > index 39e6dc41e504..317f7736dd59 100644
> > --- a/tools/testing/selftests/bpf/veristat.c
> > +++ b/tools/testing/selftests/bpf/veristat.c
> > @@ -46,10 +46,17 @@ struct stat_specs {
> >       int lens[ALL_STATS_CNT];
> >  };
> >
> > +enum resfmt {
> > +     RESFMT_TABLE,
> > +     RESFMT_TABLE_CALCLEN, /* fake format to pre-calculate table's column widths */
> > +     RESFMT_CSV,
> > +};
> > +
> >  static struct env {
> >       char **filenames;
> >       int filename_cnt;
> >       bool verbose;
> > +     enum resfmt out_fmt;
> >
> >       struct verif_stats *prog_stats;
> >       int prog_stat_cnt;
> > @@ -77,9 +84,10 @@ const char argp_program_doc[] =
> >
> >  static const struct argp_option opts[] = {
> >       { NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
> > -     { "verbose", 'v', NULL, 0, "Verbose mode" },
> > -     { "output", 'o', "SPEC", 0, "Specify output stats" },
> > +     { "vereose", 'v', NULL, 0, "Verbose mode" },
>
> "vereose" -> looks like this line was changed by mistake

yep, fat-fingered, will fix

>
