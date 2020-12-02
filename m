Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD92CB2C6
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 03:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgLBCXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 21:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgLBCXm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 21:23:42 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FFC0613CF;
        Tue,  1 Dec 2020 18:23:02 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id k65so234293ybk.5;
        Tue, 01 Dec 2020 18:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVY1xJYGIbxBh0nasrLi68Z1q4f8Z/tZBYt6pgY2b7s=;
        b=L0sHanHtNqOz8LEsMvp6nSuSztTBYODyy3lBGbqYz48Fdz2wMmQYQNyDRRE7z4s3LC
         tKb/ojHERjiVxrQ5VYF/A1zvt3hYUieXLM32viHiAQDlA7olz0Pt18HZBhkXuofSYalM
         wonQ7SZbpknGAHMk6m9Uwe8FbKIBQzWBPzfRoXrPxWP//7CF7rGcf142xbmEjbp+f/qB
         6mfdnMvUFLfHlT6Y8oi7MJasHkiR76u1+B216igo4pJX4un6DY3wEoCHok/xmmSmXXvJ
         k1gJEbFg8p96JkfCPSn6to8SEmaPjtL5DD1QFuqNIHNT+xkZNA65umkerI7Mf2JC6xBh
         Wc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVY1xJYGIbxBh0nasrLi68Z1q4f8Z/tZBYt6pgY2b7s=;
        b=rEjTJ64T1C5heGfK8M6SJzSLjniOJIsD+Y9/BeqoUWnpjqkZrBCFaAwKddKw0e5YIK
         of5yMUn/GjBaD1AUNmqrSnNnpxUtrBknzMLPZpGXRyLYkNWr7n31lHdZZ7/I3GCvnFMU
         rJahlDRCQ9+9RprxLiKR+P8T2A15iIdwU9cdCKjm28R4Iv6oK8rZgAzK26xFUMuboMQT
         mt4Ai6SSC1o5NWrsnUa9mh1C6BVv8NYrzX3O20CwgZE63LdJFcbsGjAUl4TqZ9BMxnFX
         aVTxMNcU4dbnBIFYGqPgTIry3SjQOGNJRnDUZt7sU0kMYLXsMnqyFXjZqEU4y9Hq/OOc
         1Wfg==
X-Gm-Message-State: AOAM533QwUmgN0Upr37SnEqr+v6vl/vaQwD7MC3I7g+lBhDIKf9ITHG2
        nUsJUDdn5Ot8+p9j6ekAScALiopqsirqQOR7gUUIWndqmOs5BQ==
X-Google-Smtp-Source: ABdhPJy0WurQJRqX040zo5Uc6DCX7aqWHaN0N5ZZs5QK9CWmskuhJXkYfW4vkJP5YqaohbQar1kufuyhR2UVkdfabtI=
X-Received: by 2002:a25:df82:: with SMTP id w124mr463875ybg.347.1606875781423;
 Tue, 01 Dec 2020 18:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com> <20201127175738.1085417-13-jackmanb@google.com>
In-Reply-To: <20201127175738.1085417-13-jackmanb@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 18:22:50 -0800
Message-ID: <CAEf4BzaAgtPazgOUQYnN9eV+TqPLtK0JTd14j5QmzeNXPZ+seQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Add tests for new BPF atomic operations
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 10:01 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> This relies on the work done by Yonghong Song in
> https://reviews.llvm.org/D72184
>
> Note the hackery in the Makefile that is necessary to avoid breaking
> tests for people who haven't yet got a version of Clang supporting
> V4. It seems like this hackery ought to be confined to
> tools/build/feature - I tried implementing that and found that it
> ballooned into an explosion of nightmares at the top of
> tools/testing/selftests/bpf/Makefile without actually improving the
> clarity of the CLANG_BPF_BUILD_RULE code at all. Hence the simple
> $(shell) call...
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  12 +-
>  .../selftests/bpf/prog_tests/atomics_test.c   | 329 ++++++++++++++++++
>  .../selftests/bpf/progs/atomics_test.c        | 124 +++++++
>  .../selftests/bpf/verifier/atomic_and.c       |  77 ++++
>  .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++
>  .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++
>  .../selftests/bpf/verifier/atomic_or.c        |  77 ++++
>  .../selftests/bpf/verifier/atomic_sub.c       |  44 +++
>  .../selftests/bpf/verifier/atomic_xchg.c      |  46 +++
>  .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++
>  tools/testing/selftests/bpf/verifier/ctx.c    |   2 +-
>  11 files changed, 987 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_sub.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 3d5940cd110d..5eadfd09037d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -228,6 +228,12 @@ IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
>                         grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
>  MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
>
> +# Determine if Clang supports BPF arch v4, and therefore atomics.
> +CLANG_SUPPORTS_V4=$(if $(findstring v4,$(shell $(CLANG) --target=bpf -mcpu=? 2>&1)),true,)
> +ifeq ($(CLANG_SUPPORTS_V4),true)
> +       CFLAGS += -DENABLE_ATOMICS_TESTS
> +endif
> +
>  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
>  BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)                  \
>              -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
> @@ -250,7 +256,9 @@ define CLANG_BPF_BUILD_RULE
>         $(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
>         $(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm                     \
>                 -c $1 -o - || echo "BPF obj compilation failed") |      \
> -       $(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> +       $(LLC) -mattr=dwarfris -march=bpf                               \
> +               -mcpu=$(if $(CLANG_SUPPORTS_V4),v4,v3)                  \
> +               $4 -filetype=obj -o $2
>  endef
>  # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
>  define CLANG_NOALU32_BPF_BUILD_RULE
> @@ -391,7 +399,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c      \
>  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read                          \
>                        $(wildcard progs/btf_dump_test_case_*.c)
>  TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) $(if $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)
>  TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>  $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> new file mode 100644
> index 000000000000..8ecc0392fdf9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#ifdef ENABLE_ATOMICS_TESTS
> +
> +#include "atomics_test.skel.h"
> +

[...]

> +
> +static void test_xchg(void)
> +{
> +       struct atomics_test *atomics_skel = NULL;

nit: = NULL is unnecessary

> +       int err, prog_fd;
> +       __u32 duration = 0, retval;
> +
> +       atomics_skel = atomics_test__open_and_load();
> +       if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
> +               goto cleanup;
> +
> +       err = atomics_test__attach(atomics_skel);
> +       if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
> +               goto cleanup;
> +
> +       prog_fd = bpf_program__fd(atomics_skel->progs.add);
> +       err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
> +                               NULL, NULL, &retval, &duration);
> +       if (CHECK(err || retval, "test_run add",
> +                 "err %d errno %d retval %d duration %d\n",
> +                 err, errno, retval, duration))
> +               goto cleanup;
> +
> +       CHECK(atomics_skel->data->xchg64_value != 2, "xchg64_value",
> +             "64bit xchg left unexpected value (got %lld want 2)\n",
> +             atomics_skel->data->xchg64_value);
> +       CHECK(atomics_skel->bss->xchg64_result != 1, "xchg_result",
> +             "64bit xchg returned bad result (got %lld want 1)\n",
> +             atomics_skel->bss->xchg64_result);
> +
> +       CHECK(atomics_skel->data->xchg32_value != 2, "xchg32_value",
> +             "32bit xchg left unexpected value (got %d want 2)\n",
> +             atomics_skel->data->xchg32_value);
> +       CHECK(atomics_skel->bss->xchg32_result != 1, "xchg_result",
> +             "32bit xchg returned bad result (got %d want 1)\n",
> +             atomics_skel->bss->xchg32_result);

ASSERT_EQ() is less verbose.

> +
> +cleanup:
> +       atomics_test__destroy(atomics_skel);
> +}
> +
> +void test_atomics_test(void)
> +{

why the gigantic #ifdef/#else block if you could do the check here,
skip and exit?

> +       test_add();
> +       test_sub();
> +       test_and();
> +       test_or();
> +       test_xor();
> +       test_cmpxchg();
> +       test_xchg();


please model these as sub-tests, it will be easier to debug, if anything

> +}
> +
> +#else /* ENABLE_ATOMICS_TESTS */
> +
> +void test_atomics_test(void)
> +{
> +       printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
> +              __func__);
> +       test__skip();
> +}
> +
> +#endif /* ENABLE_ATOMICS_TESTS */
> diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
> new file mode 100644
> index 000000000000..3139b00937e5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/atomics_test.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#ifdef ENABLE_ATOMICS_TESTS
> +
> +__u64 add64_value = 1;
> +__u64 add64_result = 0;
> +__u32 add32_value = 1;
> +__u32 add32_result = 0;
> +__u64 add_stack_value_copy = 0;
> +__u64 add_stack_result = 0;

empty line here

> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(add, int a)
> +{
> +       __u64 add_stack_value = 1;
> +
> +       add64_result = __sync_fetch_and_add(&add64_value, 2);
> +       add32_result = __sync_fetch_and_add(&add32_value, 2);
> +       add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
> +       add_stack_value_copy = add_stack_value;
> +
> +       return 0;
> +}
> +
> +__s64 sub64_value = 1;
> +__s64 sub64_result = 0;
> +__s32 sub32_value = 1;
> +__s32 sub32_result = 0;
> +__s64 sub_stack_value_copy = 0;
> +__s64 sub_stack_result = 0;

same

> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(sub, int a)
> +{
> +       __u64 sub_stack_value = 1;
> +
> +       sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
> +       sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
> +       sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
> +       sub_stack_value_copy = sub_stack_value;
> +
> +       return 0;
> +}
> +
> +__u64 and64_value = (0x110ull << 32);
> +__u64 and64_result = 0;
> +__u32 and32_value = 0x110;
> +__u32 and32_result = 0;

yep

> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(and, int a)
> +{
> +
> +       and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
> +       and32_result = __sync_fetch_and_and(&and32_value, 0x011);
> +
> +       return 0;
> +}
> +
> +__u64 or64_value = (0x110ull << 32);
> +__u64 or64_result = 0;
> +__u32 or32_value = 0x110;
> +__u32 or32_result = 0;

here too

> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(or, int a)
> +{
> +       or64_result = __sync_fetch_and_or(&or64_value, 0x011ull << 32);
> +       or32_result = __sync_fetch_and_or(&or32_value, 0x011);
> +
> +       return 0;
> +}
> +
> +__u64 xor64_value = (0x110ull << 32);
> +__u64 xor64_result = 0;
> +__u32 xor32_value = 0x110;
> +__u32 xor32_result = 0;

you get the idea... How often do you define global variables in
user-space code right next to the function without an extra line
between them?..

> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(xor, int a)
> +{
> +       xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
> +       xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
> +
> +       return 0;
> +}
> +
> +__u64 cmpxchg64_value = 1;
> +__u64 cmpxchg64_result_fail = 0;
> +__u64 cmpxchg64_result_succeed = 0;
> +__u32 cmpxchg32_value = 1;
> +__u32 cmpxchg32_result_fail = 0;
> +__u32 cmpxchg32_result_succeed = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(cmpxchg, int a)
> +{
> +       cmpxchg64_result_fail = __sync_val_compare_and_swap(
> +               &cmpxchg64_value, 0, 3);
> +       cmpxchg64_result_succeed = __sync_val_compare_and_swap(
> +               &cmpxchg64_value, 1, 2);
> +
> +       cmpxchg32_result_fail = __sync_val_compare_and_swap(
> +               &cmpxchg32_value, 0, 3);
> +       cmpxchg32_result_succeed = __sync_val_compare_and_swap(
> +               &cmpxchg32_value, 1, 2);

single lines are fine here and much more readable

> +
> +       return 0;
> +}
> +
> +__u64 xchg64_value = 1;
> +__u64 xchg64_result = 0;
> +__u32 xchg32_value = 1;
> +__u32 xchg32_result = 0;
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(xchg, int a)
> +{
> +       __u64 val64 = 2;
> +       __u32 val32 = 2;
> +
> +       __atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
> +       __atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
> +
> +       return 0;
> +}
> +
> +#endif /* ENABLE_ATOMICS_TESTS */

[...]
