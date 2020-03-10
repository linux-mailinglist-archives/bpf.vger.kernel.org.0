Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE5180559
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCJRrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 13:47:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41419 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgCJRrj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14so3364996wrt.8
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XC8IKQ74vPv+UfMSye3u7t/54ed4ZAgOtHUPCB0KwJI=;
        b=zIJySxHvPp+R2UTCXnHsTySARcEwLDoOm3+7DSZAUoGamSnvk4Z4m/33Y22UZhZvPi
         HRjm7o/EH8TQJqeSEacRldso2oXzc0+fB9bwfzz2X23lp9AsuVD2eG/y8ojk15LjQWKQ
         hd+gxzQvdId2G79HdN+YP70IurA1njyIw1/oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XC8IKQ74vPv+UfMSye3u7t/54ed4ZAgOtHUPCB0KwJI=;
        b=snZupFdGqVL5qKLD/JmXyH2CXZQQnH1mdMhRw5ukMJGelxq0kkhhmBBlMAN+cSr55y
         6oZM4bQpw4sEp3AWSdmS0XBXEJpf00mPC09Je7nB+K8ozOoF3fJbA9TaH7QoYlOLNcrn
         8CG07gdlS9eH3t8tKqt5dQNMt0D4WZGk5N3+B0w8dHhGTVZhWvrW5ROn4xscz/ICunRf
         ypWBysrnQ83Rl8MhxL3QfNoG1CvkjLV9uZGopdtIpKn6R3t9/t3l8UhZaI+IFZFPQB6+
         jzWIVSZAH2sdOGZG1fsyXfXgUfpmjpT9Hir3Kv3yTl/Dyw3HBvlAbtT9waLU7Ov+tN9r
         Tzvg==
X-Gm-Message-State: ANhLgQ2wCCtUGZf0t0HWcbijFdLkGBWpGmELMO/l3sQghY+cMzKujWOW
        05wM6tgFCGQ5h0TW0vdPan+AQA==
X-Google-Smtp-Source: ADFU+vsjj2OPEOgFyNbWcbNMGg6PA4mx+5cRmNV6PwJWCtb3+fuf9br0wM59YIl8VXByekmeR/p31w==
X-Received: by 2002:adf:a3c9:: with SMTP id m9mr26515647wrb.349.1583862456912;
        Tue, 10 Mar 2020 10:47:36 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:9494:775c:e7b6:e690])
        by smtp.gmail.com with ESMTPSA id k4sm9118691wrx.27.2020.03.10.10.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:47:34 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] bpf: sockmap, sockhash: return file descriptors from privileged lookup
Date:   Tue, 10 Mar 2020 17:47:10 +0000
Message-Id: <20200310174711.7490-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310174711.7490-1-lmb@cloudflare.com>
References: <20200310174711.7490-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow callers with CAP_NET_ADMIN to retrieve file descriptors from a
sockmap and sockhash. O_CLOEXEC is enforced on all fds.

Without this, it's difficult to resize or otherwise rebuild existing
sockmap or sockhashes.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 03e04426cd21..3228936aa31e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -347,12 +347,31 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
 static int __sock_map_copy_value(struct bpf_map *map, struct sock *sk,
 				 void *value)
 {
+	struct file *file;
+	int fd;
+
 	switch (map->value_size) {
 	case sizeof(u64):
 		sock_gen_cookie(sk);
 		*(u64 *)value = atomic64_read(&sk->sk_cookie);
 		return 0;
 
+	case sizeof(u32):
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		fd = get_unused_fd_flags(O_CLOEXEC);
+		if (unlikely(fd < 0))
+			return fd;
+
+		read_lock_bh(&sk->sk_callback_lock);
+		file = get_file(sk->sk_socket->file);
+		read_unlock_bh(&sk->sk_callback_lock);
+
+		fd_install(fd, file);
+		*(u32 *)value = fd;
+		return 0;
+
 	default:
 		return -ENOSPC;
 	}
-- 
2.20.1

