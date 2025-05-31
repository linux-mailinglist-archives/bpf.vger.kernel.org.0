Return-Path: <bpf+bounces-59415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C93AC9CA8
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 22:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C73417D49E
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DED1A5B99;
	Sat, 31 May 2025 20:14:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBC139D;
	Sat, 31 May 2025 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748722484; cv=none; b=EvpXMCPDrhUe1PIwNOBzB1wcRPmjxzvpiropWZiLr4HjVrm+UmV1o+L6DJVL8OK9IfA85PWAVADBsEkgMU31vH7oXbQ74rQF4Dan1NVGTWoZDlNZcRIH/sYekE9sRz+1xAWjkrsKmM6J3Mf6bCRWcQ+iMxtw8wrMna+sGs4eHok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748722484; c=relaxed/simple;
	bh=EWn7oCviz4cJo10FkBXaHDfYtLYegc5N4X7rrxnu7lU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF7cBtD8Ogx2AjGZrgS5tF9nase0Tm+GaoXxdA6rDUMx5ZKpXJyTy2XOAmkq61vRp3QoSxYquy/3qOCvkk54Kn9AzCDpvCJfTAQWtEQo9tEn015/e3F4E/LIbyYA/FW9HXpnTkIQJAL6r0clu9gcG6GOiLhl8kXwQCO945Gv9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEA6C4CEE3;
	Sat, 31 May 2025 20:14:42 +0000 (UTC)
Date: Sat, 31 May 2025 16:15:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 bpf@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] xdp: Remove unused mem_return_failed event
Message-ID: <20250531161549.6e1c69c7@gandalf.local.home>
In-Reply-To: <20250530181813.1024eec5@kernel.org>
References: <20250529160550.1f888b15@gandalf.local.home>
	<696364e6-5eb1-4543-b9f4-60fba10623fc@kernel.org>
	<20250530121638.35106c15@gandalf.local.home>
	<20250530181813.1024eec5@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 18:18:13 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 30 May 2025 12:16:38 -0400 Steven Rostedt wrote:
> > > Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>    
> > 
> > Thanks. Will this go through the networking tree or should I just take it?  
> 
> If you're planning to send it to Linus in this MW, still, go for it:
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> If you mean to keep it in your -next tree for next MW I think we should
> take it to avoid conflict noise. But our -next tree is closed during MW
> per linux-next preferences.
> 
> IOW please take it if you wanna ship it now, otherwise please repost
> after MW?

Yeah, I think I'll try to get it in now. I'll ping the maintainers of my
other patches to see if I can get them all in in one go.

Thanks,

-- Steve

