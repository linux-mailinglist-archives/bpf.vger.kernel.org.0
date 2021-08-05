Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827C03E1ECF
	for <lists+bpf@lfdr.de>; Fri,  6 Aug 2021 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbhHEWfZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbhHEWfY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 18:35:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5275FC061798
        for <bpf@vger.kernel.org>; Thu,  5 Aug 2021 15:35:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso9425263pjb.5
        for <bpf@vger.kernel.org>; Thu, 05 Aug 2021 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bk6BNtpX2bsqpgJ2JxfChzF+Dc9XGh58ZUTm6AVu4O8=;
        b=jkPQQclQNlPFdS72CY978/hPr2qVc+s2HI7k3Zt5J5omsrvgJrSH1HD6Jlj3MJQuge
         Hu6oevksHhctJSP7LGkcFv4wyWcBgJT6QPpaQnaRUQ4FhqvebMSplo2jua+7qwJoQzwZ
         Mip06e6aahIM1xlclwJ0sxNnvwEExMtpIGz4CNCGnrVXP1C0MR9ZU4mj+xdv433qzDFZ
         aIpD6RgaD8pQnITX8PDXOBpxF91+rNzasXZzhJ83NVvAGP9peUHJfSrRAjFn/2XGtO7D
         8he1Wp3CmtH9tGUXRkWy1gAYOJdmigbLVm5IVFtpKloVbksmaKwuWgDXF9380pGsbfVU
         PLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bk6BNtpX2bsqpgJ2JxfChzF+Dc9XGh58ZUTm6AVu4O8=;
        b=SUeMynhMWFF+02BtNUAD3axqzt43tqLd442mdYe/RIBPaESVde4OfsHytPqg3M760U
         rf34svtouzbVjalTkqRKOlnlhxIIZbCjR45ovOl80QfXMxDmKaTeiviKKvWRQZOiBY4u
         0uBZhg/88JbSBh6wZWAf0YRnHgFwFJyV7iXCXzJeKue41hkat5wPUYnOE4wKTZ/Krb57
         +AzPqnZ1teuY7fkv/um2slrKP7oiuj9Ix+/NGn1ElEYcYiGS826ax7YMGL7QFRw1Ktpy
         kMPw4Ty84FJeKzZHx2VZsEimU9b6mQN7M1eiV1X03jY+vKPaIegOZ6g7dYXHfFhjucYu
         dOSQ==
X-Gm-Message-State: AOAM532VKi1POfRZ6Ldi7N48rITHiVDWFk3WJ3MB9h+T9fM0yWb1VS/m
        33idZf0SWueX14DWfkgdj0ijJQ==
X-Google-Smtp-Source: ABdhPJx+MU/IrGDBdxtcJdhIiCl5rl4cocHpzWp/j1JxUgHqkZ/hkVdHuXYGMoa6ZhUBgkpqnS9dSg==
X-Received: by 2002:a17:90a:9747:: with SMTP id i7mr6976516pjw.141.1628202908950;
        Thu, 05 Aug 2021 15:35:08 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id z8sm7931638pfa.113.2021.08.05.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:35:08 -0700 (PDT)
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
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 1/5] af_unix: add read_sock for stream socket types
Date:   Thu,  5 Aug 2021 22:34:38 +0000
Message-Id: <20210805223445.624330-2-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805223445.624330-1-jiang.wang@bytedance.com>
References: <20210805223445.624330-1-jiang.wang@bytedance.com>
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
index 256c4e31132e..c020ad0e8438 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -672,6 +672,8 @@ static int unix_dgram_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_dgram_recvmsg(struct socket *, struct msghdr *, size_t, int);
 static int unix_read_sock(struct sock *sk, read_descriptor_t *desc,
 			  sk_read_actor_t recv_actor);
+static int unix_stream_read_sock(struct sock *sk, read_descriptor_t *desc,
+				 sk_read_actor_t recv_actor);
 static int unix_dgram_connect(struct socket *, struct sockaddr *,
 			      int, int);
 static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
@@ -725,6 +727,7 @@ static const struct proto_ops unix_stream_ops = {
 	.shutdown =	unix_shutdown,
 	.sendmsg =	unix_stream_sendmsg,
 	.recvmsg =	unix_stream_recvmsg,
+	.read_sock =	unix_stream_read_sock,
 	.mmap =		sock_no_mmap,
 	.sendpage =	unix_stream_sendpage,
 	.splice_read =	unix_stream_splice_read,
@@ -2358,6 +2361,15 @@ struct unix_stream_read_state {
 	unsigned int splice_flags;
 };
 
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

