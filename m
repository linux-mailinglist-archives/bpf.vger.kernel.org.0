Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5219952954C
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 01:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiEPX2c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 19:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348036AbiEPX2b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 19:28:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B83FBCC
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:28:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id s12so8971766iln.11
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJTPwb08Mc83JjERwzwUE80vVRGVXxtoGmjI2915s1w=;
        b=oG6pPgkF9rRI5rqSBg21cxkcdMoXIM4dfP17b7dgQqhk5oxoikn8zkp1Pf5+hW2v1j
         nZkSnX3Gj6uKcye2FNHIlxMzBBNmJuCGbO3JlcNkGqv3w4Ae5tfpQIstgnFZ+ulqIgtl
         Xw5RvGFCdIReEc0/s8VY9xheFIqHHx3dIxj1N8YBXgTagRJIkLi+AswbO/agW5BQRvAq
         SIj64PMl+8DPUFEuEEuxyX/3Q9XPHGcq7cmBbOAlBlenoYvkbd0Li7Wb3Nal5fiuLRnA
         WgnWokY12YHfMsN8lf8hz+/5Gjc7VUK1bViaJL6FIn+oDvZHCC4IpGnqg4BR7dRnAEDu
         6j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJTPwb08Mc83JjERwzwUE80vVRGVXxtoGmjI2915s1w=;
        b=zZFIamYsmI2A7XIJ8HHc+oTk+xN+7RpZpWrZdZDtgUYuwJLZD0/yN5Hb0oCWq4SDSW
         piLD/cNaBw/A5ar0EbxtCs4k1C71M587gMraneTaY8LldgpherRyuplcnuL36kKrbV1V
         9CYYQlxkp5xj+ssorpZ4rQqZ2mOjCyIJI6v0xkKVwjS5OdEebWKhBfF2hZXGsqZYJOvr
         nbUR7qeVdFPvArX4JpZG6OUy7WS74SpvCfxT63x9Mqg+6PsUfaxcjfofb7FB6Md7x0zT
         X/mBDQdgWDZaBhtkhCrp9b1AjsU4psehstqqhS0wlm8gcd3cTrqJvlYL5aMNFIdc2e9h
         +f7Q==
X-Gm-Message-State: AOAM530mKJ3DPKnb8/IVOTQ94hWCj5dxcbgqSYX3b1kgWnBnJ8F4cNZv
        5cFvUX26dAd7rIBEY8EpxHBrSa1Q6mv6gU8M54g=
X-Google-Smtp-Source: ABdhPJyJkP9sOZceoeygEEhkntTPvWoUoNp+35NvIRbnpdHNriy0P5AUv9qSP+I1AmAEuipc/TWG0Hh2cxzHoQovoaw=
X-Received: by 2002:a05:6e02:1c01:b0:2d1:262e:8d5f with SMTP id
 l1-20020a056e021c0100b002d1262e8d5fmr2851482ilh.98.1652743710378; Mon, 16 May
 2022 16:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220512074321.2090073-1-davemarchevsky@fb.com> <20220512074321.2090073-6-davemarchevsky@fb.com>
In-Reply-To: <20220512074321.2090073-6-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 16:28:19 -0700
Message-ID: <CAEf4Bzag3ESyhhnF=es5TFx41wpTCrqoA4J1pahiBCVan6ii5w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 5/5] selftests/bpf: get_reg_val test
 exercising fxsave fetch
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, Kernel Team <kernel-team@fb.com>
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

On Thu, May 12, 2022 at 12:43 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Add a test which calls bpf_get_reg_val with an xmm reg after forcing fpu
> state save. The test program writes to %xmm10, then calls a BPF program
> which forces fpu save and calls bpf_get_reg_val. This guarantees that
> !fpregs_state_valid check will succeed, forcing bpf_get_reg_val to fetch
> %xmm10's value from task's fpu state.
>
> A bpf_testmod_save_fpregs kfunc helper is added to bpf_testmod to enable
> 'force fpu save'. Existing bpf_dummy_ops test infra is extended to
> support calling the kfunc.
>
> unload_bpf_testmod would often fail with -EAGAIN when running the test
> added in this patch, so a single retry w/ 20ms sleep is added.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf.h                           |  1 +
>  kernel/trace/bpf_trace.c                      |  2 +-
>  net/bpf/bpf_dummy_struct_ops.c                | 13 ++++++

split kernel changes from selftests?

>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 13 ++++++
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 42 +++++++++++++++++++
>  .../selftests/bpf/progs/test_urandom_usdt.c   | 24 +++++++++++
>  tools/testing/selftests/bpf/test_progs.c      |  7 ++++
>  7 files changed, 101 insertions(+), 1 deletion(-)
>

[...]

> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index e585e1cefc77..b2b35138b097 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2020 Facebook */
> +#include <asm/fpu/api.h>
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/error-injection.h>
> @@ -25,6 +26,13 @@ bpf_testmod_test_mod_kfunc(int i)
>         *(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) = i;
>  }
>
> +noinline void
> +bpf_testmod_save_fpregs(void)
> +{
> +       kernel_fpu_begin();
> +       kernel_fpu_end();

this seems to be x86-specific kernel functions, we need to think about
building selftests (including bpf_testmod) on other architectures


> +}
> +
>  struct bpf_testmod_btf_type_tag_1 {
>         int a;
>  };
> @@ -150,6 +158,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
>
>  BTF_SET_START(bpf_testmod_check_kfunc_ids)
>  BTF_ID(func, bpf_testmod_test_mod_kfunc)
> +BTF_ID(func, bpf_testmod_save_fpregs)
>  BTF_SET_END(bpf_testmod_check_kfunc_ids)
>
>  static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
> @@ -166,6 +175,10 @@ static int bpf_testmod_init(void)
>         ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
>         if (ret < 0)
>                 return ret;
> +       ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
> +       if (ret < 0)
> +               return ret;
> +
>         if (bpf_fentry_test1(0) < 0)
>                 return -EINVAL;
>         return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index f98749ac74a7..3866cb004b22 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -8,6 +8,11 @@
>  #include "test_usdt.skel.h"
>  #include "test_urandom_usdt.skel.h"
>
> +/* Need to keep consistent with definition in include/linux/bpf.h */
> +struct bpf_dummy_ops_state {
> +       int val;
> +};
> +
>  int lets_test_this(int);
>
>  static volatile int idx = 2;
> @@ -415,6 +420,41 @@ static void subtest_urandom_usdt(bool auto_attach)
>         test_urandom_usdt__destroy(skel);
>  }
>
> +static void subtest_reg_val_fpustate(void)
> +{
> +       struct bpf_dummy_ops_state in_state;
> +       struct test_urandom_usdt__bss *bss;
> +       struct test_urandom_usdt *skel;
> +       u64 in_args[1];
> +       u64 regval[2];
> +       int err, fd;
> +
> +       in_state.val = 0; /* unused */
> +       in_args[0] = (unsigned long)&in_state;
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, attr,

nit: LIBBPF_OPTS declares variable, so it had to be in variable
declaration block

> +                  .ctx_in = in_args,
> +                  .ctx_size_in = sizeof(in_args),
> +       );
> +
> +       skel = test_urandom_usdt__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +       bss = skel->bss;
> +
> +       fd = bpf_program__fd(skel->progs.save_fpregs_and_read);
> +       regval[0] = 42;
> +       regval[1] = 0;
> +       asm("movdqa %0, %%xmm10" : "=m"(*(char *)regval));
> +
> +       err = bpf_prog_test_run_opts(fd, &attr);
> +       ASSERT_OK(err, "save_fpregs_and_read");
> +       ASSERT_EQ(bss->fpregs_dummy_opts_xmm_val, 42, "fpregs_dummy_opts_xmm_val");
> +
> +       close(fd);
> +       test_urandom_usdt__destroy(skel);
> +}
> +

[...]
