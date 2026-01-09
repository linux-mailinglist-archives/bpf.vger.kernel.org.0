Return-Path: <bpf+bounces-78370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C246D0C040
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 20:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BEA1301077C
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481262E7F29;
	Fri,  9 Jan 2026 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwPaGK6y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C017A2F6
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985830; cv=none; b=Y996HjB8DdMi54fEtb0QDtAS1ujlYp9eskKprkZeYTvIHEJBfwIL91ixHw/HJfjtqvtBTS8A+PBJSUU4ZAJLTeCGbN+GHPNZ5NXPwrCtxvvQdFqmsQCqHpVKYFOwUZwkHooAoSFIRT5o7kMH3mQD5AIXQjwfKMIofxBGgqs3wrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985830; c=relaxed/simple;
	bh=1xhvN85TB4UEq+IIEOBG/k7NvMp9qQEZ1H+rsYW6/Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7oGPGa61dff6+pRNDZa0YUehmcCh8e0QV0pt6bTPrPbe0ttG8deDsHwDNMkZkOi4om05RfBn/B5+c6hj1vDTWB/krSBIgcJce3dr3x+r4UZM58vp2ZssvXnO82NXPz+99R12XRLoWV7sr+qMMvL2DRqpe5gNhs4Xhe10g9EX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwPaGK6y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so36065465e9.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767985828; x=1768590628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xhvN85TB4UEq+IIEOBG/k7NvMp9qQEZ1H+rsYW6/Ik=;
        b=AwPaGK6y4cIuw25gY5e8WIkURlo4eSdyP+U/ZuUc68RY77cu33+8TbSPqZsebrZe7M
         770YjMHVJLLnxQOMZLuOh3l4IS9dJjx2eD/4m6NJKkdaONnWbkDpW8zTnhgTPDUoVCCW
         WE30VeXqCgYFuPzmO2DySnPOtgzA19q7taJ4q5kP9FYKEeqs3W7L2fyUgUqPHT5SjTOX
         od44tBpx0xu41u73EKhaEBbD5znxZBFto229xLXh8u0jV6K0EY5HkKTJnSVwWQR+wOQW
         FXEqhCaqSN0Q3qoIVuHqObjRrb69Izw7QHkxQNbyavgmKMmfpNV5tWI0geGVKYJuhRnk
         tbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767985828; x=1768590628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xhvN85TB4UEq+IIEOBG/k7NvMp9qQEZ1H+rsYW6/Ik=;
        b=karnUGkK/f5H1dUqLxZsRaBEFr5RpPhN2o6zqAg0VpwmOZ2bAUtwx3s4WZR2Ojjq7z
         wtgYp8j1EM2/lubVV49hm0RY1fT0DWiugGjc+mpj1yOHDYri5M0p9qCuWjO4SXtGJKWY
         RDjrWuPTvt2r/5zU1+0OC+0PLK6aOYAn4KKNN63GoDKx7wj6wO7KZJ5UmRctIk1+qXjf
         fcfQ61oeSwq8Z2rzTYK8Efi7eiIVvvu9yxli/vkl3Yp+zHWfjCzq6i2Yo01fmiYvBxSM
         8+PXhq9DfDWzsJ7CHBspM8FdGxKYMtgx2a2v0/G4iGxQ62xnOpyXcVtVFjzKWOc9PKsh
         Fpeg==
X-Forwarded-Encrypted: i=1; AJvYcCUmfL3IFj+TOVDFLsB5OsoCqfg2k0+4qcO2dHC9A7i/kef/yvLPbf81t6jw10eu2c819UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Rh3tCWSPzc3o3bgeq4NhkJdA7sXjlu9Mpqd7OZmbYIp7DBLl
	5UmU4Y8OgS58JxFpkEGoH1woaWM5Kym05+xTO0uiSIpKb2fWnJpdnclDSLI2L6A+KydE/B/7AxH
	B6OQlBDoIaj4MFCymIcKowuXeXid3uuk=
X-Gm-Gg: AY/fxX40k/Q42uDupniCJEqI2uTHaOAFRK+snzFCkPRDTHMCPVQPzWDfZZi/Q44RteM
	s6n/UlW4FXXV/MzQGAux1xz2//eoOFD1CXu+M1dwtHBajZ0BbtJC3fA0yappekr4q9e0VxgaLSR
	t1tuRBqIAew7UZiiNrT4qOCJiTqixDcbkVZUITDAgB55q/zZbE6aIqnFEEAHIj8qShZ6GRD3J5p
	ilxn8uKw43HdHMno2lZwI/4pVwDUYsw6y1xQGMrpYUXec/TXLq/jz9QmuI8S1Wfpu67D/K5kin3
	LbOPw2dlJAkletCiUq/vVo6Pze17
X-Google-Smtp-Source: AGHT+IGCA/LEYVTWUrX9KAIYdfMYJCZpS+oMbhPxZE2ZJPBTP5d+xWoHiQl/KaPfPT1JqMx+Lfan2oGwA5Nmv4TJyYs=
X-Received: by 2002:a05:600c:3543:b0:47d:649b:5c48 with SMTP id
 5b1f17b1804b1-47d8e4a3c73mr62018205e9.36.1767985827558; Fri, 09 Jan 2026
 11:10:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108220550.2f6638f3@fedora> <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
In-Reply-To: <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 11:10:16 -0800
X-Gm-Features: AZwV_QjcVAwec7ZuTAKhzlsAjlEUvQcPDYYfd4qq_4MFRTrN2yy8vZMt5WIw9Fw
Message-ID: <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:45=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-01-08 22:05, Steven Rostedt wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> [...]
>
> I disagree with many elements of the proposed approach.
>
> On one end we have BPF wanting to hook on arbitrary tracepoints without
> adding significant latency to PREEMPT RT kernels.
>
> One the other hand, we have high-speed tracers which execute very short
> critical sections to serialize trace data into ring buffers.
>
> All of those users register to the tracepoint API.
>
> We also have to consider that migrate disable is *not* cheap at all
> compared to preempt disable.

Looks like your complaint comes from lack of engagement in kernel
development.
migrate_disable _was_ not cheap.
Try to benchmark it now.
It's inlined. It's a fraction of extra overhead on top of preempt_disable.

