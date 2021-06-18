Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F53ACD08
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFROGu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 10:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233893AbhFROGt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 18 Jun 2021 10:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624025079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4/MAAO2RBJYfBGbAHmWoKr3dKd/cHorzGFyg6HuH7A=;
        b=g4cIueeh/5p54JgjwfJlR52qOcedlObFGBhGEvhApQIc0zzUOi+tdxUfNLUUfms5LRLjGm
        0vP3fkDitjs5yBDFoCcg2UW31yv3OmISrB/MwfCz/WyIlALgas54rl/tA1LzaFKLmZtCWs
        3Z12SvYjro0UTJFg5wQEW8Cnolxt2/A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-SIng_GOEP4-ekjhY2EGnCg-1; Fri, 18 Jun 2021 10:04:36 -0400
X-MC-Unique: SIng_GOEP4-ekjhY2EGnCg-1
Received: by mail-qk1-f197.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so5612637qkf.3
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 07:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o4/MAAO2RBJYfBGbAHmWoKr3dKd/cHorzGFyg6HuH7A=;
        b=XszrlHmQUlZ5u9eyCYWLbBcYENrCoTJiXk53O3y9euYO0MzwxOLpnM88C/T/HlPxtj
         qKHiPxz3QKDlu4u8uQZll0ZB7PVE7N0FsQfJrTBCMZVWnxD4AzQsOnv/WErx/Vfm2/DN
         Z5sv7VAixIT1fi5lhejkup96DHgZpF4ufuhwO9m35RNIOCB27rbGRfNjowSma6M8nm5Z
         Q+0VVHmjdDu6LQWGta/ZqlOpLw2SmgJdafpxvKrWOR+8y4Qm14Fzh74pum5QvWFX8JEb
         aCbNSMU7WKdx4ucyQxXaI/Kw0reotkcR32f41FBTXkhzdZWsWnGuXgUxGG1qcss6YHRN
         aWvw==
X-Gm-Message-State: AOAM5307USqeKQkX/JBCCNHoWWuaiu6NdGdPGfPrkCSbBXTvaCn2fQT3
        kEwVKbDWRPulwWWVAQQJbbVVyloXkYkyRnKeo+2zMtWDT7zWXeWLnln3AqLmANTy58IaC1WBqmd
        9dSKbz6PDv8WD
X-Received: by 2002:a05:6214:17d2:: with SMTP id cu18mr1856565qvb.48.1624025075808;
        Fri, 18 Jun 2021 07:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWdjn/e3bp8k2qYtJ4JSPdpyPJOcw95bpeOHzfwYoo753l01h+N2vR+P8ZKMV6jt/Xa60Msg==
X-Received: by 2002:a05:6214:17d2:: with SMTP id cu18mr1856524qvb.48.1624025075512;
        Fri, 18 Jun 2021 07:04:35 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id 7sm5415837qtx.33.2021.06.18.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 07:04:35 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:04:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 09/13] kprobes: Enable stacktrace from pt_regs in
 kretprobe handler
Message-ID: <20210618140432.icuopdgxt2urngmy@treble>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400000592.506599.4695807810528866713.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162400000592.506599.4695807810528866713.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 04:06:46PM +0900, Masami Hiramatsu wrote:
> Since the ORC unwinder from pt_regs requires setting up regs->ip
> correctly, set the correct return address to the regs->ip before
> calling user kretprobe handler.
> 
> This allows the kretrprobe handler to trace stack from the
> kretprobe's pt_regs by stack_trace_save_regs() (eBPF will do
> this), instead of stack tracing from the handler context by
> stack_trace_save() (ftrace will do this).
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Andrii Nakryik <andrii@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

> ---
>  Changes in v8:
>   - Update comment to clarify why this is needed.
>  Changes in v3:
>   - Cast the correct_ret_addr to unsigned long.
> ---
>  kernel/kprobes.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 650cbe738666..ba729ed05cb3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1896,6 +1896,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  		BUG_ON(1);
>  	}
>  
> +	/* Set the instruction pointer to the correct address */
> +	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
> +
>  	/* Run them. */
>  	first = current->kretprobe_instances.first;
>  	while (first) {
> 

-- 
Josh

