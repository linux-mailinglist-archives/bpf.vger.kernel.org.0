Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D9537AB5
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiE3Mik (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 May 2022 08:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiE3Mij (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 08:38:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9A59944;
        Mon, 30 May 2022 05:38:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b8so5383355edf.11;
        Mon, 30 May 2022 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8lA8kcruOzlM1c7pq+ZR6pniIlOpBIdn80j1dKVz8U4=;
        b=PF63nDMGfTMDNFQqOUSr26c2ZuAP3I27IbQQ5eH6wyiYq/e5HPbg5K1rnwVKces/hh
         X1LUk8zwDem0HF6wwQLUmTafQKoUBpcuKCcsGThsRnv2wiMe4fhpADbeL7PmFILNiDPQ
         WYvtvW49OJWMvStYy2FsckmjahKDGFrCYtX7FsRsdIumRt+wnfzba6iXLZRFwadCzDBe
         Y3QfXPOJwi+SHF27bMm2Xp7Y3ajLzsTja+TQmcxV5+A3NKJBEIj0jwai6cBzDjbC6prT
         yH6/wnOosowaOcCX431XRSystdVTZJQUvzD2e9aoBdRzjfipLHfq5vbEBd5/VsqEBjxt
         mTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8lA8kcruOzlM1c7pq+ZR6pniIlOpBIdn80j1dKVz8U4=;
        b=xB44Dmuk8GW07GtWi49lK3QAub1cFH7C6L4PEnGIfu5SHWK6ksZk5cuqW84kV+SIEW
         Z1GoBVaOvDAW35c/uXPn7HESwlzVaJ7wfE7DXTNEVD9+n5ZVADbM+sE7mmSVJcIpKZre
         fUsuwTqizPDHPNQiiUu81qCEFfUMOuTwOKatSQQn8U77CxIvzbo5uMpEbGgPBXjNVVo/
         zV0n/I8i7/3GIlQrEPqkhEdWqcU37W/SaV8frzm56vgIz/RzCiGbXSbJOkns10uwYbsr
         W0vNL1uvrqrjh+ilCUw9597duNDi/4thIaWY543DcUMMWT5uUSCf2/kJlaOf612pGKt7
         Hjaw==
X-Gm-Message-State: AOAM530YFCMmJKRjc4vaK9gQyfXIRE5sGh0d8gVF80rwtfiNT/cy6tP8
        jpalK6cIbGccYHk+3W86Jzs=
X-Google-Smtp-Source: ABdhPJxKdWl/ROWX18VWp01sv/OfIJv7wTIvCxrSCUnduX3kc57+VKZy9ZxTlCVMVek5DgeF1wIvUQ==
X-Received: by 2002:a05:6402:330:b0:42d:cd47:89f3 with SMTP id q16-20020a056402033000b0042dcd4789f3mr7282038edw.301.1653914314518;
        Mon, 30 May 2022 05:38:34 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906a40c00b006f3ef214e53sm3945015ejz.185.2022.05.30.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 05:38:34 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 30 May 2022 14:38:31 +0200
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <YpS6x0g8AimeaAw9@krava>
References: <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
 <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
 <20220509142203.6c4f2913@gandalf.local.home>
 <20220510181012.d5cba23a2547f14d14f016b9@kernel.org>
 <20220510104446.6d23b596@gandalf.local.home>
 <20220511233450.40136cdf6a53eb32cd825be8@kernel.org>
 <20220511111207.25d1a693@gandalf.local.home>
 <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
 <Yo4eWqHA/IjNElNN@FVFF77S0Q05N>
 <20220530100310.c22c36df4ea9324cb9cb3515@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530100310.c22c36df4ea9324cb9cb3515@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 30, 2022 at 10:03:10AM +0900, Masami Hiramatsu wrote:
> (Cc: BPF ML)
> 
> On Wed, 25 May 2022 13:17:30 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Thu, May 12, 2022 at 09:02:31PM +0900, Masami Hiramatsu wrote:
> > > On Wed, 11 May 2022 11:12:07 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > On Wed, 11 May 2022 23:34:50 +0900
> > > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > 
> > > > > OK, so fregs::regs will have a subset of pt_regs, and accessibility of
> > > > > the registers depends on the architecture. If we can have a checker like
> > > > > 
> > > > > ftrace_regs_exist(fregs, reg_offset)
> > > > 
> > > > Or something. I'd have to see the use case.
> > > > 
> > > > > 
> > > > > kprobe on ftrace or fprobe user (BPF) can filter user's requests.
> > > > > I think I can introduce a flag for kprobes so that user can make a
> > > > > kprobe handler only using a subset of registers. 
> > > > > Maybe similar filter code is also needed for BPF 'user space' library
> > > > > because this check must be done when compiling BPF.
> > > > 
> > > > Is there any other case without full regs that the user would want anything
> > > > other than the args, stack pointer and instruction pointer?
> > > 
> > > For the kprobes APIs/events, yes, it needs to access to the registers
> > > which is used for local variables when probing inside the function body.
> > > However at the function entry, I think almost no use case. (BTW, pstate
> > > is a bit special, that may show the actual processor-level status
> > > (context), so for the debugging, user might want to read it.)
> > 
> > As before, if we really need PSTATE we *must* take an exception to get a
> > reliable snapshot (or to alter the value). So I'd really like to split this
> > into two cases:
> > 
> > * Where users *really* need PSTATE (or arbitrary GPRs), they use kprobes. That
> >   always takes an exception and they can have a complete, real struct pt_regs.
> > 
> > * Where users just need to capture a function call boundary, they use ftrace.
> >   That uses a trampoline without taking an exception, and they get the minimal
> >   set of registers relevant to the function call boundary (which does not
> >   include PSTATE or most GPRs).
> 
> I totally agree with this idea. The x86 is a special case, since the
> -fentry option puts a call on the first instruction of the function entry,
> I had to reuse the ftrace instead of swbp for kprobes.
> But on arm64 (and other RISCs), we can use them properly.
> 
> My concern is that the eBPF depends on kprobe (pt_regs) interface, thus
> I need to ask them that it is OK to not accessable to some part of
> pt_regs (especially, PSTATE) if they puts probes on function entry
> with ftrace (fprobe in this case.)
> 
> (Jiri and BPF developers)
> Currently fprobe is only enabled on x86 for "multiple kprobes" BPF
> interface, but in the future, it will be enabled on arm64. And at
> that point, it will be only accessible to the regs for function
> arguments. Is that OK for your use case? And will the BPF compiler

I guess from practical POV registers for arguments and ip should be enough,
but whole pt_regs was already exposed to programs, so people can already use
any of them.. not sure it's good idea to restrict it

> be able to restrict the user program to access only those registers
> when using the "multiple kprobes"?

pt-regs pointer is provided to kprobe programs, I guess we could provide copy
of that with just available values

jirka
