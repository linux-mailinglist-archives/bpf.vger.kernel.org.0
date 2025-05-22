Return-Path: <bpf+bounces-58775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A58AC170C
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 00:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD651C02837
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7CA2BDC1F;
	Thu, 22 May 2025 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hvwi6Dhm"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7D2BD581
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954624; cv=none; b=sfElWGkvFwZ6JdC7wLPDfLH5ocAPOagTVQlkZ5Qy1h8A5PC7psJkS/VKhLzFjIntFLpUK+26jLUT/87IxaQLd9Lpvx4jOqGH2NHsxNurJJs20dGUCRvnh0378ThW68n7UqE3RbK5RI8sjWkg+YbxAWFzhuQpVrZL3S1ydxSdMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954624; c=relaxed/simple;
	bh=ShpH2Lrz40L9DOsJ3UQSgxelkKBLo/YVsgqN9p+w034=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=c7jO5hQnLiOXmIEUygD9SVRVu7iiyTQxN8lcQ3esIMlL0sbLZg08aMBa5i066SdpRGwgoCjmLitUslFqnYwKM6anahOrG55Lhgt2Ek0QuseiLahSjli8zOmELXILZ5R8PJV8Pre1G6LS6zynQnzJ6fOop3oNVahva3y/UkP9koQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hvwi6Dhm; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747954618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJDADEXuHfqfTmAHEHNUhMdj/6JudXWWJl8mcFP32/s=;
	b=Hvwi6Dhm6PdUO0889euxLcZpJjDxz7rpCSpB/RGawHif/VbiSsxwSQPXU9mg+YDp0qhrDq
	Lal+XtseX+emD5Ba/1IN93xFlGK26cyLKSGBWYC4xH3cdiWXUVOCWw2Idh0tYxoOr5xga5
	9/fTCY8YHHZEmZZwJoGjUHOO68apVPM=
Date: Thu, 22 May 2025 22:56:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <2c8ab490e47d44ef5250ac755a5388fe147345d4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v6] bpf, sockmap: avoid using sk_socket after
 free when sending
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, "Michal Luczaj" <mhal@rbox.co>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Thadeu Lima de
 Souza Cascardo" <cascardo@igalia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <3eb50302-d90c-4477-b296-f5f29a7d1eca@linux.dev>
References: <20250516141713.291150-1-jiayuan.chen@linux.dev>
 <3eb50302-d90c-4477-b296-f5f29a7d1eca@linux.dev>
X-Migadu-Flow: FLOW_OUT

2025/5/23 03:25, "Martin KaFai Lau" <martin.lau@linux.dev> wrote:

>=20
>=20On 5/16/25 7:17 AM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> The sk->sk_socket is not locked or referenced in backlog thread, an=
d
> >=20
>=20>  during the call to skb_send_sock(), there is a race condition with
> >=20
>=20>  the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
> >=20
>=20>  will be affected.
> >=20
>=20>  Race conditions:
> >=20
>=20>  '''
> >=20
>=20>  CPU0 CPU1
> >=20
>=20>  backlog::skb_send_sock
> >=20
>=20>  sendmsg_unlocked
> >=20
>=20>  sock_sendmsg
> >=20
>=20>  sock_sendmsg_nosec
> >=20
>=20>  close(fd):
> >=20
>=20>  ...
> >=20
>=20>  ops->release() -> sock_map_close()
> >=20
>=20>  sk_socket->ops =3D NULL
> >=20
>=20>  free(socket)
> >=20
>=20>  sock->ops->sendmsg
> >=20
>=20>  ^
> >=20
>=20>  panic here
> >=20
>=20>  '''
> >=20
>=20>  The ref of psock become 0 after sock_map_close() executed.
> >=20
>=20>  '''
> >=20
>=20>  void sock_map_close()
> >=20
>=20>  {
> >=20
>=20>  ...
> >=20
>=20>  if (likely(psock)) {
> >=20
>=20>  ...
> >=20
>=20>  // !! here we remove psock and the ref of psock become 0
> >=20
>=20>  sock_map_remove_links(sk, psock)
> >=20
>=20>  psock =3D sk_psock_get(sk);
> >=20
>=20>  if (unlikely(!psock))
> >=20
>=20>  goto no_psock; <=3D=3D=3D Control jumps here via goto
> >=20
>=20>  ...
> >=20
>=20>  cancel_delayed_work_sync(&psock->work); <=3D=3D=3D not executed
> >=20
>=20>  sk_psock_put(sk, psock);
> >=20
>=20>  ...
> >=20
>=20>  }
> >=20
>=20>  '''
> >=20
>=20>  Based on the fact that we already wait for the workqueue to finish=
 in
> >=20
>=20>  sock_map_close() if psock is held, we simply increase the psock
> >=20
>=20>  reference count to avoid race conditions.
> >=20
>=20>  With this patch, if the backlog thread is running, sock_map_close(=
) will
> >=20
>=20>  wait for the backlog thread to complete and cancel all pending wor=
k.
> >=20
>=20>  If no backlog running, any pending work that hasn't started by the=
n will
> >=20
>=20>  fail when invoked by sk_psock_get(), as the psock reference count =
have
> >=20
>=20>  been zeroed, and sk_psock_drop() will cancel all jobs via
> >=20
>=20>  cancel_delayed_work_sync().
> >=20
>=20>  In summary, we require synchronization to coordinate the backlog t=
hread
> >=20
>=20>  and close() thread.
> >=20
>=20>  The panic I catched:
> >=20
>=20>  '''
> >=20
>=20>  Workqueue: events sk_psock_backlog
> >=20
>=20>  RIP: 0010:sock_sendmsg+0x21d/0x440
> >=20
>=20>  RAX: 0000000000000000 RBX: ffffc9000521fad8 RCX: 0000000000000001
> >=20
>=20>  ...
> >=20
>=20>  Call Trace:
> >=20
>=20>  <TASK>
> >=20
>=20>  ? die_addr+0x40/0xa0
> >=20
>=20>  ? exc_general_protection+0x14c/0x230
> >=20
>=20>  ? asm_exc_general_protection+0x26/0x30
> >=20
>=20>  ? sock_sendmsg+0x21d/0x440
> >=20
>=20>  ? sock_sendmsg+0x3e0/0x440
> >=20
>=20>  ? __pfx_sock_sendmsg+0x10/0x10
> >=20
>=20>  __skb_send_sock+0x543/0xb70
> >=20
>=20>  sk_psock_backlog+0x247/0xb80
> >=20
>=20>  ...
> >=20
>=20>  '''
> >=20
>=20>  Reported-by: Michal Luczaj <mhal@rbox.co>
> >=20
>=20>  Fixes: 4b4647add7d3 ("sock_map: avoid race between sock_map_close =
and sk_psock_put")
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  V5 -> V6: Use correct "Fixes" tag.
> >=20
>=20>  V4 -> V5:
> >=20
>=20>  This patch is extracted from my previous v4 patchset that containe=
d
> >=20
>=20>  multiple fixes, and it remains unchanged. Since this fix is relati=
vely
> >=20
>=20>  simple and easy to review, we want to separate it from other fixes=
 to
> >=20
>=20>  avoid any potential interference.
> >=20
>=20>  ---
> >=20
>=20>  net/core/skmsg.c | 8 ++++++++
> >=20
>=20>  1 file changed, 8 insertions(+)
> >=20
>=20>  diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >=20
>=20>  index 276934673066..34c51eb1a14f 100644
> >=20
>=20>  --- a/net/core/skmsg.c
> >=20
>=20>  +++ b/net/core/skmsg.c
> >=20
>=20>  @@ -656,6 +656,13 @@ static void sk_psock_backlog(struct work_stru=
ct *work)
> >=20
>=20>  bool ingress;
> >=20
>=20>  int ret;
> >=20
>=20>  > + /* Increment the psock refcnt to synchronize with close(fd) pa=
th in
> >=20
>=20>  + * sock_map_close(), ensuring we wait for backlog thread completi=
on
> >=20
>=20>  + * before sk_socket freed. If refcnt increment fails, it indicate=
s
> >=20
>=20>  + * sock_map_close() completed with sk_socket potentially already =
freed.
> >=20
>=20>  + */
> >=20
>=20>  + if (!sk_psock_get(psock->sk))
> >=20
>=20
> This seems to be the first use case to pass "psock->sk" to "sk_psock_ge=
t()".
>=20
>=20I could have missed the sock_map details here. Considering it is raci=
ng with sock_map_close() which should also do a sock_put(sk) [?],
>=20
>=20could you help to explain what makes it safe to access the psock->sk =
here?
>=20
>=20>=20
>=20> + return;
> >=20
>=20>  mutex_lock(&psock->work_mutex);
> >=20
>=20>  while ((skb =3D skb_peek(&psock->ingress_skb))) {
> >=20
>=20>  len =3D skb->len;
> >=20
>=20>  @@ -708,6 +715,7 @@ static void sk_psock_backlog(struct work_struc=
t *work)
> >=20
>=20>  }
> >=20
>=20>  end:
> >=20
>=20>  mutex_unlock(&psock->work_mutex);
> >=20
>=20>  + sk_psock_put(psock->sk, psock);
> >=20
>=20>  }
> >=20
>=20>  > struct sk_psock *sk_psock_init(struct sock *sk, int node)
> >
>

Hi Martin,

Using 'sk_psock_get(psock->sk)' in the workqueue is safe because
sock_map_close() only reduces the reference count of psock to zero, while
the actual memory release is fully handled by the RCU callback: sk_psock_=
destroy().

In sk_psock_destroy(), we first cancel_delayed_work_sync() to wait for th=
e
workqueue to complete, and then perform sock_put(psock->sk). This means w=
e
already have an explicit synchronization mechanism in place that guarante=
es
safe access to both psock and psock->sk in the workqueue context.

Thanks.

