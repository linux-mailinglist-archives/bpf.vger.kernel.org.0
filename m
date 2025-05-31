Return-Path: <bpf+bounces-59400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C0AC98C1
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 03:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60044E21CC
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 01:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A401BC41;
	Sat, 31 May 2025 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivCVrGK6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE2F9CB;
	Sat, 31 May 2025 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748654295; cv=none; b=kngYkQLKxzMbTlbyjlddL9qZv7e3lGdBgQhntHS+E3OMXvMo7OckPla7hfeUHIzdEqMO03xXD37Xg2P2D0nIVJEwykiy14p4kW5Wpv6dX6RMxa6DkEK6RWsaM9lyBcITxTald8XwrGu5ts8S+KRD2mejd/rRYaanybAMfP9azZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748654295; c=relaxed/simple;
	bh=KCloIB4T1/EcOdaoUCdYvcDOeG6BrP9cZb98xI5Osr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+N+2WcnDb9Y/6u9Cy5iQ6L4SrD1SlC5bJdQ5LmjyvF/o7pWuH1oDknRjM9/L4MUh+E44Op+0nlgwRrcZ5Chw3OVbCNx3K3eX/JH1re94KPvIuh90VpMdHM0okg/PGeSu9dZ0wBRPgGdbZyu+SS4CYiHphw3xgctgobDTIalqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivCVrGK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370D1C4CEEB;
	Sat, 31 May 2025 01:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748654294;
	bh=KCloIB4T1/EcOdaoUCdYvcDOeG6BrP9cZb98xI5Osr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ivCVrGK6y3FxEiSPx2LR+tn+xwI7k8qQvJFmg0APzeLXFaeDQ7KvHLHKAj9ZxOCCq
	 fYAAwkj9ySulYuGiM0ugEjacpu8TBD9K9MHqcjMDAVpK6woguex8ijRWE7aXDuCdog
	 aF/+9734UvpR271lmGy8gYEZrzQRaC1IzvFncqy3LycmteBjJ8iEhClp9O20P9jiGY
	 a97Ubx3eBRG/5VwckcaWjApi86LBSeqpXSllrYQp9JwKB738YQUETs0z3lUXK8NGqN
	 Y8q4L2nmvU5Rju2D46fwJQtoY6gQqC/pQ+CFGOb/5liXEHCImvv+8nPOiBS6e5L3Fq
	 ahSq9wndCMlcQ==
Date: Fri, 30 May 2025 18:18:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 bpf@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] xdp: Remove unused mem_return_failed event
Message-ID: <20250530181813.1024eec5@kernel.org>
In-Reply-To: <20250530121638.35106c15@gandalf.local.home>
References: <20250529160550.1f888b15@gandalf.local.home>
	<696364e6-5eb1-4543-b9f4-60fba10623fc@kernel.org>
	<20250530121638.35106c15@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 12:16:38 -0400 Steven Rostedt wrote:
> > Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>  
> 
> Thanks. Will this go through the networking tree or should I just take it?

If you're planning to send it to Linus in this MW, still, go for it:
Acked-by: Jakub Kicinski <kuba@kernel.org>
If you mean to keep it in your -next tree for next MW I think we should
take it to avoid conflict noise. But our -next tree is closed during MW
per linux-next preferences.

IOW please take it if you wanna ship it now, otherwise please repost
after MW?

