Return-Path: <bpf+bounces-55148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A53A78E08
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0050D3AAD69
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1823A58B;
	Wed,  2 Apr 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tH6g8IAf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CbT04qDU"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA08239082
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596190; cv=none; b=g4FkKZndn7gsAAA5U17XdbnryXipPRpEHSw+dMtGMcnCrSIMGjHLpeyw+HQUTidcevs6/xJpYAG3DaVEWSPS1/zARwjIjz1oiYWSPZ3irWipbcdchFdzEE0uGSB2TaWv0L4AsI9VpdK0h3fcUdrdtKRt8lPj4cPDqna2AM7cGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596190; c=relaxed/simple;
	bh=59947Uzvz/Wz9HkcMH9W6ivrjIBdj/ddLa4eFtJ6O48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkNd/7fF8svOZbT5/a8Cgq8krE6vUXmf7FP3lV1aNlrIFPwdC+oK5GvFNdoJNN8emH8bwUMYw2bwihqSEYsDXdjlT+dSrNrNBGiN+oY3F654e4pXxtQqCqxg/o+GzAXZkdEKi0fo4YXZTLdj9zidmtFKqhXWB8Gjzuy1nc6d6/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tH6g8IAf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CbT04qDU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 14:16:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743596186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQk4WQsPf11N7Iy+mIpH3whaONZtx1TFQpD1Yg1zXaQ=;
	b=tH6g8IAf+WIhTI3cb6YfvB3LAjnqpV55NX+GAqjr+NSlKJAvyalL1AYQUcgY2zyeCLRWAm
	421gpGh3HnLmzhSif34ze/Mp263yc/bMzD7bPPKcC7Nb5RdutPC4iVOnE6T9fYcsuGQqd1
	hNZMluNgLRlTKElKLuOP0nhBHT8LVvogkFhPDmovUN0GjKoPkx9EkgnNg818ITIzb1UiuJ
	lT9OmTme22vHqbxacEIu6TBSo3WaupZ2A5TyKcHnd4ooWzyJVPy543EDit6po9xR3XaIqP
	wniL4q+2eyprvAwfdF+0wk3y4cCQivoHxcCCyTLV4WcX0og6Cpa60jhFWTajBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743596186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQk4WQsPf11N7Iy+mIpH3whaONZtx1TFQpD1Yg1zXaQ=;
	b=CbT04qDUJsDGlgyLyNz33oIxANPd6wcVARTAoIYW4V86ySWdSUUCAG9OlpXFTJdi5zdQvS
	S99+C8yIN4a3sjCg==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402121624.lRIPMa_h@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250402091044.GB22091@redhat.com>
 <20250402105444.tW8UU7vO@linutronix.de>
 <20250402112007.GE22091@redhat.com>
 <20250402113142.GG22091@redhat.com>
 <20250402120649._gQHEtYM@linutronix.de>
 <20250402121228.GH22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402121228.GH22091@redhat.com>

On 2025-04-02 14:12:28 [+0200], Oleg Nesterov wrote:
> On 04/02, Sebastian Sewior wrote:
> >
> > On 2025-04-02 13:31:43 [+0200], Oleg Nesterov wrote:
> > >
> > > IOW.
> > >
> > > I understand that seqcount_t is not RT-friendly, but why exactly do
> > > you think the patch above can make the things worse?
> >
> > We wouldn't notice such a case.
> 
> Sebastian, could you spell please?
> 
> What case we wouldn't notice?

I'm sorry. It wouldn't notice that preemption isn't disabled and yell.

> With this patch write_seqcount_begin(seqcount_t) will notice that
> seqprop_preemptible() is true and do preempt_disable() itself.

Yes, but that we don't want. This would disable preemption for the whole
section and not allow anything on PREEMPT_RT what would be possible
otherwise. Like acquire a spinlock_t or so.

Yes, none of this would affect hprobe_expire().

> Oleg.

Sebastian

