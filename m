Return-Path: <bpf+bounces-30785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB698D25A7
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29601C2311E
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 20:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59C178363;
	Tue, 28 May 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj5vThgV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559138DE0;
	Tue, 28 May 2024 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927625; cv=none; b=kumXx2gZqieFR9oK/R+y+LKqxjTcy8sPBHbDNOJZUwrJ9Ad6vsGse5/5BfTXfcMMUMbvG3QULCYxrUVi2fA0ow3qqRbG/WxhEqTwRis9AIi/Lh2dUgfsTbRFHp/aEgjxC8uVMXvgWa57Wd6pTTJauK2M+ynwUIwGVDM8m6ZpxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927625; c=relaxed/simple;
	bh=9nxkQndVkEqFqgKDqGv6JljTe2j+JwreE7eODbC9Neo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XzJuZG6+dY6aE8aZf4R0nupylozsLXYGKBZQCxyT1/AtNlkCH6RaJvd4TrKVCRoQ3vXBBQa7DkBZH05lsAciO6PNoy3kvWBXW9dmsw3if2jhHIMaM96LpnjfihJ3jQKlla9PqH+53XhPVm99J7D6v2cznfxV9Z3vxYAF0iuaOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj5vThgV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a5344ec7so1546535ad.1;
        Tue, 28 May 2024 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716927623; x=1717532423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB1n4uA6XWEYiTk9cyE4enxqgqP/0efJliwy3+pDOe0=;
        b=dj5vThgV5pyJXUKzrfQmNmuRQGfRQM4M1QBSx57200VxyOhe31l3Kz5jwmtJa3kkdQ
         AJ4F3V8QNx1fZ71pKftJYfG+MS2M3PJw9Z+yDxrFtJ4/0nOCuKLywJpqA+rw4cb/K7cT
         iiWRiYP4DovV05LDs+wxdt0w3D0CiWqyXywHsy7Ew35Ojts9VC+bRqec87Wh0Uzekbqz
         uEwq2WkZ6SQcJfz9ml5pkfYDhdvw4M71FDDYA6qPQplHP90nUJ/ARetdsarw2DgvGW9H
         DMvFVltPaXfAHBpk1XTYyQVwa/cy1so7U0idkTDJQAPUp+Gzkc5NasS1JpaTAPZdiRbi
         BSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716927623; x=1717532423;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bB1n4uA6XWEYiTk9cyE4enxqgqP/0efJliwy3+pDOe0=;
        b=ZbcYQU37nTbchlsfWWSJoHlsmIlmRo9P+Fp74D8gUq+h4Aw9TJX72wnK+TZSGJWnKe
         LpSmaqmXsadQQSrHNs9ALzduJFnVH/PN9L/GUs0trhWAJjx5POQLF1gidMdGr1d7riQx
         7Oz5FNfWhoSrQPApznVzyo+/siDA8go/KXeGAkXlMkGMigspLVR/GsNuwAM/VaadGq2f
         7MU08KjodMMzKfZWgm+P4l0xOKIZHUWT23SukplpTtmcQzypnCXCcpRU7g9LaRwN/0ud
         wXXYTOXFf5s9orZTCVgnOKWTxF5lCCGeDA2lUad97l4UhLk4UdY14s3y8OMusTJtLO0Q
         eBmg==
X-Forwarded-Encrypted: i=1; AJvYcCWRykTj8EM1l/m7OIUlcy15YOioLm1si0VOSYVnDafC5Yqo/HVfScmRmi3pCjc6cAPJM+/kxMqU2/ZAqpDZhj7CYW/rMWrqpIyEE8bDqBIwWsGftsCvqYZNvE7l
X-Gm-Message-State: AOJu0Yylb2dU8utWa4t43L7/OYQj0RflVd50oB4+BqYVmJWJxgCEQxtR
	B+GdvfPHllYcGygUjjmib8ydMxvTFrgo2Zkw+0ujwpjXNlIX4FgL
X-Google-Smtp-Source: AGHT+IGfD25o8NZnevXMrCddQ+nfonvi/MK7jT1lQz9Ncdv926CzW0j8u3buvCuFU4KNH/KISkc/9w==
X-Received: by 2002:a17:902:a718:b0:1f3:81c:c17 with SMTP id d9443c01a7336-1f4eaabfc4dmr1404715ad.23.1716927622663;
        Tue, 28 May 2024 13:20:22 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9683d4sm84904905ad.178.2024.05.28.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:20:22 -0700 (PDT)
Date: Tue, 28 May 2024 13:20:19 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: netdev@vger.kernel.org, 
 Cong Wang <cong.wang@bytedance.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 bpf@vger.kernel.org, 
 kernel-dev@igalia.com, 
 syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
Message-ID: <66563c8385546_2f7f208bf@john.notmuch>
In-Reply-To: <875xuzwpjb.fsf@cloudflare.com>
References: <20240524144702.1178377-1-cascardo@igalia.com>
 <875xuzwpjb.fsf@cloudflare.com>
Subject: Re: [PATCH net v2] sock_map: avoid race between sock_map_close and
 sk_psock_put
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> On Fri, May 24, 2024 at 11:47 AM -03, Thadeu Lima de Souza Cascardo wrote:
> > sk_psock_get will return NULL if the refcount of psock has gone to 0, which
> > will happen when the last call of sk_psock_put is done. However,
> > sk_psock_drop may not have finished yet, so the close callback will still
> > point to sock_map_close despite psock being NULL.
> >
> > This can be reproduced with a thread deleting an element from the sock map,
> > while the second one creates a socket, adds it to the map and closes it.
> >
> > That will trigger the WARN_ON_ONCE:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 7220 at net/core/sock_map.c:1701 sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
> > Modules linked in:
> > CPU: 1 PID: 7220 Comm: syz-executor380 Not tainted 6.9.0-syzkaller-07726-g3c999d1ae3c7 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> > RIP: 0010:sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
> > Code: df e8 92 29 88 f8 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 79 29 88 f8 4c 8b 23 eb 89 e8 4f 15 23 f8 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 13 26 3d 02
> > RSP: 0018:ffffc9000441fda8 EFLAGS: 00010293
> > RAX: ffffffff89731ae1 RBX: ffffffff94b87540 RCX: ffff888029470000
> > RDX: 0000000000000000 RSI: ffffffff8bcab5c0 RDI: ffffffff8c1faba0
> > RBP: 0000000000000000 R08: ffffffff92f9b61f R09: 1ffffffff25f36c3
> > R10: dffffc0000000000 R11: fffffbfff25f36c4 R12: ffffffff89731840
> > R13: ffff88804b587000 R14: ffff88804b587000 R15: ffffffff89731870
> > FS:  000055555e080380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 00000000207d4000 CR4: 0000000000350ef0
> > Call Trace:
> >  <TASK>
> >  unix_release+0x87/0xc0 net/unix/af_unix.c:1048
> >  __sock_release net/socket.c:659 [inline]
> >  sock_close+0xbe/0x240 net/socket.c:1421
> >  __fput+0x42b/0x8a0 fs/file_table.c:422
> >  __do_sys_close fs/open.c:1556 [inline]
> >  __se_sys_close fs/open.c:1541 [inline]
> >  __x64_sys_close+0x7f/0x110 fs/open.c:1541
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fb37d618070
> > Code: 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d4 e8 10 2c 00 00 80 3d 31 f0 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> > RSP: 002b:00007ffcd4a525d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fb37d618070
> > RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000004
> > RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
> > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> >
> > Use sk_psock, which will only check that the pointer is not been set to
> > NULL yet, which should only happen after the callbacks are restored. If,
> > then, a reference can still be gotten, we may call sk_psock_stop and cancel
> > psock->work.
> >
> > As suggested by Paolo Abeni, reorder the condition so the control flow is
> > less convoluted.
> >
> > After that change, the reproducer does not trigger the WARN_ON_ONCE
> > anymore.
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Reported-by: syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=07a2e4a1a57118ef7355
> > Fixes: aadb2bb83ff7 ("sock_map: Fix a potential use-after-free in sock_map_close()")
> > Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >
> > v2: change control flow as suggested by Paolo Abeni
> >
> > v1: https://lore.kernel.org/netdev/20240520214153.847619-1-cascardo@igalia.com/
> >
> > ---
> >  net/core/sock_map.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > index 9402889840bf..c3179567a99a 100644
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -1680,19 +1680,23 @@ void sock_map_close(struct sock *sk, long timeout)
> >  
> >  	lock_sock(sk);
> >  	rcu_read_lock();
> > -	psock = sk_psock_get(sk);
> > -	if (unlikely(!psock)) {
> > -		rcu_read_unlock();
> > -		release_sock(sk);
> > -		saved_close = READ_ONCE(sk->sk_prot)->close;
> > -	} else {
> > +	psock = sk_psock(sk);
> > +	if (likely(psock)) {
> >  		saved_close = psock->saved_close;
> >  		sock_map_remove_links(sk, psock);
> > +		psock = sk_psock_get(sk);
> > +		if (unlikely(!psock))
> > +			goto no_psock;
> >  		rcu_read_unlock();
> >  		sk_psock_stop(psock);
> >  		release_sock(sk);
> >  		cancel_delayed_work_sync(&psock->work);
> >  		sk_psock_put(sk, psock);
> > +	} else {
> > +		saved_close = READ_ONCE(sk->sk_prot)->close;
> > +no_psock:
> > +		rcu_read_unlock();
> > +		release_sock(sk);
> >  	}
> >  
> >  	/* Make sure we do not recurse. This is a bug.
> 
> Thanks.
> 
> Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

LGTM as well. Thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

