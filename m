Return-Path: <bpf+bounces-55255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783EBA7A8E8
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42189168C0A
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CDA2528E9;
	Thu,  3 Apr 2025 17:52:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44424CEE8;
	Thu,  3 Apr 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702747; cv=none; b=du3v3u32F5mjoeBlG10+/pz3w6797xKcOlFa0poAU5IJLPOBYrWSmQ/mJxKyVw+2CpPcLiM4HphKUexXF5BnHHHgtynFFGvQG5/QApHO/VU1/tzREJ/SKi/TfzMFEN98yOn4ZUxjVtmlz75bzxQh0+EI8f82B4jGRmgGQTcqtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702747; c=relaxed/simple;
	bh=lX2sDl/bFxUKj8k9SLE4kTNfkyRlRSDVIfDAZaT6YJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G86tYNHkcK/MDH9vTTwUCJzj8EmBR6TWaSCe0KIDfCb3NTne9JmJtXLBr9ZhHGCoAukFkFCIwuVpxGJ4qvjwloP3cP8SD+liUs1Mu2MIHlLQfyaOvXQx3GGgpY7YeHdCyEeZpt8FPuLdOB1xrZFeylMuytmR/143JqqmB41T++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2420C4CEE3;
	Thu,  3 Apr 2025 17:52:25 +0000 (UTC)
Date: Thu, 3 Apr 2025 13:53:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, oleg@redhat.com,
 mhiramat@kernel.org, ast@kernel.org
Subject: Re: [PATCH tip/perf] uprobes: avoid false lockdep splat in uprobe
 timer callback
Message-ID: <20250403135331.1b8e8fc0@gandalf.local.home>
In-Reply-To: <20250403174917.OLHfwBp-@linutronix.de>
References: <20250403171831.3803479-1-andrii@kernel.org>
	<20250403174917.OLHfwBp-@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 19:49:17 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > +	/* See free_ret_instance() for notes on seqcount use.  
> 
> This is not a proper multi line comment.

It's only proper in the networking code, but not the rest of the kernel.

-- Steve

