Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B10F4E726E
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 12:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345320AbiCYLxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 07:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356842AbiCYLxf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 07:53:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5DDD444A;
        Fri, 25 Mar 2022 04:51:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b24so8918609edu.10;
        Fri, 25 Mar 2022 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9wI3U2BQFfRaggeAQmJJueKOAWP02S+tWNIFRTVWCtQ=;
        b=Ve2/EcXK+GE8PfE3jvwOz03/V7oNmd4iL0dl15IPoF8aVVUUBnb/whTBCOssbM58Lf
         GJtNXtFtm80ee9XfuattJC3F2W7UPNHfiW4rHvxBq05FIS2XqciGWm2UyqtbcCFnKlMd
         UTYNkopJsMflFjXTv7DxBEXHnrUIHl0ML6ksLp6b6TSEjl/zxHfcZO/zAWqXw24KAl0w
         H3/X7ZevqGFGTTnjxAwo8QpqT7EI8QD+/IF0Smrsl9MyaR5zTIBFQ7jDnlbWGaEhfTcM
         4EeMHYCVTFUOR0sHdxze54mCjDRGE5KS1LizhHNh4jaAnw8Fkl67EPI9jQg8xqjx+8Kx
         oMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wI3U2BQFfRaggeAQmJJueKOAWP02S+tWNIFRTVWCtQ=;
        b=VD3jDGm9aKDMoyxDF132vdxAEJGy8X/kqDQ3NeR/u0JjIbO2ku3wF1/C/0+INvE0rn
         OvtiM4l8Xgclxod7rE4NpvL51XnEtg4l894gaMh5P6zz0lv5EeGhv9PeVxq6GLF4JuDj
         a7zOPjD+nnwxhPw2uNBuncXSKM835djdHr/6KreiFXMyQ40et5lzO5JacuNW4SFGPsUd
         rdXq1JCAovYEnH/DSFzmbUZFSH+6XfV0Y+P8rhbRTEYW3l42HfE2LCQkMikkVv3x7Qob
         40O3wzH+v9OWzRt5EMwl9Wll3SoywuA8Zq9ecse1/QHp1wR4unSWaTA8o73hNSwKra8w
         u+Xg==
X-Gm-Message-State: AOAM532zYK4kZiIXAhNkt2vRPcUoIiez0a7E5rTxf69/4Oi8Lv8W2OE+
        dT4OuLUuLd6ExuMlHQfV+NE=
X-Google-Smtp-Source: ABdhPJzr4CiKL3LUBhLOaYyi4c4PSg+Tr+p0g+SWLFgiEvZkhcR/ME2PFy/04g23T5TZDOmAMVZKdg==
X-Received: by 2002:a50:9b11:0:b0:419:a8f:580c with SMTP id o17-20020a509b11000000b004190a8f580cmr12748888edi.292.1648209118222;
        Fri, 25 Mar 2022 04:51:58 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm2768361edu.51.2022.03.25.04.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 04:51:57 -0700 (PDT)
Date:   Fri, 25 Mar 2022 12:51:55 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH bpf-next 2/2] rethook: kprobes: x86: Replace kretprobe
 with rethook on x86
Message-ID: <Yj2s2zVjvfy0c/QA@krava>
References: <164818251899.2252200.7306353689206167903.stgit@devnote2>
 <164818254148.2252200.5054811796192907193.stgit@devnote2>
 <20220325100940.GM8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325100940.GM8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 25, 2022 at 11:09:40AM +0100, Peter Zijlstra wrote:
> On Fri, Mar 25, 2022 at 01:29:01PM +0900, Masami Hiramatsu wrote:
> > Replaces the kretprobe code with rethook on x86. With this patch,
> > kretprobe on x86 uses the rethook instead of kretprobe specific
> > trampoline code.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/x86/Kconfig                 |    1 
> >  arch/x86/include/asm/unwind.h    |   23 +++----
> >  arch/x86/kernel/Makefile         |    1 
> >  arch/x86/kernel/kprobes/common.h |    1 
> >  arch/x86/kernel/kprobes/core.c   |  107 ----------------------------------
> >  arch/x86/kernel/rethook.c        |  121 ++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 135 insertions(+), 119 deletions(-)
> >  create mode 100644 arch/x86/kernel/rethook.c
> 
> I'm thinking you'll find it builds much better with this on...

I built it with Peter's fix and ran bpf selftests, looks good

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 2de3c8c5eba9..794fdef2501a 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -550,15 +550,15 @@ bool unwind_next_frame(struct unwind_state *state)
>  		}
>  		/*
>  		 * There is a small chance to interrupt at the entry of
> -		 * __kretprobe_trampoline() where the ORC info doesn't exist.
> -		 * That point is right after the RET to __kretprobe_trampoline()
> +		 * arch_rethook_trampoline() where the ORC info doesn't exist.
> +		 * That point is right after the RET to arch_rethook_trampoline()
>  		 * which was modified return address.
> -		 * At that point, the @addr_p of the unwind_recover_kretprobe()
> +		 * At that point, the @addr_p of the unwind_recover_rethook()
>  		 * (this has to point the address of the stack entry storing
>  		 * the modified return address) must be "SP - (a stack entry)"
>  		 * because SP is incremented by the RET.
>  		 */
> -		state->ip = unwind_recover_kretprobe(state, state->ip,
> +		state->ip = unwind_recover_rethook(state, state->ip,
>  				(unsigned long *)(state->sp - sizeof(long)));
>  		state->regs = (struct pt_regs *)sp;
>  		state->prev_regs = NULL;
> @@ -573,7 +573,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  			goto err;
>  		}
>  		/* See UNWIND_HINT_TYPE_REGS case comment. */
> -		state->ip = unwind_recover_kretprobe(state, state->ip,
> +		state->ip = unwind_recover_rethook(state, state->ip,
>  				(unsigned long *)(state->sp - sizeof(long)));
>  
>  		if (state->full_regs)
