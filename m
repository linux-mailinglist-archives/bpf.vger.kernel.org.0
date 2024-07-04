Return-Path: <bpf+bounces-33848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1384926E8C
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 06:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C1B281CEB
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 04:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713281CA84;
	Thu,  4 Jul 2024 04:49:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-04.21cn.com [182.42.158.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33B107A0;
	Thu,  4 Jul 2024 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.158.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720068541; cv=none; b=vCY68nz9QM3py4a+pQRvzGM49dRZYOj+iOaR7ufsqM+bqQ4uRvDxUwtp/qKWUuXfOLECk/p3nxcsCeRtApKkMFa17kNshnGKZenbSLn8rEYryn+KY9u7NkbNYjR+HTKoOkQvcqD/CH0LG0EWJ3qR5NTXo1mgWYs9/0cdFrFX5VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720068541; c=relaxed/simple;
	bh=WNPeAIq4l2609wBWgHZbYnzh2Yy0d58dcyDL2Aap0wY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=upnDU9IJNyo9lfVqRvPJmHx6JbggfqHP6nbwZx4bA/TEdhgoNQ8M2E74w3odYq9ZejpSkMLzjS/mIUIpsdHOkqBge6XkODrIsCe37/99uBK6zQ9HfhawrItrnMwaxlaS/Z+fZgV1jK933NHffubl400E2m/gCBhb6d4hZsOFsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.158.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1220741183
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.70 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id B617E9BF3D;
	Thu,  4 Jul 2024 12:39:01 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([27.148.194.70])
	by gateway-ssl-dep-67bdc54df-cz88j with ESMTP id d91f2d71dfe84a539426159c4b5b28ff for john.fastabend@gmail.com;
	Thu, 04 Jul 2024 12:39:05 CST
X-Transaction-ID: d91f2d71dfe84a539426159c4b5b28ff
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 27.148.194.70
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
Message-ID: <ae2569fa-f34a-40d6-9a03-33a455fbb9ea@chinatelecom.cn>
Date: Thu, 4 Jul 2024 12:39:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Ctyun AOneMail
To: john.fastabend@gmail.com, jakub@cloudflare.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
From: zhengguoyong <zhenggy@chinatelecom.cn>
Subject: [PATCH] bpf, sockmap: Use sk_rmem_schedule in bpf_tcp_ingress
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In sockmap redirect mode, when msg send to redir sk,
we use sk_wrmem_schedule to check memory is enough,

    tcp_bpf_sendmsg
        tcp_bpf_send_verdict
            bpf_tcp_ingress
                sk_wmem_schedule

but in bpf_tcp_ingress, the parameter sk means receiver,
so use sk_rmem_schedule here is more suitability.

Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
---
 net/ipv4/tcp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 53b0d62..88c58b5 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -49,7 +49,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sge = sk_msg_elem(msg, i);
 		size = (apply && apply_bytes < sge->length) ?
 			apply_bytes : sge->length;
-		if (!sk_wmem_schedule(sk, size)) {
+		if (!sk_rmem_schedule(sk, size)) {
 			if (!copied)
 				ret = -ENOMEM;
 			break;
-- 
1.8.3.1


