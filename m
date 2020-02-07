Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D83B1555E4
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2020 11:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgBGKis (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 05:38:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35030 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgBGKis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 05:38:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so2187461wmb.0
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 02:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8xqc0jfB/yBaWPmmchEBBglZJ/VBe1jDOf+DDjAxBY=;
        b=cz7aL+v4INeA1E2fIe7snXWsd4QN9xku06qy7gADtcdEa06Uorj+7dCZeUIRrsawMw
         dPXGYNx1wGCDHd2LMtMlBFmI9719CjcoyLM1UlhuuTbh4/Eca14yaUxv9dsH55GUiAwj
         ZAbKsmkYmzELw251CF1qPzBN1rBboopH8QbRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8xqc0jfB/yBaWPmmchEBBglZJ/VBe1jDOf+DDjAxBY=;
        b=C15aWE9pKuK7c6K0qItuM6EN+T9Amo50zxREBXW67W5iB64cg61LhCgdVhIjXCuJyD
         zdBHjKKab5SopLo1MM9WUD/gsviDzGe3IrLA3L+A/TdxZv24qGbAOkG5Q8cvsSKmmJr7
         ECMCUijRcb91vm+qsJgVnjUerQm13k7YcX9opT7C4v47z+uZ045b45DjWe3EzUx3utPF
         3vp0LrZuqHdx2fOPEspxQej0MNuVDdMveW3uk4TzmG2jBBp8Ms1L+AKW5j51drvUTePE
         mfB9ny0tb3MmXgWDTYxhoY8zCXNNf/nn6hTel9spqLSCYFE3bSDRqBDm548rbv+pZYdE
         cctw==
X-Gm-Message-State: APjAAAXkz5CqGrzDr6Phsw3GPMA5cj8w0NL6VVUDwNJPIr/A4tcifx/T
        MhOl6VP0yBOldSaXKd5wljPSRA==
X-Google-Smtp-Source: APXvYqw+8ADR+o4Vfv+8/hLUJZraJ/nnFhfymHMG+6r0neZCbqeIRWCE2ig3qQ7Zr6QlX0jflHg4Qw==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr3810981wml.183.1581071925982;
        Fri, 07 Feb 2020 02:38:45 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:28a5:3485:3116:20f5])
        by smtp.gmail.com with ESMTPSA id k16sm2777887wru.0.2020.02.07.02.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 02:38:45 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: sockmap: check update requirements after locking
Date:   Fri,  7 Feb 2020 10:37:12 +0000
Message-Id: <20200207103713.28175-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's currently possible to insert sockets in unexpected states into
a sockmap, due to a TOCTTOU when updating the map from a syscall.
sock_map_update_elem checks that sk->sk_state == TCP_ESTABLISHED,
locks the socket and then calls sock_map_update_common. At this
point, the socket may have transitioned into another state, and
the earlier assumptions don't hold anymore. Crucially, it's
conceivable (though very unlikely) that a socket has become unhashed.
This breaks the sockmap's assumption that it will get a callback
via sk->sk_prot->unhash.

Fix this by checking the (fixed) sk_type and sk_protocol without the
lock, followed by a locked check of sk_state.

Unfortunately it's not possible to push the check down into
sock_(map|hash)_update_common, since BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
run before the socket has transitioned from TCP_SYN_RECV into
TCP_ESTABLISHED.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
---
 net/core/sock_map.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 8998e356f423..36a2433e183f 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -416,14 +416,16 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!sock_map_sk_is_suitable(sk) ||
-	    sk->sk_state != TCP_ESTABLISHED) {
+	if (!sock_map_sk_is_suitable(sk)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
 	sock_map_sk_acquire(sk);
-	ret = sock_map_update_common(map, idx, sk, flags);
+	if (sk->sk_state != TCP_ESTABLISHED)
+		ret = -EOPNOTSUPP;
+	else
+		ret = sock_map_update_common(map, idx, sk, flags);
 	sock_map_sk_release(sk);
 out:
 	fput(sock->file);
@@ -739,14 +741,16 @@ static int sock_hash_update_elem(struct bpf_map *map, void *key,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!sock_map_sk_is_suitable(sk) ||
-	    sk->sk_state != TCP_ESTABLISHED) {
+	if (!sock_map_sk_is_suitable(sk)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
 	sock_map_sk_acquire(sk);
-	ret = sock_hash_update_common(map, key, sk, flags);
+	if (sk->sk_state != TCP_ESTABLISHED)
+		ret = -EOPNOTSUPP;
+	else
+		ret = sock_hash_update_common(map, key, sk, flags);
 	sock_map_sk_release(sk);
 out:
 	fput(sock->file);
-- 
2.20.1

