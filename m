Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF04421AA0
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 01:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhJDX1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 19:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhJDX1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Oct 2021 19:27:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E154C06174E
        for <bpf@vger.kernel.org>; Mon,  4 Oct 2021 16:25:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so18041916pgr.11
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVhO5Cff8ywinpP+5fBDLr67Q38pdXZFNpJlJzlXkJE=;
        b=GXTR3mgVoyk+LINwkQwxywsnzIcITh6CzQUvyA1sOKgsBLTkEOFhViJacv9lFs+uMD
         h+ZwlEZLKD7yS4/UfvZfC1VmewlF55C63tHv9ayQXwJO8EInNqUGkRHf93sqUG3FROdS
         LwTDkbOI71SA48KkDKTZrW27UzM/WjyMzPca2SwbB6ZjIukUxccHLdpKP4JyN7q9Ltme
         T5ZI5V+FgP4xKO0h7UgfBE4O5LJ7+oB/I7e10Enp87pG1IWrQvYc0+7HVn/cbutq+BNm
         u6XDKyaInGD5M6+xg1pBHjF/GzB46rnEGQ0QCtS01R3yIVR3OPLMASsSyvKfsKsSJ33p
         ewKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVhO5Cff8ywinpP+5fBDLr67Q38pdXZFNpJlJzlXkJE=;
        b=1RTPG5wnTz5ef+ZLO3z4LRoNoTUgXNIVlH1wqSmJWRwP+vA7JZpFFGyY3Z7glRZ3QT
         8vzz9xSHDPfJ5FujWkiP1FhTru2hF/9RaxKjUaqkq9SxD8vhClmh8pm+afLtc2tradyY
         KvkNfcjNmkLAaQhaRpsFTEyqsRO1ZCidXwqYr3v+1+8wRc79ZY8ocn48KdR7eeKtY5/+
         +nKgqf31Yc9ncaKVBOQz5SsoFPt7BFJY/AhVM2hKn32oNg6bMhz+QdLTJpFU/s4Jtl+y
         YKeHeqGhm1A0BbRn+JgDgBzFFw68b52vQLHnFRjiUe5Yy88JkQ+xtndbjSpZ9+Disg4/
         izqw==
X-Gm-Message-State: AOAM531NIxtBZn7EaIrj6ziyFOThsh0mW2poTfx2rsn7zYOr5f8mjS7O
        FDiNuHxx56VUb2zFc7nTQb1YB/7e72N2oQ==
X-Google-Smtp-Source: ABdhPJwJGPAc7usCDf8FZyr5sAz4GPe1/1fOJFubRDrEMSwdtmFeNvwS0U2MWm33Tus//mbeEHs+PA==
X-Received: by 2002:aa7:88d6:0:b0:44c:5c0b:c8a8 with SMTP id k22-20020aa788d6000000b0044c5c0bc8a8mr8955357pff.76.1633389955702;
        Mon, 04 Oct 2021 16:25:55 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id s68sm14096927pfb.192.2021.10.04.16.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 16:25:55 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     cong.wang@bytedance.com, Casey Schaufler <casey@schaufler-ca.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rao Shoaib <Rao.Shoaib@oracle.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1] unix: fix an issue in unix_shutdown causing the other end read/write failures
Date:   Mon,  4 Oct 2021 23:25:28 +0000
Message-Id: <20211004232530.2377085-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
sets unix domain socket peer state to TCP_CLOSE
in unix_shutdown. This could happen when the local end is shutdown
but the other end is not. Then the other end will get read or write
failures which is not expected.

Fix the issue by setting the local state to shutdown.

Fixes: 94531cfcbe79 (af_unix: Add unix_stream_proto for sockmap)
Suggested-by: Cong Wang <cong.wang@bytedance.com>
Reported-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 net/unix/af_unix.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index efac5989edb5..0878ab86597b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2882,6 +2882,9 @@ static int unix_shutdown(struct socket *sock, int mode)
 
 	unix_state_lock(sk);
 	sk->sk_shutdown |= mode;
+	if ((sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) &&
+	    mode == SHUTDOWN_MASK)
+		sk->sk_state = TCP_CLOSE;
 	other = unix_peer(sk);
 	if (other)
 		sock_hold(other);
@@ -2904,12 +2907,10 @@ static int unix_shutdown(struct socket *sock, int mode)
 		other->sk_shutdown |= peer_mode;
 		unix_state_unlock(other);
 		other->sk_state_change(other);
-		if (peer_mode == SHUTDOWN_MASK) {
+		if (peer_mode == SHUTDOWN_MASK)
 			sk_wake_async(other, SOCK_WAKE_WAITD, POLL_HUP);
-			other->sk_state = TCP_CLOSE;
-		} else if (peer_mode & RCV_SHUTDOWN) {
+		else if (peer_mode & RCV_SHUTDOWN)
 			sk_wake_async(other, SOCK_WAKE_WAITD, POLL_IN);
-		}
 	}
 	if (other)
 		sock_put(other);
-- 
2.20.1

