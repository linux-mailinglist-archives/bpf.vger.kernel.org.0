Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9751E2A2
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 02:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445024AbiEGANr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 20:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiEGANr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 20:13:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A924712C0
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 17:10:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f2so9715277ioh.7
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 17:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alxGrUvZ97gU/XxoSbq7WKpBNiuuVHPF+5cViV+nPZA=;
        b=eQROfk0xCALcR8tlDg5G8Ks62oNOG45CprK4zhtXMollBT/fUH8MZAeedCF8glGVdi
         RfjX5SkLPgCDhgqW/Sg+z/LIRAnAOOaTF5BQdwj9C4nwCz57Rif4Q/avrz9watUsvTLE
         RyR4TuZJ8SydUyUQkQqG2G2D83P3NdYqNcfOga3U/aqC0r8F8BHLj/dFW9hb5039OGeF
         OD8HYHVRU1Jby8384MlOqWEMu1GiBu31o96g06egEl7yD1jD45HVD+HKmadEoqhP0NG3
         YnLd94ULwd92aoYs4gxVZ7QDiAhADhW2o6eAWpQ0fVq+G0K9dXR69zBr7wPpxfWHJdNj
         M4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alxGrUvZ97gU/XxoSbq7WKpBNiuuVHPF+5cViV+nPZA=;
        b=nRn31/k5o06NAoSNtVtENG7k7Klf7MzADRRZ9U00ByzG+R6L8Ltgj29yFb7a8lV7f5
         mSYpAHiEDtiy6krLhUDFsHJSy7t07J4PVkgbp/BzYxmccQCPCnJhRE0cDvuu3msYnz1u
         snHyCp3E8wSHOCZDMci5kg1xWiPVWQVaCYxBzOSILDAHNYeXan6AD6bYqYH9YGTpyiH8
         0G+TF0jRcZuB2m8xmNLi4QSlBUYqBhJ2nYraqaWodJYsI1JRmMCUQ4NWvVmst/eNKaBK
         kefprvqbsFqmtO/OsfA148SlKtKvtm/vnmimU89aufs87mZF334xNdyOQUQQmiGxi5vi
         XcSw==
X-Gm-Message-State: AOAM5335/40FuyAb9nvGx/BXA+UDTHC7Bf+0qqyXLzdjh99fnMP3M0ec
        lrVi3x9flPYrIUIG7OyLiysAJ69eJDW2OxaWweY=
X-Google-Smtp-Source: ABdhPJy3mBWmg7hy50JWGeN0gJV4lGAoUQazldrJK9EZy8JDSSosjWVJvengpi6LilfworoHF9/8S+ZKZWyhqoxZMnk=
X-Received: by 2002:a05:6638:16d6:b0:32b:a283:a822 with SMTP id
 g22-20020a05663816d600b0032ba283a822mr2537553jat.145.1651882201600; Fri, 06
 May 2022 17:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com> <20220428211059.4065379-7-joannelkoong@gmail.com>
In-Reply-To: <20220428211059.4065379-7-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 17:09:50 -0700
Message-ID: <CAEf4BzbMjs1UV0O8HTR=v7Qcrr-ZJiXBahPCbQLGR81DpXQP2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] bpf: Dynptr tests
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patch adds tests for dynptrs, which include cases that the
> verifier needs to reject (for example, invalid bpf_dynptr_put usages
> and  invalid writes/reads), as well as cases that should successfully
> pass.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Apart from a few nits, this looks awesome. Great coverage!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../testing/selftests/bpf/prog_tests/dynptr.c | 132 ++++
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 574 ++++++++++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 218 +++++++
>  3 files changed, 924 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> new file mode 100644
> index 000000000000..0bed39fd8dac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Facebook */
> +
> +#include <test_progs.h>
> +#include "dynptr_fail.skel.h"
> +#include "dynptr_success.skel.h"
> +
> +size_t log_buf_sz = 1048576; /* 1 MB */

static

> +static char obj_log_buf[1048576];
> +
> +struct {

static

> +       const char *prog_name;
> +       const char *expected_err_msg;
> +} dynptr_tests[] = {
> +       /* failure cases */
> +       {"missing_put", "Unreleased reference id=1"},
> +       {"missing_put_callback", "Unreleased reference id=1"},
> +       {"put_nonalloc", "Expected an initialized malloc dynptr as arg #1"},
> +       {"put_data_slice", "type=dynptr_mem expected=fp"},
> +       {"put_uninit_dynptr", "arg 1 is an unacquired reference"},
> +       {"use_after_put", "Expected an initialized dynptr as arg #3"},
> +       {"alloc_twice", "Arg #3 dynptr has to be an uninitialized dynptr"},
> +       {"add_dynptr_to_map1", "invalid indirect read from stack"},
> +       {"add_dynptr_to_map2", "invalid indirect read from stack"},
> +       {"ringbuf_invalid_access", "invalid mem access 'scalar'"},
> +       {"ringbuf_invalid_api", "type=dynptr_mem expected=alloc_mem"},
> +       {"ringbuf_out_of_bounds", "value is outside of the allowed memory range"},
> +       {"data_slice_out_of_bounds", "value is outside of the allowed memory range"},
> +       {"data_slice_use_after_put", "invalid mem access 'scalar'"},
> +       {"invalid_helper1", "invalid indirect read from stack"},
> +       {"invalid_helper2", "Expected an initialized dynptr as arg #3"},
> +       {"invalid_write1", "Expected an initialized malloc dynptr as arg #1"},
> +       {"invalid_write2", "Expected an initialized dynptr as arg #3"},
> +       {"invalid_write3", "Expected an initialized malloc dynptr as arg #1"},
> +       {"invalid_write4", "arg 1 is an unacquired reference"},
> +       {"invalid_read1", "invalid read from stack"},
> +       {"invalid_read2", "cannot pass in non-zero dynptr offset"},
> +       {"invalid_read3", "invalid read from stack"},
> +       {"invalid_offset", "invalid write to stack"},
> +       {"global", "R3 type=map_value expected=fp"},
> +       {"put_twice", "arg 1 is an unacquired reference"},
> +       {"put_twice_callback", "arg 1 is an unacquired reference"},
> +       {"zero_slice_access", "invalid access to memory, mem_size=0 off=0 size=1"},
> +       /* success cases */
> +       {"test_basic", NULL},
> +       {"test_data_slice", NULL},
> +       {"test_ringbuf", NULL},
> +       {"test_alloc_zero_bytes", NULL},
> +};
> +
> +static void verify_fail(const char *prog_name, const char *expected_err_msg)
> +{
> +       LIBBPF_OPTS(bpf_object_open_opts, opts);
> +       struct bpf_program *prog;
> +       struct dynptr_fail *skel;
> +       int err;
> +
> +       opts.kernel_log_buf = obj_log_buf;
> +       opts.kernel_log_size = log_buf_sz;
> +       opts.kernel_log_level = 1;
> +
> +       skel = dynptr_fail__open_opts(&opts);
> +       if (!ASSERT_OK_PTR(skel, "dynptr_fail__open_opts"))
> +               goto cleanup;
> +
> +       prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +       if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +               goto cleanup;
> +
> +       bpf_program__set_autoload(prog, true);
> +
> +       err = dynptr_fail__load(skel);
> +       if (!ASSERT_ERR(err, "unexpected load success"))
> +               goto cleanup;
> +
> +       if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
> +               fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
> +               fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> +       }
> +
> +cleanup:
> +       dynptr_fail__destroy(skel);
> +}
> +
> +static void verify_success(const char *prog_name)
> +{
> +       struct dynptr_success *skel;
> +       struct bpf_program *prog;
> +       struct bpf_link *link;
> +
> +       skel = dynptr_success__open();
> +       if (!ASSERT_OK_PTR(skel, "dynptr_success__open"))
> +               return;
> +
> +       skel->bss->pid = getpid();
> +
> +       dynptr_success__load(skel);
> +       if (!ASSERT_OK_PTR(skel, "dynptr_success__load"))
> +               goto cleanup;
> +
> +       prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +       if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +               goto cleanup;
> +
> +       link = bpf_program__attach(prog);
> +       if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> +               goto cleanup;
> +
> +       usleep(1);
> +
> +       ASSERT_EQ(skel->bss->err, 0, "err");
> +
> +       bpf_link__destroy(link);
> +
> +cleanup:
> +       dynptr_success__destroy(skel);
> +}
> +
> +void test_dynptr(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(dynptr_tests); i++) {
> +               if (!test__start_subtest(dynptr_tests[i].prog_name))
> +                       continue;
> +
> +               if (dynptr_tests[i].expected_err_msg)
> +                       verify_fail(dynptr_tests[i].prog_name, dynptr_tests[i].expected_err_msg);
> +               else
> +                       verify_success(dynptr_tests[i].prog_name);
> +       }
> +}

overall flow and structure looks great and clean, great job!

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> new file mode 100644
> index 000000000000..e4d5464e1865
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -0,0 +1,574 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Facebook */
> +
> +#include <string.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, struct bpf_dynptr);
> +} array_map SEC(".maps");
> +
> +struct sample {
> +       int pid;
> +       long value;
> +       char comm[16];
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> +       __uint(max_entries, 1 << 12);

this is problematic for other architectures, let's drop max_entries
from here and do bpf_program__set_max_entries(skel->maps.ringbuf,
pagesize()) from user-space. We went though this process before, let's
not regress

> +} ringbuf SEC(".maps");
> +
> +int err = 0;
> +int val;
> +
> +/* Every bpf_dynptr_alloc call must have a corresponding bpf_dynptr_put call */
> +SEC("?raw_tp/sys_nanosleep")
> +int missing_put(void *ctx)
> +{
> +       struct bpf_dynptr mem;
> +
> +       bpf_dynptr_alloc(8, 0, &mem);
> +
> +       /* missing a call to bpf_dynptr_put(&mem) */
> +
> +       return 0;
> +}
> +
> +/* A non-alloc-ed dynptr can't be used by bpf_dynptr_put */
> +SEC("?raw_tp/sys_nanosleep")
> +int put_nonalloc(void *ctx)
> +{
> +       struct bpf_dynptr ptr;

nit: empty line after variable declaration

> +       bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +
> +       /* this should fail */
> +       bpf_dynptr_put(&ptr);
> +
> +       return 0;
> +}
> +

[...]

> +int pid = 0;
> +int err = 0;
> +int val;
> +
> +struct sample {
> +       int pid;
> +       int seq;
> +       long value;
> +       char comm[16];
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> +       __uint(max_entries, 1 << 12);

same about ringbuf sizing

> +} ringbuf SEC(".maps");
> +
> +SEC("tp/syscalls/sys_enter_nanosleep")
> +int test_basic(void *ctx)
> +{
> +       char write_data[64] = "hello there, world!!";
> +       char read_data[64] = {}, buf[64] = {};
> +       struct bpf_dynptr ptr = {};
> +       int i;
> +
> +       if (bpf_get_current_pid_tgid() >> 32 != pid)
> +               return 0;
> +
> +       err = bpf_dynptr_alloc(sizeof(write_data), 0, &ptr);
> +       if (err)
> +               goto done;

you don't really need `if (err) goto done` with dynptr APIs, you can have

err = bpf_dynptr_alloc(...)
err = err ?: bpf_dynptr_write();
err = err ?: bpf_dynptr_read();

That's how I'd do it in real application as well to eliminate all this
if/goto checks

> +
> +       /* Write data into the dynptr */
> +       err = bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data));
> +       if (err)
> +               goto done;
> +

[...]
