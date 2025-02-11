Return-Path: <bpf+bounces-51163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA90DA3121E
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97692165778
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F464260A4C;
	Tue, 11 Feb 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F884aayl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58651260A25;
	Tue, 11 Feb 2025 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292770; cv=none; b=au8dAyIYI0jf71OQPR9lxvz5ZfNvjJPGm+HDkQDtketKafCiSUh5w27QfQRQ0mxNN+O932gorqPoV4GT66hA68YPOl5MH33MYVIvh4PbtscPwPR8CnbT1O+tNXQgpn+7dnrCP2fych1vFGudOjd2UgM1RzZV9BBMDecHbcOo93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292770; c=relaxed/simple;
	bh=cMCtRH+z6U+h94TbDbjYZxf9DfLlcz6nfjn5WGdzMDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuJ+5lSCak1tJz/bUM0gvCabpb1LTWAlw3YO1qxXKnbTvZKIjzp5wJC+TcwalztCm1YqeuDTFspLj7LGTKvc7asJGsMa3NZo9OtvNSfFU4GTrzr7d1WN2SKZQRarQS5E0DYiIilw7S+4IhvYKRebzOkUVPOxrOmJJp/zT3XCOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F884aayl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dcb97e8a3so3701667f8f.3;
        Tue, 11 Feb 2025 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739292766; x=1739897566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7l7FdkR959eBNuQUmz1vYudXlEABsFNBYvc5a0MM9g=;
        b=F884aaylnI2ZSL/bt5hUA+D7+bb0wECbz7NkTBnHzq0kWR1cgn7yFShwJ4BKfr6o0i
         IDi2Xrx0v4+7F25KPDtgYqICqkBp1dGgJtbuM2F+c1zSF+IcKBOLQJZpJHJF0jXnIO3V
         ehjqaXuR/sUg+kftnNiiZCzgoHwl4kamhyDlQZVuQG1YOw1qUk0d5mtXgmZyHgpPMpub
         5V6N4ib4U2EdGrE3Ewhjdq86lxvl0WfJNfq8BxqebTiibapsaArdTy1YzBMb0AV+uXzv
         stS11K+Mjaa5QWkSF7kAivcmdVWqsGoHHeJpyn/3LT3/fQ6tc1I5pGqNHx+piDRHJUHv
         TU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739292766; x=1739897566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7l7FdkR959eBNuQUmz1vYudXlEABsFNBYvc5a0MM9g=;
        b=VQWsUK0EFrJV4VS4B0LiBi1XMePFsoY8GbRPJpBNOEieesQc05azOfdB4czdaUkcg1
         uqnj0zaOUTJcllr8YbhwU2JSygoJwXO6UgUanucjPR3NRqKOCOrj0ly5CCCCfKbM0TiG
         0gPdfNkEFuizH+b0dzyyVBpQI1si4/sj6RZYyRL3Njv1C1UvtQxI4CMizr/6InqimtTM
         GcGHhm9pItTx7KvX8jRaBJch6CdxTmNWyxppUUFvJGTqDsxPCLrMwEpeorglWhDZNOu+
         Pynt9H5PUjT04JDUiHtwPuUEvn1N7LdzEOmFFUztJxfTONUFy+IXmpin4sLk3nfuV2W7
         Z0WA==
X-Forwarded-Encrypted: i=1; AJvYcCUgLhxc8LoFY1KfUcwOorHOPNbU0PDtEV2QnMYJlrQNuw27awyffeIACqHmY9J44XbBPfk4tD3rtSa/Yc3+6HkSR6WF@vger.kernel.org, AJvYcCUk9enjKEAx3qooKuWmcPxmeUrY8YgHx2NrF/qmmGGQI/VPveE7Vf9LKPa0NXDves1Fl4NjRHvSvTPpXLc9@vger.kernel.org, AJvYcCUsLxAv3dBMlSIiXrThQDGd9SUAipVaJ1ri4YMe8IxMEhIg5YHdPgg3WMosobBWxbTlmys=@vger.kernel.org, AJvYcCWJYAD7qEjwn1cYRvuBAU/ZUkEOsAvmEzPV6uWOH0zMt+9rUMgVorXBe1DuNZRVQ7Erre8DesTx@vger.kernel.org, AJvYcCXDcCayTcLlGgf116C2PesYheSKk6k1rJSlNvcnOyjaLimK7lPIC41ZvS54FP4w0txeySETLQEvgmMo@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKbp4Sm+nFdPrqDTqrAwyg1mvb87Aj1kJ711GdRu/rv+r1W+i
	LlYem3iinGGAgP1PztACIxT4NP+uvILt/qxLNftv4tWZ5Mne0P5S1jmn3W7YaufhzfW22S5yQLH
	mvmfTV4g0OjjKD8E8gliskQKTjT80ZA+1
X-Gm-Gg: ASbGncummmDseBqaX0rXTwyBUketrMbLwld6eJ4UiMwlZjBaTXM/iRn2q6HX04Tpf9M
	VuEtSiBC+at7Nfc5gBI+DZI443jD99UuZH/qYvVXk6x4MVtLikhd4gY8aak0xIRa0ecQVQkoc
X-Google-Smtp-Source: AGHT+IEM+6wMrT0JRG3VIrgXvAIM2GN8O9zWoQmnsuW8lvAeaQmEhS9wOO/SRRIC2ca8APfB0ccJeeLexU7+BMfWIUw=
X-Received: by 2002:a05:6000:2c1:b0:38d:d666:5448 with SMTP id
 ffacd0b85a97d-38dd66656aemr13413226f8f.40.1739292765187; Tue, 11 Feb 2025
 08:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211111559.2984778-1-jolsa@kernel.org> <CAEf4BzYPmtUirnO3Bp+3F3d4++4ttL_MZAG+yGcTTKTRK2X2vw@mail.gmail.com>
In-Reply-To: <CAEf4BzYPmtUirnO3Bp+3F3d4++4ttL_MZAG+yGcTTKTRK2X2vw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Feb 2025 08:52:34 -0800
X-Gm-Features: AWEUYZnQJyQVViKFBVnVgmh-OYBVequMFzAuUfgtInjn-tuR2NbKw0gZmlSYgJg
Message-ID: <CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
Subject: Re: [PATCHv2 perf/core] uprobes: Harden uretprobe syscall trampoline check
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, 
	Eyal Birger <eyal.birger@gmail.com>, stable <stable@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Deepak Gupta <debug@rivosinc.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 8:48=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 11, 2025 at 3:16=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > Jann reported [1] possible issue when trampoline_check_ip returns
> > address near the bottom of the address space that is allowed to
> > call into the syscall if uretprobes are not set up.
> >
> > Though the mmap minimum address restrictions will typically prevent
> > creating mappings there, let's make sure uretprobe syscall checks
> > for that.
> >
> > [1] https://lore.kernel.org/bpf/202502081235.5A6F352985@keescook/T/#m9d=
416df341b8fbc11737dacbcd29f0054413cbbf
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Eyal Birger <eyal.birger@gmail.com>
> > Cc: stable@vger.kernel.org
> > Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return =
probe")
> > Reported-by: Jann Horn <jannh@google.com>
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > v2 changes:
> > - adding UPROBE_NO_TRAMPOLINE_VADDR macro (Andrii)
> > - rebased on top of perf/core
> >
> >  arch/x86/kernel/uprobes.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 5a952c5ea66b..e8d3c59aa9f7 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -357,19 +357,25 @@ void *arch_uprobe_trampoline(unsigned long *psize=
)
> >         return &insn;
> >  }
> >
> > -static unsigned long trampoline_check_ip(void)
> > +static unsigned long trampoline_check_ip(unsigned long tramp)
> >  {
> > -       unsigned long tramp =3D uprobe_get_trampoline_vaddr();
> > -
> >         return tramp + (uretprobe_syscall_check - uretprobe_trampoline_=
entry);
> >  }
> >
> > +#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)

If you respin anyway maybe use ~0UL instead?
In the above and in
uprobe_get_trampoline_vaddr(),
since

unsigned long trampoline_vaddr =3D -1;

looks odd too.

