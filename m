Return-Path: <bpf+bounces-30637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5718CFD81
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 11:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1968F1C20A37
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAD713AD0E;
	Mon, 27 May 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eQ0LNE/7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA813A897
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803519; cv=none; b=RJC7q95lLXokmmoXvvC0j/eUp/QST0EKddljgUD0LNR08mqmfRObcaIBy9yclekpwGpfa6v4Vm42yhNSJM9tjpoJKv0p+75igjNI+5kcnqr3NRI+y1buScTEJ8QQpsAVJSsmRJaMBrWw8+GT1paQ4tLyAULuqOlbQNDQWEywMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803519; c=relaxed/simple;
	bh=s2vRmK0IgCfvZEuotrJ0Jbr4sdRCjqr/0lSRPY1ZiOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pul9ShhBr909+GlUowiL2ZWIOjFxOZXZkMOMfh2/lwc2c/U6xb6cnFYrkF26fAXzSBVu32k6Ut2uLUSTJMRerZx7kz6c6mJoW/KnURWqFzKhKVOnfpQwH31/NFwRCu3pg1VW47plR3OGWiXEpOh/z5sem5iRZ+kkBhpOsqvHbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eQ0LNE/7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so9328013a12.0
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716803515; x=1717408315; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isrw2tRKnUr8JI9eeSEQGhxhMUppaLjF7pk2VxNOCCQ=;
        b=eQ0LNE/7VWGKBvzYJEjy+SH1ru1PZPPMGpHWTw1aTy5LKq/UAk+QzJAm+EbjF0EsoT
         bJY4wjOOsVhpFRks1l+pGoPCFDY8uGfsSXY+MqpV0aD44FcnhS33x5ab5QxaLU7waEtw
         oYvahrJWSSRd+BkSOtebcdwYzZqOPSE+M0VyG/RBLfqMm+GSAeqp/BlTqOtu8+EnmU6T
         fO2ri6bSPkCKQ00wv9uBHbwjRgLZHbzXeebqGrFP+KlIN2AkuhX0OVxCYSURXyUCVm80
         pZb2iNC3lqLDX5+ybJHF3SBDGn/GQIgt/NyF6l+4aayqXQKT/Uvi32NZRNKISJA89V3l
         4MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803515; x=1717408315;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isrw2tRKnUr8JI9eeSEQGhxhMUppaLjF7pk2VxNOCCQ=;
        b=B0gVUKUpVilYKb368uA/bLNSxBbNC8Nkc4Q/XPTabREyvOSMiroYf54Lv8gZLpHBmJ
         hJ8ge6HAlQdScO/kP3KxEd3LwBi8op5I2rzmU9W+oCiauD8ERfCeakwnQWkyyPWLjM/l
         t67JwQVnaM3qTRhTiDJ1A76U1/hULWn9r1V8bwaD7aImAIKlY1UV9NjsDmuO53rb6BGm
         X9BK9YMPcpkILaDiT5rqcEC/GvWptGRXEvQ7IIzPOZ7H2TXah8mNXBpnaEody+Pe2VQO
         8+dSs5IaH7Tg2PuesyLIIIcs7vtns3ZRpXs8lvum4+UtyYDVZR/4pKDGQoxNcpD+tHof
         HHlA==
X-Forwarded-Encrypted: i=1; AJvYcCXjsDVuZmb7oYz5Exb9LhcnU2VvCtj0GtUE8KgObbMZaHuFpL2uwJvKMuJnYzWLemgEziLxGozONX+ER1QtKG6tgNkl
X-Gm-Message-State: AOJu0YyCIBTqpTpj6/oIkYpBI/2P65N5l2+i8ajyHocNRr7HoY0THiKb
	gypFLwNKYDOV+AB1nIE/GSCETb4bQFUtrCWGFtngi8CSNbaH788h6GWpcdXmElo=
X-Google-Smtp-Source: AGHT+IF4JmO9V3VMH//snb2k0ouHEw0dyADuUqBY06Gba8/foSg7mzomuC4j1QyCga8kdmpACpSI2g==
X-Received: by 2002:aa7:d60c:0:b0:578:57f6:499d with SMTP id 4fb4d7f45d1cf-57857f64f40mr7722127a12.12.1716803514867;
        Mon, 27 May 2024 02:51:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c3bbee4asm2603657a12.76.2024.05.27.02.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:51:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: netdev@vger.kernel.org,  Cong Wang <cong.wang@bytedance.com>,  Eric
 Dumazet <edumazet@google.com>,  Daniel Borkmann <daniel@iogearbox.net>,
  John Fastabend <john.fastabend@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  bpf@vger.kernel.org,  kernel-dev@igalia.com,
  syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com,
  stable@vger.kernel.org
Subject: Re: [PATCH net v2] sock_map: avoid race between sock_map_close and
 sk_psock_put
In-Reply-To: <20240524144702.1178377-1-cascardo@igalia.com> (Thadeu Lima de
	Souza Cascardo's message of "Fri, 24 May 2024 11:47:02 -0300")
References: <20240524144702.1178377-1-cascardo@igalia.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 27 May 2024 11:51:52 +0200
Message-ID: <875xuzwpjb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 24, 2024 at 11:47 AM -03, Thadeu Lima de Souza Cascardo wrote:
> sk_psock_get will return NULL if the refcount of psock has gone to 0, which
> will happen when the last call of sk_psock_put is done. However,
> sk_psock_drop may not have finished yet, so the close callback will still
> point to sock_map_close despite psock being NULL.
>
> This can be reproduced with a thread deleting an element from the sock map,
> while the second one creates a socket, adds it to the map and closes it.
>
> That will trigger the WARN_ON_ONCE:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 7220 at net/core/sock_map.c:1701 sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
> Modules linked in:
> CPU: 1 PID: 7220 Comm: syz-executor380 Not tainted 6.9.0-syzkaller-07726-g3c999d1ae3c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> RIP: 0010:sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
> Code: df e8 92 29 88 f8 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 79 29 88 f8 4c 8b 23 eb 89 e8 4f 15 23 f8 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 13 26 3d 02
> RSP: 0018:ffffc9000441fda8 EFLAGS: 00010293
> RAX: ffffffff89731ae1 RBX: ffffffff94b87540 RCX: ffff888029470000
> RDX: 0000000000000000 RSI: ffffffff8bcab5c0 RDI: ffffffff8c1faba0
> RBP: 0000000000000000 R08: ffffffff92f9b61f R09: 1ffffffff25f36c3
> R10: dffffc0000000000 R11: fffffbfff25f36c4 R12: ffffffff89731840
> R13: ffff88804b587000 R14: ffff88804b587000 R15: ffffffff89731870
> FS:  000055555e080380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000000207d4000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  unix_release+0x87/0xc0 net/unix/af_unix.c:1048
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xbe/0x240 net/socket.c:1421
>  __fput+0x42b/0x8a0 fs/file_table.c:422
>  __do_sys_close fs/open.c:1556 [inline]
>  __se_sys_close fs/open.c:1541 [inline]
>  __x64_sys_close+0x7f/0x110 fs/open.c:1541
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb37d618070
> Code: 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d4 e8 10 2c 00 00 80 3d 31 f0 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> RSP: 002b:00007ffcd4a525d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fb37d618070
> RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>
> Use sk_psock, which will only check that the pointer is not been set to
> NULL yet, which should only happen after the callbacks are restored. If,
> then, a reference can still be gotten, we may call sk_psock_stop and cancel
> psock->work.
>
> As suggested by Paolo Abeni, reorder the condition so the control flow is
> less convoluted.
>
> After that change, the reproducer does not trigger the WARN_ON_ONCE
> anymore.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Reported-by: syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=07a2e4a1a57118ef7355
> Fixes: aadb2bb83ff7 ("sock_map: Fix a potential use-after-free in sock_map_close()")
> Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>
> v2: change control flow as suggested by Paolo Abeni
>
> v1: https://lore.kernel.org/netdev/20240520214153.847619-1-cascardo@igalia.com/
>
> ---
>  net/core/sock_map.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 9402889840bf..c3179567a99a 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1680,19 +1680,23 @@ void sock_map_close(struct sock *sk, long timeout)
>  
>  	lock_sock(sk);
>  	rcu_read_lock();
> -	psock = sk_psock_get(sk);
> -	if (unlikely(!psock)) {
> -		rcu_read_unlock();
> -		release_sock(sk);
> -		saved_close = READ_ONCE(sk->sk_prot)->close;
> -	} else {
> +	psock = sk_psock(sk);
> +	if (likely(psock)) {
>  		saved_close = psock->saved_close;
>  		sock_map_remove_links(sk, psock);
> +		psock = sk_psock_get(sk);
> +		if (unlikely(!psock))
> +			goto no_psock;
>  		rcu_read_unlock();
>  		sk_psock_stop(psock);
>  		release_sock(sk);
>  		cancel_delayed_work_sync(&psock->work);
>  		sk_psock_put(sk, psock);
> +	} else {
> +		saved_close = READ_ONCE(sk->sk_prot)->close;
> +no_psock:
> +		rcu_read_unlock();
> +		release_sock(sk);
>  	}
>  
>  	/* Make sure we do not recurse. This is a bug.

Thanks.

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

