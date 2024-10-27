Return-Path: <bpf+bounces-43258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D8A9B1E08
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 15:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E874EB20FD5
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACFE1632F1;
	Sun, 27 Oct 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbgWxow1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938A1428E0;
	Sun, 27 Oct 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730038220; cv=none; b=GG26UKBPCLms/rG+2pML1aHDo8/GycInj5W25fDBYhKOldIOWPZK7D4u17MylBXQ421Z+E4J6k7GnWVaqne3jPmZmM95pcRivxE7zRNQQ+P0WUSobl84lUFcLfcAp2lLWHqBZDpInP4ObCNDWDhGqSQDrcF3HPRNyoBsmRc3G4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730038220; c=relaxed/simple;
	bh=wbqIozrq2BqN3Qh0GIEmkRGN7pQWpNjoIAQs3t3WMs8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WwOBa57huJF0cndbgdANwuqPVY9+bdbOWRHFMPplcNFqBE4b1W0pvlkPuYIRgNsrXQgbbwFMWOS7I2MmtKTyywPWRA9VPl8uahqWp6/IR1TT/TFeilYThqTSG0zLTYiXknlRFiKIyP13BOsY1VBmzLq2UXbUiy2SPKdvgv4gQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbgWxow1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903E8C4CEC3;
	Sun, 27 Oct 2024 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730038218;
	bh=wbqIozrq2BqN3Qh0GIEmkRGN7pQWpNjoIAQs3t3WMs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pbgWxow1mk7tTiQt7wW1mgbMVb/6Q9YobN7L8wy2AkjpON3qb9UcNI8lSGZ2LpfbH
	 uBoY+tJ4ICiE3lkjEb2caiKhzxYULDoQwOFtAqiynHvLk1ZoT7/P4zFsD5YcF0xWhm
	 BSLidl+RKjHUvRj0YtHDdgJehfFmOfAPmvgEJS+Bgnabt6OVFPBNClRF4nuiioN+67
	 Q3ATTB3dTm/nNJW6RRWKhrBNL84gLBOrOXjrpXxp+ds5TkPItLaLFKBXj7ZYSt3oql
	 YEX3Z4uh6qY9Tk26WVXq5HzaeFe1VglXdlsOJDQehND4j433sfrxhaCzM/1h36f9vB
	 BY2MrxdjD7Oyg==
Date: Sun, 27 Oct 2024 23:10:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Liao Chang <liaochang1@huawei.com>,
 catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
 oleg@redhat.com, peterz@infradead.org, ast@kernel.org, puranjay@kernel.org,
 andrii@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into
 user stack
Message-Id: <20241027231013.434c071d7554e3f2aac7cef3@kernel.org>
In-Reply-To: <CAEf4Bzb9fM+hx8quHpCCeRh2p7UVk9Kk6yGj3XvyJLTQu9C-2w@mail.gmail.com>
References: <20240910060407.1427716-1-liaochang1@huawei.com>
	<ZxpUX1rbppLqS0bD@J2N7QTR9R3.cambridge.arm.com>
	<CAEf4Bzb9fM+hx8quHpCCeRh2p7UVk9Kk6yGj3XvyJLTQu9C-2w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 13:51:14 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> All good ideas for sure, we should do them, IMO. But we'll still be
> paying an extra kernel->user->kernel switch, which almost certainly is
> slower than doing a simple stack push emulation just like we do in
> x86-64 case, no?
> 
> 
> BTW, I did a quick local profiling run. I don't think XOL management
> is the main source of overhead. I see 5% of CPU cycles spent in
> arch_uprobe_copy_ixol, but other than that XOL doesn't figure in stack
> traces. There are at least 22% CPU cycles spent in some
> local_daif_restore function, though, not sure what that is, but might
> be related to interrupt handling, right?
> 
> 
> The take away I'd like to communicate here is avoiding the
> single-stepping need is *the best way* to go, IMO. So if we can
> emulate those STP instructions for uprobe *cheaply*, that would be
> awesome.

+1.
Unlike the kprobe, uprobe singlestep needs to go userspace (for
sacurity), which can introduce much bigger overhead. If we can just
emulate the instruction safely in the kernel, it should be done.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

