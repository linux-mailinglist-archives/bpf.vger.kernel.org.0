Return-Path: <bpf+bounces-33841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B0926C6B
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 01:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1902828A4
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9865194A6D;
	Wed,  3 Jul 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaNBnZSf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBDB17838D;
	Wed,  3 Jul 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049211; cv=none; b=W4LiBkKQ8tfLYhFx1BPhYx614150i4bidtNiYQfHfirm2WpUXL9T3QaneXi6dzvKmy5omJqBWcjJJeNfjUaNZysuUFgOMvpv+TrLOyR1SRhUILZPWki4jMCfgaxwcQ03NXjR/Gib8My0woRHtIX26n6x7Niz4hdA0FUSZyhGZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049211; c=relaxed/simple;
	bh=/I4zR2Jxebxcv3lm4liZ8+T/2eec+pcepi3f9aw53bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBzKMZUKfb9poVkyto3YonLda4RrlNwo9hFhzuzrhqsyUrvoURjFJCfeQa/URd7DK8um5aDa23PZDoLj6neyNrXOtwAabFrheJoK/vqttiJ3Teeyo7SrVs0mGEOHTQUMvO7bh181JdLsoSMjI8IrRO2uaeVuqb8hnNQVbB7B9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaNBnZSf; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d566d5eda9so49023b6e.0;
        Wed, 03 Jul 2024 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720049209; x=1720654009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HXePwbqvjghg/jCRXhGgfiZPDFLMmhiGck4biFS5sU=;
        b=BaNBnZSfIOiXNl3cpwBxxBUIRaCrt7dup/di+kQvAB5fdMDlOwI+AxMCCAwaJXirXB
         l0LI96J9nuMEKbIAUCIz5KF2XR7YILwaxqRvCbxFil/hfAiaYHBJklo3zRrbNlnWPeqs
         D96mL7Js6Zw94d+LzsPcsrpdVWfFun4eprMMOxBs4y5kpMwzWb9HkL9RBjqfjWB/v9m4
         iL0tHkzhwfh+6hdZjGNYcc9UUdWy3uZwhr3SDZ9bfnB2NIJnlkHfMlv8YfJi4unnNlJb
         Ixq4/gFpulGKu7m3EG1+dqP2xWN0XLy+TMHwiVm6XXkBXE+BmKBzzLNvw/uuE+x/hPnF
         9j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720049209; x=1720654009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HXePwbqvjghg/jCRXhGgfiZPDFLMmhiGck4biFS5sU=;
        b=uxVDMY220/Nus0L4hPYxtjlhcExKP+MHwOaAD1BIVD25ZGoggjGkg2BhZ9agEpDkqC
         RMpjEJ6Nym/5uffbi23FZSWAmkVn+EGKu/LRXccMvkjPeMV7BNak/k2W0KO7fUMOa5Ap
         ZsMcJlxpUw0kvMXqOsSybtwZoVPq136eQsqL0A4Qhv62AE4DoSfNaQsDozll0B1jUjTn
         Gq8NmG5S0L/XSLlYbkpwQr8F6dDYhHslz7PsYBsRo1/GJ1sQDMttDJiCxR7CxKa52497
         274SMOkr0iJnSZkcu6QsOspmcw3a3WbL6zhQilvX+rz0YfXXMzW+ajWh8xMrOcGZ7fRY
         bGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwaZoYXPQnq02/3XEBFoOFtCRyXzDo1m2TXt4Hg4l7s9kN6E4uZv99407SVU0N9G7usTZidhTM7x7H0DOQxwoen3tstyU6Z0VxwYQh0bzovybhjDq0lsWdRUlrmYjaIqVhF2mUc/gesipLm5MrHqZpjCTew6ku+jPXrSF9ipuHq8nJAkbM0EnBZY9JfWSM3Eip8H8a32dBGzPq14+sDK7M6dSV3YBwjQ==
X-Gm-Message-State: AOJu0Yw1uwAFQT0HhQodL6jQtzvaNeN21Q6PiZIF0OKbZDSHGt0kDtKd
	/ZLjx+MTGtv4E2g9J4tlIMI9/+HTHaNPV40mMdmE12pDjlg1Ung6LY4tFM7RAcG5sy469H4ZKQv
	A0p5eqXsHnYFC77R2aXyxgo95PIY=
X-Google-Smtp-Source: AGHT+IHawKE8y6ADXQN4QpihhsZLlwXk2aAtwmYmiDAT27uTStzJkBHG3ApvbBZ4tqnJtJI4D8hA2umF3on6Joe6pow=
X-Received: by 2002:a05:6808:1918:b0:3d6:38c2:fcb5 with SMTP id
 5614622812f47-3d914c4b21fmr64100b6e.3.1720049208375; Wed, 03 Jul 2024
 16:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703040203.3368505-1-andrii@kernel.org> <20240703223927.zby4glzbngjqxemd@treble>
In-Reply-To: <20240703223927.zby4glzbngjqxemd@treble>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 16:26:36 -0700
Message-ID: <CAEf4BzYja7imAz-kW+6WF03dQGkwfugw79p6reVmHbc8BTFOjw@mail.gmail.com>
Subject: Re: [PATCH v3] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	x86@kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:39=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> On Tue, Jul 02, 2024 at 09:02:03PM -0700, Andrii Nakryiko wrote:
> > @@ -2833,6 +2858,18 @@ perf_callchain_user32(struct pt_regs *regs, stru=
ct perf_callchain_entry_ctx *ent
> >
> >       fp =3D compat_ptr(ss_base + regs->bp);
> >       pagefault_disable();
> > +
> > +#ifdef CONFIG_UPROBES
> > +     /* see perf_callchain_user() below for why we do this */
> > +     if (current->utask) {
> > +             u32 ret_addr;
> > +
> > +             if (is_uprobe_at_func_entry(regs, current->utask->auprobe=
) &&
> > +                 !__get_user(ret_addr, (const u32 __user *)regs->sp))
>
> Shouldn't the regs->sp value be checked with __access_ok() before
> calling __get_user()?

Ah, it's __get_user vs get_user quirk, right? Should I just use
get_user() here? It seems like existing code is trying to avoid two
__access_ok() checks for two fields of stack_frame, but here we don't
have that optimization opportunity anyways.

>
> Also, instead of littering functions with ifdefs it would be better to
> abstract this out into a separate function which has an "always return
> false" version for !CONFIG_UPROBES.  Then the above could be simplified t=
o
> something like:

Sure, can do.

>
>         ...
>         pagefault_disable();

But I'd leave pagefault_disable() outside of that function, because
caller has to do it either way.

>
>         if (is_uprobe_at_func_entry(regs, current) &&
>             __access_ok(regs->sp, 4) &&
>             !__get_user(ret_addr, (const u32 __user *)regs->sp))
>                 perf_callchain_store(entry, ret_addr);
>         ...
>
> Also it's good practice to wait at least several days before posting new
> versions to avoid spamming reviewers and to give them time to digest
> what you've already sent.

I'm not sure about "at least several days", tbh. I generally try to
not post more often than once a day, and that only if I received some
meaningful reviewing feedback (like in your case). I do wait a few
days for reviews before pinging the mailing list again, though.

Would I get this feedback if I haven't posted v3? Or we'd just be
delaying the inevitable for a few more idle days? This particular
change (in it's initial version before yours and recent Peter's
comments) has been sitting under review since May 8th ([0], and then
posted without changes on May 21st, [1]), so I'm not exactly rushing
the things here.

Either way, I won't get to this until next week, so I won't spam you
too much anymore, sorry.

  [0] https://lore.kernel.org/linux-trace-kernel/20240508212605.4012172-4-a=
ndrii@kernel.org/
  [1] https://lore.kernel.org/linux-trace-kernel/20240522013845.1631305-4-a=
ndrii@kernel.org/

>
> --
> Josh

