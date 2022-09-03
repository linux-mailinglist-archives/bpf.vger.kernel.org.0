Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4159E5ABF0D
	for <lists+bpf@lfdr.de>; Sat,  3 Sep 2022 15:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiICNLJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Sep 2022 09:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiICNLI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Sep 2022 09:11:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688CC642D4
        for <bpf@vger.kernel.org>; Sat,  3 Sep 2022 06:11:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b44so5948498edf.9
        for <bpf@vger.kernel.org>; Sat, 03 Sep 2022 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=YX9BMI5vGhunHegA1z4rhcT0PH9EqYmqmqhL3jmCoKQ=;
        b=RhiPEf/Uul/yHvVJFDl0CRcxgy4TkZCCer8IytvLer/jXDjtACFp1yn7+FWnCGckt/
         VET7TnkKR1euR8fWp6r3CjIkmxP451Umbx0xVyLHcNagI9HH6OB9oGCK2aZ49etkyOuQ
         PfzZ7eLn90WYz/f6wTHnVKj0F+PAoidZTxPcVYmFV2bbmkNfdKkoFUPPagzct84Uc2hg
         PA08ya/8FwLas08JzT0+wPSuPp2YbAGxgnbqdJ1QpB88MfecWG/TxgwEhn7Dsn19+8BX
         4DLrEQAPD5mFIzmY8IDXU0ub7+K0xEmV4EOk3o7RMmIrEyuUX7PfYF1wYYu+a3a/aLoi
         e/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YX9BMI5vGhunHegA1z4rhcT0PH9EqYmqmqhL3jmCoKQ=;
        b=EuhfOb9Zq0NS1L08oxxjawAOgX4GVP//9CE9lkweLmzQyEUKjhei79l3neHARPVwdg
         Ca+7Whs4y/059FXKKLTE8ozBVjkkr5g9vIdNNZMdfuTWv09FiDs6ST5UhiKhxeRElxLM
         PFdN3pO4lCiOBQgLZ1xi0liL/XmZbgHA16lmDoDuWj38c3Rx7pX9bCjmE5M1E94NlCDk
         6BDB4LBVZliFqTmEnKKiUbIYwnEpyOO5WBgNt7oEbutOrY/tc4tKWuatdIhzcks0p+KS
         Ep/OJko9XA98z/qOvtnjKkKLKgSiNLhXDy787NEsyGPVJgfcS6NTQAG7kCzfSiyZEA2n
         oydg==
X-Gm-Message-State: ACgBeo1pG72Hycft2Jkonw6vWlsRX2TV1XihPyLSKFccxhJUGo8K4IfG
        bP6b2BK5cBHZGptiPfzn8Yw=
X-Google-Smtp-Source: AA6agR7xa9qI2rRjXJhwVFSBdHacsbsCO3WLLfmkY7ZUIGjufgL5LW3OdsZ2ucFhejTAp9K3SOpErg==
X-Received: by 2002:a05:6402:90d:b0:443:ef4c:480f with SMTP id g13-20020a056402090d00b00443ef4c480fmr36572881edz.128.1662210664850;
        Sat, 03 Sep 2022 06:11:04 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906301200b0073d6093ac93sm2547688ejz.16.2022.09.03.06.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 06:11:04 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 3 Sep 2022 15:11:02 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv2 bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <YxNSZvmRCyYzfee7@krava>
References: <20220901134150.418203-1-jolsa@kernel.org>
 <20220901134150.418203-3-jolsa@kernel.org>
 <YxHli+6C5rylF3EH@hirez.programming.kicks-ass.net>
 <YxI1EtYjkLaooFm8@krava>
 <YxI7aC4L495CwZWE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxI7aC4L495CwZWE@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 02, 2022 at 07:20:40PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 02, 2022 at 06:53:38PM +0200, Jiri Olsa wrote:
> > > Are you sure you want the notrace x86_64 only?
> > > 
> > > That is, perhaps something like this...
> > > 
> > > +#ifdef CONFIG_X86_64
> > > +#define BPF_DISPATCHER_ATTRIBUTES	   __attribute__((patchable_function_entry(5)))
> > > +#else
> > > +#define BPF_DISPATCHER_ATTRIBUTES
> > > +#endif
> > > +
> > >  #define DEFINE_BPF_DISPATCHER(name)					\
> > > +	notrace BPF_DISPATCHER_ATTRIBUTES				\
> > >  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
> > > 
> > 
> > that's also an option.. but I don't this it's big deal that the function
> > is traceable on other arches, because the dispatcher image is generated
> > only on x86, so no other arch is touching that function entry, so it's
> > safe for ftrace to attach
> 
> It just seems like a pointless difference.

ok, I'll use notrace as default

> 
> From a code-gen POV you don't strictly need the notrace; without it
> it'll generate:
> 
> bpf_dispatcher_name_func:
> 	nop
> 	nop
> 	nop
> 	nop
> 	nop
> 	call __fentry__
> 	RET
> 
> It'll just function 'weird', but it'll 'work'.

I'll use notrace for all archs as you suggests, so there's less
surprise in future if some other arch implements dispatcher image

thanks,
jirka
