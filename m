Return-Path: <bpf+bounces-2446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0FD72D06E
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808A01C209DF
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102FC2C7;
	Mon, 12 Jun 2023 20:26:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79F8833
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 20:26:14 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B135E19B;
	Mon, 12 Jun 2023 13:25:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-97881a996a0so847463366b.0;
        Mon, 12 Jun 2023 13:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686601556; x=1689193556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdv3vzNPkrrapPOhx9OkW0gebiaW56nR0p2AcI7Bl0s=;
        b=YtKUkr7aYmpsscebasGh8jqgUj5/RFK5S0z5Vojx92Ai+P7xlRaZJZZw08ZgOJaAh9
         tYprzwpmWpRnaVbG5+ooVLNyL6fKx9LI46l6r/JZ7IrIUwgqjc6R4onX0se8NTB9XYva
         /YFRBczWG//nlp3Vw71eUQ01RVjG8xcrP305D6e2MJyt6nP6WoLY+u/AzPF9e3ZwrHh/
         0Q7k9wqT1FyfVOMfj5mD5WxppPbYiFp2j7gf85nDVb2DcYf+rDNKIN72McnVeSfu3hZY
         u5dVqvCwxgKgZ0sxbn+8TgjY1raC8UUQF/go2LnfZOkTkoCgwVXb7/V0IU88eq4LwdcA
         MDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686601556; x=1689193556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdv3vzNPkrrapPOhx9OkW0gebiaW56nR0p2AcI7Bl0s=;
        b=Pb8q7FOoOEMxYeAwugMbkllq8bzn3+GmLzGZlJJxG4tk7soQB3cXI1FHMIc6VckzLQ
         4PCvJxVEuIilWoiBjTPQacD4b9Lqqi2ZxMPPYOMgoB/Y6U/KSKqseIxSzha3tPCCxfM9
         EA0Tm2FXdNxfYyuU9WOL+peZiNydPGcxd23UoX3RexNcpJ+Z18VRgBGlMESfkRqiKx0e
         Zt1aeklECtgwks2l+h1eUmWuj/23LBFI4ocUKNenlRAxw3bfYdU8eFTV4m1vfzbHPEWJ
         RUcR3nQrhDBp5Q8XqdTaL1l/wqPlsWsAPJfRANWa+ne5CEQ0vnHNiiJRnwprk/W8nkX3
         2Z3Q==
X-Gm-Message-State: AC+VfDw7ewjLVM1gkP/JQLkwTTigWRqMQhaAC26BDELtYjk1npa/dz34
	XmWb2ocvOa5gPN09+Z/umk0=
X-Google-Smtp-Source: ACHHUZ68tbqVprHJAzbsOB+yLTYiQ1Lh4TimLjN9ifwSPBOKlpqNOeM8ktKZXpxvMRzjr/SWYGnNKg==
X-Received: by 2002:a17:907:728b:b0:97d:a87a:f4db with SMTP id dt11-20020a170907728b00b0097da87af4dbmr8539757ejc.66.1686601555829;
        Mon, 12 Jun 2023 13:25:55 -0700 (PDT)
Received: from krava ([83.240.63.222])
        by smtp.gmail.com with ESMTPSA id sa1-20020a170906eda100b009745a6d1b37sm5574871ejb.202.2023.06.12.13.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:25:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Jun 2023 22:25:52 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yonghong Song <yhs@meta.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <ZId/UL/iujOdgel+@krava>
References: <20230611130029.1202298-1-jolsa@kernel.org>
 <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
 <20230611225407.3e9b8ad2@gandalf.local.home>
 <20230611225754.01350a50@gandalf.local.home>
 <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
 <20230612110222.50c254f3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612110222.50c254f3@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 11:02:22AM -0400, Steven Rostedt wrote:
> On Mon, 12 Jun 2023 07:49:53 -0700
> Yonghong Song <yhs@meta.com> wrote:
> 
> > I am actually interested in how available_filter_functions_addrs
> > will be used. For example, bpf_program__attach_kprobe_multi_opts()
> > can already take addresses from kallsyms. How to use
> > available_filter_functions_addrs to facilitate kprobe_multi?

the problem is that we need to do 2 passes:

 - through available_filter_functions and find out if the function is traceable
 - through /proc/kallsyms to get the address for traceable function

having available_filter_functions symbols together with addresses allow
us to skip the kallsyms step

and we are ok with the address in available_filter_functions_addr not being the
function entry, because kprobe_multi uses fprobe and that handles both entry and
patch-site address properly

> > Do we need to change kernel APIs? It would be great at least we
> > got a RFC patch to answer these questions.
> 
> I agree, having that information would also be useful to me.
> 
> Jiri? Andrii?

so we have 2 interfaces how to create kprobe_multi link:

  a) passing symbols to kernel

     1) user gathers symbols and need to ensure that they are
        trace-able -> pass through available_filter_functions file

     2) kernel takes those symbols and translates them to addresses
        through kallsyms api

     3) addresses are passed to fprobe/ftrace through:

         register_fprobe_ips
         -> ftrace_set_filter_ips

  b) passing addresses to kernel

     1) user gathers symbols and needs to ensure that they are
        trace-able -> pass through available_filter_functions file

     2) user takes those symbols and translates them to addresses
       through /proc/kallsyms

     3) addresses are passed to the kernel and kernel calls:

         register_fprobe_ips
         -> ftrace_set_filter_ips


The new available_filter_functions_addrs file helps us with option b),
because we can make 'b 1' and 'b 2' in one step - while filtering traceable
functions, we get the address directly.

I tested the new available_filter_functions_addrs changes with some hacked
selftest changes, you can check it in here [1].

I assume Jackie Liu will send new version of her patchset [2] based on this
new available_filter_functions_addrs file.

I think we should have these changes coming together and add some perf
measurements from before and after to make the benefit apparent.

jirka


[1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/avail_addrs&id=fecaeeaf40bae034715ab2e9a46ca1dc16371e8e
[2] https://lore.kernel.org/bpf/20230526155026.1419390-1-liu.yun@linux.dev/#r

