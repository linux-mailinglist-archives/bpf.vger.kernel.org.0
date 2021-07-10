Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5713C3585
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGJQaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 12:30:14 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:35202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229452AbhGJQaO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 10 Jul 2021 12:30:14 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 3C9BB181D3025;
        Sat, 10 Jul 2021 16:27:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 1F0D3240236;
        Sat, 10 Jul 2021 16:27:24 +0000 (UTC)
Message-ID: <dd3ec20d371703c121a18e91908ab8faa76c852d.camel@perches.com>
Subject: Re: [PATCH -tip 6/6] kprobes: Use bool type for functions which
 returns boolean value
From:   Joe Perches <joe@perches.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 10 Jul 2021 09:27:22 -0700
In-Reply-To: <162592897337.1158485.13933847832718343850.stgit@devnote2>
References: <162592891873.1158485.768824457210707916.stgit@devnote2>
         <162592897337.1158485.13933847832718343850.stgit@devnote2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1F0D3240236
X-Spam-Status: No, score=1.59
X-Stat-Signature: g7d5ey6794yc3adwpqbjf4sfbzj4aa8s
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18NhvQmIVgwou9EnrL7AsJoLwMB4STNfdM=
X-HE-Tag: 1625934444-490807
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2021-07-10 at 23:56 +0900, Masami Hiramatsu wrote:
> Use the 'bool' type instead of 'int' for the functions which
> returns a boolean value, because this makes clear that those
> functions don't return any error code.
[]
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
[]
> @@ -104,25 +104,25 @@ struct kprobe {
>  #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
>  
> 
>  /* Has this kprobe gone ? */
> -static inline int kprobe_gone(struct kprobe *p)
> +static inline bool kprobe_gone(struct kprobe *p)
>  {
>  	return p->flags & KPROBE_FLAG_GONE;
>  }

This change would also allow the removal of the !! from:

kernel/trace/trace_kprobe.c:104:        return !!(kprobe_gone(&tk->rp.kp));
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ea6178cb5e334..c6e0345a44e94 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -101,7 +101,7 @@ static nokprobe_inline unsigned long trace_kprobe_offset(struct trace_kprobe *tk
 
 static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 {
-	return !!(kprobe_gone(&tk->rp.kp));
+	return kprobe_gone(&tk->rp.kp);
 }
 
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,


