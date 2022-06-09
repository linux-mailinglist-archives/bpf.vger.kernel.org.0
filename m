Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15775455BC
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiFIUfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiFIUfD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 16:35:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E9720F6F
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 13:35:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s13so27450403ljd.4
        for <bpf@vger.kernel.org>; Thu, 09 Jun 2022 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gM6EdEJv2ehBisgqSAHjQr46BdQDLkLt/URs2O3TGYA=;
        b=MESQc1jLo21VEUYuNrzpWhNzOGKwprgdt39kTO7+Pk4AwR/uBG8psVWZZ4Ucj6fs34
         eC1KjHbKn0/EtTW33It/9HUCIRA5ntadq+z/Bqq0AVegwMBkqo3CFqXsIcr+HgekJAed
         rwx9G1J8U7lXg1vrOirioyAA2m8HDew8ISPny8OiiAVdzkOBklXSnCawg+LxGNG8ykwI
         VgxCUHPWW7Xpll0+3Ug6qImUTUCPwM0gs71wA5eFJ5xLO3piz8OC3If7VUaFwaa14W0q
         P9f8NcK9B3XMs1B8uh2EAPPX9KQoMB49REUIQhEZZRtBG+RywPWeCDOnjw4qyjTGc9vA
         EkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gM6EdEJv2ehBisgqSAHjQr46BdQDLkLt/URs2O3TGYA=;
        b=mBvrKT3rpeKR9KBIqOPTGrsZoNLk5mm6SdXsDP0ZDy7dEBiZXEXzKXjD3waFJeE+Zl
         2Aa+mqH/oh826JPbpWJcVU48bNCBCC5caBQDA4oum3Qxa5NL4+UCmx5y4Qf8vgsWC4Ji
         MlOBKjDl++Ty7OazMvRwkJOsydiel0HWSvocAegCcEuNCLTeTpOGDkEojnnhqdcpieje
         5Guda2l3Jspvd86vgNXlTEzIH9N56Tjm07opIdv5C7+xrsr+1KRhjf+w2UW76qLLbwrQ
         28H3QtwMuVFNFejDf7vc8UPFfM5WG7FVqStuTpODtvAWe3WOp9UVKZ4GRmHIgyJv/q4C
         cA5Q==
X-Gm-Message-State: AOAM532FbJ8YVqL6l/kzoPkQXiOz9ShLFsJiJvGaYI2CKDafh3F07H2s
        WNq1xYMtEfGpczKpoLnfrQQdyTEe4kjQnfbPlC8=
X-Google-Smtp-Source: ABdhPJyrSyUnL6UxV8fWqLTHbbyNYJ22zsnoFdCAX4SZXq8saxfdzJ9Lqv+kDzn5NYKThchzA0V9w0djgLoKBX6Mw28=
X-Received: by 2002:a2e:bd13:0:b0:246:1ff8:6da1 with SMTP id
 n19-20020a2ebd13000000b002461ff86da1mr59872894ljq.219.1654806899852; Thu, 09
 Jun 2022 13:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220524055748.4064533-1-andrii@kernel.org>
In-Reply-To: <20220524055748.4064533-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Jun 2022 13:34:47 -0700
Message-ID: <CAEf4BzbLA=Gkvv3rQw4_jsRb0yMcJ-e=mVMtHmnQGZ7OTffnSA@mail.gmail.com>
Subject: Re: [PATCH] BUG: demonstration of uprobe/uretprobe corrupted stack traces
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, rihams@fb.com,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>
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

On Mon, May 23, 2022 at 10:58 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Hi Masami,
>
> We've got reports about partially corrupt stack traces when being captured from
> uretprobes. Trying the simplest repro seems to confirm that something is not
> quite right here. I'll try to debug it a bit more this week, but I was hoping
> for you to take a look as well, if you get a chance.
>

A friendly ping! See below, at this point I'm mostly concerned about #2.


> Simple repro built on top of BPF selftests.
>
>   $ sudo ./test_progs -a uprobe_autoattach -v
>   ...
>   FN ADDR 0x55fde0 - 0x55fdef
>   UPROBE SZ 40 (CNT 5)       URETPROBE SZ 40 (CNT 5)
>   UPROBE 0x55fde0           URETPROBE 0x55ffd4
>   UPROBE 0x584653           URETPROBE 0x584653
>   UPROBE 0x585cc9           URETPROBE 0x585cc9
>   UPROBE 0x7fa9a31eaca3     URETPROBE 0x7fa9a31eaca3
>   UPROBE 0x5541f689495641d7 URETPROBE 0x5541f689495641d7
>   ...
>   #203     uprobe_autoattach:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> There seem to be two distinct problems.
>
> 1. Last two entries for both uprobe and uretprobe stacks are not user-space
> addressed (0x7fa9a31eaca3) and the very last one doesn't even look like a valid
> address (0x5541f689495641d7).

We can probably ignore this one, because I suspect it's due to my
system-wide libc was built without frame-pointers. So once we got into
some API inside libc stack traces got corrupted. But the one below
about not getting an address of a probed function for uretprobe still
stands. Can you please take a look? Thank you!

>
> 2. Looking at first entry for UPROBE vs URETPROBE, you can see that uprobe
> one's is correct and points exactly to the beginning of autoattach_trigger_func
> (0x55fde0) as expected, but uretprobe entry (0x55ffd4) is way out of
> autoattach_trigger_func (which is just 15 bytes long and ends at 0x55fdef).
> Using addr2line it shows that it points to:
>
>   0x000000000055ffd4: test_uprobe_autoattach at /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c:33
>
> Which is a valid function and location to which autoattach_trigger_func()
> should return (see objdump snippet below), but from uretprobe I'd imagine that
> we are going to get address within traced user function (that is 0x55fde0 -
> 0x55fdef range), not the return address in a parent function.
>
>      55ffc4:       89 83 3c 08 00 00       mov    %eax,0x83c(%rbx)
>      55ffca:       8b 45 e8                mov    -0x18(%rbp),%eax
>      55ffcd:       89 c7                   mov    %eax,%edi
>      55ffcf:       e8 0c fe ff ff          call   55fde0 <autoattach_trigger_func>
> -->  55ffd4:       89 45 a8                mov    %eax,-0x58(%rbp)
>      55ffd7:       ba ef fd 55 00          mov    $0x55fdef,%edx
>
> Both issues above seem unexpected, can you please see if I have some wrong
> assumptions here?
>
> Thanks in advance for taking a look!
>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Riham Selim <rihams@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile               |  3 ++-
>  .../selftests/bpf/prog_tests/uprobe_autoattach.c   | 14 ++++++++++++++
>  .../selftests/bpf/progs/test_uprobe_autoattach.c   | 11 +++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 2d3c8c8f558a..0d3109c8d8d5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -23,7 +23,8 @@ BPF_GCC               ?= $(shell command -v bpf-gcc;)
>  SAN_CFLAGS     ?=
>  CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)     \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> +         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT) -fno-omit-frame-pointer
> +
>  LDFLAGS += $(SAN_CFLAGS)
>  LDLIBS += -lelf -lz -lrt -lpthread
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> index 35b87c7ba5be..c0fbe4d240be 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> @@ -10,6 +10,7 @@ static noinline int autoattach_trigger_func(int arg)
>         asm volatile ("");
>         return arg + 1;
>  }
> +static noinline int autoattach_trigger_func_post(int arg) { return 0; }
>
>  void test_uprobe_autoattach(void)
>  {
> @@ -17,6 +18,7 @@ void test_uprobe_autoattach(void)
>         int trigger_val = 100, trigger_ret;
>         size_t malloc_sz = 1;
>         char *mem;
> +       int i;
>
>         skel = test_uprobe_autoattach__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "skel_open"))
> @@ -30,6 +32,18 @@ void test_uprobe_autoattach(void)
>         /* trigger & validate uprobe & uretprobe */
>         trigger_ret = autoattach_trigger_func(trigger_val);
>
> +       printf("FN ADDR %p - %p\n", autoattach_trigger_func, autoattach_trigger_func_post);
> +       printf("UPROBE SZ %d (CNT %d)      URETPROBE SZ %d (CNT %d)\n",
> +               skel->bss->uprobe_stack_sz,
> +               skel->bss->uprobe_stack_sz / 8,
> +               skel->bss->uretprobe_stack_sz,
> +               skel->bss->uretprobe_stack_sz / 8);
> +       for (i = 0; i < skel->bss->uprobe_stack_sz / 8; i++) {
> +               printf("UPROBE %-18p URETPROBE %-18p\n",
> +                       (void *)skel->bss->uprobe_stack[i],
> +                       (void *)skel->bss->uretprobe_stack[i]);
> +       }
> +
>         skel->bss->test_pid = getpid();
>
>         /* trigger & validate shared library u[ret]probes attached by name */
> diff --git a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> index ab75522e2eeb..f630f83b4426 100644
> --- a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> +++ b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> @@ -27,11 +27,19 @@ int handle_uprobe_noautoattach(struct pt_regs *ctx)
>         return 0;
>  }
>
> +__u64 uprobe_stack[128];
> +__u64 uretprobe_stack[128];
> +int uprobe_stack_sz, uretprobe_stack_sz;
> +
>  SEC("uprobe//proc/self/exe:autoattach_trigger_func")
>  int handle_uprobe_byname(struct pt_regs *ctx)
>  {
>         uprobe_byname_parm1 = PT_REGS_PARM1_CORE(ctx);
>         uprobe_byname_ran = 1;
> +
> +       uprobe_stack_sz = bpf_get_stack(ctx,
> +                                       uprobe_stack, sizeof(uprobe_stack),
> +                                       BPF_F_USER_STACK);
>         return 0;
>  }
>
> @@ -40,6 +48,9 @@ int handle_uretprobe_byname(struct pt_regs *ctx)
>  {
>         uretprobe_byname_rc = PT_REGS_RC_CORE(ctx);
>         uretprobe_byname_ran = 2;
> +       uretprobe_stack_sz = bpf_get_stack(ctx,
> +                                          uretprobe_stack, sizeof(uretprobe_stack),
> +                                          BPF_F_USER_STACK);
>         return 0;
>  }
>
> --
> 2.30.2
>
