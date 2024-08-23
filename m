Return-Path: <bpf+bounces-37926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1745F95C804
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B95281F15
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91727143C6C;
	Fri, 23 Aug 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOC7GR17"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F5143736;
	Fri, 23 Aug 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401527; cv=none; b=Wmm5Mb3VtlcMqVsi1dginN3fjZNvG5JLetLUVfneFU4bGMM5BP4m5UNNhbYEVe2asGXKXYcqcI09qARWJZqFPHAvbwdR0x+x0TOM50h8kGiQ3rGZ01W5Yi4GCNLnvQQ1+TAUYXmq6pTJWwIYwaeJikEbB6rT2VTZDuCL9qFOkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401527; c=relaxed/simple;
	bh=BHLpzt7Dtjn8m5qYRc3cu8T6nysZSnMVb3D3BT0zxgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpZ54ryr12KGNzG1U382XQ7fSwvkJYmpingpWox8bQkb4xeyDiMWzU2uuqXp7M8sHZewjy2IMPgVSLvASCP/+GA8xd0WtAEdEPvOGkk3k/Z7GL+kM3E0uAFLRvb9jxAGGlN1MuQaihyg3ZG5mhotoY2ib99t58AzHiOlqW1gcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOC7GR17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C6EC32786;
	Fri, 23 Aug 2024 08:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724401526;
	bh=BHLpzt7Dtjn8m5qYRc3cu8T6nysZSnMVb3D3BT0zxgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOC7GR17b6q0+eIL7+qodYXvZFuHW7zLU7DE9si/AJdiIY3EskirzXlR3wTxAUNCn
	 jqfQ37LgoKdlHLFr3QLMyM5Z/1k/ZlGHeF/hm+1+p0AP5KBPJ7bEE+gLUc3DKK3hrJ
	 HgbkOswszxanj4Vepy6HGt/V0xSQSm76KY8FdY8CZvvV2jsZfQF8cdpMYEq0FsOtXY
	 81LmQjhy2A72QJXDlk9aC7bOxmqcTgEvJ+emOB5kIMWZm4oZwUn85OBoxdrdBduXCY
	 q0Z+S9ClP3LCDq7nKNa8JOba6bNVNG/OpyIHM7RWcVEga9RAVH2huZ7Sw7n+TxmPlQ
	 lhgISgzdXrl9g==
Date: Fri, 23 Aug 2024 09:25:22 +0100
From: Simon Horman <horms@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [Patch bpf] tcp_bpf: fix return value of tcp_bpf_sendmsg()
Message-ID: <20240823082522.GS2164@kernel.org>
References: <20240821030744.320934-1-xiyou.wangcong@gmail.com>
 <20240821145533.GA2164@kernel.org>
 <ZsaLFVB0HyQfXBXy@pop-os.localdomain>
 <66c7a37fd0270_1b1420837@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c7a37fd0270_1b1420837@john.notmuch>

On Thu, Aug 22, 2024 at 01:45:51PM -0700, John Fastabend wrote:
> Cong Wang wrote:
> > On Wed, Aug 21, 2024 at 03:55:33PM +0100, Simon Horman wrote:
> > > On Tue, Aug 20, 2024 at 08:07:44PM -0700, Cong Wang wrote:
> > > > From: Cong Wang <cong.wang@bytedance.com>
> > > > 
> > > > When we cork messages in psock->cork, the last message triggers the
> > > > flushing will result in sending a sk_msg larger than the current
> > > > message size. In this case, in tcp_bpf_send_verdict(), 'copied' becomes
> > > > negative at least in the following case:
> > > > 
> > > > 468         case __SK_DROP:
> > > > 469         default:
> > > > 470                 sk_msg_free_partial(sk, msg, tosend);
> > > > 471                 sk_msg_apply_bytes(psock, tosend);
> > > > 472                 *copied -= (tosend + delta); // <==== HERE
> > > > 473                 return -EACCES;
> > > > 
> > > > Therefore, it could lead to the following BUG with a proper value of
> > > > 'copied' (thanks to syzbot). We should not use negative 'copied' as a
> > > > return value here.
> > > > 
> > > >   ------------[ cut here ]------------
> > > >   kernel BUG at net/socket.c:733!
> > > >   Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > > >   Modules linked in:
> > > >   CPU: 0 UID: 0 PID: 3265 Comm: syz-executor510 Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3 #0
> > > >   Hardware name: linux,dummy-virt (DT)
> > > >   pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > > >   pc : sock_sendmsg_nosec net/socket.c:733 [inline]
> > > >   pc : sock_sendmsg_nosec net/socket.c:728 [inline]
> > > >   pc : __sock_sendmsg+0x5c/0x60 net/socket.c:745
> > > >   lr : sock_sendmsg_nosec net/socket.c:730 [inline]
> > > >   lr : __sock_sendmsg+0x54/0x60 net/socket.c:745
> > > >   sp : ffff800088ea3b30
> > > >   x29: ffff800088ea3b30 x28: fbf00000062bc900 x27: 0000000000000000
> > > >   x26: ffff800088ea3bc0 x25: ffff800088ea3bc0 x24: 0000000000000000
> > > >   x23: f9f00000048dc000 x22: 0000000000000000 x21: ffff800088ea3d90
> > > >   x20: f9f00000048dc000 x19: ffff800088ea3d90 x18: 0000000000000001
> > > >   x17: 0000000000000000 x16: 0000000000000000 x15: 000000002002ffaf
> > > >   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > > >   x11: 0000000000000000 x10: ffff8000815849c0 x9 : ffff8000815b49c0
> > > >   x8 : 0000000000000000 x7 : 000000000000003f x6 : 0000000000000000
> > > >   x5 : 00000000000007e0 x4 : fff07ffffd239000 x3 : fbf00000062bc900
> > > >   x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffdef
> > > >   Call trace:
> > > >    sock_sendmsg_nosec net/socket.c:733 [inline]
> > > >    __sock_sendmsg+0x5c/0x60 net/socket.c:745
> > > >    ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
> > > >    ___sys_sendmsg+0xac/0x100 net/socket.c:2651
> > > >    __sys_sendmsg+0x84/0xe0 net/socket.c:2680
> > > >    __do_sys_sendmsg net/socket.c:2689 [inline]
> > > >    __se_sys_sendmsg net/socket.c:2687 [inline]
> > > >    __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
> > > >    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
> > > >    invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
> > > >    el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
> > > >    do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
> > > >    el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
> > > >    el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
> > > >    el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> > > >   Code: f9404463 d63f0060 3108441f 54fffe81 (d4210000)
> > > >   ---[ end trace 0000000000000000 ]---
> > > > 
> > > > Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> > > > Reported-by: syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com
> > > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > > Cc: Jakub Sitnicki <jakub@cloudflare.com>
> > > > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > > > ---
> > > >  net/ipv4/tcp_bpf.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > > > index 53b0d62fd2c2..fe6178715ba0 100644
> > > > --- a/net/ipv4/tcp_bpf.c
> > > > +++ b/net/ipv4/tcp_bpf.c
> > > > @@ -577,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> > > >  		err = sk_stream_error(sk, msg->msg_flags, err);
> > > >  	release_sock(sk);
> > > >  	sk_psock_put(sk, psock);
> > > > -	return copied ? copied : err;
> > > > +	return copied > 0 ? copied : err;
> > > 
> > > Does it make more sense to make the condition err:
> > > is err 0 iif everything is ok? (completely untested!)
> > 
> > Mind to elaborate?

I was thinking that a valid test for for being in an error state is that
err is non-zero. Although given the below, it seems that I was mistaken.

> > 
> > From my point of view, 'copied' is to handle partial transmission, for
> > example:
> > 
> > 0. User wants to send 2 * 1K bytes with sendmsg()
> > 1. Kernel already sent the first 1K successfully
> > 2. Kernel got some error when sending the 2nd 1K
> > 
> > In this scenario, we should return 1K instead of the error to the caller to
> > indicate this partial transmission situation, otherwise we could not
> > distinguish it with a compete failure (that is, 0 byte sent).
> 
> Yep, if we don't return the positive value on partial send we will confuse
> apps and they will probably resent data.
> 
> >From my side this looks good.
> 
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>

Thanks for responding to my query.
FWIIW, I am now happy with this patch.

