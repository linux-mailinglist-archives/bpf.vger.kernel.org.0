Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8172732EF41
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 16:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCEPoO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 10:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhCEPoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 10:44:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC406508C;
        Fri,  5 Mar 2021 15:44:10 +0000 (UTC)
Date:   Fri, 5 Mar 2021 10:44:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 5/5] tracing: Remove kretprobe unknown indicator
 from stacktrace
Message-ID: <20210305104409.72e90865@gandalf.local.home>
In-Reply-To: <161495879052.346821.1701648047040447725.stgit@devnote2>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <161495879052.346821.1701648047040447725.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat,  6 Mar 2021 00:39:50 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the stacktrace API fixup the kretprobed address correctly,
> there is no need to convert the "kretprobe_trampoline" to
>  "[unknown/kretprobe'd]" anymore. Remove it.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_output.c |   27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 61255bad7e01..f5f8b081b668 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -346,37 +346,18 @@ int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...)
>  }
>  EXPORT_SYMBOL_GPL(trace_output_call);
>  
> -#ifdef CONFIG_KRETPROBES
> -static inline const char *kretprobed(const char *name)
> -{
> -	static const char tramp_name[] = "kretprobe_trampoline";
> -	int size = sizeof(tramp_name);
> -
> -	if (strncmp(tramp_name, name, size) == 0)
> -		return "[unknown/kretprobe'd]";
> -	return name;
> -}
> -#else
> -static inline const char *kretprobed(const char *name)
> -{
> -	return name;
> -}
> -#endif /* CONFIG_KRETPROBES */
> -
>  void
>  trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
>  {
>  #ifdef CONFIG_KALLSYMS
> -	char str[KSYM_SYMBOL_LEN];
> -	const char *name;
> +	char name[KSYM_SYMBOL_LEN];
>  
>  	if (offset)
> -		sprint_symbol(str, address);
> +		sprint_symbol(name, address);
>  	else
> -		kallsyms_lookup(address, NULL, NULL, NULL, str);
> -	name = kretprobed(str);
> +		kallsyms_lookup(address, NULL, NULL, NULL, name);
>  
> -	if (name && strlen(name)) {
> +	if (strlen(name)) {
>  		trace_seq_puts(s, name);
>  		return;
>  	}

