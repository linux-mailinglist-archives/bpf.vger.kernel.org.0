Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4E6081F9
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJUXEt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJUXEr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:04:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC465B042
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:04:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b12so11210327edd.6
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nrK11QsFv4jF+kKh0yzfLM0ktUqBXlmXYGjrdz3tWTo=;
        b=PqgMFKsy8dluhgFsntGCI6T3ehXx5zvNk50CZ7U84YM5sMFMrvSNCqA/JXGhxX9v5l
         VeMkgui+vTfdkalBjUZi6vShSNILoNYpSDUy142EebpREsMaokVwTHUzFxmTXkXsNqyS
         ABrI5fBPPso1ay1RxyRvaEQZ4AXyOtcS6rhdGEUGBIV+6Zo6UcosCN4tTSh7tNveqroA
         n29Par6bYSw4RfRrqX6dhyagf6JT03ijjTi/kITdejMmbEpDjXvfuq0zcA7ZXA0rWkVD
         W8iz400ThV/uHQkNyfu2uwWh/oH3Z7aGwp1iPX/OuSvm3fidQl2riAP+Qz1t6NdYHsIi
         m5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrK11QsFv4jF+kKh0yzfLM0ktUqBXlmXYGjrdz3tWTo=;
        b=lcaV6yMFyFuaCGb2kC+QpNd19FpaUGqpYtl7lkz0X42nY2Jdq0cM5ULjLvRyKGyQp8
         bckNDGK9qjIciqcc7Hfkml3+s/SKZy/QNqlvqCKjLiIOvRJ9JXLj6dQa0yUwSnguCwQ1
         EMTntm0JnHYdDQUMQohGkRCfVBE8jcYsQJe0CmceOpIwMpxU+Sx1E7tXmaFYOAxNg7AE
         jXsOsyIq4KwIsTb3YskowWUhdCHAgl0A4gN8dBE0I/kr6IblLi+sA1jrFCQGXYiyBP1O
         xV5KrIqV7A4uNVz80zU0lxZZf3ESkavEtZyIg4pjPR8nc/5Lc892dZB5KyLPtac+w93W
         LOoA==
X-Gm-Message-State: ACrzQf1wSfwIILY0tmeMSFYFcXowudXmI39nVYV3f1Uygkl8PktsE6/Z
        IcNkMg2gtJjnnWmG7XgHc/tKEMqWSbd84gyjf9w=
X-Google-Smtp-Source: AMsMyM73wcD1jyhlgH8eDLChgXYdeTwRhcnu/RMyyn9siK9rIZt7VmGlfo+jNhFXB2RwNrJ5EEjNrJPwkDH+KFIP3yo=
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id
 sc36-20020a1709078a2400b00795bb7d643bmr11874811ejc.115.1666393481798; Fri, 21
 Oct 2022 16:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221020160721.4030492-1-davemarchevsky@fb.com> <20221020160721.4030492-3-davemarchevsky@fb.com>
In-Reply-To: <20221020160721.4030492-3-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 16:04:28 -0700
Message-ID: <CAEf4BzZTdDTaiDYCy6KtkF4D-W8-JNmZZzLOrZYAVrst9GrWiw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/4] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Thu, Oct 20, 2022 at 9:07 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Add a test_ringbuf_map_key test prog, borrowing heavily from extant
> test_ringbuf.c. The program tries to use the result of
> bpf_ringbuf_reserve as map_key, which was not possible before previouis
> commits in this series. The test runner added to prog_tests/ringbuf.c
> verifies that the program loads and does basic sanity checks to confirm
> that it runs as expected.
>
> Also, refactor test_ringbuf such that runners for existing test_ringbuf
> and newly-added test_ringbuf_map_key are subtests of 'ringbuf' top-level
> test.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> v4->v5: lore.kernel.org/bpf/20220923060614.4025371-2-davemarchevsky@fb.com
>
> * Fix some nits (Andrii)
>   * migrating prog from fentry -> ksyscall wasn't done as lskel doesn't
>     support the latter. Talked to Andrii about it offlist, he's fine with it.
>
> v3->v4: lore.kernel.org/bpf/20220922142208.3009672-2-davemarchevsky@fb.com
>
> * Fix some nits (Yonghong)
>   * make subtest runner functions static
>   * don't goto cleanup if -EDONE check fails
>   * add 'workaround' to comment in test to ease future grepping
> * Add Yonghong ack
>
> v2->v3: lore.kernel.org/bpf/20220914123600.927632-2-davemarchevsky@fb.com
>
> * Test that ring_buffer__poll returns -EDONE (Alexei)
>
> v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
>
> * Actually run the program instead of just loading (Yonghong)
> * Add a bpf_map_update_elem call to the test (Yonghong)
> * Refactor runner such that existing test and newly-added test are
>   subtests of 'ringbuf' top-level test (Yonghong)
> * Remove unused globals in test prog (Yonghong)
>
>  tools/testing/selftests/bpf/Makefile          |  8 ++-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 66 ++++++++++++++++-
>  .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
>  3 files changed, 140 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e6cf21fad69f..79edef1dbda4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -359,9 +359,11 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h              \
>                 test_subskeleton.skel.h test_subskeleton_lib.skel.h     \
>                 test_usdt.skel.h

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> new file mode 100644
> index 000000000000..2760bf60d05a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
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

btw, libbpf is smart enough now to auto-fix ringbuf size, so you could
have used __uint(max_entries, 4096) and that would work even on
architectures that have 64KB pages. Just FYI.

> +} ringbuf SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 1000);
> +       __type(key, struct sample);
> +       __type(value, int);
> +} hash_map SEC(".maps");
> +
> +/* inputs */
> +int pid = 0;
> +
> +/* inner state */
> +long seq = 0;
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")

it's fine as is, my suggestion to use ksyscall was to 1) avoid using
BPF trampoline (and so have these tests work on s390x) and 2) no have
to use ugly SYS_PREFIX. SEC("kprobe/" SYS_PREFIX "sys_getpgid") would
solve 1), which is more important in practical terms. 2) is a wishlist
:)

I'm not insisting or asking to change this, just pointing out the
rationale for ksyscall suggestion in the first place.


> +int test_ringbuf_mem_map_key(void *ctx)
> +{
> +       int cur_pid = bpf_get_current_pid_tgid() >> 32;
> +       struct sample *sample, sample_copy;
> +       int *lookup_val;
> +
> +       if (cur_pid != pid)
> +               return 0;
> +
> +       sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
> +       if (!sample)
> +               return 0;
> +
> +       sample->pid = pid;
> +       bpf_get_current_comm(sample->comm, sizeof(sample->comm));
> +       sample->seq = ++seq;
> +       sample->value = 42;
> +
> +       /* test using 'sample' (PTR_TO_MEM | MEM_ALLOC) as map key arg
> +        */
> +       lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);
> +
> +       /* workaround - memcpy is necessary so that verifier doesn't
> +        * complain with:
> +        *   verifier internal error: more than one arg with ref_obj_id R3
> +        * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
> +        *
> +        * Since bpf_map_lookup_elem above uses 'sample' as key, test using
> +        * sample field as value below
> +        */
> +       __builtin_memcpy(&sample_copy, sample, sizeof(struct sample));
> +       bpf_map_update_elem(&hash_map, &sample_copy, &sample->seq, BPF_ANY);
> +
> +       bpf_ringbuf_submit(sample, 0);
> +       return 0;
> +}
> --
> 2.30.2
>
