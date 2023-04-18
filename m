Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B1D6E6FAE
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 00:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjDRWxv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 18:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDRWxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 18:53:50 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEAA2D42
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:49 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63d30b08700so6402196b3a.1
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681858429; x=1684450429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHYD7Ii0uZ8iFkhB8mefjINCBY9zbBE8vUmPjDpaYGQ=;
        b=uuPcKJi53bn/XlLiyQbOPELMWsFEYWSpo849IpvL4Jph8+X8vOCRFVjLM/pj6OxjiF
         Co9yVsPjxTuKMG30Xo3R7iVtGjwida0HOeWhvW5czdFjNYw5zo+s5e+4U5LraYx8vPJH
         r9nLgjGGC5Z9mY5+zOGKMmpEuqA5Mq86SfQyeVDBsK1pwBh5JipBglQGgKZdj2Jo6Jug
         Zcz19Lp4tanaOlNy8Ri8CbqGDvfpHyPWhFxuhigzu2cheSZVfmIxN6MG+C30c7U08dGX
         hJIUwT/tDvT5tnScR8wx3CynS0chqnUedIgdhZHoJ1jSORLeiq1fz0/7pdEK3/Rg4vZQ
         nGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858429; x=1684450429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHYD7Ii0uZ8iFkhB8mefjINCBY9zbBE8vUmPjDpaYGQ=;
        b=bG0413WmWplcIhylRXBtbRyx3JxRIAn1YDGU8Apkmb0JMo7UFOfJ6WH3N5bvVrc/hm
         NjJ29JK2cVuuDzwe650PXjqCmC/gPV3tuw9toQg5iJpC53V0JFFjvZAy9kt5bbMz2tYL
         n7L+/lRZsYPZEU4v7pNAkdxwvv2+N03Tbx3p1GXFbDUeY6bQ5GGIuKe9rorA9HhufW9B
         mtTNL+uIz97ue3KZ99LABEOOBE4yEIYWBKjWmqTYL1gEX8qQSyLgnQOWRnCT4v2gzGE2
         LkC16cjTT/K8uq9CYpqcH836w4h/zx0VnkWI8rpVWeUpYo1+Pf2TKGHZ1Lez5xhlq2p0
         pTig==
X-Gm-Message-State: AAQBX9dYbtRk9vKVUR9KbGS0xxSgttaNFwN1qduPYM72exaVe2hRr3dL
        46CRwRapY+J9q4lXeuEUcRB3KQV6hX3zKwr9J08oflSvsqLsfESvj2d3x9lwfh1LUd5fXIuXrYD
        S+u8tw8ns7YsKjmU32uuQuNb0oargD+Ch+pYVJW5eafG51cM0OA==
X-Google-Smtp-Source: AKy350aT9o2xfqrmUv2SWQ8JU0Ui9wIqWbUxcSiHvfZX/QJBIOUbt0QgaPeH/cx0M5J/3m2pR2GRrCQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:4e48:b0:247:1e13:90e6 with SMTP id
 t8-20020a17090a4e4800b002471e1390e6mr105328pjl.2.1681858428635; Tue, 18 Apr
 2023 15:53:48 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:39 -0700
In-Reply-To: <20230418225343.553806-1-sdf@google.com>
Mime-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418225343.553806-3-sdf@google.com>
Subject: [PATCH bpf-next 2/6] selftests/bpf: Verify optval=NULL case
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure we get optlen exported instead of getting EFAULT.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 28 +++++++++++++++++++
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 12 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 60d952719d27..4512dd808c33 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -3,6 +3,7 @@
 #include "cgroup_helpers.h"
 
 #include <linux/tcp.h>
+#include <linux/netlink.h>
 #include "sockopt_sk.skel.h"
 
 #ifndef SOL_TCP
@@ -183,6 +184,33 @@ static int getsetsockopt(void)
 		goto err;
 	}
 
+	/* optval=NULL case is handled correctly */
+
+	close(fd);
+	fd = socket(AF_NETLINK, SOCK_RAW, 0);
+	if (fd < 0) {
+		log_err("Failed to create AF_NETLINK socket");
+		return -1;
+	}
+
+	buf.u32 = 1;
+	optlen = sizeof(__u32);
+	err = setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &buf, optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(NETLINK_ADD_MEMBERSHIP) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+
+	optlen = 0;
+	err = getsockopt(fd, SOL_NETLINK, NETLINK_LIST_MEMBERSHIPS, NULL, &optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(NETLINK_LIST_MEMBERSHIPS) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+	ASSERT_EQ(optlen, 4, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
+
 	free(big_buf);
 	close(fd);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index c8d810010a94..fe1df4cd206e 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -32,6 +32,12 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval_end = ctx->optval_end;
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
@@ -131,6 +137,12 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval_end = ctx->optval_end;
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
-- 
2.40.0.634.g4ca3ef3211-goog

