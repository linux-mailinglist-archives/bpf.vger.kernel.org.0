Return-Path: <bpf+bounces-43265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A29B21EC
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830252811D7
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24213D281;
	Mon, 28 Oct 2024 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUYPh+XN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8437836C;
	Mon, 28 Oct 2024 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078589; cv=none; b=A2sz9XVjEGHaSZ9Hmkd7ulrsuMu2T3EwcgvVr8/seQhqQJLiJmaoiT/ASnxvFwBOKKk32Qaw8PkUSML1nRODDQS/VQblUSJ0oA5szuU1VomaTmP4jxKjpBxOozOit5C/FtmbvKKBs2+dnjN/QwLAZk24KwDA10DBZ92gJelxO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078589; c=relaxed/simple;
	bh=3clKcpfjHoJ2vWVpZGgOiNVWowcSiHHETNe0z39scfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbpv0AxljZ8uMnz3vbtJbrJJNM940He/jYo3NO4Xa0NOh215qKZ2AiJVmOaftsZaXpnOnMLvOpMY5QfYIqGqxjfKiYlyCoL5sWBvhUTYloIbwxBOfhU/AeAWmErRoDoYuQOtNLKCBosHuYGRenu6YwtfLIkhkz2bI2Wwiy80JME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUYPh+XN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e467c3996so2740623b3a.2;
        Sun, 27 Oct 2024 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730078587; x=1730683387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbd7mQXguTcXJtcB72uwvmxn4tt+BzOaf76K1S0JSgM=;
        b=CUYPh+XNsvqrHkp3alemUdCt/WXqBIeFs3Q7bGaGuMCm93TevvRPio3LdpnKZKWL6n
         NFanrUTf4CN9AnR1o+kG8v+4Djndw7IslJoY2OdX6yga5Kf/QELuC9zPwf6SmbJYyPOH
         gXyN2MBZqvlbEUSNWsz0QOto53/cfJ9WDqZI50XE8qvDG6Kpfa870iygU1jlqmmqpqJl
         5b42LPXghNC8hScEOCWF56qwrNEfxBIfQPq533C3CDf4loRWWYzGLkiLCvfgXdWGPYHt
         Kl2rBvhcHSWZStaxBkpQn8uwIW/g+RZNNXTDZnX8tsmDnB/XPu5SdaH5X090EZS/5UTA
         RBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730078587; x=1730683387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbd7mQXguTcXJtcB72uwvmxn4tt+BzOaf76K1S0JSgM=;
        b=xHF/5HM++93s3bNwBbtidxOcr9MVSeVi7VtEEvurV9gBuCjFgEdRKmFdCG1UISZ6GS
         zMInKqKgnSh06aD/9L+2HQcSPfKjqInh0MOWir+i+jQYGD7r6NdayuYGOz4VrGnqC0FD
         0uITAL11FwjlASDlEK2vwmS5SHfWxIT/F88jChqsM2hEm7OiuiI5MYlLY9gUsgPMTr4e
         TxcOaqGIX2aNC2uHILesC+Zc2kaVnjeRK9YMSETU6Mgw2EZuJC+FRm02HHSn3jGTXj/A
         PTXvINPwq4oWfvWqO+nW5BQCBUkAIsWqTjjkTNPuV+ADXmsOZkUdrxCBegbOeFvhQA+I
         wgSg==
X-Forwarded-Encrypted: i=1; AJvYcCUwPl293RjbXG9zMnHT/uLKnDO7JIbO5AvH9EWhYMU7U6jjiV37QkLEjaTnloHajkr8eiI=@vger.kernel.org, AJvYcCX44YsFUaumfE+oWZBZHjqp/YGotxB+tTD3gZnEzFGWbBjvugkzcVvQo6WazrCeVzto0AXH385SKZJlKJyt@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrlUYIqvYc+W472cuTJSpZXuU7I/pgoDzS9sy1YqceJ0/b/W4
	2NnmC0myqAcjTvDC9XzJn8w04xVp2pA2dvKaODdwX1qmZleIsX6McT8Td/5NBW9khE4/V2IDFwT
	O2+8D5lBjTS78HGMn7NlJX936gUs=
X-Google-Smtp-Source: AGHT+IE6S+GTd1AliA/Bb42MdYlnzo3ZnyT8vf9nlUdOljX7d8bNs2n/HjkzAgK+qr/oHrAgf16pMB3obR+dJx5orEQ=
X-Received: by 2002:a05:6a00:18a0:b0:71e:786c:3fa9 with SMTP id
 d2e1a72fcca58-72062a5d8e2mr11272201b3a.0.1730078586612; Sun, 27 Oct 2024
 18:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com> <20241026154629.593041-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241026154629.593041-3-mathieu.desnoyers@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 27 Oct 2024 18:22:54 -0700
Message-ID: <CAEf4BzaD24V=Z6T3wNh27pv9OV_WaLNQeAPbUANQJYN0h5zHKw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	Jordan Rife <jrife@google.com>, syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 8:48=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> The grace period used internally within tracepoint.c:release_probes()
> uses call_rcu() to batch waiting for quiescence of old probe arrays,
> rather than using the tracepoint_synchronize_unregister() which blocks
> while waiting for quiescence.
>
> With the introduction of faultable syscall tracepoints, this causes
> use-after-free issues reproduced with syzkaller.
>
> Fix this by using the appropriate call_rcu() or call_rcu_tasks_trace()
> before invoking the rcu_free_old_probes callback. This can be chosen
> using the tracepoint_is_syscall() API.
>
> A similar issue exists in bpf use of call_rcu(). Fixing this is left to
> a separate change.
>
> Reported-by: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
> Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle pa=
ge faults")
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
> Cc: Jordan Rife <jrife@google.com>
> ---
> Changes since v0:
> - Introduce tracepoint_call_rcu(),
> - Fix bpf_link_free() use of call_rcu as well.
>
> Changes since v1:
> - Use tracepoint_call_rcu() for bpf_prog_put as well.
>
> Changes since v2:
> - Do not cover bpf changes in the same commit, let bpf developers
>   implement it.
> ---
>  kernel/tracepoint.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 5658dc92f5b5..47569fb06596 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -106,13 +106,16 @@ static void rcu_free_old_probes(struct rcu_head *he=
ad)
>         kfree(container_of(head, struct tp_probes, rcu));
>  }
>
> -static inline void release_probes(struct tracepoint_func *old)
> +static inline void release_probes(struct tracepoint *tp, struct tracepoi=
nt_func *old)
>  {
>         if (old) {
>                 struct tp_probes *tp_probes =3D container_of(old,
>                         struct tp_probes, probes[0]);
>
> -               call_rcu(&tp_probes->rcu, rcu_free_old_probes);
> +               if (tracepoint_is_syscall(tp))
> +                       call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_ol=
d_probes);

should this be call_rcu_tasks_trace() -> call_rcu() chain instead of
just call_rcu_tasks_trace()? While currently call_rcu_tasks_trace()
implies RCU GP (as evidenced by rcu_trace_implies_rcu_gp() being
hardcoded right now to returning true), this might not always be the
case in the future, so it's best to have a guarantee that regardless
of sleepable or not, we'll always have have RCU GP, and for sleepable
tracepoint *also* RCU Tasks Trace GP.

> +               else
> +                       call_rcu(&tp_probes->rcu, rcu_free_old_probes);
>         }
>  }
>
> @@ -334,7 +337,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
>                 break;
>         }
>
> -       release_probes(old);
> +       release_probes(tp, old);
>         return 0;
>  }
>
> @@ -405,7 +408,7 @@ static int tracepoint_remove_func(struct tracepoint *=
tp,
>                 WARN_ON_ONCE(1);
>                 break;
>         }
> -       release_probes(old);
> +       release_probes(tp, old);
>         return 0;
>  }
>
> --
> 2.39.5
>

