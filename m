Return-Path: <bpf+bounces-50781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68A8A2C87C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F332188B92D
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E818E35D;
	Fri,  7 Feb 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBU3tCyd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585D18DB2A;
	Fri,  7 Feb 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945258; cv=none; b=B19iJ0AR8M87kCVck0/6aKH3xlpUEqg3zQJBnK7N6/B8mFJ4nzTmth+rPO6YVD5nW8jTV29g4D7r4x0IqqC4cphUGqnQXsM5kWlnrIhoLQpxmgLjdc6FmonFFbRv3Fw+8LNuhm/66QUYmQDt8qknIFOSPCxRcCBVec3H+yVhdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945258; c=relaxed/simple;
	bh=Q+jJuko3vRFuWcjBjn7xFGDYWjD5CX3AQ/f2x3U2J5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdSgMqeZ/nMUCL+m+nsHAxVCMXIEpd01osGoQDkiSMNfA/5ZH0aboLUqo3qQ+gX4SUq5vUWp3G6lNNS8MHUWGDIjhUyhQ5GalJeOWL1crpRvtKYZkTVxpuBTCwR/azL4uDH7stXj7WFIUDyqoM2xl4+t6vQH14oMywnxrhV5Z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBU3tCyd; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso1249753fac.1;
        Fri, 07 Feb 2025 08:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738945255; x=1739550055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+jJuko3vRFuWcjBjn7xFGDYWjD5CX3AQ/f2x3U2J5c=;
        b=YBU3tCyd+Sf7ZOewMkp8zmpBDgonlddyiKhT5Gmz/g57tK/W/wQ5IPWytSwsLOxWYR
         j8qB95OQkGQNbX66B0SEZTY51vHcZ7JpNuYD7ogwnwGrc/7aGzNfowSNvrR4PDP+pHBx
         ihduk/vajL8vzKCCh3KRxh7DUnJleFWVrTPvQqM4nhl/4SlRiaRgX4FvSowxLIVyHzdW
         817EtznTrNFdAWwBV8TQqcS6jMyK6NnN4ZDxuKmg4e+bEiiRhoQdGJkyRQsyJgoU1brj
         z24Pa5WenaNr6RmDy/6RJJp7m/mQ+DPZxmb0axg/T7aGvWUnORJP693LNlcXFPNmwZre
         QOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738945255; x=1739550055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+jJuko3vRFuWcjBjn7xFGDYWjD5CX3AQ/f2x3U2J5c=;
        b=UhBwmhRKPc7kfLJe279DT/qb2g/fZz6uOurZuj61YfdFtgJKEvJsfh5pbniX1tWfmq
         8Ypf+EJa+SDG8j2jM2mJTrcqAccaHK4Ix405M1mNbpIcDHQQ0qQoVXsbhrksG5jTi78h
         0kIJFbrx06jh2kCqdgCW4B4o82Hqy0d+g0ACwcGHaLmhSj3YiC8ROs452KJ7eKowTqeo
         Zdq4d5GzZ7z0vBdwi8IKoOySg2MqdhFnCxXMjAIoKVMmeZZAnZ0y2ucdubu3BYfFRaha
         Js9jUe/YjobAuIWZITxP+Vx5VPJt7CruQ+97qFUa+58cjHzLVidON+itt8xlJiunrz9h
         SohQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyLn9wTgAT97OQrSZMrXxQ7n0A0i4FWMhUcC30PiiQUb+L+3VqVz6XpUNf/Ofys+eGzjgSSBrGVMpD@vger.kernel.org, AJvYcCVqHFw66a29yb+5lndaMs2SZeBxP3+/9jGb10NIovjKtbzDxnncZtG0iGBMm1rRMs3Ecn4=@vger.kernel.org, AJvYcCWf51Ji0kpltfoXMB7BPm8LlgnvrBg6AEB2IJGjCEPU0jUKCuhyi7Z8mazZb9vzFG8HmSGd0NeC2fI2g59qE+ykR8w/@vger.kernel.org, AJvYcCXQVKLTCP+8az0E3jXoNbcXplL1Ep9W9apnERxgpZCc4YPWleFiu0eypEMf5IjdNk6ef9Y6TrrsV89V9Fuy@vger.kernel.org
X-Gm-Message-State: AOJu0YwgE1/4j1jpzDq9qp7iKL4GB7qqJ5ZxaOnzv6RtkGINDXo6MBC1
	rypBzvQ+L4N/aVOmpvhrlfS1E+1Rqj/9dIKFNV45dHdIrNu2kjf6JIxn+Cze5z+a0FO771axSZ7
	DvBB2TcVKdmuEYfkGeX6WaTaGjs4=
X-Gm-Gg: ASbGncsECp5nivxyY98N3wjAMl4oNTN7Sn/yT095+L86hWuDvmbDMg8V+hxTKGivp8i
	NPCybG5rh9PKOCoyFi/CUyQJWBg1Pi2AJ9G3FUzmV1jCI60bmVgAMoLS1apYlGArnYMrevjhH
X-Google-Smtp-Source: AGHT+IHy8QAerDSS7gZMSjx/B/HCjgVcpF34r7/h7iyiuO1/5M9u9UQzyoq7BBJqNCDJzK0t4eLC4zEovNygij+7BqQ=
X-Received: by 2002:a05:6870:1b05:b0:27b:61df:2160 with SMTP id
 586e51a60fabf-2b83ef25258mr2373533fac.31.1738945255379; Fri, 07 Feb 2025
 08:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202162921.335813-1-eyal.birger@gmail.com> <CAG48ez1Pj6MT=RV-sogtNbw7WLLmCrC-3TkNfRjpcCif8iNGkA@mail.gmail.com>
In-Reply-To: <CAG48ez1Pj6MT=RV-sogtNbw7WLLmCrC-3TkNfRjpcCif8iNGkA@mail.gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 7 Feb 2025 08:20:43 -0800
X-Gm-Features: AWEUYZkQfJkHRmOvdBM-4YQL_cr5yg0xT2Y_nAss3ZMOlyFGchGJdBF7R0-XW8s
Message-ID: <CAHsH6GtiwCGJevfkE5=VzzuQcusKp-ugnRD+AD+5a+8kqOGyZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through seccomp
To: Jann Horn <jannh@google.com>, jolsa@kernel.org
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	olsajiri@gmail.com, cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com, 
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com, 
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 7, 2025 at 7:27=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Sun, Feb 2, 2025 at 5:29=E2=80=AFPM Eyal Birger <eyal.birger@gmail.com=
> wrote:
> > uretprobe(2) is an performance enhancement system call added to improve
> > uretprobes on x86_64.
> >
> > Confinement environments such as Docker are not aware of this new syste=
m
> > call and kill confined processes when uretprobes are attached to them.
>
> FYI, you might have similar issues with Syscall User Dispatch
> (https://docs.kernel.org/admin-guide/syscall-user-dispatch.html) and
> potentially also with ptrace-based sandboxes, depending on what kinda
> processes you inject uprobes into. For Syscall User Dispatch, there is
> already precedent for a bypass based on instruction pointer (see
> syscall_user_dispatch()).

Thanks. This is interesting.

Do you know of confinement environments using this?

>
> > Since uretprobe is a "kernel implementation detail" system call which i=
s
> > not used by userspace application code directly, pass this system call
> > through seccomp without forcing existing userspace confinement environm=
ents
> > to be changed.
>
> This makes me feel kinda uncomfortable. The purpose of seccomp() is
> that you can create a process that is as locked down as you want; you
> can use it for some light limits on what a process can do (like in
> Docker), or you can use it to make a process that has access to
> essentially nothing except read(), write() and exit_group(). Even
> stuff like restart_syscall() and rt_sigreturn() is not currently
> excepted from that.

Yes, this has been discussed at length in the threads mentioned
in the "Link" tags.

>
> I guess your usecase is a little special in that you were already
> calling from userspace into the kernel with SWBP before, which is also
> not subject to seccomp; and the syscall is essentially an
> arch-specific hack to make the SWBP a little faster.

Indeed. The uretprobe mechanism wasn't enforced by seccomp before
this syscall. This change preserves this.

>
> If we do this, we should at least ensure that there is absolutely no
> way for anything to happen in sys_uretprobe when no uretprobes are
> configured for the process - the first check in the syscall
> implementation almost does that, but the implementation could be a bit
> stricter. It checks for "regs->ip !=3D trampoline_check_ip()", but if no
> uprobe region exists for the process, trampoline_check_ip() returns
> `-1 + (uretprobe_syscall_check - uretprobe_trampoline_entry)`. So
> there is a userspace instruction pointer near the bottom of the
> address space that is allowed to call into the syscall if uretprobes
> are not set up. Though the mmap minimum address restrictions will
> typically prevent creating mappings there, and
> uprobe_handle_trampoline() will SIGILL us if we get that far without a
> valid uretprobe.

I'm not sure I understand your point. If creating mappings in that
area is prevented, what is the issue? also, this would be related to the
uretprobe syscall implementation in general, no?

To me this seems unrelated to the seccomp change.
Jiri, do you have any input on this?

Thanks!
Eyal.

