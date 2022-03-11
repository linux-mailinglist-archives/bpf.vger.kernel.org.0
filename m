Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411D4D6AF2
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 00:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiCKXl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 18:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiCKXlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 18:41:22 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516A9186C2
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:40:18 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r11so11898895ioh.10
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohWhs9J0cXVAK5H3Kn3StzKsqENmwZf7ApAc/cEDiEo=;
        b=o2PCs7dDnHzWWYWaP+6fqcAdlaGSDbeD/5eXGg6bsD+KJNuKcJH0sCAgDMmN1f/sT3
         asPZVzA2WyGMpVQV6t1wkyzRB1gh8J8tbSPyTPzzX11Y0X8l8sOv8uYoX8Xy+hKkraib
         nJasQgtSOGiVoTN4ynKiJjDfr0G/f2RhsyALnEejZZZ9AwJ7KFOj7uUJOGXnLjUKAb+w
         3cmk2Xv+Vuk1yTmPgeksY+kZISfof2Bh9R5lCKtJ1LQrEnfAVPC0i+ITVzVFJ81xWJYc
         pDPZoazpIN+2AmT9UhAlB3KGwD0TYMj8xoO1O1ABvzqu+stOXj1NVDdlxdG2eF6xTALL
         m6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohWhs9J0cXVAK5H3Kn3StzKsqENmwZf7ApAc/cEDiEo=;
        b=kJdd3me0oqDzUWKNuKsiR5v54Aktx1gW4CckvFIvSOvSEIq1LusWTZBeTk1vYIvila
         6v0yFcvVfFlTIbnNBMIPdBi1gZKV5CVV6D4IfoOpmWKDQIhiprM+fEtcslpj3aEb/QKv
         aMwHHMnfUE/KV+Aq4wpyWuvxEHIvy6onDWOaCz6fL7YSlsLNUw4P8sAQaj/tb0qVuoBo
         W/sa8iM9Q2EZEQd0pcZytcOwdtTn8gVyICe/75RHfmqKO5XCcDyQ6bm3gz0BKa8A2i+G
         kExHXTGTg3+16d7P2zEf9KJ9uOAETE4NqJcQ3dQZ0LrYImnqiRctTUFCBBETOOCNgoDb
         HiVg==
X-Gm-Message-State: AOAM532mqt+GKDCBSwAvS3Eh/awbKoSV1ZF03NTSoUUJkhbBx5+z6ahj
        xMmMcoAyRq8kcGQLnkYwZBwYumIsOJQ7Gn8qmtM=
X-Google-Smtp-Source: ABdhPJx5Sw0oLQwzM8txYf+eKCo+vqwngMSJfCxJC5BaNLzBBCLW9mW2FDgAK72zmq80B2B+Q5cC4UFq+xEC9lNPpnU=
X-Received: by 2002:a05:6638:33a8:b0:319:cb5c:f6d9 with SMTP id
 h40-20020a05663833a800b00319cb5cf6d9mr5312539jav.93.1647042017606; Fri, 11
 Mar 2022 15:40:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <f262f63b36d00d4a77d1166bcaffe7684b6ebbee.1646957399.git.delyank@fb.com>
In-Reply-To: <f262f63b36d00d4a77d1166bcaffe7684b6ebbee.1646957399.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Mar 2022 15:40:06 -0800
Message-ID: <CAEf4BzaVt=+g2gKpMqsNH5JGSvEJnjnDHW7ueFFgcUtBv1z01Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: test subskeleton functionality
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Thu, Mar 10, 2022 at 4:12 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> This patch changes the selftests/bpf Makefile to  also generate
> a subskel.h for every skel.h it would have normally generated.
>
> Separately, it also introduces a new subskeleton test which tests
> library objects, externs, weak symbols, kconfigs, and user maps.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |  1 +
>  tools/testing/selftests/bpf/Makefile          | 10 ++-
>  .../selftests/bpf/prog_tests/subskeleton.c    | 83 +++++++++++++++++++
>  .../selftests/bpf/progs/test_subskeleton.c    | 23 +++++
>  .../bpf/progs/test_subskeleton_lib.c          | 56 +++++++++++++
>  .../bpf/progs/test_subskeleton_lib2.c         | 16 ++++
>  6 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index a7eead8820a0..595565eb68c0 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -31,6 +31,7 @@ test_tcp_check_syncookie_user
>  test_sysctl
>  xdping
>  test_cpp
> +*.subskel.h
>  *.skel.h
>  *.lskel.h
>  /no_alu32
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index fe12b4f5fe20..9f7b22faedd6 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -328,6 +328,12 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
>  LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h          \
>                 linked_vars.skel.h linked_maps.skel.h
>
> +# In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
> +# but that's created as a side-effect of the skel.h generation.
> +LINKED_SKELS += test_subskeleton.skel.h test_subskeleton_lib.skel.h

this can be part of LINKED_SKELS list above, no need to split
definition. The comment above is very useful, but can stay near -deps
definitions without hurting understanding, IMO

> +test_subskeleton.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o test_subskeleton.o
> +test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o
> +
>  LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
>         test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
>         map_ptr_kern.c core_kern.c core_kern_overflow.c
> @@ -404,6 +410,7 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>         $(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
>         $(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
>         $(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$@
> +       $(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$(@:.skel.h=.subskel.h)

we shouldn't need or use name for subskeleton (in real life you won't
know the name of the final bpf_object)

>
>  $(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>         $$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> @@ -421,6 +428,7 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
>         $(Q)diff $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
>         $$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
>         $(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@
> +       $(Q)$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h)

probably don't need subskel for LSKELS (and it just adds race when we
generate both skeleton and light skeleton for the same object file)

>  endif
>
>  # ensure we set up tests.h header generation rule just once
> @@ -557,6 +565,6 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR) \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
>         feature bpftool                                                 \
> -       $(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h no_alu32 bpf_gcc bpf_testmod.ko)
> +       $(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h no_alu32 bpf_gcc bpf_testmod.ko)
>
>  .PHONY: docs docs-clean
> diff --git a/tools/testing/selftests/bpf/prog_tests/subskeleton.c b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
> new file mode 100644
> index 000000000000..9cbe17281f17
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include "test_subskeleton.skel.h"
> +#include "test_subskeleton_lib.subskel.h"
> +
> +void subskeleton_lib_setup(struct bpf_object *obj)

static?

> +{
> +       struct test_subskeleton_lib *lib = test_subskeleton_lib__open(obj);
> +
> +       if (!ASSERT_OK_PTR(lib, "open subskeleton"))
> +               goto out;

nit: can return early, if open failed that lib should be NULL, right?

> +
> +       *lib->rodata.var1 = 1;
> +       *lib->data.var2 = 2;
> +       lib->bss.var3->var3_1 = 3;
> +       lib->bss.var3->var3_2 = 4;
> +
> +out:
> +       test_subskeleton_lib__destroy(lib);
> +}
> +
> +int subskeleton_lib_subresult(struct bpf_object *obj)

static?

> +{
> +       struct test_subskeleton_lib *lib = test_subskeleton_lib__open(obj);
> +       int result;
> +
> +       if (!ASSERT_OK_PTR(lib, "open subskeleton")) {
> +               result = -EINVAL;
> +               goto out;
> +       }

same, just return ?


> +
> +       result = *lib->bss.libout1;
> +       ASSERT_EQ(result, 1 + 2 + 3 + 4 + 5 + 6, "lib subresult");
> +
> +       ASSERT_OK_PTR(lib->progs.lib_perf_handler, "lib_perf_handler");
> +       ASSERT_STREQ(bpf_program__name(lib->progs.lib_perf_handler),
> +                    "lib_perf_handler", "program name");
> +
> +       ASSERT_OK_PTR(lib->maps.map1, "map1");
> +       ASSERT_STREQ(bpf_map__name(lib->maps.map1), "map1", "map name");
> +
> +       ASSERT_EQ(*lib->data.var5, 5, "__weak var5");
> +       ASSERT_EQ(*lib->data.var6, 6, "extern var6");
> +       ASSERT_TRUE(*lib->kconfig.CONFIG_BPF_SYSCALL, "CONFIG_BPF_SYSCALL");
> +
> +out:
> +       test_subskeleton_lib__destroy(lib);
> +       return result;
> +}
> +
> +void test_subskeleton(void)
> +{
> +       int err, result;
> +       struct test_subskeleton *skel;
> +
> +       skel = test_subskeleton__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       skel->rodata->rovar1 = 10;
> +       skel->rodata->var1 = 1;
> +       subskeleton_lib_setup(skel->obj);
> +
> +       err = test_subskeleton__load(skel);
> +       if (!ASSERT_OK(err, "skel_load"))
> +               goto cleanup;
> +
> +

nit: extra empty line

> +       err = test_subskeleton__attach(skel);
> +       if (!ASSERT_OK(err, "skel_attach"))
> +               goto cleanup;
> +
> +       /* trigger tracepoint */
> +       usleep(1);
> +
> +       result = subskeleton_lib_subresult(skel->obj) * 10;
> +       ASSERT_EQ(skel->bss->out1, result, "unexpected calculation");
> +
> +cleanup:
> +       test_subskeleton__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton.c b/tools/testing/selftests/bpf/progs/test_subskeleton.c
> new file mode 100644
> index 000000000000..5bd5452b41cd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_subskeleton.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +/* volatile to force a read, compiler may assume 0 otherwise */
> +const volatile int rovar1;
> +int out1;
> +
> +/* Override weak symbol in test_subskeleton_lib */
> +int var5 = 5;
> +

can you please add CONFIG_BPF_SYSCALL here as well, to check that
externs are properly "merged" and found, even if they overlap between
library and app BPF code

> +extern int lib_routine(void);
> +
> +SEC("raw_tp/sys_enter")
> +int handler1(const void *ctx)
> +{
> +       out1 = lib_routine() * rovar1;
> +       return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c b/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
> new file mode 100644
> index 000000000000..665338006e33
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <stdbool.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +/* volatile to force a read */
> +const volatile int var1;
> +volatile int var2 = 1;
> +struct {
> +       int var3_1;
> +       __s64 var3_2;
> +} var3;
> +int libout1;
> +
> +extern volatile bool CONFIG_BPF_SYSCALL __kconfig;
> +
> +int var4[4];
> +
> +__weak int var5 SEC(".data");
> +extern int var6;
> +int (*fn_ptr)(void);
> +

libbpf supports .data.my_custom_name and .rodata.my_custom_whatever,
let's have a variable to test this also works?


> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __type(key, __u32);
> +       __type(value, __u32);
> +       __uint(max_entries, 16);
> +} map1 SEC(".maps");
> +
> +extern struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __type(key, __u32);
> +       __type(value, __u32);
> +       __uint(max_entries, 16);
> +} map2 SEC(".maps");
> +
> +int lib_routine(void)
> +{
> +       __u32 key = 1, value = 2;
> +
> +       (void) CONFIG_BPF_SYSCALL;
> +       bpf_map_update_elem(&map2, &key, &value, BPF_ANY);
> +
> +       libout1 = var1 + var2 + var3.var3_1 + var3.var3_2 + var5 + var6;
> +       return libout1;
> +}
> +
> +SEC("perf_event")
> +int lib_perf_handler(struct pt_regs *ctx)
> +{
> +       return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c b/tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c
> new file mode 100644
> index 000000000000..cbff92674b76
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __type(key, __u32);
> +       __type(value, __u32);
> +       __uint(max_entries, 16);
> +} map2 SEC(".maps");
> +

let's move this into progs/test_subskeleton.c instead. It will
simulate a bit more complicated scenario, where library expects
application to define and provide a map, but the library itself
doesn't define it. It should work just fine right now (I think), but
just in case let's double check that having only "extern map" in the
library works.

> +int var6 = 6;
> +
> +char LICENSE[] SEC("license") = "GPL";
> --
> 2.34.1
