Return-Path: <bpf+bounces-45124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC01D9D1A16
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 22:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A0828235B
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5071E906F;
	Mon, 18 Nov 2024 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="qrB0wB8g"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA41E8844;
	Mon, 18 Nov 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963936; cv=none; b=V6tdEYCf91vG96Hxns0yPoH0xEYlddXvKd+ZvWNy/iXKBuOEzjLVvZzqVHtjJ2MjWXpPnjH4o81dmMQ8fYVUe1XPqL+EP/hjjtE5dh0WNXNWq60EepWPdcPMER3Q1NcKOTWRsxNoeZW6li3IDUGOUAu0GUwIjgHJI7DcHGilJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963936; c=relaxed/simple;
	bh=yxgSfg68f3OHumg7gYdyISrFvbP1dKO8ppUKrFr+3rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bPvnJ+Y5OTbtSpbL4Q6MA5aI781ucYHKGpHiWA6tMTj6DPSdX8i47QgVTAcFDlMAKbmKboXkeX2xZdWXLr9rGAmfJR7gH/YPtSNC3+SLP3LxBJEK6D7H3zUII4C+7TQ94XXaWedz5mYwZE5wCFkJj/DS7xtIfMaUbqQuxX4RJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=qrB0wB8g; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tD8vr-000078-L6; Mon, 18 Nov 2024 22:05:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=v8a/IYagFmlBSqn1ewjBjt5G7sUJDzk9cHncBbjifAU=; b=qrB0wB8gkOs7/xpmeXJ+R/+w4u
	WuRlm+VFEShffrDV7tzrVxJp3UvIOW7NRthD+adZQX/dsowACyTK+LdZSeSFTkPvqaxt0HGf0LsLq
	QuDjCkI8hs6T8o1GWJaDMMbfaI0hu2GT/i/Z5OofdzGOh0BTg3xKacoLNIcQ8s1I9QbtiyuLPwl6N
	fhG9py2NDi9AMwZlNJBWA39Z8d8g8pXbTa3pQETLk4g2+i9DaZ6F5enHMMo59HemK7HxSynYYhDcf
	Fp8B9l/3aCKrRP9g8zSSYensN86G5K3x2N0G88IPU9Ply6uRtoRXOBaaJ9qGi4QnxMWFIZb3YS+tW
	x2V+efRA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tD8vr-0007dA-3J; Mon, 18 Nov 2024 22:05:15 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tD8vf-00DME4-0r; Mon, 18 Nov 2024 22:05:03 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 18 Nov 2024 22:03:41 +0100
Subject: [PATCH bpf 1/4] bpf, vsock: Fix poll() missing a queue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

When a verdict program simply passes a packet without redirection, sk_msg
is enqueued on sk_psock::ingress_msg. Add a missing check to poll().

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index dfd29160fe11c4675f872c1ee123d65b2da0dae6..919da8edd03c838cbcdbf1618425da6c5ec2df1a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1054,6 +1054,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLRDHUP;
 	}
 
+	if (sk_is_readable(sk))
+		mask |= EPOLLIN | EPOLLRDNORM;
+
 	if (sock->type == SOCK_DGRAM) {
 		/* For datagram sockets we can read if there is something in
 		 * the queue and write as long as the socket isn't shutdown for

-- 
2.46.2


