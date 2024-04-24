Return-Path: <bpf+bounces-27678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B478B094E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 14:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788B1288B6C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450315B107;
	Wed, 24 Apr 2024 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/ZSUfR8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE715AAA2
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961436; cv=none; b=uk7SbHHMjeQ3RsSzkaePRMyWrU38Nmu+vHP9spBNIHtxPJOmFE/cE1S5znOHGZOobSoGcI4VpBYJqYrqkbSWi1bBGBY+TT9SMl4GVlKoH+uurn/JhwnJOrKKEPGG42LrT9Iyvc2KefayuA4UZjrU/b+F/3MhEbBvFV91KpF5YnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961436; c=relaxed/simple;
	bh=ORZZxGjmGHnHgh+htS3fBicgBeOmFerSKJMRkIfKFiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dijONokFGKUtfdOQMOaXaXSHpPpSZu+iX/3TLGaUa4muAFIyPNXyUl4uIUN6Gw7vDVeprNlsOVOrtlKHS686ndK5e7XCTgicjOvJwNTTcigYP0InuJ63oRxkfIlg6KvBU5flsCdZxiLKUgsvjo6Zc4RQnpl6IVtkLfVqRZjDpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m/ZSUfR8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a52c544077so4803051a91.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713961435; x=1714566235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzPFuKdNUZkpwzAJaOpO9HeYEWhXgRSLVW/xtUMpOxM=;
        b=m/ZSUfR82H3i0sDVyZwmvo7Lc23Xc5zo9fN9b3MtNIK/xjJN+CtGzZ86qHOskbzPqv
         JNua+czu+QxRJ+ryyMG1GdO7Cf53cewI9qQF/+L9tVFfcHvA5J5qB1l1+1OIwnu7mAF+
         BI+aCS7oeiJuWnbXQJEqFiVJ1bMC9lQaA1/GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961435; x=1714566235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzPFuKdNUZkpwzAJaOpO9HeYEWhXgRSLVW/xtUMpOxM=;
        b=M9Jbi3nJfma2jAdsDWCVvhkynWUoQeW52L1UGBGF42Y1az9FI17Y/7mS0Bd12DlQQi
         zSpR0JZZVgnlbduo5vIpjJxwRkgzS1YakhaVgb7aEvqy04KfjQByjqMNbWqQrK2sn80+
         sq53ycyd7e69NE2cN1ocZJgb0a+I6oOs3sgYS5je7WthXRg01QwHD+WiYWtEMG7Fzelq
         xQHQaREJV4q5eQTwsNRY5KoQnSTdn8YHjW6EDItxDiqt55eXmTbllUmycP1VZAJPixS5
         iegPIGGe8orUSfQr5VFqeh88mQ8r/N2epcwRaJflE6u1rehtdRFPh5+6p6Ip8dg07ZVB
         t6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb9OKWpQgyJLk8O6MmN2y2M9rpzkgA1SDJ6xarVlnzL3TmtnE0hQslPn8rCffSuDEQcvCoCIUkedT8yEE6HdLVHrLL
X-Gm-Message-State: AOJu0Yx2lrJAfaN1Sk2v7Jmor6BGPj77YQmdKPjFVowD+mo2yvyRYNWK
	4CpofaGPeWMT3Ml8tHzoVfP/88lJHFNBVVxOZgcbG8GPkLyHPtDwyio5TXq3J3AMDtnNkQ4eoZY
	ZHAYNCdBo1x0vcpvoIO58hw1Zdae7jcZ1zP7+07nd6HMQ8pY=
X-Google-Smtp-Source: AGHT+IH2IM9SxHij/Nzj82Ol3E1aFfE6LovFWRkib+r17aS6b+q4k8qg3+2XI8OPsrBM5WUhWdYyVJmomgqCmRh7whw=
X-Received: by 2002:a17:90a:df8d:b0:2af:3c7f:3531 with SMTP id
 p13-20020a17090adf8d00b002af3c7f3531mr1386367pjv.33.1713961434840; Wed, 24
 Apr 2024 05:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2> <171318535003.254850.2125783941049872788.stgit@devnote2>
In-Reply-To: <171318535003.254850.2125783941049872788.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Wed, 24 Apr 2024 14:23:43 +0200
Message-ID: <CABRcYmK_Btem8cBbz=j==RWxw11PQ8cNAUshNA540VD3O=2WEQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/36] tracing: Add a comment about ftrace_regs definition
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 2:49=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> To clarify what will be expected on ftrace_regs, add a comment to the
> architecture independent definition of the ftrace_regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  Changes in v8:
>   - Update that the saved registers depends on the context.
>  Changes in v3:
>   - Add instruction pointer
>  Changes in v2:
>   - newly added.
> ---
>  include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 54d53f345d14..b81f1afa82a1 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -118,6 +118,32 @@ extern int ftrace_enabled;
>
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>
> +/**
> + * ftrace_regs - ftrace partial/optimal register set
> + *
> + * ftrace_regs represents a group of registers which is used at the
> + * function entry and exit. There are three types of registers.
> + *
> + * - Registers for passing the parameters to callee, including the stack
> + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> + * - Registers for passing the return values to caller.
> + *   (e.g. rax and rdx on x86_64)

Ooc, have we ever considered skipping argument registers that are not
return value registers in the exit code paths ? For example, why would
we want to save rdi in a return handler ?

But if we want to avoid the situation of having "sparse ftrace_regs"
all over again, we'd have to split ftrace_regs into a ftrace_args_regs
and a ftrace_ret_regs which would make this refactoring even more
painful, just to skip a few instructions. :|

I don't necessarily think it's worth it, I just wanted to make sure
this was considered.

> + * - Registers for hooking the function call and return including the
> + *   frame pointer (the frame pointer is architecture/config dependent)
> + *   (e.g. rip, rbp and rsp for x86_64)
> + *
> + * Also, architecture dependent fields can be used for internal process.
> + * (e.g. orig_ax on x86_64)
> + *
> + * On the function entry, those registers will be restored except for
> + * the stack pointer, so that user can change the function parameters
> + * and instruction pointer (e.g. live patching.)
> + * On the function exit, only registers which is used for return values
> + * are restored.
> + *
> + * NOTE: user *must not* access regs directly, only do it via APIs, beca=
use
> + * the member can be changed according to the architecture.
> + */
>  struct ftrace_regs {
>         struct pt_regs          regs;
>  };
>

