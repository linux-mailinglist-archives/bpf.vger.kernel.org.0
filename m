Return-Path: <bpf+bounces-48982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A9A12D74
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20967162184
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BB1DC993;
	Wed, 15 Jan 2025 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA1/Jgdg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA51DBB3A;
	Wed, 15 Jan 2025 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975675; cv=none; b=nlva9mJc0ZiUaVH+L8WxYtFAV5/xDt2eZtZpxzQtqKIajco+/NqZx8PU1zDstsCbhkEOKlghbFuI7ZYj4uFOZc8+SgUevUyKDQsiz+rg3Ne17FutNl78nYSdcRoii5ZrbwhCHgerJ1xWAcnJZw0bYox59fYmEJirP9hPB37Iqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975675; c=relaxed/simple;
	bh=T7t3MR/ZRqchZRVbBHbHFECeBBmUTVf2COwP5KKdpd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3BdUYbjhGGa5W1M/jHhBh2Cr5oMYLfDkRuHQN7gmhd01Ls8HQSdMaZt0fbtt3JSNQnBlbXJDVyUwav8rJSnu40zVkNoiXb5QQcUXg1N83Y2cWZT/9rezrYJHyNJBBqMEOU7FhCOBmJwJ4S3Kg2dhnVmDvEtjDm2SOwyUEtifpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA1/Jgdg; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f2d5b3c094so53077eaf.1;
        Wed, 15 Jan 2025 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736975673; x=1737580473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKljeJVT6hglv8S1VM7AkT8q/pMP1H6RrwDcNwQEUZk=;
        b=SA1/JgdgCI6Hi36F+x+fRRbyc+2TCrbT6YTvdgUtHTlFRnYUvW9xEMA2F5MD2KBBuS
         /ms6yYkxHoIc2aStfrX0HrYimHLOiE24xGWK8pjPcJw9JCMQSVVfoy0ag4UBizgRhCeD
         Z+yfPjXkwgwm6v5qVAHd0RUYy1RdZyVpT41zu/h0E7DWWJTcW2KxjhFFcW6ALEYVwBSa
         oCMs9g4cShRhv11FM8/Rn78pO+bOTxjcDP8+8056cGcKK58c+Gudnp6a4LnVGZ+mNDHd
         NFS/4ZntVumCjXdl7UMMjRTNAA7pfOFDV/1thHYAP7ivb/5SyJXgK3SaOcqakYDF3gO3
         eIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736975673; x=1737580473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKljeJVT6hglv8S1VM7AkT8q/pMP1H6RrwDcNwQEUZk=;
        b=as02bLC2dwJH4J+Qs0Nb/9aXbQKn9SBqTNv0xb3foZomVqgKBl460/gmpHDDPLaT54
         a0we97OUuvC9eImXY6j8Gm6RRlhsitt2PUEsFj3zSZkO69UQy6ZYBv65VQ9XyaM8wPmK
         58XOr6r71ihnJm6KIfYmzSdFEk3IVp/hAbTd1zb1dBj30+9MgKZlxTdwj2yAjIdl2jlI
         cqapLThE3qII1a0SUM55ZIdE6vwax3cU1nanExHDNFg79n+8yQ4djUNnixjFodAejcXm
         lUW7P/BFK9dRKp1X1z1OlzTjKbB4RJR55t65unnUtdkFc6QFnuyblaLxL+a03AbUiGhC
         xqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU79Cp9YOUUdl91oNpgmpHVwZhHMS3BNpHIeHH9misr+opRDHNy/PPiahBJCYA04OEKdpnBa8xfGT6ZZ6Yf@vger.kernel.org, AJvYcCV186/8ypwPKypAGOoJsqxzUHiLmvIR66ZVigiAUEX1QAVXItegkTCyaCk8w9ZZ0iERI0I=@vger.kernel.org, AJvYcCWW41V8OClUPZcjEfQ3migQvcjOMPRmEIRUUhI3I2Wqm1MeLBc+//u4FsK44ZxDybgNUq9zHMC35dD/@vger.kernel.org, AJvYcCXMakdW0WQeoSexW1cKJl0Zmbs0vZQKK5UBmBAN+hbTmXHPM95AkCxWgpHaLYF0WNQQKurllyTmN1OmYCfryH3U+Gn5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6zOMIMnwy59pJHb3i4gD0k7fSaopvuH66ObAtItVPaPoeblo
	Lw++m5AWzyLHotKP74nTeiWuQOtlhLzeSnFaVQCEKhUhDrDme2ISjEmyhMxv4vgAQiI3jjZTsvR
	UD0nF90ULPtd0L33AdDVIljTNt1c8CZbs1UkbVA==
X-Gm-Gg: ASbGnctyLcI5BR7ojEOgLMLQjOyeeLLXRrnQKsrRYNBQ6y/pdyj3T4KgjZ6Kidd+p0Z
	Ea3qghougTV3+d+HbJEKxznS+2HLjYGzEJLr/KA==
X-Google-Smtp-Source: AGHT+IE0varc4lyMUOKjAL7/Pos0lkoQgDTdClT8ML+yEWa49gsE+myrp0OLIVY1N6p1Uu5TxAKR6zP+iG9JHmJ2OpM=
X-Received: by 2002:a05:6870:7e8c:b0:29e:49b3:c50e with SMTP id
 586e51a60fabf-2aa066c71eemr15917950fac.13.1736975673361; Wed, 15 Jan 2025
 13:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z4YszJfOvFEAaKjF@krava> <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com> <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com> <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com> <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com> <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
 <20250115190304.GB21801@redhat.com>
In-Reply-To: <20250115190304.GB21801@redhat.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 15 Jan 2025 13:14:22 -0800
X-Gm-Features: AbW1kvaz-Q0fRIgCZTjOMTFK2ww7SHO5PAEedC4Ees9Ik9taYh09rHGNbM1UVRM
Message-ID: <CAHsH6Gtd5kYPife3hK+uKafjBMx=-23UzvQgnOnqNDzSZgHyqw@mail.gmail.com>
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

On Wed, Jan 15, 2025 at 11:03=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 01/15, Eyal Birger wrote:
> >
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1359,6 +1359,9 @@ int __secure_computing(const struct seccomp_data =
*sd)
> >         this_syscall =3D sd ? sd->nr :
> >                 syscall_get_nr(current, current_pt_regs());
> >
> > +       if (this_syscall =3D=3D __NR_uretprobe)
> > +               return 0;
> > +
>
> Yes, this is what I meant. But we need the new arch-dependent helper.

Do you mean because __NR_uretprobe is not defined for other architectures?
Is there an existing helper? I wasn't able to find one...

If not, would it just make sense to just wrap this check in
#ifdef __NR_uretprobe ?

Eyal.

>
> Oleg.
>

