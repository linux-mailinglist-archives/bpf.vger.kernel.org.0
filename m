Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA014FA007
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 01:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiDHXSu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiDHXSs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 19:18:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED46136332
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 16:16:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 17so13303407lji.1
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hr9+Obr43Ugb+tftzzH4at8I9cFTTs8UC/mYzT3zrkY=;
        b=XC7T2dlkLlRK9BSFnzXcvtFe81TjfRbI6Rd7fXF7B/+rAqYfFMCL6S6HjCmtYgiPH4
         sd75N6aDGvLNXu9RPSl5JwDgdGIiexTq+r2laatIeGQy0Fslp9v5r2QWYQILhnWdxJdf
         JEAKTCur4rytPz6QqczTYpe3+x1KoWs1IkGOwpssk0yh6aw1tFvV2COD8HFiGiho83F4
         MqTqcU/rLedsKu64GWxhSI/IDFhkWWH3frkoMPN2zpQGq/QWAjl2bQ5JJgBPX52435fS
         s7eigv1yVp1j49EuDJ6ch8Eqnt0DJzG0XJoLtCXl4Fpimb8Tfrb0Rs0VKdpVMV7NOtGi
         RkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hr9+Obr43Ugb+tftzzH4at8I9cFTTs8UC/mYzT3zrkY=;
        b=WxoJol8kld0D+6q+cQL+t3m9UYDx8xZtNdCaYumfwPq5HYyHin7PyWtqCe3M+qkeu/
         rMMucuvmGYzPZaGamC/JaPiR0Cmse77vunaUJIJXtdkGJPoI9QxwDbqKSh4+KfmX17lS
         UNKg+TDOM0naUUxFYgbCeby9yD0eCqvnSJaCrDyDBkERvQbijscwcl+2wF+tFTHYoS1K
         Kt2XS8giGLFqTiyujDGHgIcmGB1zld96C5B+VvgWxGhJnwrjKD9Qj44V7tH76wskuZIc
         FsUKOhwyLYtJhR3hj2tTkleRLLnfICsryP+/K62rtAekhCUv6WRbSN/xXnaoA4l2kzAd
         x4OQ==
X-Gm-Message-State: AOAM530mfBckpj38Y+L+33EF2+Isw0Hoa8yLOXwY/38iMxvoHijhCxK5
        AuqVoGMV3FqHUByV3GDgIb58Ox7D8fwEe5nJe1E=
X-Google-Smtp-Source: ABdhPJxUuUVg8ufY74gENl/KfZDS8z2dCe+gi6hs57/epMj8V/oR+id6tEVrfN1fNe3g8GSCiJ5o51/U+oWSYRTuO1A=
X-Received: by 2002:a2e:b008:0:b0:24b:4ff2:5e09 with SMTP id
 y8-20020a2eb008000000b0024b4ff25e09mr3181680ljk.28.1649459802203; Fri, 08 Apr
 2022 16:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-8-joannekoong@fb.com>
 <CAEf4BzZATaiQpRcW=z1yW02L-D8Oo5QdkQ15S-gZ4d8EFL9McQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZATaiQpRcW=z1yW02L-D8Oo5QdkQ15S-gZ4d8EFL9McQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 8 Apr 2022 16:16:31 -0700
Message-ID: <CAJnrk1Z1z7-zX_2q3TJ_-0Wk_u2GtdTALt7LPJqKgCjR2K8A+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/7] bpf: Dynptr tests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Wed, Apr 6, 2022 at 4:11 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
> >
> > From: Joanne Koong <joannelkoong@gmail.com>
> >
> > This patch adds tests for dynptrs. These include scenarios that the
> > verifier needs to reject, as well as some successful use cases of
> > dynptrs that should pass.
> >
> > Some of the failure scenarios include checking against invalid bpf_frees,
> > invalid writes, invalid reads, and invalid ringbuf API usages.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
>
> Great set of tests! Hard to keep reading 500+ lines of failing use
> cases, but seems like a lot of interesting corner cases are handled!
> Great job!
>
> >  .../testing/selftests/bpf/prog_tests/dynptr.c | 303 ++++++++++
> >  .../testing/selftests/bpf/progs/dynptr_fail.c | 527 ++++++++++++++++++
> >  .../selftests/bpf/progs/dynptr_success.c      | 147 +++++
> >  3 files changed, 977 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > new file mode 100644
> > index 000000000000..7107ebee3427
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > @@ -0,0 +1,303 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Facebook */
> > +
> > +#include <test_progs.h>
> > +#include "dynptr_fail.skel.h"
> > +#include "dynptr_success.skel.h"
> > +
> > +size_t log_buf_sz = 1024 * 1024;
> > +
> > +enum fail_case {
> > +       MISSING_FREE,
> > +       MISSING_FREE_CALLBACK,
> > +       INVALID_FREE1,
> > +       INVALID_FREE2,
> > +       USE_AFTER_FREE,
> > +       MALLOC_TWICE,
> > +       INVALID_MAP_CALL1,
> > +       INVALID_MAP_CALL2,
> > +       RINGBUF_INVALID_ACCESS,
> > +       RINGBUF_INVALID_API,
> > +       RINGBUF_OUT_OF_BOUNDS,
> > +       DATA_SLICE_OUT_OF_BOUNDS,
> > +       DATA_SLICE_USE_AFTER_FREE,
> > +       INVALID_HELPER1,
> > +       INVALID_HELPER2,
> > +       INVALID_WRITE1,
> > +       INVALID_WRITE2,
> > +       INVALID_WRITE3,
> > +       INVALID_WRITE4,
> > +       INVALID_READ1,
> > +       INVALID_READ2,
> > +       INVALID_READ3,
> > +       INVALID_OFFSET,
> > +       GLOBAL,
> > +       FREE_TWICE,
> > +       FREE_TWICE_CALLBACK,
> > +};
>
> it might make sense to just pass the program name as a string instead,
> just like expected error message. This will allow more table-like
> subtest specification (I'll expand below)
>
[...]
> > +
> > +       if (test__start_subtest("missing_free"))
> > +               verify_fail(MISSING_FREE, obj_log_buf,
> > +                           "spi=0 is an unreleased dynptr");
> > +
>
> [...]
>
> > +       if (test__start_subtest("free_twice_callback"))
> > +               verify_fail(FREE_TWICE_CALLBACK, obj_log_buf,
> > +                           "arg #1 is an unacquired reference and hence cannot be released");
> > +
> > +       if (test__start_subtest("success"))
> > +               verify_success();
>
> so instead of manually coded set of tests, it's more "scalable" to go
> with table-driven approach. Something like
>
> struct {
>     const char *prog_name;
>     const char *exp_msg;
> } tests = {
>   {"invalid_read2", "Expected an initialized dynptr as arg #3"},
>   {"prog_success_ringbuf", NULL /* success case */},
>   ...
> };
>
> then you can just succinctly:
>
> for (i = 0; i < ARRAY_SIZE(tests); i++) {
>   if (!test__start_subtest(tests[i].prog_name))
>     continue;
>
>   if (tests[i].exp_msg)
>     verify_fail(tests[i].prog_name, tests[i].exp_msg);
>   else
>     verify_success(tests[i].prog_name);
> }
>
> Then adding new cases would be only adding BPF code and adding a
> single line in the tests table.
>
Awesome!! I love this. This will make it a lot easier to read!
> > +
> > +       free(obj_log_buf);
> > +}
[...]
>
> > +/* A dynptr can't be passed into a helper function at a non-zero offset */
> > +SEC("raw_tp/sys_nanosleep")
> > +int invalid_helper2(void *ctx)
> > +{
> > +       struct bpf_dynptr ptr = {};
> > +       char read_data[64] = {};
> > +       __u64 x = 0;
> > +
> > +       bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
> > +
> > +       /* this should fail */
> > +       bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 8, 0);
> > +
> > +       return 0;
> > +}
> > +
> > +/* A data slice can't be accessed out of bounds */
> > +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>
> why switching to fentry here with this ugly SYS_PREFIX thingy?
Ooh thanks for spotting this, I forgot to switch this over. Will
definitely change this for v2!
>
[...]
