Return-Path: <bpf+bounces-59232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96137AC75EB
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2E01BC55B4
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EAF245007;
	Thu, 29 May 2025 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GwbTNOWG"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480612F872
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748486559; cv=none; b=q/cHk58yh6yttlJPGX62NZ2DQrYP6Ogl+9yosMOnM0S6uKOO6U9QRnpaN6S4uTuQVGeQ/GXgwwsEZvfOb/NNReArZrhiOOs9/wYOy/LDFWfDkKHh0ZNara6/j6gTw9h+mnFEMSQLR8ZqIwdJe29DIc/8tR43vKg3Ge/TB8t4bVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748486559; c=relaxed/simple;
	bh=GNLRYQUJcKmHRLXQoGd5L1xafjjvL1agDYEiwlM6VJw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=QPjmeCBXBtzy/0/pGUq3wLtHftzu1QKjoB2MKWqJxnElKcXLv+ts49PzMqCPoTno2pr8wZjLYuHbAMvyYMZGiCtLyLK/y/cfSkx7ip+VTJb29zqL2n6a7JqQ7ucOhv7kAvs1LhRMaKuuVG7+NXFwge4trQBTFKf2cWB9hF+D7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GwbTNOWG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748486544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7vrs6bHYMJbGrO5/ULBT0VnsxBQ4VzjvKqhI3ES3E4=;
	b=GwbTNOWGRLn5YQ0S+STemjaPdr+AT42nVc0pOwx0hrMCbgHWoX/XDdHTyjB8NyTL6QqNW8
	NJSqned0g1KAMapS4YSvovRSpXCv6zwK0lrKYYrw4OSO/hcdFCEzohoy2qVKrxSiaX7vR6
	XBm8UiNt/yUzJLF/4S97A30uWboAu1c=
Date: Thu, 29 May 2025 02:42:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <fefe50c6ec558074ec7de944175cec82bb426f10@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Fix psock incorrectly pointing
 to sk
To: "John Fastabend" <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, "Jakub Sitnicki" <jakub@cloudflare.com>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528234650.n5orke2yq55qnoen@gmail.com>
References: <20250523162220.52291-1-jiayuan.chen@linux.dev>
 <20250528234650.n5orke2yq55qnoen@gmail.com>
X-Migadu-Flow: FLOW_OUT

May 29, 2025 at 07:46, "John Fastabend" <john.fastabend@gmail.com> wrote:



>=20
>=20On 2025-05-24 00:22:19, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> We observed an issue from the latest selftest: sockmap_redir where
> >=20
>=20>  sk_psock(psock->sk) !=3D psock in the backlog. The root cause is t=
he special
> >=20
>=20>  behavior in sockmap_redir - it frequently performs map_update() an=
d
> >=20
>=20>  map_delete() on the same socket. During map_update(), we create a =
new
> >=20
>=20>  psock and during map_delete(), we eventually free the psock via rc=
u_work
> >=20
>=20>  in sk_psock_drop(). However, pending workqueues might still exist =
and not
> >=20
>=20>  be processed yet. If users immediately perform another map_update(=
), a new
> >=20
>=20>  psock will be allocated for the same sk, resulting in two psocks p=
ointing
> >=20
>=20>  to the same sk.
> >=20
>=20>=20=20
>=20>=20
>=20>  When the pending workqueue is later triggered, it uses the old pso=
ck to
> >=20
>=20>  access sk for I/O operations, which is incorrect.
> >=20
>=20>=20=20
>=20>=20
>=20>  Timing Diagram:
> >=20
>=20>=20=20
>=20>=20
>=20>  cpu0 cpu1
> >=20
>=20>=20=20
>=20>=20
>=20>  map_update(sk):
> >=20
>=20>  sk->psock =3D psock1
> >=20
>=20>  psock1->sk =3D sk
> >=20
>=20>  map_delete(sk):
> >=20
>=20>  rcu_work_free(psock1)
> >=20
>=20>=20=20
>=20>=20
>=20>  map_update(sk):
> >=20
>=20>  sk->psock =3D psock2
> >=20
>=20>  psock2->sk =3D sk
> >=20
>=20>  workqueue:
> >=20
>=20>  wakeup with psock1, but the sk of psock1
> >=20
>=20>  doesn't belong to psock1
> >=20
>=20>  rcu_handler:
> >=20
>=20>  clean psock1
> >=20
>=20>  free(psock1)
> >=20
>=20>=20=20
>=20>=20
>=20>  Previously, we used reference counting to address the concurrency =
issue
> >=20
>=20>  between backlog and sock_map_close(). This logic remains necessary=
 as it
> >=20
>=20>  prevents the sk from being freed while processing the backlog. But=
 this
> >=20
>=20>  patch prevents pending backlogs from using a psock after it has be=
en
> >=20
>=20>  freed.
> >=20
>=20
> Nit, its not that psock would be freed because we do have the
>=20
>=20cancel_delayed_work_sync() before the kfree(psock). But this
>=20
>=20is not a good state with two psocks referenceing the same sk.
>=20
>=20>=20
>=20> Note: We cannot call cancel_delayed_work_sync() in map_delete() sin=
ce this
> >=20
>=20>  might be invoked in BPF context by BPF helper, and the function ma=
y sleep.
> >=20
>=20>=20=20
>=20>=20
>=20>  Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg inte=
rface")
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>=20=20
>=20>=20
>=20>  ---
> >=20
>=20>  Thanks to Michal Luczaj for providing the sockmap_redir test case,=
 which
> >=20
>=20>  indeed covers almost all sockmap forwarding paths.
> >=20
>=20>  ---
> >=20
>=20>  include/linux/skmsg.h | 1 +
> >=20
>=20>  net/core/skmsg.c | 5 ++++-
> >=20
>=20>  2 files changed, 5 insertions(+), 1 deletion(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> >=20
>=20>  index 0b9095a281b8..b17221eef2f4 100644
> >=20
>=20>  --- a/include/linux/skmsg.h
> >=20
>=20>  +++ b/include/linux/skmsg.h
> >=20
>=20>  @@ -67,6 +67,7 @@ struct sk_psock_progs {
> >=20
>=20>  enum sk_psock_state_bits {
> >=20
>=20>  SK_PSOCK_TX_ENABLED,
> >=20
>=20>  SK_PSOCK_RX_STRP_ENABLED,
> >=20
>=20>  + SK_PSOCK_DROPPED,
> >=20
>=20>  };
> >=20
>=20>=20=20
>=20>=20
>=20>  struct sk_psock_link {
> >=20
>=20>  diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >=20
>=20>  index 34c51eb1a14f..bd58a693ce9a 100644
> >=20
>=20>  --- a/net/core/skmsg.c
> >=20
>=20>  +++ b/net/core/skmsg.c
> >=20
>=20>  @@ -656,6 +656,9 @@ static void sk_psock_backlog(struct work_struc=
t *work)
> >=20
>=20>  bool ingress;
> >=20
>=20>  int ret;
> >=20
>=20>=20=20
>=20>=20
>=20>  + if (sk_psock_test_state(psock, SK_PSOCK_DROPPED))
> >=20
>=20>  + return;
> >=20
>=20
> Could we use the SK_PSOCK_TX_ENABLED bit here? Its already used to
>=20
>=20ensure we wont requeue work after the psock has started being
>=20
>=20removed. Seems like we don't need two flags? wdyt?
>=20
>=20>=20
>=20> +
> >=20
>=20>  /* Increment the psock refcnt to synchronize with close(fd) path i=
n
> >=20
>=20>  * sock_map_close(), ensuring we wait for backlog thread completion
> >=20
>=20>  * before sk_socket freed. If refcnt increment fails, it indicates
> >=20
>=20>  @@ -867,7 +870,7 @@ void sk_psock_drop(struct sock *sk, struct sk_=
psock *psock)
> >=20
>=20>  write_unlock_bh(&sk->sk_callback_lock);
> >=20
>=20>=20=20
>=20>=20
>=20>  sk_psock_stop(psock);
> >=20
>=20
> Can we add this to sk_psock_stop where we have the TX_ENABLED bit
>=20
>=20cleared.



Thanks, I just add SK_PSOCK_TX_ENABLED checking at the start of sk_psock_=
backlog().
Every works fine, and truly no more flag needed !

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 34c51eb1a14f..83c78379932e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -656,6 +656,13 @@ static void sk_psock_backlog(struct work_struct *wor=
k)
        bool ingress;
        int ret;

+       /* If sk is quickly removed from the map and then added back, the=
 old
+        * psock should not be scheduled, because there are now two psock=
s
+        * pointing to the same sk.
+        */
+       if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+               return;
+
        /* Increment the psock refcnt to synchronize with close(fd) path =
in
         * sock_map_close(), ensuring we wait for backlog thread completi=
on
         * before sk_socket freed. If refcnt increment fails, it indicate=
s



> >=20
>=20> -
> >=20
>=20>  + sk_psock_set_state(psock, SK_PSOCK_DROPPED);
> >=20
>=20>  INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);
> >=20
>=20>  queue_rcu_work(system_wq, &psock->rwork);
> >=20
>=20>  }
> >=20
>=20>  --=20
>=20>=20
>=20>  2.47.1
> >
>

