Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED274B325E
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 02:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354531AbiBLBQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 20:16:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbiBLBQj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 20:16:39 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714AFD5C
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 17:16:37 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n17so13468685iod.4
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 17:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4ENLH9F2DL2DVk3yYxb+H2OZIMLjcp9YgZQFAM+HaY=;
        b=FLhBzplDshPAx5cVcBM25LKL0Gs8DvtYV3fz7Kzmo7Yw7NvE5RYYUxa0YdFtaWFT1s
         zw14P60mNni+psRP3N8GAVlTAnWF8D1Wibtwoc9fxfXuRhqyildwbEkRl1wvwDnWGXV+
         uPwUltXpoBHx78BVTfp+zoKE4oh4VOe12NQdHzkM3zPkFv63T6lQjxG1W9dd0RJkz8nP
         8YHfBqL5biy1e+GQ2awcvTPA0U5vnm6SQ5qSE7cHDyVoqd1GmrG4QdNC53Nvy69v5way
         8UsYGIW1Pge530HUpmo/87yj6Kh2zSWFfUWGusgOR5fxNQnCTlB5b4YZf8waJjw+M9SB
         y0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4ENLH9F2DL2DVk3yYxb+H2OZIMLjcp9YgZQFAM+HaY=;
        b=Zw/vkG0uDRliZowtEhBHvREzkf5RSXrlqxufcuPDmV3kyqfslDSZ9Kdb4ABb1LlZJR
         RXDzBk6tkbFfsrh8cw9MyfFC+wRuxZoDWyuB+WhE5wrS1l8QeJYHgKAAq0y31FQDfkMN
         OzCWzxA6HKEa99qFVbmIbU6daf281PStf6rgkusTnn5q9wXzYYHwGD3KRZmLjPXDU39n
         MGqirCF0QB6QeSk+wEhtl9Hq8yHTISiwrtbXSuRRuWW2mRQY0mgqKMtx+dqMVbq/PDms
         GhPsb4TFxYjlzIu1EorOkoFAmT7AfA2C+U6IC8yu5Bc32qU5dqxGHq4mZg/f1mbTkzQU
         QYMg==
X-Gm-Message-State: AOAM533LTKqtfqnlkqR2Y/uWr6pymUs348nKa77RZsfdCoG6qhK4rCYQ
        3gBGNqKhi2tFzcJ42ukFP4fh7/s8+0iNuHyHJok=
X-Google-Smtp-Source: ABdhPJxyGnAThgddXlO03mJAtaiMNt3eDwU6H0NtCnJSFp9xq0ZUDlES3zm3EXG2P5YPllD7nM14Q9woi1S+M6DQBOc=
X-Received: by 2002:a5e:8406:: with SMTP id h6mr2198859ioj.144.1644628596759;
 Fri, 11 Feb 2022 17:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-4-andrii@kernel.org>
 <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com> <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Feb 2022 17:16:25 -0800
Message-ID: <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com>
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

On Fri, Feb 11, 2022 at 4:18 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 11, 2022 at 03:31:56PM -0800, Andrii Nakryiko wrote:
> > On Fri, Feb 11, 2022 at 3:13 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Feb 11, 2022 at 01:14:50PM -0800, Andrii Nakryiko wrote:
> > > > Add a selftest validating various aspects of libbpf's handling of custom
> > > > SEC() handlers. It also demonstrates how libraries can ensure very early
> > > > callbacks registration and unregistration using
> > > > __attribute__((constructor))/__attribute__((destructor)) functions.
> > > >
> > > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++++++++++
> > > >  .../bpf/progs/test_custom_sec_handlers.c      |  63 +++++++
> > > >  2 files changed, 239 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > > > new file mode 100644
> > > > index 000000000000..28264528280d
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > > > @@ -0,0 +1,176 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright (c) 2022 Facebook */
> > > > +
> > > > +#include <test_progs.h>
> > > > +#include "test_custom_sec_handlers.skel.h"
> > > > +
> > > > +#define COOKIE_ABC1 1
> > > > +#define COOKIE_ABC2 2
> > > > +#define COOKIE_CUSTOM 3
> > > > +#define COOKIE_FALLBACK 4
> > > > +#define COOKIE_KPROBE 5
> > > > +
> > > > +static int custom_init_prog(struct bpf_program *prog, long cookie)
> > > > +{
> > > > +     if (cookie == COOKIE_ABC1)
> > > > +             bpf_program__set_autoload(prog, false);
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > What is the value of init_fn callback?
> > > afaict it was and still unused in libbpf.
> > > The above example doesn't make a compelling case, since set_autoload
> > > can be done out of preload callback.
> > > Maybe drop init_fn for now and extend libbpf_prog_handler_opts
> > > when there is actual need for it?
> >
> > Great question, but no, you can't set_autoload() in the preload
> > handler, because once preload is called, loading of the program is
> > inevitable.
>
> Ahh!, but we can add 'if (prog->load)' in bpf_object_load_prog_instance()
> after preload_fn() was called.

Yes we can and solve this *one specific* scenario. But there is a
bunch of preparatory stuff that's happening for bpf_program before we
get to actually loading finalized instructions. All the relocations,
marking whether we need vmlinux BTF, etc. All that is skipped if
!prog->load.

I don't want to go and analyze every single possible scenario (and
probably still miss a bunch of subtle ones) to understand if it's
always equivalent. Libbpf's contract is that
bpf_program__set_autoload() is called before bpf_object__load(). You
are asking me to redesign this contract to move it much deeper into
bpf_object__load() (and potentially break a bunch of subtle things)
just to avoid init_fn callback. Hard sell :)

Basically, init_fn is allowed to do everything that normal user code
is allowed to do between bpf_object__open() and bpf_object__load().
preload_fn() doesn't have this luxury, but gets access to
bpf_prog_load opts that normal user code doesn't have access, but it's
not free to do all the stuff that user is free to do before
bpf_object__load(). They are not interchangeable.

> Surely the libbpf would waste some time preping the prog with relos,
> but that's not a big deal.
> Another option is to move preload_fn earlier.
> Especially since currently it's only setting attach types.

It should be able to affect logging and all the attach parameter. I
didn't want to design new OPTS struct just for this callback, so I'm
trying to reuse bpf_prog_load_opts as a contract. That means I can't
easily change prog_type (but that's trivial to handle in init_fn) and
insns (but I can hardly see how that can be done safely at all), but
otherwise those opts give the full power of low-level bpf_prog_load.

I keep a possibility open to change preload_fn contract to actually
execute bpf_prog_load() on its own and return prog fd, but I'm
hesitant because all the libbpf log handling and retries, and other
niceties will be lost, making trivial things like adding extra
BPF_F_SLEEPABLE flag not trivial at all. But here's the thing, we can
later add "advanced" load callback that will be mutually exclusive
with preload_fn and would be able to handle more advanced cases. But
that can be done as an extra extension without changing anything about
current interface.

>
> Calling the callback 'preload' when it cannot affect the load is odd too.

It's what happening before loading, I never had intention to prevent
load... Would "prepare_load_fn" be a better name?

>
> > We might need to adjust the obj->loaded flag so that set_autoload()
> > returns an error when called from the preload() callback, but that's a
> > bit orthogonal. I suspect there will be few more adjustments like this
> > as we get actual users of this API in the wild.
> >
> > It's not used by libbpf because we do all the initialization outside
> > of the callback, as it is the same for all programs and serves as
> > "default" behavior that custom handlers can override.
> >
> > Also, keep in mind that this is the very beginning of v0.8 dev cycle,
> > we'll have time to adjust interfaces and callback contracts in the
> > next 2-3 months, if necessary. USDT library open-sourcing will almost
> > 100% happen during this time frame (though I think USDT library is a
> > pretty simple use case, so isn't a great "stress test"). But it also
> > seems like perf might need to use fallback handler for their crazy
> > SEC() conventions, that will be a good test as well.
>
> It would be much easier to take your word if there was an actual example
> (like libusdt) that demonstrates the use of callbacks.
> "We will have time to fix things before release" isn't very comforting
> in the case of big api extension like this one.

Hmm. For libusdt it would be literally:

libbpf_register_prog_handler("usdt", BPF_PROG_TYPE_KPROBE, 0, NULL);

Done.

There is no way (at least currently) to support auto-attach through
skeleton__attach() or bpf_program__attach(), because single USDT
attachment is actually multiple program attachments (due to inlining).
So until libbpf provides APIs to construct "composite" bpf_link from a
single link, there won't be auto-attach. We might add it later, but I
don't want to design the entire world in one patch set :)

USDT is too simple a use case, perhaps. I'm trying to also take into
consideration perf's custom SEC("lock_page=__lock_page page->flags")
use case, hypothetical SEC("perf_event/cpu_cycles:1000") case, and
just thinking from the "first principles" what some advanced library
might what to be able to do with this. Alan's uprobe attach by
function name would be implementable through these APIs outside of
libbpf as well (except then we won't be able to add func_name into
bpf_uprobe_opts, which would be a pity).

I can postpone this whole patch set until later as well, don't care
all that much. I hate callback APIs anyways :)

We can do USDT library without all this and the user experience won't
change all that much, actually.
