Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009B5B98B6
	for <lists+bpf@lfdr.de>; Thu, 15 Sep 2022 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIOKZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 06:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIOKZQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 06:25:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F054641
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 03:25:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a26so12317922ejc.4
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=etKZlwy+ld3iqkbiUEH5Xp8bHHPeh6BWFIUYYtxfAas=;
        b=N4NVU4P2aigYa1gxlbny0iClBdvscp3m52ts8ZFjMiWR1Xq/wPraqe6CNLp0EjFb6e
         n4tHZReKL6k8MV9985AvCzSXBsLy5K4Zgmgo2x8eNmTbq275PR/n+9yLpcZlMmiXPjio
         4052S+OvnxaCl6+/xMHiOG18vT6KtzSZ6HHf1bxGLEHJpKXyOJcvQXylrvhpDewbfofC
         MqSJ1T8ZNOUWdMge1Yl8xpBdVDh3xpdwhWKcvTbiktQD9NNyoBgJ8sF7UJBFOC/9J/2F
         LXqal6qJbqvzDU5zkBWRhdFTU1LPaNGvmq0xY5fElLRa22Pnm3vZNj8fZ+lcw4r3zhns
         Qubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=etKZlwy+ld3iqkbiUEH5Xp8bHHPeh6BWFIUYYtxfAas=;
        b=V53Qy3FKcptQnZlmpfjcB2bm9So5/J9Xp72kWL7WJMAEEmecNb0jHZRNuzD3+mon4T
         Yu19QoAZapAPQO81168Wtld2N960dULVvAv3fIMksIeEzCrhYMtk5uAROEqZnN0anLNd
         IigsbU7OJf6+Px0VpoQ4WncdW48DcOkuNPJgzeoJzOvyMvrykfSjP5BeGF3DsiFjQig8
         8U5XrNgfYhdMzPTzxydu0I4+nfC/DDRno4RcckgrRz6pNacZw7jO/ywk78eN1/0i1Dkj
         5z8weaZSZGLgMQm0mHyKf0xv/pd4klZbDb22VlQ29y5vSptVA8bTwbFEjEIkEkIvE9gE
         TlUw==
X-Gm-Message-State: ACgBeo1OJSlWy6cN7cZAUYD4AnYCSgwNrpWw+NQpxFEC7LmqykMD1F5v
        L0rIrx6GZugLuOpj/+rpRu8D9yajDIzM3ngCJ7w=
X-Google-Smtp-Source: AA6agR7lccoMKukO2itm+gP1SxnkEWObkyMWjam9Y7I+2CDG5q987D07koosmXJSGyTwdDL3pECvOXLTEOwyquoLDK8=
X-Received: by 2002:a17:907:e93:b0:77b:e7a8:2f63 with SMTP id
 ho19-20020a1709070e9300b0077be7a82f63mr15528848ejc.94.1663237510707; Thu, 15
 Sep 2022 03:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220914123600.927632-1-davemarchevsky@fb.com> <20220914123600.927632-2-davemarchevsky@fb.com>
In-Reply-To: <20220914123600.927632-2-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 15 Sep 2022 11:24:59 +0100
Message-ID: <CAADnVQJ1zzunbU_KqmdMJTBCmHSh6CkOuOcXYhkC5Z5eOQ-hag@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Wed, Sep 14, 2022 at 1:36 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
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
> ---
> v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
>
> * Actually run the program instead of just loading (Yonghong)
> * Add a bpf_map_update_elem call to the test (Yonghong)
> * Refactor runner such that existing test and newly-added test are
>   subtests of 'ringbuf' top-level test (Yonghong)
> * Remove unused globals in test prog (Yonghong)
>
>  tools/testing/selftests/bpf/Makefile          |  8 ++-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 63 ++++++++++++++++-
>  .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
>  3 files changed, 137 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6cd327f1f216..231d9c1364c9 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -351,9 +351,11 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h              \
>                 test_subskeleton.skel.h test_subskeleton_lib.skel.h     \
>                 test_usdt.skel.h
>
> -LSKELS := fentry_test.c fexit_test.c fexit_sleep.c \
> -       test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
> -       map_ptr_kern.c core_kern.c core_kern_overflow.c
> +LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c           \
> +       trace_printk.c trace_vprintk.c map_ptr_kern.c                   \
> +       core_kern.c core_kern_overflow.c test_ringbuf.c                 \
> +       test_ringbuf_map_key.c
> +
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
>         kfunc_call_test_subprog.c
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> index 9a80fe8a6427..e0f8db69cb77 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -13,6 +13,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/ring_buffer.h>
>  #include "test_ringbuf.lskel.h"
> +#include "test_ringbuf_map_key.lskel.h"
>
>  #define EDONE 7777
>
> @@ -58,6 +59,7 @@ static int process_sample(void *ctx, void *data, size_t len)
>         }
>  }
>
> +static struct test_ringbuf_map_key_lskel *skel_map_key;
>  static struct test_ringbuf_lskel *skel;
>  static struct ring_buffer *ringbuf;
>
> @@ -81,7 +83,7 @@ static void *poll_thread(void *input)
>         return (void *)(long)ring_buffer__poll(ringbuf, timeout);
>  }
>
> -void test_ringbuf(void)
> +void ringbuf_subtest(void)
>  {
>         const size_t rec_sz = BPF_RINGBUF_HDR_SZ + sizeof(struct sample);
>         pthread_t thread;
> @@ -297,3 +299,62 @@ void test_ringbuf(void)
>         ring_buffer__free(ringbuf);
>         test_ringbuf_lskel__destroy(skel);
>  }
> +
> +static int process_map_key_sample(void *ctx, void *data, size_t len)
> +{
> +       struct sample *s;
> +       int err, val;
> +
> +       s = data;
> +       switch (s->seq) {
> +       case 1:
> +               ASSERT_EQ(s->value, 42, "sample_value");
> +               err = bpf_map_lookup_elem(skel_map_key->maps.hash_map.map_fd,
> +                                         s, &val);
> +               ASSERT_OK(err, "hash_map bpf_map_lookup_elem");
> +               ASSERT_EQ(val, 1, "hash_map val");
> +               return -EDONE;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +void ringbuf_map_key_subtest(void)
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
> +
> +       err = test_ringbuf_map_key_lskel__attach(skel_map_key);
> +       if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__attach"))
> +               goto cleanup_ringbuf;
> +
> +       syscall(__NR_getpgid);
> +       ASSERT_EQ(skel_map_key->bss->seq, 1, "skel_map_key->bss->seq");
> +       ring_buffer__poll(ringbuf, -1);

Why is there no err == EDONE check here?
Without the check the prog could have skipped
ringbuf_submit and process_map_key_sample() above would not
be called.
