Return-Path: <bpf+bounces-48967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF792A12AC7
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E5D1887A0A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FE81D63C7;
	Wed, 15 Jan 2025 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7/o/xVC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0824A7D5;
	Wed, 15 Jan 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965250; cv=none; b=IPBaM3+wyo00E1f09hq+r1+6Iq90SHOqZucViQLJYhVFrG0ugKQPzemVAs5j09WKWhIrs33gJvbG+smbwQ4qT3Wd7MeQTlnq9bjBKk5j62CdQtkx1oOTk6ae+Qvnc2hr/GE9Z6H0tVCStKBdrxDkZ8+y6U6v2x4DifayR+BPRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965250; c=relaxed/simple;
	bh=Vq66YhCbR2GtMp6Cq7zCCTvPpbdue7ohUPmScQz6nzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGwyZoTM59H/18eAE2A/CGy5LDH49uXrlEJn8QRgOVaTqfTE1txBFpae7aPvnUepH0ACT7/d9ZZHygbSYaQocRmIGdapaGzmYddgtLYbhLHub7bL1935cnYX28wG5dlny+KtmmBf0VDMMaA8+BLUTT2GCZig1vd+Qc07p1xJ1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7/o/xVC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so2009091a91.0;
        Wed, 15 Jan 2025 10:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736965248; x=1737570048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq66YhCbR2GtMp6Cq7zCCTvPpbdue7ohUPmScQz6nzk=;
        b=j7/o/xVCgfC64bxHazI/AoCFWAoj0OM4uW3WClKNaIVih/58zjYmzL4iJfNCaSMCS5
         9SZf34K207OpqMHBav+QNPHhGgq65sPrw6FxPWNoYy69YsDEL3Dv7OAsqtWggtWCS3Ax
         XIe7ucVpLVLV3Lx17nHcSgZZNU5T4DgyhZiq/dSONavfh/zEYj70hlfJos2WInegXdTk
         xucGbgwd53RS41TiZMAx3JGSrEd9q6radflIlrfLse+ZMUub6R+YI4c8LV5TnCNXpdh3
         J+ibSEPc1XwEoaDmpssdnSEu4ubc8J9YNZPdf9C2wbw4zHoGpLD5U8Gq57pn0JXgrUZg
         jr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736965248; x=1737570048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq66YhCbR2GtMp6Cq7zCCTvPpbdue7ohUPmScQz6nzk=;
        b=FApPbWMI54JgUkXw0AWMo2e2UkhmqdlG9kgpYuXbBd48pCWJ09N4aJoVQUz2v6B/US
         7cK8Fgtj4AUps5LHT/f0QBNAn5gavy7AJykXxE/m2wHM2O9tznYzNOr/Unaj8hjwZ7AC
         vsaXlud3JtPkR6/U9JdgI9VGSU3sHCHM+IB0DxB3WoEFDpkevv9wyzv/xWxdhuoOjMLY
         a8GWimI4diSB3TXk9Qnjwn40072u97uBPcZhg5Mc+KnMFkuKQpsPhG3pZXPKJPRMb2MP
         najf/yBNOTVmXW2/3F1LMBUvC5EF/4bO559aUJq9j7mR9DeeHcl+CBPhFEktJxiHnYVA
         uWPg==
X-Forwarded-Encrypted: i=1; AJvYcCUymtqUfHJDvqNWSwwow+W+GBHeTtrz8q/mIs1pPSbAe3iNoVfRFkgOx6IYm8Ded0dlu6ezygyN4Q4kvFav@vger.kernel.org, AJvYcCVDv3fKz82vIl9t33ivsUvhQL1T5/MtdUqXAbZR/AgP0+L9yMzP7dTChTO2FVp6IDTrAOsGrqfTf3sY1CeOnzgMlHZL@vger.kernel.org, AJvYcCXgjbyP7OutV9P9rXJHbZSCws+untf+TSFsP+JusP6DcW66B7LwEl8D+r888EVGUkpC2gE=@vger.kernel.org, AJvYcCXkviiRc1gydmNcMHjbMgYztDn9bzVuUnzpocryPOAh9Pn9Juv8N3BRV0k+Hugndj91js7HFS2NPCM7@vger.kernel.org
X-Gm-Message-State: AOJu0YzxucOMx55z2yQUgKHtPTCdssZqSLEG5U47KuyqX/O8RB4CxM9u
	v1uMGvycRGO3PF2/vsiM2obKdpq+fX3cnlasbH2R0XtX9vrgqVMQqbOBXuNm/rMY39NqLNwcxgs
	N56sKKMWUe5aTQ7wAZRyzVFaJJgow7g==
X-Gm-Gg: ASbGncsRcduH1EE2LPk5vAOGKetAbiR9iJFPT8FqhanWquAlp0LgDsVznrJxf3maLXK
	teWlsXkbsM5Ec3jUlFVxgCmHywn7cck2TbB6E
X-Google-Smtp-Source: AGHT+IF9NtZ+66UkL1FvOrp8/deBXAsjyUAeArR2ssqxqY4JNezqt9qJmoTEWsR9BAvb4fZrRaNnHkO2od84IYZsXh0=
X-Received: by 2002:a17:90b:2b8d:b0:2ee:7504:bb3d with SMTP id
 98e67ed59e1d1-2f728bf2c11mr6571054a91.0.1736965246987; Wed, 15 Jan 2025
 10:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava> <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com> <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com> <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com> <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
In-Reply-To: <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 Jan 2025 10:20:34 -0800
X-Gm-Features: AbW1kvZVbnIbnZHW-8PInM1hXXlwjQREQdb1YQX5brF_yU0Utl0vyp__rJJ66dk
Message-ID: <CAEf4BzbVZuYEXro57FhZyTetaKFZ1xr9FGn5iyi8Nwa+LbA0vA@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Eyal Birger <eyal.birger@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, BPF-dev-list <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 15, 2025 at 7:06=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > Or we can change __secure_computing() to do nothing if
> > this_syscall =3D=3D __NR_uretprobe.
>
> I think that's the best way forward.
> seccomp already allowlists sigreturn syscall.
> uretprobe syscall is in the same category.

+1, we will have a similar problem with sys_uprobe (when it's added).
Just like rt_sigreturn, these are special kernel-only mechanisms, and
the kernel already protects itself from any user abuse. So I think we
should have a way to ensure those special syscalls can go through
regardless of seccomp.

> See __secure_computing_strict.

