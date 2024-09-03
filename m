Return-Path: <bpf+bounces-38824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B87F96A704
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BE41C23573
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F41CB32C;
	Tue,  3 Sep 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A+SR+zPZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06C1CB317
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390027; cv=none; b=bJVOe9jpSKTVmd2aIZQLRyuDJH463iViKOuB4QroK7LONW9xcXuiGTBBUFd/iHZMCz8/h8TUYSxcvB4Noixi8xZC36uqtskT299afD3VVygiNUw/lnF2eWfbwsekqWVme76GGqUeQSvlDybmcPrm5z0VvF72ywwjvoepqRhrHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390027; c=relaxed/simple;
	bh=2uozw+fJ5WSOhhVTdjzSoLngH5Q1O9Z/Og7kh1h8O9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja21rWyD8zHciRCXQzrsIfocvsuImrDw8666sfjhcWKlWHE5XTJm1Ok9/lmsQ0bSvoatkwuMofzepkQ75p2+ci6z6KarqkeQ+cDtBE5/EyWXcMoj9yg1G2C0yroQ+7A9nnGpaxRxNJBDV/Jum33HpEqkanQaE3HbtD1QjCfkOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A+SR+zPZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86984e035aso695489866b.2
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725390023; x=1725994823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1O1ShPrP32GZ6zNKibhG+Lc7a+zlJjipIRDsNar31FQ=;
        b=A+SR+zPZj0gkOqpvjJ5yvZhWDvhWE+sAlNM2VtlTMG+UQB6L7dL0QXDg+ad97+pb4k
         fUVndEo15J45pcfwv3xnU/kHzumBwEHh5QucnM6PgIQoZckm231+J0xX/5lQBTYbf3Le
         ERJAtqihF0oPr7GXzIukiEjNuLpoLc3gEFE7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390023; x=1725994823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O1ShPrP32GZ6zNKibhG+Lc7a+zlJjipIRDsNar31FQ=;
        b=OjGe1lGX6aMgNoabwWl2HK7h3rz8VgdoiNumCQiX575FGCMbicMtjA3IpWjhjtJ/eV
         KL2MCe6qSyU/esYzfmP5Z4IwOKP42SQwO1q+GPH7NwKre0VxFfAhZySsirWFnFe/H/Rb
         cEwdLoDzw7lhnrqe4jRhickoW2sL8kWTE8f7PzaIOmomWtyjg+ZksVt4zpsCfwDCgBVA
         kT8yD38ZpehOjUol4lqhMyW4BILthxGOyx1pjzMv1sQRCywgWnFPlns0pDXCel1/CLwn
         Hhwlmpv/Gozs4HVcrstb39r0Mc188uJyLi3X9gemoPi18uXfSKgYCJhqbjyIsffvuGq6
         4BdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX3a8eGgI7i8ft/TtVHsHk7Cz23rZuIAASujA1mI+PtqQjYcT/E1b4B2dpvlTMpUHbT50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1Q6mIoTbmicPJUydn6nIs4Q5jPrPYCTqlTiCRo/2NUareKwg
	dKjaTdE+3lKIDgO+ir94V05UbOHcuoqt9+LETCG00LP0CkL5pztbsjX/sgwTbzy1pvz3FTWA+Pa
	OhwRb6Q==
X-Google-Smtp-Source: AGHT+IE49MIgRGnKyOax6OIuy+sKMyxuyf/jioYi/WGv9SKa9TsGDudaOl8EmUq0HCHjCM8YrxTB6g==
X-Received: by 2002:a17:906:478c:b0:a86:6fa8:c6a3 with SMTP id a640c23a62f3a-a89a36d084dmr907592066b.39.1725390022716;
        Tue, 03 Sep 2024 12:00:22 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb888sm712610866b.30.2024.09.03.12.00.21
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:00:21 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so6088027a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 12:00:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlPFo0MAp7A0PRVepzaBDbo8q6rrMlLOGNiYfC+3rdd7fbapoq0f8J9VCyhpCu4wAgL+k=@vger.kernel.org
X-Received: by 2002:a05:6402:430a:b0:5c2:632e:a4e7 with SMTP id
 4fb4d7f45d1cf-5c2632ea4famr4616131a12.6.1725390021271; Tue, 03 Sep 2024
 12:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com> <20240902154334.GH4723@noisy.programming.kicks-ass.net>
 <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com> <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
 <60d293cb-3863-41c8-868d-59c7468e270e@efficios.com>
In-Reply-To: <60d293cb-3863-41c8-868d-59c7468e270e@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 12:00:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com>
Message-ID: <CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 06:42, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If we look at perf_trace_##call(), with the conditional guard, it looks
> like the following. It is not clear to me that code duplication would
> be acceptable here.

Sure it is.

Admittedly, I think it would look a *lot* better off with that macro
creating a helper function for the common part, and then just call
that helper function in two places.

In fact, I think the existing "perf_trace_##call()" function *is* that
helper function already, and all it needs is

 (a) add the traditional double underscore (or "do_") to that function

 (b) create the wrapper function.

IOW, I think the diff would look something like this:

--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -15,7 +15,7 @@
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
 static notrace void                                                    \
-perf_trace_##call(void *__data, proto)                                 \
+__perf_trace_##call(void *__data, proto)                               \
 {                                                                      \
        struct trace_event_call *event_call = __data;                   \
        struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
@@ -53,6 +53,17 @@ perf_trace_##call(void *__data, proto)
                         \
        perf_trace_run_bpf_submit(entry, __entry_size, rctx,            \
                                  event_call, __count, __regs,          \
                                  head, __task);                        \
+}                                                                      \
+static notrace void                                                    \
+perf_trace_##call(void *__data, proto)                                 \
+{                                                                      \
+        if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                        \
+                might_fault();                                          \
+                guard(preempt_notrace)();                              \
+                __perf_trace_##call(__data, proto);                    \
+                return;
         \
+        }                                                              \
+        __perf_trace_##call(__data, proto);                            \
 }

 /*

and notice how there is no actual duplicated code on a source level
now (although the compiler may obviously do the inlining and
duplication - although I think that the tp_flags are always constant,
so what actually hopefully happens is that the compiler doesn't
duplicate anything at all, and all the conditionals just go away.).

NOTE! The above patch is garbage. I did it as a "like this" patch on
my current tree, and it doesn't even have the "tp_class" thing at all,
so the patch is obviously not functional. It's just meant as a "look,
wrapper function".

In fact, I think the wrapping might even be done at a higher level (ie
maybe the whole "may_fault" shouldn't be an argument at all, but a
static part of the define, in case some event classes can take faults
and others cannot?)

I dunno. I actually think the whole "TRACEPOINT_MAY_FAULT" thing is an
incredibly ugly hack, and SHOULD NOT EXIST.

In other words - why make these incredibly ugly macros EVEN MORE UGLY
- when there is a single use-case and we sure as hell don't want to
add any more?

IOW - why not get rid of the stupid TRACE_EVENT_FN_MAY_FAULT thing
entirely, and do this trivial wrapping in the *one* place that wants
it, instead of making it look like some generic thing with an
allegedly generic test, when it is anything but generic, and is in
fact just a single special case for system call.

Yes, I know. Computer Science classes say that "generic programming is
good". Those CS classes are garbage. You want to make your code as
specialized as humanly possible, and *not* make some complicated "this
handles all cases" code that is complicated and fragile.

                            Linus

