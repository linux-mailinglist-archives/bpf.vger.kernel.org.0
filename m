Return-Path: <bpf+bounces-38264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22DB962648
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 13:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCE21F23D53
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA716C86F;
	Wed, 28 Aug 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt+hxmiq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF927166F0E;
	Wed, 28 Aug 2024 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845570; cv=none; b=UFgudu0bQsXJ40mzKBM3UVuM/iIJuG01z4FXkYvpzgoLt82YVejXyeZ+yTOaw0B57MAMB8Ii9gPN/HNMEXYln4g5wW908/OJtuuCk6sb8rGx//jFrhoZ+3PF8J3885J6EesZPHgD5bRM9cZ2YuC0vqaJQAse0FlRYJHm55buvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845570; c=relaxed/simple;
	bh=8ZEstB1ND1c9iOC2+qOOCsD/N4dwJhJsVf4IsY1WF+U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUTccvqPVT+qM65Y+tTn8YVsuv4RLzGRj7XfJR+5nMNdHQzZhSl0M4L/wJ5onB4e7JiPV+V7FJUmSp5VbSKgQi4Fg4E3ydzNrtVvPNkRugLMrJjwt6NHLo5MxBkUrD6ZHEfwTkqtlIZOzXlULaU5uxegDR/T2Iai6Xu7li/zyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt+hxmiq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c218866849so577441a12.0;
        Wed, 28 Aug 2024 04:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724845567; x=1725450367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wAkuMMTjC69avPQ3AhGJ1Inrsm85tv0XbpC7+w92Wo=;
        b=Lt+hxmiq7tJjZGjGoYvVZbaBud6ecN3E6YXghu8XCcwAXkDiu1v0uQTVX5eNmRMoy4
         WPsl4ifK32mAvBpSNJ2D6VrFo3wlVIvnwsvs7VCr04Bt0ptZFdawt4zleGSCfM58Ne5a
         DbJB2DTi7PhAO/RfgHojQ3AiBi/wZhdN/1KFyDJI3kCRJbQ0+izwjgfY8Vy4pUqlAwx0
         F/l0vwNtRD7nkqBNHQAai74UTzh2fqWXKD951Szq+eMyjvD8smL1YwsSyQStN4R8ZdHM
         JCU5IwpQUHhZ/I00NalhX+JO/xikpDEmue/Sf3Uwc5ZpFQMpuedKDhisbvZspISTEBBf
         isCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724845567; x=1725450367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wAkuMMTjC69avPQ3AhGJ1Inrsm85tv0XbpC7+w92Wo=;
        b=Pps1gtQqVRxaVC9ZPhgsh2Z1XpoXv9QXvGoBR2j5lvKKeqy5FdyZrhju2DKxpMunw4
         Dv2CXPuHWLk3R4bZHzORWOlBx6fMYDoaKPhlB8eTWLXQCyXctZ4PFyt7sJhPZU3g8xg/
         v478T8MOFh6/YywduTVxkJs1H318wHwEU5IrVU9cXgf4Z4a/3EKRs1UEaHLjVgFLuENh
         9yKr3LfkuOJ4PRcLme84FQdiubhSJ/2yqkfXz5jjSPgRztxmNK16VP05Dj32de+tbkZ7
         8JZZCu+hGpSCbJWtfWiYR+ypcQFtBiGkzdIQbW4b1wDRnAkRUmrSolbUWOQ6ybjpQx2d
         KL7A==
X-Forwarded-Encrypted: i=1; AJvYcCWB0ayp3IhB6nZKymRoAG56Al+0jpa7eWX6EWYasKj6TTf/Q9fXhC4Hz/EmsMWNk5udndg=@vger.kernel.org, AJvYcCWnFg4NFstj/t7dsootRDYIJncwP0JPTHASHS9WFJ8gT28uM7lfUjMgEqBXYEyjOFO84O+Nblf8DyQFQrI61q415LPq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/Ao27fn/gKsRwCn0d2c7KB85HzULfrcCobOGU++CPCnv4cIJ
	oUG7zqYuOFgIXRI6FcDZlIWrdU2b1AHIBjUvkMae9G50gUiu26/NZj/yhRP/mUIrRQ==
X-Google-Smtp-Source: AGHT+IFgHV8r9f5vno3x983HZlFlCq+hbnbtTdc4a/ktAqjFYir7OUjgIdb3s/7qIIJ/mT4hlYMaZg==
X-Received: by 2002:a05:6402:2792:b0:5c0:acf4:dfb4 with SMTP id 4fb4d7f45d1cf-5c0acf4e220mr5729786a12.1.1724845566494;
        Wed, 28 Aug 2024 04:46:06 -0700 (PDT)
Received: from krava ([173.38.220.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1e5d3esm2170067a12.37.2024.08.28.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:46:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 28 Aug 2024 13:46:03 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zs8N-xP4jlPK2yjE@krava>
References: <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
 <Zs3PdV6nqed1jWC2@krava>
 <20240827201926.GA15197@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827201926.GA15197@redhat.com>

On Tue, Aug 27, 2024 at 10:19:26PM +0200, Oleg Nesterov wrote:
> Sorry for another reply, I just noticed I missed one part of your email...
> 
> On 08/27, Jiri Olsa wrote:
> >
> >    ->     uretprobe-hit
> >             handle_swbp
> >               uprobe_handle_trampoline
> >                 handle_uretprobe_chain
> >                 {
> >
> >                   for_each_uprobe_consumer {
> >
> >                     // consumer for task 1019
> >                     uretprobe_dispatcher
> >                       uretprobe_perf_func
> >                         -> runs bpf program
> >
> >                     // consumer for task 1018
> >                     uretprobe_dispatcher
> >                       uretprobe_perf_func
> >                         -> runs bpf program
> >
> >                   }
> >                 }
> >
> > and I think the same will happen for perf record in this case where instead of
> > running the program we will execute perf_tp_event
> 
> Hmm. Really? In this case these 2 different consumers will have the different
> trace_event_call's, so
> 
> 	// consumer for task 1019
> 	uretprobe_dispatcher
> 	  uretprobe_perf_func
> 	    __uprobe_perf_func
> 	      perf_tp_event
> 
> won't store the event because this_cpu_ptr(call->perf_events) should be
> hlist_empty() on this CPU, the perf_event for task 1019 wasn't scheduled in
> on this CPU...

I'll double check on that, but because there's no filter for uretprobe
I think it will be stored under 1018 event

> 
> No?
> 
> Ok, looks like I'm totally confused ;)

I'm working on bpf selftests for above (uprobe and uprobe_multi paths)
I plan to send them together with fixes we discussed earlier

I'm hoping this will make it more clear

jirka

