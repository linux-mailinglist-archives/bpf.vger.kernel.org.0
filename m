Return-Path: <bpf+bounces-2184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F9728C4A
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 02:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3411C20F0C
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 00:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91567E5;
	Fri,  9 Jun 2023 00:14:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D683163
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 00:14:03 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0362D68;
	Thu,  8 Jun 2023 17:14:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b00ecabdf2so2698305ad.2;
        Thu, 08 Jun 2023 17:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686269641; x=1688861641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TsTE3qmxIV7pG9azb/NVqbAFzY56xIALD3o7FLY1GW8=;
        b=XjnlrHuVLqvBaR6lTNTwM/UYSJ4Z0+uyzIaJixshSWSguI3Dx77ZE6c33YZVD7UB//
         yaXNDXgjPX+uIP8KPtW7Izj/t5NTp78Og9Jzt8TZlT6qjHgoMzxQXYw6U9D53Fr2WZfR
         w19lMJcknE4ScXne3h44D93yhSXgWfDTjlEiXiiW/qfLqEXxIa3bZ+AmO+mUa7JT/qZ2
         yoHhYQsNTwgo1TdmJSKwI7vRgl1HpzrwAIFHFyQi518bu9t0L/wfPzfaZGSKCtB2c8P8
         G8p1y9UQJ+8eBbCkRAiaY5xN5nsm7KuNge+qS186ModIPFBUk+/zfo4ci/2YXmKJBu3w
         WmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686269641; x=1688861641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsTE3qmxIV7pG9azb/NVqbAFzY56xIALD3o7FLY1GW8=;
        b=LqApAMJrnsuIlg9HqBsLwNNL0ou1SbtjrIZuIj/tBKeAiz4QpozwMSJYSB5DV1pCF3
         nJwC00fB4m5z+H60MoCF7yf6hkgc+rLB8GeZ1FhYlkXzmm80Wq+KNL3iMUMbCCYqpdT2
         /C4t9UpR/o7T4UrEEj24m5PfW1GAvSq5uLvSvAFlsWHPZyl02Q1kVOqG4JGaqzFZKDct
         LLCp9J0XQxMfbOhgrmAk01MxsCOntJVSgXwtLn9HBBSt+VpoeXrxpb9AEn4bWd8L8BDH
         1c2PXURXIU7yJNBLxnE+DQeVcfnc71vZWU4sO6T9Xk2T9P0Ns/CwbhqkPzL4s8URlZR2
         pziQ==
X-Gm-Message-State: AC+VfDw0SbXURzcQWP2lp0pqVJ9PKn1QuCg0C4q1j8S6dGLmrJW4bli2
	Lk9wPlC2QoSRftlTaxWUi7c=
X-Google-Smtp-Source: ACHHUZ4Mh9UGZY5QhTCUEZsaIgVIl2TyYkb9IKjwX68B38is0xZbxtvRI2M8Ce+jngvNWl6Xif3EKw==
X-Received: by 2002:a17:903:44c:b0:1b2:43a5:a5e5 with SMTP id iw12-20020a170903044c00b001b243a5a5e5mr7407916plb.34.1686269641307;
        Thu, 08 Jun 2023 17:14:01 -0700 (PDT)
Received: from krava (c-67-160-222-115.hsd1.ca.comcast.net. [67.160.222.115])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902bd0500b00186a2274382sm1968478pls.76.2023.06.08.17.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 17:14:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 8 Jun 2023 17:13:57 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <ZIJuxc34CBu/zpuN@krava>
References: <20230608212613.424070-1-jolsa@kernel.org>
 <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
 <20230608192748.435a1dbf@gandalf.local.home>
 <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 08, 2023 at 04:55:40PM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 8, 2023 at 4:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 8 Jun 2023 15:43:03 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > On Thu, Jun 8, 2023 at 2:26 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > >
> > > > hi,
> > > > when ftrace based tracers we need to cross check available_filter_functions
> > > > with /proc/kallsyms. For example for kprobe_multi bpf link (based on fprobe)
> > > > we need to make sure that symbol regex resolves to traceable symbols and
> > > > that we get proper addresses for them.
> >
> > I forgot, what was the problem with doing the above?
> 
> More code, more memory, more CPU to parse all the text files. Parsing
> kallsyms is quite expensive, so avoiding this would be great.

yes, reading both kallsyms and available_filter_functions parsing often
shows up in perf profiles

> 
> >
> > > >
> > > > Looks like on the last last LSF/MM/BPF there was an agreement to add new
> > > > file that will have available_filter_functions symbols plus addresses.
> > > >
> > > > This RFC is to kick off the discussion, I'm not sure Steven wants to do
> > > > that differently ;-)
> >
> > I'm not totally against this, but I'd like to know the full issue its
> > solving. Perhaps I need to know more about what is being done, and what is
> > needed too.
> 
> There are BPF tools that allow user to specify regex/glob of kernel
> functions to attach to. This regex/glob is checked against
> available_filter_functions to check which functions are traceable. All
> good. But then also it's important to have corresponding memory
> addresses for selected functions (for many reasons, e.g., to have
> non-ambiguous and fast attachment by address instead of by name, or
> for some post-processing based on captured IP addresses, etc). And
> that means that now we need to also parse /proc/kallsyms and
> cross-join it with data fetched from available_filter_functions.
> 
> All this is unnecessary if avalable_filter_functions would just
> provide function address in the first place. It's a huge
> simplification. And saves memory and CPU.
> 
> >
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > >
> > > > ---
> > > > Adding new available_filter_functions_addrs file that shows all available
> > > > functions (same as available_filter_functions) together with addresses,
> > > > like:
> > > >
> > > >   # cat available_filter_functions_addrs | head
> > >
> > > nit: can we have some more succinct name, like "traceable_funcs" or
> >
> >
> > It's to match avaliable_filter_functions
> 
> it's minor, I'm fine with whatever name, I'm searching for it in my
> history every single time anyways :)
> 
> >
> > Another way is to add a tracing option to make the address show up in the
> > available_filter_functions file. That would be my preferred choice.
> >
> >   echo 1 > options/available_filter_addrs
> >
> > Or something like that.
> 
> This would modify behavior for entire system, right? I think this is
> very bad. Just because one application is aware of this option and
> wants to turn this on, doesn't mean that all other applications that
> might also use available_filter_functions should immediately break on
> that machine.
> 
> Please, let's have a separate file. There is no downside to that.

+1 for file, AFAIU the option would change that globaly so we could race
with another app and break each other

jirka

