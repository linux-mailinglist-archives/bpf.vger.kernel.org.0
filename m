Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3E84070AA
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhIJRvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhIJRva (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 13:51:30 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E9C061574
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 10:50:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z18so5476121ybg.8
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBNKT1yquxAnFLe4vJSFTfBL9HPlFkqn8OkRzcFgQvc=;
        b=g84IGaAbn7dg2NqOHHNPFVBU7Gk8U2FfZirnUA+nuGPlwVRIQowBdVmlTc2uRS3/5X
         udXtFNKncJ6O9b0KaKjSj9II1+jHibamZ6b4bg6MmlTXy1qi8jMO8y2mGNF7eG9w7fpT
         3xckeH1xCeK2PUMgWSvEskyJkPKZAtCTbercPm2EMZUQtfZb8fmy9ob1QcKOSvwMDVxO
         EJtBM6T6U68mcM140Sh+XWjEwMX1k9a1+NE785ycI36GczIHHgMeIgpbRf/JOaxwpqwK
         OwSjbS/drNQ9BbNANGLOFGlYAz3Wzk+9vvk+IxjPOuWteDJhAkLM8JVVxI1ZvDLu6qv+
         XGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBNKT1yquxAnFLe4vJSFTfBL9HPlFkqn8OkRzcFgQvc=;
        b=4oOKyUVb8DrRD+b5Etg7SM2JrjseTj8ojchyYKyy3+7/kxl7JmePv2GHMvq7sJwfOg
         knPZ/WljZLRfuvjMo2OeM2GkNi7xa+bnLPTkPGbqzYvEI3tlNR4xZPjW+sPYQ8+m/lNU
         tQYClICFqXLujlCzUEZ9LeGaO07PIoEfcTI6e5vcjI/hkGuH35UN5/sptg0G8n9B4mDj
         pN2LIGk4zOhlZ2dWyhjQE+HarkrYg8eKslWlUovCNvlBRPskOzykV8zfEofmzgE4CvAw
         FAzzo0nYpkO1w4v1ARoAXTLoPMEwkgEhduvE0d5GNbK0oudFdPT1NLBluuNzEpPKls6l
         AxOw==
X-Gm-Message-State: AOAM530fp+n/hrPaC8kD3dlGZ/vXLdJV1I9UAoKDQ/VKE34Il9q9Johg
        8PzzKkh9h1dFsOLRB8DMCBsD3kiAnTfl9UUnZX3jvw==
X-Google-Smtp-Source: ABdhPJw+3TMKB0d99mgd+SofkC9D6me6m2ytSdvEvGtHqpjBeDfEvIeGHV7gPZy/HSX4kJHv9qFkVwgJIH2HW0Lbjco=
X-Received: by 2002:a25:c006:: with SMTP id c6mr12389298ybf.480.1631296213392;
 Fri, 10 Sep 2021 10:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210910091900.16119-1-daniel@iogearbox.net>
In-Reply-To: <20210910091900.16119-1-daniel@iogearbox.net>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Fri, 10 Sep 2021 19:50:02 +0200
Message-ID: <CAM1=_QRYT4TYUtFbrRMJnnNQwDBLeBTpHru4cUOKL4qpJaNbNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, selftests: Replicate tailcall limit test
 for indirect call case
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@cilium.io>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 11:19 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> The tailcall_3 test program uses bpf_tail_call_static() where the JIT
> would patch a direct jump. Add a new tailcall_6 test program replicating
> exactly the same test just ensuring that bpf_tail_call() uses a map
> index where the verifier cannot make assumptions this time.
>
> In other words, this will now cover both on x86-64 JIT, meaning, JIT
> images with emit_bpf_tail_call_direct() emission as well as JIT images
> with emit_bpf_tail_call_indirect() emission.
>
>   # echo 1 > /proc/sys/net/core/bpf_jit_enable
>   # ./test_progs -t tailcalls
>   #136/1 tailcalls/tailcall_1:OK
>   #136/2 tailcalls/tailcall_2:OK
>   #136/3 tailcalls/tailcall_3:OK
>   #136/4 tailcalls/tailcall_4:OK
>   #136/5 tailcalls/tailcall_5:OK
>   #136/6 tailcalls/tailcall_6:OK
>   #136/7 tailcalls/tailcall_bpf2bpf_1:OK
>   #136/8 tailcalls/tailcall_bpf2bpf_2:OK
>   #136/9 tailcalls/tailcall_bpf2bpf_3:OK
>   #136/10 tailcalls/tailcall_bpf2bpf_4:OK
>   #136/11 tailcalls/tailcall_bpf2bpf_5:OK
>   #136 tailcalls:OK
>   Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED
>
>   # echo 0 > /proc/sys/net/core/bpf_jit_enable
>   # ./test_progs -t tailcalls
>   #136/1 tailcalls/tailcall_1:OK
>   #136/2 tailcalls/tailcall_2:OK
>   #136/3 tailcalls/tailcall_3:OK
>   #136/4 tailcalls/tailcall_4:OK
>   #136/5 tailcalls/tailcall_5:OK
>   #136/6 tailcalls/tailcall_6:OK
>   [...]
>
> For interpreter, the tailcall_1-6 tests are passing as well. The later
> tailcall_bpf2bpf_* are failing due lack of bpf2bpf + tailcall support
> in interpreter, so this is expected.
>
> Also, manual inspection shows that both loaded programs from tailcall_3
> and tailcall_6 test case emit the expected opcodes:
>
> * tailcall_3 disasm, emit_bpf_tail_call_direct():
>
>   [...]
>    b:   push   %rax
>    c:   push   %rbx
>    d:   push   %r13
>    f:   mov    %rdi,%rbx
>   12:   movabs $0xffff8d3f5afb0200,%r13
>   1c:   mov    %rbx,%rdi
>   1f:   mov    %r13,%rsi
>   22:   xor    %edx,%edx                 _
>   24:   mov    -0x4(%rbp),%eax          |  limit check
>   2a:   cmp    $0x20,%eax               |
>   2d:   ja     0x0000000000000046       |
>   2f:   add    $0x1,%eax                |
>   32:   mov    %eax,-0x4(%rbp)          |_
>   38:   nopl   0x0(%rax,%rax,1)
>   3d:   pop    %r13
>   3f:   pop    %rbx
>   40:   pop    %rax
>   41:   jmpq   0xffffffffffffe377
>   [...]
>
> * tailcall_6 disasm, emit_bpf_tail_call_indirect():
>
>   [...]
>   47:   movabs $0xffff8d3f59143a00,%rsi
>   51:   mov    %edx,%edx
>   53:   cmp    %edx,0x24(%rsi)
>   56:   jbe    0x0000000000000093        _
>   58:   mov    -0x4(%rbp),%eax          |  limit check
>   5e:   cmp    $0x20,%eax               |
>   61:   ja     0x0000000000000093       |
>   63:   add    $0x1,%eax                |
>   66:   mov    %eax,-0x4(%rbp)          |_
>   6c:   mov    0x110(%rsi,%rdx,8),%rcx
>   74:   test   %rcx,%rcx
>   77:   je     0x0000000000000093
>   79:   pop    %rax
>   7a:   mov    0x30(%rcx),%rcx
>   7e:   add    $0xb,%rcx
>   82:   callq  0x000000000000008e
>   87:   pause
>   89:   lfence
>   8c:   jmp    0x0000000000000087
>   8e:   mov    %rcx,(%rsp)
>   92:   retq
>   [...]
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Cc: Paul Chaignon <paul@cilium.io>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Link: https://lore.kernel.org/bpf/CAM1=_QRyRVCODcXo_Y6qOm1iT163HoiSj8U2pZ8Rj3hzMTT=HQ@mail.gmail.com
> ---
>  [ Cooked up proper patch for it after manual inspection as I think
>    it's useful in any case to have the coverage for both JIT code
>    generation cases. ]
>
>  .../selftests/bpf/prog_tests/tailcalls.c      | 25 +++++++++++---
>  tools/testing/selftests/bpf/progs/tailcall6.c | 34 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall6.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index b5940e6ca67c..7bf3a7a97d7b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -219,10 +219,7 @@ static void test_tailcall_2(void)
>         bpf_object__close(obj);
>  }
>
> -/* test_tailcall_3 checks that the count value of the tail call limit
> - * enforcement matches with expectations.
> - */
> -static void test_tailcall_3(void)
> +static void test_tailcall_count(const char *which)
>  {
>         int err, map_fd, prog_fd, main_fd, data_fd, i, val;
>         struct bpf_map *prog_array, *data_map;
> @@ -231,7 +228,7 @@ static void test_tailcall_3(void)
>         __u32 retval, duration;
>         char buff[128] = {};
>
> -       err = bpf_prog_load("tailcall3.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
> +       err = bpf_prog_load(which, BPF_PROG_TYPE_SCHED_CLS, &obj,
>                             &prog_fd);
>         if (CHECK_FAIL(err))
>                 return;
> @@ -296,6 +293,22 @@ static void test_tailcall_3(void)
>         bpf_object__close(obj);
>  }
>
> +/* test_tailcall_3 checks that the count value of the tail call limit
> + * enforcement matches with expectations. JIT uses direct jump.
> + */
> +static void test_tailcall_3(void)
> +{
> +       test_tailcall_count("tailcall3.o");
> +}
> +
> +/* test_tailcall_6 checks that the count value of the tail call limit
> + * enforcement matches with expectations. JIT uses indirect jump.
> + */
> +static void test_tailcall_6(void)
> +{
> +       test_tailcall_count("tailcall6.o");
> +}
> +
>  /* test_tailcall_4 checks that the kernel properly selects indirect jump
>   * for the case where the key is not known. Latter is passed via global
>   * data to select different targets we can compare return value of.
> @@ -822,6 +835,8 @@ void test_tailcalls(void)
>                 test_tailcall_4();
>         if (test__start_subtest("tailcall_5"))
>                 test_tailcall_5();
> +       if (test__start_subtest("tailcall_6"))
> +               test_tailcall_6();
>         if (test__start_subtest("tailcall_bpf2bpf_1"))
>                 test_tailcall_bpf2bpf_1();
>         if (test__start_subtest("tailcall_bpf2bpf_2"))
> diff --git a/tools/testing/selftests/bpf/progs/tailcall6.c b/tools/testing/selftests/bpf/progs/tailcall6.c
> new file mode 100644
> index 000000000000..0f4a811cc028
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall6.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +       __uint(max_entries, 1);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(__u32));
> +} jmp_table SEC(".maps");
> +
> +int count, which;
> +
> +SEC("classifier/0")
> +int bpf_func_0(struct __sk_buff *skb)
> +{
> +       count++;
> +       if (__builtin_constant_p(which))
> +               __bpf_unreachable();
> +       bpf_tail_call(skb, &jmp_table, which);
> +       return 1;
> +}
> +
> +SEC("classifier")
> +int entry(struct __sk_buff *skb)
> +{
> +       if (__builtin_constant_p(which))
> +               __bpf_unreachable();
> +       bpf_tail_call(skb, &jmp_table, which);
> +       return 0;
> +}
> +
> +char __license[] SEC("license") = "GPL";
> --
> 2.27.0
>

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
