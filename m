Return-Path: <bpf+bounces-3577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7497400CC
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354EC280C12
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AACB19E71;
	Tue, 27 Jun 2023 16:23:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3B18C3B
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 16:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD1BC433C0;
	Tue, 27 Jun 2023 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687882988;
	bh=X7C7c+mN0VpeHK+Ecm9oxh43Gqr/gyJV3O7Y5jth8xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tSPi7/uDtxqfHqRTF6IbAWQW8/3OiYU+wZWpSb0uiTAc+vMsUawt2XKn4Hp6EbklJ
	 1okL5JcYassR84iRuRkwC741bSR8W25HoTWBcUYgYoaMEhnLGwEF22tQNhCFX8bSHF
	 FjsX4JlAPveulCI5S4GXjzrrsBkedfdH34gXrFSvJrR804Tbmmg4tsOvLO87kpEZaN
	 ui0iclTiL4bRAqDa+J1BW5LcfIBPbRKAy9vQPLDtBdh+v2cDXZgRKYY2bjcuSkFGty
	 ZULNPOykMMaMTMMRC0jglcUoRQ0uZuV7P0O1PfLLLqA1kHqL9qZeTuY+jsugYkYhMJ
	 n7YOKmDVk2t0A==
Date: Wed, 28 Jun 2023 01:23:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mark
 Rutland <mark.rutland@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Release rethook after the ftrace_ops is
 unregistered
Message-Id: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
In-Reply-To: <20230627233306.b9b04d75f86944466f6534c2@kernel.org>
References: <20230615115236.3476617-1-jolsa@kernel.org>
	<20230627233306.b9b04d75f86944466f6534c2@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 23:33:06 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 18d36842faf5..0121e8c0d54e 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -364,19 +364,13 @@ int unregister_fprobe(struct fprobe *fp)
> >  		    fp->ops.saved_func != fprobe_kprobe_handler))
> >  		return -EINVAL;
> >  
> > -	/*
> > -	 * rethook_free() starts disabling the rethook, but the rethook handlers
> > -	 * may be running on other processors at this point. To make sure that all
> > -	 * current running handlers are finished, call unregister_ftrace_function()
> > -	 * after this.
> > -	 */

Oh, wait, here is an important comment. If a rethook handler is still running
(because it hooks target function exit), returning from unregister_fprobe()
right after rethook_free() may cause another issue.

rethook_free() clears 'rh->handler', so after calling rethook_free(), we
can ensure no NEW rethook handler (means fprobe_exit_handler()) is called.
However, it doesn't mean there is no current running fprobe_exit_handler().
Thus if unregister_fprobe() caller releases the 'fp' right after returning
from unregister_fprobe(), current running fprobe_exit_handler() can access
'fp' (use-after-free).

Thus we need to add below code with this patch;
	/*
	 * The rethook handlers may be running on other processors at this point.
	 * To make sure that all current running handlers are finished, disable
	 * rethook by clearing handler and call unregister_ftrace_function()
	 * to ensure all running rethook handlers exit. And call rethook_free().
	 */
	if (fp->rethook)
		WRITE_ONCE(fp->rethook->handler, NULL);

> > -	if (fp->rethook)
> > -		rethook_free(fp->rethook);
> > -
> >  	ret = unregister_ftrace_function(&fp->ops);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	if (fp->rethook)
> > +		rethook_free(fp->rethook);
> > +
> >  	ftrace_free_filter(&fp->ops);
> >  
> >  	return ret;

Thank you,

> > -- 
> > 2.40.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

