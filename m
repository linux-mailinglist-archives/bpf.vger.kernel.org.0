Return-Path: <bpf+bounces-55136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BEA78CB1
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593263B197B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E412236A7C;
	Wed,  2 Apr 2025 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UKWbw+wP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eioyDVbS"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500A14375C
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591289; cv=none; b=qZ/NsqGKTjF5guHckBSdbRj79WjYBEynT4oMvmIOxU7zlv40mXTzKtF4iV0Sm3CsUCQYsqMikWmdfxclhLSJqNymg7NxeUIAkJSr0UBip2Bpc9zT0vnXXUjqnTTFV7NxEytjNkN2Cz/tVHGkxk07oE1HGSIDI8BuXfXP76nmYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591289; c=relaxed/simple;
	bh=oLWXhZ33xuy9zVDG3IEMsldxkhmR2C68YxSisX283x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDWTbW9bOCesEbBCVbv3Q+/O+mi6sBMBKKJrX+uDjMTOrIZuzw1L724byyyGtsxJPSkWjSH6gLTg3rdn35Hu1fEaoiKHMkahQSCBF9K4olG5V8DLp+BHn4Yw9EaB/IcJqdLS5Fy9sXJ0hz9RlwCiKSRy4y7yPobFMe3iozirLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UKWbw+wP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eioyDVbS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 12:54:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743591285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhI4xfEPxgBkfhNnQXk3UWE1HUnpz5ET9vTVE9mWNUY=;
	b=UKWbw+wPi30GcD06tP4F9VB2jMA5wG3vyT2E7gHQ8SJe+zcRZ/6Qcdf5xTlCcpkCySfvkU
	tsKiYW4D078vw+sho0h7yi7NqgKtVtAWWzsIDiupU1WZHLpVCqaNmVjozUqoNDemLFHUox
	QKzzqjveZb8gslN2h2gwKhseeW8EED8cR6gwVQFVgQbO27w7MomJ7CSgT3xU0aIiSj7m9/
	Hy6H7duOgGWrp7g7FcraazegomcxS0vgsi4fMXTnikgqltY2TZ5cta+5kzPm6VKbuVpURT
	56XodD+Vay0K2tkXSTHo/ua43Zn72w9XRBL4zzLw9drXHjvM7ERORK58LdzSMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743591285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhI4xfEPxgBkfhNnQXk3UWE1HUnpz5ET9vTVE9mWNUY=;
	b=eioyDVbSywAlWS77oCOSwpXk1v22rLK0EuPRdRhGbqfhr5P7HF12j6o3qSHKY7YzIXsyLZ
	803w59gCN2q0VSDw==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402105444.tW8UU7vO@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250402091044.GB22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402091044.GB22091@redhat.com>

On 2025-04-02 11:10:45 [+0200], Oleg Nesterov wrote:
> Add Peter.
> 
> I never understood why __seqprop_preemptible() returns false.
> Stupid question, perhaps
> 
> 	--- x/include/linux/seqlock.h
> 	+++ x/include/linux/seqlock.h
> 	@@ -213,12 +213,11 @@ static inline unsigned __seqprop_sequenc
> 	 
> 	 static inline bool __seqprop_preemptible(const seqcount_t *s)
> 	 {
> 	-	return false;
> 	+	return true;
> 	 }
> 	 
> 	 static inline void __seqprop_assert(const seqcount_t *s)
> 	 {
> 	-	lockdep_assert_preemption_disabled();
> 	 }
> 	 
> 	 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
> 
> makes more sense?
> 
> Then we can remove the no longer necessary preempt_disable()'s
> before write_seqcount_begin() in other users of seqcount_t.

This depends on locktype that is coupled with the seqcount.
If the lock disables preemption and relies on it then it must be somehow
enforced on PREEMPT_RT or rely on the lock+unlock mechnanism to avoid
deadlocks. Also it needs to be ensured that you don't have two writer
since preemption is allowed.

> Oleg.

Sebastian

