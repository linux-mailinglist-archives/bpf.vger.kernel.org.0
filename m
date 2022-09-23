Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4D5E8596
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIWWKF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIWWKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:10:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7483F3B
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:10:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x21so1904210edd.11
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QVqtu/mVe/Z+GWXvcdsXT7VbPcHF6WUXXH/WgnUmBrg=;
        b=jNRIRVaZQAHrp3olGcF0C2DQr9n+P8pwHPKUCKgnn5Hp0K5t3q0j5nEGroux8kQ5Dd
         w6xHiCSPVM13B9MrZhPx/dCrR01H5mQzyRwSBu3LBjOAXuVfucSLHxyAHVBjnc50W3Dc
         EN1YsQvif0l9b32AXEBp8YntdIlMTc/xIK7fAB3f656SFP3qqrG9rXX9jFEXi/ngBSCa
         wB29l7SL9GNby1m+f96h0veH15T+stOWcZptZ2lO8z4va+FqdETqr4JJYGDIa87NRbs3
         J8UPV6tVGo/Cio6SXAhSULV47Tz9nRA4h7+6QnCrNyjiLAQa1L7rmDP6K07XZluFszXa
         TG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QVqtu/mVe/Z+GWXvcdsXT7VbPcHF6WUXXH/WgnUmBrg=;
        b=5zEurCG4l3jC0s0N1kMyDInrayiFBXxePnPxlt4Hce3tUkGFW5ziQOrVlHZV62VAvz
         mKjvXpXh49eDLXcncrkccoKx2Vh+5Uoj3/xxr5qe9Xf94F3jIPPTIkg3uTz3L5pR47io
         t7GXjdsroZiBI8RaPPnqQJnxxgUP89r4MOfnSEY7KYyKVMfXNTItjePbd+GgjcxlHIUd
         tkwPinjPuKxkfSYoeWq6DOhpFqdETxfCYCc9//fMFgiA5WuIVB6HluuUzt+JOp6UOn8F
         20Nkg/ENWpOMCORZb0nXg1jXCDa7FRzEOe9cGLYSjvO6dxPVdFUSg7VXspi8hQhDxrJE
         Sbew==
X-Gm-Message-State: ACrzQf0Bb4NSk2+L0vx2H0QF7RJd/3bFErkgwuM4LXKqN925L6Fe+Whq
        02fg+1+xDCOcggipVfFTHH9b5xpudY5ToSkYtqw=
X-Google-Smtp-Source: AMsMyM4sedY0gkHWxKV2Zwo+xdZ31/CxZcpWlYB08i/aKzVeyJRh+4erL+xY3sG/kyiuGlJiEAx+YzlEmuQutHffeG8=
X-Received: by 2002:a05:6402:3603:b0:451:fdda:dddd with SMTP id
 el3-20020a056402360300b00451fddaddddmr10339839edb.81.1663971000337; Fri, 23
 Sep 2022 15:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220923060614.4025371-1-davemarchevsky@fb.com> <20220923060614.4025371-2-davemarchevsky@fb.com>
In-Reply-To: <20220923060614.4025371-2-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 15:09:49 -0700
Message-ID: <CAEf4BzYqKGz69qYrYLnGgDNpY1v2-c7DH7ajAFVCNDQv+Mh-pw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
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

On Thu, Sep 22, 2022 at 11:06 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
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
>  .../selftests/bpf/prog_tests/ringbuf.c        | 64 ++++++++++++++++-
>  .../bpf/progs/test_ringbuf_map_key.c          | 71 +++++++++++++++++++
>  3 files changed, 139 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 5898d3828b82..28bd482f34a1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -358,9 +358,11 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h              \
>                 test_subskeleton.skel.h test_subskeleton_lib.skel.h     \
>                 test_usdt.skel.h
>

[...]

> +static void ringbuf_map_key_subtest(void)
> +{
> +       int err;
> +
> +       skel_map_key = test_ringbuf_map_key_lskel__open();
> +       if (!ASSERT_OK_PTR(skel_map_key, "test_ringbuf_map_key_lskel__open"))
> +               return;
> +
> +       skel_map_key->maps.ringbuf.max_entries = getpagesize();
> +       skel_map_key->bss->pid = getpid();
> +
> +       err = test_ringbuf_map_key_lskel__load(skel_map_key);
> +       if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__load"))
> +               goto cleanup;
> +
> +       ringbuf = ring_buffer__new(skel_map_key->maps.ringbuf.map_fd,
> +                                  process_map_key_sample, NULL, NULL);

if (!ASSERT_OK_PTR(ringbuf, ...))

is missing

> +
> +       err = test_ringbuf_map_key_lskel__attach(skel_map_key);
> +       if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__attach"))
> +               goto cleanup_ringbuf;
> +
> +       syscall(__NR_getpgid);
> +       ASSERT_EQ(skel_map_key->bss->seq, 1, "skel_map_key->bss->seq");
> +       err = ring_buffer__poll(ringbuf, -1);
> +       ASSERT_EQ(err, -EDONE, "ring_buffer__poll");
> +
> +cleanup_ringbuf:
> +       ring_buffer__free(ringbuf);
> +cleanup:
> +       test_ringbuf_map_key_lskel__destroy(skel_map_key);
> +}
> +
> +void test_ringbuf(void)
> +{
> +       if (test__start_subtest("ringbuf"))
> +               ringbuf_subtest();
> +       if (test__start_subtest("ringbuf_map_key"))
> +               ringbuf_map_key_subtest();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> new file mode 100644
> index 000000000000..44f89c4d1f9e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
> @@ -0,0 +1,71 @@
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
> +       __uint(max_entries, 4096);

you are setting max_entries from user-space, so best drop this line here

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

if we use SEC("ksyscall/getpgid") this will work on s390x as well. We
don't seem to gain anything from using fentry here, do we?
Currently entire ringbuf selftests is denied on s390x, but you are
switching it to use subtest, so we can enable at least the new
subtest?

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
