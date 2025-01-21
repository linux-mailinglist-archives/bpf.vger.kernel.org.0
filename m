Return-Path: <bpf+bounces-49419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBF5A18834
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 00:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5EB167184
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 23:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1EB1F8F03;
	Tue, 21 Jan 2025 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyXZ1chF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8054764;
	Tue, 21 Jan 2025 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737501246; cv=none; b=scyxFyYZJ1z0/h+i9XDIBZIVte8P3wd1zFFjDY/5HvlhBMfj+by3AEoAnk7n1bLJnsAHoXq2N1UvJR0bCoBsXVmddaecuFxtciAPUnDiplbqEefLdGvsKl7ZzOJ+F0VBKza5JqoH/GW2iGLWoHPQlekFPiNeTDszQfLe9U9VfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737501246; c=relaxed/simple;
	bh=r+K17ViIKCxWE8yhTCiAB/kg7t6922HWI1yUzRx94YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jr5KzUbdgjHlQk2PRkeku5XBcp8o7P2uoAhSlz/1sh/Zf0RntyDrpPtjjDIG8DkwTIhXiNF7ffIS1Kez3v2h7GS8KP+nKi87QrICcCnSelCuTRnk8ARMSUkGX9V8hZ4fO3fVN05KQ9UzZYYtmBvVO1O3WaH9Nt4ZwU9H9Ux7Lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyXZ1chF; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29fe83208a4so155113fac.0;
        Tue, 21 Jan 2025 15:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737501244; x=1738106044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+K17ViIKCxWE8yhTCiAB/kg7t6922HWI1yUzRx94YU=;
        b=iyXZ1chF7qWjgRXnpbJ0ZY/b0g7yE/dH0Ut8RTOmVU5D152YZz276sKKiQ/Sq33ZeB
         Zc5rQ7cls+463wAPnJiIrf+7rYD+v6cu5fLrUC5uSz4ubizp2EMmSUjP3eBUdqgTG48y
         yRSixt1+YdQqROUvH7CF1WpwKS5pw5+IJ/6b/6KeXm44fvCGlreu1g8piluAjE8UkPbl
         QO8YiALbE+xaP3yt7n/694sB1RJkh1dm0+IqA+jfIq8Ogzd8IKNp8u5JbgzNPHwqRf0t
         47534/pqIE2uOtX9ntAFl9RKV2vi8cHbxDWz0GYrYBMS0BVWbtSrktCmE4+lj5ZOaJ5G
         hEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737501244; x=1738106044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+K17ViIKCxWE8yhTCiAB/kg7t6922HWI1yUzRx94YU=;
        b=lPiO46Lw9fJKwLe+DIF+g8Lw8sVIcRD5FwgTO94VxmF4rEHMSJ4TEVeb3+IkMY3sIS
         Hlt/z+Qqx6ZgiKI+FozkL7ijMlHJbKKtQx0LzrOXI1XSX3OHKbbP8caOy7VktaGe7HAs
         mKpKrGZ4eRNi3+6kHPKZuR9qEMsMQ4qR9eUlt0y1hiXx2c4eiKew9UaGOIRx5zxBuHp9
         j5g5DQIZ3v3ec5/A6pVals+f9F855y+cxzEblIv6rM+EI+3dpgwzu7Y0Ydnd4XcijA5O
         F65kpldNoGBET3KyzyTZFSF2skMbvB3PRH5JDcfScYQUR0casWfkBlMHVgyWrzS0Vs+0
         kKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1bDlvKd047aN1j3ZzuDxrkLlUFE2BIEBiPoZn4GYqCT7fRgjo/IJ6atObp5CAMWVbSQIYSnJz/uyg@vger.kernel.org, AJvYcCUDpkiErho+PCXr4se58Ts4z74UuTCVK54uFbVJjbkUkRI2F095yBonP88cw7bJunXnS8+DXOUD@vger.kernel.org, AJvYcCUjh3NsGVD56ZLlzHsOhrQHav00SjGyvZyYjYcb+Ts6LIdeewMpTXgLuKYa4eL5zFmlo79pyskXe0RrGAad@vger.kernel.org, AJvYcCUrPtAy3lk1WLgPJwcSHnC+adu2Qo0iySqMtIoQ/Cl7PgYM5IFVCQrHOA40v/2QHJ0O9hddiAFNn8s5OONAVHwLWKfv@vger.kernel.org, AJvYcCXdPwjN9vnVY27RaQVzoFbUSBDhmVhszkgGQHu+z+XHN5ObWYgcrtz7VPm820eau1EF7PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fVDyfyCyqG8Kc/vsUm+BZVHcx2B7KeDpmacW4g0WCIAcO3n4
	mQjopB+6Yy1yAEtZnBH1CeWej/meHYDIuX+BWtCvUPeE3040WL3PjVO1XIixML0npL0grseoaIE
	rYVVbFdtONuUR5guy/1EOivXbasc=
X-Gm-Gg: ASbGncvmXkUVlYALvnTnqE85BJkgW/jvgeMlKGm5WPLt2JUUO0BOILx1P/aAaHsOor5
	yMrT9aogXO6DGZQ/2fTYsdQicGXwUx3y1+nEEVy/4bkbubJJ0Kyc=
X-Google-Smtp-Source: AGHT+IHg2SP7reP43cxCp9MMzNfCrnA91Kckjsj9faconzRGXzXIvnOL/LifNgyWQToIsrQBtkTgjU+4I2BEYOMg53A=
X-Received: by 2002:a05:6870:6713:b0:29e:37af:a943 with SMTP id
 586e51a60fabf-2b1c29a314bmr12086727fac.18.1737501243895; Tue, 21 Jan 2025
 15:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook> <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org> <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <Z4-xeFH0Mgo3llga@krava> <20250121111631.6e830edd@gandalf.local.home>
 <Z4_Riahgmj-bMR8s@krava> <CAEf4BzZv3s0NtrviQ1MCCwZMO-SqCsiQF-WXpG6_-p4u5GeA2A@mail.gmail.com>
 <20250121174620.06a0c811@gandalf.local.home>
In-Reply-To: <20250121174620.06a0c811@gandalf.local.home>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 21 Jan 2025 15:13:52 -0800
X-Gm-Features: AbW1kvahVFwKEbkF6OdqGiPb88_E6d_DuBGpM375fLo2jXHLZe9n7F2El2e3XKo
Message-ID: <CAHsH6GvcOjNh8VMpPs9CzyVSCOB+92zRj_3ZeDOd6APySWdm5Q@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	ldv@strace.io, mhiramat@kernel.org, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, cyphar@cyphar.com, songliubraving@fb.com, 
	yhs@fb.com, john.fastabend@gmail.com, peterz@infradead.org, 
	tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, 
	rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 2:46=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 21 Jan 2025 14:38:09 -0800
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > You said yourself that sys_uretprobe is no different from rt_sigreturn
> > and restart_syscall, so why would we rollback sys_uretprobe if we
> > wouldn't rollback rt_sigreturn/restart_syscall? Given it's impossible,
> > generally speaking, to know if userspace is blocking the syscall (and
> > that can change dynamically and very frequently), any improvement or
> > optimization that kernel would do with the help of special syscall is
> > now prohibited, effectively. That doesn't seem wise to restrict the
> > kernel development so much just because libseccomp blocks any unknown
> > syscall by default.
>
> What happens if the system call is hit when there was no uprobe attached =
to
> it? Perhaps it should segfault? That is, this system call is only used wh=
en
> the kernel attaches it, if the kernel did not attach it, perhaps there's
> some malicious code that is trying to use it for some CVE corner case. Bu=
t
> if it always crashes when added, the only thing the malicious code can do
> by adding this system call is to crash the application. That shouldn't be=
 a
> problem, as if malicious code can add a system call, it can also change t=
he
> code to crash as well.
>
> Perhaps the security folks would feel better if there were other
> protections against this system call when not used as expected?

Isn't that the case already, or maybe I misunderstood what Jiri wrote [1]:

> On Sun, Jan 19, 2025 at 2:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> that's correct, uretprobe syscall is installed by kernel to special user
> memory map and it can be executed only from there and if process calls it
> from another place it receives sigill

Eyal.

[1] https://lore.kernel.org/lkml/Z4zXlaEMPbiYYlQ8@krava/

