Return-Path: <bpf+bounces-12439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55227CC7FD
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593BEB21192
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D545F42;
	Tue, 17 Oct 2023 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIzrWR/r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC243AB3
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:50:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66038B0
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697557815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SbEoh4e4WA6pjRcOHbsVz+cBxfUN2k+YV1QxzQo3Yo4=;
	b=UIzrWR/rHDD+weLZkbO44H3yBVSpbrKOGwL8SHppJpCwTWAeqW9GmPFB2PckaAF39jZ9k6
	sVX+Y+3pIUC5tX1/59ldVPkCseoYZCIcL8mm8YHShwdoe5xMzEpv589v66tRw8CudFDToT
	AsJkftcw2AdIQBboXe6iSonHiNhJDXw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-lzfZXiUeNWqVZ_pp73_7Xw-1; Tue, 17 Oct 2023 11:50:12 -0400
X-MC-Unique: lzfZXiUeNWqVZ_pp73_7Xw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CDFE3C176FA;
	Tue, 17 Oct 2023 15:50:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95B1F40C6F79;
	Tue, 17 Oct 2023 15:50:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH net] tcp_bpf: properly release resources on error paths
Date: Tue, 17 Oct 2023 17:49:51 +0200
Message-ID: <8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the blamed commit below, I completely forgot to release the acquired
resources before erroring out in the TCP BPF code, as reported by Dan.

Address the issues by replacing the bogus return with a jump to the
relevant cleanup code.

Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp_bpf.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ba2e92188124..53b0d62fd2c2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -307,8 +307,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 
 		data = tcp_msg_wait_data(sk, psock, timeo);
-		if (data < 0)
-			return data;
+		if (data < 0) {
+			copied = data;
+			goto unlock;
+		}
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
 		copied = -EAGAIN;
@@ -319,6 +321,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	tcp_rcv_space_adjust(sk);
 	if (copied > 0)
 		__tcp_cleanup_rbuf(sk, copied);
+
+unlock:
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 	return copied;
@@ -353,8 +357,10 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 		data = tcp_msg_wait_data(sk, psock, timeo);
-		if (data < 0)
-			return data;
+		if (data < 0) {
+			ret = data;
+			goto unlock;
+		}
 		if (data) {
 			if (!sk_psock_queue_empty(psock))
 				goto msg_bytes_ready;
@@ -365,6 +371,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		copied = -EAGAIN;
 	}
 	ret = copied;
+
+unlock:
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 	return ret;
-- 
2.41.0


