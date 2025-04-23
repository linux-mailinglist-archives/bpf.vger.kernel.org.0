Return-Path: <bpf+bounces-56532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD4A997C0
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 20:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45D71B838B6
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98428E5EA;
	Wed, 23 Apr 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl2EDV52"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FD28DEEA;
	Wed, 23 Apr 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432511; cv=none; b=NMbfTe5h07KbDWFU+pRthOj4sPnfsq8T7N6qMjWxCGrrUeqr18ZO+mO2SaBraCF6bhPdJblAoFaU3r+660T71CN2GOLxYomuSG1MCfFOdDiVfGaVXJwEoHNmjf9wtgBM5LrszKsNqSBlfBVpPb/c9PSMlB++Z8YY3yVHFN5xsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432511; c=relaxed/simple;
	bh=n5KEgKPWGyndOy8RBM0wXCL7YL1bmrK2XR2keNckLaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvZfUW1+2rIeLvQvIm5N//sQ8ZHQEY3F7pFxz5NVnZzByTAu8SZYws3apHmrIWguqq45Yishx3v8+xAg6z5xWxYnpJkfjdHir83wFBenn56C3S9hcdFbsHX2GErOciozQRcvYlXJlZYUO3CXjiVZ2StAIpWj2+P2mjHWgiaTIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl2EDV52; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so172030a12.2;
        Wed, 23 Apr 2025 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745432508; x=1746037308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhlqINkYpZZBLzVdSPqg22TCWxPQvkr1ZzGoXFf5r1M=;
        b=cl2EDV52G7UXR88D2b+Ku+trcK8nub6TC31rjkxsal9iSKRDP1qab3CWKtXBfSIX6W
         60K0hx1rWKhkLHoljiFmyk7dw/GVdYRVnVxLkNQ7lZb5b+GHIWec338zKDHmqEc38Re0
         xMvAlkIyAP4EScG/TXCaZOFy0p1wHAjKneP3F4PrRWg5BIWdyRdKjBh/d4PYmqqVnJXW
         VLrLbsZvBpkhBhuNbLvkK18gElc/wSsbYrBjpqBNMjjo88XlwrInc3x1/4hAjpIizg2M
         d2eHLeUJ951FByiVyd8YHVzON6k7x3sgRl3UvcT1kslqapQd5nD1v+kEhHuHB5mwRJeC
         rnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432508; x=1746037308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhlqINkYpZZBLzVdSPqg22TCWxPQvkr1ZzGoXFf5r1M=;
        b=qC4EK7DTEeLMraOJqBcJw0BpHN172I5cyFjE4Y6lRZH44QaxlgvGcs8bQdLLKzBsTk
         qVvsbRHZK7OW8DsGuB/ZnZn7xNfWG7VO1Jg1u0qvfIHthikEt5uIrDABGMWvSbQhZZe3
         OcLGvbQK5Z7k18pSQHGUHH6sTdGcVrmfcuhBpkfuNw0NrY6kvtD7mXng2dRix0k6Gmlq
         t/8lgeIzXfFzzBaZU5cOTOgOe1pxc8pinOpHm3FCr+T8TDY+C6UQpOoVZZa7tcqz7vRt
         DuLQL+s5IsFExIjLEeThytBMZ/E8ZUt9bzb3XQpVMp55i3c55qqn7EaLWuyVNqPnNE11
         a/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUOYKfKTZZZzdUvlXzkc1h3TAkj3N/IiTvuMjD81/Tjg7ki2X3x1gt1WjcEt8oIOgo2aIE=@vger.kernel.org, AJvYcCVrRN1dM0f/sOstAO88FMHdQfmGfPEDGoymUeKnYXfyLBsuw3SJgyDcEbrU1qJ+IdopraM92qfODv3BiqeVCe9wPkSx@vger.kernel.org, AJvYcCWTn8SUlCBeGXT8asANdWme4bEp+suOB/LwYGcuS7uqM/mkMZihhCVBLHYLq5/ojCqA2QZrFkop@vger.kernel.org
X-Gm-Message-State: AOJu0YyHlvyDj45bOy4ndQpGp7Wsb4q7Zbnys3mz6d/L35mpn/Lw3b9N
	65DQSyENTbaWT6w2WzOBjf4JrqIKdekrf9EkxNbUulNoDXMz/3iTRL6YvBvPdN/CDcq4kGQm99a
	C4MkxZQ8YfQ9nPvrieSdbsbfbm6YtmkWu
X-Gm-Gg: ASbGncuUBlWEiDPtt3sVqswjuEtHaCNXl0tlCKgPsp+Ng1a9t8r6jhXkoNCjL6fJkCr
	K6r//g21mgQJyekqnUIr2gCj9quhZf1Hh7TrxBTbg5iH32Heexr+jhAMh628mygUspNkS4AEDFK
	jMrMYe/Ta7IcTAfGHXcS+T/orZD4em8ud2sCw3FQ==
X-Google-Smtp-Source: AGHT+IH5HySMSVpWQQiLuLBm1KmGGdctAt+lPhEDR0CAkLYpQS/qWp3FPfJC0WRecO9a0ItoWqyOqKqk1/lb4NE26vI=
X-Received: by 2002:a17:907:26c3:b0:ac1:f003:be08 with SMTP id
 a640c23a62f3a-ace54e6c8ecmr12271066b.12.1745432507647; Wed, 23 Apr 2025
 11:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418110104.12af6883@gandalf.local.home>
In-Reply-To: <20250418110104.12af6883@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 11:21:25 -0700
X-Gm-Features: ATxdqUHQ9RunUOfE64hoOmU3UUAYp4mJ_IcDoTqKsW5Uram8ZVu2YLxD24VGhnk
Message-ID: <CAEf4BzZfoCV=irWiy1MCY0fkhsJWxq8UGTYCW9Y3pQQP35eBLQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, David Ahern <dsahern@kernel.org>, 
	Juri Lelli <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 7:59=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Most tracepoints in the kernel are created with TRACE_EVENT(). The
> TRACE_EVENT() macro (and DECLARE_EVENT_CLASS() and DEFINE_EVENT() where i=
n
> reality, TRACE_EVENT() is just a helper macro that calls those other two
> macros), will create not only a tracepoint (the function trace_<event>()
> used in the kernel), it also exposes the tracepoint to user space along
> with defining what fields will be saved by that tracepoint.
>
> There are a few places that tracepoints are created in the kernel that ar=
e
> not exposed to userspace via tracefs. They can only be accessed from code
> within the kernel. These tracepoints are created with DEFINE_TRACE()

The part about accessing only from code within the kernel isn't true.
Can we please drop that? BPF program can be attached to these bare
tracepoints just fine without tracefs (so-called BPF raw tracepoint
program types).

But I don't have an objection to the change itself, given all of them
currently do have _tp suffix except a few that we have in BPF
selftests's module, just as Jiri mentioned.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

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
> Link: https://lore.kernel.org/all/20250418083351.20a60e64@gandalf.local.h=
ome/
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

[...]

