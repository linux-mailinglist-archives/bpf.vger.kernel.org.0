Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72695664346
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjAJObm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 09:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbjAJObU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 09:31:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BD8140FE;
        Tue, 10 Jan 2023 06:31:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A13CB81698;
        Tue, 10 Jan 2023 14:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE95C433D2;
        Tue, 10 Jan 2023 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673361075;
        bh=LOoYPBlODlu7y05E+u+90jbiPTHc4w3PhsP6x/osJoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+XjPie5/w2MDGgsY8S8gAH0BV0o6HmDRINBztS21ZpDDxD+6mde0rFr1Q9S87oJp
         eOdJRoMIAtz1IDthp59xL3lMaUoCSdWa5dRDbShWI6GPqxaTp+rUIXNjs/5vCgXMTx
         gmBT8Ew96WPK9vcaPoR5I+r/fuRSD4WdlZzU/UUJ9E7qGcieZjlSh6Sbb8pzdnJfj7
         fPMktE1oXHAB1j4jK+BDPCzqmx/QhAQzSW5zI7VOzeTrhWy/QrL4zgYk85nh0KhATn
         mt6fQV8U1AG72osVMrDjJbxJeheaFBetjCZw3GT46+oqCJjiHq4jqcUmJM8+axDkJE
         q2Njs7/8qDJRA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E1F740468; Tue, 10 Jan 2023 11:31:12 -0300 (-03)
Date:   Tue, 10 Jan 2023 11:31:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y712sCnYBJobe2eY@kernel.org>
References: <20230106151320.619514-1-irogers@google.com>
 <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org>
 <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org>
 <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org>
 <Y7xYimp0h4YT72/N@krava>
 <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
 <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 09, 2023 at 11:29:51AM -0800, Ian Rogers escreveu:
> On Mon, Jan 9, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Jan 9, 2023 at 10:10 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Mon, Jan 09, 2023 at 12:12:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Jan 06, 2023 at 11:06:46AM -0800, Ian Rogers escreveu:
> > > > > So trying to get build-test working on my Debian derived distro is a
> > > > > PITA with broken feature detection for options I don't normally use.
> > > >
> > > > Its really difficult to have perf building with so many dependent
> > > > libraries, mowing out some should be in order.
> > > >
> > > > > I'll try to fix this.
> > > >
> > > > Thanks.
> > > >
> > > > > In any case I think I've spotted what is really happening here and it
> > > > > isn't a failure but a feature :-D The build is specifying
> > > >
> > > > I get it.
> > > >
> > > > > LIBBPF_DYNAMIC=1 which means you get the libbpf headers from
> > > > > /usr/include. I think the build is trying to do this on a system with
> > > > > an old libbpf and hence getting the failures above. Previously, even
> > > > > though we wanted the dynamic headers we still had a -I, this time for
> > > > > the install_headers version. Now you really are using the system
> > > > > version and it is broken. This means a few things:
> > > > > - the libbpf feature test should fail if code like above is going to fail,
> > > >
> > > > Agreed.
> > > >
> > > > > - we may want to contemplate supporting older libbpfs (I'd rather not),
> > > >
> > > > I'd rather require everybody to be up to the latest trends, but I really
> > > > don't think that is a reasonable expectation.
> > > >
> > > > > - does build-test have a way to skip known issues like this?
> > > >
> > > > Unsure, Jiri?
> > >
> > > I don't think so it just triggers the build, it's up to the features check
> > > to disable the feature if the library is not compatible with perf code
> > >
> > > could we add that specific libbpf call to the libbpf feature check?
> >
> > Looking at the failure closer, the failing code is code inside a
> > feature check trying to workaround the feature not being present. We
> > need to do something like:
> >
> > ```
> > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > index 6e9b06cf06ee..a1c3cc230273 100644
> > --- a/tools/perf/util/bpf-loader.c
> > +++ b/tools/perf/util/bpf-loader.c
> > @@ -33,17 +33,18 @@
> > #include <internal/xyarray.h>
> >
> > #ifndef HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
> > -int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
> > -                          struct bpf_insn *new_insns __maybe_unused,
> > size_t new_insn_cnt __maybe_un
> > used)
> > +static int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
> > +                                 struct bpf_insn *new_insns __maybe_unused,
> > +                                 size_t new_insn_cnt __maybe_unused)
> > {
> >        pr_err("%s: not support, update libbpf\n", __func__);
> >        return -ENOTSUP;
> > }
> >
> > -int libbpf_register_prog_handler(const char *sec __maybe_unused,
> > -                                 enum bpf_prog_type prog_type __maybe_unused,
> > -                                 enum bpf_attach_type exp_attach_type
> > __maybe_unused,
> > -                                 const struct
> > libbpf_prog_handler_opts *opts __maybe_unused)
> > +static int libbpf_register_prog_handler(const char *sec __maybe_unused,
> > +                                       enum bpf_prog_type prog_type
> > __maybe_unused,
> > +                                       enum bpf_attach_type
> > exp_attach_type __maybe_unused,
> > +                                       const void *opts __maybe_unused)
> > {
> >        pr_err("%s: not support, update libbpf\n", __func__);
> >        return -ENOTSUP;
> > ```
> >
> > There are some other fixes necessary too. I'll try to write the fuller
> > patch but I have no means for testing except for undefining
> > HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS.
> >
> > Thanks,
> > Ian
> 
> So libbpf_prog_handler_opts is missing in the failing build, this
> points to a libbpf before 0.8. I'm somewhat concerned that to work
> around these linkage problems we're adding runtime errors - we may
> build but the functionality is totally crippled. Is it worth
> maintaining these broken builds or to just upfront fail the feature
> test?

Probably better to make the feature test disable bpf support while
emitting a warning that features such as a, b, and c won't we available.

- Arnaldo
 
> We can also switch the feature tests for LIBBPF_MAJOR_VERSION and
> LIBBPF_MINOR_VERSION checks. This would have the property of letting
> us tie the error messages to what version of libbpf is assumed.
> 
> In this case we could have a feature test for the libbpf version and
> if the version is before libbpf 0.8 fail the feature check. A quick
> way to do this is:
> ```
> diff --git a/tools/build/feature/test-libbpf.c
> b/tools/build/feature/test-libbpf.c
> index a508756cf4cc..dadd8186b71d 100644
> --- a/tools/build/feature/test-libbpf.c
> +++ b/tools/build/feature/test-libbpf.c
> @@ -1,6 +1,10 @@
> // SPDX-License-Identifier: GPL-2.0
> #include <bpf/libbpf.h>
> 
> +#if (LIBBPF_MAJOR_VERSION == 0) && (LIBBPF_MINOR_VERSION < 8)
> +#error At least libbpf 0.8 is assumed for Linux tools.
> +#endif
> +
> int main(void)
> {
>        return bpf_object__open("test") ? 0 : -1;
> ```
> 
> Thanks,
> Ian
> 
> > > jirka
> > >
> > > >
> > > > But yeah, previous experiences with Andrii were that we can do not too
> > > > costly feature checks, not using .c programs that would fail if some
> > > > required feature wasn't present but instead would just do some grep on a
> > > > header and if some "smell" wasn't scent, just fail the cap query.
> > > >
> > > > - Arnaldo

-- 

- Arnaldo
