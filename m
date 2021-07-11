Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051533C39E0
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 04:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhGKCKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 22:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231376AbhGKCK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 22:10:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EA5A610A1;
        Sun, 11 Jul 2021 02:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625969263;
        bh=haxQ3gshZCmVQEAZFEN8JV7jIw4Yf+8/Et/CYbeJzew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DAuxHJ0iwVukl21etWafOvyhowQhaDrXrznRUBdaekF7ErUPzyt9h56EORxLHTtHu
         dkWhjWMUwmF4BrLj8iBc7OXs9/cEijxzNWKtcj/mYWNuCrBMZRdRXjLiTI2cQ0EJ04
         GdxWl+RVGRUPf8hxP34Ju5cFEBRCf3NBizWGBkorwHPH3wP7CpcmFjyZ9KP5EJKmCD
         DLQo+qLbtPjG385NsFdrDPxAK3D/HG9rBol7ZjTT/fXGHoVy6LwpUFsybdmZBz9V76
         m4GRHMsG6KAzsKvoOx1grjTnv97muyfuRchOadyLSZbZjq2NPdu4vQ5E4hpg/QOjzA
         GuUhu06h+xktg==
Date:   Sun, 11 Jul 2021 11:07:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH 2/2] objtool: Ignore unwind hints for ignored functions
Message-Id: <20210711110738.f745f62b6858e2d5d9006cd6@kernel.org>
In-Reply-To: <20210710192514.ghvksi3ozhez4lvb@treble>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399996966.506599.810050095040575221.stgit@devnote2>
        <YOK8pzp8B2V+1EaU@gmail.com>
        <20210710003140.8e561ad33d42f9ac78de6a15@kernel.org>
        <20210710104104.3a270168811ac38420093276@kernel.org>
        <20210710190143.lrcsyal2ggubv43v@treble>
        <20210710192514.ghvksi3ozhez4lvb@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 10 Jul 2021 12:25:14 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> If a function is ignored, also ignore its hints.  This is useful for the
> case where the function ignore is conditional on frame pointers, e.g.
> STACK_FRAME_NON_STANDARD_FP().

This also looks good to me, and test with my series works fine.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e5947fbb9e7a..67cbdcfcabae 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2909,7 +2909,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
>  	}
>  
>  	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
> -		if (insn->hint && !insn->visited) {
> +		if (insn->hint && !insn->visited && !insn->ignore) {
>  			ret = validate_branch(file, insn->func, insn, state);
>  			if (ret && backtrace)
>  				BT_FUNC("<=== (hint)", insn);
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
