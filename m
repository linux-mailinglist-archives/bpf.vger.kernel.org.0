Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8321C547A75
	for <lists+bpf@lfdr.de>; Sun, 12 Jun 2022 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiFLOL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Jun 2022 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiFLOL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Jun 2022 10:11:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D8A17598
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 07:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EF2CB80C6E
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 14:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E85C34115;
        Sun, 12 Jun 2022 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655043112;
        bh=Pr20QeGN9tNpXpXdPNczSKLz7V4qDUD3z0yhRhHWHn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Osn09YEqH6tYyfkGxebvWtc8W2+dl+lYpYUCO83EHZYZ2jxnH+uHaYina5iPC8siB
         GAAcFl5K+yfM1tAuT8oWimHRSCzOZpYNWE41USKvxx54pxKyWkSL1Z1Ls8ms0ssMng
         ZOJTPv4OUl94mmhiDn0lTDC6JkCOxEJ2OXn+6Hcp8YFvlpAHJcB/6ZM0BJCc0TZzXn
         vgwVP9ulp0XUjYRcezeo1k389LZ7ocjChmrOmf5Ea7oo/LYMVU6PIKM5hewxiV4gaj
         xsD2uuPE1e3aBlNR9PQS1J6mGV1d3/zu5+hL83wmv3ZaPH3D/J7UFJAryEwGn0iweV
         stCb+EJnSODDw==
Date:   Sun, 12 Jun 2022 23:11:47 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     <bpf@vger.kernel.org>, <ast@kernel.org>, <rihams@fb.com>,
        <jolsa@kernel.org>, oleg@redhat.com
Subject: Re: [PATCH] BUG: demonstration of uprobe/uretprobe corrupted stack
 traces
Message-Id: <20220612231147.b3210be6da6f81ce7272f12c@kernel.org>
In-Reply-To: <20220524055748.4064533-1-andrii@kernel.org>
References: <20220524055748.4064533-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

Sorry for waiting. 

On Mon, 23 May 2022 22:57:48 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Hi Masami,
> 
> We've got reports about partially corrupt stack traces when being captured from
> uretprobes. Trying the simplest repro seems to confirm that something is not
> quite right here. I'll try to debug it a bit more this week, but I was hoping
> for you to take a look as well, if you get a chance.

Ah, uprobes/uretprobes will be handled by Oleg. But I'll try to explain it
as far as I know. Oleg, please correct me if I'm wrong.

> 
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

Hmm, what user-space stack unwinder are you using? I guess it comes
from the user-space stack unwinder routine.

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

No, it is expected behavior. Since the "return probe" probes the function
returning, the first entry of the stack address is the address where the
function is returned (IOW, the IP address when the probe hit). Not the
address of the return instruction. As long as it uses the stack to hook
the return of the function, it's impossible in principle.
(if it decodes the function to find the return instruction and replace it
with a software breakpoint, it may be possible. But this will not work
if the function does tail call etc.)

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

So, #1 maybe we need to look into the stack unwinder (bpf_get_stack()?)
 Does this happen if you unwind user-stack from kprobe event?
 Oleg, would you know anything about this issue?

And #2 is the expected behavior.

Thank you,

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
> @@ -23,7 +23,8 @@ BPF_GCC		?= $(shell command -v bpf-gcc;)
>  SAN_CFLAGS	?=
>  CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
>  	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
> -	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> +	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT) -fno-omit-frame-pointer
> +
>  LDFLAGS += $(SAN_CFLAGS)
>  LDLIBS += -lelf -lz -lrt -lpthread
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> index 35b87c7ba5be..c0fbe4d240be 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> @@ -10,6 +10,7 @@ static noinline int autoattach_trigger_func(int arg)
>  	asm volatile ("");
>  	return arg + 1;
>  }
> +static noinline int autoattach_trigger_func_post(int arg) { return 0; }
>  
>  void test_uprobe_autoattach(void)
>  {
> @@ -17,6 +18,7 @@ void test_uprobe_autoattach(void)
>  	int trigger_val = 100, trigger_ret;
>  	size_t malloc_sz = 1;
>  	char *mem;
> +	int i;
>  
>  	skel = test_uprobe_autoattach__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "skel_open"))
> @@ -30,6 +32,18 @@ void test_uprobe_autoattach(void)
>  	/* trigger & validate uprobe & uretprobe */
>  	trigger_ret = autoattach_trigger_func(trigger_val);
>  
> +	printf("FN ADDR %p - %p\n", autoattach_trigger_func, autoattach_trigger_func_post);
> +	printf("UPROBE SZ %d (CNT %d)      URETPROBE SZ %d (CNT %d)\n",
> +		skel->bss->uprobe_stack_sz,
> +		skel->bss->uprobe_stack_sz / 8,
> +		skel->bss->uretprobe_stack_sz,
> +		skel->bss->uretprobe_stack_sz / 8);
> +	for (i = 0; i < skel->bss->uprobe_stack_sz / 8; i++) {
> +		printf("UPROBE %-18p URETPROBE %-18p\n",
> +			(void *)skel->bss->uprobe_stack[i],
> +			(void *)skel->bss->uretprobe_stack[i]);
> +	}
> +
>  	skel->bss->test_pid = getpid();
>  
>  	/* trigger & validate shared library u[ret]probes attached by name */
> diff --git a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> index ab75522e2eeb..f630f83b4426 100644
> --- a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> +++ b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
> @@ -27,11 +27,19 @@ int handle_uprobe_noautoattach(struct pt_regs *ctx)
>  	return 0;
>  }
>  
> +__u64 uprobe_stack[128];
> +__u64 uretprobe_stack[128];
> +int uprobe_stack_sz, uretprobe_stack_sz;
> +
>  SEC("uprobe//proc/self/exe:autoattach_trigger_func")
>  int handle_uprobe_byname(struct pt_regs *ctx)
>  {
>  	uprobe_byname_parm1 = PT_REGS_PARM1_CORE(ctx);
>  	uprobe_byname_ran = 1;
> +
> +	uprobe_stack_sz = bpf_get_stack(ctx,
> +					uprobe_stack, sizeof(uprobe_stack),
> +					BPF_F_USER_STACK);
>  	return 0;
>  }
>  
> @@ -40,6 +48,9 @@ int handle_uretprobe_byname(struct pt_regs *ctx)
>  {
>  	uretprobe_byname_rc = PT_REGS_RC_CORE(ctx);
>  	uretprobe_byname_ran = 2;
> +	uretprobe_stack_sz = bpf_get_stack(ctx,
> +					   uretprobe_stack, sizeof(uretprobe_stack),
> +					   BPF_F_USER_STACK);
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
