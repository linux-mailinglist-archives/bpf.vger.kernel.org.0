Return-Path: <bpf+bounces-47611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A149FC69C
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 22:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A827A139A
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EE41B87C9;
	Wed, 25 Dec 2024 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFnsDV5X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E123156F53;
	Wed, 25 Dec 2024 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735162865; cv=none; b=bXZ/cVL/dVKeH8/Z0+R0lKPoytpWZUmtKRNcvnKb3ATxbN6/qXXcsF9Z7sR8pZXCwJ0FZZTZIkm9AZrWyCvgkjTH9YOcLavqFQbVlex4qMO6WyieYfqCuS/rKl0XukX9WnoGeL/5nq95jwMdKyuHAwZvYXtm2km1w+6OPM59ILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735162865; c=relaxed/simple;
	bh=WjPx4zThxC5TM6oy+sYo5WxM3maQGGvkczyjtl61UXg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCneDBQsZajW5Z3h7JxF/PjCyVcGVQ10obUYjtIA0yqky+e14rm8Qa4cCanDOPs/VqWnTQDD9hj0lkkuYTHMf8z9ITzbBejYkg8jlKDY6RKfJCMCi++pvTKD/EvhydvD0N0X1lgXW+3z0PjuQsKZidAp2wovZrKJReI1jVOscmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFnsDV5X; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso367193666b.1;
        Wed, 25 Dec 2024 13:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735162861; x=1735767661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/OTOqSE4rPhYMOMkXY7FoWqYZro7fZ2HTAGSi1fUGk=;
        b=jFnsDV5XNY5DsSNlz1ly+Ap07z5revyZZd1cD2aqqvSYrOHTp5n3Wr9ESCqnoWkmwv
         zYUe+IMiFG4lRB8xTEM9CW5O4oEis6S/SfPSr20aFH599u5TxXATYXkhxP6bNT0JbiLe
         xYSKDptEJeusXQ3EdreCHkwTcCXzUouAjaSt/BppVjitKvIT6xJORPYU5wvo+mfeX9QX
         UgRPSqMCGlFOgS84dz4BmvLKImN1yewtpbsqMoVYzAnEz3ushmrJIp3ceWQz9koE75d2
         073C/+G4/9iR0mL15XG3514OB8h5enorNimu4R/0ql6+exC7/dLr4H9HD1fywUEphZle
         ehIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735162861; x=1735767661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/OTOqSE4rPhYMOMkXY7FoWqYZro7fZ2HTAGSi1fUGk=;
        b=breqJHfPUGEhUpuYO0IH9YHOA1ItEprsMs3xW+lOE3u2g2emzjD2QXCCkCS+tArHCd
         68d4g/F08DpMH53SgET0sFPSk8uoKjJV6Gjcra23jMy1co9G3rRLkyYzQBXze2JP4CBL
         7OUbyCgITc7fsRKOqYU9q1toqpjdUCCg/vNxc+K/mvSb27hqTNlSGAjNNricRTDb9tY2
         4LAN6iFjUMyyx8LNYYwnNH6Lke46l4RlQC/S1T8Ga2Uj0WN66LskeBQIcnix8rzYSCpl
         dHibQo+AJjw29ObF1BHQJlcNITyXV4Rcv//irYfpmAi0jj26DL6FfNkKszzeud4fT5bf
         JZmw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Uve+qWc06JkL8gK3exu5rB+wUwN5FPZov76yz5E37oLISEeS/xdcCQyHHEjhDgXelRudne4zrl6wtk1CDcbc/9rZ@vger.kernel.org, AJvYcCXp3A+7Qxq7hs5hfCigrdIYFu00BAfm1+6XGn2ad3NKr8iCYfgJDVPQansJ+73VQP/HmW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlB2wYSYuhon3Pd3MPWQjZW2b2S7fi5WdaslyvCsmb1a1d6ly
	HYLhByf9CnX+q/quK/XbA/9o9CFzLLzeeNRvuf11N0V91edUR50S
X-Gm-Gg: ASbGncslCzyrngTZGc2UkJt8zlAutRs2gSax4/wdirmDf1TnFJNBb767v7vPvcazPkr
	Pe0c8O0UfXQnnVbi/a8KLSOYpir83Dbue6M4PQirIOnlWeG8tgFLblnyBN4hzynLio//Bk7n/iI
	4ZKkJIQQKG9N3uelaqQ1u+Qm1dCmPUPGQMqrG3flSd0cMYr0OyzgVwFX92R4MBSxV6mq9AKURqz
	qKti3Tz2CqxDJ2tSzBm4PO5NUevBYuRrMRZQ87dVDcbbmmPnSDgmTZszYR/dQuTPMdnmRIIqlXH
	8g==
X-Google-Smtp-Source: AGHT+IGHdNiMW2jaHiQ0isEVB9fUDdY2DquksCOBVs3Nrz56IoGV9ofnLjeEOiXWOWvfMByGhJGoIw==
X-Received: by 2002:a17:907:6e90:b0:aa6:5d30:d974 with SMTP id a640c23a62f3a-aac2d3286bfmr2294089166b.28.1735162861113;
        Wed, 25 Dec 2024 13:41:01 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4b85sm844078966b.118.2024.12.25.13.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 13:41:00 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Dec 2024 22:40:53 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Zheng Yejian <zhengyejian@huaweicloud.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ftrace: Add function arguments to function tracers
Message-ID: <Z2x75Yumj1TKYce0@krava>
References: <20241223201347.609298489@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223201347.609298489@goodmis.org>

On Mon, Dec 23, 2024 at 03:13:47PM -0500, Steven Rostedt wrote:
> 
> These patches add support for printing function arguments in ftrace.
> 
> Example usage:
> 
> function tracer:
> 
>  ~# cd /sys/kernel/tracing/
>  ~# echo icmp_rcv >set_ftrace_filter
>  ~# echo function >current_tracer
>  ~# echo 1 >options/func-args
>  ~# ping -c 10 127.0.0.1
> [..]
>  ~# cat trace
> [..]
>             ping-1277    [030] ..s1.    39.120939: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    39.120946: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    40.179724: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    40.179730: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    41.219700: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    41.219706: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    42.259717: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    42.259725: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    43.299735: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    43.299742: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
> 
> function graph:
> 
>  ~# cd /sys/kernel/tracing
>  ~# echo icmp_rcv >set_graph_function
>  ~# echo function_graph >current_tracer
>  ~# echo 1 >options/funcgraph-args
> 
>  ~# ping -c 1 127.0.0.1
> 
>  ~# cat trace
> 
>  30)               |  icmp_rcv(skb=0xa0ecab00) {
>  30)               |    __skb_checksum_complete(skb=0xa0ecab00) {
>  30)               |      skb_checksum(skb=0xa0ecab00, offset=0, len=64, csum=0) {
>  30)               |        __skb_checksum(skb=0xa0ecab00, offset=0, len=64, csum=0, ops=0x232e0327a88) {
>  30)   0.418 us    |          csum_partial(buff=0xa0d20924, len=64, sum=0)
>  30)   0.985 us    |        }
>  30)   1.463 us    |      }
>  30)   2.039 us    |    }
> [..]
> 
> This was last posted by Sven Schnelle here:
> 
>   https://lore.kernel.org/all/20240904065908.1009086-1-svens@linux.ibm.com/
> 
> As Sven hasn't worked on it since, I decided to continue to push it
> through. I'm keeping Sven as original author and added myself as
> "Co-developed-by".
> 
> The main changes are:
> 
> - Made the kconfig option unconditional if all the dependencies are set.
> 
> - Not save ftrace_regs in the ring buffer, as that is an abstract
>   descriptor defined by the architectures and should remain opaque from
>   generic code. Instead, the args are read at the time they are recorded
>   (with the ftrace_regs passed to the callback function), and saved into
>   the ring buffer. Then the print function only takes an array of elements.
> 
>   This could allow archs to retrieve arguments that are on the stack where
>   as, post processing ftrace_regs could cause undesirable results.
> 
> - Made the function and function graph entry events dynamically sized
>   to allow the arguments to be appended to the event in the ring buffer.
>   The print function only looks to see if the event saved in the ring
>   buffer is big enough to hold all the arguments defined by the new
>   FTRACE_REGS_MAX_ARGS macro and if so, it will assume there are arguments
>   there and print them. This also means user space will not break on
>   reading these events as arguments will simply be ignored.
> 
> - The printing of the arguments has some more data when things are not
>   processed by BPF. Any unsupported argument will have the type printed
>   out in the ring buffer. 
> 
> - Also removed the spaces around the '=' as that's more in line to how
>   trace events show their fields.
> 
> - One new patch I added to convert function graph tracing over to using
>   args as soon as the user sets the option even if function graph tracing
>   is enabled. Function tracer did this already by default.
> 
> Steven Rostedt (1):
>       ftrace: Have funcgraph-args take affect during tracing
> 
> Sven Schnelle (3):
>       ftrace: Add print_function_args()
>       ftrace: Add support for function argument to graph tracer
>       ftrace: Add arguments to function tracer

hi,
what branch is this based on? can't find any that would apply patch#2
without conflict.

thanks,
jirka

> 
> ----
>  include/linux/ftrace_regs.h          |   5 +
>  kernel/trace/Kconfig                 |  12 +++
>  kernel/trace/trace.c                 |  12 ++-
>  kernel/trace/trace.h                 |   4 +-
>  kernel/trace/trace_entries.h         |  12 ++-
>  kernel/trace/trace_functions.c       |  46 ++++++++-
>  kernel/trace/trace_functions_graph.c | 174 ++++++++++++++++++++++++++++-------
>  kernel/trace/trace_irqsoff.c         |   4 +-
>  kernel/trace/trace_output.c          |  96 ++++++++++++++++++-
>  kernel/trace/trace_output.h          |   9 ++
>  kernel/trace/trace_sched_wakeup.c    |   4 +-
>  11 files changed, 324 insertions(+), 54 deletions(-)
> 

