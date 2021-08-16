Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A83EDD96
	for <lists+bpf@lfdr.de>; Mon, 16 Aug 2021 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhHPTGN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhHPTEN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 15:04:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8584AC0613CF
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 12:03:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u15so6346333plg.13
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6SJ/0BzbhcL/AQI/DdNhZ/xDFhfJbOcXEvb92Bi/wU=;
        b=YhKFTIVMdZXol9+WB6zelB3uoE23mZzapWVMgXpFtnHW1tBSZsbvGaOxeMLFXUO6v/
         ZvnBdWAzGkWc+IxojctUGA+IHvWSWGOpB8QaS5uIfmGCbzY7fMXoJ4RQOea9huM6pTPb
         xyStPpjIp4DtwZxwTT9X++Qc/r0y11cB7qSOOL9atFuPBUgjmjXqk+RZVAu3++Ntnksf
         poEq2m2M2Gkv14RK8CX7jShnGTkm0aiTLAYQB83c7om8BJXlTRL0p8nd2vYjvPQ+OQ7s
         DTF1LRGaN7ZEQVKzXzqHVgm6rYyUr56o3doUzSfhcZ99c3jLAKQOmSGzqpyxQq3r1Qtm
         QJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6SJ/0BzbhcL/AQI/DdNhZ/xDFhfJbOcXEvb92Bi/wU=;
        b=WX4D/uM6R+N8RJpNdELco06m8X+vf9N38T7y7k7FURFJ/SuxGzawNXvK+XTw5HovBx
         leN/bXON/TAPZiZ0+nJYqXJoB8ZqsAn7I9akFKAZooAaWXQ3wPpgpWzihpIgQLYK9K+E
         /c0HZ0KP+MCOLqDY8Vc01XWA8magjRHivBrqcm67nEdkyQOCndHeeTAQ11NF7vKkk8Vv
         wD5yRiq6uogiTKU2upCuLUHs74Q0T9joEN14bikClSnfnP19vHl1+RwqyeNVQPHr7byX
         rpX69GGjIwdOrgh4KNRuoOyQ8ZGGl+IyNEKRhsG2y5s5YCyaaKxR037CxwmjaSiekXRi
         YmzQ==
X-Gm-Message-State: AOAM5338PAlApMJE3e2yQJBaAzfNnqAr7044jVyCDe+3BZqWj/VQdTuH
        cwby6DRRMzQ5SHx6jjsCfQ2MuQ==
X-Google-Smtp-Source: ABdhPJzbu/LrHemYjYM2HNEniQCk3UB1HBWNS3nzBqdpM0QeZp5FewgF1aidGa4Et1T6LevOsD6sAA==
X-Received: by 2002:a17:90a:ce0a:: with SMTP id f10mr155817pju.52.1629140621130;
        Mon, 16 Aug 2021 12:03:41 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id t30sm175845pgl.47.2021.08.16.12.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:03:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 1/5] af_unix: add read_sock for stream socket types
Date:   Mon, 16 Aug 2021 19:03:20 +0000
Message-Id: <20210816190327.2739291-2-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210816190327.2739291-1-jiang.wang@bytedance.com>
References: <20210816190327.2739291-1-jiang.wang@bytedance.com>
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

