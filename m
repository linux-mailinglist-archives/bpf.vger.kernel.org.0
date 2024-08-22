Return-Path: <bpf+bounces-37801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D195A937
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868741F224D8
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDDD6AAD;
	Thu, 22 Aug 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6EeEEr7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404E10A19;
	Thu, 22 Aug 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287769; cv=none; b=NQ77wS5nvME3AUy1J6ZVqrHgS5NKScNz3KS6tX51MgPxv+DhxumE+Fz6QkIvWBFrtQ4RyNeKP1n491xARlMg9YXrnbClMhaVsfd7oD6Gnsi7kwm2rwAQIcWZeaXgpxUmvHudGRLxCTnIPKuQYHdOKyw+aJfr0vphwddzU/vbw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287769; c=relaxed/simple;
	bh=mskJEZ3NYR7YIp06wSecMjlqGp7J4qylb6WtESbvLjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8YMZ9+QB+WJD30tjGt1EKzfciN/igvnRMPRGriR8RLQCV9PRRe7idddGjRpOBjj2HgNIke3GENo3hkSJUaubgm0JAalIcT6+ZoxFu8uy0nBnV3FurUOVpfzcYltXIUYFXsEgiC1f4KXbwLBIx0TDjYAl2UMwdW1UemY2XbqZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6EeEEr7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-202089e57d8so1667665ad.0;
        Wed, 21 Aug 2024 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724287768; x=1724892568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LKq3AXnBw2AtVmCSA6snTUlcx38oy1Ib0aPbJH1eQI=;
        b=G6EeEEr7baxInqcNSK0ro4/cx9yqX3QtgZ1BkKrxex/eBRfJInWbeTqSbPXNKwSaqv
         jRgqh/S3oYDRwAdLe6f6LN8pdAXY0ZfPLRSGhg4mNAkuM3ckq0SHyLzmZOqeByvMXpP5
         RMVlbZ20VbDGb1l4S8Xmay0GiUriCbSbG5Yw4f486Q/KIOKkb3TID3Tz53feifUFrqU/
         TokaEo+OmhhPuOdQjGKTER/6UEyyAWAY/J1FljxoRLbqIJXE0BOdVm+c01AAW0n1j8yi
         20bs9CKyLNoBWSu//YAyGS+zMnUZjisOQrgSRgXN0TnSRQclKCVK5iFK32bxBJDZGLCS
         6nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724287768; x=1724892568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LKq3AXnBw2AtVmCSA6snTUlcx38oy1Ib0aPbJH1eQI=;
        b=s4dELDOfvYE9Oc8qNNl3rLasEmEPj85ESntRLMeqRzRBpxh59DPWkVofOZ9Oml/GwW
         D117NUgw8D6Vtl/avPMWBR/ee77r1eDk6gEn0zaNZhBuBvirmsClU/x5aEsm7jqTrtLH
         dJ2LO+esHNhufZF3f42a4FgkU5nBYrWvPA8wWRmKSYc15R01AJ9rRJn9SWIFMSGCBuCj
         Miem1Ap/F3zprdSOUtEeCNlZHEorimUi96wwavnjrUiKCwiVgVcg15oDh/Sc0omqwm0O
         bimVRUjOe7WI5ULHcbg3FNIG+hpjUdn5E+oTcMhazOM5OJVOrwbdwOFXxe6iiViR4MNI
         w31w==
X-Forwarded-Encrypted: i=1; AJvYcCW0YGEKoFhdNq9T86jIUnyyrbowB6n+I0IJBgPZ9D8jroOSwzVwcvngTWKTFK0/ajlUf80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+agzGUPG/6+KXXNg6roLbw4xj+nmOHtE5p5wzu8wHj7vJGqJ
	UfhzBYBiRflZrLEUdDaIn4JnqmOPod1lsE7VKlZU9Yp5vumWs1w9
X-Google-Smtp-Source: AGHT+IE6KNJ3DVcEnwcJBAiXp06i6mKcVrluzRfZcJwHqhpBOC3620vieULHCBLtE5GmeR4IOfkqwA==
X-Received: by 2002:a17:902:ce03:b0:202:3617:d52a with SMTP id d9443c01a7336-2037ef22d89mr23671595ad.6.1724287767558;
        Wed, 21 Aug 2024 17:49:27 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:7789:9ed:101e:8908])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566590sm1867065ad.26.2024.08.21.17.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:49:26 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:49:25 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [Patch bpf] tcp_bpf: fix return value of tcp_bpf_sendmsg()
Message-ID: <ZsaLFVB0HyQfXBXy@pop-os.localdomain>
References: <20240821030744.320934-1-xiyou.wangcong@gmail.com>
 <20240821145533.GA2164@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821145533.GA2164@kernel.org>

On Wed, Aug 21, 2024 at 03:55:33PM +0100, Simon Horman wrote:
> On Tue, Aug 20, 2024 at 08:07:44PM -0700, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > When we cork messages in psock->cork, the last message triggers the
> > flushing will result in sending a sk_msg larger than the current
> > message size. In this case, in tcp_bpf_send_verdict(), 'copied' becomes
> > negative at least in the following case:
> > 
> > 468         case __SK_DROP:
> > 469         default:
> > 470                 sk_msg_free_partial(sk, msg, tosend);
> > 471                 sk_msg_apply_bytes(psock, tosend);
> > 472                 *copied -= (tosend + delta); // <==== HERE
> > 473                 return -EACCES;
> > 
> > Therefore, it could lead to the following BUG with a proper value of
> > 'copied' (thanks to syzbot). We should not use negative 'copied' as a
> > return value here.
> > 
> >   ------------[ cut here ]------------
> >   kernel BUG at net/socket.c:733!
> >   Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> >   Modules linked in:
> >   CPU: 0 UID: 0 PID: 3265 Comm: syz-executor510 Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3 #0
> >   Hardware name: linux,dummy-virt (DT)
> >   pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> >   pc : sock_sendmsg_nosec net/socket.c:733 [inline]
> >   pc : sock_sendmsg_nosec net/socket.c:728 [inline]
> >   pc : __sock_sendmsg+0x5c/0x60 net/socket.c:745
> >   lr : sock_sendmsg_nosec net/socket.c:730 [inline]
> >   lr : __sock_sendmsg+0x54/0x60 net/socket.c:745
> >   sp : ffff800088ea3b30
> >   x29: ffff800088ea3b30 x28: fbf00000062bc900 x27: 0000000000000000
> >   x26: ffff800088ea3bc0 x25: ffff800088ea3bc0 x24: 0000000000000000
> >   x23: f9f00000048dc000 x22: 0000000000000000 x21: ffff800088ea3d90
> >   x20: f9f00000048dc000 x19: ffff800088ea3d90 x18: 0000000000000001
> >   x17: 0000000000000000 x16: 0000000000000000 x15: 000000002002ffaf
> >   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> >   x11: 0000000000000000 x10: ffff8000815849c0 x9 : ffff8000815b49c0
> >   x8 : 0000000000000000 x7 : 000000000000003f x6 : 0000000000000000
> >   x5 : 00000000000007e0 x4 : fff07ffffd239000 x3 : fbf00000062bc900
> >   x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffdef
> >   Call trace:
> >    sock_sendmsg_nosec net/socket.c:733 [inline]
> >    __sock_sendmsg+0x5c/0x60 net/socket.c:745
> >    ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
> >    ___sys_sendmsg+0xac/0x100 net/socket.c:2651
> >    __sys_sendmsg+0x84/0xe0 net/socket.c:2680
> >    __do_sys_sendmsg net/socket.c:2689 [inline]
> >    __se_sys_sendmsg net/socket.c:2687 [inline]
> >    __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
> >    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
> >    invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
> >    el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
> >    do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
> >    el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
> >    el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
> >    el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> >   Code: f9404463 d63f0060 3108441f 54fffe81 (d4210000)
> >   ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> > Reported-by: syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > ---
> >  net/ipv4/tcp_bpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index 53b0d62fd2c2..fe6178715ba0 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -577,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> >  		err = sk_stream_error(sk, msg->msg_flags, err);
> >  	release_sock(sk);
> >  	sk_psock_put(sk, psock);
> > -	return copied ? copied : err;
> > +	return copied > 0 ? copied : err;
> 
> Does it make more sense to make the condition err:
> is err 0 iif everything is ok? (completely untested!)

Mind to elaborate?

From my point of view, 'copied' is to handle partial transmission, for
example:

0. User wants to send 2 * 1K bytes with sendmsg()
1. Kernel already sent the first 1K successfully
2. Kernel got some error when sending the 2nd 1K

In this scenario, we should return 1K instead of the error to the caller to
indicate this partial transmission situation, otherwise we could not
distinguish it with a compete failure (that is, 0 byte sent).

Do I miss anything?

Thanks.

