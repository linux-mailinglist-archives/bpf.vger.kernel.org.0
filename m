Return-Path: <bpf+bounces-70639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4BBC7489
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 05:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4134F37B
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 03:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B5231830;
	Thu,  9 Oct 2025 03:19:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-09.21cn.com [182.42.152.55])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42052230BCC;
	Thu,  9 Oct 2025 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.152.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979946; cv=none; b=IdjUkNLj+9+kjv2CSv2REqJeDNQFeYnzk+BRoc+Ylkja7kWR69By5fw+yXAh4MoZ6gUbmNherKQr9bcNkcNoRHgVGqykG1FaRhZAz/l9hvtteFEsDjN8rIkGJzTDJ/H+59RFRXuHCNTXWCPHuPUH+ezdg4rArOd6PbFgO9f2pks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979946; c=relaxed/simple;
	bh=2dVoS6G/45/uzPULkcFB5snwNDzAAe9QEfhs6uojtSY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VLZxef+JmQygGNk58yhAQ9of+oEdixn5LwAHPcpRblvBNVNIXZoyH6LHGfqZelhJeEjCrmIMBy7y/cP6/wRT2s1v+QttuPwrsdXJX6k0PbJwKq9QMpIKxDSginwhXzPtXiiZVDFjhB+qmibaEQaUL8r4TkRPLGveGpsrkE+/pmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.152.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.1902175892
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.68 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id B83E41120EE27;
	Thu,  9 Oct 2025 11:06:57 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([27.148.194.68])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id 375b2c6fbcaa43b497e9cf07ee1cdf4b for john.fastabend@gmail.com;
	Thu, 09 Oct 2025 11:07:06 CST
X-Transaction-ID: 375b2c6fbcaa43b497e9cf07ee1cdf4b
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 27.148.194.68
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
Message-ID: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
Date: Thu, 9 Oct 2025 11:07:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Ctyun AOneMail
Content-Language: en-US
To: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
From: zhengguoyong <zhenggy@chinatelecom.cn>
Subject: [PATCH] bpf, sockmap: Update tp->rcv_nxt in sk_psock_skb_ingress
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using sockmap to forward TCP traffic to the application
layer of the peer socket, the peer socket's tcp_bpf_recvmsg_parser
processing flow will synchronously update the tp->copied_seq field.
This causes tp->rcv_nxt to become less than tp->copied_seq.

Later, when this socket receives SKB packets from the protocol stack,
in the call chain tcp_data_ready → tcp_epollin_ready, the function
tcp_epollin_ready will return false, preventing the socket from being
woken up to receive new packets.

Therefore, it is necessary to synchronously update the tp->rcv_nxt
information in sk_psock_skb_ingress.

Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
---
 net/core/skmsg.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 9becadd..e9d841c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -576,6 +576,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	struct sock *sk = psock->sk;
 	struct sk_msg *msg;
 	int err;
+	u32 seq;

 	/* If we are receiving on the same sock skb->sk is already assigned,
 	 * skip memory accounting and owner transition seeing it already set
@@ -595,8 +596,15 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 */
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
-	if (err < 0)
+	if (err < 0) {
 		kfree(msg);
+	} else {
+		bh_lock_sock_nested(sk);
+		seq = READ_ONCE(tcp_sk(sk)->rcv_nxt) + len;
+		WRITE_ONCE(tcp_sk(sk)->rcv_nxt, seq);
+		bh_unlock_sock(sk);
+	}
+
 	return err;
 }

-- 
1.8.3.1

