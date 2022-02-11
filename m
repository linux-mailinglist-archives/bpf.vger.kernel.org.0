Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7598D4B3143
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 00:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbiBKXcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 18:32:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353323AbiBKXcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 18:32:10 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DCAD5A
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:32:08 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r144so13230024iod.9
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NaGF3PjPsWCKOdw7IAHoTUfU6apsakNKzvbSPYkIHwY=;
        b=DCzTnyJdtYZuawDftpc4hnfwC6kW+yE2SN8qUnRwicM0zZwmEJvATt8ABRJAbPiu13
         Sw0IqQY7aYp6nI1spcvqRuUNcAYuWy016YqGnNwGf1oU14uOQ9C/2s1YEIguyJRvWCoA
         RE/yC66Xy+7Jlpv2uZlk0B8DdfU8qNptAt7txhfXwwcNZbRvukS4AnetI5UKrZUU35uH
         FQnhuMLeVyUO1JMULX3qhGlqz/ZW4NEQY94bZ07wJeA5+IyXHYwwCL4TCjyuLDnEJwCy
         iugviHOXewpfKcJEGcdXkwyDzrFEPRNXhT2quRzlfKyyYso7YaAOiFQtk6JFcuWmCMzs
         M13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NaGF3PjPsWCKOdw7IAHoTUfU6apsakNKzvbSPYkIHwY=;
        b=Rfk9Pr5QnPoFPObRZNrhSsAx4/ewNSpWZ7/ophoszULyxvC8aw64U1L9mxygLrMTOs
         bkty7gcBM3Dvo1a0MWXc5WB+EMPyYriZog1T8Qp7F91cd0TySP4IbRPHsoUMGd2uxvFj
         P3WRkoFsNsw2YOCovam6B7NIeBnFZMr2HPYTHE5Q+l8xULFXitVLsb0GBVTSWUCrfhTJ
         fH2u+cFFX9Qq9yrO9Itam4viHbAGNGhoN41/YCTJY92GkmSRRn3etZvzDYyNQ47Z2OqK
         8tJxfKhFpLK7ZqtVddD54cgjlCw4Y3tTXNqaybC9wgB6PlPcOgJxLiWeJOZYwiUrco/9
         pfJA==
X-Gm-Message-State: AOAM533uq5JccdWijOraxIiEnLeUvT2VZkWCB5Mq5rrt+l+t/8vNLCQj
        FE7az86l8kfxv58a99vQ23zOGGkSRzXnyoFvKwU=
X-Google-Smtp-Source: ABdhPJyYhQtEtG8KMBTIzHg+U6pM4KTlAMB9dXHEX3JqSvu742Q2tFE4b3h0HX5nUN6U12M5/XC0fvXlvw61vBmbg3s=
X-Received: by 2002:a05:6638:d88:: with SMTP id l8mr2170504jaj.234.1644622327868;
 Fri, 11 Feb 2022 15:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-4-andrii@kernel.org>
 <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Feb 2022 15:31:56 -0800
Message-ID: <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling selftest
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
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

On Fri, Feb 11, 2022 at 3:13 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 11, 2022 at 01:14:50PM -0800, Andrii Nakryiko wrote:
> > Add a selftest validating various aspects of libbpf's handling of custom
> > SEC() handlers. It also demonstrates how libraries can ensure very early
> > callbacks registration and unregistration using
> > __attribute__((constructor))/__attribute__((destructor)) functions.
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++++++++++
> >  .../bpf/progs/test_custom_sec_handlers.c      |  63 +++++++
> >  2 files changed, 239 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > new file mode 100644
> > index 000000000000..28264528280d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Facebook */
> > +
> > +#include <test_progs.h>
> > +#include "test_custom_sec_handlers.skel.h"
> > +
> > +#define COOKIE_ABC1 1
> > +#define COOKIE_ABC2 2
> > +#define COOKIE_CUSTOM 3
> > +#define COOKIE_FALLBACK 4
> > +#define COOKIE_KPROBE 5
> > +
> > +static int custom_init_prog(struct bpf_program *prog, long cookie)
> > +{
> > +     if (cookie == COOKIE_ABC1)
> > +             bpf_program__set_autoload(prog, false);
> > +
> > +     return 0;
> > +}
>
> What is the value of init_fn callback?
> afaict it was and still unused in libbpf.
> The above example doesn't make a compelling case, since set_autoload
> can be done out of preload callback.
> Maybe drop init_fn for now and extend libbpf_prog_handler_opts
> when there is actual need for it?

Great question, but no, you can't set_autoload() in the preload
handler, because once preload is called, loading of the program is
inevitable.

We might need to adjust the obj->loaded flag so that set_autoload()
returns an error when called from the preload() callback, but that's a
bit orthogonal. I suspect there will be few more adjustments like this
as we get actual users of this API in the wild.

It's not used by libbpf because we do all the initialization outside
of the callback, as it is the same for all programs and serves as
"default" behavior that custom handlers can override.

Also, keep in mind that this is the very beginning of v0.8 dev cycle,
we'll have time to adjust interfaces and callback contracts in the
next 2-3 months, if necessary. USDT library open-sourcing will almost
100% happen during this time frame (though I think USDT library is a
pretty simple use case, so isn't a great "stress test"). But it also
seems like perf might need to use fallback handler for their crazy
SEC() conventions, that will be a good test as well.
