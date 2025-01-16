Return-Path: <bpf+bounces-49059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182FA13C9A
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD05188D224
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FA822B5A4;
	Thu, 16 Jan 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqXQJqeF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DF146D40;
	Thu, 16 Jan 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038867; cv=none; b=bvxduLvNs/vz9JHV0CHnm3Mc3B4dQVk3oqbfAwmGo4qAEmxf+D6Z0Zn/HH3+Gt/34HrCHgHhIh0YxkHkkk/tsXXQvkrwBtKQg0XOZeAb/y0MryCRkkrQExMl2XHCbgnywahk+4h0Ez9aRTrBvjGKTg7NamP2PwKFYRINMtkWKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038867; c=relaxed/simple;
	bh=8MoQUGqtnqj0c/pjAJ74KM43M3tFPlK15/hOJfM22Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWkp0i70jnj/0+i7al52TebPahVKGSYGr1gZV55xgIZvxfN+T7ivWsK1TuEBbj8HfHAOSBd7g+KVzkKzJieNVXNM6W1ErHhlubd25rfzhHrOcMqGTB7c0sZfIj2Xca8MuBVy3ApEA6fm+XQchHHxtve3YGxbYYVKL39a+4hboMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqXQJqeF; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e15717a2dso581478a34.3;
        Thu, 16 Jan 2025 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737038865; x=1737643665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giASkQCuXebcp9kjz1fKCKXsILzQJtJjWyYvnye3pYI=;
        b=DqXQJqeFnSgAuUqPnN0EAaBCjWnAbeY330PlZmPu55L8boyApaRUwTwOrkgWZUKtss
         mBQe7/j+Vu+wZaDsXlI6jPqFTQsM6/HzMmNnkfDV/ly/aiWtZXBgHb15zzLm1fi4UDHt
         TOaW9SdSXcqH6IeI/DlcFMzfZ5JIwwm3ohHCrw/oOQLYmu6qJRycOTq0LbO2o2LSXZwF
         1ZZFWBSyta+wvXJjwN5B8OXD3Cw92TZ91ixb8Kh+5VxEBrX2c8IPqvhRoN3dnEDPIHZo
         1NoYRGTDaVWKCBZqDOkchqIDqQATLK+hNv5syaRJWhOxxtqzA8B5NnSlC5cxaGyMFMri
         rnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038865; x=1737643665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giASkQCuXebcp9kjz1fKCKXsILzQJtJjWyYvnye3pYI=;
        b=ScFYGse6IsVjjPaG+7jbSDYZCcnoi5UP4IBu05EwYbssOrZks+VFP8eSDUzMVyWSAX
         swDQ8VAhdfkY2lMKk8YgdjkbfeO0nk43yRt3eVfgcZ6TkTbRPWrVmfk7Me1wh3YRgxcA
         vHqQ5sk3tojudp0Jy8JXeI7mceEufSfMue39OzHIkCBHu1zP1AqVBJFZuL7N1EeWYDhV
         l94/l5nOtArjA2s6clqby9rE94VI0T9MPMsicBSA2v/O+7HU3ugtcDdFBk/0K6bAO+y1
         Y29Ju4o9ZrThFXdfVUCr6hhIeJh1PV7+bM51fMDpptN+BaNeph/qwr0vIC9fcytGx2qZ
         J34g==
X-Forwarded-Encrypted: i=1; AJvYcCUDoXc0fNkiuf8sphtvmAwJR1eqiUx9OtU1yJUVfk7G+2NM4loa/yrR/uBK3MhYd7gV0fJfsVkicyEuSKKTVb1g++xq@vger.kernel.org, AJvYcCVOxJn3BG1akFseWxYXvkXAid8LXRj1NTBFpTWaLNZCZNK/Vt/kYx6RmDT90akgYEosdkpMNMfBrWSHWaZX@vger.kernel.org, AJvYcCX9gdp7BTgQlmSycM5+HU/Lqiv9I0Ka+uvAJNCC0ScaUt1/pge7TJxM0OoqfF3R6sWq1h4=@vger.kernel.org, AJvYcCXyxhdQc9ClQhwBnjqkKHiUWgjaGgOPepjqq83eJV1UHWyG+7dJ+IiffQrCxDio8XhEK1eiHex2xIon@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Znmz95RM99sXtrga39iGnRZfk4SqTRQ2BpOPwYyuPylMyV0q
	eq3cvzAaioWN0mK7qV1IBIhaXG3V0etsh0M53oBI4PsBzKpiKDrc47I/PbDUFGRHnbBx+nWeyVq
	gG0Kbjba3D1Rv17VEcBZkWFLJLac=
X-Gm-Gg: ASbGncvDCHc5RvfR0g+TCihiWDNeMMdjZkUjatQNUCwEiu0FQD0HTZNHHkdZ9Lw+SHF
	H3iEeEDeBNhfFPMnvKz2QzhQRwFfV9/tpzmicqg==
X-Google-Smtp-Source: AGHT+IECnOGB2gyyVlJC1oV3YVbDwQTtUmUfcs2zlORj83Fv8h+7dY6jmTdppHU1R9VdAtVdK7tKEOCmR+lBrTrfd3E=
X-Received: by 2002:a05:6871:650f:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-2aa0690ed2bmr20293498fac.26.1737038864729; Thu, 16 Jan 2025
 06:47:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114143313.GA29305@redhat.com> <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com> <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com> <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com> <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
 <20250115190304.GB21801@redhat.com> <CAHsH6Gtd5kYPife3hK+uKafjBMx=-23UzvQgnOnqNDzSZgHyqw@mail.gmail.com>
 <20250116143956.GD21801@redhat.com>
In-Reply-To: <20250116143956.GD21801@redhat.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 16 Jan 2025 06:47:32 -0800
X-Gm-Features: AbW1kvZpsTjKFzfuN89Gdz7a2goZi8__7fgR5mr4jeXOBsdDwPtRBs7MBAOpOaM
Message-ID: <CAHsH6GukV+ydR+hw_-RF=0=_x6aO7xZzkCmbc53=Pk0Kv=8hUQ@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, BPF-dev-list <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:40=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/15, Eyal Birger wrote:
> >
> > On Wed, Jan 15, 2025 at 11:03=E2=80=AFAM Oleg Nesterov <oleg@redhat.com=
> wrote:
> > >
> > > On 01/15, Eyal Birger wrote:
> > > >
> > > > --- a/kernel/seccomp.c
> > > > +++ b/kernel/seccomp.c
> > > > @@ -1359,6 +1359,9 @@ int __secure_computing(const struct seccomp_d=
ata *sd)
> > > >         this_syscall =3D sd ? sd->nr :
> > > >                 syscall_get_nr(current, current_pt_regs());
> > > >
> > > > +       if (this_syscall =3D=3D __NR_uretprobe)
> > > > +               return 0;
> > > > +
> > >
> > > Yes, this is what I meant. But we need the new arch-dependent helper.
> >
> > Do you mean because __NR_uretprobe is not defined for other architectur=
es?
>
> Yes, and see below,
>
> > Is there an existing helper? I wasn't able to find one...
>
> No,
>
> > If not, would it just make sense to just wrap this check in
> > #ifdef __NR_uretprobe ?
>
> Given that we need a simple fix for -stable, I won't argue.
> Up to seccomp maintainers.
>
> But please note that this_syscall =3D=3D __NR_uretprobe can be false
> positive if is_compat_task().
>
> __NR_uretprobe =3D=3D __NR_ia32_rt_tgsigqueueinfo, so I guess we need
>
>         #ifdef CONFIG_X86_64
>                 if (this_syscall =3D=3D __NR_uretprobe && !in_ia32_syscal=
l())
>                         return 0;
>         #endif
>
> I don't think we need to worry about the X86_X32 tasks...
Ack. I agree.

Do you want to send a formal patch, or should I?

Eyal.

