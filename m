Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C453EC07B
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 06:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhHNE3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Aug 2021 00:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhHNE27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Aug 2021 00:28:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539AFC0612A5
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 21:28:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bo18so18398810pjb.0
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 21:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iqwgQUcM7kXjxKmNPoKYxMsXr+XLcOB8+pWCUZkNe8=;
        b=fvOuwKoQ212hPJxpvu+eXB3l+9X9CTwdzNpm6t+0yppO7P2Ljyx4B/EmO1jpcR2QP7
         knVA8TnyhNcEUc9tIhW2IDYZ8950Jljd4/UHe9yusWxYZo974Pm0pME1hm6EWLKhhRS0
         qP6HEgf5D/92s22ehSAmz5RXzInWlQ4xTL/WSbZirekHKLIns2VtYFE8tRhs86P1szll
         DndmkUznlfGQzIdOvKnT1Kw0WipbuPvFQN47/fzlJSqpWCtPiUdVQKdCnx2VRmO3AkEI
         0Lp6rbuZLzt8yjXn2lRMwOI9H91Xy6WWqt8S6Qx90aB9e6Ls+p+sxMvhX3703LXt3Cl/
         wz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iqwgQUcM7kXjxKmNPoKYxMsXr+XLcOB8+pWCUZkNe8=;
        b=RHvsh/JPBtk7gcN09sEN+JeC0IzvxqOyGie/ej+HDWfqFVxpRz+BV+PZ257K9HJysZ
         jPj1geKw2d8V6YYF1cZ8Pzv17oS9jYk3iXT+xq0X05OGAJe2tVxgQUTN++1CQmpEvkQN
         5ReTiSf9VUZHZ3gjJ6jhMX2VN8z+0utv0DTx8NzVZ/mk6Jy9Qq/0x6HIP7QQ6dqSZVjO
         aXweBTp5WHfrArAdOmO1M8qCTScA07sD68aFA2T7RDL98foIvFgPnQWmG6wC0PIBZT6D
         f1LtID4YoLvsHl+SpafYXXgr2av2L1vhSVkW9nlktpntuqvZ8hZpeq0OVOC97+nFnZNG
         p/rQ==
X-Gm-Message-State: AOAM531gELpeq2zkDT3iHtPnb65LH999nT5L5Bua+jNrNYy8X7Gxjmrp
        +s+d+9Iu5cSuVHCyzbBAXRkLkQ==
X-Google-Smtp-Source: ABdhPJz1shFcNtkiOYR2XlqZ6VkjnLAxDcTtXHEXvByLTscUuYyQ1GhLzojS5ieOy9CVWNaH0T+s0g==
X-Received: by 2002:a63:7c5:: with SMTP id 188mr5331402pgh.211.1628915307941;
        Fri, 13 Aug 2021 21:28:27 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id q21sm4420492pgk.71.2021.08.13.21.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 21:28:27 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH bpf-next v6 5/5] selftest/bpf: add new tests in sockmap for unix stream to tcp.
Date:   Sat, 14 Aug 2021 04:27:50 +0000
Message-Id: <20210814042754.3351268-6-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210814042754.3351268-1-jiang.wang@bytedance.com>
References: <20210814042754.3351268-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two new test cases in sockmap tests, where unix stream is
redirected to tcp and vice versa.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 07ed8081f9ae..afa14fb66f08 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1884,7 +1884,7 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	xclose(p0);
 }
 
-static void udp_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
+static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
@@ -1899,9 +1899,13 @@ static void udp_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	skel->bss->test_ingress = false;
 	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				    REDIR_EGRESS);
+	inet_unix_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				    REDIR_EGRESS);
 	skel->bss->test_ingress = true;
 	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				    REDIR_INGRESS);
+	inet_unix_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				    REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
@@ -1961,7 +1965,7 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 
 }
 
-static void unix_udp_skb_redir_to_connected(struct test_sockmap_listen *skel,
+static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
@@ -1976,9 +1980,13 @@ static void unix_udp_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	skel->bss->test_ingress = false;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				     REDIR_EGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				     REDIR_EGRESS);
 	skel->bss->test_ingress = true;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				     REDIR_INGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				     REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
@@ -1994,8 +2002,8 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
-	udp_unix_skb_redir_to_connected(skel, map, family);
-	unix_udp_skb_redir_to_connected(skel, map, family);
+	inet_unix_skb_redir_to_connected(skel, map, family);
+	unix_inet_skb_redir_to_connected(skel, map, family);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.20.1

