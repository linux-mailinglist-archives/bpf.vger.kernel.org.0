Return-Path: <bpf+bounces-66683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E6B387AB
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052B13A9FDD
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF52417DE;
	Wed, 27 Aug 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGuHaasj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CB21ADA4;
	Wed, 27 Aug 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311725; cv=none; b=PlSxlVB9xfU+W1GuYISAFfMCHMvQ7+uaX77XzLgt2R7pofs/aSHfBWvwgUCgZKa9IdKKXFiFewuoRlYFRowRNRYYLzKNaKmdWVlrm/UM6K43P/uGSpJLcBwzrrR/ewbPDhCza8+jyHmZUiXy25UfvGL5+oVHBubW7lAKuUitvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311725; c=relaxed/simple;
	bh=jCxCe7NfFgfjNDubdChvfWyemaO1MU4Akx1GvD0fAs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE/SPlMxbk3qjqr+9kl/PfELEx7It1rgI6/N7bEeUpDkySQkwMwgTAA3R+dxSlimH3g2Z88RE5J7IP/WCh9W5IYwWPpcmAXX+4ps/zh0nMIXK8Nn8XtGMmDjjZdQTNFsODWEhTIzlA5J8f0AOabvXBvioQUkBnWowBlF8OQgSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGuHaasj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3cbe70a7923so1295632f8f.2;
        Wed, 27 Aug 2025 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756311722; x=1756916522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D3AJk4D2c4vynhddacA8LBhopdWO4yfWWNEYOAts+o=;
        b=KGuHaasjy751FjsmNLMdZU3Im4Zd/7xajWs5TdBEh3XJUptSGv3joA3i4cd3jWRLX9
         5aB3VjiTFjKjsh071RZ3VtwOIIwSNSYPMgtpPY09Us+iMaFYNab/OJ0jpf8SqwT45QpQ
         an0xE4fvo7LHTcoKRLssv/eDZmswlrbIyqkDe0sQN04f0XS8O/5/hR8D1/gtXYGVV/KT
         xOAlh8kr+d+4SSE6ciXo0n2bHlCdqNK00ZAXki/eyjGom09cmrdIOi3jVJjTC58kIlTs
         yZoih0fFyLiYboVrU6J07wqf9ib6V7v8ixAthedfRVZKCAmx3feabvOLt3mAAEV7MJFC
         T0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756311722; x=1756916522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2D3AJk4D2c4vynhddacA8LBhopdWO4yfWWNEYOAts+o=;
        b=RwtkuK6STsxg1+GQj5BQs0WFzRm+MsV+EHeJBvTsaMIbmLwXiWqjezZftkFZHd3R+C
         lFfHVWdPaBuXe8OaOm2D7o0KMqX1wLrg4k+84RWlRe+HidqS5zl3D76ryVkzLVCIcmTz
         sjXhWXvIu8CwzljJWuvtnffJJzGvn883Bj2y6nWD3k0PxxZBG/HYI3KQQTmo1VOCde+H
         NtgZgqQAamtG+ql2dnrLGnunuy2kXrdLMEm01486m60RVNR/M7I1OLEjlzna5gc/Q3ff
         OLc7JaCBjKJTR111IUBHOUh00llu0x4TTWa6iBl9UqEgsNnqPOmAXHdmQ/Lj8iZASrbN
         RfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi1eSikhc9V7qbxreRa8jqSs+ellf1ufbnqls8mbZM0ZGvS5GhxAod+fPXIqMfpZhhGdGqIQ1wwfYMstH7@vger.kernel.org, AJvYcCWKbDr+ioj2Q80H12dQK+wtjYUNfNXMh5bnEoxCtb3/382zqn5kr+K2s8uEgkq3xMXHKTE=@vger.kernel.org, AJvYcCWPDfq5Te4AeSv4911MlPS+6y3iCBpEuRwUdiFWNcySueQ5Qf1WVafk+vVzlGz18+4LKz0dKQW1TP8iJr3k0zAZ1XOY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Lhs8/mqP77gBb+NghirVzwaC4npcaRYkWlLvftY23WAS4IZi
	cofg80UNzJ2nGR9HlDONa8K0LQug1IEdxrSLaWO5fOSYnAshpqV9avYWj1cD1Ti93RJav00B9NH
	8KJ68bBp5i55vvGcSAl8LZ8UM2baYPTw=
X-Gm-Gg: ASbGncvUiX1RIDTTbEFaX17Y3zr5KiZ4owASdzNuo2EV/EgY8D+DDZ4T7F3H0w2RMiD
	CgiJSos2gvqc8LubvIH3wrlM6d9OP6OhD+PpItP8mKIh15PCk2heU8ayrk9gJbJQLeB1jScBmA1
	LLQlxB7xZLgOr/da0yUESI9qHupyIr683fHwPbax9Gg6mYhK2Fwd3+ofnd6Fyq53rmjFeYvfGKi
	b3yFnAhiTZA49TXIJTs0ZFYWd55WZwISg==
X-Google-Smtp-Source: AGHT+IFiweMNZe1Ue2jbWG+XrQZJD1Hhj87E+pj9VWnLFhG+6/ADwNhXG1QOFlSsoFq5TJR5UJpZyImKjFyDkhZ90UU=
X-Received: by 2002:a5d:5d06:0:b0:3cb:6ce9:75f9 with SMTP id
 ffacd0b85a97d-3cb6ce9788cmr6102232f8f.38.1756311721614; Wed, 27 Aug 2025
 09:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827123814.60217-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250827123814.60217-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Aug 2025 09:21:49 -0700
X-Gm-Features: Ac12FXw1kFNZOu-9q7VTAHMguHUr8GQYIcnv17oOnH_FM8KnK8-h2dDeHlH0dXY
Message-ID: <CAADnVQLBwjVhKFptO1_CEC9q1ugT1Cy2SiG5XgtD+kr7BTrr_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: remove unnecessary rcu_read_lock in kprobe_multi_link_prog_run
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:38=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Preemption is disabled in ftrace graph, which indicate rcu_read_lock. So
> the rcu_read_lock is not needed in fprobe_entry(), and it is not needed
> in kprobe_multi_link_prog_run() neither.

kprobe_busy_begin() doing preempt_disable() is an implementation
detail that might change.
Having explicit rcu_read_lock() doesn't hurt.
It's a nop anyway in PREEMPT_NONE.

pw-bot: cr

> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/bpf_trace.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 606007c387c5..0e79fa84a634 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2741,12 +2741,10 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_mult=
i_link *link,
>                 goto out;
>         }
>
> -       rcu_read_lock();
>         regs =3D ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr(=
));
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>         err =3D bpf_prog_run(link->link.prog, regs);
>         bpf_reset_run_ctx(old_run_ctx);
> -       rcu_read_unlock();
>
>   out:
>         __this_cpu_dec(bpf_prog_active);
> --
> 2.51.0
>

