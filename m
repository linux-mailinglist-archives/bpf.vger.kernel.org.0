Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A3E4F6E6A
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 01:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiDFXNr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 19:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiDFXNr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 19:13:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA95160FE7
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 16:11:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b16so4892559ioz.3
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PedBjSzHw5ipP/OVIVb5GOZlqsQtNM2wCgShuUd3p9o=;
        b=YTqIpWvVTSf6FDY6LeN2KyosjZeFDUrHkzQeupK9p45e4yuIDY2rpGFmhFhgST1VpK
         Yquqix4+Ejl3HqxckOZOSJRItvr2i5FJZnkgFUzFdxVCRHDBIRGQGmZCCHmaWEBRI53A
         ck8njdbjnGQCMXEGV+LgaK66QhmwqibopvLIVrELGpv/ib1jd+XcPx/odhUeX3QkYsiO
         xe80NVaVHAJYXUeA8RaC4rzptr8ai9mqyDWi20Cb7AjrNH3aerlXqp8Hr+ALO3JSvYLR
         w320dU39owq8TjbOLmnMCekN8wIY8GOLl8sEvfCZMpNz21DKb/mJ2sA0HF2fPPZ/1sKn
         S6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PedBjSzHw5ipP/OVIVb5GOZlqsQtNM2wCgShuUd3p9o=;
        b=TPvFoJ40uAT6py5pD35Q7XY/J+vQfaFd7aoXICry4UM24YdvZLd10od+jpGhyzkglQ
         Fr+n2kM+Ai2/cMMEn0xfamWiMQOlqphUmMGX8TQCuC8HBypBH0hFvQTBzd48W37NV32B
         ZmoL17g6nBbWWITgtOOOw1oDIg0NcWyOKDxf7MITDMnFUBNSrO0nnP6y7jB815NywVFn
         FWvKTc9f75HMSofSIp5kn1f91fe4DjhZUu8pGeQfPqh3nBgcndh1qQNzctt1KbNiFfQ6
         kjudd3gIybOkyQ4DYztcIZk0InM2ge4hKNJZ/KHqkOtm62W57Jzb5DvQkmw4wztH2t47
         1F4A==
X-Gm-Message-State: AOAM531nAnxb5W5ZxkcM5IjFkXrWC98tiJ60VL/2/RC+9C6o6Bdb8fSs
        RIFF7Nq3O7aK9zfuljbA/5L2kcp7YtV/9yKjwLo=
X-Google-Smtp-Source: ABdhPJySbgr24ukwaCp9SEX2BbvOvxUnjJzINruILURXVzLgjlUhAXE270c18jX0vLziuHSWSQEhQ4cuLxc6JI7EBV8=
X-Received: by 2002:a05:6602:3c6:b0:63d:cac9:bd35 with SMTP id
 g6-20020a05660203c600b0063dcac9bd35mr5131299iov.144.1649286706723; Wed, 06
 Apr 2022 16:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-8-joannekoong@fb.com>
In-Reply-To: <20220402015826.3941317-8-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 16:11:35 -0700
Message-ID: <CAEf4BzZATaiQpRcW=z1yW02L-D8Oo5QdkQ15S-gZ4d8EFL9McQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/7] bpf: Dynptr tests
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> This patch adds tests for dynptrs. These include scenarios that the
> verifier needs to reject, as well as some successful use cases of
> dynptrs that should pass.
>
> Some of the failure scenarios include checking against invalid bpf_frees,
> invalid writes, invalid reads, and invalid ringbuf API usages.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Great set of tests! Hard to keep reading 500+ lines of failing use
cases, but seems like a lot of interesting corner cases are handled!
Great job!

>  .../testing/selftests/bpf/prog_tests/dynptr.c | 303 ++++++++++
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 527 ++++++++++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 147 +++++
>  3 files changed, 977 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> new file mode 100644
> index 000000000000..7107ebee3427
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Facebook */
> +
> +#include <test_progs.h>
> +#include "dynptr_fail.skel.h"
> +#include "dynptr_success.skel.h"
> +
> +size_t log_buf_sz = 1024 * 1024;
> +
> +enum fail_case {
> +       MISSING_FREE,
> +       MISSING_FREE_CALLBACK,
> +       INVALID_FREE1,
> +       INVALID_FREE2,
> +       USE_AFTER_FREE,
> +       MALLOC_TWICE,
> +       INVALID_MAP_CALL1,
> +       INVALID_MAP_CALL2,
> +       RINGBUF_INVALID_ACCESS,
> +       RINGBUF_INVALID_API,
> +       RINGBUF_OUT_OF_BOUNDS,
> +       DATA_SLICE_OUT_OF_BOUNDS,
> +       DATA_SLICE_USE_AFTER_FREE,
> +       INVALID_HELPER1,
> +       INVALID_HELPER2,
> +       INVALID_WRITE1,
> +       INVALID_WRITE2,
> +       INVALID_WRITE3,
> +       INVALID_WRITE4,
> +       INVALID_READ1,
> +       INVALID_READ2,
> +       INVALID_READ3,
> +       INVALID_OFFSET,
> +       GLOBAL,
> +       FREE_TWICE,
> +       FREE_TWICE_CALLBACK,
> +};

it might make sense to just pass the program name as a string instead,
just like expected error message. This will allow more table-like
subtest specification (I'll expand below)

> +
> +static void verify_fail(enum fail_case fail, char *obj_log_buf,  char *err_msg)

nit: extra space

> +{
> +       LIBBPF_OPTS(bpf_object_open_opts, opts);
> +       struct bpf_program *prog;
> +       struct dynptr_fail *skel;
> +       int err;
> +
> +       opts.kernel_log_buf = obj_log_buf;
> +       opts.kernel_log_size = log_buf_sz;

see below, this could easily be just a static array variable, no need
to pass it in

> +       opts.kernel_log_level = 1;
> +
> +       skel = dynptr_fail__open_opts(&opts);
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       bpf_object__for_each_program(prog, skel->obj)
> +               bpf_program__set_autoload(prog, false);
> +
> +       /* these programs should all be rejected by the verifier */
> +       switch (fail) {
> +       case MISSING_FREE:
> +               prog = skel->progs.missing_free;
> +               break;
> +       case MISSING_FREE_CALLBACK:
> +               prog = skel->progs.missing_free_callback;
> +               break;

[...]

> +               break;
> +       case GLOBAL:
> +               prog = skel->progs.global;
> +               break;
> +       case FREE_TWICE:
> +               prog = skel->progs.free_twice;
> +               break;
> +       case FREE_TWICE_CALLBACK:
> +               prog = skel->progs.free_twice_callback;
> +               break;
> +       default:
> +               fprintf(stderr, "unknown fail_case\n");
> +               return;
> +       }

so instead of maintaining this enum definition and corresponding
mapping to prog, you can just specify program name as a string and use
bpf_object__find_program_by_name(). The only downside is that if you
make a typo in program name or it is renamed, you'll catch it at
runtime not at compilation time. But I think it's acceptable tradeoff.

> +
> +       bpf_program__set_autoload(prog, true);
> +
> +       err = dynptr_fail__load(skel);
> +
> +       ASSERT_OK_PTR(strstr(obj_log_buf, err_msg), "err_msg not found");

let's also print out the full log if something goes wrong. It will be
hard to debug when something (even the message itself) changes on
verifier side.

> +
> +       ASSERT_ERR(err, "unexpected load success");

nit: move this before log_buf check? seems like it's logically first
check you need to do

> +
> +       dynptr_fail__destroy(skel);
> +}
> +
> +static void run_prog(struct dynptr_success *skel, struct bpf_program *prog)
> +{
> +       struct bpf_link *link;
> +
> +       link = bpf_program__attach(prog);
> +       if (!ASSERT_OK_PTR(link, "bpf program attach"))

or ASSERT_xxx() macros this second string argument is something like
entity/variable name, it's not a message. See how ASSERT_xxx() uses it
internally. So keeping it short and identifier-like makes it easier to
follow actual failure messages.

> +               return;
> +
> +       usleep(1);
> +
> +       ASSERT_EQ(skel->bss->err, 0, "err");
> +
> +       bpf_link__destroy(link);
> +}
> +
> +static void verify_success(void)
> +{
> +       struct dynptr_success *skel;
> +
> +       skel = dynptr_success__open();
> +
> +       skel->bss->pid = getpid();
> +
> +       dynptr_success__load(skel);
> +       if (!ASSERT_OK_PTR(skel, "dynptr__open_and_load"))
> +               return;
> +
> +       run_prog(skel, skel->progs.prog_success);
> +       run_prog(skel, skel->progs.prog_success_data_slice);
> +       run_prog(skel, skel->progs.prog_success_ringbuf);

let's keep it generic as well as for negative tests and pass program
name? it will be easier to extend such framework

> +
> +       dynptr_success__destroy(skel);
> +}
> +
> +void test_dynptr(void)
> +{
> +       char *obj_log_buf;
> +
> +       obj_log_buf = malloc(3 * log_buf_sz);
> +       if (!ASSERT_OK_PTR(obj_log_buf, "obj_log_buf"))
> +               return;
> +       obj_log_buf[0] = '\0';

I'd keep it simple and just have a global static log buf of necessary
size. Less parameters to pass a well

> +
> +       if (test__start_subtest("missing_free"))
> +               verify_fail(MISSING_FREE, obj_log_buf,
> +                           "spi=0 is an unreleased dynptr");
> +

[...]

> +       if (test__start_subtest("free_twice_callback"))
> +               verify_fail(FREE_TWICE_CALLBACK, obj_log_buf,
> +                           "arg #1 is an unacquired reference and hence cannot be released");
> +
> +       if (test__start_subtest("success"))
> +               verify_success();

so instead of manually coded set of tests, it's more "scalable" to go
with table-driven approach. Something like

struct {
    const char *prog_name;
    const char *exp_msg;
} tests = {
  {"invalid_read2", "Expected an initialized dynptr as arg #3"},
  {"prog_success_ringbuf", NULL /* success case */},
  ...
};

then you can just succinctly:

for (i = 0; i < ARRAY_SIZE(tests); i++) {
  if (!test__start_subtest(tests[i].prog_name))
    continue;

  if (tests[i].exp_msg)
    verify_fail(tests[i].prog_name, tests[i].exp_msg);
  else
    verify_success(tests[i].prog_name);
}

Then adding new cases would be only adding BPF code and adding a
single line in the tests table.

> +
> +       free(obj_log_buf);
> +}

[...]

> +/* Can't call non-dynptr ringbuf APIs on a dynptr ringbuf sample */
> +SEC("raw_tp/sys_nanosleep")
> +int ringbuf_invalid_api(void *ctx)
> +{
> +       struct bpf_dynptr ptr;
> +       struct sample *sample;
> +
> +       err = bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> +       sample = bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> +       if (!sample)
> +               goto done;
> +
> +       sample->pid = 123;
> +
> +       /* invalid API use. need to use dynptr API to submit/discard */
> +       bpf_ringbuf_submit(sample, 0);

this will be rejected also due to missing discard_dynptr() in this
code path, right? But if you remove return 0 below and fall through
into done this will go away.

> +
> +       return 0;
> +
> +done:
> +       bpf_ringbuf_discard_dynptr(&ptr, 0);
> +       return 0;
> +}

[...]

> +/* A dynptr can't be passed into a helper function at a non-zero offset */
> +SEC("raw_tp/sys_nanosleep")
> +int invalid_helper2(void *ctx)
> +{
> +       struct bpf_dynptr ptr = {};
> +       char read_data[64] = {};
> +       __u64 x = 0;
> +
> +       bpf_dynptr_from_mem(&x, sizeof(x), &ptr);
> +
> +       /* this should fail */
> +       bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 8, 0);
> +
> +       return 0;
> +}
> +
> +/* A data slice can't be accessed out of bounds */
> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")

why switching to fentry here with this ugly SYS_PREFIX thingy?

> +int data_slice_out_of_bounds(void *ctx)
> +{
> +       struct bpf_dynptr ptr = {};
> +       void *data;
> +
> +       bpf_malloc(8, &ptr);
> +
> +       data = bpf_dynptr_data(&ptr, 0, 8);
> +       if (!data)
> +               goto done;
> +
> +       /* can't index out of bounds of the data slice */
> +       val = *((char *)data + 8);
> +
> +done:
> +       bpf_free(&ptr);
> +       return 0;
> +}
> +

[...]
