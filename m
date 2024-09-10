Return-Path: <bpf+bounces-39387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B8972608
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 02:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A451C2341F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E321DFE8;
	Tue, 10 Sep 2024 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4tlgYu4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF029A5;
	Tue, 10 Sep 2024 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926597; cv=none; b=JBo3splHuh8EP528KyNJYLy76rya+yTxK1NQ+M03KXn+ZYO1L1lgrkVeFHNvW1vPm0coxtdxMH/LJBydo0K301ETJS18Cw9mahZUP23XcT9OKuch0WcBvbHIpWiANy9oU7lrIAWtngwsgArxkaxqPCbBbVBCkuBZGTDHBcqSlJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926597; c=relaxed/simple;
	bh=RVU/WXgoPWforUjJ0oVD1VRfrBNg19UyZXAgKVK9VaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiFy5Y5+VgUcONNV1KZMttS1CMg6HwnT887d+b9Xq7UtM8ob2RZWeAGGgIt2IlLjtP9Z6Zjqb1K+1GN5zGhPASIgxQvl/gg3bz0wG0BHWvSuKwP5q2rhgAroljuXMTi+1goncjdj+L/e1ErlgxRNIYUFUsyG3RD3Is/24WsVqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4tlgYu4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8a4bad409so3439462a91.0;
        Mon, 09 Sep 2024 17:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725926596; x=1726531396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX07L4MyH3UtAmhVXaceT+nqL4USjSuMhroAMQ1kAWc=;
        b=P4tlgYu4+Rggz79cGvtSrRN0yDNASRnFGzHcVsPBLDXXV5MOhsOLTrqY9f5OrB47pM
         KUdhp00J5E/mapo+kbwRRgz6iudmJsWbtTRev2Y1iN+xthCpotSeHwS0J/7VW24z0Gfc
         4EtgQxKyzyYKF39uucTGe0d909jGhGbjFEm22thKCDdN4s/iXUcJ/a50KB9vqrDrJZh0
         tCXhMVJ0V+5iSCRa/JQABCT2hKoVHeqG15LwW31nbLujxBsIcts01bDcAhf4HkdhUruN
         Azt5VIij5o0Krt0o15yjwcoeNtvWT+ZWdruOlPHeuJMIOVsWGAQZnUiVGo7EQAjgnFuZ
         6+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725926596; x=1726531396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX07L4MyH3UtAmhVXaceT+nqL4USjSuMhroAMQ1kAWc=;
        b=wC3ky7EqCJ9M4eBwLt1cVoH0T4Bbr7v3qqZDO0tnK6Gek7Lp9dIPgg9gT5hezbZWrR
         Mgh3M5QXlD2rghv2k6CLeR1/61NZ50RcEjkpmlEi7qqclzI/jHFqCmM/Jpr0fL8qozwR
         4afi2ajBSBnvX/5s6Qmh/qmmdWbSxty7v0Jm1Hk22KW70qmy5JBhBf0Wjogf/0BckAXH
         l1OFYz7r/tX1k0qGiRI66UK/wLmU8eX/++8nnrqs/xyuI6FxbbbZimtBjc1CyYNocCnZ
         q/jQ1U7EBF9TbsRDF6oaJzJmR31BsIi6mZ8gyRBTFfTC3YY+c/yj7q3PpyypJzwIZSJp
         0RLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUep8tuSlHY4t4yXYTdOA6A3vlsLscZdD8weUyHARC49w88XflLB4iibq/+HzUlKhEp3lY=@vger.kernel.org, AJvYcCUs42Ts3HRBtLS4FCL58Yz5Ab/fW7mplMWcUKiiS84Tqrp4mf/vflHRzRarTyShds+efrbDlHCS4C4OI5phduXFl8bS@vger.kernel.org, AJvYcCW8yh7sxTRx7GMExj9rEeNgMhJJ7fuWQ/mpT2yO76J2XIIdlDOHreH4WiK3/qhYzLyeBxZ047L3mZLSeeC+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Bj5NWZxzAB/vUNNeTBUhuIl/pmoJ7yq/ab1Gex/ClsoPmqDG
	L8OACfCEEHZ8Ot9hmckagO1mCDUu71vO5M+Fnvt9JKusl9/kLpoQJWFlM/iwSRjRWmKqeK2chhb
	0RHcwIWeuMZXvQDq6vUNJaRdJGek=
X-Google-Smtp-Source: AGHT+IFf8sUPFNRoE6HG/5otm81c0UQzsaXRgNB9WUVkQnJGtqaVmqSOeqk7BwoGLjGAl+cQ5lj4P0iXwUrikTB/aZg=
X-Received: by 2002:a17:90b:1b4b:b0:2c8:64a:5f77 with SMTP id
 98e67ed59e1d1-2dad5196e14mr12806819a91.37.1725926595585; Mon, 09 Sep 2024
 17:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com> <20240909201652.319406-5-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240909201652.319406-5-mathieu.desnoyers@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 17:03:02 -0700
Message-ID: <CAEf4BzZUgLaK8r5VK4VmfQTEKZ13qDEGUEEdeKJeZYc_96KCTw@mail.gmail.com>
Subject: Re: [PATCH 4/8] tracing/bpf: guard syscall probe with preempt_notrace
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:17=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> In preparation for allowing system call enter/exit instrumentation to
> handle page faults, make sure that bpf can handle this change by
> explicitly disabling preemption within the bpf system call tracepoint
> probes to respect the current expectations within bpf tracing code.
>
> This change does not yet allow bpf to take page faults per se within its
> probe, but allows its existing probes to adapt to the upcoming change.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/trace/bpf_probe.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index c85bbce5aaa5..211b98d45fc6 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -53,8 +53,17 @@ __bpf_trace_##call(void *__data, proto)               =
                       \
>  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
>         __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
>
> +#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)                 \
> +static notrace void                                                    \
> +__bpf_trace_##call(void *__data, proto)                                 =
       \
> +{                                                                      \
> +       guard(preempt_notrace)();                                       \
> +       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(=
args));        \
> +}
> +
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> -#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
> +#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, =
print) \
> +       __BPF_DECLARE_TRACE_SYSCALL(call, PARAMS(proto), PARAMS(args))
>
>  /*
>   * This part is compiled out, it is only here as a build time check
> --
> 2.39.2
>

