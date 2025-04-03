Return-Path: <bpf+bounces-55256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73479A7A8EE
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B7117796A
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C82528F9;
	Thu,  3 Apr 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FaoI4BDn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZR7lnvb"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95F24CEE8;
	Thu,  3 Apr 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702984; cv=none; b=pVwagypwRKQOq10BgmoKVAg2c+uqfxWO2PfSsyhOkiLDKrksme88dwcHKcLtVpFM1ois2kLS/UB8pbgBKV/fJslKvO8BK06RzVpksKQf/JhlWKKwdsS646zHx6PRdVEP5/IzOztTWRT0/3GKmyJmF5uC20nkoVIr+veDw71PvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702984; c=relaxed/simple;
	bh=rizTYVIoWzIbYzn3OLqRG6dh4TQQiYzE9jAODYFdxhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGa9j0NOsxIL4OLDgvZvcZEtpjGp5Lsmq43eOR0Wquo3G3lf0WE/AhdP1CtDHvuMX6ePkwVllFE7F8IAMyIkGCWGrSC9qb1zdco0HIGs/pEsCdJ46PlEtCRvKsnt0a7sZSvFUuXSKkhJjPLHHeYzRfHSLsduU4bwaRjhmryyQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FaoI4BDn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZR7lnvb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 3 Apr 2025 19:56:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743702981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LcthvqE88d5gy2Qcxi0NqD6LJiCHYdT8lPf3khfZem8=;
	b=FaoI4BDnt2OjqHubUgAmbqWzK6+yscrpjDbWCSy64aOb82ttaeaGI3LonyNOLhrBmkOTBl
	jT0po6WHVzFi2CVdWDsElaFlYZk1VensxacuRkdtbCoYimn9ABtJjXeFlWNkIEEY91U/mT
	j0XzlYTjEJap4O5AaW8MYQjnYIgULvCTeDFRtu4bmTjF65hB0kD3US1ctlnAXeZcU52sJY
	ROE0fNR7PTEKuN3TNHP0rTubi84FWltjfHvZfDQjd43u9udIpeBKNOJsyvez1ZVWRMieHu
	fHa7WC948HCrqThjj7eO5cCiZKaxrkxabmakHR9SZ2yuTp6xHh3nYTvrzwvI9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743702981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LcthvqE88d5gy2Qcxi0NqD6LJiCHYdT8lPf3khfZem8=;
	b=qZR7lnvbngGml9Vwc3jUbQjPQINWQgay3k0x0LQYlR5B2vH6TS5gnb+gQ/iQmHMa80Zi17
	H2EcMcWEF0dCCLDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com, oleg@redhat.com,
	mhiramat@kernel.org, ast@kernel.org
Subject: Re: [PATCH tip/perf] uprobes: avoid false lockdep splat in uprobe
 timer callback
Message-ID: <20250403175619.2QB0oWe_@linutronix.de>
References: <20250403171831.3803479-1-andrii@kernel.org>
 <20250403174917.OLHfwBp-@linutronix.de>
 <20250403135331.1b8e8fc0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403135331.1b8e8fc0@gandalf.local.home>

On 2025-04-03 13:53:31 [-0400], Steven Rostedt wrote:
> On Thu, 3 Apr 2025 19:49:17 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > +	/* See free_ret_instance() for notes on seqcount use.  
> > 
> > This is not a proper multi line comment.
> 
> It's only proper in the networking code, but not the rest of the kernel.

I wasn't aware that uprobe is following networking standards here.

> -- Steve

Sebastian

