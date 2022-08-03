Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6608589008
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiHCQLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiHCQLs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 12:11:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9A632DAA
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 09:11:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tk8so32314884ejc.7
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LULOdmMImFHvi86I83XVdMzQKQVIPexAidsGV1AbhXo=;
        b=f69i9CiVOJ2AqM7uR3TDRNqNikF1hF2CBV94Bgj/O7rtpWFPmeG3rvK0RFiQaKbZGB
         dEWF+D9ogcEB7kTKphK7uW18fisdODOiFG+tMNLgO/FdCqciSUiBMTCBbjYIr5iLEt8T
         AL3Bn2eeGewFN8hNaSRNLDybebNBbpPSqCf+NNti1JEpSTcnLZe/dSgy+pixLiOhb0g2
         u+QXFYqkSIuHtbygLsjjZ8Ddnxdu7w0WZAFypRnbYy/8dIVxQfO1VkuzKFspfPu1KF26
         M50LMd80QAVWkhkPDT5iP/Fp/OMd4lfQIOJhXasUnkzc9eJddAcbs8YvjDy4AE714uoB
         YO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LULOdmMImFHvi86I83XVdMzQKQVIPexAidsGV1AbhXo=;
        b=o729Bnd++BBQeoYjCrjInndtQM/bXmAqE/jnl/vVAAs0bb/61/REDDzRLQc/32sM8c
         pqB02xwqKPDTJNNkCXQKQIGcd2+VBVCV83rYUI9I8DUJ66W4SXY6eawVWoM2VbWPbnx5
         ZoQnF03yH3qk1lVdI6ArWQnfBbtHuH9wOB+Dn20bS9LPhz0OFormVJ15tVCZhvxPBti2
         tmzHgjhu6BiJOdeC2da+UDGq/yKH77gC6RZFQn9nQsihKfbkqGdAxDvcUo44LxK8Es1x
         V87JnqPjbJn7kPr0cZyVwT1ZNPRivp4xRYojoS3VLX+8sOR6TWx7BDazwiqUspFH4ugi
         l1AA==
X-Gm-Message-State: AJIora8xfHDugS/KpnxadVadAjn3KRxmk5P477i8UoJVWRm/NjBlvZXb
        WlSQDSgzSGHDQX8yEhYaBTMgXQds23oW7zpUqT8=
X-Google-Smtp-Source: AGRyM1ue7/bPK63S7/YmKvR4n/m2zYAfywbf/nbFzPrMa7c/5Lv2BcgliBfazqYWa00ZPFweMEi2N/hvL+Dcz0IiFdA=
X-Received: by 2002:a17:907:608f:b0:72b:7db9:4dc6 with SMTP id
 ht15-20020a170907608f00b0072b7db94dc6mr19899041ejc.463.1659543105200; Wed, 03
 Aug 2022 09:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-4-joannelkoong@gmail.com> <CAEf4Bzb2Jev=NpwzkKn8UPRe-99-3WcgySfGwOB6W8n-3E4G1g@mail.gmail.com>
 <CAJnrk1Yg75-pMX=T9AnXoCWhvRX+bA=DBkyj1Quci_zkazpZyg@mail.gmail.com> <CAEf4BzZVq2vG3DOx0Pa03ksucSYZK5=QKMPTO1NYqces4TPAJA@mail.gmail.com>
In-Reply-To: <CAEf4BzZVq2vG3DOx0Pa03ksucSYZK5=QKMPTO1NYqces4TPAJA@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 3 Aug 2022 09:11:33 -0700
Message-ID: <CAJnrk1aodZ84YjaHNcxPZhREA+nx4=2Rh=4Nx9NcmkYvWn6S0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Tue, Aug 2, 2022 at 5:53 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 2, 2022 at 3:56 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Mon, Aug 1, 2022 at 10:58 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > >
> > > > Test skb and xdp dynptr functionality in the following ways:
> > > >
> > > > 1) progs/test_xdp.c
> > > >    * Change existing test to use dynptrs to parse xdp data
> > > >
> > > >      There were no noticeable diferences in user + system time between
> > > >      the original version vs. using dynptrs. Averaging the time for 10
> > > >      runs (run using "time ./test_progs -t xdp_bpf2bpf"):
> > > >          original version: 0.0449 sec
> > > >          with dynptrs: 0.0429 sec
> > > >
> > > > 2) progs/test_l4lb_noinline.c
> > > >    * Change existing test to use dynptrs to parse skb data
> > > >
> > > >      There were no noticeable diferences in user + system time between
> > > >      the original version vs. using dynptrs. Averaging the time for 10
> > > >      runs (run using "time ./test_progs -t l4lb_all/l4lb_noinline"):
> > > >          original version: 0.0502 sec
> > > >          with dynptrs: 0.055 sec
> > > >
> > > >      For number of processed verifier instructions:
> > > >          original version: 6284 insns
> > > >          with dynptrs: 2538 insns
> > > >
> > > > 3) progs/test_dynptr_xdp.c
> > > >    * Add sample code for parsing tcp hdr opt lookup using dynptrs.
> > > >      This logic is lifted from a real-world use case of packet parsing in
> > > >      katran [0], a layer 4 load balancer
> > > >
> > > > 4) progs/dynptr_success.c
> > > >    * Add test case "test_skb_readonly" for testing attempts at writes /
> > > >      data slices on a prog type with read-only skb ctx.
> > > >
> > > > 5) progs/dynptr_fail.c
> > > >    * Add test cases "skb_invalid_data_slice" and
> > > >      "xdp_invalid_data_slice" for testing that helpers that modify the
> > > >      underlying packet buffer automatically invalidate the associated
> > > >      data slice.
> > > >    * Add test cases "skb_invalid_ctx" and "xdp_invalid_ctx" for testing
> > > >      that prog types that do not support bpf_dynptr_from_skb/xdp don't
> > > >      have access to the API.
> > > >
> > > > [0] https://github.com/facebookincubator/katran/blob/main/katran/lib/bpf/pckt_parsing.h
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  .../testing/selftests/bpf/prog_tests/dynptr.c |  85 ++++++++++---
> > > >  .../selftests/bpf/prog_tests/dynptr_xdp.c     |  49 ++++++++
> > > >  .../testing/selftests/bpf/progs/dynptr_fail.c |  76 ++++++++++++
> > > >  .../selftests/bpf/progs/dynptr_success.c      |  32 +++++
> > > >  .../selftests/bpf/progs/test_dynptr_xdp.c     | 115 ++++++++++++++++++
> > > >  .../selftests/bpf/progs/test_l4lb_noinline.c  |  71 +++++------
> > > >  tools/testing/selftests/bpf/progs/test_xdp.c  |  95 +++++++--------
> > > >  .../selftests/bpf/test_tcp_hdr_options.h      |   1 +
> > > >  8 files changed, 416 insertions(+), 108 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr_xdp.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > > index bcf80b9f7c27..c40631f33c7b 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > > @@ -2,6 +2,7 @@
> > > >  /* Copyright (c) 2022 Facebook */
> > > >
> > > >  #include <test_progs.h>
> > > > +#include <network_helpers.h>
> > > >  #include "dynptr_fail.skel.h"
> > > >  #include "dynptr_success.skel.h"
> > > >
> > > > @@ -11,8 +12,8 @@ static char obj_log_buf[1048576];
> > > >  static struct {
> > > >         const char *prog_name;
> > > >         const char *expected_err_msg;
> > > > -} dynptr_tests[] = {
> > > > -       /* failure cases */
> > > > +} verifier_error_tests[] = {
> > > > +       /* these cases should trigger a verifier error */
> > > >         {"ringbuf_missing_release1", "Unreleased reference id=1"},
> > > >         {"ringbuf_missing_release2", "Unreleased reference id=2"},
> > > >         {"ringbuf_missing_release_callback", "Unreleased reference id"},
> > > > @@ -42,11 +43,25 @@ static struct {
> > > >         {"release_twice_callback", "arg 1 is an unacquired reference"},
> > > >         {"dynptr_from_mem_invalid_api",
> > > >                 "Unsupported reg type fp for bpf_dynptr_from_mem data"},
> > > > +       {"skb_invalid_data_slice", "invalid mem access 'scalar'"},
> > > > +       {"xdp_invalid_data_slice", "invalid mem access 'scalar'"},
> > > > +       {"skb_invalid_ctx", "unknown func bpf_dynptr_from_skb"},
> > > > +       {"xdp_invalid_ctx", "unknown func bpf_dynptr_from_xdp"},
> > > > +};
> > > > +
> > > > +enum test_setup_type {
> > > > +       SETUP_SYSCALL_SLEEP,
> > > > +       SETUP_SKB_PROG,
> > > > +};
> > > >
> > > > -       /* success cases */
> > > > -       {"test_read_write", NULL},
> > > > -       {"test_data_slice", NULL},
> > > > -       {"test_ringbuf", NULL},
> > > > +static struct {
> > > > +       const char *prog_name;
> > > > +       enum test_setup_type type;
> > > > +} runtime_tests[] = {
> > > > +       {"test_read_write", SETUP_SYSCALL_SLEEP},
> > > > +       {"test_data_slice", SETUP_SYSCALL_SLEEP},
> > > > +       {"test_ringbuf", SETUP_SYSCALL_SLEEP},
> > > > +       {"test_skb_readonly", SETUP_SKB_PROG},
> > >
> > > nit: wouldn't it be better to add test_setup_type to dynptr_tests (and
> > > keep fail and success cases together)? It's conceivable that you might
> > > want different setups to test different error conditions, right?
> >
> > Yeah! I originally separated it out because the success tests don't
> > have an error message while the fail ones do, and fail ones don't have
> > a setup (I don't think we'll need any custom userspace setup for those
> > since we're checking for verifier failures at prog load time) and the
> > success ones do. But I can combine them into 1 so that it's simpler. I
> > will do this in v2.
>
> great, thanks! you might actually need custom setup for SKB vs XDP
> programs if you are unifying bpf_dynptr_from_packet?

Yes I think so for the success cases (for the fail cases, I think just
having SEC("xdp") and SEC("tc") is sufficient)

>
> > >
> > > >  };
> > > >
> > > >  static void verify_fail(const char *prog_name, const char *expected_err_msg)
> > > > @@ -85,7 +100,7 @@ static void verify_fail(const char *prog_name, const char *expected_err_msg)
> > > >         dynptr_fail__destroy(skel);
> > > >  }
> > > >
>
> [...]
>
> > > > +/* The data slice is invalidated whenever a helper changes packet data */
> > > > +SEC("?xdp")
> > > > +int xdp_invalid_data_slice(struct xdp_md *xdp)
> > > > +{
> > > > +       struct bpf_dynptr ptr;
> > > > +       struct ethhdr *hdr1, *hdr2;
> > > > +
> > > > +       bpf_dynptr_from_xdp(xdp, 0, &ptr);
> > > > +       hdr1 = bpf_dynptr_data(&ptr, 0, sizeof(*hdr1));
> > > > +       if (!hdr1)
> > > > +               return XDP_DROP;
> > > > +
> > > > +       hdr2 = bpf_dynptr_data(&ptr, 0, sizeof(*hdr2));
> > > > +       if (!hdr2)
> > > > +               return XDP_DROP;
> > > > +
> > > > +       hdr1->h_proto = 12;
> > > > +       hdr2->h_proto = 12;
> > > > +
> > > > +       if (bpf_xdp_adjust_head(xdp, 0 - (int)sizeof(*hdr1)))
> > > > +               return XDP_DROP;
> > > > +
> > > > +       /* this should fail */
> > > > +       hdr2->h_proto = 1;
> > >
> > > is there something special about having both hdr1 and hdr2? Wouldn't
> > > this test work with just single hdr pointer?
> >
> > Yes, this test would work with just 1 single hdr pointer (which is
> > what skb_invalid_data_slice does) but I wanted to ensure that this
> > also works in the case of multiple data slices. If you think this is
> > unnecessary / adds clutter, I can remove hdr2.
>
>
> I think testing two pointers isn't the point, so I'd keep the test
> minimal. It seems like testing two pointers should be in a success
> test, to prove it works, rather than as some side effect of an
> expected-to-fail test, no?

My intention was to test that two pointers doesn't work (eg that when
you have multiple data slices, changing the packet buffer should
invalidate all slices, so that any attempt to access any slice should
fail) so I think to test that this would have to stay in the
verifier_fail test. I think this test might be more confusing than
helpful, so I will just remove hdr2 for v2 :)

>
> >
> > >
> > > > +
> > > > +       return XDP_PASS;
> > > > +}
> > > > +
> > > > +/* Only supported prog type can create skb-type dynptrs */
> > >
> > > [...]
> > >
> > > > +       err = 1;
> > > > +
> > > > +       if (bpf_dynptr_from_skb(ctx, 0, &ptr))
> > > > +               return 0;
> > > > +       err++;
> > > > +
> > > > +       data = bpf_dynptr_data(&ptr, 0, 1);
> > > > +       if (data)
> > > > +               /* it's an error if data is not NULL since cgroup skbs
> > > > +                * are read only
> > > > +                */
> > > > +               return 0;
> > > > +       err++;
> > > > +
> > > > +       ret = bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
> > > > +       /* since cgroup skbs are read only, writes should fail */
> > > > +       if (ret != -EINVAL)
> > > > +               return 0;
> > > > +
> > > > +       err = 0;
> > >
> > > hm, if data is NULL you'll still report success if bpf_dynptr_write
> > > returns 0 or any other error but -EINVAL... The logic is a bit unclear
> > > here...
> > >
> > If data is NULL and bpf_dynptr_write returns 0 or any other error
> > besides -EINVAL, I think we report a failure here (err is set to a
> > non-zero value, which userspace checks against)
>
> oh, ok, I read it backwards. I find this "stateful increasing error
> number" pattern very confusing. Why not write it more
> straightforwardly as:
>
> if (bpf_dynptr_from_skb(...)) {
>     err = 1;
>     return 0;
> }
>
> data = bpf_dynptr_data(...);
> if (data) {
>     err = 2;
>     return 0;
> }
>
> ret = bpf_dynptr_write(...);
> if (ret != -EINVAL) {
>     err = 3;
>     return 0;
> }
>
> /* all tests passed */
> err = 0;
> return 0;
>
> ?
>

My thinking was that err++ would be more robust (eg if you add another
case to the code, then you don't have to go down and fix all the err
numbers to adjust them by 1). But you're right, I think this just ends
up being confusing / non-intuitive to read. I will change it to the
more explicit way for v2

> >
> > > > +
> > > > +       return 0;
> > > > +}
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c b/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> > > > new file mode 100644
> > > > index 000000000000..c879dfb6370a
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/progs/test_dynptr_xdp.c
> > > > @@ -0,0 +1,115 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
>
> [...]
>
> > > > +       hdr_len = data[1];
> > > > +       if (hdr_len > *hdr_bytes_remaining)
> > > > +               return -1;
> > > > +
> > > > +       if (kind == tcp_hdr_opt_kind_tpr) {
> > > > +               if (hdr_len != tcp_hdr_opt_len_tpr)
> > > > +                       return -1;
> > > > +
> > > > +               memcpy(server_id, (__u32 *)(data + 2), sizeof(*server_id));
> > >
> > > this implicitly relies on compiler inlining memcpy, let's use
> > > __builtint_memcpy() here instead to set a good example?
> >
> > Sounds good, I will change this for v2. Should memcpys in bpf progs
> > always use __builtin_memcpy or is it on a case-by-case basis where if
> > the size is small enough, then you use it?
>
> __builtin_memcpy() is best. When we write just "memcpy()" we still
> rely on compiler to actually optimizing that to __builtin_memcpy(),
> because there is no memcpy() (we'd get unrecognized extern error if
> compiler actually emitted call to memcpy()).

Ohh I see, thanks for the explanation!

I am going to do some selftests cleanup this week, so I'll change the
other usages of memcpy() to __builtin_memcpy() as part of that clean
up.

>
> > >
> > > > +               return 1;
> > > > +       }
> > > > +
> > > > +       *off += hdr_len;
> > > > +       *hdr_bytes_remaining -= hdr_len;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
>
> [...]
