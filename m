Return-Path: <bpf+bounces-56462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91D1A97B36
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F16A3ABC4F
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0614621B9C5;
	Tue, 22 Apr 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5AKWUg7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4652153F1;
	Tue, 22 Apr 2025 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365699; cv=none; b=lQtBKKUu5Yosv5e2mt0BKi0oBi+HOrcFTRCqsTqU42Zde+Z76Wpmf322xi3t9oEA/vPPAMafFA95uS5AoDCS5W6F0RHS7wRkPTVjB4CEUEA09gZxhwvHhf5bZXCnLhYDcvXBxkOLPhJIYn29KcpHk0F4ReMgK+TCacdIcIp+Swc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365699; c=relaxed/simple;
	bh=+40hAu3bUXUJIbm4+VNTCNA9aMW+tanXGfKUVrMO/Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmWqROntsTyycKNH+sdcdS8g2ktLurmH5pXHuzhhdXlltBMULCAEyNBp3Y9fG/wJSTgj2CXh5JSkO1/jKVolSyQbd7XPJ4WDRD7DmHltmC990hErdOK7UvxHOQTlxncolXAsIZpuB+to7+Dtuk5CFs1Jxb+HtkH/moXAoC6N3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5AKWUg7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so6058478b3a.1;
        Tue, 22 Apr 2025 16:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745365697; x=1745970497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eShSuHzF8zRgOXJ9h+TKKwhpFe0OJ/PDxiZ/WuLMR9g=;
        b=g5AKWUg7aqKa5XXCFOFjdWm69yI2kTQuIXdKRV905AzQzzBghdRNBSnISF9Om9yf4H
         FzuOvTbyZIgyGSmUGKtUuLbf5XQl65ICe9aP3jnHIm7GDArBt60qpegC0LlrfzSjtpsY
         3w3d7FruKmrxfwJ2iXd3/kEy+QyQPyB61L+UVDwH0fFL5Thws2HQkDcSVYqIZ15etck/
         bjZeHWxHChJ+ycCpTAbQ3iOODL1DOMaQ5noSVJ8AvaMu0qwcO4E3j7e7tsgHTmLUPpGZ
         v93bhC9jCTon2V/4g6JOxlQxmnXApXn5Iqz0LzqeNxK9EO4DLCicbFO5ufqpdi2P+utr
         GURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365697; x=1745970497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eShSuHzF8zRgOXJ9h+TKKwhpFe0OJ/PDxiZ/WuLMR9g=;
        b=HRAYntO1n3GR8ElJ/v+L6lICSwbibOyO+LNaNxrFoBPwOPSZvX/nNqRqz8q3qZGdp7
         TMaNY0yoOWwuxWa2HfM8EaBKxDqFQYPUV05tPRaOxSaDD4Qz+UB8u8U0jF5DnEijk0fS
         mEug9mJMFtEirzck3le3I35UDxuGCX10UfYWl5UNZbrz1Mu6A4RoAnXuPxiGn7PbC2m2
         kWpIR1rGiEi18HqVCHhq8XUAANastmX8nLgJ7JDJXDvg9yAwuUmuEhirJE2j1T4RytI3
         tSsEb0EIcqVtdVVKvMFgrmGl00tMPUKFuY06wkmh3a0MxKmO+q0OMNAh5ETO9muKzHSb
         EKJg==
X-Forwarded-Encrypted: i=1; AJvYcCUu2E3edlScLFc4cgEFEfHT37DVicrMduS/G+J7U4fZGZRnsbXrNc4XAcz4MQ7vVypdq6+J7Xl3tXGh5rdiPP0Vl3O9@vger.kernel.org, AJvYcCVKb7we+9tKKcyGeHDlxUERyOsjxhRGZ2aa9tF1jy6xE6m93NX3NK+uLrAwEf/5OTh8xoA=@vger.kernel.org, AJvYcCWP+lqvjh3XRmg4AzasIgZ+KATidq+5YYbzaTMvjAtzIx15+CE6nnMsceZxKZJryNo6OsggXaHBE1hfxFd+@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqK6SyyEWGSdUibCQdcwSSFF4rm/oBWCICisz+8cJLSs0hDG/
	bcsmj7XhdUzBak1L2zijTb6GiVvA9UM9zDsYF5qRS3e7w51H7PMd/JkZ8xoP8qlseKew9JQwhuv
	ldcvUo3lV/UBfKSfF/zmDMaWlj6A=
X-Gm-Gg: ASbGnctOvRD7TaGnYdUIqc4UkuoE8BwzU4STiEwBK2dfmc94l/ErKiwSrbtIc2pF6id
	9PKgXk1sDLK6IIAs0eDGpATWlqmj3AH/tl7Z1DXRld//ph6RMpSIXE8o6De4VFoiIL7Jh5aAIRp
	Wo5GoI+EI3+V6cYHno0qSUlPNPq3h/3kOGB6dkwg==
X-Google-Smtp-Source: AGHT+IEu0yYtokeCyy8Mo5SZuFzYNZEwB7ykdkZ1iVrZgv0wCrDda5aqI83NKuD++K7zVDpzIO0QFYdy19cyM8m7r1A=
X-Received: by 2002:a05:6a20:9f46:b0:1f5:9d5d:bcdd with SMTP id
 adf61e73a8af0-203cbc056f1mr29761096637.1.1745365697332; Tue, 22 Apr 2025
 16:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-10-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 16:48:04 -0700
X-Gm-Features: ATxdqUG6y22eK7OqIgrCK3eoJYN6m_lwL1AWftBr4wBZAjPZkXExZ4GLtq-CVoE
Message-ID: <CAEf4Bzb9tTQMR2C+kpFxKqaXabTZN91LX-6hSyqknp4=aLcXtQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 09/22] uprobes/x86: Add uprobe syscall to speed
 up uprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:46=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new uprobe syscall that calls uprobe handlers for given
> 'breakpoint' address.
>
> The idea is that the 'breakpoint' address calls the user space
> trampoline which executes the uprobe syscall.
>
> The syscall handler reads the return address of the initial call
> to retrieve the original 'breakpoint' address. With this address
> we find the related uprobe object and call its consumers.
>
> Adding the arch_uprobe_trampoline_mapping function that provides
> uprobe trampoline mapping. This mapping is backed with one global
> page initialized at __init time and shared by the all the mapping
> instances.
>
> We do not allow to execute uprobe syscall if the caller is not
> from uprobe trampoline mapping.
>
> The uprobe syscall ensures the consumer (bpf program) sees registers
> values in the state before the trampoline was called.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  arch/x86/kernel/uprobes.c              | 122 +++++++++++++++++++++++++
>  include/linux/syscalls.h               |   2 +
>  include/linux/uprobes.h                |   1 +
>  kernel/events/uprobes.c                |  17 ++++
>  kernel/sys_ni.c                        |   1 +
>  6 files changed, 144 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index cfb5ca41e30d..9fd1291e7bdf 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -345,6 +345,7 @@
>  333    common  io_pgetevents           sys_io_pgetevents
>  334    common  rseq                    sys_rseq
>  335    common  uretprobe               sys_uretprobe
> +336    common  uprobe                  sys_uprobe
>  # don't use numbers 387 through 423, add new calls after the last
>  # 'common' entry
>  424    common  pidfd_send_signal       sys_pidfd_send_signal

[...]

