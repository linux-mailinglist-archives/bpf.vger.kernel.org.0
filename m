Return-Path: <bpf+bounces-55144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95137A78DD7
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15F5188A5D5
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F2238177;
	Wed,  2 Apr 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AZpCniPa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqchoK/L"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18323371D
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595614; cv=none; b=GZCAkcGJ8FbtrDUifpzFGva20uT3mm8vTM8mD8tE5zATbjbKH6/Qtg3aRBhVBGGFIp1ALHL+DvHKkGCt9AbD+67v3mPeZUnJDlVQyDGuinv58eslWa8pSmO7trCjwN1txDdqJM9u54EHnmM+z+CpSORit32ZIGhRzXRydwb2Uvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595614; c=relaxed/simple;
	bh=/Px5bPwwuLj3mg4AamCtb5AhGfib36tDEDdv2QSHseY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1poBnSA3grecV85l7FnRLzshAxMlCalX+YCsXY4m/gNh/H3EZaFpyMTE7bYT0MIvf0UMW/lKwOP8YNrxyw6Ak9SXwPdFB1aYKlWpdeD83O/IfuOummUjoTRbK0YLW6mjAERlgi4qFv77fEs3/faRdHjtleC8oz/4b7Yp/jYhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AZpCniPa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqchoK/L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 14:06:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743595610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jUxd5IMbfhiHHFrQIVRb+i9IUafb3y4GTnZmxR3aZk=;
	b=AZpCniPaVFMAyb7Y29u8dNRnrrKnTpaG6J/vNIRPX2Rjho13HR86he654uvxJnXxsRZ8VM
	udu/+x9ywcnq+PJdYW3FKR2oXXEs94Wa2bxikkKRLQXqGZt2NRUugpp19CQFbjGLogEqX5
	3q52r6W3K1jIHm2ALe9E3wVbx/nrmCMgUVdIJdxIRfke1K6U2hHzjOmZtO+enMoq1eCTKr
	A8KnyWb513nEU/hSmQAehDTjB7nFuyI+z0VZ3X1LnyMG5St6XfpQwlPqUh3Iwh6utShXLt
	oM1kbfO2hvjVg0i+5/sQBFWsA2Y1k5hCu00CvMc/BaWiuQYzCM4hQFc06BEZyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743595610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jUxd5IMbfhiHHFrQIVRb+i9IUafb3y4GTnZmxR3aZk=;
	b=RqchoK/Ln4RjKpMRxRf9rbUp0mAQ9QOijnqZUyYtNA+3xxc+7hta8xmFLgneNseDZreIb8
	Fgi6sr1PcAMA/eBA==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402120649._gQHEtYM@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250402091044.GB22091@redhat.com>
 <20250402105444.tW8UU7vO@linutronix.de>
 <20250402112007.GE22091@redhat.com>
 <20250402113142.GG22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402113142.GG22091@redhat.com>

On 2025-04-02 13:31:43 [+0200], Oleg Nesterov wrote:
> > > > Then we can remove the no longer necessary preempt_disable()'s
> > > > before write_seqcount_begin() in other users of seqcount_t.
> > >
> > > This depends on locktype that is coupled with the seqcount.
> >
> > Yes.
> >
> > But seqcount_t doesn't have the "internal" lock. Unlike other
> > seqcount's defined by SEQCOUNT_LOCKNAME().
> >
> > > If the lock disables preemption and relies on it then it must be somehow
> > > enforced on PREEMPT_RT or rely on the lock+unlock mechnanism to avoid
> > > deadlocks. Also it needs to be ensured that you don't have two writer
> > > since preemption is allowed.
> >
> > Sorry, I don't understand.
> >
> > Again, seqcount_t differs, it can't do lock+unlock like (say)
> > seqcount_spinlock_t.
> 
> IOW.
> 
> I understand that seqcount_t is not RT-friendly, but why exactly do
> you think the patch above can make the things worse?

We wouldn't notice such a case.

> Oleg.

Sebastian

