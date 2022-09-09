Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B7A5B3F59
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 21:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIITS6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIITS4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 15:18:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2413EE40
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 12:18:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so6267806ejy.5
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SDt5K+wzXLKj5B+U0e9ONsK39pNlKDW/hAHk6FG/W1g=;
        b=dngyjn1hH6cpPRA7AaiaQD06yhovOo7t49HTrTwO2vRimthoCPTJ4l/aUqSYP/3dsx
         W7bKi/dhYe7MGq646c9/sDPNV6ZNk7ck9e+Rw/eIEuggPeAkSqkxYj5TkWCShMbqTSas
         FJlmjG/gztPlfVsn0JN/9VYKUlTHlshrJKNFDvf3CshsVzLtJ/QG5+A32xZ1/eWdeoWB
         Ae4Bt0//rSh+7d4J42R07YSnr13CR6kU58xICauxsbL4MNPygHUprb+otFLGALExiuJm
         SaN5ra7NupjTZBG4d/kJMcy3bhFjaMgJAvhITfP2SNxyYDI/caAe1rA/0If9k2hrjFYc
         CBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SDt5K+wzXLKj5B+U0e9ONsK39pNlKDW/hAHk6FG/W1g=;
        b=DqOW8NTXRLs6T6B7Ej/TNpFtKu95jqSysHdGno59D0WoldOTLrPYZj8reqDAYkBP6g
         gsGZe+QQFBs4UCpqQ2r/hH8+1bZnNPazBRsYsFlV71bwS00wLT9cCC/qHrFyWHDOt8VP
         X9+haoTR9YZqG9HAINzQ6sCPycl22soJbsjqb+Xb6LGbNUsk521sJK+/vjY/Ed4/0ubi
         f72zqDfrPe3g6xft2IsZf5s0420xhNZ3pArx17HBM+24En21zp03NFvW43UljRa7wWkR
         03JawLQ/aFpxkAvEoPzlTVxG3Pf3+nZnrfoFmm9nwLgoEayk+cjhFM4sAGqd0BaQIWXY
         q0nA==
X-Gm-Message-State: ACgBeo0W9IvAtDl4YRxXb1KEPGquWfKjzGdoapd+PYobucQ2b2teIFaq
        yPTe88uM7VUwOkGnYJYZ/v7Wb0IzCuLbcUQpeUo=
X-Google-Smtp-Source: AA6agR5w4cmFeQK33TlARhGszUsvUCP3pUjsePuxGWRv5wwqE/0RHTV09tyZJ7wDAu0Nq2/hEJ2VlOUOYUkTYiSNpyM=
X-Received: by 2002:a17:907:3e08:b0:774:3e36:f019 with SMTP id
 hp8-20020a1709073e0800b007743e36f019mr6919369ejc.226.1662751131626; Fri, 09
 Sep 2022 12:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220826231531.1031943-1-andrii@kernel.org> <20220826231531.1031943-4-andrii@kernel.org>
 <937c74badbd88d0ffd25c8204db74797eebf2b47.camel@fb.com>
In-Reply-To: <937c74badbd88d0ffd25c8204db74797eebf2b47.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 12:18:40 -0700
Message-ID: <CAEf4BzboPd8CJY1pgMkgg2u35Ln1dgsH58OAJ90d1k6sABz2bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add veristat tool for
 mass-verifying BPF object files
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 28, 2022 at 11:02 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Fri, 2022-08-26 at 16:15 -0700, Andrii Nakryiko wrote:
> > Add a small tool, veristat, that allows mass-verification of
> > a set of *libbpf-compatible* BPF ELF object files. For each such
> > object
> > file, veristat will attempt to verify each BPF program
> > *individually*.
> > Regardless of success or failure, it parses BPF verifier stats and
> > outputs them in human-readable table format. In the future we can
> > also
> > add CSV and JSON output for more scriptable post-processing, if
> > necessary.
> >
> > veristat allows to specify a set of stats that should be output and
> > ordering between multiple objects and files (e.g., so that one can
> > easily order by total instructions processed, instead of default file
> > name, prog name, verdict, total instructions order).
> >
> > This tool should be useful for validating various BPF verifier
> > changes
> > or even validating different kernel versions for regressions.
> >
> > Here's an example for some of the heaviest selftests/bpf BPF object
> > files:
> >
> >   $ sudo ./veristat -s insns,file,prog
> > {pyperf,loop,test_verif_scale,strobemeta,test_cls_redirect,profiler}*
> > .linked3.o
> >   File
> > Program                               Verdict  Duration, us  Total
> > insns  Total states  Peak states

[...]

> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/.gitignore |   1 +
> >  tools/testing/selftests/bpf/Makefile   |   6 +-
> >  tools/testing/selftests/bpf/veristat.c | 541
> > +++++++++++++++++++++++++
> >  3 files changed, 547 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/veristat.c
> >
> > diff --git a/tools/testing/selftests/bpf/.gitignore
> > b/tools/testing/selftests/bpf/.gitignore
> > index 3a8cb2404ea6..3b288562963e 100644
> > --- a/tools/testing/selftests/bpf/.gitignore
> > +++ b/tools/testing/selftests/bpf/.gitignore
> > @@ -39,6 +39,7 @@ test_cpp
> >  /tools
> >  /runqslower
> >  /bench
> > +/veristat
> >  *.ko
> >  *.tmp
> >  xskxceiver
>
> [...]
>
> > +
> > +static int process_prog(const char *filename, struct bpf_object
> > *obj, struct bpf_program *prog)
> > +{

[...]

> > +               bpf_object__for_each_program(tprog, tobj) {
> > +                       const char *tprog_name =
> > bpf_program__name(tprog);
> > +
> > +                       if (strcmp(prog_name, tprog_name) == 0) {
> > +                               bpf_program__set_autoload(tprog,
> > true);
> > +                               lprog = tprog;
> > +                       } else {
> > +                               bpf_program__set_autoload(tprog,
> > false);
> > +                       }
> > +               }
> > +
> > +               process_prog(filename, tobj, lprog);
> > +               bpf_object__close(tobj);
> > +       }
>
> It leaks obj.

good catch, fixed.

>
> > > +
> > +cleanup:
> > +       libbpf_set_print(old_libbpf_print_fn);
> > +       return err;
> > +}
> > +

[...]

> > +
> > +#define snappendf(dst, len, fmt,
> > args...)                                      \
> > +       len += snprintf(dst +
> > len,                                              \
> > +                             sizeof(dst) < len ? 0 : sizeof(dst) -
> > len,        \
> > +                             fmt, ##args)
>
> Never been used?

yep, dropped

>
> > +
> > +#define HEADER_CHAR '-'
> > +#define COLUMN_SEP "  "
> > +
> > +static void output_headers(bool calc_len)
> > +{
> > +       int i, len;
> > +
> > +       for (i = 0; i < env.output_spec.spec_cnt; i++) {
> > +               int id = env.output_spec.ids[i];
> > +               int *max_len = &env.output_spec.lens[i];
> > +
> > +               if (calc_len) {
> > +                       len = snprintf(NULL, 0, "%s",
> > stat_defs[id].header);
>
> Is there any reason to no use strlen()?

to keep it consistent with other snprintf() uses for calc_len case

> It would be ok to merge this block to one line since this function is
> always called exactly once before output_stats() with calc_len being
> true.  For example,
>
>  *max_len = strlen(...)
>

yes, but I wanted to keep it consistent and not have to keep track of
ordering dependencies. So I'd prefer to keep it as is.

>
> > +                       if (len > *max_len)
> > +                               *max_len = len;
> > +               } else {
> > +                       printf("%s%-*s", i == 0 ? "" : COLUMN_SEP,
> > *max_len, stat_defs[id].header);
> > +               }
> > +       }
> > +
> > +       if (!calc_len)
> > +               printf("\n");
> > +}
> > +
> > +static void output_lines(void)
>
> lines? It is confusing for me since it always prints exactly one line.
> How about something like output_sep_line()?

lines refers to "---------" under headers and at the bottom, so
multiple of them. sep (for separator) is also a bit misleading. I'll
call it output_header_underlines().

>
> > +{
> > +       int i, j, len;
> > +
> > +       for (i = 0; i < env.output_spec.spec_cnt; i++) {
> > +               len = env.output_spec.lens[i];
> > +
> > +               printf("%s", i == 0 ? "" : COLUMN_SEP);
> > +               for (j = 0; j < len; j++)
> > +                       printf("%c", HEADER_CHAR);
> > +       }
> > +       printf("\n");
> > +}
> > +

[...]

note: it's a good idea to trim irrelevant parts of the email to keep
it shorter and easier to read, if patch is long
