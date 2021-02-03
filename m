Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2B30D9F2
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 13:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBCMlj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 07:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhBCMlg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 07:41:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB1A164F87;
        Wed,  3 Feb 2021 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612356056;
        bh=2FV/J6/l2jFSKiBR70t8KfN8a1ETHQXMtRCaWul0VyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cp2NyR/OGKMyclEAg+EgedhtglyOI03rkabjNdbhnkNrRzzkL8/nG54IcH0cVJPND
         66QKRkLhx4XyMCXW5aIOTuN+eq/1HrPX9xWQlMyVEjVJycrHuaf++UC7yOCs/qF4zp
         vCVR+O3a4Yb7vUzC3LZsPqvTj1snoRCZD7YmRPOBoRZtN5J1OwhYfkzFU692KFfQEP
         qslrmGOr0eVN/Lic/xDx2THdh9RjOBe7k5vUxTvQOpthJpHgu9tho5RLV05uyWN8vm
         /MW6LxJ7DLaSCmpwh0Ve7aM3o/3fe5IafOAnZfzfKOk4KDOeJ6GiixT+gYiYyS6dse
         x3G59VNHNhCHA==
Date:   Wed, 3 Feb 2021 21:40:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, nborisov@suse.com,
        peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf] bpf: Unbreak BPF_PROG_TYPE_KPROBE when kprobe is
 called via do_int3
Message-Id: <20210203214051.f9cd7c0c0d096b02efbd01c3@kernel.org>
In-Reply-To: <20210203070636.70926-1-alexei.starovoitov@gmail.com>
References: <20210203070636.70926-1-alexei.starovoitov@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  2 Feb 2021 23:06:36 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> From: Alexei Starovoitov <ast@kernel.org>
> 
> The commit 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> converted do_int3 handler to be "NMI-like".
> That made old if (in_nmi()) check abort execution of bpf programs
> attached to kprobe when kprobe is firing via int3
> (For example when kprobe is placed in the middle of the function).
> Remove the check to restore user visible behavior.
> 
> Fixes: 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Looks good to me :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/bpf_trace.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6c0018abe68a..764400260eb6 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -96,9 +96,6 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>  {
>  	unsigned int ret;
>  
> -	if (in_nmi()) /* not supported yet */
> -		return 1;
> -
>  	cant_sleep();
>  
>  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> -- 
> 2.24.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
