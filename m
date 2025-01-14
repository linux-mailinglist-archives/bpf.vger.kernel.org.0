Return-Path: <bpf+bounces-48860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA385A11354
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733797A28BD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 21:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C822135BE;
	Tue, 14 Jan 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMjWiNG/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA64211278;
	Tue, 14 Jan 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891126; cv=none; b=XoOANdG9mX+skzDEQ4+/P2MUyvlcTd/uaDHmYTjY9lq5ffB518XC36z3e83lOcv+tjcAE/hYHCah1dDAgWRXFtv4GfK8i5em15f151uPjZCFFEpaFEB8JG1L7frDOnaVSl2sbFbucfuiSSCQlsWmVB6rDnD7wZ8OvSFIjML7cew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891126; c=relaxed/simple;
	bh=B4VxK/IwclpVLI678QvJf7Dk6Acfv8NvptCWzRWVedQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCrkTPNTrPLaSfpIFkKks6zjwr8LCrqneOmnk7FjLzNglNT3p8zHpZCE5FD+6MctmkJUKoUwh9Uo2easu/u+gmh5YTg/FweQgGeiMQ3CWMF9e92EVumsvv+6dC/4YR62N59wTvy3idm/e704KuizXwSPTmDpX0dI3kUch2pLu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMjWiNG/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so346906a91.0;
        Tue, 14 Jan 2025 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736891124; x=1737495924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RL7+HsQwmXaIo0B/cwtFxWTlGU+cmitUPhIWfe6zNU=;
        b=NMjWiNG/2tutZwkGSBsKtF3nYar6HMVJu4LGhkUu4XxdBGrfszneLrm7OlzdfCRdFQ
         aPYQr4pV/YNG/3fNmFpXVdrtycpqO12pNfJ7dXjFNtci4T6XYYIOnOZ9jGhV8n+iVBBf
         ev5+N2fhQNNFRCZCMrrCkVeXR9KrU8DSPIIxAgD8YpmX80LkQfx23WFR6zd5x88351eS
         tq8GBqf8of9pKjOC6B2LxjzfMmer0rIf8r9O9F1KsvEuSTajtGGMbn3yULvYW0JjWP/H
         /JpxRBIpqNYQ3C30dYnWLjJ7pbthMj68Qw/HTfYl6I/CN5+xEEPsTXdc13MEBWYJL3JE
         9HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736891124; x=1737495924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RL7+HsQwmXaIo0B/cwtFxWTlGU+cmitUPhIWfe6zNU=;
        b=exykbL4C+pwKVQGxSV7YfbEhi9PWJdjmQuwW5LlIp/h/dXnWzNxZGe5qS5pa53xBeu
         eBY5eeUnS1bWnpbuAdgcsbWzOR4eFzPWujcbfyAJierZlWUAdA640sAXEHd5pzImfw3V
         5jQuzpL0+dqCR93A5SK0T7KSJS2XYkbMYS3hHRjwPF6B9Z6dOfZ18btzxGHG+KQdP8F7
         ThpT3PISdsuE3uKgTUlCSZtBRG+OgNS7CCOqQbLsSHqwmFY+S6fBuY1x0QqQ/yJpI+5F
         i3RyU+kDl7o+6QWo6Dp3qF9H3WoHYH4PlSUCyEGhkKm2tzkn/bPwlvoObbtF6gu03iza
         Mc2w==
X-Forwarded-Encrypted: i=1; AJvYcCUjv5R+YOoroVPmaxuNCfYgHX6fdtZ+ftc11PLzJ7ydKAWFG2spR7vovsgqorgXrsmMkCZthCgri2P/huD5d9DNT7tK@vger.kernel.org, AJvYcCWGYibGaYh/JnBEey59HbPS9y0kp8/UddiILQG3eCAnyv5x2q4000QoYe4SLN3uA/FvHzF1BxiPYPNp@vger.kernel.org, AJvYcCWecQHBxTJF5PU+hFDOjiQw9+OLsWJziZNl9OYoNzzc3Cjeu4yz6evBAR/hIfHBhQTVdPuJufRu/qZbbhCX@vger.kernel.org, AJvYcCXA9rsnwCOLGiFYOYTQ+s8ChJBcTfyem1udF9ugazpS6B3UFUyfWSH1j/hbRmFO03Dk+P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPp2pU9ah7lqhvQVgQGJycgRbZvETePsQD9q7j+wXHC+J/78hP
	XzBVbDr5npNimpB/stODWaJQ+vK4vEp4JuN7nsixjxMWiJl+wa1QIFspsqMpl/W6ORKrfhaELkT
	z6ouiH8PDQ/pzMwSoD3YFttBcEWM=
X-Gm-Gg: ASbGnctMmRpFUVftr5TJmPcll2TyEvNOO3CJd3szRM3QU7gp5fErdVE7AEUOSOdgheP
	GkAPK9kMI+xYbc4fVaKt31kLxxYFAwGHiZaQykD6mC5V5oir0YBCRhA==
X-Google-Smtp-Source: AGHT+IH0FKA+tIQ7HagM82UYT5wwWCYgyacSsyTFhJtKlXmawCq8RBogQ93/3MJRxqMUGEOJwpjGrhxcBYifJI6Hzjc=
X-Received: by 2002:a17:90b:534c:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-2f728e1cedemr752422a91.14.1736891124501; Tue, 14 Jan 2025
 13:45:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava> <20250114105802.GA19816@redhat.com>
 <Z4ZyYudZSD92DPiF@krava> <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
 <20250114203922.GA5051@redhat.com>
In-Reply-To: <20250114203922.GA5051@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 13:45:11 -0800
X-Gm-Features: AbW1kva1vYogaoHUziyVoRJIKZjSt5M_Zfni5CCWmCbYg3_OFfE1JSNggSra2Bk
Message-ID: <CAEf4BzaRCzWMVvyGC_T52djF7q65yM8=AdBEMOPUU8edG-PLxg@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 12:40=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 01/14, Andrii Nakryiko wrote:
> >
> > Should we just fix whoever is blocking kernel-internal special syscall
> > (sys_uretprobe)?
>
> Well, we can add __NR_uretprobe to mode1_syscalls[] but this won't
> really help.
>
> We can't "fix" the existing user-space setups which can nack any
> "unnecessary/unknown" syscall.
>
> > What would happen if someone blocked that other
> > special kernel-internal syscall for signal handling (can't remember
> > the name,
>
> sys_rt_sigreturn().
>
> Yes, the task will crash after return from the signal handler if this
> syscall is filtered out.
>
> But, unlike sys_uretprobe(), sys_rt_sigreturn() is old, so the existing
> setups must know that sigreturn() should be respected...

someday sys_uretprobe will be old as well ;) FWIW, systemd allowlisted
sys_uretprobe, see [0]

  [0] https://github.com/systemd/systemd/issues/34615#issuecomment-24067614=
51

>
> Oleg.
>
>

