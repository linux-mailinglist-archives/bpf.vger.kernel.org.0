Return-Path: <bpf+bounces-46913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A69F1842
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C30218856C5
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7818A6AF;
	Fri, 13 Dec 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN8oLFL+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0598191F6C;
	Fri, 13 Dec 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127204; cv=none; b=jH2/Eqwcj1WKcJBZ0zEScBSf7grQO80OTeT9waTTviOUfu90avhRp+YEJAWFZdNjafj+uz38LjZgzGiGERjoFor7HAtghqe5q5orGmnz29uEy05mBLBQ5mYzOCQcoflU2+Y/Z4jgXE5tOfsQrBM3JNvOTsOE/niDHHTCGZtk3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127204; c=relaxed/simple;
	bh=9I7jc1DX3DaIFFopBSZ4wu1k+NPSlYdd9tFsgLMkvGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWBkFNwBko6EalNaXXFukRlh3SN0C3rDI4ughprf0P1zHuAxyZuoOMJj2qb2keqDmthziue/vDEUNTyq0GexQAapb/y4X6b2ZVB0xfA18i4b6UqLJ7qeIaNI07AJy8J845m1aY+3KruFfOiuIDGSSmDPvgcMnscKkxy6qdn13cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN8oLFL+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21628b3fe7dso19061415ad.3;
        Fri, 13 Dec 2024 14:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734127202; x=1734732002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ewD8EgJf55IsD5hRUbEqPM4ENcw2eA3d/FI7PPWYuQ=;
        b=cN8oLFL+zBWN7vYa8UH+op9mEt5iOSNx1ZeyYRqKe7d2FdNYG5ulqjqUiMb33x7Y75
         upYuX4lgabU62bckMvJ+6rkHMtBArb5L6PrYWv9gAUoppn5nB0sNeVFm5tg/aNi8FeAS
         3OhAs4qsDAMwSJBKsv6xuRFdWZRrpoNlI1szDttvTXoWyaO3iXlH01Wz/UEB61x151/L
         7khG1fAj5Np0hKA9ypMsDqmq5Li3h+X/cjyoS3xHPmdvRhPZV7GLT6tFRRmGHSTIchEV
         1ODE6KfDG0mKa2YMd64xHMXvcwybIW+n9eARbpBYlkFsSC/5OY8EXYJKtDLLh2vgXCHt
         BVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127202; x=1734732002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ewD8EgJf55IsD5hRUbEqPM4ENcw2eA3d/FI7PPWYuQ=;
        b=TAfuooerhy2/26f6KnPPTKPJF1B8KCC8Yru/ZQmj4n//SX824Zo2ngclHQJ5pyFW9Y
         XEBOAwUK3h8L5kcgAuJG/Gcd5vRxypYlmPVSpzdn+YA9mJF3broyIg6UWIZIZuUVM8Al
         CWjLoxN7myM86/G9ydK7yQj25+rPtOfqqgsT6m2l21g+qo19TpoPDFOMA4/hoqU5NLb+
         yH1CPkYKEZcnfcUYNz/QoEB5QYaK0kDefFouHSOhRLUV7tyD+2EioMUtEXfN+/Wdtoim
         b2p6XFLhQMAfH0KP9wT0wdZzMB8s+Px5qtI1wZP4viP3zzqoeR5iNA70tmZ9aIxiORTN
         TO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAitbXB2jN6bDJgLJKJQn0TlWrNRVzl5ESMY7weH62mTDyBYeKYQf+RK4hKDtjPZsw6pM=@vger.kernel.org, AJvYcCWgtsdW5HgjZwsQTg1yVdUIyS/lPFiCbL+LY/DpL0CyzeJY9YurLgKIGaYDpWnRQaV0GrRiklngUdTe/vO6@vger.kernel.org, AJvYcCX0epVAfSDG4OZDhBjyCZ8bks9jcPFmU68k/unn6UwLbA0FMNMj+BfQSfYtFgGlpcMmDDqLPbNXy3w3aOREnnbGrext@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZQOFXW+Ppwg7zi2HWUuZTJX4ijL6SaDtzQjFK2cY1F28NAty
	mx36DRyP/TlBpsdteriMewBhcMXews29X/c95runm2/fooXo/FZWY9LVu1FMOEfOrbJnekdrlq2
	TTQSBRIxNUE1bTD9+H09oxKUxaLA=
X-Gm-Gg: ASbGnctaLzvAoDhR3CrM3a908marTqAEq0gn/MOqOVtRZ7WmSw98yPLGd9oz2VmRkED
	5eWtFAXJ/bP40cCt/iVFlIz0b7AOBBBOF6R+DklXIKOeKDHy3WkCiDA==
X-Google-Smtp-Source: AGHT+IFZpl12YmemAcyWgQMb0bUsiVqzKLSjYNMZRG50kZGLjKtv2W6IyGN4k/haaBN7zt8pDvcRrd7omTL+yPNHh9I=
X-Received: by 2002:a17:90b:3b52:b0:2ef:2d9f:8e55 with SMTP id
 98e67ed59e1d1-2f28fd66b3dmr7300719a91.17.1734127202257; Fri, 13 Dec 2024
 14:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241213105105.GB35539@noisy.programming.kicks-ass.net>
 <Z1wxqhwHbDbA2UHc@krava> <20241213135433.GD35539@noisy.programming.kicks-ass.net>
 <Z1w_Qi_Wya56YDO_@krava> <20241213183954.GC12338@noisy.programming.kicks-ass.net>
 <Z1yslwyX0yYzS_sb@krava>
In-Reply-To: <Z1yslwyX0yYzS_sb@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 13:59:49 -0800
Message-ID: <CAEf4BzaOSAW6cQ3DYK-WJCFs-cW8+ayt5Qk9cBJ=VRXzi81htg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 1:52=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Dec 13, 2024 at 07:39:54PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 13, 2024 at 03:05:54PM +0100, Jiri Olsa wrote:
> > > On Fri, Dec 13, 2024 at 02:54:33PM +0100, Peter Zijlstra wrote:
> > > > On Fri, Dec 13, 2024 at 02:07:54PM +0100, Jiri Olsa wrote:
> > > > > On Fri, Dec 13, 2024 at 11:51:05AM +0100, Peter Zijlstra wrote:
> > > > > > On Wed, Dec 11, 2024 at 02:33:49PM +0100, Jiri Olsa wrote:
> > > > > > > hi,
> > > > > > > this patchset adds support to optimize usdt probes on top of =
5-byte
> > > > > > > nop instruction.
> > > > > > >
> > > > > > > The generic approach (optimize all uprobes) is hard due to em=
ulating
> > > > > > > possible multiple original instructions and its related issue=
s. The
> > > > > > > usdt case, which stores 5-byte nop seems much easier, so star=
ting
> > > > > > > with that.
> > > > > > >
> > > > > > > The basic idea is to replace breakpoint exception with syscal=
l which
> > > > > > > is faster on x86_64. For more details please see changelog of=
 patch 8.
> > > > > >
> > > > > > So ideally we'd put a check in the syscall, which verifies it c=
omes from
> > > > > > one of our trampolines and reject any and all other usage.
> > > > > >
> > > > > > The reason to do this is that we can then delete all this code =
the
> > > > > > moment it becomes irrelevant without having to worry userspace =
might be
> > > > > > 'creative' somewhere.
> > > > >
> > > > > yes, we do that already in SYSCALL_DEFINE0(uprobe):
> > > > >
> > > > >         /* Allow execution only from uprobe trampolines. */
> > > > >         vma =3D vma_lookup(current->mm, regs->ip);
> > > > >         if (!vma || vma->vm_private_data !=3D (void *) &tramp_map=
ping) {
> > > > >                 force_sig(SIGILL);
> > > > >                 return -1;
> > > > >         }
> > > >
> > > > Ah, right I missed that. Doesn't that need more locking through? Th=
e
> > > > moment vma_lookup() returns that vma can go bad.
> > >
> > > ugh yes.. I guess mmap_read_lock(current->mm) should do, will check
> >
> > If you check
> > tip/perf/core:kernel/events/uprobe.c:find_active_uprobe_speculative()
> > you'll find means of doing it locklessly using RCU.
>
> right, will use that

phew, yep, came here to ask not to add mmap_read_lock() into the hot
path again :)

>
> thanks,
> jirka

