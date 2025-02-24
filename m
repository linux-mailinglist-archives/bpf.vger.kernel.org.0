Return-Path: <bpf+bounces-52417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D1A42CA2
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2218986FB
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9201FCFD9;
	Mon, 24 Feb 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZPnwA0H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84A1FC7D0;
	Mon, 24 Feb 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424978; cv=none; b=Do+PW5peN7xQGULyGpEF7Khgu83lWtOz/vE+p2HwVxZVd6a+ZYi+0t81VVVH2TEvwbqUgsf8JOXQqNdMSiNH5YJDvoR7x2p60QGIcIP3ploOQ+GZi51miQXxaXjgI9A4ajrGtEvVawd0UU/s/BhD7CpkvekzjLBKwtfmj7SB7E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424978; c=relaxed/simple;
	bh=vGr191suNHJMobX/xH0d0V4FfC46fopUgaS64eWuGio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHTgOsE+1kpeWJw340dPAsULG26GTAVXwlPlRF/SFvW06EkuhlBqti/tWuYQvR+yk8fx5amvd4SgwvXJzvmK3zUH0MQat6q8lYZkDwWxfdkf6eqZDX1XwMfdRuNj69LNR4tLFsporrOBin5mxhJNq8cOmHFECvqxzin0LHvbp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZPnwA0H; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f24fc466aso3634355f8f.2;
        Mon, 24 Feb 2025 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740424974; x=1741029774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2gwHImuzq/bOyTYKm1I6At6U11HqW5s/2Yyuz2olGE=;
        b=mZPnwA0HMjvjhilt4+ocKGmRDQ6YKTYRu4w+6i5xKEwM1fJHlD88s1X5alNTDqadwd
         kXV6yidiBIZ8GrU04UgZp3XqG4nEhWuXkALGb6RQ1HcqSipjgrtnnsAXhpMfuj33isIA
         VdmQhTsd8UkxTgmuveEHIGF9J7yXY2bkHnWHxqzS/8UWUcqwmWwGZFoX2YyZxfgtFu2D
         PW+tYNhhhlmtIIRnapPgLGIyq5Z9Butk2B4iKs5Q/5N/yjcGAoxwsDDLIOi8paFOgxSd
         PcX0aCXh4Bw5vilBoBZIl39GGOk8E2yCkg5SYR0rdP4ramEoa4e0GdNeWrgvUU4gAvGF
         Latg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424974; x=1741029774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2gwHImuzq/bOyTYKm1I6At6U11HqW5s/2Yyuz2olGE=;
        b=orFfubV6sOKCN3nUVl6tpFtmhfEwqNdTgLp8Ow+dK1bWNtrXRfFG0U0Zvn0DMjk3kw
         WogB6jeoQrknnnmkOkptyT78ejVVeWx6PcEZbDkU3QTdz3eAJxjJjQeehpsnLvSFX0Or
         RNUkPBKpKk9044c+jbgr4CbgT0j4xu7wl5fC8pcogY7kyshCJHGFb0fKQ2zsHV0PSdq1
         MMEJthPspdOxj+y+O9cr4gNjt7e9GYMppTXihuu/p595gxmy1AgzzfyRR3VLDmNc4ixR
         csNZcEsy8EJDxAsfPyyM+/fhUKK+2SHQ2fxsbN+45MsbonfUSfXmqJb7kDPifSD4fxah
         te1w==
X-Forwarded-Encrypted: i=1; AJvYcCUHvVfJKIpEDDcCZDeYmnjRXzDoKs/2nLarmvUiGMDpEnz/2upllowLBFLp9jqn1MsTzSBRd+EJae+LZbY5yLGu33Ae@vger.kernel.org, AJvYcCVDI5s/r6zzP6Za8cubcdRgxA3opbMNqyBSBVdgIU2vxpd9yeRcQYJK2vlSBVMK2q3Q1wE=@vger.kernel.org, AJvYcCVSC8zHA1QlT8oFdnmX6hJPYaCGq4G648Q5SBpVcBDA1BlYO8ikABfOKKSsrZ6h/J7727iDWk7waniqUTjx@vger.kernel.org
X-Gm-Message-State: AOJu0YykaIuX1gmtMMpXTWlIVcXZV3vUZ9js8Lje8OkSQ4aoV2pGpur+
	zanTqTUoYm8UzRTGcElofXh4EQTVKDE3t85STatik5JzaqL1iKOogsCxiEYdILHGw9AbjmNHk3w
	E5yeK0XHZb57Q0YlFtDD1X/gAxVw=
X-Gm-Gg: ASbGncu/GeZuegaEdLCTRadcpKpideyrwE9KWZXgK++8vT2Ezlab+9TFAhskE12KgOk
	pzimWn5TX74f/6MsJgTOAUDo2WooR66Zm7CrMBXgGQ0xffiEhxEM2yNWqewvIhgTrJH4aZWVxQu
	QWgdDZGxaImD6pkFUaQHtqktQ=
X-Google-Smtp-Source: AGHT+IHB+AWBWMWujb3mhlPpZTweDQu7gM85nkpA1ASHouT/Lu7csEogxRIcljQtw93JGoGEX+oW7MjtuiuWGRqB2ak=
X-Received: by 2002:a05:6000:2ae:b0:38d:e304:7470 with SMTP id
 ffacd0b85a97d-38f707b0798mr11924539f8f.25.1740424973425; Mon, 24 Feb 2025
 11:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224140151.667679-1-jolsa@kernel.org> <20250224140151.667679-9-jolsa@kernel.org>
In-Reply-To: <20250224140151.667679-9-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Feb 2025 11:22:42 -0800
X-Gm-Features: AWEUYZkGP788jzMs5wQ5_d8-32CVaAvKvg6jzwRmafgcfsVy_Y3Y5MT5uxFOAJo
Message-ID: <CAADnVQJ_-7cB3OaeFWaupcq0fRPh3uP62HBGxq0QbyZsx3aHqA@mail.gmail.com>
Subject: Re: [PATCH RFCv2 08/18] uprobes/x86: Add uprobe syscall to speed up uprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:08=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> +SYSCALL_DEFINE0(uprobe)
> +{
> +       struct pt_regs *regs =3D task_pt_regs(current);
> +       unsigned long bp_vaddr;
> +       int err;
> +
> +       err =3D copy_from_user(&bp_vaddr, (void __user *)regs->sp + 3*8, =
sizeof(bp_vaddr));
> +       if (err) {
> +               force_sig(SIGILL);
> +               return -1;
> +       }
> +
> +       /* Allow execution only from uprobe trampolines. */
> +       if (!in_uprobe_trampoline(regs->ip)) {
> +               force_sig(SIGILL);
> +               return -1;
> +       }
> +
> +       handle_syscall_uprobe(regs, bp_vaddr - 5);
> +       return 0;
> +}
> +
> +asm (
> +       ".pushsection .rodata\n"
> +       ".balign " __stringify(PAGE_SIZE) "\n"
> +       "uprobe_trampoline_entry:\n"
> +       "endbr64\n"

why endbr is there?
The trampoline is called with a direct call.

> +       "push %rcx\n"
> +       "push %r11\n"
> +       "push %rax\n"
> +       "movq $" __stringify(__NR_uprobe) ", %rax\n"

To avoid introducing a new syscall for a very similar operation
can we disambiguate uprobe vs uretprobe via %rdi or
some other way?
imo not too late to change uretprobe api.
Maybe it was discussed already.

> +       "syscall\n"
> +       "pop %rax\n"
> +       "pop %r11\n"
> +       "pop %rcx\n"
> +       "ret\n"

In later patches I see nop5 is replaced with a call to
uprobe_trampoline_entry, but which part saves
rdi and other regs?
Compiler doesn't automatically spill/fill around USDT's nop/nop5.
Selftest is doing:
+__naked noinline void uprobe_test(void)
so just lucky ?

