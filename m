Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17A043BAA5
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhJZTZh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhJZTZg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 15:25:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B15C061570;
        Tue, 26 Oct 2021 12:23:12 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id q124so125995oig.3;
        Tue, 26 Oct 2021 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V7VkTSBwQgFald//Ilc+j+3+SnZ8bbvef2rDCsEgFBg=;
        b=jECLzu54Y0zvazkU9iFIX1o2wd7J0KfFc385pv6kSc6u7Q6BiN7hRbb7F+ztk7BEOc
         4kfeBvy55NzB54ZGBBMZbPNX4z5HqcYP73w83xBNS0LOrGsFvEfgREzsXVKADOxw4Zk3
         BQPMB0uBQbVg7n8FGNK5zX9TrZyIkRse/joyfl7oHgG5Am1a++NwBQ1CzPQ/al3Eh5yO
         SMaCX5JdutW10D34o/DFT1tX7c0/KeZHD9qQWQQEbPYgOY2dI7Zug+x8Ss5fjtRB+Sy2
         8b5XQDhxiQCfXHasdGHCPXQ0231DPYELnmIkYKYICQwjBu+oS1FVXsyW7vEzc9VTTgdi
         o37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=V7VkTSBwQgFald//Ilc+j+3+SnZ8bbvef2rDCsEgFBg=;
        b=OVe/INom5wcezPW+wwHVoUT9yiZrEJgy1RAeS9kv2NLh8o1KS5vGMsNGE0DzM8YT1v
         bLBK3YKunw8NQXwXYlNX6PUzjgOIOloR57Or5znTxo8QoygBEJeeLTgYC899XSG9UUeV
         nq26xl8J0jxXxhklMpe6mmggrAtJcbDVvPUn1XmV2KH4xjoGi/7ZV82p2bHqXLxRhzKG
         wBj9t14TkihSpfoT6Zs18cr1LZfqz1CRzh5jA1qQ3WsOoR32AIKZME1Ct4GvB7kTTNsi
         D9ppYHlSfwdBfzAeKZcxAB8WXYsxrkJO5Jl/rcL9H+whP3cpv5aUDdk56sdF1rPZxob1
         QKpg==
X-Gm-Message-State: AOAM533LGE+gW4yLHFxqc9YxnRC3ti5gZ42pwvrp0sv8NF54HlYw0ZSR
        Kb05nYFFWDdKud/nR6RKd6YtxElcnuc=
X-Google-Smtp-Source: ABdhPJwuQ30wCPAKeFparW8yIDS9zoJPEZUgKtlNoDLgX3KLgctJU2SUHCG3dBZSx7z6+SiWw09luA==
X-Received: by 2002:a54:4616:: with SMTP id p22mr506288oip.96.1635276191711;
        Tue, 26 Oct 2021 12:23:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17sm5139886ots.35.2021.10.26.12.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:23:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Oct 2021 12:23:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 8/8] ftrace/samples: Add multi direct interface test
 module
Message-ID: <20211026192309.GA2038767@roeck-us.net>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <20211008091336.33616-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008091336.33616-9-jolsa@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 08, 2021 at 11:13:36AM +0200, Jiri Olsa wrote:
> Adding simple module that uses multi direct interface:
> 
>   register_ftrace_direct_multi
>   unregister_ftrace_direct_multi
> 
> The init function registers trampoline for 2 functions,
> and exit function unregisters them.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Building s390:defconfig ... failed
--------------
Error log:
<stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
{standard input}: Assembler messages:
{standard input}:11: Error: Unrecognized opcode: `pushq'
{standard input}:12: Error: Unrecognized opcode: `movq'
{standard input}:13: Error: Unrecognized opcode: `pushq'
{standard input}:14: Error: Unrecognized opcode: `movq'
{standard input}:15: Error: Unrecognized opcode: `call'
{standard input}:16: Error: Unrecognized opcode: `popq'
{standard input}:17: Error: Unrecognized opcode: `leave'
{standard input}:18: Error: Unrecognized opcode: `ret'
make[3]: *** [scripts/Makefile.build:288: samples/ftrace/ftrace-direct-multi.o] Error 1
make[2]: *** [scripts/Makefile.build:571: samples/ftrace] Error 2
make[1]: *** [Makefile:1993: samples] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:226: __sub-make] Error 2

Guenter

> ---
>  samples/ftrace/Makefile              |  1 +
>  samples/ftrace/ftrace-direct-multi.c | 52 ++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 samples/ftrace/ftrace-direct-multi.c
> 
> diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
> index 4ce896e10b2e..ab1d1c05c288 100644
> --- a/samples/ftrace/Makefile
> +++ b/samples/ftrace/Makefile
> @@ -3,6 +3,7 @@
>  obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
>  obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
>  obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
> +obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-multi.o
>  
>  CFLAGS_sample-trace-array.o := -I$(src)
>  obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> new file mode 100644
> index 000000000000..2a5b1fb7ac14
> --- /dev/null
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/module.h>
> +
> +#include <linux/mm.h> /* for handle_mm_fault() */
> +#include <linux/ftrace.h>
> +#include <linux/sched/stat.h>
> +
> +void my_direct_func(unsigned long ip)
> +{
> +	trace_printk("ip %lx\n", ip);
> +}
> +
> +extern void my_tramp(void *);
> +
> +asm (
> +"	.pushsection    .text, \"ax\", @progbits\n"
> +"	.type		my_tramp, @function\n"
> +"	.globl		my_tramp\n"
> +"   my_tramp:"
> +"	pushq %rbp\n"
> +"	movq %rsp, %rbp\n"
> +"	pushq %rdi\n"
> +"	movq 8(%rbp), %rdi\n"
> +"	call my_direct_func\n"
> +"	popq %rdi\n"
> +"	leave\n"
> +"	ret\n"
> +"	.size		my_tramp, .-my_tramp\n"
> +"	.popsection\n"
> +);
> +
> +static struct ftrace_ops direct;
> +
> +static int __init ftrace_direct_multi_init(void)
> +{
> +	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
> +	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
> +
> +	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> +}
> +
> +static void __exit ftrace_direct_multi_exit(void)
> +{
> +	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> +}
> +
> +module_init(ftrace_direct_multi_init);
> +module_exit(ftrace_direct_multi_exit);
> +
> +MODULE_AUTHOR("Jiri Olsa");
> +MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
> +MODULE_LICENSE("GPL");
> -- 
> 2.31.1
> 
