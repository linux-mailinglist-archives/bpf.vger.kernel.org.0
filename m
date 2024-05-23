Return-Path: <bpf+bounces-30380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D408CCD56
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1E0282F3B
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57F13CF84;
	Thu, 23 May 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic5sU1BF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0D339A0
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450774; cv=none; b=gh6u/GP7b1QToX59Fgs13n+MFcmD+z0vGWGXKYG5wTCLALXBhFtLq8sE1DKuR3Er4rNNPliVZNSYLEIGUtMbctSjgTENquH5jub1ypBS/MvfUguPqXuCGKprV1fPUx8Qqrlo1poNKXbGwmEafmvA0e6T0tzaQnbIcJ9xiT7UUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450774; c=relaxed/simple;
	bh=bLX4kzxrFGZHQiWmD9NNZxR00UUlvn3yUWnR4d0/nLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lkb8VC0whnSBsF1ObIZ30jtBfcr6/aCwmULIkQcsQEM9iUsHbng7BJz7Y1X8LeKNeW1QTiWsmzG4BACHVzmypWr4kD+OQ6/7mD4BvG7x9bSQFRa14ZBGfI4Kw9B31P5C9K5s2crEEnxnZB6XGFsjCTh2jhTl2lJcLGd8nDpciIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ic5sU1BF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716450772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jfUml5xcQaIZ5iYf7eZB8yPQBcGlGRP0fYnYVl9vols=;
	b=ic5sU1BF1IL8sB3+j9+o1YrIohBPE2O0W5dna/08h+QqHmUDgl+dYR5ppjnBeivoCD1sCi
	OUjgn2NBPSod9gdlXQzyTEYc62kOw9Ro7GItOlSTLcLZDzI3/qGzSWgteZCCA53N6p+e2Y
	dVv97M2EjGA+hPvYl0J+c3t/eUHvtv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-60_lqKdfNauMgi8zguFKHw-1; Thu, 23 May 2024 03:52:50 -0400
X-MC-Unique: 60_lqKdfNauMgi8zguFKHw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-354d4404a76so309928f8f.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 00:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450768; x=1717055568;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfUml5xcQaIZ5iYf7eZB8yPQBcGlGRP0fYnYVl9vols=;
        b=sBwecaGol6OEuxf1wM2LnBwWFyhoKRS6mo1JtQZRIjX4XMe0n99t4eazbnGjZwKGgo
         nIHhek88XDYKlJaVabmCLM7hBDxuMzLlPmyBntIIqVMzLXOjd1OHNryT2mXhXdMN1UlC
         kfMSH++/NzHJC/P18esR/+3lCnt42kFxcvOMSbk19tFbgLNiNU0YfsFd9fM9NisgevZ+
         jPBJ3sA32DnaPGHKVFjU9k04PGKfzsbKB0UcXsj6ka+Dbl+vgwUyVBfZPeAvRY2LIYo4
         LUIFOWmSi92XKUu+Ytw/YD3gEAJ1HD7jO+xCb3YrYyetvzrJILMhbBhBvWPc5jT8746n
         4vrA==
X-Forwarded-Encrypted: i=1; AJvYcCU05bURxLfEh90e2hgnqujM5R+u0l0v8EKJyrngOBPdtQlZeHsEOlg0QBjxUwYrv2iWjnErHzJGnfl2sfTq3GmE5Rb2
X-Gm-Message-State: AOJu0Yx3OmjJ7brRvBhAkYs0juzIc5jnbzQJlp++bjO6h436nuQ5Ew/h
	EIDt9AihnZ2FoZeNYQIN6qXR1Mp6v8g7p+kICZuKSfh1U3Z2IdpRxhn1kpP0SJ9Y09maMcmt/o8
	pFDYr5GREGehY4KGM8vWulivXa7iIDY4HuNKloW27TUyx1tw8tQ==
X-Received: by 2002:a05:6000:707:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-354d8db8103mr3637648f8f.4.1716450767856;
        Thu, 23 May 2024 00:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOezpAuDnzTSwr7aUgCeLnph2ngObjaT/PPgOctfTwjGglWH20lXf1q7t4KFZ5W8MM4AjJTg==
X-Received: by 2002:a05:6000:707:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-354d8db8103mr3637625f8f.4.1716450767391;
        Thu, 23 May 2024 00:52:47 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm35873297f8f.66.2024.05.23.00.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:52:46 -0700 (PDT)
Message-ID: <58032b8049696566704e1941f909159a2f6c9af8.camel@redhat.com>
Subject: Re: [PATCH net] sock_map: avoid race between sock_map_close and
 sk_psock_put
From: Paolo Abeni <pabeni@redhat.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
	netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>, Jakub Sitnicki
 <jakub@cloudflare.com>,  Eric Dumazet <edumazet@google.com>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
 kernel-dev@igalia.com,
 syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
Date: Thu, 23 May 2024 09:52:45 +0200
In-Reply-To: <13b77d180c2bad74d6749a6c34190a10134bd6fa.camel@redhat.com>
References: <20240520214153.847619-1-cascardo@igalia.com>
	 <13b77d180c2bad74d6749a6c34190a10134bd6fa.camel@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 14:08 +0200, Paolo Abeni wrote:
> On Mon, 2024-05-20 at 18:41 -0300, Thadeu Lima de Souza Cascardo wrote:
> > sk_psock_get will return NULL if the refcount of psock has gone to 0, w=
hich
> > will happen when the last call of sk_psock_put is done. However,
> > sk_psock_drop may not have finished yet, so the close callback will sti=
ll
> > point to sock_map_close despite psock being NULL.
> >=20
> > This can be reproduced with a thread deleting an element from the sock =
map,
> > while the second one creates a socket, adds it to the map and closes it=
.
> >=20
> > That will trigger the WARN_ON_ONCE:
> >=20
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 7220 at net/core/sock_map.c:1701 sock_map_close+0x=
2a2/0x2d0 net/core/sock_map.c:1701
> > Modules linked in:
> > CPU: 1 PID: 7220 Comm: syz-executor380 Not tainted 6.9.0-syzkaller-0772=
6-g3c999d1ae3c7 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 04/02/2024
> > RIP: 0010:sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
> > Code: df e8 92 29 88 f8 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74=
 08 48 89 df e8 79 29 88 f8 4c 8b 23 eb 89 e8 4f 15 23 f8 90 <0f> 0b 90 48 =
83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 13 26 3d 02
> > RSP: 0018:ffffc9000441fda8 EFLAGS: 00010293
> > RAX: ffffffff89731ae1 RBX: ffffffff94b87540 RCX: ffff888029470000
> > RDX: 0000000000000000 RSI: ffffffff8bcab5c0 RDI: ffffffff8c1faba0
> > RBP: 0000000000000000 R08: ffffffff92f9b61f R09: 1ffffffff25f36c3
> > R10: dffffc0000000000 R11: fffffbfff25f36c4 R12: ffffffff89731840
> > R13: ffff88804b587000 R14: ffff88804b587000 R15: ffffffff89731870
> > FS:  000055555e080380(0000) GS:ffff8880b9500000(0000) knlGS:00000000000=
00000
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
> > Code: 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d4 e8=
 10 2c 00 00 80 3d 31 f0 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 =
ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> > RSP: 002b:00007ffcd4a525d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fb37d618070
> > RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000004
> > RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
> > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> >=20
> > Use sk_psock, which will only check that the pointer is not been set to
> > NULL yet, which should only happen after the callbacks are restored. If=
,
> > then, a reference can still be gotten, we may call sk_psock_stop and ca=
ncel
> > psock->work.
> >=20
> > After that change, the reproducer does not trigger the WARN_ON_ONCE
> > anymore.
> >=20
> > Reported-by: syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D07a2e4a1a57118ef7355
> > Fixes: aadb2bb83ff7 ("sock_map: Fix a potential use-after-free in sock_=
map_close()")
> > Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,u=
nhash} call itself")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >  net/core/sock_map.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > index 9402889840bf..13267e667a4c 100644
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -1680,19 +1680,23 @@ void sock_map_close(struct sock *sk, long timeo=
ut)
> > =20
> >  	lock_sock(sk);
> >  	rcu_read_lock();
> > -	psock =3D sk_psock_get(sk);
> > +	psock =3D sk_psock(sk);
> >  	if (unlikely(!psock)) {
> > +		saved_close =3D READ_ONCE(sk->sk_prot)->close;
> >  		rcu_read_unlock();
> >  		release_sock(sk);
> > -		saved_close =3D READ_ONCE(sk->sk_prot)->close;
> >  	} else {
> >  		saved_close =3D psock->saved_close;
> >  		sock_map_remove_links(sk, psock);
> > +		psock =3D sk_psock_get(sk);
> >  		rcu_read_unlock();
> > -		sk_psock_stop(psock);
> > +		if (psock)
> > +			sk_psock_stop(psock);
> >  		release_sock(sk);
> > -		cancel_delayed_work_sync(&psock->work);
> > -		sk_psock_put(sk, psock);
> > +		if (psock) {
> > +			cancel_delayed_work_sync(&psock->work);
> > +			sk_psock_put(sk, psock);
> > +		}
> >  	}
> > =20
> >  	/* Make sure we do not recurse. This is a bug.
>=20
> As a personal opinion I think the code will become simple reordering
> the condition, something alike:
>=20
> 	if (psock) {
> 		saved_close =3D psock->saved_close;
>  		sock_map_remove_links(sk, psock);
> 		psock =3D sk_psock_get(sk);
> 		if (!psock)
> 			goto no_psock;
>  		rcu_read_unlock();
> 		sk_psock_stop(psock);
>  		release_sock(sk);
> 		cancel_delayed_work_sync(&psock->work);
> 		sk_psock_put(sk, psock);
> 	} else {
> no_psock:
> 		saved_close =3D READ_ONCE(sk->sk_prot)->close;

FTR, the above is wrong, should be:

		saved_close =3D READ_ONCE(sk->sk_prot)->close;
no_psock:

>  		rcu_read_unlock();
>  		release_sock(sk);
> 	}

/P


