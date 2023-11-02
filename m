Return-Path: <bpf+bounces-13924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B254E7DEE57
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B51281A76
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4077490;
	Thu,  2 Nov 2023 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPhOH9fc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48120F9;
	Thu,  2 Nov 2023 08:50:10 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EC212C;
	Thu,  2 Nov 2023 01:50:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32fb190bf9bso24261f8f.1;
        Thu, 02 Nov 2023 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698915007; x=1699519807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yv7JujbLaP4o6hSsKOV57zb9TN8J85KbDLi3JdO3f/s=;
        b=EPhOH9fcusYcqopUs0R93No46bvdzgvLKTj3iVsSMPu6OOfVLkRNUFIeOfuOAJ8ro8
         naql77uzAPHbc6hMUFdXdqx5RJmUtmu71qw8q/EEBdYZ88H7cZKj9PVtdctijKo7ER3O
         D0PDIKYgOsuDB3tsIDgYRLhEvO+VkEyOx6oZqstRMHxvhqPSZy0NKNrosQrxLU2E5fov
         B8j/CPlIdG5zdeDd4PCWM8CD5AJokQPZcDet55S6HTUAiLCBqXSUOJrG7wwhn8750b0q
         pF4MrcwoeOay+tn1ZYqhFWPdbu3BudBdi/y7QHjwARpDNKvBH+sPe+w+Y47WqFG6ZPgs
         b8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915007; x=1699519807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yv7JujbLaP4o6hSsKOV57zb9TN8J85KbDLi3JdO3f/s=;
        b=A9gI6e5cgpXHxzgTirfYHjCgRC32Ovx9uLWpNdfHOq/XRHkw41/cBUDCvZcH1wIfam
         gbYr7h8m/rmJ3xOEEhlUA8y3m4ZzVxwwBjScJklGrIe5x8we8iRgTAK8XYpBaw4eohZ4
         nd2z2FBX7qbT4tMV2UMgU20+ACMsadMGGQOrzbSo3kYtCuI3tSyWxjaCEF5nTerKwb3h
         K/WXypau9fm22OyQY5l4pWws21TuXhbleBrHvop7YMGNcZIwAyL4FhYBqjlw0un9ipPC
         +utO8My2sHkP7IEhT0RxJeQwzmpfgfk0NyxbY5vg0K0BlZXh0HmkiRYi7a/kgs8kWz3s
         Euag==
X-Gm-Message-State: AOJu0YwmJe7wvlkh4wPWy9G72pUWKyKjTWhwVPSJHqLiSejo8j1aBzvJ
	8PH7f384zRTLvssfI3+YBeI=
X-Google-Smtp-Source: AGHT+IHbzB2L2tJyDeKxMrCqoZyo8l1gQNXHKEUawAhrJ+wLyhJsAc38PJ+/ORcpVT51ZZPVoLdzpQ==
X-Received: by 2002:a05:6000:156d:b0:32d:a366:7073 with SMTP id 13-20020a056000156d00b0032da3667073mr6805024wrz.14.1698915007132;
        Thu, 02 Nov 2023 01:50:07 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d4a85000000b0032fa66bda58sm1718607wrq.101.2023.11.02.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 01:50:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Nov 2023 09:50:05 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] ftrace_test_recursion_trylock behaviour
Message-ID: <ZUNivSK2brywL0J6@krava>
References: <ZUKLnmYyHpthlMEE@krava>
 <20231101134556.5d4a46c3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101134556.5d4a46c3@gandalf.local.home>

On Wed, Nov 01, 2023 at 01:45:56PM -0400, Steven Rostedt wrote:
> On Wed, 1 Nov 2023 18:32:14 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > hi,
> > I'm doing some testing on top of fprobes and noticed that the
> > ftrace_test_recursion_trylock allows caller from the same context
> > going through twice.
> > 
> > The change below adds extra fprobe on stack_trace_print, which is
> > called within the sample_entry_handler and I can see it being executed
> > with following trace output:
> > 
> >            <...>-457     [003] ...1.    32.352554: sample_entry_handler:
> > Enter <kernel_clone+0x0/0x380> ip = 0xffffffff81177420 <...>-457
> > [003] ...2.    32.352578: sample_entry_handler_extra: Enter
> > <stack_trace_print+0x0/0x60> ip = 0xffffffff8127ae70
> > 
> > IOW nested ftrace_test_recursion_trylock call in the same context
> > succeeded.
> > 
> > It seems the reason is the TRACE_CTX_TRANSITION bit logic.
> > 
> > Just making sure it's intentional.. we have kprobe_multi code on top of
> > fprobe with another re-entry logic and that might behave differently based
> > on ftrace_test_recursion_trylock logic.
> 
> Yes it's intentional, as it's a work around for an issue that may be
> cleared up now with Peter Zijlstra's noinstr updates.
> 
> The use case for that TRACE_CTX_TRANSITION is when a function is traced
> just after an interrupt was triggered but before the preempt count was
> updated to let us know that we are in an interrupt context.
> 
> Daniel Bristot reported a regression after the trylock was first introduced
> where the interrupt entry function was traced sometimes but not always.
> That's because if the interrupt happened normally, it would be traced, but
> if the interrupt happened when another event was being traced, the recursion
> logic would see that the trace of the interrupt was happening in the same
> context as the event it interrupted and drop the interrupt trace. But after
> the preempt count was updated, the other functions in the interrupt would be
> seen. This led to very confusing trace output.
> 
> The solution to that was this workaround hack, where the trace recursion
> logic would allow a single recursion (the interrupt preempting another
> trace before it set preempt count).
> 
> But with noinstr, there should be no more instances of this problem and we
> can drop that extra bit. But the last I checked, there were a few places
> that still could be traced without the preempt_count set. I'll have to
> re-investigate.

I see, so I'll keep in mind that it could change in the future

thanks,
jirka

