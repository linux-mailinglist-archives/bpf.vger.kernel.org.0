Return-Path: <bpf+bounces-10803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE8C7AE195
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C21A528162F
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E972511E;
	Mon, 25 Sep 2023 22:14:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866124204;
	Mon, 25 Sep 2023 22:14:40 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C91EBC;
	Mon, 25 Sep 2023 15:14:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso12096031e87.1;
        Mon, 25 Sep 2023 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695680076; x=1696284876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iM72w41jJ0uTcmpakwU36eusGXW9uEpXtWiPgSR0LzQ=;
        b=LEiIUym7FsC+YOEQVJzf7uTcUmJ2U2nOqOL6eDI7Ot+gtBculDvwbnp7izTY2LZa/w
         MbkOzDLPbaI49Xr8QBXOWBPhqI7BHvQvpWbFQ9n79oyylvWLqRbY2mx7k6dBnr+XvYbL
         mYEsnekwTVfNaaaO2X44+eRuXpy9d6VPg9SQGQf19R5qt7fD1sMHVo3pCe5wB7eFL2lK
         xpykcov5iNbZOUcVyaMJ5jz+okI+HQI80UjvTY0MzR0PpHDZn6Ep3RoF0BRmuIx8cqlE
         GRU9uTIozrsJVHubqI8AtZWioiVDOhyq0F2eSq5Cwmve4FQn9vC6WefYZ+a1z4WOnLud
         helA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695680076; x=1696284876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM72w41jJ0uTcmpakwU36eusGXW9uEpXtWiPgSR0LzQ=;
        b=UlyDTuCLvXpnkbtS9NtC4oDVbvFZscvdkTi4MYoCLen4vJ/KZmX1gvkDHYroNaLgGP
         ffERKAXTgFw/YlnBzBQ1D7UjnM0wiBPUNQoK5tJ194hehUEuU5H2Tet6wqLHqi5HB0YA
         SgbMznRfHt36uOjX5xBHrGzcPPta0r69LNpyDxmbS3U+EP8VM1n1cGhyXTW1qDLo/bD3
         /61HZf5Sm/wwwAZTQNGMYZLCAFIkSJpTRTth9oYkEzlxTRhdNKSqimVInj4JbHz7LbrO
         5+Lv+ZJKsliuBeSDA5hzecWH5CVhaaBzALE2MXUVuuWqXr9sUxzPqjY0Kz7tcei9LGT+
         ucKA==
X-Gm-Message-State: AOJu0YzfsxnVWqlX/uQmbM6qwyuzoe7o8R5UrdzNGNysYgHp8GsnZ5Q5
	Hf1lhEtiR57BkgXGarmbiLE=
X-Google-Smtp-Source: AGHT+IFKSGyuAtyHJuuBvay/ET7E6hG1fGFgiObpPOPHuDfnTn3nl26nHyxIjNZ8o2oPTofMIUtzCQ==
X-Received: by 2002:a05:6512:b9b:b0:500:8c19:d8c6 with SMTP id b27-20020a0565120b9b00b005008c19d8c6mr7453171lfv.58.1695680076324;
        Mon, 25 Sep 2023 15:14:36 -0700 (PDT)
Received: from krava ([83.240.61.244])
        by smtp.gmail.com with ESMTPSA id e9-20020a50ec89000000b0052c9f1d3cfasm6005501edr.84.2023.09.25.15.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:14:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 Sep 2023 00:14:33 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 04/12] fprobe: Use ftrace_regs in fprobe entry handler
Message-ID: <ZRIGSTTTYADzP7QU@krava>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
 <169556259571.146934.4558592076420704031.stgit@devnote2>
 <ZRFj97DJtbXc4naO@krava>
 <20230925211515.41d26a160c546c7bce08ac64@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925211515.41d26a160c546c7bce08ac64@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 09:15:15PM +0900, Masami Hiramatsu wrote:
> Hi Jiri,
> 
> On Mon, 25 Sep 2023 12:41:59 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Sun, Sep 24, 2023 at 10:36:36PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > > on arm64.
> > > 
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Acked-by: Florent Revest <revest@chromium.org>
> > 
> > I was getting bpf selftests failures with this patchset and when
> > bisecting I'm getting crash when running on top of this change
> 
> Thanks for bisecting!
> 
> > 
> > looks like it's missing some of the regs NULL checks added later?
> 
> yeah, if the RIP (arch_rethook_prepare+0x0/0x30) is correct, 
> 
> void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)
> 
> RSI (the 2nd argument) is NULL. This means fregs == NULL and caused the crash.
> I think ftrace_get_regs(fregs) for the entry handler may return NULL.
> 
> Ah, 
> 
> @@ -182,7 +182,7 @@ static void fprobe_init(struct fprobe *fp)
>  		fp->ops.func = fprobe_kprobe_handler;
>  	else
>  		fp->ops.func = fprobe_handler;
> -	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
> +	fp->ops.flags |= FTRACE_OPS_FL_SAVE_ARGS;
>  }
>  
>  static int fprobe_init_rethook(struct fprobe *fp, int num)
> 
> This may cause the issue, it should keep REGS at this point (this must be done in
> [9/12]). But after applying [9/12], it shouldn't be a problem... 
> 
> Let me check it again.

that helped with the crash, I'll continue bisecting to find out
where it breaks the tests

thanks,
jirka

