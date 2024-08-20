Return-Path: <bpf+bounces-37636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68425958AB0
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 17:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23FC28768D
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DA192B9F;
	Tue, 20 Aug 2024 15:04:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51F192B6F;
	Tue, 20 Aug 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166282; cv=none; b=grPWZO6oLwQTQGFI3f0qlaWd0wUmDtKTtuT4BahW73m8A+yC/Bwvlj7yGKptPBJjSQHYd5w5vpgFmy2+aqaSB1uhL/iCziHUXGtPhjg6oF1019lyF1qEgDfooIgMGr9zfEmojPFIt2QWDDsvGGn+T+QSO1xoKMtndJZALyVYnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166282; c=relaxed/simple;
	bh=80PM77WG0gFp1uShBuw0+NR4/r1wVC1wGMKPmuudLos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KizMcUcpqHDAr3iZqpzENIpgVWfFDkqHTFnRmYOKcB5mS3rV5MEd9KRGw9v7cgNk4juMkHf04kWbWoWlGuO6huKeSRAcydPsV74mfehb3262OK16pDmTeIeyel1Ea6+nX4HYmREFJA7btAc3WfIZLM7CUfK5q/r/hkjuB6lzyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F1FC4AF0C;
	Tue, 20 Aug 2024 15:04:40 +0000 (UTC)
Date: Tue, 20 Aug 2024 11:05:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Juri Lelli
 <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Artem Savkov <asavkov@redhat.com>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program
 (6.11.0-rc1)
Message-ID: <20240820110507.2ba3d541@gandalf.local.home>
In-Reply-To: <ZsRtOzhicxAhkmoN@krava>
References: <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
	<ZrSh8AuV21AKHfNg@krava>
	<CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
	<Zr3q8ihbe8cUdpfp@krava>
	<CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
	<20240816101031.6dd1361b@rorschach.local.home>
	<Zr-ho0ncAk__sZiX@krava>
	<20240816153040.14d36c77@rorschach.local.home>
	<ZsMwyO1Tv6BsOyc-@krava>
	<20240819113747.31d1ae79@gandalf.local.home>
	<ZsRtOzhicxAhkmoN@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 12:17:31 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> > Could it be possible that the verifier could add to the exception table for
> > all accesses to tracepoint arguments? Then if there's a NULL pointer
> > dereference, the kernel will not crash but the exception can be sent to the
> > user space process instead? That is, it sends SIGSEV to the task accessing
> > NULL when it shouldn't.  
> 
> hm, but that would mean random process that would happened to trigger
> the tracepoint would segfault, right? I don't think we can do that

Better than a kernel crash, isn't it?  I thought the guarantee of BPF was
not to ever crash the kernel. Crashing user space may be bad, but not
always fatal, and something that can be fixed by fixng the BPF program that
was loaded.

> 
> it seems better to teach verifier which tracepoint arguments can be NULL
> and deny load of the bpf program that would not check such argument properly

These are not mutually exclusive. I think you want both. Adding annotation
is going to be a whack-a-mole game as new tracepoints will always be
created with new possibly NULL parameters and even old tracepoints can add
that too. There's nothing to stop that.

The exception table logic will prevent any missed checks from causing a
kernel crash, and your annotations will keep user space from crashing.

-- Steve

