Return-Path: <bpf+bounces-63007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75D3B01536
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E44483DAA
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CAF1F1301;
	Fri, 11 Jul 2025 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RiqrnJt+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUm8QtHc"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05AC1F4261
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220362; cv=none; b=Zu6BH5H/5GrAGKt/xXEb3V5BNXROWlvPso1Lsgrf+ytKy0POJwABuDplpOFDDRNb3JIIxTqjo8lS6XLRAIWDU87PHdlxw1gxreTyZxFWEewPAPH6HVrfpcorrBrxivorAM5nio1lW0hSdusHoTAWlxFN51/tEYmU6918hV/K67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220362; c=relaxed/simple;
	bh=5n95+4SMEC9dWAl5vWi3boEj3Y2G6c66JNrAWFbLZaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu2g4UQN74SMN58OQ8b1yD8DTNHGK5zo24bbs34cfOEZjRd6KXXGn2O1EbvmefjiSTBbh6vGftgKG+5gVBBm7vfAcOhKAoJtTdbm8hrjY+t8KFQ584ELAJKEMuSp1rGs9/c+hQh7GR0TuXdftyszPdPoFbEDPdisNhY/fg5nEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RiqrnJt+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUm8QtHc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 09:52:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752220358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9p3/lOEzIkzqGBOZIoy9S4wc774rzvONwLTqO2l6Jr0=;
	b=RiqrnJt+Oa936pVuR9yrejPYUj2KQlq3Thoceh8e7jeMrhKE9f7gyh9quMsxIR72K0Z5/c
	VWpjhqjbYCgghsLH8l10XIfKyXGucWkROOVJX9ltUcP7IocIlxeDt43lWItfYHJsPoyMps
	IAtAslMDxkL6/gloLC9T2W47C4SdveusJcLURNRgYfTRrB+mbHY4UIYHqK/nzn1HCeg5Cv
	2qSuaB3WNf+ADMt7vSi5wDibQqBAn75UfxnSaG0CdezfH/0y2OfSOwsqcExBrdoA+7OKUb
	24wIM7ZTTZ87mitW7kime1poVO+942yM2E3i6+kbEx4rMbU0V9OXQ2creSANCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752220358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9p3/lOEzIkzqGBOZIoy9S4wc774rzvONwLTqO2l6Jr0=;
	b=bUm8QtHc8fsdEzibKupfGJsFm8VJDivG0vmroKUbhAPAQqpwiM3U+bqrTS39SWC+E/f9N/
	e7rcPCF8WIGu77CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2 2/6] locking/local_lock: Introduce
 local_lock_is_locked().
Message-ID: <20250711075237.fxp08l0n@linutronix.de>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709015303.8107-3-alexei.starovoitov@gmail.com>

On 2025-07-08 18:52:59 [-0700], Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce local_lock_is_locked() that returns true when
> given local_lock is locked by current cpu (in !PREEMPT_RT) or
> by current task (in PREEMPT_RT).

+ The goal is to detect a deadlock by the caller.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Sebastian

