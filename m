Return-Path: <bpf+bounces-77141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70ECCF237
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 10:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884EB3071F96
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B753F2F12CB;
	Fri, 19 Dec 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW/KcAQP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258F2EF65C
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136477; cv=none; b=XDY/XTIcc+JRskuQ+QbU16wjkeSMXC620XP6O/6s93/PLQk/OY60jZd4FVJ3hLB6kcE/ZOlXrqwfqLaUmM60weinlmFrRWpP7LDmMxmpnFX9XFBTOc9D16tf90vExct+9RAaR0l78ZcORyVKy0kekuFJhx+o0wo7zEm0dd1PCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136477; c=relaxed/simple;
	bh=YAbkYZrQlfJ6U2s9oizGjN7iGoBcBDd5qzlhP1huDT4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBQaJrcEdu0cj4SmgaWwZJ0aI15ih9gfnVrFE9mKM3UVbXeyrNfB3k94OWPDOmFGSfoHQa/sHvV+N22WRVmOwCkDaSEfvCmOHcQsoM3ct0EKVWRL70N5rTjkt3w+D8lul8/VLzk6T5WHASd27Yj6i88VDZJly5ddZZ+gE9STQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW/KcAQP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so1269595f8f.0
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136473; x=1766741273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCGmpPdYb0Ltj1HSEShjNZdXJFFU/MaFibrJ3AqDnRs=;
        b=GW/KcAQPSZXlOmBBlCsV8azEVXhHRt4tWwnjRfA/CgIB5ydGerdd3s6k2YUXPqujL4
         jJmEjCu6AJSxo4OTdKKSmXn/B3Mbdvx7eI9JJHj95OFIIAPPf68jQ7LLQr0E1336fTX7
         OvoE3lQqUfE5fn4cD0zUtTw/GeJX18Lh+HxTUBQYdlSom2Sr3pKwbqHlUbe+kLrjJH4O
         0r9nBNZ4549L4yTYqoQ5x2XcxBGIqp1M8KZuf3ywPOFsiznOROVaIOZgQUg2kjyg641a
         aFtKEG2iVyDcr3r+4d49wfoimLxqt3AmoidF0tH8fHfMv7IyQlyNsoJrqURrpXC/fmpZ
         Iisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136473; x=1766741273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCGmpPdYb0Ltj1HSEShjNZdXJFFU/MaFibrJ3AqDnRs=;
        b=dgtxfP16JWGvBdFd9UvVNv4iT7HhWHu102rBwNry//4JEx3zAVzhQkdCAID5FPIMK+
         MNXnTXCNC3+TnVPUCYFLScFtmQNSYT2QUNwqEfDIItK/avKfj1QVrAgoU82MKvq9cm4b
         5+ulREpgNB+hyZenZ0/zrbxjV8K6J5thNhllIUWU8bVbUk0X99U9/PT9rXOyooGFyRwe
         VpPgMRIpXw5iqiaHIei6sirRkpEMOafCISjWZNvcWVlVM4B8Spk60vOvN757sxRAtMV3
         0EeYnEHe9cKlmZ6LCjsKRxduCs94fgBw4xGtKcLEaWUQHITmdE36ROw5wqm1Eae/ZyIw
         NEAA==
X-Forwarded-Encrypted: i=1; AJvYcCVBZI/Lj289nFxkHjaA5lnyLE/9gU5gwUwo41j8eyIVltAmXIEuVJzDulIVRskJoSIO28o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKabfUjyyd0n5zqlehAAdz1UHilf8wZMIcFDXsiy/tfbKrtJS
	WnnOHNjn2/9U+rn4cMLZv12OLQMGb7sMN85btwEGqJULI72xu8DTrL04OLhs4w==
X-Gm-Gg: AY/fxX4iyMQYbQZqWq84HbsxHga92MniGpFNB3/7T8i2ejnDb+AX4nP3TNbtCQdgMD6
	GGhGU0a66SyBqiZAtbUWkY1lZ3upAQASD65xHdCSmZJ2j8dSyS3SFvmUdvQhNdaxYC8nFqEXTJN
	qgVF2TEnxEdDPhJFId2Me+/ZmxPohCnQdDA8+s0+oEJe8EcMBLNzfW3hRyd5zMC/874u+HJ2UWc
	a1l7L+4sleo6WH+sfbOEgSgs6tX902Ta9shDc6QE7iH5qQp38oT8WtaOOKJ39XV8TotKcMO3kZY
	8urqb94SldtGzGoJsYWCJJrLby6Fe6fCr10n7vwZfkd30ytBNdmkkNRsKr7OSjqN4/LHuT6cKT/
	bynUQQVasJBDXGiFQzhwiAoU3LI2jjuQgWok8vwG8ygtwJAu4wxS2N43LTu5p
X-Google-Smtp-Source: AGHT+IE7/VK4y7V4wJuk9vYv49B29c5HQgz1tSNGyKksyWwzYQwHH1FTIr4fJ/PQrOZ1NBe4x1lPWw==
X-Received: by 2002:a5d:5888:0:b0:431:307:21fc with SMTP id ffacd0b85a97d-4324e42e79emr2769680f8f.23.1766136473309;
        Fri, 19 Dec 2025 01:27:53 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2beasm3929064f8f.33.2025.12.19.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:51 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/9] ftrace: Add update_ftrace_direct_mod
 function
Message-ID: <aUUal38FoUFnndOI@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-7-jolsa@kernel.org>
 <20251218101942.0716efd6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218101942.0716efd6@gandalf.local.home>

On Thu, Dec 18, 2025 at 10:19:42AM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:13:59 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 48dc0de5f2ce..95a38fb18ed7 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6489,6 +6489,78 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  	return err;
> >  }
> >  
> 
> Kerneldoc needed.

will add

> 
> > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> > +{
> > +	struct ftrace_func_entry *entry, *tmp;
> > +	static struct ftrace_ops tmp_ops = {
> > +		.func		= ftrace_stub,
> > +		.flags		= FTRACE_OPS_FL_STUB,
> > +	};
> > +	struct ftrace_hash *orig_hash;
> > +	unsigned long size, i;
> > +	int err = -EINVAL;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +		return -EINVAL;
> > +	if (direct_functions == EMPTY_HASH)
> > +		return -EINVAL;
> > +
> > +	if (do_direct_lock)
> > +		mutex_lock(&direct_mutex);
> 
> This optional taking of the direct_mutex lock needs some serious rationale
> and documentation.

it mirrors the use of modify_ftrace_direct/modify_ftrace_direct_nolock
when we do trampoline update from within ftrace_ops->ops_func callback

I'll add comments with more details

> 
> > +
> > +	orig_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> > +	if (!orig_hash)
> > +		goto unlock;
> > +
> > +	/* Enable the tmp_ops to have the same functions as the direct ops */
> > +	ftrace_ops_init(&tmp_ops);
> > +	tmp_ops.func_hash = ops->func_hash;
> > +
> > +	err = register_ftrace_function_nolock(&tmp_ops);
> > +	if (err)
> > +		goto unlock;
> > +
> > +	/*
> > +	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
> > +	 * ops->ops_func for the ops. This is needed because the above
> > +	 * register_ftrace_function_nolock() worked on tmp_ops.
> > +	 */
> > +	err = __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, true);
> > +	if (err)
> > +		goto out;
> > +
> > +	/*
> > +	 * Now the ftrace_ops_list_func() is called to do the direct callers.
> > +	 * We can safely change the direct functions attached to each entry.
> > +	 */
> > +	mutex_lock(&ftrace_lock);
> 
> I'm going to need some time staring at this code. It looks like it may be
> relying on some internals here.

ok, thanks

jirka

