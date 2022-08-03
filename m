Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55EE58852D
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 02:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiHCAxt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 20:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiHCAxs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 20:53:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BFD4C611
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 17:53:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y13so14769328ejp.13
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 17:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BlOWm/VMATHd5WatwKzvOVRPoxvLzDEDJdKCVrwZr+I=;
        b=eYmXpQzSlDT+EUkzZCDdhl6AC+HE9I7c6CpTYjl8KnpVvKrbEDFEMIKPbGoNtqtUWG
         vHmWZUkEdtI6JZykIl1G1k5Lulx2LVsmuFbxC40DpNah7BiO/7VeYCg0skVE2cUHN8Kx
         N+HOy3wMl2grCNPf/J3gO3tgcZ9iMSb8ehdp2JVGDvDhh99ScNgtQASfkh5nxIHDjBYk
         tq3wz1I1khGXHJQcdvWYq/s0NKzq3LeL5x1Lv01gFsVYgokCjzlZPvhCnxuSxOqRVBq4
         RjmgU0fyRBK+Kl0KhgB3d3DFgYZMulB54BVFZidikuDpnMepiOSJWtOEjR+vIXlab/ir
         3zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BlOWm/VMATHd5WatwKzvOVRPoxvLzDEDJdKCVrwZr+I=;
        b=U5EwYxtI7n/sYiwzmLy2H+uEv5cugMSXPXfp5KA3RYid2LsFH4++Kqm99dZFBq/dqu
         z0RL74yVyRhDtOgmA+bUKxyLDpc114L+0lrRKFJJCD49vCe3F9WbkEu+o99s4fEEGTDz
         Y7b+k0sSJjbqRzNGGvKggpVd0zzQKThRPPmVq5lHHCA0Y3hRSCf5wJFigkxPcwMrsrjE
         yl6q1ix4YrxoMm/oF2bCucG+uH+Lf/gRtInqz6OafvtLiwsG9+FFjpqjnceoH3rkUCC+
         zBz5sxhh6N53oeEDy0KHNlLJff4RWwNZBaGTcbXElKNsTI5NZXZsVxUHkTJe2UivVVkD
         Wlcw==
X-Gm-Message-State: ACgBeo01EOv6TFP4PzgutrZ14P/kE2U8ZHiLoWo9/vdNL+tlvi5gSz33
        DEZFEqJBZd0bpCe102PyCJOHWQj71JikjD8FFn8=
X-Google-Smtp-Source: AA6agR5T6ttK1Gs88kPLK8NyEEuxvG8s9Vs9+PcGtFRSdHiTRQKjYtLmqBXFHAyc7bhbeJQcT+kUdaRQZkHcwe7JSrY=
X-Received: by 2002:a17:907:1361:b0:730:8f59:6434 with SMTP id
 yo1-20020a170907136100b007308f596434mr8169568ejb.745.1659488025143; Tue, 02
 Aug 2022 17:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-4-joannelkoong@gmail.com> <CAEf4Bzb2Jev=NpwzkKn8UPRe-99-3WcgySfGwOB6W8n-3E4G1g@mail.gmail.com>
 <CAJnrk1Yg75-pMX=T9AnXoCWhvRX+bA=DBkyj1Quci_zkazpZyg@mail.gmail.com>
In-Reply-To: <CAJnrk1Yg75-pMX=T9AnXoCWhvRX+bA=DBkyj1Quci_zkazpZyg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 17:53:33 -0700
Message-ID: <CAEf4BzZVq2vG3DOx0Pa03ksucSYZK5=QKMPTO1NYqces4TPAJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Aug 2, 2022 at 3:56 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 10:58 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > Test skb and xdp dynptr functionality in the following ways:
> > >
> > > 1) progs/test_xdp.c
> > >    * Change existing test to use dynptrs to parse xdp data
> > >
> > >      There were no noticeable diferences in user + system time between
> > >      the original version vs. using dynptrs. Averaging the time for 10
> > >      runs (run using "time ./test_progs -t xdp_bpf2bpf"):
> > >          original version: 0.0449 sec
> > >          with dynptrs: 0.0429 sec
> > >
> > > 2) progs/test_l4lb_noinline.c
> > >    * Change existing test to use dynptrs to parse skb data
> > >
> > >      There were no noticeable diferences in user + system time between
> > >      the original version vs. using dynptrs. Averaging the time for 10
> > >      runs (run using "time ./test_progs -t l4lb_all/l4lb_noinline"):
> > >          original version: 0.0502 sec
> > >          with dynptrs: 0.055 sec
> > >
> > >      For number of processed verifier instructions:
> > >          original version: 6284 insns
> > >          with dynptrs: 2538 insns
> > >
> > > 3) progs/test_dynptr_xdp.c
> > >    * Add sample code for parsing tcp hdr opt lookup using dynptrs.
> > >      This logic is lifted from a real-world use case of packet parsing in
> > >      katran [0], a layer 4 load balancer
> > >
> > > 4) progs/dynptr_success.c
> > >    * Add test case "test_skb_readonly" for testing attempts at writes /
> > >      data slices on a prog type with read-only skb ctx.
> > >
> > > 5) progs/dynptr_fail.c
> > >    * Add test cases "skb_invalid_data_slice" and
> > >      "xdp_invalid_data_slice" for testing that helpers that modify the
> > >      underlying packet buffer automatically invalidate the associated
> > >      data slice.
> > >    * Add test cases "skb_invalid_ctx" and "xdp_invalid_ctx" for testing
> > >      that prog types that do not support bpf_dynptr_from_skb/xdp don't
> > >      have access to the API.
> > >
> > > [0] https://github.com/facebookincubator/katran/blob/main/katran/lib/bpf/pckt_parsing.h
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  .../testing/selftests/bpf/prog_tests/dynptr.c |  85 ++++++++++---
> > >  .../selftests/bpf/prog_tests/dynptr_xdp.c     |  49 ++++++++
> > >  .../testing/selftests/bpf/progs/dynptr_fail.c |  76 ++++++++++++
> > >  .../selftests/bpf/progs/dynptr_success.c      |  32 +++++
> > >  .../selftests/bpf/progs/test_dynptr_xdp.c     | 115 ++++++++++++++++++
> > >  .../selftests/bpf/progs/test_l4lb_noinline.c  |  71 +++++------
> > >  tools/testing/selftests/bpf/progs/test_xdp.c  |  95 +++++++--------
> > >  .../selftests/bpf/test_tcp_hdr_options.h      |   1 +
> > >  8 files changed, 416 insertions(+), 108 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > index bcf80b9f7c27..c40631f33c7b 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > @@ -2,6 +2,7 @@
> > >  /* Copyright (c) 2022 Facebook */
> > >
> > >  #include <test_progs.h>
> > > +#include <network_helpers.h>
> > >  #include "dynptr_fail.skel.h"
> > >  #include "dynptr_success.skel.h"
> > >
> > > @@ -11,8 +12,8 @@ static char obj_log_buf[1048576];
> > >  static struct {
> > >         const char *prog_name;
> > >         const char *expected_err_msg;
> > > -} dynptr_tests[] = {
> > > -       /* failure cases */
> > > +} verifier_error_tests[] = {
> > > +       /* these cases should trigger a verifier error */
> > >         {"ringbuf_missing_release1", "Unreleased reference id=1"},
> > >         {"ringbuf_missing_release2", "Unreleased reference id=2"},
> > >         {"ringbuf_missing_release_callback", "Unreleased reference id"},
> > > @@ -42,11 +43,25 @@ static struct {
> > >         {"release_twice_callback", "arg 1 is an unacquired reference"},
> > >         {"dynptr_from_mem_invalid_api",
> > >                 "Unsupported reg type fp for bpf_dynptr_from_mem data"},
> > > +       {"skb_invalid_data_slice", "invalid mem access 'scalar'"},
> > > +       {"xdp_invalid_data_slice", "invalid mem access 'scalar'"},
> > > +       {"skb_invalid_ctx", "unknown func bpf_dynptr_from_skb"},
> > > +       {"xdp_invalid_ctx", "unknown func bpf_dynptr_from_xdp"},
> > > +};
> > > +
> > > +enum test_setup_type {
> > > +       SETUP_SYSCALL_SLEEP,
> > > +       SETUP_SKB_PROG,
> > > +};
> > >
> > > -       /* success cases */
> > > -       {"test_read_write", NULL},
> > > -       {"test_data_slice", NULL},
> > > -       {"test_ringbuf", NULL},
> > > +static struct {
> > > +       const char *prog_name;
> > > +       enum test_setup_type type;
> > > +} runtime_tests[] = {
> > > +       {"test_read_write", SETUP_SYSCALL_SLEEP},
> > > +       {"test_data_slice", SETUP_SYSCALL_SLEEP},
> > > +       {"test_ringbuf", SETUP_SYSCALL_SLEEP},
> > > +       {"test_skb_readonly", SETUP_SKB_PROG},
> >
> > nit: wouldn't it be better to add test_setup_type to dynptr_tests (and
> > keep fail and success cases together)? It's conceivable that you might
> > want different setups to test different error conditions, right?
>
> Yeah! I originally separated it out because the success tests don't
> have an error message while the fail ones do, and fail ones don't have
> a setup (I don't think we'll need any custom userspace setup for those
> since we're checking for verifier failures at prog load time) and the
> success ones do. But I can combine them into 1 so that it's simpler. I
> will do this in v2.

great, thanks! you might actually need custom setup for SKB vs XDP
programs if you are unifying bpf_dynptr_from_packet?

> >
> > >  };
> > >
> > >  static void verify_fail(const char *prog_name, const char *expected_err_msg)
> > > @@ -85,7 +100,7 @@ static void verify_fail(const char *prog_name, const char *expected_err_msg)
> > >         dynptr_fail__destroy(skel);
> > >  }
> > >

[...]

> > > +/* The data slice is invalidated whenever a helper changes packet data */
> > > +SEC("?xdp")
> > > +int xdp_invalid_data_slice(struct xdp_md *xdp)
> > > +{
> > > +       struct bpf_dynptr ptr;
> > > +       struct ethhdr *hdr1, *hdr2;
> > > +
> > > +       bpf_dynptr_from_xdp(xdp, 0, &ptr);
> > > +       hdr1 = bpf_dynptr_data(&ptr, 0, sizeof(*hdr1));
> > > +       if (!hdr1)
> > > +               return XDP_DROP;
> > > +
> > > +       hdr2 = bpf_dynptr_data(&ptr, 0, sizeof(*hdr2));
> > > +       if (!hdr2)
> > > +               return XDP_DROP;
> > > +
> > > +       hdr1->h_proto = 12;
> > > +       hdr2->h_proto = 12;
> > > +
> > > +       if (bpf_xdp_adjust_head(xdp, 0 - (int)sizeof(*hdr1)))
> > > +               return XDP_DROP;
> > > +
> > > +       /* this should fail */
> > > +       hdr2->h_proto = 1;
> >
> > is there something special about having both hdr1 and hdr2? Wouldn't
> > this test work with just single hdr pointer?
>
> Yes, this test would work with just 1 single hdr pointer (which is
> what skb_invalid_data_slice does) but I wanted to ensure that this
> also works in the case of multiple data slices. If you think this is
> unnecessary / adds clutter, I can remove hdr2.


I think testing two pointers isn't the point, so I'd keep the test
minimal. It seems like testing two pointers should be in a success
test, to prove it works, rather than as some side effect of an
expected-to-fail test, no?

>
> >
> > > +
> > > +       return XDP_PASS;
> > > +}
> > > +
> > > +/* Only supported prog type can create skb-type dynptrs */
> >
> > [...]
> >
> > > +       err = 1;
> > > +
> > > +       if (bpf_dynptr_from_skb(ctx, 0, &ptr))
> > > +               return 0;
> > > +       err++;
> > > +
> > > +       data = bpf_dynptr_data(&ptr, 0, 1);
> > > +       if (data)
> > > +               /* it's an error if data is not NULL since cgroup skbs
> > > +                * are read only
> > > +                */
> > > +               return 0;
> > > +       err++;
> > > +
> > > +       ret = bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
> > > +       /* since cgroup skbs are read only, writes should fail */
> > > +       if (ret != -EINVAL)
> > > +               return 0;
> > > +
> > > +       err = 0;
> >
> > hm, if data is NULL you'll still report success if bpf_dynptr_write
> > returns 0 or any other error but -EINVAL... The logic is a bit unclear
> > here...
> >
> If data is NULL and bpf_dynptr_write returns 0 or any other error
> besides -EINVAL, I think we report a failure here (err is set to a
> non-zero value, which userspace checks against)

oh, ok, I read it backwards. I find this "stateful increasing error
number" pattern very confusing. Why not write it more
straightforwardly as:

if (bpf_dynptr_from_skb(...)) {
    err = 1;
    return 0;
}

data = bpf_dynptr_data(...);
if (data) {
    err = 2;
    return 0;
}

ret = bpf_dynptr_write(...);
if (ret != -EINVAL) {
    err = 3;
    return 0;
}

/* all tests passed */
err = 0;
return 0;

?

>
> > > +
> > > +       return 0;
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c b/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> > > new file mode 100644
> > > index 000000000000..c879dfb6370a
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> > > @@ -0,0 +1,115 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +

[...]

> > > +       hdr_len = data[1];
> > > +       if (hdr_len > *hdr_bytes_remaining)
> > > +               return -1;
> > > +
> > > +       if (kind == tcp_hdr_opt_kind_tpr) {
> > > +               if (hdr_len != tcp_hdr_opt_len_tpr)
> > > +                       return -1;
> > > +
> > > +               memcpy(server_id, (__u32 *)(data + 2), sizeof(*server_id));
> >
> > this implicitly relies on compiler inlining memcpy, let's use
> > __builtint_memcpy() here instead to set a good example?
>
> Sounds good, I will change this for v2. Should memcpys in bpf progs
> always use __builtin_memcpy or is it on a case-by-case basis where if
> the size is small enough, then you use it?

__builtin_memcpy() is best. When we write just "memcpy()" we still
rely on compiler to actually optimizing that to __builtin_memcpy(),
because there is no memcpy() (we'd get unrecognized extern error if
compiler actually emitted call to memcpy()).

> >
> > > +               return 1;
> > > +       }
> > > +
> > > +       *off += hdr_len;
> > > +       *hdr_bytes_remaining -= hdr_len;
> > > +
> > > +       return 0;
> > > +}
> > > +

[...]
