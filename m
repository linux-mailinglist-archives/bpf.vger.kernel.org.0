Return-Path: <bpf+bounces-39386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80409972606
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 02:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD25D1C2347F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A02F3B;
	Tue, 10 Sep 2024 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9AA1e2B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A229A5;
	Tue, 10 Sep 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926592; cv=none; b=ZLBXKhtHSJV7O5+/lZZZDgvniugCE+mEfI9c66FP4zFUJQxRQMzE4twBZ7+uaC578BBich1xU7NjHJM1F74N5W7bDvMy4iWzKSzASFfBXzfsBI3jrUW9m/7uZeavSPPfxeX4ie/M0oexmXrZr5Li4Ev/zoSxncaW/5+rWQl/Ehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926592; c=relaxed/simple;
	bh=fNbW5VQJv2KiALwisGPfVfx3yL5JVzNmx2yxw+sAx3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFE6tAOMe//itRiaukTy9mUsyu6w1OHmFB3XB4h2IKeDIrJt1R0rrAVx2ZFHI7+fENoINhf1pn1KpVOt6/HNAKr/A8ppSY/jvgrA2+Fm3LEfagWfaQUOrywCTV72tEnsDNXcsqFTtzsYvjWl+u6LdTYpFhumJ+vw8wHG57XYDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9AA1e2B; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so86272a12.2;
        Mon, 09 Sep 2024 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725926590; x=1726531390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf9ULe6jsxG188hJeNVVqnkWBFrA7j3PQqhf5n/c+xI=;
        b=S9AA1e2B/RbXNoCPnDusqe4nZYQ9Iw6QXTmUMj8Ym7UQ0Bwid9JPrCKw0hBrwfnkCf
         jtnYH7KJzWUBeM0XSXiY1eDHN7Ea6utZ9q9Q0j+igY3YVwhoQovQZyTuKE3DQi7/fEly
         QI9cSy+ZVIfbbxALoU0ITqb/MD2F4Jqkb/GXm+/0BvubYov912DtBFHABWjKqz+TPbbg
         eV6WZWb7X5F2e/OrjKk2B5XQ516l5kVWEy/6sHx7EBvHWGTj5fMFrvpcTLxUwLwdJs+0
         20++fJXXEswGZlZTovQ9EAPXOnHGKzXjDN/7xkj8eom9Wd7QPXKOGf+OAIH57SVRDkpf
         XgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725926590; x=1726531390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf9ULe6jsxG188hJeNVVqnkWBFrA7j3PQqhf5n/c+xI=;
        b=c9bdG7yEXW3U2IF96TQX6fKrdviWaCCc7zldo5pHkEMb4T7UF1mYzA5vqlOtWbCCdS
         h6oB3YCqiUAU8jTeyJVAEy43MyWP3VXgVoJmlA+Mpus3ObwZnlifKY4zTPw+53QTsSJA
         /TkEI400nf+bR/7NrTJmT+QRZK4jqeiZszDHsmgayW6mD4dEdEzXsZ1q+S6vkFWMRsY6
         7ivZ+SEwAigBlC9VAdY+pL/1FzX7856Bxt9FLTxrDc+/v+6bTgZ2rwBlTyVWotwIRF1Z
         Flrd4uiVRsFbuMUy60MVawLlDXGeXaEGmLb0Gnkxy4AbmuF0QH+vyXydKCEOH444ziTb
         KvEA==
X-Forwarded-Encrypted: i=1; AJvYcCULr/pZtj3X+Q48yCAFXA2u8ZNHvm0VnNL28eY9/LB/63tVz30csnb0c1JxGDR/3LxYDGs=@vger.kernel.org, AJvYcCVttrhh4Sc4hRKoW1eDHhC2czxDZdeL3nXtD9k+9xhXb7vf1WIvaqzL1kLBrYsLdl2626XIi3w2EQfHROAEmNvhjYqH@vger.kernel.org, AJvYcCWhxeirEmtm1PSRCuIHWNGn9H2FGGq2c3o6SI9f5KXs5ZwCZost4s+YnB1DHouV19Jd8AZJZO8EHDG1IsNT@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZOcjKB8yi1HlVgEiX7QCJrmysiTXCprj9ZBT76TS17IOSUPf
	XDA26jP8qKpIi3PlNa+cVIJpwQVag7iW+dFHMwjkkMj+8MFyyywJwd13/6jH60Nbac+72L2Tt3F
	0qid/gNf824fFtSG9wkp53gyNzY0=
X-Google-Smtp-Source: AGHT+IFvXB8mLD6dJwZP3Pf15H9sUUYVkpsnD3HQyjTliH6BBIO2jlNj3+UCaP6yigz66S7v2K2ky8JAh/+0mc3Wmns=
X-Received: by 2002:a17:90a:1fc9:b0:2d8:8d60:a198 with SMTP id
 98e67ed59e1d1-2dafd0c0076mr10852213a91.37.1725926590486; Mon, 09 Sep 2024
 17:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com> <20240909201652.319406-9-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240909201652.319406-9-mathieu.desnoyers@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 17:02:58 -0700
Message-ID: <CAEf4Bza07qWL1o9Y-ZZddrsH-hm6nse7855bjpCurAZvf5C_2w@mail.gmail.com>
Subject: Re: [PATCH 8/8] tracing/bpf: Add might_fault check to syscall probes
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
> Add a might_fault() check to validate that the bpf sys_enter/sys_exit
> probe callbacks are indeed called from a context where page faults can
> be handled.
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
>  include/trace/bpf_probe.h | 1 +
>  1 file changed, 1 insertion(+)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 211b98d45fc6..099df5c3e38a 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -57,6 +57,7 @@ __bpf_trace_##call(void *__data, proto)                =
                       \
>  static notrace void                                                    \
>  __bpf_trace_##call(void *__data, proto)                                 =
       \
>  {                                                                      \
> +       might_fault();                                                  \
>         guard(preempt_notrace)();                                       \
>         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(=
args));        \
>  }
> --
> 2.39.2
>

