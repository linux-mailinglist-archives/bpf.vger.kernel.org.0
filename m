Return-Path: <bpf+bounces-46522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2E9EB4A6
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 16:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C71886266
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364EE1B86D5;
	Tue, 10 Dec 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ITqQqAE1"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA11B85F0
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844123; cv=none; b=iHdO06SD7lxYncqggDFwCne0wKFWYwIh00VnACZM4cX5pEOkXdCKJake+P1jNseqSSpkVaFnNWiF64hvFHkldUqLbB4l0gywE70Ssh8cemRfCcoiPIcvp1im0RyD3tM+8HVxnDhU6ti6QnioE55XteKaazZzzqovnhdWyrUFNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844123; c=relaxed/simple;
	bh=EKOLhptBsFEhkwrg01m2vCC8ID8MkHR5VfRuOrUvRIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fteCeXcXzU65+fxU8u5GXf3QnRbWDLrYN7g4RgwMnxJzkugg8IiPFKrv52xZX00BYntqZmcO2bynufSXBXsBd74MsalFBKwBIeJy2knKx6aQucg2WBBaI+bT1vGpyinNBTEIcxEkpgQH00wiRH3ofCOV7+gc0DvDw33m+4c4R9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ITqQqAE1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J3yNmvyX55aa/m4mwbEYXamXlXDyCNPNi0BIlyXZ4+8=; b=ITqQqAE1NKs0qJAAJn/jqO280s
	bu0msO7d/4Acha1AWH1Pg+fILSJPSFWCMJu+vskO0HF1AMa28fL6SW3GKKhg6CTD5ZNT69F5eLXKX
	opmpoHT4w3mtK0hxCryMtsjWyLGFusNLJcJ3I9KQ0/jyxPbVwz287yAdGB1kYEf0OSK3P9Zo/KIar
	/itVgiF+V8Kr/8/cJEVWe8h4Sdgwo4T2QJdAYjrUr8PXHHc8s+mfft5qBc8c3Oa8hsfetf5Cvfn1b
	zOt9lp9dL0fuEQYODTzUP0ErbYPVAibe7SHswGc9bZjh/iWM1Vony999fOwt5Zoip8GJpBOX92lhE
	kT5tJ11A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL23h-0000000A4T6-1tFO;
	Tue, 10 Dec 2024 15:21:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0496E30035F; Tue, 10 Dec 2024 16:21:57 +0100 (CET)
Date: Tue, 10 Dec 2024 16:21:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Saqib <usama.saqib@datadoghq.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
	bigeasy@linutronix.de, torvalds@linux-foundation.org
Subject: Re: BPF and lazy preemption.
Message-ID: <20241210152156.GX35539@noisy.programming.kicks-ass.net>
References: <CAOzX8ixn1d4ja+LOJq_S_WDq=ZqtUTcV0RZzKpyJ2Yd0pBMx2g@mail.gmail.com>
 <CAOzX8iyS6ODErbnkyZO7RyVfXBCL5CFX5ydoKcvzc9LZf425Vw@mail.gmail.com>
 <20241210141413.GT35539@noisy.programming.kicks-ass.net>
 <CAOzX8iy=hELHmPAeMxQ3on_6dqJmJryGgvAXRxMOijqr+Jj62w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzX8iy=hELHmPAeMxQ3on_6dqJmJryGgvAXRxMOijqr+Jj62w@mail.gmail.com>

On Tue, Dec 10, 2024 at 03:48:32PM +0100, Usama Saqib wrote:
> Thanks for your reply. It is correct that the problem I shared is
> already present under PREEMPT_FULL, and as such there is no new issue
> being introduced by PREEMPT_LAZY.
> 
> My main concern is that if PREEMPT_LAZY is intended to become the
> default mode (please correct me if I am wrong here) before this
> problem is addressed in the BPF subsystem, then this would result in a
> big regression for us. This is especially true if distros pick up the
> changes in the intervening period. I wanted to draw attention to this
> issue so this situation does not happen.

Fair enough; I think it'll be a few releases before LAZY is in any shape
to be considered a replacement in any case. Quite a lot of cond_resched
(ab)use needs to be audited, Live-patching needs a bit of TLC and so on.

