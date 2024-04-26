Return-Path: <bpf+bounces-27958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524C8B3EC6
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4393E2829C8
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4DE16C688;
	Fri, 26 Apr 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht3w4aX+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207445037;
	Fri, 26 Apr 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154349; cv=none; b=NlvI653NCbt7ZoKcAotJkWfCTCVBbAS6V6vjdUjjx7X8ZZ0k9GxdUUQWZsnwiQuSLEcXYFL9maM0V5quvaiVQJYXR+K6BwCwNNXTioGsUKx2gdqlBxdHgQmfi/QkPYMw7bHGbwuHuEsSnqZkv6wM78zUv79mxeEqJGBrUd/PLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154349; c=relaxed/simple;
	bh=jLXLjmPCCy2WMtXuYXb1yzwYedv2/aiycIzCZCtiSYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peraID4R6qKQW5/zf05dQHNX2S4xFhwnnQzBIEG3zxS9gDteQH3cAqtwhZDIoO8q6aYHJ4qoS3NaPW4BgC46LAq5hz5agZeqGrsvH5guXD1EvPbCs2+72bz8lvmUM5RZ7nth3PhpO+E0R3kjDRURzFBrqFvUQoWhbndI8b3/Fw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht3w4aX+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so2061997a91.2;
        Fri, 26 Apr 2024 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714154348; x=1714759148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7URhKYHzpKyiBcok2oJAmJmsMfJGo9/k3ZcIBr4z04=;
        b=ht3w4aX+vjkiB5HO3uVg3s3ust9/RF4STPT+0K3I7RN8qr4QX/7tKf6Ird1kcjkmcE
         flZ3HPkVjbhULG/EdIG4RbcvIBKcYcvBfVbpl6PH7pt7XVlHu3P43x8jobda4ao+TVl8
         4BCYZEfj/3ZZMALmy5yH5YjojX915bAd1VndXWfY9efdC08UDByvPveTiS2gI7S9hzO+
         AXlfW893aui+kJDPpRT6zyKh+fAs6KMISA8n8N7dc0UHQ36t6LPQ/Izzsd4etJYKSGgt
         gi1xIh8Hv7RZ7LZYN7PAoXUYBJ80dl4lF37X9t8NQ3Sob3Ayp21H3jr1Fzk+i/wb3AiF
         SAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154348; x=1714759148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7URhKYHzpKyiBcok2oJAmJmsMfJGo9/k3ZcIBr4z04=;
        b=tJ+RVd8v0jYejQYXcRrpSakr8sIgSAsKEOo+0E+apiwDnfzrFo+MWoaWXrC5Kt8/NI
         QNHI0FTddxkTqMPORU3BGQ3tWLHoKYKtX+Vo997KyV1XlZ+09DsOXzmjGTK2wWj8ayYQ
         5miKJf0Gtj/IdDd/QZP/Uv9PNfA9q+g6xWPTiJeX3DjfJu96FCH6XQ5urXtWIlU2/r32
         ReU5SxDWT8b0OVC8zusn2YjggMYYQ7aZVfzDLn2wgzw+JpNaBBCw1um6E97oyNV0PFDe
         PvLWwCusBfc/KEJ1SrtfQvrpFXxsfyCHRka9MZm9yk9Qlm7fcsoxNNdKFNMvs55OnKLS
         OtZA==
X-Forwarded-Encrypted: i=1; AJvYcCUVuUt+SJ87jXlKciD3amAUsCD7GwsOuYLyP0gBxAhw3MEV0Gos1KRp21kchIpodNgeUOFH+Q8xFW1R0hX3Sqx2gowJWK8lSTx4w3pAhVtfnYa8YX652nsMoFgHMjUVmJsJmifhfNdDegSPOj8NIwiLEDdjq45GvHeqLFfqXmb5bQfh8xqgfUoLlfSZs23iZUF3rHtZF1u05rkLJqfnluLi
X-Gm-Message-State: AOJu0Yxrwo6ox7jo4ioEfSiEHESc+JImSxexbWDQCJslUVQT8rU6/x7O
	AsXPPzIkAiSxYagdKJLZQ+A5vEE9CkTHdIQJYA/NbTZLsF7xdX0StCG+6Di1YD2jo7UbD/+PFrD
	JpycxAvbYJAGr39Lga/9YrAd+5h3aNDjcHmo=
X-Google-Smtp-Source: AGHT+IHQGcVwu2otK2Q/ofDPKlhlZmY9qj6taWgiNbin6u61+6952kJcDEeNN51QQ0serCWCWpwEqPbjN3KBQA6Fx0o=
X-Received: by 2002:a17:90a:ab0f:b0:2a7:b6ee:2ed0 with SMTP id
 m15-20020a17090aab0f00b002a7b6ee2ed0mr3244671pjq.7.1714154347705; Fri, 26 Apr
 2024 10:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421194206.1010934-1-jolsa@kernel.org> <20240421194206.1010934-3-jolsa@kernel.org>
In-Reply-To: <20240421194206.1010934-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 10:58:55 -0700
Message-ID: <CAEf4BzaowKhAPsY+4EN-Ak16YELeh46fCgQvry-ihS9UUa_PLA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 12:42=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding uretprobe syscall instead of trap to speed up return probe.
>
> At the moment the uretprobe setup/path is:
>
>   - install entry uprobe
>
>   - when the uprobe is hit, it overwrites probed function's return addres=
s
>     on stack with address of the trampoline that contains breakpoint
>     instruction
>
>   - the breakpoint trap code handles the uretprobe consumers execution an=
d
>     jumps back to original return address
>
> This patch replaces the above trampoline's breakpoint instruction with ne=
w
> ureprobe syscall call. This syscall does exactly the same job as the trap
> with some more extra work:
>
>   - syscall trampoline must save original value for rax/r11/rcx registers
>     on stack - rax is set to syscall number and r11/rcx are changed and
>     used by syscall instruction
>
>   - the syscall code reads the original values of those registers and
>     restore those values in task's pt_regs area
>
>   - only caller from trampoline exposed in '[uprobes]' is allowed,
>     the process will receive SIGILL signal otherwise
>
> Even with some extra work, using the uretprobes syscall shows speed
> improvement (compared to using standard breakpoint):
>
>   On Intel (11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz)
>
>   current:
>     uretprobe-nop  :    1.498 =C2=B1 0.000M/s
>     uretprobe-push :    1.448 =C2=B1 0.001M/s
>     uretprobe-ret  :    0.816 =C2=B1 0.001M/s
>
>   with the fix:
>     uretprobe-nop  :    1.969 =C2=B1 0.002M/s  < 31% speed up
>     uretprobe-push :    1.910 =C2=B1 0.000M/s  < 31% speed up
>     uretprobe-ret  :    0.934 =C2=B1 0.000M/s  < 14% speed up
>
>   On Amd (AMD Ryzen 7 5700U)
>
>   current:
>     uretprobe-nop  :    0.778 =C2=B1 0.001M/s
>     uretprobe-push :    0.744 =C2=B1 0.001M/s
>     uretprobe-ret  :    0.540 =C2=B1 0.001M/s
>
>   with the fix:
>     uretprobe-nop  :    0.860 =C2=B1 0.001M/s  < 10% speed up
>     uretprobe-push :    0.818 =C2=B1 0.001M/s  < 10% speed up
>     uretprobe-ret  :    0.578 =C2=B1 0.000M/s  <  7% speed up
>
> The performance test spawns a thread that runs loop which triggers
> uprobe with attached bpf program that increments the counter that
> gets printed in results above.
>
> The uprobe (and uretprobe) kind is determined by which instruction
> is being patched with breakpoint instruction. That's also important
> for uretprobes, because uprobe is installed for each uretprobe.
>
> The performance test is part of bpf selftests:
>   tools/testing/selftests/bpf/run_bench_uprobes.sh
>
> Note at the moment uretprobe syscall is supported only for native
> 64-bit process, compat process still uses standard breakpoint.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h   |   3 +
>  kernel/events/uprobes.c   |  24 +++++---
>  3 files changed, 135 insertions(+), 7 deletions(-)
>

LGTM as far as I can follow the code

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

