Return-Path: <bpf+bounces-56308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7F4A95133
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 14:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284711711C0
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09980265605;
	Mon, 21 Apr 2025 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6B9ZQBE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F52905;
	Mon, 21 Apr 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239469; cv=none; b=TS8GAQU8dJVSV/loIbE0Z9wqfEy0ltvD6NOheMc0/6AmgatEk0H9t5BwcVlsUW/lRo3p0PltcGEwUzONS1B52mWNYwTG4EIpoQ6oRyxuUiB6W5se2+sdo5v/FghZag2zAEC80hCqsICv/h5XFa0O9aT1DYu/lMo00KSMwMNmQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239469; c=relaxed/simple;
	bh=msmr++qMaRrpMwocl7aVdZOHFvpjPy35z+sljXfcCqs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAMyBk0RH1xfgbotu+t2F6PfoUOFAnmBaRojGYHTFpu+fTjlHoV2U8uNod3+w7D7csaLE78F17zq/oWY6wiOoxjGVm9n0acQ/+/v8yfGuTONASZ7Iz+QC//+w80/C0yexwVfEPag5PwOBDWEczXkjiEORXbngwpMreYgLOWxSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6B9ZQBE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso7392620a12.3;
        Mon, 21 Apr 2025 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239466; x=1745844266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8wgu7iDQ+eyYe+Yv9pFlAr+skkcnHXb23MdhqN0e3I=;
        b=b6B9ZQBEDNciquwjZkli2pyforkDvngEnRzLTlhSdpxbiL7hw12JVnjuNoM/9fEBqC
         QxHdDp/IVFJvMzG3ffyIoiMvbh0jshaNZ1AHPRkE9BpfIaNsjRWVJknn8O2vCdgqXGma
         xq6Lpu7hI7/0+hxkU/hGSHzFaUTYJGM5LfwNNVlOdkUmGZtQUCfMgAbqPlI6uMZP/9uH
         y/ChHxwJrBgEva57KWYKuJhm1f8aGhajNzw6mkHIv4dCgsYJ6Qxjn6g8VbrBUnreJqJB
         bcOpeeB5dOPDWAibqiLOTqJ6bm2hAxu3ycOEhabdre7TsX0gexaBYTNY9PSqAqfLZcV+
         ElAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239466; x=1745844266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8wgu7iDQ+eyYe+Yv9pFlAr+skkcnHXb23MdhqN0e3I=;
        b=cDwK1eNC8DAXZRL1sPKyYcdIdTeDYlY6L2F4kFws1ZubZ6ANWlQfTH++VdxeNeZYZC
         OGP1tOsqV6O51cBOktjV7UFA4D9N8PFZwGD76UxgF5vauXn/f3MIk6mXkmc/W2xhFb77
         y1lF4ycCNSfrnVj+KdL0HvSldvHD10zKJb2oVW1nsWKRvR0U3ynQTqZ/8DAz4RzxPFX3
         udhPqb/p5etLnDk4LuzwSdxGUF2MzdKxuSUxY/vY7gOntYigu084Hvr2G0yW8SBjsVjG
         mwJmcunLNSxtHx4yFlGQRI8DSbFgwMeIFhAIijyJZ8zIMfb2qLZ+JTsm5rU9odPAXvTa
         QCww==
X-Forwarded-Encrypted: i=1; AJvYcCW+qitfpT7qFU2GnrZff5Ygfx2AGQ4/jQ2ZQ3h6aoYF2X1vGiajhMLIEnJGQqQC0xRxSrxAR6HWjvQtxLxOfCxnxzhP@vger.kernel.org, AJvYcCWOngqATotedxnWYVJOuexdtzd9EtAESy6c+Pj1IJcLk4Kg1dUuavTnGRPdDO5+IyDyMp0=@vger.kernel.org, AJvYcCXtB7UV1IVX7wOZj0OTidlZPFcm7/t7Vj1N5J4jmhJmJhG1Cm3W9Ms9dx72iEJdT8dqoq4xalH9@vger.kernel.org
X-Gm-Message-State: AOJu0YykVN33eofjSiSHWhAn/3fJ1jlEEN/npIPVe5wFCiJV80GIrSd5
	wuHe4OrReN8YOpkbO2SR2pSr2rCjLqsgZ4YkzQ9qf/3rtHunO7Lm
X-Gm-Gg: ASbGncuUzcekS/fBP9y0ODPf/5+qto/l16l27LCIDa7oSltRHzhpcEqLcRqo6bQT9kz
	7sNNbKo1Bg+71ZI/mc2b9maOtMYirMBCoizupY9kLFd7mzs7xQQAEZ2+UFkTtB0PiYiJLabg3ZP
	IpwCpzI0ZhCjEJgNhjH1DdzyUoecry8HzZZgzyZMf9FJDu98TMP8CJ3LRllzOEzPPNPLMsfDlPU
	zRR/vS/Hem68NZ1/3wOgwznyMLFDWNxj0M/+Bcu13kD2ROmBr6egmfV1ZgUhnmvDPuuiKg7Gbhz
	uCAKZIABso8G1O+27yMeO8Zr1TMZiymAfVWf0wBmC1RUvfk=
X-Google-Smtp-Source: AGHT+IFKOfPK1H0jKNo8rpw2hwhKgxQI2qhVac83pOeQAKMWP+1BKJj1LGWSLFV72pzppkcN9eu4lw==
X-Received: by 2002:a17:907:2ce6:b0:abf:6ec7:65e9 with SMTP id a640c23a62f3a-acb74d9b35dmr900858166b.43.1745239465528;
        Mon, 21 Apr 2025 05:44:25 -0700 (PDT)
Received: from krava (85-193-35-57.rib.o2.cz. [85.193.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec4c673sm513175466b.52.2025.04.21.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:44:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Apr 2025 14:44:21 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@gmail.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [RFC][PATCH] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
Message-ID: <aAY9pcvYHkYKFwZ5@krava>
References: <20250418110104.12af6883@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418110104.12af6883@gandalf.local.home>

On Fri, Apr 18, 2025 at 11:01:04AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Most tracepoints in the kernel are created with TRACE_EVENT(). The
> TRACE_EVENT() macro (and DECLARE_EVENT_CLASS() and DEFINE_EVENT() where in
> reality, TRACE_EVENT() is just a helper macro that calls those other two
> macros), will create not only a tracepoint (the function trace_<event>()
> used in the kernel), it also exposes the tracepoint to user space along
> with defining what fields will be saved by that tracepoint.
> 
> There are a few places that tracepoints are created in the kernel that are
> not exposed to userspace via tracefs. They can only be accessed from code
> within the kernel. These tracepoints are created with DEFINE_TRACE()
> 
> Most of these tracepoints end with "_tp". This is useful as when the
> developer sees that, they know that the tracepoint is for in-kernel only
> and is not exposed to user space.
> 
> Instead of making this only a process to add "_tp", enforce it by making
> the DECLARE_TRACE() append the "_tp" suffix to the tracepoint. This
> requires adding DECLARE_TRACE_EVENT() macros for the TRACE_EVENT() macro
> to use that keeps the original name.
> 
> Link: https://lore.kernel.org/all/20250418083351.20a60e64@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/tracepoint.h   | 38 ++++++++++++++++++++++++------------
>  include/trace/bpf_probe.h    |  4 ++--
>  include/trace/define_trace.h | 17 +++++++++++++++-
>  include/trace/events/sched.h | 30 ++++++++++++++--------------
>  include/trace/events/tcp.h   |  2 +-
>  5 files changed, 60 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index a351763e6965..826ce3f8e1f8 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -464,16 +464,30 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  #endif
>  
>  #define DECLARE_TRACE(name, proto, args)				\
> -	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> +	__DECLARE_TRACE(name##_tp, PARAMS(proto), PARAMS(args),		\
>  			cpu_online(raw_smp_processor_id()),		\
>  			PARAMS(void *__data, proto))
>  
>  #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
> -	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> +	__DECLARE_TRACE(name##_tp, PARAMS(proto), PARAMS(args),		\
>  			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
>  			PARAMS(void *__data, proto))
>  
>  #define DECLARE_TRACE_SYSCALL(name, proto, args)			\
> +	__DECLARE_TRACE_SYSCALL(name##_tp, PARAMS(proto), PARAMS(args),	\
> +				PARAMS(void *__data, proto))
> +
> +#define DECLARE_TRACE_EVENT(name, proto, args)				\
> +	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> +			cpu_online(raw_smp_processor_id()),		\
> +			PARAMS(void *__data, proto))
> +
> +#define DECLARE_TRACE_EVENT_CONDITION(name, proto, args, cond)		\
> +	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> +			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
> +			PARAMS(void *__data, proto))
> +
> +#define DECLARE_TRACE_EVENT_SYSCALL(name, proto, args)			\
>  	__DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args),	\
>  				PARAMS(void *__data, proto))
>  
> @@ -591,32 +605,32 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  
>  #define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)
>  #define DEFINE_EVENT(template, name, proto, args)		\
> -	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
> +	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
>  #define DEFINE_EVENT_FN(template, name, proto, args, reg, unreg)\
> -	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
> +	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
>  #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
> -	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
> +	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
>  #define DEFINE_EVENT_CONDITION(template, name, proto,		\
>  			       args, cond)			\
> -	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
> +	DECLARE_TRACE_EVENT_CONDITION(name, PARAMS(proto),	\
>  				PARAMS(args), PARAMS(cond))
>  
>  #define TRACE_EVENT(name, proto, args, struct, assign, print)	\
> -	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
> +	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
>  #define TRACE_EVENT_FN(name, proto, args, struct,		\
>  		assign, print, reg, unreg)			\
> -	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
> -#define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,		\
> +	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
> +#define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,	\
>  		assign, print, reg, unreg)			\
> -	DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
> +	DECLARE_TRACE_EVENT_CONDITION(name, PARAMS(proto),	\
>  			PARAMS(args), PARAMS(cond))
>  #define TRACE_EVENT_CONDITION(name, proto, args, cond,		\
>  			      struct, assign, print)		\
> -	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
> +	DECLARE_TRACE_EVENT_CONDITION(name, PARAMS(proto),	\
>  				PARAMS(args), PARAMS(cond))
>  #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign,	\
>  			    print, reg, unreg)			\
> -	DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
> +	DECLARE_TRACE_EVENT_SYSCALL(name, PARAMS(proto), PARAMS(args))
>  
>  #define TRACE_EVENT_FLAGS(event, flag)
>  
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 183fa2aa2935..fbfe83b939ac 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -119,8 +119,8 @@ static inline void bpf_test_buffer_##call(void)				\
>  
>  #undef DECLARE_TRACE
>  #define DECLARE_TRACE(call, proto, args)				\
> -	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
> -	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
> +	__BPF_DECLARE_TRACE(call##_tp, PARAMS(proto), PARAMS(args))		\
> +	__DEFINE_EVENT(call##_tp, call##_tp, PARAMS(proto), PARAMS(args), 0)
>  
>  #undef DECLARE_TRACE_WRITABLE
>  #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \

hi,
do we need the change also for DECLARE_TRACE_WRITABLE?
I needed change below for bpf selftest kmod

jirka


---
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index fbfe83b939ac..9391d54d3f12 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -125,8 +125,8 @@ static inline void bpf_test_buffer_##call(void)				\
 #undef DECLARE_TRACE_WRITABLE
 #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
 	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
-	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
+	__BPF_DECLARE_TRACE(call##_tp, PARAMS(proto), PARAMS(args)) \
+	__DEFINE_EVENT(call##_tp, call##_tp, PARAMS(proto), PARAMS(args), size)
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
index aeef86b3da74..2bac14ef507f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
@@ -42,7 +42,7 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
 
 struct sk_buff;
 
-DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
+DECLARE_TRACE(bpf_testmod_test_raw_null,
 	TP_PROTO(struct sk_buff *skb),
 	TP_ARGS(skb)
 );
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index f38eaf0d35ef..dd9b806d255e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -413,7 +413,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
-	(void)trace_bpf_testmod_test_raw_tp_null(NULL);
+	(void)trace_bpf_testmod_test_raw_null_tp(NULL);
 
 	bpf_testmod_test_struct_ops3();
 
@@ -431,14 +431,14 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	if (bpf_testmod_loop_test(101) > 100)
 		trace_bpf_testmod_test_read(current, &ctx);
 
-	trace_bpf_testmod_test_nullable_bare(NULL);
+	trace_bpf_testmod_test_nullable_bare_tp(NULL);
 
 	/* Magic number to enable writable tp */
 	if (len == 64) {
 		struct bpf_testmod_test_writable_ctx writable = {
 			.val = 1024,
 		};
-		trace_bpf_testmod_test_writable_bare(&writable);
+		trace_bpf_testmod_test_writable_bare_tp(&writable);
 		if (writable.early_ret)
 			return snprintf(buf, len, "%d\n", writable.val);
 	}
@@ -470,7 +470,7 @@ bpf_testmod_test_write(struct file *file, struct kobject *kobj,
 		.len = len,
 	};
 
-	trace_bpf_testmod_test_write_bare(current, &ctx);
+	trace_bpf_testmod_test_write_bare_tp(current, &ctx);
 
 	return -EIO; /* always fail */
 }

