Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D6E68FC5D
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 02:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjBIBFY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 20:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjBIBFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 20:05:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA5012F0B
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 17:05:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id da9so701079edb.12
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 17:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qud9usRdJwrWKec2zU4rCYoylXwjhgNFCnniJZMJig=;
        b=i9MeLGRoKVt3YcMuyxFNloXLZeUfA5SoD+HZN9CNN5Jzc5Nj9oX8OQdAmNmAwCj9QL
         h1AtPGSu+zoQnQGG0vW5SP7J4+lUlM5BcwNLsOsUIh9n07cRKnS4vhtIdsmyQhQ2MC9d
         UmnQ9p9VxuZgNPF+68Bjapwk4ME3/WrT6qZLjKGByscBnohzYO/IILYrVLWNbeMTCpEp
         KCYPRepOLIfHKEtHPhbEayniJsoMbZpDbAwxAz6kvfjQh9tzLvV2lHr0HkBjT787IhfP
         4b4nJjvZFgDfcgmLOZpBJqFi0KkjqTFdi5XNvejHxXqOaViNXMwR15SxmPdCqSMVK3iK
         Q1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qud9usRdJwrWKec2zU4rCYoylXwjhgNFCnniJZMJig=;
        b=XpZupzs9Zh5V2OvKVYQaM/21iuzPiNCK/hyZacPISdwkxIEO/38zc8Uc570TQsgcno
         fouFGPqhhqlP8n7EpFShMuXumkA27sCnPsbpe59Pne5/43NLrp8/m1YRS9ArP197D8NB
         XG538n/wY49INKflNMudXupxBY6nP9RHkq3D5rCowqVQV7cus5EzMdlRchXWsggrIU01
         N8nQu8s53WVRKDMKzDJBgnLii6HaG96W8ZY4ljoMtRkOCYtyZMUaNy82pG5ZaqjxxBa0
         poM35zuD2m6lc2yDpN2xqWU9wpp5ly5RE5pWI2FwKRF/NpADkx/uOGlGkBQOMTPyDL4m
         14dg==
X-Gm-Message-State: AO0yUKWsL/6Wy0UOYL1lZ6kdm3tdMZVoaDcp4ox2FkpS4nTM2U429zCO
        0+GkY8agfjVdONaopfYWs9t+T15eza+8w9zvAvA=
X-Google-Smtp-Source: AK7set/lEs4KWsyEcD8qsiEpbkcyytXMmumtwIaW3DDzwECq8uuZs2d01CJIyfCcjjTinG/kiK9hRoDb7bC3r4auynU=
X-Received: by 2002:a50:f603:0:b0:49d:ec5e:1e98 with SMTP id
 c3-20020a50f603000000b0049dec5e1e98mr1740567edn.5.1675904721191; Wed, 08 Feb
 2023 17:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-6-iii@linux.ibm.com>
In-Reply-To: <20230208205642.270567-6-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 17:05:09 -0800
Message-ID: <CAEf4Bzb6-JOL7SQGoiNK-Mfed-qh5pnbirEULu4Miw8-tZh9CA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/9] selftests/bpf: Attach to fopen()/fclose() in uprobe_autoattach
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> malloc() and free() may be completely replaced by sanitizers, use
> fopen() and fclose() instead.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  .../selftests/bpf/prog_tests/uprobe_autoattach.c     | 12 ++++++------
>  .../selftests/bpf/progs/test_uprobe_autoattach.c     | 10 +++++-----
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> index 82807def0d24..b862948f95a8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> @@ -16,10 +16,10 @@ static noinline int autoattach_trigger_func(int arg1, int arg2, int arg3,
>
>  void test_uprobe_autoattach(void)
>  {
> +       const char *devnull_str = "/dev/null";
>         struct test_uprobe_autoattach *skel;
>         int trigger_ret;
> -       size_t malloc_sz = 1;
> -       char *mem;
> +       FILE *devnull;
>
>         skel = test_uprobe_autoattach__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "skel_open"))
> @@ -36,16 +36,16 @@ void test_uprobe_autoattach(void)
>         skel->bss->test_pid = getpid();
>
>         /* trigger & validate shared library u[ret]probes attached by name */
> -       mem = malloc(malloc_sz);
> +       devnull = fopen(devnull_str, "r");
>
>         ASSERT_EQ(skel->bss->uprobe_byname_parm1, 1, "check_uprobe_byname_parm1");
>         ASSERT_EQ(skel->bss->uprobe_byname_ran, 1, "check_uprobe_byname_ran");
>         ASSERT_EQ(skel->bss->uretprobe_byname_rc, trigger_ret, "check_uretprobe_byname_rc");
>         ASSERT_EQ(skel->bss->uretprobe_byname_ret, trigger_ret, "check_uretprobe_byname_ret");
>         ASSERT_EQ(skel->bss->uretprobe_byname_ran, 2, "check_uretprobe_byname_ran");
> -       ASSERT_EQ(skel->bss->uprobe_byname2_parm1, malloc_sz, "check_uprobe_byname2_parm1");
> +       ASSERT_EQ(skel->bss->uprobe_byname2_parm1, devnull_str, "check_uprobe_byname2_parm1");
>         ASSERT_EQ(skel->bss->uprobe_byname2_ran, 3, "check_uprobe_byname2_ran");
> -       ASSERT_EQ(skel->bss->uretprobe_byname2_rc, mem, "check_uretprobe_byname2_rc");
> +       ASSERT_EQ(skel->bss->uretprobe_byname2_rc, (void *)devnull, "check_uretprobe_byname2_rc");
>         ASSERT_EQ(skel->bss->uretprobe_byname2_ran, 4, "check_uretprobe_byname2_ran");
>
>         ASSERT_EQ(skel->bss->a[0], 1, "arg1");
> @@ -67,7 +67,7 @@ void test_uprobe_autoattach(void)
>         ASSERT_EQ(skel->bss->a[7], 8, "arg8");
>  #endif
>
> -       free(mem);
> +       fclose(devnull);
>  cleanup:
>         test_uprobe_autoattach__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> index 774ddeb45898..72f5e7a82c58 100644
> --- a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> +++ b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> @@ -13,9 +13,9 @@ int uprobe_byname_ran = 0;
>  int uretprobe_byname_rc = 0;
>  int uretprobe_byname_ret = 0;
>  int uretprobe_byname_ran = 0;
> -size_t uprobe_byname2_parm1 = 0;
> +void *uprobe_byname2_parm1 = NULL;
>  int uprobe_byname2_ran = 0;
> -char *uretprobe_byname2_rc = NULL;
> +void *uretprobe_byname2_rc = NULL;


ugh... shall we use u64 and avoid problems with 32-bit host vs 64-bit
BPF mismatch? Maybe it will never bite us, but why risking?

>  int uretprobe_byname2_ran = 0;
>
>  int test_pid;
> @@ -88,7 +88,7 @@ int BPF_URETPROBE(handle_uretprobe_byname, int ret)
>  }
>
>
> -SEC("uprobe/libc.so.6:malloc")
> +SEC("uprobe/libc.so.6:fopen")
>  int handle_uprobe_byname2(struct pt_regs *ctx)
>  {
>         int pid = bpf_get_current_pid_tgid() >> 32;
> @@ -96,12 +96,12 @@ int handle_uprobe_byname2(struct pt_regs *ctx)
>         /* ignore irrelevant invocations */
>         if (test_pid != pid)
>                 return 0;
> -       uprobe_byname2_parm1 = PT_REGS_PARM1_CORE(ctx);
> +       uprobe_byname2_parm1 = (void *)(long)PT_REGS_PARM1_CORE(ctx);
>         uprobe_byname2_ran = 3;
>         return 0;
>  }
>
> -SEC("uretprobe/libc.so.6:malloc")
> +SEC("uretprobe/libc.so.6:fopen")
>  int handle_uretprobe_byname2(struct pt_regs *ctx)
>  {
>         int pid = bpf_get_current_pid_tgid() >> 32;
> --
> 2.39.1
>
