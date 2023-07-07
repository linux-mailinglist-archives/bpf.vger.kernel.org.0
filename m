Return-Path: <bpf+bounces-4363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB074A806
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03F8281374
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7273E804;
	Fri,  7 Jul 2023 00:17:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433C161
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 00:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD925C433C7;
	Fri,  7 Jul 2023 00:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688689036;
	bh=ymAymf4FHdvPplfqSDcRK8uyKvH11GL8w4/ZdkYCmgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t02yP5f9rk25XZLZpImqy243RZTgUUKufHS4sJg0w/slPICynml3SV3qvyJaOnJqn
	 VFEMSV5RObHJxO18LvaTbmC6WoiTe/tLex0osTRbXjEgBGFflSakhO/5svwwGg5Dax
	 2jNk2SVszEriENOYIhfEXmCmsuXzqj/2LT1sPHZUkF9wJdxSXR/KELNt/Z/M2cZocr
	 Q4k2BrU2hnG2u9uoNTvjBdm7VHpMqsridPMqhq5FiD76G5/wC8yOeIuoglL0ja7S72
	 DUwzUQ6wp88qbX91ano7F8FA8dUXhdr77u94lBiXkI5S7n2HnpNoz0DcZ1oniddLeu
	 Qy9S5RrAVpYJA==
Date: Fri, 7 Jul 2023 09:17:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, lkml
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Ensure running fprobe_exit_handler() finished
 before calling rethook_free()
Message-Id: <20230707091712.e478e0b6e8f5c1ab0802a510@kernel.org>
In-Reply-To: <20230706095624.3a846b8e@gandalf.local.home>
References: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
	<168796344232.46347.7947681068822514750.stgit@devnote2>
	<20230705212657.5968daf7@gandalf.local.home>
	<20230706141012.c1a0ae0901e0fdec7b3078c7@kernel.org>
	<20230706095624.3a846b8e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jul 2023 09:56:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 6 Jul 2023 14:10:12 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > With only Jiri's patch, following flow can happen;
> > 
> > ------
> >  CPU1                              CPU2
> >  call unregister_fprobe()
> >  ...
> >                                    __fprobe_handler()
> >                                    rethook_hook() on probed function
> >  unregister_ftrace_function()
> >                                    return from probed function
> >                                    rethook hooks
> >                                    find rh->handler == fprobe_exit_handler
> >                                    call fprobe_exit_handler()
> >  rethook_free():
> >    set rh->handler = NULL;
> >  return from unreigster_fprobe;
> >                                    call fp->exit_handler() <- (*)
> > 
> > (*) In this point, the exit handler is called after returning from 
> > unregister_fprobe().
> > ------
> > 
> > So, this patch changes it as following;
> > ------
> >  CPU1                              CPU2
> >  call unregister_fprobe()
> >  ...
> >  rethook_stop():
> >    set rh->handler = NULL;
> >                                    __fprobe_handler()
> >                                    rethook_hook() on probed function
> >  unregister_ftrace_function()
> >                                    return from probed function
> >                                    rethook hooks
> >                                    find rh->handler == NULL
> >                                    return from rethook
> >  rethook_free()
> >  return from unreigster_fprobe;
> > ------
> > 
> > I can also just put a synchronize_sched_rcu() right after rethook_free()
> > to wait for all running fprobe_exit_handler() too.
> > 
> 
> This makes more sense. Can you please add the above to the change log.

OK, let me update it.

Thanks!

> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

