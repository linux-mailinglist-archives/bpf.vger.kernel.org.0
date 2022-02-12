Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2DB4B31D8
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 01:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiBLASk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 19:18:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354367AbiBLASi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 19:18:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8DD76
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 16:18:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso9095528pjj.1
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tv1RwhDDvAXN7IM8e3BduJ11NixN20EYOsnvSUoh0R0=;
        b=N/XARbSMA9NJ4rtxoS7LjTGWgcJVpSe1aU3xAMDxlAEow/uYnO+5Mz/cT9YG+QgMND
         UFo0pGHun03J8zgCT3+htzWWeEM415GKiTFWxEN6lJ+L6lF1hR07Y+UCEzX6KA2am+at
         F2/IR/dRbod25jwmaxuP0KMQFLwNu6E1rYvfQI2tvns3FmmYfDZ4unlOXJ6hQstxwbCu
         sZEMm+LZUlUhEG/uXd5CcR24wAsepQQyzQ8zV7GcQY7SvN8WAllefqzBdSKV64lmT+XD
         5lNcYIOcJNU80HG141GRUhjKGTkWKZPwhXyueztziPX31elXv4M81K6zL7xFcz/yINDj
         pmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tv1RwhDDvAXN7IM8e3BduJ11NixN20EYOsnvSUoh0R0=;
        b=zpyaXazn6Whqew+nv9fzGxCsd0MGP+73E/Kocto8qFolr3H7wBhhPk64dFJrLv6Rou
         fhnVkLyTgwWumLah0xRFVMx2eJd8rMseIuUTi4RUWyBXHCN35kGjs7L1lg4mSyKg5RHq
         3TGZATEu77+1vlLaON+X9cB3xAzT8myCZGXIstOXyZZITYn1WJTnZi8n9KYqQ34UVDsG
         z1CBZNXOPwT5G8hHz5edWcxXOwBgrcQ89lq5XMW+DR32x/4edDVRIDJx8tStiBjJyoca
         UaKMY79GbdMkfZ0YJegkNRkTT+p4FS3K9HoJZgJRDbHda03/3WeK26o14mHpuvkF76qT
         4Bxg==
X-Gm-Message-State: AOAM530FBPH/jSv407AZgDd+7wbhGjKYfMk0r1n2TXBAOQWqUALkYcSO
        TDImEq3wezuA/7YqGGm6JZk=
X-Google-Smtp-Source: ABdhPJxqUusjimEbj3qF+G2PEGRo5mycu+8b87R4Cy0xSQFholh+LZqKHve94DNCY3DoobVGDvEHWg==
X-Received: by 2002:a17:902:b68b:: with SMTP id c11mr3925252pls.116.1644625115742;
        Fri, 11 Feb 2022 16:18:35 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:eb33])
        by smtp.gmail.com with ESMTPSA id e14sm3954201pgt.1.2022.02.11.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 16:18:35 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:18:32 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling
 selftest
Message-ID: <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com>
References: <20220211211450.2224877-1-andrii@kernel.org>
 <20220211211450.2224877-4-andrii@kernel.org>
 <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 11, 2022 at 03:31:56PM -0800, Andrii Nakryiko wrote:
> On Fri, Feb 11, 2022 at 3:13 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Feb 11, 2022 at 01:14:50PM -0800, Andrii Nakryiko wrote:
> > > Add a selftest validating various aspects of libbpf's handling of custom
> > > SEC() handlers. It also demonstrates how libraries can ensure very early
> > > callbacks registration and unregistration using
> > > __attribute__((constructor))/__attribute__((destructor)) functions.
> > >
> > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++++++++++
> > >  .../bpf/progs/test_custom_sec_handlers.c      |  63 +++++++
> > >  2 files changed, 239 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > > new file mode 100644
> > > index 000000000000..28264528280d
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > > @@ -0,0 +1,176 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2022 Facebook */
> > > +
> > > +#include <test_progs.h>
> > > +#include "test_custom_sec_handlers.skel.h"
> > > +
> > > +#define COOKIE_ABC1 1
> > > +#define COOKIE_ABC2 2
> > > +#define COOKIE_CUSTOM 3
> > > +#define COOKIE_FALLBACK 4
> > > +#define COOKIE_KPROBE 5
> > > +
> > > +static int custom_init_prog(struct bpf_program *prog, long cookie)
> > > +{
> > > +     if (cookie == COOKIE_ABC1)
> > > +             bpf_program__set_autoload(prog, false);
> > > +
> > > +     return 0;
> > > +}
> >
> > What is the value of init_fn callback?
> > afaict it was and still unused in libbpf.
> > The above example doesn't make a compelling case, since set_autoload
> > can be done out of preload callback.
> > Maybe drop init_fn for now and extend libbpf_prog_handler_opts
> > when there is actual need for it?
> 
> Great question, but no, you can't set_autoload() in the preload
> handler, because once preload is called, loading of the program is
> inevitable.

Ahh!, but we can add 'if (prog->load)' in bpf_object_load_prog_instance()
after preload_fn() was called.
Surely the libbpf would waste some time preping the prog with relos,
but that's not a big deal.
Another option is to move preload_fn earlier.
Especially since currently it's only setting attach types.

Calling the callback 'preload' when it cannot affect the load is odd too.

> We might need to adjust the obj->loaded flag so that set_autoload()
> returns an error when called from the preload() callback, but that's a
> bit orthogonal. I suspect there will be few more adjustments like this
> as we get actual users of this API in the wild.
> 
> It's not used by libbpf because we do all the initialization outside
> of the callback, as it is the same for all programs and serves as
> "default" behavior that custom handlers can override.
> 
> Also, keep in mind that this is the very beginning of v0.8 dev cycle,
> we'll have time to adjust interfaces and callback contracts in the
> next 2-3 months, if necessary. USDT library open-sourcing will almost
> 100% happen during this time frame (though I think USDT library is a
> pretty simple use case, so isn't a great "stress test"). But it also
> seems like perf might need to use fallback handler for their crazy
> SEC() conventions, that will be a good test as well.

It would be much easier to take your word if there was an actual example
(like libusdt) that demonstrates the use of callbacks.
"We will have time to fix things before release" isn't very comforting
in the case of big api extension like this one.
