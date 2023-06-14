Return-Path: <bpf+bounces-2577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A90172F50E
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 08:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E7281335
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9FAA53;
	Wed, 14 Jun 2023 06:42:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156DB7F
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 06:42:53 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C841A3;
	Tue, 13 Jun 2023 23:42:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-310b631c644so512977f8f.0;
        Tue, 13 Jun 2023 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686724970; x=1689316970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmdEkfLeOgGxB3Q9AIBuyne+hWdSajk51LvARVCqqic=;
        b=bb5a5z6Jj/LuTLtvf9GgxMLUdTQKDG9xeM7fb/9DhVTvbOQKwhKhvRsQMx1mdV2EjB
         1P1WkD89YMLWXoxF+UwharvRk/SKA7mUfMVJfNFjC4d9OUKfaXXNfIA5/Bd8uslIZsl+
         Ws1hNMvTtkDo+0qMpEohZjQcDN8yi2ovWMhhUr/yp5mozx0+W8Skh3v4qezHtBvGCIBX
         rHpgy+cj6mSVBcVcG4Csjd4PAdhmC9RGNvUauCMEQ9SZlSTEMrTTElvsxN1UuAylahXP
         O4DtqU8Ua2KvLTzIUhJTmHeNjP+9uNWR1ZTTon7DfunYdZlhzhcygzd3g9c6+6uv7X1A
         cFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686724970; x=1689316970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmdEkfLeOgGxB3Q9AIBuyne+hWdSajk51LvARVCqqic=;
        b=TeZaeLd6akPXSwsJmgC/f0+I0FDjtGBJWghA/1VPUTwyo70T1fVmp48vJHs41MMjeU
         Qu9WL/UatFer+yzcbrNDkMZ7BqGV0tU3an6KAz2N729eEGquk2YbzLgKe+2P/at7fbx2
         QCa8V6oZy7rYConIKeXCJx3lzdMcSXyhApBvZhbu0Hb2uAiRt0zq0NeJz2WDeUqXLj9N
         AWKhyd1L8df8LVs0OiYgGNdwIkZJufoRSnB5Uk6ZNsR8PXrFSn+tovZhbPfwhVghbINB
         Ex8ohdHLj0wbM4ws5Wz7ocafmnYUS0UorBLmJSRcAV/HWTqxdZmVfa2wqd0rhyHSmydM
         34Gw==
X-Gm-Message-State: AC+VfDw7mH6SdqRKWglSaVdVQ8KnHlsUarv3raVR6VsQ7UJ6JGkkTM5u
	iN+AgsaT5DfMJuJdnjza9Z4=
X-Google-Smtp-Source: ACHHUZ6TYA0Ii1kImtzYdAbRoLNit9gVczXVEMxUjSMRl8RC/73ZOWvWsBHLwgdfFVWQ0ksjSQy/xg==
X-Received: by 2002:a05:6000:46:b0:301:8551:446a with SMTP id k6-20020a056000004600b003018551446amr10343725wrx.2.1686724970365;
        Tue, 13 Jun 2023 23:42:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c219100b003f18b942338sm16490823wme.3.2023.06.13.23.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 23:42:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Jun 2023 08:42:47 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [RFC] fprobe call of rethook_try_get faults
Message-ID: <ZIlhZ6gbhfvmZP2r@krava>
References: <ZICzdpvp46Xk1rIv@krava>
 <20230613174844.4d50991d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613174844.4d50991d@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 05:48:44PM -0400, Steven Rostedt wrote:
> On Wed, 7 Jun 2023 09:42:30 -0700
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > I can't really reliable reproduce this, but while checking the code, I wonder
> > we should call rethook_free only after we call unregister_ftrace_function like
> > in the patch below
> 
> Yeah, I think you're right!
> 
> > 
> > jirka
> > 
> > 
> > ---
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
> 
> The above only waits for RCU to finish and then starts to free rethook.
> 
> This also means that something could be on the trampoline already and was
> preempted. It could be that this code path gets preempted. Anyway, I don't
> see how freeing rethook is safe before disabling all users.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

thanks, I'll send formal patch

jirka

> 
> -- Steve
> 
> 
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

