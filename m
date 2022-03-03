Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39F34CB61E
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 06:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiCCE7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCCE7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:59:46 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912B213FAF5
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:59:00 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id k7so3134911ilo.8
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMQ/XvxGa0NDlk6zpJ0bYw9GieiJspLDRSpN4Iu0As0=;
        b=H0s983Tl2lhGVjcMQ/gye5N5YgUbD8vn8MIroIMU9tpFrH6R312h3zqO7LP4w1kC9g
         dcsfSzazrvfMPQl89HMffbHH3qtRhxacJZhB4rQuyM9XLTZbj+wCQ78yuD0sfa2Gk+8L
         oHTolb5VgrRWe75pnRtnVjnbrKhfh4qCO/wm5pvOAq8gtH5Gv2SDapXEaQ8ybceYgjrR
         D4fg6gLW0sHTEd/+Zp1JQhdk9njGlGDD4oxuXJepry96LzDLJP2A5HwGuN7l3V2Y3YnW
         diWegt49z7rmokccAhZ0cIT7oH7fEDA/ZPx9wks+JSyJVNmEke6FVeaaoG+YIQtc9286
         aUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMQ/XvxGa0NDlk6zpJ0bYw9GieiJspLDRSpN4Iu0As0=;
        b=wObjjr5I6ex+BRZeQFbRxuXP2WaYCvpkGzhVE6pkuT+XB6TcNKE1u8v87zPm2TE73g
         v1Lf6yfiz6woWLTc9fPxf13rZYcwtz2iOvOigTJF2d3e/LjvLVgmK2tYx3XsO0ugeAT/
         m7vXagfdZ7q6GIr8PWYLaZ7F8uSiIfVdDnc86q3mY1omr4esnjo94X+srRatTjFUkCzR
         UCeYt3v8Senguniedzfx+vzteYGxSuLt1Oy0mQd8agKYQ7d+QltHqDuTE1F7qWr2N9o1
         1WvRFO4+waaLlozEQ2kulMrOKOwqpb0f7B17crc2+xfVY6JZ739K0PnR93T7zSUQ0a9C
         EkRQ==
X-Gm-Message-State: AOAM533rkVKbi3y1UxaU5gKF0d+0xrulT9akeB0LG5Q1TsVCb2f3iLnG
        YPq/8SDHYTBJmYNuMCqM2MUo3APz/fLn/Pix7xFeNZXo6ow=
X-Google-Smtp-Source: ABdhPJyvGNOWboByUESUm/R1renAsBxyZcFHo9Zu+tZnZh8peX1kr1MPMhINqwNilRSL9iuTpyp6mcC1TBPdjvENwVY=
X-Received: by 2002:a92:c148:0:b0:2c2:615a:49e9 with SMTP id
 b8-20020a92c148000000b002c2615a49e9mr30424404ilh.98.1646283539910; Wed, 02
 Mar 2022 20:58:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <89a850b9c06835b839da76386ee0e4bbeaf5a37b.1646188795.git.delyank@fb.com>
In-Reply-To: <89a850b9c06835b839da76386ee0e4bbeaf5a37b.1646188795.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Mar 2022 20:58:48 -0800
Message-ID: <CAEf4Bzb4S+Vs6-TfzMYrieSQdR0yeg1DaCguYnt6PgQiDtHBHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: test subskeleton functionality
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

On Tue, Mar 1, 2022 at 6:49 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> The new Makefile support via SUBSKELS and .skel.h-deps is a mixture
> of LINKED_SKELS and LSKELS. By definition subskeletons require multiple
> BPF object files to be linked together. However, generating the
> subskeleton only requires the library object file and not the final
> program object file.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile          | 18 ++++++++-
>  .../selftests/bpf/prog_tests/subskeleton.c    | 38 +++++++++++++++++++
>  .../bpf/prog_tests/subskeleton_lib.c          | 29 ++++++++++++++
>  .../selftests/bpf/progs/test_subskeleton.c    | 20 ++++++++++
>  .../bpf/progs/test_subskeleton_lib.c          | 22 +++++++++++
>  5 files changed, 125 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton_lib.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index fe12b4f5fe20..57da63ba790b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -326,19 +326,23 @@ endef
>  SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
>
>  LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h          \
> -               linked_vars.skel.h linked_maps.skel.h
> +               linked_vars.skel.h linked_maps.skel.h test_subskeleton.skel.h
> +
> +SUBSKELS := test_subskeleton_lib.skel.h

So, unless I'm mistaken, bpf_object__open() will succeed for
"incomplete" BPF object file (e.g., even if they have unresolved
externs, for example). At least that used to be the case.

In such a case, we can totally generate both skeletons and
sub-skeletons for all files for which we currently generate skeletons.
It will keep Makefile simpler and will test sub-skeleton code
generator on a much wider variety of BPF object files. Let's use
.subskel.h naming convention for those. We can even add a simple test
in test_skeleton, test_vmlinux and a bunch of others that "stress
test" skeleton features to make sure that corresponding sub-skeleton
can be opened just fine.

We probably will run into name conflicts for <skel>__open and
<skel>__destroy... So we can either use <skel>__open_subskel and
<skel>__destroy_subskel to disambiguate (might not be a bad idea to
make it clear that we are dealing with "incomplete" sub-skeleton), or
we can just not test skeleton and sub-skeleton in the same user-space
.c file. Not sure if anyone feels strongly about naming, let me know.

>
>  LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
>         test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
>         map_ptr_kern.c core_kern.c core_kern_overflow.c
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
> -SKEL_BLACKLIST += $$(LSKELS)
> +SKEL_BLACKLIST += $$(LSKELS) $$(SUBSKELS)
>
>  test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
>  linked_funcs.skel.h-deps := linked_funcs1.o linked_funcs2.o
>  linked_vars.skel.h-deps := linked_vars1.o linked_vars2.o
>  linked_maps.skel.h-deps := linked_maps1.o linked_maps2.o
> +test_subskeleton.skel.h-deps := test_subskeleton_lib.o test_subskeleton.o
> +test_subskeleton_lib.skel.h-deps := test_subskeleton_lib.o
>
>  LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
>
> @@ -363,6 +367,7 @@ TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,   \
>                                  $$(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),\
>                                                $$(TRUNNER_BPF_SRCS)))
>  TRUNNER_BPF_LSKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS) $$(LSKELS_EXTRA))
> +TRUNNER_BPF_SUBSKELS := $$(addprefix $$(TRUNNER_OUTPUT)/,$(SUBSKELS))
>  TRUNNER_BPF_SKELS_LINKED := $$(addprefix $$(TRUNNER_OUTPUT)/,$(LINKED_SKELS))
>  TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
>
> @@ -405,6 +410,14 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>         $(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
>         $(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$@
>
> +$(TRUNNER_BPF_SUBSKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> +       $$(call msg,GEN-SUBSKEL,$(TRUNNER_BINARY),$$@)
> +       $(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
> +       $(Q)$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o)
> +       $(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
> +       $(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
> +       $(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$@
> +
>  $(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>         $$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
>         $(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
> @@ -441,6 +454,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:                   \
>                       $(TRUNNER_EXTRA_HDRS)                             \
>                       $(TRUNNER_BPF_OBJS)                               \
>                       $(TRUNNER_BPF_SKELS)                              \
> +                     $(TRUNNER_BPF_SUBSKELS)                           \
>                       $(TRUNNER_BPF_LSKELS)                             \
>                       $(TRUNNER_BPF_SKELS_LINKED)                       \
>                       $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> diff --git a/tools/testing/selftests/bpf/prog_tests/subskeleton.c b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
> new file mode 100644
> index 000000000000..651aafc28e7f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019 Facebook */
> +

year is off

> +#include <test_progs.h>
> +#include "test_subskeleton.skel.h"
> +
> +extern void subskeleton_lib_setup(struct bpf_object *obj);
> +extern int subskeleton_lib_subresult(struct bpf_object *obj);
> +
> +void test_subskeleton(void)
> +{
> +       int duration = 0, err, result;
> +       struct test_subskeleton *skel;
> +
> +       skel = test_subskeleton__open();
> +       if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))

no CHECK()s

> +               return;
> +
> +       skel->rodata->rovar1 = 10;
> +
> +       err = test_subskeleton__load(skel);
> +       if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))

CHECK

> +               goto cleanup;
> +
> +       subskeleton_lib_setup(skel->obj);
> +
> +       err = test_subskeleton__attach(skel);
> +       if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))

CHECK

> +               goto cleanup;
> +
> +       /* trigger tracepoint */
> +       usleep(1);
> +
> +       result = subskeleton_lib_subresult(skel->obj) * 10;
> +       ASSERT_EQ(skel->bss->out1, result, "unexpected calculation");
> +cleanup:
> +       test_subskeleton__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/prog_tests/subskeleton_lib.c b/tools/testing/selftests/bpf/prog_tests/subskeleton_lib.c
> new file mode 100644
> index 000000000000..f7f98b3febaf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/subskeleton_lib.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019 Facebook */
> +

outdated year?

> +#include <test_progs.h>
> +#include <bpf/libbpf.h>
> +
> +#include "test_subskeleton_lib.skel.h"
> +
> +void subskeleton_lib_setup(struct bpf_object *obj)
> +{
> +       struct test_subskeleton_lib *lib = test_subskeleton_lib__open(obj);
> +
> +       ASSERT_OK_PTR(lib, "open subskeleton");

return on failed assert, otherwise SIGSEGV

> +
> +       *lib->data.var1 = 1;
> +       *lib->bss.var2 = 2;
> +       lib->bss.var3->var3_1 = 3;
> +       lib->bss.var3->var3_2 = 4;
> +}
> +
> +int subskeleton_lib_subresult(struct bpf_object *obj)
> +{
> +       struct test_subskeleton_lib *lib = test_subskeleton_lib__open(obj);
> +
> +       ASSERT_OK_PTR(lib, "open subskeleton");
> +
> +       ASSERT_EQ(*lib->bss.libout1, 1 + 2 + 3 + 4, "lib subresult");
> +       return *lib->bss.libout1;
> +}

I'm not sure we really need to have a separate user-space file to
simulate a library code. Let's have this library setup code in the
selftest file itself

> diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton.c b/tools/testing/selftests/bpf/progs/test_subskeleton.c
> new file mode 100644
> index 000000000000..bad3970718cb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_subskeleton.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +const int rovar1;
> +int out1;

see below, let's have some shared stuff between skeleton and
subskeleton (.kconfig, variable used from lib, variable defined in
lib, etc). Think creatively on how you could break codegen :)

As we want to add maps, I'd also use extern maps for more coverage

> +
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
> +int VERSION SEC("version") = 1;

see below, no VERSION nowadays

> diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c b/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
> new file mode 100644
> index 000000000000..23c7f24997a7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +int var1 = -1;
> +int var2;
> +struct {
> +       int var3_1;
> +       __s64 var3_2;
> +} var3;
> +int libout1;

we should also test:

- .kconfig externs
- __weak variables
- .rodata variable (like Alexei already mentioned)
- let's also have an array variable (C uses non-uniform syntax for
pointer to an array)
- extern .data variable defined in another file

> +
> +int lib_routine(void)
> +{
> +       libout1 =  var1 + var2 + var3.var3_1 + var3.var3_2;

nit: extra space after =

> +       return libout1;
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";
> +int VERSION SEC("version") = 1;

VERSION is obsolete, please drop

> --
> 2.34.1
