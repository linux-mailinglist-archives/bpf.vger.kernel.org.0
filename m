Return-Path: <bpf+bounces-50782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A323A2C94A
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63A416196D
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8805B18FDAA;
	Fri,  7 Feb 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qH1qA4gk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC818DB2A
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947048; cv=none; b=rLH971hFjKuqnyI84S7LgTZsx0Ny8MnRNo5vhRb265IeskXMyVLzD31bSvWukEHC4IEvA6dTs4tcSidDujIobhW+FY3M3m067MPQSasa02QKHFBfvf7bS6v7Qvc/t1c927cUevQI6kgPQB03lOD/Xkq5SGVHLlgDAflEUCR6sfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947048; c=relaxed/simple;
	bh=aPBkZDl/m4Qspl14MEY6KN0Fw6qRKdLc63tzwqiKBVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+wv7yRhGAyc7dVJBqHi/zzp2SKUZfFHTpGFnoGaxKkYiZ44Ncxy7w7A6WEXgQ95uSqEWHaIft7kK6FW9iIBClBJYWbQiOs9mAO7CEgqk6TEvldi92nC7PiNz/GM63xFCmWDB6xjQXbZKQCDiKrT2Otjde2aMmOm6KEZs8a5jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qH1qA4gk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so12061a12.0
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738947043; x=1739551843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPBkZDl/m4Qspl14MEY6KN0Fw6qRKdLc63tzwqiKBVM=;
        b=qH1qA4gkY/CpOnT5oAPiRTR5tiqxMHvnqiUPVNtE6fVOAgm4z6HZxjUKoLFujQZVtb
         aHu0ZE+flOC7tJve/ZF67alkV/6ISN2mX9BClB2TrokRiD9D/Zut/RbzZGZq8VOyWu2B
         5T39ZTsx0aGKKqyUWQXpmwWEedfLoCG4eN2poODUs3N7rqF9F3CIMShBNldvFbm7wWrz
         H74I9BU5q3hey8sSJb0EHSnQPfSdMFu/huzJUZPVedr93v8KuH/UR3/oLlYlQUeUMtp1
         2FhPPb+ju249TqmGroFgiOIP31jAGam1Rm1xeIA4F43EVNwdX5kg41db6dggWGB42/3/
         xf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947043; x=1739551843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPBkZDl/m4Qspl14MEY6KN0Fw6qRKdLc63tzwqiKBVM=;
        b=vBMsoNzx/GH+RC5OipI1MAwTjGBloIShWn5xTUdQlBKPnCI9hyKv2SYwVMarJDMP47
         89VMkPmLOTRFHlSXTIXp2Zji/v98bMqZ4LnnZ95/dePTHvmeBbeHIvjdMJ3VU2jpePW2
         v/ttTpBbzwzpVOEMcGwn5q3KyIWuCONxVATgy8CTUvbt3osZ8VZVfx+fLYYKfSObKYml
         Bqu3Op5ubJdqeVJj8LXLf+m4x9klJR2BKULpo5C4/xajJ7TihvMZyV4xBEe6JknwfN39
         hmNQ8zbPa8R/S5iA7PYvgsvgCWUwtBoi50QM+QA1R0apRIle6lZaJMhWK8TEsbZTaG30
         oMog==
X-Forwarded-Encrypted: i=1; AJvYcCV08paJVR5eJPka9dRUepazfVGKRKcklApR35UkL4xn8vg3martfWj9IZXtxIwvCZXtAsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsKW81tbaXiNcV+eFeBZ/2+O2ywoOwvvNHnHWxCoA8+CN2xYy
	eNSfYsjKwX+O2MlT+zNXyn5Xnr8I0IbyYKer+yAyU1PVyhvXQH0yfZNo9UfAoBL3K5WkzLX2yXS
	iKYlDNDkzOdo1BjJeVK2AsHxmwtFT0+GQANYe
X-Gm-Gg: ASbGncsRO5fQDhSbtp5+QCBmLlz43R/Tmfu6ftPKnLOB3M76Zn4GqwGwlD6pf+qden6
	qgashVE8bwO7JDyvqBGvql6pAEWTKaUBoquf0LXbacQCxuOb4se6uY9D7MsbwCQYrPYWK/58aLS
	euGkTl7a9biX7bS6LLFLfJOd4=
X-Google-Smtp-Source: AGHT+IEF6TMgHg91uuYvMyntZQJrsyMXP7NnVk9IAG0elRzcK8gPqLJatjsvPJxCYVqWs5mWaF1xWRYMHmsCfe0F4NQ=
X-Received: by 2002:aa7:d441:0:b0:5de:38e7:c864 with SMTP id
 4fb4d7f45d1cf-5de46900143mr124485a12.4.1738947043132; Fri, 07 Feb 2025
 08:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202162921.335813-1-eyal.birger@gmail.com>
 <CAG48ez1Pj6MT=RV-sogtNbw7WLLmCrC-3TkNfRjpcCif8iNGkA@mail.gmail.com> <CAHsH6GtiwCGJevfkE5=VzzuQcusKp-ugnRD+AD+5a+8kqOGyZA@mail.gmail.com>
In-Reply-To: <CAHsH6GtiwCGJevfkE5=VzzuQcusKp-ugnRD+AD+5a+8kqOGyZA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 7 Feb 2025 17:50:06 +0100
X-Gm-Features: AWEUYZmXc_6bGyGXPbhUQLG44CKNvo7X6skdH1pv_MYBSLuJ5OXxGW_nuazaMbM
Message-ID: <CAG48ez0c-n1K=Ui-Awp+pGq-k6QvaWarjqz0znyKi5HO5R5P7A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through seccomp
To: Eyal Birger <eyal.birger@gmail.com>
Cc: jolsa@kernel.org, kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	oleg@redhat.com, mhiramat@kernel.org, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 5:20=E2=80=AFPM Eyal Birger <eyal.birger@gmail.com> =
wrote:
> On Fri, Feb 7, 2025 at 7:27=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> >
> > On Sun, Feb 2, 2025 at 5:29=E2=80=AFPM Eyal Birger <eyal.birger@gmail.c=
om> wrote:
> > > uretprobe(2) is an performance enhancement system call added to impro=
ve
> > > uretprobes on x86_64.
> > >
> > > Confinement environments such as Docker are not aware of this new sys=
tem
> > > call and kill confined processes when uretprobes are attached to them=
.
> >
> > FYI, you might have similar issues with Syscall User Dispatch
> > (https://docs.kernel.org/admin-guide/syscall-user-dispatch.html) and
> > potentially also with ptrace-based sandboxes, depending on what kinda
> > processes you inject uprobes into. For Syscall User Dispatch, there is
> > already precedent for a bypass based on instruction pointer (see
> > syscall_user_dispatch()).
>
> Thanks. This is interesting.
>
> Do you know of confinement environments using this?

Not for Syscall User Dispatch; I think that was mostly intended for
stuff like emulating Windows syscalls in WINE. I'm not sure who
actually uses it, I just know a bit about the kernel side of it.

From what I know, ptrace sandboxing is a technique used by some
configurations of gVisor
(https://gvisor.dev/docs/architecture_guide/platforms/#ptrace), though
now I see that that page says that this configuration is no longer
supported. I am also not sure whether you'd ever have uprobes
installed in files from which instructions are executed in this
environment.

> > > Since uretprobe is a "kernel implementation detail" system call which=
 is
> > > not used by userspace application code directly, pass this system cal=
l
> > > through seccomp without forcing existing userspace confinement enviro=
nments
> > > to be changed.
> >
> > This makes me feel kinda uncomfortable. The purpose of seccomp() is
> > that you can create a process that is as locked down as you want; you
> > can use it for some light limits on what a process can do (like in
> > Docker), or you can use it to make a process that has access to
> > essentially nothing except read(), write() and exit_group(). Even
> > stuff like restart_syscall() and rt_sigreturn() is not currently
> > excepted from that.
>
> Yes, this has been discussed at length in the threads mentioned
> in the "Link" tags.
>
> >
> > I guess your usecase is a little special in that you were already
> > calling from userspace into the kernel with SWBP before, which is also
> > not subject to seccomp; and the syscall is essentially an
> > arch-specific hack to make the SWBP a little faster.
>
> Indeed. The uretprobe mechanism wasn't enforced by seccomp before
> this syscall. This change preserves this.
>
> >
> > If we do this, we should at least ensure that there is absolutely no
> > way for anything to happen in sys_uretprobe when no uretprobes are
> > configured for the process - the first check in the syscall
> > implementation almost does that, but the implementation could be a bit
> > stricter. It checks for "regs->ip !=3D trampoline_check_ip()", but if n=
o
> > uprobe region exists for the process, trampoline_check_ip() returns
> > `-1 + (uretprobe_syscall_check - uretprobe_trampoline_entry)`. So
> > there is a userspace instruction pointer near the bottom of the
> > address space that is allowed to call into the syscall if uretprobes
> > are not set up. Though the mmap minimum address restrictions will
> > typically prevent creating mappings there, and
> > uprobe_handle_trampoline() will SIGILL us if we get that far without a
> > valid uretprobe.
>
> I'm not sure I understand your point. If creating mappings in that
> area is prevented, what is the issue?

It is usually prevented, not always - root can do it depending on
system configuration.

Also, in a syscall like this that will be reachable in every sandbox,
I think we should try to be more careful about edge cases and avoid
things like this offset calculation on address -1.

> also, this would be related to the
> uretprobe syscall implementation in general, no?

Yes. I just think it is relevant to the seccomp change because
excepting a syscall from seccomp makes it more important that that
syscall is robust and correct.

> To me this seems unrelated to the seccomp change.
> Jiri, do you have any input on this?
>
> Thanks!
> Eyal.

