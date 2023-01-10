Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569EA663F2E
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 12:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjAJLUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 06:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjAJLT7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 06:19:59 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C6C12602;
        Tue, 10 Jan 2023 03:19:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso5239327wms.0;
        Tue, 10 Jan 2023 03:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxQkDdVDafHcjUoOF3EQnmddqLP5rPkgih0jPFZvU2E=;
        b=oSJ8PVtgQcRGxfsFCxheDVMBtkmXR2RB3yi6lBOwAjKC6KZiGU5lWMLNyjABxMqsxb
         mCdj37EWlNQMiajkDUGQR+qYTlwEuu3SPS88i/Xlwqx8bh7h0UQ9gsOd+fty/nba4RUi
         geRWvLBnOYqPYhl1VOpo8vGc45wKqT6fXtQChyOwgqyf8X6/NZ451ea25vdiA9tKlvQN
         9JJlYI3au4aBpWDaqxN9l2G2YRIrIOCWPNoF23CE698VVQHk6U0np8JrdZYVr9iGnK8w
         gUjnpSMwS5jLX8w0nFVEVn4GzSxgP/ngP88zMuHp2P7bj3z+jvm97VtUbhDhh4tqN0mh
         vm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxQkDdVDafHcjUoOF3EQnmddqLP5rPkgih0jPFZvU2E=;
        b=yb8Y1E5zKt8yED6xAXY5lWyqHZL8uyiheNIx2JPTXuCAgt/muxlwKRSm8+q3cWMm1G
         BLLZuKdMTF8TeoXo5S4iGTv6SQ2MAohQ6coxw45ipMFOo5qTwHCF3AvXVeYSKrUuOiw5
         MFQs8ZOctBMVzQWdCWJt/S7Dy6+64ezAC+hlt3U7i2fsrUZoFiGp3VCvt/nNM9yr9XNR
         dI2qqVWdHuMJgzydLG02zVBXEZis3DiP3lXgDDpWAyD6u9+FxonfCXzDfPYD2vcdvi+L
         V8eI8u9Al+9XF6hKROUpAQO1ldOnG6GCbJGS6+Sfz9Q58pLuJsi60XqFEBW5aq6YpA4H
         Rm/Q==
X-Gm-Message-State: AFqh2kqYdzQ+NkWuzLPzIct0p00hFoFIRR3WuwyCrBNX+63hRHofmpG8
        JicCn3oChsipe8u5GflgJ3Sp0cszqlA/CBC9
X-Google-Smtp-Source: AMrXdXvZ75opWZTbfYPfpgM6I0lIFfRpx9gkSf25WUweD/6H0BELiuV1MCXQnbGxE3NfTzMZnGi0uw==
X-Received: by 2002:a05:600c:48a8:b0:3cf:7197:e68a with SMTP id j40-20020a05600c48a800b003cf7197e68amr49737298wmp.18.1673349596531;
        Tue, 10 Jan 2023 03:19:56 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b003d9fb59c16fsm997071wms.11.2023.01.10.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:19:56 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 10 Jan 2023 12:19:53 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y71J2WpaMtked02+@krava>
References: <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org>
 <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org>
 <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org>
 <Y7xYimp0h4YT72/N@krava>
 <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
 <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
 <CAP-5=fVtMEahrPMJNVOqsZGj-GoTxUnWsdzK7M+9F2+DhG_STQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVtMEahrPMJNVOqsZGj-GoTxUnWsdzK7M+9F2+DhG_STQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 09, 2023 at 11:34:44AM -0800, Ian Rogers wrote:
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

yes, seems good.. fedora has libbpf 1.0 already so should not be problem
there at least ;-)

thanks,
jirka
