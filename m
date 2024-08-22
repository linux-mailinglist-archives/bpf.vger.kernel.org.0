Return-Path: <bpf+bounces-37896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621C95BFE8
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7241C20AFE
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCEC1D1F40;
	Thu, 22 Aug 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuJY+LBR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E713AA2E;
	Thu, 22 Aug 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359556; cv=none; b=WuvMT/GURQuusj5k/Tnk6ajdmZmZAhDqbwxxGi71TDGKieo1KRuWE219xiTIO/zN+5r6rfjyYS9dQ4JXgxGNcwEwMWzW3UVP3fSpahytzxj6wW6PbrTQfDq4GuLpTnNAhFB2RGn/jrJ36Imay6cNF0ryGEbf43zNvo3gcP2MMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359556; c=relaxed/simple;
	bh=4X4eXD1J6KuR99w3hqgsl01Ywx/0FiL8cRJGyD1iOto=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=paMp6UAFeTwFc/ZFJ+urtNN6Nk9Opq3QL0HcuQcgLyJICyCLb5J4kL7HedkpeQyuPT9s6BfAtLOqhiF9hYpyC1vYd2vqi/qNG3typrN5/uDiFM3ivsmVElL5DH1HjMKxb/mTwls1LUxfYp2ScplhK9azC2w/L8xTlQCHTxqVsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuJY+LBR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-709428a9469so1071199a34.3;
        Thu, 22 Aug 2024 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724359553; x=1724964353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KalSChFzh47JfE4JuYlfPUsBnlMCnoElRFYPYzng2A=;
        b=IuJY+LBRhjPfy7zc0njrclPx2pWlHZBqANV8mDLDw8RAt7LWQJQYTvzISUh2i+zJ/u
         BZEyre7q1FM6V7xcng7hFOG7Dzlp1BaZVXjE/qljOCfRGeE07mmCqH+mz+8mS8+QXVhP
         z7TkKXZAJocdAZZuPBlrgdlj5r0+Qe3rhxlFmhrxDvj51MB9vKmhd36QQuOU271z4CwA
         NPSxbIzNwtdy8OsA0BeaQ174IywBRPsmXdIUeOlK7L9txQeTf4evo0H8QJtD5uMSZ/a8
         YMEB1eKMs9D65qwNtTPM30Fxac/SUY6y1PybiE1X+bJb9SncPyeeDKqMZkwIC+0pJ96L
         KFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724359553; x=1724964353;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3KalSChFzh47JfE4JuYlfPUsBnlMCnoElRFYPYzng2A=;
        b=Er2rS6n/2i0SL8BJlw+VfX1qCBAQAs8bkZ8vgu7o2UaAxbia6sStitqN9ZFXWEZ+lb
         /Mu7tayQ+S0lmyO1xUKBM09hEX1SMrgihu7VEIzvj0J4e+mIoCXXwra7fXxD8SDj5viy
         wN3G+EqY55ShCgvj3jFgVvmkEd/C2UovubI2+dZICAV6+JLTTNsEMjC81hvXoMZidrYw
         5mTjTk+/MaPDtc6zAbnpxBWFxLxOpscWZ3t5pqMc6fAAsNyNwZV1s71unz/+A/mq1G7C
         VzQTrFn+0tfi1F8dH3b4vpEmy3S7mlNewBcz8yY7yUKLuGQdjUPZoQ1VQx8oLhCJyrhw
         42cg==
X-Forwarded-Encrypted: i=1; AJvYcCWdE/XQOfMXM9/OhGZuaxqM6Vcu3Mlzh4FB7Vk5mDZNtQYLaAb8XhdK5V15HvrVH4AFvuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx063rVbIk3jsRApmyYTUJr5wh60zX3aDDYsmbLBD/Y3SEGhDiG
	oX7YHnjvpNR5IotG5xXnmFeWswWuUmm3iNFu10g8uW5+CW5gLfMd
X-Google-Smtp-Source: AGHT+IEWUVdkYJ0EQvahLyXPTA9UN2T2iNqB7mW6aA1xfXsnhpC7Ic/1nteElNRMMtuaS5SSe96EYg==
X-Received: by 2002:a05:6808:1990:b0:3d9:b33e:d3ef with SMTP id 5614622812f47-3de2a87135emr82165b6e.3.1724359553318;
        Thu, 22 Aug 2024 13:45:53 -0700 (PDT)
Received: from localhost ([98.97.38.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad55fe9sm1760015a12.60.2024.08.22.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:45:52 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:45:51 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Cong Wang <cong.wang@bytedance.com>, 
 syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <66c7a37fd0270_1b1420837@john.notmuch>
In-Reply-To: <ZsaLFVB0HyQfXBXy@pop-os.localdomain>
References: <20240821030744.320934-1-xiyou.wangcong@gmail.com>
 <20240821145533.GA2164@kernel.org>
 <ZsaLFVB0HyQfXBXy@pop-os.localdomain>
Subject: Re: [Patch bpf] tcp_bpf: fix return value of tcp_bpf_sendmsg()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Cong Wang wrote:
> On Wed, Aug 21, 2024 at 03:55:33PM +0100, Simon Horman wrote:
> > On Tue, Aug 20, 2024 at 08:07:44PM -0700, Cong Wang wrote:
> > > From: Cong Wang <cong.wang@bytedance.com>
> > > 
> > > When we cork messages in psock->cork, the last message triggers the
> > > flushing will result in sending a sk_msg larger than the current
> > > message size. In this case, in tcp_bpf_send_verdict(), 'copied' becomes
> > > negative at least in the following case:
> > > 
> > > 468         case __SK_DROP:
> > > 469         default:
> > > 470                 sk_msg_free_partial(sk, msg, tosend);
> > > 471                 sk_msg_apply_bytes(psock, tosend);
> > > 472                 *copied -= (tosend + delta); // <==== HERE
> > > 473                 return -EACCES;
> > > 
> > > Therefore, it could lead to the following BUG with a proper value of
> > > 'copied' (thanks to syzbot). We should not use negative 'copied' as a
> > > return value here.
> > > 
> > >   ------------[ cut here ]------------
> > >   kernel BUG at net/socket.c:733!
> > >   Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > >   Modules linked in:
> > >   CPU: 0 UID: 0 PID: 3265 Comm: syz-executor510 Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3 #0
> > >   Hardware name: linux,dummy-virt (DT)
> > >   pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > >   pc : sock_sendmsg_nosec net/socket.c:733 [inline]
> > >   pc : sock_sendmsg_nosec net/socket.c:728 [inline]
> > >   pc : __sock_sendmsg+0x5c/0x60 net/socket.c:745
> > >   lr : sock_sendmsg_nosec net/socket.c:730 [inline]
> > >   lr : __sock_sendmsg+0x54/0x60 net/socket.c:745
> > >   sp : ffff800088ea3b30
> > >   x29: ffff800088ea3b30 x28: fbf00000062bc900 x27: 0000000000000000
> > >   x26: ffff800088ea3bc0 x25: ffff800088ea3bc0 x24: 0000000000000000
> > >   x23: f9f00000048dc000 x22: 0000000000000000 x21: ffff800088ea3d90
> > >   x20: f9f00000048dc000 x19: ffff800088ea3d90 x18: 0000000000000001
> > >   x17: 0000000000000000 x16: 0000000000000000 x15: 000000002002ffaf
> > >   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > >   x11: 0000000000000000 x10: ffff8000815849c0 x9 : ffff8000815b49c0
> > >   x8 : 0000000000000000 x7 : 000000000000003f x6 : 0000000000000000
> > >   x5 : 00000000000007e0 x4 : fff07ffffd239000 x3 : fbf00000062bc900
> > >   x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffdef
> > >   Call trace:
> > >    sock_sendmsg_nosec net/socket.c:733 [inline]
> > >    __sock_sendmsg+0x5c/0x60 net/socket.c:745
> > >    ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
> > >    ___sys_sendmsg+0xac/0x100 net/socket.c:2651
> > >    __sys_sendmsg+0x84/0xe0 net/socket.c:2680
> > >    __do_sys_sendmsg net/socket.c:2689 [inline]
> > >    __se_sys_sendmsg net/socket.c:2687 [inline]
> > >    __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
> > >    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
> > >    invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
> > >    el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
> > >    do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
> > >    el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
> > >    el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
> > >    el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> > >   Code: f9404463 d63f0060 3108441f 54fffe81 (d4210000)
> > >   ---[ end trace 0000000000000000 ]---
> > > 
> > > Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> > > Reported-by: syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: Jakub Sitnicki <jakub@cloudflare.com>
> > > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > > ---
> > >  net/ipv4/tcp_bpf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > > index 53b0d62fd2c2..fe6178715ba0 100644
> > > --- a/net/ipv4/tcp_bpf.c
> > > +++ b/net/ipv4/tcp_bpf.c
> > > @@ -577,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> > >  		err = sk_stream_error(sk, msg->msg_flags, err);
> > >  	release_sock(sk);
> > >  	sk_psock_put(sk, psock);
> > > -	return copied ? copied : err;
> > > +	return copied > 0 ? copied : err;
> > 
> > Does it make more sense to make the condition err:
> > is err 0 iif everything is ok? (completely untested!)
> 
> Mind to elaborate?
> 
> From my point of view, 'copied' is to handle partial transmission, for
> example:
> 
> 0. User wants to send 2 * 1K bytes with sendmsg()
> 1. Kernel already sent the first 1K successfully
> 2. Kernel got some error when sending the 2nd 1K
> 
> In this scenario, we should return 1K instead of the error to the caller to
> indicate this partial transmission situation, otherwise we could not
> distinguish it with a compete failure (that is, 0 byte sent).

Yep, if we don't return the positive value on partial send we will confuse
apps and they will probably resent data.

From my side this looks good.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

> 
> Do I miss anything?
> 
> Thanks.



