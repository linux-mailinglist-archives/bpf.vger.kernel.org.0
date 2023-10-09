Return-Path: <bpf+bounces-11721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B97BE286
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3671C209F7
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D812D35895;
	Mon,  9 Oct 2023 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV8vwGnW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319E347DF;
	Mon,  9 Oct 2023 14:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7763C433D9;
	Mon,  9 Oct 2023 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696861223;
	bh=16U5YsvVXq5mHf2wc80nLuyb9WsMzTKLY8C5x5/BRsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XV8vwGnW65YlZ2bz5W61tx/7iEkczeYNyZKLTADVKLZOfKmF14tNjl/Nxmkl+6qMf
	 RG/L8mvRT3gY+4U0DlmjCTqaZbuKuOco3apnnPYd6T41znvviBN74Zc0Iuds37h8pZ
	 Y5/xI43Zz28WYSytkNpJ7+iEXg1oJqPkzAbR6z9Jd1RLanFzGQT0BQjUWuiwUZKhu5
	 aEE6vylKr3rb/2LyslogVUKhQQ48O90uB7min8T++dn0CJ4r9Bh15p8Jdyyvh6Ux/L
	 5RgG4tUTLDNxn/8cIdtP2DANSnxr4WtX1wOfnCkpxkQUx9Xsv+FsrMME+oJ12XL77L
	 LGRUHMowAaeBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9031EE0009B;
	Mon,  9 Oct 2023 14:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] net/xdp: fix zero-size allocation warning in
 xskq_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169686122358.13891.1040766174680237802.git-patchwork-notify@kernel.org>
Date: Mon, 09 Oct 2023 14:20:23 +0000
References: <20231007075148.1759-1-andrew.kanner@gmail.com>
In-Reply-To: <20231007075148.1759-1-andrew.kanner@gmail.com>
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: martin.lau@linux.dev, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aleksander.lobakin@intel.com, xuanzhuo@linux.alibaba.com, ast@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net,
 linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
 syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat,  7 Oct 2023 10:51:49 +0300 you wrote:
> Syzkaller reported the following issue:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 2807 at mm/vmalloc.c:3247 __vmalloc_node_range (mm/vmalloc.c:3361)
>  Modules linked in:
>  CPU: 0 PID: 2807 Comm: repro Not tainted 6.6.0-rc2+ #12
>  Hardware name: Generic DT based system
>  unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
>  show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>  dump_stack_lvl from __warn (kernel/panic.c:633 kernel/panic.c:680)
>  __warn from warn_slowpath_fmt (./include/linux/context_tracking.h:153 kernel/panic.c:700)
>  warn_slowpath_fmt from __vmalloc_node_range (mm/vmalloc.c:3361 (discriminator 3))
>  __vmalloc_node_range from vmalloc_user (mm/vmalloc.c:3478)
>  vmalloc_user from xskq_create (net/xdp/xsk_queue.c:40)
>  xskq_create from xsk_setsockopt (net/xdp/xsk.c:953 net/xdp/xsk.c:1286)
>  xsk_setsockopt from __sys_setsockopt (net/socket.c:2308)
>  __sys_setsockopt from ret_fast_syscall (arch/arm/kernel/entry-common.S:68)
> 
> [...]

Here is the summary with links:
  - [bpf,v4] net/xdp: fix zero-size allocation warning in xskq_create()
    https://git.kernel.org/bpf/bpf/c/a12bbb3cccf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



