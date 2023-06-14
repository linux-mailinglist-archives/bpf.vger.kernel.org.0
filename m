Return-Path: <bpf+bounces-2591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814873016F
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AAD2814CC
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC14DDDC4;
	Wed, 14 Jun 2023 14:14:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BEAC137
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 14:14:25 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88F2CD;
	Wed, 14 Jun 2023 07:14:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9745d99cfccso125687566b.1;
        Wed, 14 Jun 2023 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686752062; x=1689344062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZcc1N+pfWDP9EyHMZ8HVe/V78CMvOZrkT7dGeTorW0=;
        b=lRelaGos+jd5arMyCLOFQs5LM5DoQgXvA6qkSU8/8bb5j7QTCdDcjrFAzA5+09H8va
         Vj7IxMejFnY3Wonw15taxTIZ7FhIbq4g6J/kbiKvHzZg/x4JC/Ca0ksRK9RD8k80HCFg
         Q5CMj8tvbCuzJSrpYk+jMRlsEWw4++lg+xaXbXjG+1nEEkPAeWX3W3sWRGeKkF3q1V+S
         FB8z7px0eY6vTAlJp8z+C5ebYA13En7kfjZ2v+lq9laZCZciEHy2MzTCdaFp4MrLMPNb
         5pQLSkpVcFQLpacWxrwndWmA78B/d9LGuYXRtiVKpOJnapEu1A3ca41O2vDQGhbwsDgq
         cnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752062; x=1689344062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZcc1N+pfWDP9EyHMZ8HVe/V78CMvOZrkT7dGeTorW0=;
        b=goazEibIucGrvD4g52KKI/TyYL7nzrfCDo5CSjQoha75dPj5D4UUAbydLXs/YyvCrO
         7NAL8bgw7ynwahAZWGo3KdJEXVJRl6h0/CzlCXuzGatrfeYC6VoZR6/xM41LUQ9Lu8w2
         opEv94c/I9dHmNJAQxYoyvDF1YrNiuHU3kFpSwpCwpMdSm+KpfRACMI9DCvDOyDDcrL7
         E+s0EpvYB0Nz39QjJr4zP2gLex3lAX/i2CylyuWd9uRQfTMFUs/QThs16fx7OOfxIwl+
         J1SDjeK67SHvM8UrG6FagUnBScCQ0fTS1YoEDot7IPjeMAeCh1/h4qirvSe5x/MT7uk0
         IVog==
X-Gm-Message-State: AC+VfDyYlTFshOGXV9tmynu/oMYF3X7y1o5IA146JS+j+o5ji94KpibJ
	uZALsxsUJjcSd+8OxpumHhE=
X-Google-Smtp-Source: ACHHUZ5AOEghS7r/YuBm8qLG9tdWa5T4rDdMOPaDHJ4gyt0FnJMgDbUWn7gXD2yBpY+ahQw+UsIwkw==
X-Received: by 2002:a17:907:7f93:b0:974:218d:c048 with SMTP id qk19-20020a1709077f9300b00974218dc048mr19264188ejc.26.1686752061928;
        Wed, 14 Jun 2023 07:14:21 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e26-20020a1709062c1a00b00974556e50a6sm8103322ejh.114.2023.06.14.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:14:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Jun 2023 16:14:19 +0200
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
Message-ID: <ZInLO4/xly/f+Zk3@krava>
References: <20230611130029.1202298-1-jolsa@kernel.org>
 <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
 <20230611225407.3e9b8ad2@gandalf.local.home>
 <20230611225754.01350a50@gandalf.local.home>
 <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
 <20230612110222.50c254f3@gandalf.local.home>
 <ZId/UL/iujOdgel+@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZId/UL/iujOdgel+@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 10:25:55PM +0200, Jiri Olsa wrote:
> On Mon, Jun 12, 2023 at 11:02:22AM -0400, Steven Rostedt wrote:
> > On Mon, 12 Jun 2023 07:49:53 -0700
> > Yonghong Song <yhs@meta.com> wrote:
> > 
> > > I am actually interested in how available_filter_functions_addrs
> > > will be used. For example, bpf_program__attach_kprobe_multi_opts()
> > > can already take addresses from kallsyms. How to use
> > > available_filter_functions_addrs to facilitate kprobe_multi?
> 
> the problem is that we need to do 2 passes:
> 
>  - through available_filter_functions and find out if the function is traceable
>  - through /proc/kallsyms to get the address for traceable function
> 
> having available_filter_functions symbols together with addresses allow
> us to skip the kallsyms step
> 
> and we are ok with the address in available_filter_functions_addr not being the
> function entry, because kprobe_multi uses fprobe and that handles both entry and
> patch-site address properly
> 
> > > Do we need to change kernel APIs? It would be great at least we
> > > got a RFC patch to answer these questions.
> > 
> > I agree, having that information would also be useful to me.
> > 
> > Jiri? Andrii?
> 
> so we have 2 interfaces how to create kprobe_multi link:
> 
>   a) passing symbols to kernel
> 
>      1) user gathers symbols and need to ensure that they are
>         trace-able -> pass through available_filter_functions file
> 
>      2) kernel takes those symbols and translates them to addresses
>         through kallsyms api
> 
>      3) addresses are passed to fprobe/ftrace through:
> 
>          register_fprobe_ips
>          -> ftrace_set_filter_ips
> 
>   b) passing addresses to kernel
> 
>      1) user gathers symbols and needs to ensure that they are
>         trace-able -> pass through available_filter_functions file
> 
>      2) user takes those symbols and translates them to addresses
>        through /proc/kallsyms
> 
>      3) addresses are passed to the kernel and kernel calls:
> 
>          register_fprobe_ips
>          -> ftrace_set_filter_ips
> 
> 
> The new available_filter_functions_addrs file helps us with option b),
> because we can make 'b 1' and 'b 2' in one step - while filtering traceable
> functions, we get the address directly.
> 
> I tested the new available_filter_functions_addrs changes with some hacked
> selftest changes, you can check it in here [1].
> 
> I assume Jackie Liu will send new version of her patchset [2] based on this
> new available_filter_functions_addrs file.
> 
> I think we should have these changes coming together and add some perf
> measurements from before and after to make the benefit apparent.

FYI I did some perf meassurements and the speedup is not substantial :-\

looks like the symbols resolving to addresses we do in kernel for kprobe_multi
link is more faster/cheaper than I thought 

but still there is 'some' speedup and we will get rid of the extra
/proc/kallsyms parsing, so I think it's still worth it to have the
new file


base:

 Performance counter stats for './test_progs -n 103/1':

       103,423,103      cycles:u
    79,279,231,029      cycles:k
    79,382,694,663      cycles

      18.627593589 seconds time elapsed

       0.025999000 seconds user
      18.323855000 seconds sys


with fix:

 Performance counter stats for './test_progs -n 103/1':

       126,659,572      cycles:u
    77,951,768,179      cycles:k
    78,078,467,451      cycles

      18.651464273 seconds time elapsed

       0.025001000 seconds user
      18.243828000 seconds sys


jirka

