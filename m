Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C46631AB
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjAIUks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 15:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbjAIUkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 15:40:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D54DECE
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 12:40:45 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso8047253wmq.1
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 12:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MCRW0UkTNlTzkZ4jOzer8zj7ypiKG1rbT29sYMJr0H0=;
        b=SKO4ZX8fQPOxTTcMnTbp5MFbMfTEzMDNX7cwrMxkDT51AdOR0mgCK+A8X5hxt6SrEq
         w4CKxeCPJiZxa/vofF5uHOsRmB6riV3BPAPZuZkIg3PekMR4z9IGHtAl1DQDHEw0eF4i
         JIGunRDVUq7U+Bhpui8Rcvid0HOehY53Ify5/l6SCIlPmFXUGYBTzuqkUs7jJ45yGsnW
         rQA3u1EPJy1VdUSMCvy8ZSG9UF63qoNWihdHPMIoKJFGKVrni57DUHimOtV975ev9H+Q
         m011MLFr6BN52WpZwJRFNyGaYJfSbc5WUIY2pFbD5JrRQaZhHefi1LXaloaC20F484Bn
         08hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCRW0UkTNlTzkZ4jOzer8zj7ypiKG1rbT29sYMJr0H0=;
        b=mr3Ww7f4/UY2KgOu3+gCCTltR63SCsA1fz4upnH9ozFyysOgKnRUn1KJ964Mz4hQKj
         1f1uL+4ejzH/vQa4P91vcSOD7wvHMYn89v9zTuJhU3PqaMsTucWbcjTWzdUn1zmVPmCF
         Ui0utQylDzFv9G475oys8tK/PRCkMony/MFCf75OUMX5HenTEj9SqrfLp9W4G7uw9B3L
         pYrLpA6iy73QCy7HNrW9iY1Kp/PTT2prvXxpztFVZojTK7v+LR6W7XN5peN1d6wtLKlm
         JEPs/LoIx5PkS3SV5N6sM9je7Eiu9FGnI4SqPv+7hLvWtHGaSoOowK6RhexAsgYtf9L+
         iHAg==
X-Gm-Message-State: AFqh2kpMUknwMvKKh8iWnv2tGciVlU2gzDFV+d3u3tUxQjogGzx34/Nl
        huVJYNzhCg+FSoguJyPljTMfpChBcyhskBKlleL0iw==
X-Google-Smtp-Source: AMrXdXsHG/iZRmaXeZTbdJc8dLvE4HxpOxTVoriaJACvg5w0n2cAyT8cqtwrH/tyBJFGsjhsaYh4xJxSXcFfCetfRPY=
X-Received: by 2002:a1c:4c04:0:b0:3d9:edae:ed7 with SMTP id
 z4-20020a1c4c04000000b003d9edae0ed7mr230023wmf.182.1673296843828; Mon, 09 Jan
 2023 12:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20230106151320.619514-1-irogers@google.com> <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org> <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org> <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org> <Y7xYimp0h4YT72/N@krava> <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
 <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com> <CAP-5=fVtMEahrPMJNVOqsZGj-GoTxUnWsdzK7M+9F2+DhG_STQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVtMEahrPMJNVOqsZGj-GoTxUnWsdzK7M+9F2+DhG_STQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Jan 2023 12:40:31 -0800
Message-ID: <CAP-5=fX_MQBaER86c1UEuSMYGoQ0uv4siv==_ewr6H5xhb0XpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 9, 2023 at 11:34 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jan 9, 2023 at 11:29 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Jan 9, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Mon, Jan 9, 2023 at 10:10 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Mon, Jan 09, 2023 at 12:12:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Em Fri, Jan 06, 2023 at 11:06:46AM -0800, Ian Rogers escreveu:
> > > > > > So trying to get build-test working on my Debian derived distro is a
> > > > > > PITA with broken feature detection for options I don't normally use.
> > > > >
> > > > > Its really difficult to have perf building with so many dependent
> > > > > libraries, mowing out some should be in order.
> > > > >
> > > > > > I'll try to fix this.
> > > > >
> > > > > Thanks.
> > > > >
> > > > > > In any case I think I've spotted what is really happening here and it
> > > > > > isn't a failure but a feature :-D The build is specifying
> > > > >
> > > > > I get it.
> > > > >
> > > > > > LIBBPF_DYNAMIC=1 which means you get the libbpf headers from
> > > > > > /usr/include. I think the build is trying to do this on a system with
> > > > > > an old libbpf and hence getting the failures above. Previously, even
> > > > > > though we wanted the dynamic headers we still had a -I, this time for
> > > > > > the install_headers version. Now you really are using the system
> > > > > > version and it is broken. This means a few things:
> > > > > > - the libbpf feature test should fail if code like above is going to fail,
> > > > >
> > > > > Agreed.
> > > > >
> > > > > > - we may want to contemplate supporting older libbpfs (I'd rather not),
> > > > >
> > > > > I'd rather require everybody to be up to the latest trends, but I really
> > > > > don't think that is a reasonable expectation.
> > > > >
> > > > > > - does build-test have a way to skip known issues like this?
> > > > >
> > > > > Unsure, Jiri?
> > > >
> > > > I don't think so it just triggers the build, it's up to the features check
> > > > to disable the feature if the library is not compatible with perf code
> > > >
> > > > could we add that specific libbpf call to the libbpf feature check?
> > >
> > > Looking at the failure closer, the failing code is code inside a
> > > feature check trying to workaround the feature not being present. We
> > > need to do something like:
> > >
> > > ```
> > > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > > index 6e9b06cf06ee..a1c3cc230273 100644
> > > --- a/tools/perf/util/bpf-loader.c
> > > +++ b/tools/perf/util/bpf-loader.c
> > > @@ -33,17 +33,18 @@
> > > #include <internal/xyarray.h>
> > >
> > > #ifndef HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
> > > -int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
> > > -                          struct bpf_insn *new_insns __maybe_unused,
> > > size_t new_insn_cnt __maybe_un
> > > used)
> > > +static int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
> > > +                                 struct bpf_insn *new_insns __maybe_unused,
> > > +                                 size_t new_insn_cnt __maybe_unused)
> > > {
> > >        pr_err("%s: not support, update libbpf\n", __func__);
> > >        return -ENOTSUP;
> > > }
> > >
> > > -int libbpf_register_prog_handler(const char *sec __maybe_unused,
> > > -                                 enum bpf_prog_type prog_type __maybe_unused,
> > > -                                 enum bpf_attach_type exp_attach_type
> > > __maybe_unused,
> > > -                                 const struct
> > > libbpf_prog_handler_opts *opts __maybe_unused)
> > > +static int libbpf_register_prog_handler(const char *sec __maybe_unused,
> > > +                                       enum bpf_prog_type prog_type
> > > __maybe_unused,
> > > +                                       enum bpf_attach_type
> > > exp_attach_type __maybe_unused,
> > > +                                       const void *opts __maybe_unused)
> > > {
> > >        pr_err("%s: not support, update libbpf\n", __func__);
> > >        return -ENOTSUP;
> > > ```
> > >
> > > There are some other fixes necessary too. I'll try to write the fuller
> > > patch but I have no means for testing except for undefining
> > > HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS.
> > >
> > > Thanks,
> > > Ian
> >
> > So libbpf_prog_handler_opts is missing in the failing build, this
> > points to a libbpf before 0.8. I'm somewhat concerned that to work
> > around these linkage problems we're adding runtime errors - we may
> > build but the functionality is totally crippled. Is it worth
> > maintaining these broken builds or to just upfront fail the feature
> > test?
> >
> > We can also switch the feature tests for LIBBPF_MAJOR_VERSION and
> > LIBBPF_MINOR_VERSION checks. This would have the property of letting
> > us tie the error messages to what version of libbpf is assumed.
> >
> > In this case we could have a feature test for the libbpf version and
> > if the version is before libbpf 0.8 fail the feature check. A quick
> > way to do this is:
> > ```
> > diff --git a/tools/build/feature/test-libbpf.c
> > b/tools/build/feature/test-libbpf.c
> > index a508756cf4cc..dadd8186b71d 100644
> > --- a/tools/build/feature/test-libbpf.c
> > +++ b/tools/build/feature/test-libbpf.c
> > @@ -1,6 +1,10 @@
> > // SPDX-License-Identifier: GPL-2.0
> > #include <bpf/libbpf.h>
> >
> > +#if (LIBBPF_MAJOR_VERSION == 0) && (LIBBPF_MINOR_VERSION < 8)
> > +#error At least libbpf 0.8 is assumed for Linux tools.
> > +#endif
> > +
> > int main(void)
> > {
> >        return bpf_object__open("test") ? 0 : -1;
> > ```
> >
> > Thanks,
> > Ian
>
> Oh, just to note. While failing the feature test is disappointing for
> a libbpf that isn't very old, we have the newer libbpf to statically
> build in. Developers won't be impacted due to the static route. If you
> are a distro maintainer, you should just update your libbpf. So we
> could just bump the API assumption to 1.0 as I believe that'd have the
> advantage of removing feature tests, workarounds, untested code (like
> what broke here), etc.
>
> What do you think?
>
> Thanks,
> Ian

The removal of pre-libbpf 1.0 support is in:
https://lore.kernel.org/lkml/20230109203424.1157561-1-irogers@google.com/
So my proposal is that for 6.2 these two patches are sufficient. In
perf/core (to be in 6.3) it makes sense to add both sets of patches to
fix the build issue reported here. The problem with that is that some
build tests will fail for 6.2 if they are testing libbpf dynamic with
a libbpf earlier than 1.0. If that is an issue then cherry-picking the
first or all of the pre-libbpf 1.0 removal patches should address it.

Thanks,
Ian

> > > > jirka
> > > >
> > > > >
> > > > > But yeah, previous experiences with Andrii were that we can do not too
> > > > > costly feature checks, not using .c programs that would fail if some
> > > > > required feature wasn't present but instead would just do some grep on a
> > > > > header and if some "smell" wasn't scent, just fail the cap query.
> > > > >
> > > > > - Arnaldo
