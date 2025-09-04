Return-Path: <bpf+bounces-67502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64863B447B5
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70AF3B7080
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A428642A;
	Thu,  4 Sep 2025 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXP5tN6C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27573284662;
	Thu,  4 Sep 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019007; cv=none; b=Zra9a+kbneCLY1UX3ASRcHvKa1B8973lSG7KsqPA8l+PWVrYMTwdsRO/RBWPH3Ess/D1BHl/L0VLekN6nupInL43tVN/LLWjWVwCJoabgRrBnE1X9CZGBO8aivBSRi880KDUqjC/vEIggaaNxpkVggADEoXxsfZ7slfcVHA1Jy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019007; c=relaxed/simple;
	bh=rbU3Na218/cO9Dgeu17WUqgnREIxHR6BvPoo+ue3vjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avkRE6QxkBP6eHmda3zOzASYPcqoii5NMPon2QaZKjl7JvxZa8Q+8yiy3dK9TouwOt0DSc/0j6O4xwMFeQ0T2gextgdSWjWUuZ1aLPHfJTkwRuLGAU3fWP1ZfFCYc5nCOeYEzoDu9qKgAoq62zfFkJBsj5LtslHD7ZkOoJ37XXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXP5tN6C; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32bab30eefbso730888a91.1;
        Thu, 04 Sep 2025 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757019005; x=1757623805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbU3Na218/cO9Dgeu17WUqgnREIxHR6BvPoo+ue3vjg=;
        b=aXP5tN6CRqmS8W9OVBIOrkqs22/fUua+YfcasjQ9U/5EczLNu+qzbpnhPTSoiTCUSW
         TqxwEQiEZaozKS8CdWq6OYFIKVXf0B2k8cUQXrsjNqzuuDUksPxdiJFT+QtAHxzF/Vcm
         AfxxspNkC9bOm+4Fnsp5KnghGEtPThpJ5Y+HQ0zhY6DhR2lfn7ZJGvRrI6prSRUFq9//
         sqdkUEVFX5mx80CgjU5Nu8BltoEcF0cb+dXr4MThcTCmz3X3ZQ3BU5isAco1PJPPmhyj
         2mx/cAPSudY/op1UVuEuWrCPaDkucYXPrCZz9L3xyJBnFJ/dTGX+F1faoeGXoLpzjwyx
         eWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757019005; x=1757623805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbU3Na218/cO9Dgeu17WUqgnREIxHR6BvPoo+ue3vjg=;
        b=P2BXeg0UpULM2srK1eW6gXq03Nb9zv7Mh7KBFnh41Ktk23tUvbu36HsBa/bJruQ0AF
         z7FeQF+sTkchDFOPWf1ytu/LEGcqekEaMw7DNZj8tGSkFpwoFm7y08OQoPuntBndSEVR
         /V0qr52YAy1S9DHIVbhk5EXPilEeeGzR7UkfBVT3Juy0WoK2ezsZfJYKMFZZh92NnYDo
         0alToLxi2hQqhO+7dsHpViocGHti4YxKW7IZA2vS/ve8YMxcgi/rISu1BL1FPQUW94DK
         4FLbBeVpeN6ZhNfhgn/2eYLFUcSPN4CgcS2ZjvceKIXPm+nGeb85CNEwsHSsDW40WqH3
         6SLg==
X-Forwarded-Encrypted: i=1; AJvYcCV7SPGBungAc62EKj2+PRD7Pwo7R9QmDii4MpubRITWgCxkef1C/ICHjANu7cVxhdf6GNhuqiVRovuyDrdLPwzb8VRp@vger.kernel.org, AJvYcCVQdwxerionvTThv+QwlhJYDFJk3ExX75o7UqZayyYKia8+2EQAYOSrujcX9ZBspeep9pBuxZoIbvKExQm6@vger.kernel.org, AJvYcCXkCESWdGsLwbxKgsmqV56Ub3xIkHUeTV8IwHSJ4ZQThmtTY6sxXv91nRkXWAyvhTLwwrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvDFci08icLEyvj9FBubaOCrD+mgHj5jSM3rs8A56P/xsvHtG
	JAgUCmOWI0gYOldKxbXyAOQHlSwKqSDzFRWmbg3EUDY1TRlueqf4cDXPd0X4hI9W98p2IvACsQl
	4naml/BdW+IOOnxJCLw1YpabKBMQpNs4=
X-Gm-Gg: ASbGncvp66r/W7XMNz94zBjDIiBLuucHI19JK4xvnZht6EtwmPkLvdYxbkPjO5LB2w9
	Vq1bER0ZTYfT8nozdKyL4vgR2Jtmj7jO/N2omzuBZfJCxJuJdsP7okKz/SevvUXPJ/FH5w0sCnH
	rbqcxFoxI4nKr98d6/2/mbX/CERKigoowE1H6lJUgVG5QQM7AtLR3nFEaj+bYbDJHgNOtyEWTqr
	HEtqcDrMfQ80herVX7ZY4SUuhh/W382HPddKkHoRUpO
X-Google-Smtp-Source: AGHT+IHFd7QUY1bbcvhGtlf6UJwMZcaOS0cCPx4rkGAuPSqto0UUrIwqGSgNhE/V63S1kMVF5DB30TUoLH8XS5MHmZM=
X-Received: by 2002:a17:90b:3e89:b0:325:15bf:4dc2 with SMTP id
 98e67ed59e1d1-32bbb15ada6mr1107990a91.0.1757019005278; Thu, 04 Sep 2025
 13:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-1-jolsa@kernel.org> <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava> <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
 <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Sep 2025 13:49:49 -0700
X-Gm-Features: Ac12FXyUrif6v0X1VJhVWTr6DrgREZstYYDUpRdBEdCxqScp6zLqgyr7pdnFiPE
Message-ID: <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com>
Subject: Re: nop5-optimized USDTs WAS: Re: [PATCHv6 perf/core 09/22]
 uprobes/x86: Add uprobe syscall to speed up uprobe
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 1:35=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Sep 04, 2025 at 11:27:45AM -0700, Andrii Nakryiko wrote:
>
> > > > So I've been thinking what's the simplest and most reliable way to
> > > > feature-detect support for this sys_uprobe (e.g., for libbpf to kno=
w
> > > > whether we should attach at nop5 vs nop1), and clearly that would b=
e
> > >
> > > wrt nop5/nop1.. so the idea is to have USDT macro emit both nop1,nop5
> > > and store some info about that in the usdt's elf note, right?
>
> Wait, what? You're doing to emit 6 bytes and two nops? Why? Surely the
> old kernel can INT3 on top of a NOP5?
>

Yes it can, but it's 2x slower in terms of uprobe triggering compared
to nop1. So while it will work to use just nop5 on old kernels, it's
going to be a performance regression if we do this unconditionally.

So the idea was to have nop1 + nop5, stick to nop1 for old kernels,
attach to nop5 for newer ones (that's where feature detection I was
asking about is important, libbpf will do this automatically and
transparently).

I know it's messy, but I think we have to do that.

>
>
>

