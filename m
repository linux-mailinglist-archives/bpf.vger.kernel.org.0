Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842FD529551
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 01:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348639AbiEPXcK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 19:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350327AbiEPXcI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 19:32:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474EF34B84
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:32:07 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o190so17654976iof.10
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46LWP1WXBTP8NjntW13l6A0dEgpzkkBpzZzq7Vuie9I=;
        b=pZJa+nPaDxYb3lFHnvqIgoYpE9N54o0a8ZYB/u7LJC1EqWdvJFKDvpeB8Ub8Na/8N9
         6dQ+VOJgeCeERpyMd5+dR2Lwck7PQvp3YCho2F9KOrz8rBl5Ij6XQjKz5QfMH9kj+BcH
         iUiCTbADF1ONU9xp4MRKbgyBm7BvCMKHZXrPp1xCInWxXoomgva0c/f+ePC1XZTJjS8s
         TqqKC4QUIfuVTmjdGcy/6YXOK2uMwDc5L9IxbOfdyH51o6Ufo/jjdcxu+oV4RHsjkGrD
         lx1pavcP95e9o+kjewqgz7sTMnWMKsihYh6EcC94rRc1lj3SDEMsStyvi093IpoNqdO2
         GHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46LWP1WXBTP8NjntW13l6A0dEgpzkkBpzZzq7Vuie9I=;
        b=qc9f6TzD54blSmr3270aiUa6uDExIe+9X0LHGEU6GAGKwvjqZLRWbJ9b3Q4o0EkYPe
         V1Tcjh/8J5dUQkX8l9rDC9CWe0B/bqLZ9QwfFzGJdqhyZ/HSFjmI5RqzNR4v8lzJeeII
         7mY7Sf0YqzNl5cfJOguXLdvdEjoEXcpB4VX2AcPt/3RFJf8ZVsgAXMfS3hZY8oz5Rw0Y
         c5TRsTVkZh6Qua+D/dkh7dXKrw0Z6O6CJy1LklO54kZo7pwzQWOFhGU3tGdVY8BNcvS9
         pndn2oN4iZZExDl3xHV/o9amY54FBVTvySqy6c1lDhAp9MyAFu4dz7rORhIvaiDeV3pZ
         sYRw==
X-Gm-Message-State: AOAM533gdDKqfemSwEWjslPxcWM5chJi9i3MVMEuu2IaXMGS7y9k1wFZ
        yf9SmRlwey9Li1auqKxm1kxZp5kVzwc9n83yoNxIW0StGkc=
X-Google-Smtp-Source: ABdhPJxs8QJMug9dIR4cmrCgOIWLFU9HIiiXTpk3aFNliSi48e9U+8MmZEFlGLjbp7f1VIY/dZbJkQXrO/IXeEw+WYc=
X-Received: by 2002:a5d:9316:0:b0:657:a364:ceb with SMTP id
 l22-20020a5d9316000000b00657a3640cebmr9229754ion.63.1652743926552; Mon, 16
 May 2022 16:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220512074321.2090073-1-davemarchevsky@fb.com> <20220512074321.2090073-5-davemarchevsky@fb.com>
In-Reply-To: <20220512074321.2090073-5-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 16:31:55 -0700
Message-ID: <CAEf4BzYj2i4shfAFW4fUKaEDFQvkMtyirVpq8_5AQAX0pW36yQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 4/5] selftests/bpf: Add test for USDT parse
 of xmm reg
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
> Validate that bpf_get_reg_val helper solves the motivating problem of
> this patch series: USDT args passed through xmm regs. The userspace
> portion of the test forces STAP_PROBE macro to use %xmm0 and %xmm1 regs
> to pass a float and an int, which the bpf-side successfully reads using
> BPF_USDT.
>
> In the wild I discovered a sanely-configured USDT in Fedora libpthread
> using xmm regs to pass scalar values, likely due to register pressure.
> urandom_read_lib_xmm mimics this by using -ffixed-$REG flag to mark
> r11-r14 unusable and passing many USDT args.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  8 ++-
>  tools/testing/selftests/bpf/prog_tests/usdt.c |  7 +++
>  .../selftests/bpf/progs/test_urandom_usdt.c   | 13 ++++
>  tools/testing/selftests/bpf/urandom_read.c    |  3 +
>  .../selftests/bpf/urandom_read_lib_xmm.c      | 62 +++++++++++++++++++
>  5 files changed, 91 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/urandom_read_lib_xmm.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6bbc03161544..19246e34dfe1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -172,10 +172,14 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
>         $(call msg,LIB,,$@)
>         $(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
>
> -$(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
> +$(OUTPUT)/liburandom_read_xmm.so: urandom_read_lib_xmm.c
> +       $(call msg,LIB,,$@)
> +       $(Q)$(CC) -O0 -ffixed-r11 -ffixed-r12 -ffixed-r13 -ffixed-r14 -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@

this looks very x86-specific, but we support other architectures as well

looking at sdt.h, it seems like STAP_PROBEx() macros support being
called from assembly code, I wonder if it would be better to try to
figure out how to use it from assembly and use some xmm register
directly in inline assembly? I have never done that before, but am
hopeful :)

> +
> +$(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so $(OUTPUT)/liburandom_read_xmm.so
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.c,$^)                        \
> -                 liburandom_read.so $(LDLIBS)                                 \
> +                 liburandom_read.so liburandom_read_xmm.so $(LDLIBS)          \
>                   -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
>
>  $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index a71f51bdc08d..f98749ac74a7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -385,6 +385,12 @@ static void subtest_urandom_usdt(bool auto_attach)
>                         goto cleanup;
>                 skel->links.urandlib_read_with_sema = l;
>
> +               l = bpf_program__attach_usdt(skel->progs.urandlib_xmm_reg_read,
> +                                            urand_pid, "./liburandom_read_xmm.so",
> +                                            "urandlib", "xmm_reg_read", NULL);
> +               if (!ASSERT_OK_PTR(l, "urandlib_xmm_reg_read"))
> +                       goto cleanup;
> +               skel->links.urandlib_xmm_reg_read = l;
>         }
>
>         /* trigger urandom_read USDTs */
> @@ -402,6 +408,7 @@ static void subtest_urandom_usdt(bool auto_attach)
>         ASSERT_EQ(bss->urandlib_read_with_sema_call_cnt, 1, "urandlib_w_sema_cnt");
>         ASSERT_EQ(bss->urandlib_read_with_sema_buf_sz_sum, 256, "urandlib_w_sema_sum");
>
> +       ASSERT_EQ(bss->urandlib_xmm_reg_read_buf_sz_sum, 256, "liburandom_read_xmm.so");
>  cleanup:
>         if (urand_pipe)
>                 pclose(urand_pipe);
> diff --git a/tools/testing/selftests/bpf/progs/test_urandom_usdt.c b/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
> index 3539b02bd5f7..575761863eb6 100644
> --- a/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
> +++ b/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
> @@ -67,4 +67,17 @@ int BPF_USDT(urandlib_read_with_sema, int iter_num, int iter_cnt, int buf_sz)
>         return 0;
>  }
>
> +int urandlib_xmm_reg_read_buf_sz_sum;

nit: empty line here

> +SEC("usdt/./liburandom_read_xmm.so:urandlib:xmm_reg_read")
> +int BPF_USDT(urandlib_xmm_reg_read, int *f1, int *f2, int *f3, int a, int b,
> +                                    int c /*should be float */, int d, int e,
> +                                    int f, int g, int h, int buf_sz)
> +{
> +       if (urand_pid != (bpf_get_current_pid_tgid() >> 32))
> +               return 0;
> +
> +       __sync_fetch_and_add(&urandlib_xmm_reg_read_buf_sz_sum, buf_sz);
> +       return 0;
> +}
> +

[...]
