Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516DC3EC06C
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 06:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhHNE2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Aug 2021 00:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhHNE2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Aug 2021 00:28:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C7C061757
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 21:28:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c17so9269580plz.2
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 21:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6SJ/0BzbhcL/AQI/DdNhZ/xDFhfJbOcXEvb92Bi/wU=;
        b=qmk3PVBzAY/iEPc9SONxP6krNMjaNMuYbuj0rt4sFXcmNzKhqH8Acpy2cluEclN/Bi
         bqoc+4cpnTzRGT62zR7KBkrWLC0thDPTp9CylOAuifoQIzdW1h25ZZbJwEE+CBJswf1B
         yAoCPR0QbzMsW2vm32D1AFfc/+EVDN+f7im84P/Xcyd5cW8WYFWonL1takYMbg7G0Tft
         LrCjdM2wI+NbYx//BYGWtNYkW4pcUVv0Y4xTtLeqeBiGNDBCpeDvPcnpeLzhkH9XR5A0
         c6hybRh0wz5TDqFd+qYeR5dCOmjPkC1OGj+ApTLRspU5DidK4p9AeVmXO4X1OEZHsWZh
         Vtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6SJ/0BzbhcL/AQI/DdNhZ/xDFhfJbOcXEvb92Bi/wU=;
        b=fRUDvu1gnS54IWr92Xl8VZYUvzPDNGzHsc1xYHYvX5kaN8tGpUuxIfVhUoNzYXeTBo
         l0C9DcHbWpwLlFSNkW/tnl5az4UCl2NGPNsW8hqyiUZKFcRoMVfB/qvgrGGAuOQdGGPW
         6OPaO/U7s8IYepAa446tI9AV1vT78UArrYA5yJQyDUtUKZ4jrs1kGu0WcwnpnDoR5zHL
         Y7dF7fw2eMmO6bms1ipuBReMbetFlR0b+skD8vxTbH1CxMlWqkGdhSntCVLTUmvMKysf
         W1uK9E1Wv3wZVeqjSZ+EguIhhYLivbzEfU8c1dueRU9jhKGjGwVWF3fvn3JaY4b9QyvO
         ThrQ==
X-Gm-Message-State: AOAM532DGwfGTsrIddBWsOQEtNGlIBUYarUrRqS1yrfzR/XuExKzVBjh
        qRHXvNjZpdqjkLmVYjKBoakFrw==
X-Google-Smtp-Source: ABdhPJx8mrakcQoTylEwRyECS8AgNyqu79qApoz4nSwtdQp4MeVoda2piDCjBcoGPAJYR5PvT8XC2g==
X-Received: by 2002:a17:90a:ff13:: with SMTP id ce19mr5652135pjb.114.1628915287934;
        Fri, 13 Aug 2021 21:28:07 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id q21sm4420492pgk.71.2021.08.13.21.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 21:28:07 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rao Shoaib <rao.shoaib@oracle.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 1/5] af_unix: add read_sock for stream socket types
Date:   Sat, 14 Aug 2021 04:27:46 +0000
Message-Id: <20210814042754.3351268-2-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210814042754.3351268-1-jiang.wang@bytedance.com>
References: <20210814042754.3351268-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To support sockmap for af_unix stream type, implement
read_sock, which is similar to the read_sock for unix
dgram sockets.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
---
 net/unix/af_unix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1c2224f05b51..31061304ccf2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -678,6 +678,8 @@ static int unix_dgram_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_dgram_recvmsg(struct socket *, struct msghdr *, size_t, int);
 static int unix_read_sock(struct sock *sk, read_descriptor_t *desc,
 			  sk_read_actor_t recv_actor);
+static int unix_stream_read_sock(struct sock *sk, read_descriptor_t *desc,
+				 sk_read_actor_t recv_actor);
 static int unix_dgram_connect(struct socket *, struct sockaddr *,
 			      int, int);
 static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
@@ -731,6 +733,7 @@ static const struct proto_ops unix_stream_ops = {
 	.shutdown =	unix_shutdown,
 	.sendmsg =	unix_stream_sendmsg,
 	.recvmsg =	unix_stream_recvmsg,
+	.read_sock =	unix_stream_read_sock,
 	.mmap =		sock_no_mmap,
 	.sendpage =	unix_stream_sendpage,
 	.splice_read =	unix_stream_splice_read,
@@ -2490,6 +2493,15 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 }
 #endif
 
+static int unix_stream_read_sock(struct sock *sk, read_descriptor_t *desc,
+				 sk_read_actor_t recv_actor)
+{
+	if (unlikely(sk->sk_state != TCP_ESTABLISHED))
+		return -ENOTCONN;
+
+	return unix_read_sock(sk, desc, recv_actor);
+}
+
 static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				    bool freezable)
 {
-- 
2.20.1

