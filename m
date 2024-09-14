Return-Path: <bpf+bounces-39911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C878C979324
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734B01F220DF
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 19:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C32A129A78;
	Sat, 14 Sep 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aA0kH9Kk"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C65476B;
	Sat, 14 Sep 2024 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726340921; cv=none; b=fOUmw+XVy6jwi3jZHs6StjukzVvbNdxGKhhSvuDqPPjhxLtg3lfCA3oYFb3y322wlxhKe3N8K/fb9yn+R1M+pipLO+vRpeCDyT4oyt/KuYVa2knLaeSFiSdTZjqNLwbjQT/fy1testXa2ynzGK6FOtXhDUUF4Tn76dIUWvYdk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726340921; c=relaxed/simple;
	bh=igLWrUMalHNuo/JvrtqATze08C1+QPyMEMgPZKPU1nQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k73/qRDwePGVRs9A6JtQI2NXhvEG85JwvYPQ5r7shM/uabAjmQ0QhbVh1oT+z1H7t3AEWrzurkq8YR0w1dlEEhrfQ4i0aA2rtudOyb9sKXYnlgS4dOC8krIa7jS6QraLRULk4K/Tu8NGfVhPTRBCo9bE6LiU9MY9N6du+NdfAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=aA0kH9Kk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/RmgvQdkupwCieq+lND0mlPnkDQ+yuLauIg41h7E0Ng=; b=aA0kH9KkgT6DO/GaWr6zNx1nhr
	VAL/WXFgBUW/zCe/1aQJm/mRDanqbfa4TwnCMR/c0YnQeQD10CQy1VWEzvKI4l/CCOON/wM0MRXqy
	nnhxjbZX7VnlNCDLXjoW44A9+4Hw2tQAwHyTlEFd0v/ULr0mw5Z9EjNB+Y1lzRnTsENBsDmmxTMyO
	cb0Rq+1Jav7Vyb9Ie9ckBbVrOvymY27DdjN+MHHEugbgHfxgzuHWEmRWtsRE5DYbscrOxitVz9Az8
	jTKk2StKFat6v/NmxnjLfAuSgrDpb1ksrtTlGBq/jPP7B0DyV9N8q2bQSwQ93He2xCtwh9wWWVRjW
	EfRPjg2Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1spY8H-000P16-CT; Sat, 14 Sep 2024 21:08:33 +0200
Received: from [85.1.206.226] (helo=linux-1.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1spY8G-0008If-0Z;
	Sat, 14 Sep 2024 21:08:32 +0200
Subject: Re: [PATCH net] netkit: Ensure current->bpf_net_context is set in
 netkit_xmit()
To: Jordan Rife <jrife@google.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org, stable@vger.kernel.org
References: <20240914184616.2916445-1-jrife@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a8ed72fe-416f-d5ed-c59f-85ec59afcc40@iogearbox.net>
Date: Sat, 14 Sep 2024 21:08:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240914184616.2916445-1-jrife@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27398/Sat Sep 14 10:42:15 2024)

Hi Jordan,

On 9/14/24 8:46 PM, Jordan Rife wrote:
> When operating Cilium in netkit mode with BPF-based host routing, calls
> to bpf_redirect() cause a kernel panic.
> 
> [   52.247646] BUG: kernel NULL pointer dereference, address: 0000000000000038
> ...
> [   52.247727] RIP: 0010:bpf_redirect+0x18/0x80
> ...
[...]
> Setting a breakpoint inside bpf_net_ctx_get_ri() confirms that
> current->bpf_net_context is NULL right before the panic.
> 
> (gdb) p $lx_current().bpf_net_context
> $4 = (struct bpf_net_context *) 0x0 <fixed_percpu_data>
> (gdb) disassemble bpf_redirect
> Dump of assembler code for function bpf_redirect:
>     0xffffffff81f085e0 <+0>:	nopl   0x0(%rax,%rax,1)
>     0xffffffff81f085e5 <+5>:	mov    %gs:0x7e12d593(%rip),%rax
>     0xffffffff81f085ed <+13>:	push   %rbp
>     0xffffffff81f085ee <+14>:	mov    0x23d0(%rax),%rax
> => 0xffffffff81f085f5 <+21>:	mov    %rsp,%rbp
>     0xffffffff81f085f8 <+24>:	mov    0x38(%rax),%edx
> ...
> (gdb) continue
> Continuing.
> 
> Thread 1 hit Breakpoint 1, panic ...
> 288	{
> (gdb)
> 
> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
> on PREEMPT_RT.") recently moved bpf_redirect_info into bpf_net_context,
> a new member of task_struct. Currently, current->bpf_net_context is set
> and then cleared inside sch_handle_egress() where tcx_run() and tc_run()
> execute, but it looks like netkit_xmit() was missed leaving
> current->bpf_net_context uninitialized when it runs. This patch ensures
> that current->bpf_net_context is initialized while running
> netkit_xmit().
> 
> Signed-off-by: Jordan Rife <jrife@google.com>
> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")

Thanks for the fix! Similar patch is however already in net tree :

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=157f29152b61ca41809dd7ead29f5733adeced19

Best,
Daniel

