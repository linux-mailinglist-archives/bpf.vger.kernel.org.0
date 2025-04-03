Return-Path: <bpf+bounces-55213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB46A79FB2
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFF13A74D2
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03DD24166A;
	Thu,  3 Apr 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dxuDi4Fc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/BevF6cF"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B224336B
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671320; cv=none; b=lSiT38K6djmihFSoA6CuFPE6rlOypjlVei24nxrrFmM74zgsGdBS//j8k0E1sl2AVgv69+Q4Rju+Y6wGJJ/Wb44Kr3al72lrJ8A13jNGX2qbxLulTrIm0KCjM/W62aiCuJ0FKSyEZg2vy8py9UKVyquLEI84N+TgsnR8s7YSUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671320; c=relaxed/simple;
	bh=E0srXR+llhqLPvOM35cCcBzp2ae5Rc+FQKST1Ofqa5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD5KUVWu0Y0NTFRmCkq1voQts4dqgsMRCCZxv9Nrv+/PS0jIMFWyvXuaNlZ75/BTTET5XYltrlA/oTjC1KSfiUMwY5NoiAbfs5Xtnh4p13J8jIoHThu9iYJDbRl0p487zBDqyGlGkIALMHc19HizLF88pvz0Mo+MWylRVrPKarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dxuDi4Fc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/BevF6cF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 3 Apr 2025 11:08:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743671316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I122sQnbeakmqIOE8B6fHoFDLjURNTLj+rveTb7E4qk=;
	b=dxuDi4Fcu5yDxpLkch0tRZWFOZeG5K2Hkp1ToebBlLyUDJbqOP6zqXxkPn+HBw63Zc/P/k
	xjWjbfg5uXtGYbj4Itzp+EDE/7k+GaxrdacjID5eQC/EbHHib5mZ5shNZ0XzkiSpYPy1zr
	DVLsg25FcWLnY91CulhdjfeaGi0ljFjK4lxxPw5dn4iHQTHutad0pWSqfPcaqETWqpLF+u
	MC8Xqq5FKODbWw2cJTMQbN3IlWDCiWyrdL9kaZ/5scddLt7gNx+H9pOK0/C3gGIPNT8kBh
	tiP0iDpf3FjnXdMS2SjaMyZoAR+HebZhmjYZo7tSItl1SEqjzXa0HnsiOZTvVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743671316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I122sQnbeakmqIOE8B6fHoFDLjURNTLj+rveTb7E4qk=;
	b=/BevF6cFlDgmefZGMt8qIfx/hNk0DKXOWIaAL3efUkI/VHj89V+F1yzyPPVd65p/3ltzOl
	vAVxfno3ShCsLwBQ==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250403090834.rp7Y4KRt@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250402091044.GB22091@redhat.com>
 <20250402105444.tW8UU7vO@linutronix.de>
 <20250402112007.GE22091@redhat.com>
 <20250402113142.GG22091@redhat.com>
 <20250402120649._gQHEtYM@linutronix.de>
 <20250402121228.GH22091@redhat.com>
 <20250402121624.lRIPMa_h@linutronix.de>
 <20250402135641.GJ22091@redhat.com>
 <20250402142349.GL22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402142349.GL22091@redhat.com>

On 2025-04-02 16:23:50 [+0200], Oleg Nesterov wrote:
> OK, it seems we can't understand each other. Probably my fault.
> 
> So, it think that
> 
> 	static inline bool __seqprop_preemptible(const seqcount_t *s)
> 	{
> 		return false;
> 	}
> 
> should return true. Well because it is preemptible just like
> SEQCOUNT_LOCKNAME(mutex) or, if PREEMPT_RT=y, SEQCOUNT_LOCKNAME(spinlock).
> 
> Am I wrong?

A seqcount_t has no lock associated with so it is not preemptible. It
always refers to the lock. This should come from extern so it not only
disables preemption but also ensures that there can only be one writer.
The "disabling preemption" is only there to ensure progress is made in
reasonable time: You should not get preempted in your write section. If
the writer gets preempted then nothing bad (as in *boom*) will happen
because you ensured that you have only one writer can enter the section.
In that scenario the reader will spin on the counter until the writer
gets back on the CPU and completes the write section and while doing so
wasting resources. No boom, just wasting resources.

If you make __seqprop_preemptible() return true then
write_seqcount_begin() for seqcount_t will disable preemption on its
own. You could now remove all preempt_disable() around its callers. So
far so good as everyone should have one.

The problem here is that for !RT only seqcount_mutex_t gets preemption
disabled. For RT none of the seqcount_t variants get preemption disabled
but rely on lock+unlock mechanism to ensure that progress is made.
With this change it would also disable preemption for RT and I don't
know if it is is always the smart thing to do. Usually if the splats
pop up the users can be pointed to something else. Then we have also the
"limited" API where you can't use spinlock_t within the seqcount because
it would break PREEMPT_RT.

I've been now verbose to make up for the other few times where I was
brief :)

> Oleg.

Sebastian

