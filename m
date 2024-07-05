Return-Path: <bpf+bounces-33956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E079289E1
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 15:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E807A1C2410B
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D427514B959;
	Fri,  5 Jul 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAWhIf5v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56352B9B9;
	Fri,  5 Jul 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186699; cv=none; b=FlRa+v6zKjU8sJeXGcyKRvZtDDetqvI3DqKESL6iw13se0WYrncpUAbLgbIyImzQ3lIQUF26gboo9UvMv14SXubgGCVtK4lnLh2g0UK1kWMbdanevElAljyUhES6T3ifOO+NjCsT5U0Oc2yNEKGfouvrhU6I9n4GzsROo6AUgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186699; c=relaxed/simple;
	bh=cWnCrmUJRexOSMDRTpVlcG2Z7kBl2f9gCMlUA9djuec=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQWfBdC2QrPQAWG/XegHrW4pC59rDeCZC0mkeCv7T1T37nUwdSDfmqWzSyjPiMT4J5A4vXSBcfjHhpszcazSUF9UtAJwjdub3o0Z/pbUvzS7/qknkBrJ5XONl1eNMHGQfYQL+1fVMgJMPUQ6FnK942rETEwSTF4PzzOCU9gNohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAWhIf5v; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77baa87743so188904566b.3;
        Fri, 05 Jul 2024 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720186696; x=1720791496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7426fshMzR6GNFPcqwrx5x2skuuMIJBYu2mYPgY4MrU=;
        b=UAWhIf5v3A9Wd7HdAf+IJXKxXtkwBRgH4/QKqO7ge9kAYipwwjmJYMObO1mIjSsGiP
         y4O12m5dmoU3FrcAhxM4i/Dq2kNUOlSm7+G9Kz7c8+OEiyj6ErgLx+GJfaXK6y/dhabn
         AuJ3Ja9JaiUJXQu9nPukuHYKqCS2ghfptX60ooAy8ZvYCuy7zaQ9kGhHqZdgHyUaPEMH
         7DXZsLt/89dKO7wptW7sXUPKYD1A8gw25BhziBQOhTRR2ukapJeSUdM+z7GlYrpTOpcw
         /Ru3qyk67XgE2qgxGZDbAcCoLwbIh0JaLUyYVPPK+7GpeNNrov3eFZJjemuNfbq3UMPm
         NVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720186696; x=1720791496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7426fshMzR6GNFPcqwrx5x2skuuMIJBYu2mYPgY4MrU=;
        b=Q/icKXLFKe4vWOnP3xfrZ/aFhL1MBoGq6uvQ5qAriXeYNKc3LQCbP3tT0CSH/qSuWP
         M3Su6/jPQ0rapgeLYrh956AkUYy6bqaPPz/lpnci45WEJQaTP0TqB9+lpubQSqgphxEL
         zsk3QidmRhuq17XYCIVXyqanKSZtDmF5Yg8zfhYK3wU5RFpM1FGTpeBi3V900++/UH0V
         wFdSU8n4Z1Y8n/HA034uluE86QOWmCy5PHxbhLvvnrZM/j3ZgXrY0OkNM/s4czrUADln
         iAYM6/Wi8LAMHWLlE9LwwdAONj4Qo+dD7Stgvojqt+knX0dxlQHSdoqOgkvHQZs4FIOI
         ZWCg==
X-Forwarded-Encrypted: i=1; AJvYcCXX2MnwD+wLyXXioztR1StWQPk3GTtpttL39Cejyy7abL+VWmf4XDICNId0OWiVwxg3FjppczzJns6rR9EaZbfPLybBP7zj+i2Zra97EcoJ994ZPex0SMmbDbxJLQj6TWrmWkfKkMjzpAGiY02jcL57pLqPfUL5vYAmXSnNG/L17XuHGQue
X-Gm-Message-State: AOJu0Yz62bQhwEtZ+U+hxYMjsQmBzB8jekSb7UlNzjm2WrRRYYsdBEcu
	PJ1uPC8nDk/wyHKCQyI2qZaN3Rctjde+aBpoLSje0KMWZvFVi+Ky
X-Google-Smtp-Source: AGHT+IFRWiSaf/g0RePwmmAb5dJSgEwZk2F7I0MEWkE5X70RByhGeHc0/LLOtqYgynN4RfFSwzEKnQ==
X-Received: by 2002:a17:907:969e:b0:a72:b34f:e15b with SMTP id a640c23a62f3a-a77ba70d6b7mr419519866b.57.1720186695932;
        Fri, 05 Jul 2024 06:38:15 -0700 (PDT)
Received: from krava (net-93-65-242-193.cust.vodafonedsl.it. [93.65.242.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1b555sm676111966b.5.2024.07.05.06.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:38:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Jul 2024 15:38:12 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <Zof3RIqSl6TgaVKq@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <20240703085533.820f90544c3fc42edf79468d@kernel.org>
 <CAEf4Bzbn+jky3hb+tUwmDCUgUmgCBxL5Ru_9G5SO3=uTWpi=kA@mail.gmail.com>
 <ZoV3rRUHEdvTmJjG@krava>
 <CAEf4BzYKVbCEGupX47fwM0XSzwwmXs+0sVpcAdp3poFLkjMA6Q@mail.gmail.com>
 <20240705173544.9ef034c30ae93c52164ecc1b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705173544.9ef034c30ae93c52164ecc1b@kernel.org>

On Fri, Jul 05, 2024 at 05:35:44PM +0900, Masami Hiramatsu wrote:

SNIP

> > > > > Also, if we can set session enabled by default, and skip ret_handler by handler's
> > > > > return value, it is more simpler. (If handler returns a specific value, skip ret_handler)
> > > >
> > > > you mean derive if it's a session or not by both handler and
> > > > ret_handler being set? I guess this works fine for BPF side, because
> > > > there we never had them both set. If this doesn't regress others, I
> > > > think it's OK. We just need to make sure we don't unnecessarily
> > > > allocate session state for consumers that don't set both handler and
> > > > ret_handler. That would be a waste.
> > >
> > > hum.. so the current code installs return uprobe if there's ret_handler
> > > defined in consumer and also the entry 'handler' needs to return 0
> > >
> > > if entry 'handler' returns 1 the uprobe is unregistered
> > >
> > > we could define new return value from 'handler' to 'not execute the
> > > 'ret_handler' and have 'handler' return values:
> > >
> > >   0 - execute 'ret_handler' if defined
> > >   1 - remove the uprobe
> > >   2 - do NOT execute 'ret_handler'  // this current triggers WARN
> > >
> > > we could delay the allocation of 'return_instance' until the first
> > > consumer returns 0, so there's no perf regression
> > >
> > > that way we could treat all consumers the same and we wouldn't need
> > > the session flag..
> > >
> > > ok looks like good idea ;-) will try that
> > 
> > Just please double check that we don't pass through 1 or 2 as a return
> > result for BPF uprobes/multi-uprobes, so that we don't have any
> > accidental changes of behavior.
> 
> Agreed. BTW, even if the uprobe is removed, the ret_handler should be called?
> I think both 1 and 2 case, we should skip ret_handler.

do you mean what happens when the uretprobe is installed and its consumer
is unregistered before it's triggered?

I think it won't get executed, because the consumer is removed right away,
even if the uprobe object stays because the return_instance holds ref to it

> 
> > > > > >
> > > > > >  #ifdef CONFIG_UPROBES
> > > > > > @@ -80,6 +83,12 @@ struct uprobe_task {
> > > > > >       unsigned int                    depth;
> > > > > >  };
> > > > > >
> > > > > > +struct session_consumer {
> > > > > > +     __u64           cookie;
> > > > >
> > > > > And this cookie looks not scalable. If we can pass a data to handler, I would like to
> > > > > reuse it to pass the target function parameters to ret_handler as kretprobe/fprobe does.
> > > > >
> > > > >         int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, void *data);
> > > > >
> > > > > uprobes can collect its uc's required sizes and allocate the memory (shadow stack frame)
> > > > > at handler_chain().
> > > >
> > > > The goal here is to keep this simple and fast. I'd prefer to keep it
> > > > small and fixed size, if possible. I'm thinking about caching and
> > > > reusing return_instance as one of the future optimizations, so if we
> > > > can keep this more or less fixed (assuming there is typically not more
> > > > than 1 or 2 consumers per uprobe, which seems realistic), this will
> > > > provide a way to avoid excessive memory allocations.
> 
> Hmm, so you mean user will allocate another "data map" and use cookie as
> a key to access the data? That is possible but sounds a bit redundant.
> If such "data map" allocation is also provided, it is more useful.

is the argument only about the size of the shared data?

we can make it configurable.. for bpf user we will probably stick to
8 bytes to match the kprobe session and to be compatible with existing
helpers accessing the cookie

jirka

