Return-Path: <bpf+bounces-34260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70B192C1E3
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8551F23718
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753C1A00FE;
	Tue,  9 Jul 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krsMThMX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0A19DF97;
	Tue,  9 Jul 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543334; cv=none; b=tkl4oy/poVMfGHGhUI26LJvrX0tleDmqa2nu+ydmE5JKsemGV/CacoUA9mfEaMTH6DUG6Dn9/GUP89wPsflQ6j6MMtKm4OZRHtNjixFeqrZirwBUQ1MjaIFl2HIMK0SlxVP/bfW7vVvCA1z+kkZ/Tru7G4sccLAwgUQj1w4f+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543334; c=relaxed/simple;
	bh=TOPEQCqKNtP+Zy4WyKXZJU6SqsZ0Lay1/kaf2uXX1Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7oV+vJSgS1hoY+tllXn6k3E84g79AoEDWtynqM6WCyX42agh9fJblkYZgHV6A1178SdOv5Gx+BRQ+CwbgsnIDxRiQRkMshRLoxFQM5Zt5vf6w1kXmqQApqjTDmfKFVXgRkqDqODdhQTOZ7HGHSyj59RX/SN4l7LhIKx6sfFaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krsMThMX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so3675136a91.0;
        Tue, 09 Jul 2024 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720543333; x=1721148133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn2AUZgJ/nLQYA7uztloOzDIbm4J/qB8cIe6P5OOgrM=;
        b=krsMThMXUfpSeSydQvGKPUvLhzdssqvf50d6q/irzMGt0PeXvWI0wHJ8K6O4mHN8uI
         dDcPtfAeI5bQBlJn2eW4SgD0HjNLoUtYfDaSyFcYrfqtMi1cmlP3+gm5h9raf65hwgeJ
         lQRjbFJ3cOXj29KavOI8JpeCVX3zcAmIgHAWQiqWtrZ8vKKGAZS359+r0leITWmsAyU8
         LUXK4MYpvsNeKiXDpD36+ua89Hn8pstNEHw0f79fVcyAUi24e3UTrj5zdqfMMexbDbpj
         yivUkr4kcNDfM5M81pS097VOCU+w91nLdcOF/NTCH0vAV5DDusVC6YBGPoV+cRAs0z2l
         946Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543333; x=1721148133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn2AUZgJ/nLQYA7uztloOzDIbm4J/qB8cIe6P5OOgrM=;
        b=MHsjzM+q0T+pSLoCRSYPLOz09sppSf55Zk6SPdd/wJJq4ltD5JUL1I3NJBhT2t2pms
         6BrOAYwjjUjiMhBrWZRUl2WRxL6Hh3gcHe3iJ8wZcdGWYsmLpstl5rhnbvMtsuWCXMts
         QTyFWuWmYhvYp8IQH+EQi7sDPKqTKEhZGGZjKo4Zebkq33Ag14poNHfp9Q0hrrNT34B+
         YbM1COd/+fu5g8Im+9KdbW5uSatXkc4s1BKQuzinrlTFIU0xtfbvPyoOwoIY+F9ZqUT4
         Y2H/539Ms4GG6Qp5gLecgY6Zwi352VisPNCz5lNWDZcmtqjxOLjRzxSrQF0ukUbaLzpj
         2Qag==
X-Forwarded-Encrypted: i=1; AJvYcCU4eVkAmlzqALNLjKVGuCyhkbKCJHx8XHRL9sinqyLLmlWNLlNm247y+4dM9LdErkEpIJLzLMkpv98gu1BNLwPfxDoi2XkINRf0W4alHbs96FA+RofIZGcocUEb6OjeSn2h
X-Gm-Message-State: AOJu0YzNtUDXPlvrL3mz52e5MFRtNr7Br4x//YAOJizczKAc8s0JHb/V
	9XVlGuVD4XUb3IHvhd4ZLANFEA8QfyVj6ALYNgtIc/kHjOA2VYISW1b+ANvrTnrdbvIiZg7TsZe
	SiFtKgqgHFiskEspDrzuBS0+w/7M=
X-Google-Smtp-Source: AGHT+IGIeoUFFQZgHj4FUZ4jNJFai/RmD3uRoWIu0MLKJb6LuShRNp46411Onm2qUU3jxmaVfTH0cub44G0df0f2qlk=
X-Received: by 2002:a17:90a:3001:b0:2c7:aba6:d32f with SMTP id
 98e67ed59e1d1-2ca35c69399mr2729893a91.22.1720543332573; Tue, 09 Jul 2024
 09:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708091241.544262971@infradead.org> <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net> <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
In-Reply-To: <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 09:42:00 -0700
Message-ID: <CAEf4BzZp31-skJQWcv_H+iTG52dAbX+YeXkZ4d+HMaXRyXhJQA@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: paulmck@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:11=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Tue, Jul 09, 2024 at 11:01:53AM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:
> >
> > > Quick profiling for the 8-threaded benchmark shows that we spend >20%
> > > in mmap_read_lock/mmap_read_unlock in find_active_uprobe. I think
> > > that's what would prevent uprobes from scaling linearly. If you have
> > > some good ideas on how to get rid of that, I think it would be
> > > extremely beneficial.
> >
> > That's find_vma() and friends. I started RCU-ifying that a *long* time
> > ago when I started the speculative page fault patches. I sorta lost
> > track of that effort, Willy where are we with that?
> >
> > Specifically, how feasible would it be to get a simple RCU based
> > find_vma() version sorted these days?
>
> Liam's and Willy's Maple Tree work, combined with Suren's per-VMA locking
> combined with some of Vlastimil's slab work is pushing in that direction.
> I believe that things are getting pretty close.

Yep, I realized that this might be a solution right after asking the
question :) I've been recently exposed to per-VMA locking, so I might
take a look at this later.

>
> As with your work in 2010 and MIT guy's work in 2013, corner-case
> correctness and corner-case performance regressions continue to provide
> quite a bit of good clean fun.
>
>                                                         Thanx, Paul

