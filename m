Return-Path: <bpf+bounces-3252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A673B5E1
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 13:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8348281674
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FB1FCF;
	Fri, 23 Jun 2023 11:11:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E33D6A
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 11:11:43 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB26510F6;
	Fri, 23 Jun 2023 04:11:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f973035d60so494415e87.3;
        Fri, 23 Jun 2023 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687518700; x=1690110700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=do2bpdVMJ85bRb47mVgKbZvqePYWno5Te4+1xoLO+cA=;
        b=rAxKMbv6GqbOHjUiDS8dFT6/c0ePaFssDunkFQr3S5e+t+4F35gxilj77Tk8q7MQkC
         e4Dep24F5Yy6ZmT2PDgYXix7AYefI8wsJ0p5iJvAvLqqR84cl94I1Lhge5eTQFf63Dyr
         eK1vz+ynecIclLPAxSchNaK0fmn7s9kFllsgtIRYRz/V8eFqa238MQmiU10FZQtmd9Ql
         8gOEsXyC6PBQzEvNTHvVf8RU3muJKRG5QCiccxPP2OhdQXwrMDBs7mJFzkmkBDdkQcBK
         AcI6haW9a49UHk1qmsxk/7vEGA1G7Y+HD5D8DGtpih0IzR2Df1A0oJEyiKFGXDPrJbFq
         iVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687518700; x=1690110700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do2bpdVMJ85bRb47mVgKbZvqePYWno5Te4+1xoLO+cA=;
        b=Zazk28F+R6v0VbnyEbvtoo9uZs1oLZPEDGEOOADJMZmp6BNwgMfAhhs9s6N97/3Zuh
         d5ePPJutfbvRp0L1GVs+oFBoLEV5mE7dBy3jWzqCNrMUfTVPTJ7SlwLtyMSkISLU57eU
         yoiUrdpZccrRBBt9qOJIbsiqfxhloiq880BKof4s+GO3GGCo1wyzU97/rfJwGSuIij+8
         mCuu1fo6jkz+ggT9gdU0x/KfAfsharjCB0YRuJaQuonjAzdK4Qj5ugmdTGTGp/yi/qJg
         lLbeCMfWRelxB9IWUTjucL5HnzgvXyaA2b7zBE6lCbhL536hr2HIGWehuyXgDYmUkqt9
         KUAA==
X-Gm-Message-State: AC+VfDwBvKfh/j6+J48FchWvTu0b2CILxVsbP1F/aC3r/v/OIK0hQtsP
	2cgUr2vfK7721ZW1ZqIin7/UXHhG38I=
X-Google-Smtp-Source: ACHHUZ4803QgZmjT5Dlbvcvt9KwmbS0zzuCrnTbJO0AFMNORcAcWIN2QouoqCxwoMM/Mg4OTgZGMyQ==
X-Received: by 2002:a19:ab11:0:b0:4f8:7614:48a5 with SMTP id u17-20020a19ab11000000b004f8761448a5mr7273219lfe.66.1687518699691;
        Fri, 23 Jun 2023 04:11:39 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c14-20020a7bc84e000000b003f8126bcf34sm2009848wml.48.2023.06.23.04.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:11:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Jun 2023 13:11:36 +0200
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Release rethook after the ftrace_ops is
 unregistered
Message-ID: <ZJV96BqF8EAXAOOd@krava>
References: <20230615115236.3476617-1-jolsa@kernel.org>
 <20230615085920.7dadac74@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615085920.7dadac74@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 08:59:20AM -0400, Steven Rostedt wrote:
> 
> Masami,
> 
> Want to take this via your probes/urgent branch and send it off to Linus?

hi,
did this one make it into some tree?

thanks,
jirka


> 
> -- Steve
> 
> 
> On Thu, 15 Jun 2023 13:52:36 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > While running bpf selftests it's possible to get following fault:
> > 
> >   general protection fault, probably for non-canonical address \
> >   0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> >   ...
> >   Call Trace:
> >    <TASK>
> >    fprobe_handler+0xc1/0x270
> >    ? __pfx_bpf_testmod_init+0x10/0x10
> >    ? __pfx_bpf_testmod_init+0x10/0x10
> >    ? bpf_fentry_test1+0x5/0x10
> >    ? bpf_fentry_test1+0x5/0x10
> >    ? bpf_testmod_init+0x22/0x80
> >    ? do_one_initcall+0x63/0x2e0
> >    ? rcu_is_watching+0xd/0x40
> >    ? kmalloc_trace+0xaf/0xc0
> >    ? do_init_module+0x60/0x250
> >    ? __do_sys_finit_module+0xac/0x120
> >    ? do_syscall_64+0x37/0x90
> >    ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >    </TASK>
> > 
> > In unregister_fprobe function we can't release fp->rethook while it's
> > possible there are some of its users still running on another cpu.
> > 
> > Moving rethook_free call after fp->ops is unregistered with
> > unregister_ftrace_function call.
> > 
> > Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/fprobe.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
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
> 

