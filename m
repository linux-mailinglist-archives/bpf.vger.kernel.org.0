Return-Path: <bpf+bounces-18283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C4818895
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC71284588
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478931A728;
	Tue, 19 Dec 2023 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFuN0W0h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04D18ED6;
	Tue, 19 Dec 2023 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55370780c74so2477463a12.1;
        Tue, 19 Dec 2023 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702992220; x=1703597020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=69alNgUwO4fEHcqvlE9wDHPb87XBycRiNpEU0YqP8dI=;
        b=eFuN0W0hlGpPbszrLgW5riCtIgRr7m9ocAWh8w/UFI6osJooFYma5j5BiO3cYxP3tg
         BpPzBimkv8XeTSmas1PtEYID8vLWuTEnG+oYjRIoeQ5bibskAAhAkTw9sYSRj81wbFh2
         JXciVW88h5BLdC6b2RRlGwm91Jv5q0LcWzVsMVeQBfMm0c0F006ja6OWZFl9t7Cnd2OE
         +vcLkn0OA+8FBebv3SDZwxjHFrxa3Lo9XaGPAmCCDEBci4I30tqCp0HaHNfrev4LGWJO
         o2R69ykhB5eYiqXo26krQHqYsW3wBj5M85AjSCuSVIEKC8PVlwqewGEpkAH46PVRHiVZ
         sL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702992220; x=1703597020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69alNgUwO4fEHcqvlE9wDHPb87XBycRiNpEU0YqP8dI=;
        b=PIlzXNpcx/5ZaZ4BjW5K0bA3NSmvZwMHh0qJtvQOBVhTXfuTgj3SWD+jYddbWh6SAS
         ioLCf1YVJbHINVAhsvIuNVIbebwdPf7K+gTCbHxEma9a0jDOy7PvuIYCr7b1UzKyxNHL
         kVYm3lBzEyeNSG7qsyHZP4EO5Kj04HmxV/cSlAle2WMKw7UuOpnqnf5ASfNFFKfuM/+/
         r9vYRsD1VD+JCTMj1mYfIea+hRKBxxREW3dbHEAhxYgZ3qcrm/CTk02A3RZeEN5CaLpE
         js03RA5fr/CqQ+RbI9moP0MlfTCwE8Mzg+Uan7ZRU4w//0AawofUVGp2AyfRRVsFZT7G
         z7tw==
X-Gm-Message-State: AOJu0YwumZwudBxDor3GE84pf0WkH0DwqyXP2TRNShKfp2wFKk3GT1j8
	Kv1GCzA/m8Jzi9bVZIhDzLU=
X-Google-Smtp-Source: AGHT+IFI7ga9857gOeHls61Pb8uACAAUgA2DnLBwa41gHMWBZxqS4Pzzc5dvwJBFt14RpJDi1nv2Xg==
X-Received: by 2002:a17:906:2d6:b0:a1f:8aa3:2bd4 with SMTP id 22-20020a17090602d600b00a1f8aa32bd4mr8549477ejk.133.1702992220176;
        Tue, 19 Dec 2023 05:23:40 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ot17-20020a170906ccd100b00a235b01886dsm2285702ejb.10.2023.12.19.05.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:23:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Dec 2023 14:23:37 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: Re: [PATCH v5 06/34] function_graph: Allow multiple users to attach
 to function graph
Message-ID: <ZYGZWWqwtSP82Sja@krava>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
 <170290516454.220107.14775763404510245361.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170290516454.220107.14775763404510245361.stgit@devnote2>

On Mon, Dec 18, 2023 at 10:12:45PM +0900, Masami Hiramatsu (Google) wrote:

SNIP

>  /* Both enabled by default (can be cleared by function_graph tracer flags */
>  static bool fgraph_sleep_time = true;
>  
> @@ -126,9 +247,34 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  	calltime = trace_clock_local();
>  
>  	index = current->curr_ret_stack;
> -	RET_STACK_INC(current->curr_ret_stack);
> +	/* ret offset = 1 ; type = reserved */
> +	current->ret_stack[index + FGRAPH_RET_INDEX] = 1;
>  	ret_stack = RET_STACK(current, index);
> +	ret_stack->ret = ret;
> +	/*
> +	 * The unwinders expect curr_ret_stack to point to either zero
> +	 * or an index where to find the next ret_stack. Even though the
> +	 * ret stack might be bogus, we want to write the ret and the
> +	 * index to find the ret_stack before we increment the stack point.
> +	 * If an interrupt comes in now before we increment the curr_ret_stack
> +	 * it may blow away what we wrote. But that's fine, because the
> +	 * index will still be correct (even though the 'ret' won't be).
> +	 * What we worry about is the index being correct after we increment
> +	 * the curr_ret_stack and before we update that index, as if an
> +	 * interrupt comes in and does an unwind stack dump, it will need
> +	 * at least a correct index!
> +	 */
>  	barrier();
> +	current->curr_ret_stack += FGRAPH_RET_INDEX + 1;
> +	/*
> +	 * This next barrier is to ensure that an interrupt coming in
> +	 * will not corrupt what we are about to write.
> +	 */
> +	barrier();
> +
> +	/* Still keep it reserved even if an interrupt came in */
> +	current->ret_stack[index + FGRAPH_RET_INDEX] = 1;

seems like this was set already few lines above?

jirka

> +
>  	ret_stack->ret = ret;
>  	ret_stack->func = func;
>  	ret_stack->calltime = calltime;
> @@ -159,6 +305,12 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  			 unsigned long frame_pointer, unsigned long *retp)
>  {
>  	struct ftrace_graph_ent trace;
> +	int offset;
> +	int start;
> +	int type;
> +	int val;
> +	int cnt = 0;
> +	int i;
>  
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  	/*

SNIP

