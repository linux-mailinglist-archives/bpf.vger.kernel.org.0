Return-Path: <bpf+bounces-8137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E617781FED
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 22:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08B5280F73
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895446FCF;
	Sun, 20 Aug 2023 20:39:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7823D4
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 20:39:04 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E824680;
	Sun, 20 Aug 2023 13:35:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c3df710bdso444786f8f.1;
        Sun, 20 Aug 2023 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692563683; x=1693168483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zB1xiQc5Oed0ZYgipibvdeoQBgtJ6iuUAyN6A/7wco=;
        b=bgrJ3XaE1frdvL97Bmgr3FmqTq8aRBX0tMhv7wtsR7b37LoRROybd+/WDhOqikfPX6
         MHWZczIpLBgz8biHKdIeoJcbw0IB5xLjj+xpwxmtpEj3SO1RGmzsqUYc7D960wOLliQ2
         IXB6cPjYixbFljB6iWF+xUM/jU3bO/V415qkuAPn0pW3r2oqVdfKfeSH2JvdtlozaN67
         ZhBbxHL3MWpeYoGzTTA+8UdoQ2Kzj0NWfuFGG9UvCuHkB4ckBydkDcp68g87ZatgUJhD
         LAY7xhL1KDsMjINKEaHQ8UMX6VBZrNKaLg/i4IkAih3+CgFei5tCBgob6ZRymdhFtgip
         yd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692563683; x=1693168483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zB1xiQc5Oed0ZYgipibvdeoQBgtJ6iuUAyN6A/7wco=;
        b=kI/VE2iKNwAkTNdVKLEMY8AusJ6w7c02DoNop+SRvVytUoNg0b9ZbsMzxeB0z3ZwDA
         SNzyqseW24oSfITR2xAIOPJ7lQ0qH475mK3QqRIx3eKMxlp1BVGEM9iol0/ckvFRdz95
         /dB5uPb/sjUmCNCWN6v2bffJiMdX8+dGVt42A1z5qS8ZgcpuuP0EbkzWzQ6/qEUSphw3
         8zusSKtPwyJsE4U7tY/sAil9Cy3tcTq+rZnPw5MbkDew4yt1OcEa8AyOWbLA445KqdaZ
         Ou9Q+OMukFXJR0NmudffCPxjJ/F0nUF9xi8pSYwPSCO63yvmuzBFP31hUEYUtYkdO/Qg
         WzMA==
X-Gm-Message-State: AOJu0YwHisklUviPoeAUxch1o759tSCxenV1OTXaKm1flG+ASEeK5drl
	N9ajU8aZM4Zhauj92XVXPZc=
X-Google-Smtp-Source: AGHT+IHuPhBgSvr4phlBQzV5Q5db4sPkNhymPKcH8wDywGVQHfaJbsJe5ZW6iS3tGiRSO6Zq6odO+w==
X-Received: by 2002:adf:f291:0:b0:318:c108:67b0 with SMTP id k17-20020adff291000000b00318c10867b0mr3439092wro.48.1692563682769;
        Sun, 20 Aug 2023 13:34:42 -0700 (PDT)
Received: from krava ([83.240.60.227])
        by smtp.gmail.com with ESMTPSA id l4-20020a1709062a8400b00997e00e78e6sm5196847eje.112.2023.08.20.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 13:34:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 20 Aug 2023 22:34:40 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Francis Laniel <flaniel@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <ZOJ44P40bsSpUmYA@krava>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
 <2154216.irdbgypaU6@pwmachine>
 <20230818220537.75ce8210c6a4c80a5a8d16f8@kernel.org>
 <5702263.DvuYhMxLoT@pwmachine>
 <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 10:11:05AM +0900, Masami Hiramatsu wrote:

SNIP

> > > > > > +	func_addr = kallsyms_lookup_name(func);
> > > > > > +	for (i = 0; i < array.size; i++) {
> > > > > > +		struct trace_kprobe *tk_same_name;
> > > > > > +		unsigned long address;
> > > > > > +
> > > > > > +		address = array.addrs[i];
> > > > > > +		/* Skip the function address as we already registered it. */
> > > > > > +		if (address == func_addr)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		/*
> > > > > > +		 * alloc_trace_kprobe() first considers symbol name, so we set
> > > > > > +		 * this to NULL to allocate this kprobe on the given address.
> > > > > > +		 */
> > > > > > +		tk_same_name = alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > > > > > +						  (void *)address, NULL, offs,
> > > > > > +						  0 /* maxactive */,
> > > > > > +						  0 /* nargs */, is_return);
> > > > > > +
> > > > > > +		if (IS_ERR(tk_same_name)) {
> > > > > > +			ret = -ENOMEM;
> > > > > > +			goto error_free;
> > > > > > +		}
> > > > > > +
> > > > > > +		init_trace_event_call(tk_same_name);
> > > > > > +
> > > > > > +		if (traceprobe_set_print_fmt(&tk_same_name->tp, ptype) < 0) {
> > > > > > +			ret = -ENOMEM;

also are we leaking tk_same_name in here?


> > > > > > +			goto error_free;
> > > > > > +		}
> > > > > > +
> > > > > > +		ret = append_trace_kprobe(tk_same_name, tk);
> > > > > > +		if (ret)

and here?

jirka

> > > > > > +			goto error_free;
> > > > > > +	}
> > > > > > +
> > > > > > +end:
> > > > > > +	kfree(array.addrs);
> > > > > > 
> > > > > >  	return trace_probe_event_call(&tk->tp);
> > > > > > 
> > > > > > +error_free:
> > > > > > +	kfree(array.addrs);
> > > > > > 
> > > > > >  error:
> > > > > >  	free_trace_kprobe(tk);
> > > > > >  	return ERR_PTR(ret);
> > > > 
> > > > ---
> > > > [1]: https://github.com/torvalds/linux/blob/
> > > > 57012c57536f8814dec92e74197ee96c3498d24e/tools/perf/util/probe-event.c#L29
> > > > 89- L2993
> > 
> > 
> > 
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

