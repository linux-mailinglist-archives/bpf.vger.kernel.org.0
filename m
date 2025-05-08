Return-Path: <bpf+bounces-57733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B28AAF398
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48704178AC9
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 06:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD6212F94;
	Thu,  8 May 2025 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p1EIz/YB"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6271D8A0A
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685180; cv=none; b=Vk0RzFcDIc0bFPFgW3gnC3/Tf0VWomEPDC6CrA7zfxMHSDfTPdSXvxDXPXSDOW2r6eK1KwIxp3H/sdTUWL8v62wg1nx3BFjRpvhtSvZVExqijFJbiZ6dDvAJV4KY398xeFAI/P2rMhmDDQen0CWdmtBAU9KkFHsyY7GJQv17lSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685180; c=relaxed/simple;
	bh=DtYmFysUlSJqt4dIK+BH0UUapcZkTkGEqj05JbxIk9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8euVedj7qCKZNTNYJfG6OtmLuZAC2SAU408sfgKOV9LXyBUIk+qvWi9gRYjA9s+DbXkt7WVim2dLa8z5pstnKglgQTug3yuOZ9CWVyL5Pa9ojlGgVPp3BnJiLVlN6AO3Kbb+nBVjLuPxRjJEnagNUCHQOzIa4cXL2Krh3xmNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p1EIz/YB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746685166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JQOF4qJClLbpwilGN0tAlFNmWOxZLphtkwR7tYlHPGI=;
	b=p1EIz/YBzmUGRmku30gPRdKcF4rMdist4JBJuy1Rk3g5iqXwIarl1t9ye/MaAQs/vV8Bf8
	GYMPUtdEwDDsWDse2hvlXAiPUJbGIl0rpw+kA2gonqUMrxcbYgTX0C7OoJyUOr/tPSmIUd
	8ewKtI7F8lLTuW/HKL/nMP9TrC12g5s=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5] bpf, sockmap: avoid using sk_socket after free when sending
Date: Thu,  8 May 2025 14:18:25 +0800
Message-ID: <20250508061825.51896-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The sk->sk_socket is not locked or referenced in backlog thread, and
during the call to skb_send_sock(), there is a race condition with
the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
will be affected.

Race conditions:
'''
CPU0                               CPU1

backlog::skb_send_sock
  sendmsg_unlocked
    sock_sendmsg
      sock_sendmsg_nosec
                                   close(fd):
                                     ...
                                     ops->release() -> sock_map_close()
                                     sk_socket->ops = NULL
                                     free(socket)
      sock->ops->sendmsg
            ^
            panic here
'''

The ref of psock become 0 after sock_map_close() executed.
'''
void sock_map_close()
{
    ...
    if (likely(psock)) {
    ...
    // !! here we remove psock and the ref of psock become 0
    sock_map_remove_links(sk, psock)
    psock = sk_psock_get(sk);
    if (unlikely(!psock))
        goto no_psock; <=== Control jumps here via goto
        ...
        cancel_delayed_work_sync(&psock->work); <=== not executed
        sk_psock_put(sk, psock);
        ...
}
'''

Based on the fact that we already wait for the workqueue to finish in
sock_map_close() if psock is held, we simply increase the psock
reference count to avoid race conditions.

With this patch, if the backlog thread is running, sock_map_close() will
wait for the backlog thread to complete and cancel all pending work.

If no backlog running, any pending work that hasn't started by then will
fail when invoked by sk_psock_get(), as the psock reference count have
been zeroed, and sk_psock_drop() will cancel all jobs via
cancel_delayed_work_sync().

In summary, we require synchronization to coordinate the backlog thread
and close() thread.

The panic I catched:
'''
Workqueue: events sk_psock_backlog
RIP: 0010:sock_sendmsg+0x21d/0x440
RAX: 0000000000000000 RBX: ffffc9000521fad8 RCX: 0000000000000001
...
Call Trace:
 <TASK>
 ? die_addr+0x40/0xa0
 ? exc_general_protection+0x14c/0x230
 ? asm_exc_general_protection+0x26/0x30
 ? sock_sendmsg+0x21d/0x440
 ? sock_sendmsg+0x3e0/0x440
 ? __pfx_sock_sendmsg+0x10/0x10
 __skb_send_sock+0x543/0xb70
 sk_psock_backlog+0x247/0xb80
...
'''

Reported-by: Michal Luczaj <mhal@rbox.co>
Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
This patch is extracted from my previous v4 patchset that contained
multiple fixes, and it remains unchanged. Since this fix is relatively
simple and easy to review, we want to separate it from other fixes to
avoid any potential interference.
---
 net/core/skmsg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 276934673066..34c51eb1a14f 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -656,6 +656,13 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	/* Increment the psock refcnt to synchronize with close(fd) path in
+	 * sock_map_close(), ensuring we wait for backlog thread completion
+	 * before sk_socket freed. If refcnt increment fails, it indicates
+	 * sock_map_close() completed with sk_socket potentially already freed.
+	 */
+	if (!sk_psock_get(psock->sk))
+		return;
 	mutex_lock(&psock->work_mutex);
 	while ((skb = skb_peek(&psock->ingress_skb))) {
 		len = skb->len;
@@ -708,6 +715,7 @@ static void sk_psock_backlog(struct work_struct *work)
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
+	sk_psock_put(psock->sk, psock);
 }
 
 struct sk_psock *sk_psock_init(struct sock *sk, int node)
-- 
2.47.1


