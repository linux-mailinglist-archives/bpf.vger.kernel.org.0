Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E183BB88E
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhGEIF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhGEIF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 04:05:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A982C061574;
        Mon,  5 Jul 2021 01:02:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a8so9236101wrp.5;
        Mon, 05 Jul 2021 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nDuL6f8Z9nXcmXENCd06OrjSCnYjBU1lGgkNiNZdJMs=;
        b=R/gy7mYUqgocSsQcPyweebZW5aSxozHHZYjO/99tK78pwiZm/MULplsTRCmRTAH/DH
         xIvW3kerIaQuNsYFiojpBcGNoPQyEQ9R7fG5hGO9O77fAzJdRVVOe+5tZRmNkckQkm+N
         XIinPBRbOjZiGyeFgT0J/wY84jyY2RyeR9NOgaroKUg+HbLWwSTQpn2ZJQuIzg5hiiUn
         FpQjRtsaD5hCbgJYom7ZbZAIHcLNUDB9WzVwzgc1iYhi2+QEabLVDfZWUwgNiK+ivEkY
         +UXNFVAAj4zL1U+OO5InApYxQLsHe+sXqdj6nAfKkMDuQOBzgeVP6XzHDLb61SmN8yH+
         VVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nDuL6f8Z9nXcmXENCd06OrjSCnYjBU1lGgkNiNZdJMs=;
        b=KrIDwEFLYv+FrLTF/B+vMhYx9DGuGPy+/F71F4Z15lbLC99GZZzv+t6S0ykcCVlNn+
         gZfKjqwz2z+ES88xbqqQoqzs7qVF9bLQw2K7GcEqMQnNKXWyNmi32qDWJC+XHIkf9qAv
         POctt0w2JDe20xmL7rWLilHQFDYjeGthNCLM4QrFLmt0EW779RaBk5jN8GHvPyshS2EH
         57Qqa6Ue3NgV7S/7rZi2Pew4/qJc3P1BColTRtnho3ewBZJlbhomf5X4vBV9wqxeVIcQ
         +ZWxgv0zJc81zVd45Oe0JzmDSecWJnXIbLNwweLZCUTagdVEScguraMl5xgZkQC3Fjg2
         S3jA==
X-Gm-Message-State: AOAM532SB/gHPdfQDS3mm/rCxDDnyL416veclyfymYuS08jScpyU87HV
        UMMn15tJphXzlYkRZ7D9z88=
X-Google-Smtp-Source: ABdhPJyL6aJS7V9VOYZLzsWIpvPdp2UJoP0THM5EMXpOd8Yg8ZrDZwVHtL/IdAto8nRiJggPDWe9nQ==
X-Received: by 2002:adf:f642:: with SMTP id x2mr10594402wrp.37.1625472170047;
        Mon, 05 Jul 2021 01:02:50 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id p18sm9155162wrt.18.2021.07.05.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:02:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 10:02:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 05/13] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-ID: <YOK8pzp8B2V+1EaU@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399996966.506599.810050095040575221.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162399996966.506599.810050095040575221.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Add UNWIND_HINT_FUNC on kretporbe_trampoline code so that ORC
> information is generated on the kretprobe_trampoline correctly.

What is a 'kretporbe'?

> Note that when the CONFIG_FRAME_POINTER=y, since the
> kretprobe_trampoline skips updating frame pointer, the stack frame
> of the kretprobe_trampoline seems non-standard. So this marks it
> is STACK_FRAME_NON_STANDARD() and undefine UNWIND_HINT_FUNC.

What does 'marks it is' mean?

'undefine' UNWIND_HINT_FUNC?

Doesn't the patch do the exact opposite:

  > +#define UNWIND_HINT_FUNC \
  > +	UNWIND_HINT(ORC_REG_SP, 8, UNWIND_HINT_TYPE_FUNC, 0)

But it does undefine it in a specific spot:



> Anyway, with the frame pointer, FP unwinder can unwind the stack
> frame correctly without that hint.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Andrii Nakryik <andrii@kernel.org>

I have to say these changelogs are very careless.

> +#else
> +

In headers, in longer CPP blocks, please always mark the '#else' branch 
with what it is the else branch of.

See the output of:

   kepler:~/tip> git grep '#else' arch/x86/include/asm/ | head

> +#ifdef CONFIG_FRAME_POINTER
> +/*
> + * kretprobe_trampoline skips updating frame pointer. The frame pointer
> + * saved in trampoline_handler points to the real caller function's
> + * frame pointer. Thus the kretprobe_trampoline doesn't seems to have a
> + * standard stack frame with CONFIG_FRAME_POINTER=y.
> + * Let's mark it non-standard function. Anyway, FP unwinder can correctly
> + * unwind without the hint.

s/doesn't seems to have a standard stack frame
 /doesn't have a standard stack frame

There's nothing 'seems' about the situation - it's a non-standard function 
entry and stack frame situation, and the unwinder needs to know about it.

> +STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> +#undef UNWIND_HINT_FUNC
> +#define UNWIND_HINT_FUNC
> +#endif
>  /*
>   * When a retprobed function returns, this code saves registers and
>   * calls trampoline_handler() runs, which calls the kretprobe's handler.
> @@ -1031,6 +1044,7 @@ asm(
>  	/* We don't bother saving the ss register */
>  #ifdef CONFIG_X86_64
>  	"	pushq %rsp\n"
> +	UNWIND_HINT_FUNC
>  	"	pushfq\n"
>  	SAVE_REGS_STRING
>  	"	movq %rsp, %rdi\n"
> @@ -1041,6 +1055,7 @@ asm(
>  	"	popfq\n"
>  #else
>  	"	pushl %esp\n"
> +	UNWIND_HINT_FUNC
>  	"	pushfl\n"
>  	SAVE_REGS_STRING
>  	"	movl %esp, %eax\n"

Why not provide an appropriate annotation method in <asm/unwind_hints.h>, 
so that other future code can use it too instead of reinventing the wheel?

Thanks,

	Ingo
