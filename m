Return-Path: <bpf+bounces-56390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B4A96BF6
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3233B41D3
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AD281352;
	Tue, 22 Apr 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PIC9fETO"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF432AD2F;
	Tue, 22 Apr 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327078; cv=none; b=JSqiSlbJk6pZ+gpiQqBB5UvRSIhi5zI4tKHm29mvQfjPnkhzQhMdDOdKm6iHnsnIEZHwHjkFM6YsOCRz0EFaY5J3lN3excK3xwIP21e3aoO7H9Rel5+Q5zDjAcBoPPzdw/a0YdFaARI+eY45a4VEABjcMCkvF4LBRPewj+1vDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327078; c=relaxed/simple;
	bh=vR1+n0qHKzUusRbN9MvRO32EAe1y0m5YRoTz2ag6oBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmOBPSKzfaVtYlaA3Gvf94dZyOOu6E1RyMF5zz7ZSzigsrBg95PYyr9G9h2s4oYP9qmHljlsGhP8kbuRPTwm5n253caMJkP34xK3JK/nBFw3q5dr6R7frd0Ej8LTv5pD4z/uOXNrvhc72fCPigeJyfnwuNaVo8v74xRYHr0Bylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PIC9fETO; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=28yq7Fdvn3I/oAFD8m2t4buzuiParf0VBMFOuBiHTKQ=;
	b=PIC9fETObgp/7bQprdTgawAioYtSrwz631c9KjkhB1Xbz2pQYjbLPC+6pncdDf
	0Bpe0KA6OTbjpqy27wGCz0SzsZw9FTPyTMsqv+YxZWJybXIaUQTWdoNz44hE0neF
	2AFjHowkvmxLxn0Qa1YDhqS3p+UHVDvZDtaPPSgL8m8to=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnZSunkwdoESG1Bg--.15092S2;
	Tue, 22 Apr 2025 21:03:37 +0800 (CST)
Date: Tue, 22 Apr 2025 21:03:35 +0800
From: Jiayuan Chen <mrpre@163.com>
To: syzbot <syzbot+c21c23281290bfafe8d5@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [bpf?] KASAN: slab-use-after-free Read in
 sk_psock_verdict_data_ready (3)
Message-ID: <iehdn772fdww4zj3cknkijb5zyfj44qvpec33zyc6h4jm6qyeh@ivak4n6ekjr4>
References: <68076b8b.050a0220.380c13.0088.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68076b8b.050a0220.380c13.0088.GAE@google.com>
X-CM-TRANSID:_____wDnZSunkwdoESG1Bg--.15092S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1DCrWDXFW5KFyDArWfuFg_yoW8uFW5pr
	WDAryxCrn0yryFvFy8Kr1UJw10qrs8K3yUX3y0qr17uanrAF10kws2yr45GFZ0kr47CasI
	qr15ua4Yq3s5Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnXoxUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWx03p2gHjWTgOgAAsK

On Tue, Apr 22, 2025 at 03:12:27AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8582d9ab3efd libbpf: Verify section type in btf_find_elf_s..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13baba3f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b209dc5439043d2
> dashboard link: https://syzkaller.appspot.com/bug?extid=c21c23281290bfafe8d5
> compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ee77ac023e33/disk-8582d9ab.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ebe52a30453e/vmlinux-8582d9ab.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6868f9db2e2e/bzImage-8582d9ab.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c21c23281290bfafe8d5@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in sk_psock_verdict_data_ready+0x6d/0x390 net/core/skmsg.c:1239
> Read of size 8 at addr ffff888078595a20 by task syz.2.24/6005
> 
Same as the obsoleted one:
https://syzkaller.appspot.com/bug?extid=dd90a702f518e0eac072

I'd like to create the discussion here, so that others can find it and
contribute to the topic.

Sorry to forget replying this patch:
https://lore.kernel.org/all/20250408073033.60377-1-jiayuan.chen@linux.dev/T/

That patch obtains the ops from sk->sk_socket with RCU locked, preventing
sk_socket from being freed by RCU. Since 'ops' is a const type data that's
never freed, I can still use it even after sk_socket is freed.
It's a trick way but lightweight.

I also had a discussion with Michal Luczaj about fixing this issue using
file references:
https://lore.kernel.org/all/20250317092257.68760-1-jiayuan.chen@linux.dev/T/

Welcome any better suggestions.


