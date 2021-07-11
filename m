Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B471A3C39D3
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 03:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhGKB3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 21:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhGKB3R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 21:29:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C3F961278;
        Sun, 11 Jul 2021 01:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625966791;
        bh=PV9N7JnYv9F98KCENyu3s5fMBWIhEK3SUc/c5d6y7v8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1TllhmIQ9ljDTRH9sWoeexIgYLsX6dEtnqqIKX8KawgDfOGy8Z7ETKuuofy40dsv
         JmGHt3VEM2gen4OW0A9RLAAxRwXz3cjuneBakkonYtMx5FCHjJsAzq00OPbOl8Gu1u
         0QUB3OC8V9J7DS1ZPaw3z+4lBialGPinQzmPzwErTNqbOwomDz//38Ho3GtC5/ftGM
         la4cAF5zvsRoNX80JDeuYIIGtoxRec+O92+FG49RoXH1dSQBSIiZiVanYW6E0hhLLK
         cmh9u9Bk4T1ZXc5u7seYbGBgxCTN1QByTWZD1U/YNTxr5lEQo17nIrMyvikATJOScT
         6vcp1Uq2wx1TA==
Date:   Sun, 11 Jul 2021 10:26:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip 6/6] kprobes: Use bool type for functions which
 returns boolean value
Message-Id: <20210711102627.aacd375107225da46473e2ee@kernel.org>
In-Reply-To: <dd3ec20d371703c121a18e91908ab8faa76c852d.camel@perches.com>
References: <162592891873.1158485.768824457210707916.stgit@devnote2>
        <162592897337.1158485.13933847832718343850.stgit@devnote2>
        <dd3ec20d371703c121a18e91908ab8faa76c852d.camel@perches.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 10 Jul 2021 09:27:22 -0700
Joe Perches <joe@perches.com> wrote:

> On Sat, 2021-07-10 at 23:56 +0900, Masami Hiramatsu wrote:
> > Use the 'bool' type instead of 'int' for the functions which
> > returns a boolean value, because this makes clear that those
> > functions don't return any error code.
> []
> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> []
> > @@ -104,25 +104,25 @@ struct kprobe {
> >  #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
> >  
> > 
> >  /* Has this kprobe gone ? */
> > -static inline int kprobe_gone(struct kprobe *p)
> > +static inline bool kprobe_gone(struct kprobe *p)
> >  {
> >  	return p->flags & KPROBE_FLAG_GONE;
> >  }
> 
> This change would also allow the removal of the !! from:
> 
> kernel/trace/trace_kprobe.c:104:        return !!(kprobe_gone(&tk->rp.kp));

Good catch! OK, I'll update 

Thank you,

> ---
>  kernel/trace/trace_kprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index ea6178cb5e334..c6e0345a44e94 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -101,7 +101,7 @@ static nokprobe_inline unsigned long trace_kprobe_offset(struct trace_kprobe *tk
>  
>  static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
>  {
> -	return !!(kprobe_gone(&tk->rp.kp));
> +	return kprobe_gone(&tk->rp.kp);
>  }
>  
>  static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
