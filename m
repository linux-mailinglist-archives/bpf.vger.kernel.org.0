Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA7413DD5
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhIUXKk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 19:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhIUXKk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 19:10:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5697FC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:09:11 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t4so2890884qkb.9
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoY1MvjodBHwsp1sLEQd5Il8otRonscwa0g/4GtFFjk=;
        b=Ha2EnFGyP/tqVmcTclWU45AjtHfe79n/i0El8A8XGzGHtvkN8Vy6DNRAjtSskRvC6h
         NXF0PA9VSniXUiMbxsjRpaAmK/hnOr/K/sohKPh1J6efn9jfkNZWD7NaAiom2iLa+4Os
         vX6jdjVeSd4BylI9EKkBAYNRoq5JmhYVJ5N/qhVeBy2IYbGbLeQoKbK535QxK14XZeAB
         XBBbDHebWiZERlx+tdVpNku2ZZnsRA3YrrqFRStjuUp0HJQYFoEhpNzXCDYg60aB6YRF
         WucXNbdaaTuTLcusW3LrkxTCejv7R9ylz2y+nGO3heQiGn7tQWzAMJHPOmlAqEFAg0oS
         hiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoY1MvjodBHwsp1sLEQd5Il8otRonscwa0g/4GtFFjk=;
        b=pv/4pqoopYDH9D2C2t2DLlkK+oEgUqvq/uqqJW1JpNOEk2w9HeuuzD1eehpVR9emo0
         7us211zkR0llBLsqqQz3GNdY8llvTptHjZmzUV2/Fahi9LEY52huFrmg05cQWBtJ7KxM
         n39TI+KGhSy6SdWpGDLf0m91mGMbSKyrM3pKKVXsSq2jLe4VhilD2Ng3ytzfWFEf52Ec
         YgzUQxbidP6brxcCBFvvdd3DGm542lGfyUg00oiJlG6ZFfiaSDwt5h5UztEHtV2fsZVw
         2Fdxh5pqNACkvCZWpJS+yyQVgLJHnSwqV6OPa8edYZnvLiGPCkeibAOPKkHkHqX/JYEB
         vVJQ==
X-Gm-Message-State: AOAM533wSuA87d1/Kt+nFU9IKNoMKRhUl7AnGakIQ97kkK3686BemNC/
        RSqsuBEgkZwTGrL39//sdNC3U3guR2CrLsBJntpZk2A+
X-Google-Smtp-Source: ABdhPJzpUZ7xILHNCniNJpYrmFS2xXw4e2L4f8ltH+oZkwvr3D01Fl1qemD+R7EVO6O8NNC/TKkWjaoxALVyn321sLI=
X-Received: by 2002:a25:1884:: with SMTP id 126mr24764992yby.114.1632265750513;
 Tue, 21 Sep 2021 16:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210920234320.3312820-1-andrii@kernel.org> <20210920234320.3312820-2-andrii@kernel.org>
 <4ab8049e-7e06-17b3-56ab-f1776cdf5e5e@fb.com>
In-Reply-To: <4ab8049e-7e06-17b3-56ab-f1776cdf5e5e@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 16:08:59 -0700
Message-ID: <CAEf4BzbV7M5Uhsw+OtE+JdaJ17ragpfyKXAT9=1yoec4jhq4nA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/9] selftests/bpf: normalize XDP section
 names in selftests
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 20, 2021 at 9:55 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/20/21 7:43 PM, Andrii Nakryiko wrote:
> > Convert almost all SEC("xdp_blah") uses to strict SEC("xdp") to comply
> > with strict libbpf 1.0 logic of exact section name match for XDP program
> > types. There is only one exception, which is only tested through
> > iproute2 and defines multiple XDP programs within the same BPF object.
> > Given iproute2 still works in non-strict libbpf mode and it doesn't have
> > means to specify XDP programs by its name (not section name/title),
> > leave that single file alone for now until iproute2 gains lookup by
> > function/program name.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Aside from a checkpatch nit which you didn't cause, LGTM. Some general
> comments follow as well, but aren't directly related to the patch.
>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
>
> >  tools/testing/selftests/bpf/progs/test_map_in_map.c         | 2 +-
> >  .../selftests/bpf/progs/test_tcp_check_syncookie_kern.c     | 2 +-
> >  tools/testing/selftests/bpf/progs/test_xdp.c                | 2 +-
> >  .../testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c | 2 +-
> >  .../selftests/bpf/progs/test_xdp_adjust_tail_shrink.c       | 4 +---
> >  tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c | 2 +-
> >  tools/testing/selftests/bpf/progs/test_xdp_link.c           | 2 +-
> >  tools/testing/selftests/bpf/progs/test_xdp_loop.c           | 2 +-
> >  tools/testing/selftests/bpf/progs/test_xdp_noinline.c       | 4 ++--
> >  .../selftests/bpf/progs/test_xdp_with_cpumap_helpers.c      | 4 ++--
> >  .../selftests/bpf/progs/test_xdp_with_devmap_helpers.c      | 4 ++--
> >  tools/testing/selftests/bpf/progs/xdp_dummy.c               | 2 +-
> >  tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c | 4 ++--
> >  tools/testing/selftests/bpf/progs/xdping_kern.c             | 4 ++--
> >  tools/testing/selftests/bpf/test_tcp_check_syncookie.sh     | 2 +-
> >  tools/testing/selftests/bpf/test_xdp_redirect.sh            | 4 ++--
> >  tools/testing/selftests/bpf/test_xdp_redirect_multi.sh      | 2 +-
> >  tools/testing/selftests/bpf/test_xdp_veth.sh                | 4 ++--
> >  tools/testing/selftests/bpf/xdping.c                        | 6 +++---
>
> Doesn't look like the test_...sh's here are run by the CI. Confirmed they
> (as well as test_xdping.sh) all passed for me. My test VM isn't doing anything
> special networking-wise, so maybe it's not too difficult to add these to CI.

Thanks for confirming. Yes, they are not run in CI, we only run
test_progs, test_verifier and test_maps. Instead of adding all those
small scripts to be run by CI, we are encouraging everyone to converge
on test_progs, because that's where we invest efforts to make it a
universal test runner for BPF needs. So I'd say let's convert them to
test_progs framework instead.

>
> >  19 files changed, 28 insertions(+), 30 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> > index 1cfeb940cf9f..5f0e0bfc151e 100644
> > --- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
> > +++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> > @@ -23,7 +23,7 @@ struct {

[...]

> >       void *data_end = (void *)(long)xdp->data_end;
> > diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
> > index 22065a9cfb25..b7448253d135 100644
> > --- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
> > +++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
> > @@ -9,9 +9,7 @@
> >  #include <linux/if_ether.h>
> >  #include <bpf/bpf_helpers.h>
> >
> > -int _version SEC("version") = 1;
> > -
>
> Didn't realize this was meant to specify kernel version for compat, and that
> it no longer does anything anyways. Maybe this should be removed from all
> selftests + examples to make this more obvious?

Yes, it should, but perhaps in a separate clean up series. Except I'd
leave it for BPF static linker testing, of course.

>
> > -SEC("xdp_adjust_tail_shrink")
> > +SEC("xdp")
> >  int _xdp_adjust_tail_shrink(struct xdp_md *xdp)
> >  {
> >       void *data_end = (void *)(long)xdp->data_end;
> > diff --git a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
> > index b360ba2bd441..807bf895f42c 100644
> > --- a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c

Note, it's generally a good idea to trim irrelevant parts in your
reply making it easier to see one's replies among the wall of text,
especially outside of gmail UI.

[...]

> > diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
> > index 842d9155d36c..f9798ead20a9 100644
> > --- a/tools/testing/selftests/bpf/xdping.c
> > +++ b/tools/testing/selftests/bpf/xdping.c
> > @@ -178,9 +178,9 @@ int main(int argc, char **argv)
> >               return 1;
> >       }
> >
> > -     main_prog = bpf_object__find_program_by_title(obj,
> > -                                                   server ? "xdpserver" :
> > -                                                            "xdpclient");
> > +     main_prog = bpf_object__find_program_by_name(obj,
> > +                                                   server ? "xdping_server" :
> > +                                                            "xdping_client");
>
> checkpatch doesn't like the text alignment here, not that you changed it

yeah, me neither, but not worth re-spin just for this :)

>
> >       if (main_prog)
> >               prog_fd = bpf_program__fd(main_prog);
> >       if (!main_prog || prog_fd < 0) {
> >
>
>
