Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34C26AFF60
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCHHAj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCHHAa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:30 -0500
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166B7A1FDA
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:29 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vogKz0JNHm5eWBibnwNqFTuXn7m7ds2XLcVlTeori8=;
        b=cUKjpyxaJ2otDCdIEn9WYokaNRHD7XN/MoLv+FDDMDyv5iFQ4y6XbHcyqe1zc+PNBFxhBl
        5Gp5bH/XQEg7SYXzMH5OJNpUTpNasIz9PqdS7vSYjjBGjz5mDDlpTWIannNEnRGhosg8aU
        fkoz+PREt+KrKR5TLhbkMTx8huvY7KU=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 16/17] selftests/bpf: Check freeing sk->sk_local_storage with sk_local_storage->smap is NULL
Date:   Tue,  7 Mar 2023 22:59:35 -0800
Message-Id: <20230308065936.1550103-17-martin.lau@linux.dev>
In-Reply-To: <20230308065936.1550103-1-martin.lau@linux.dev>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch tweats the socket_bind bpf prog to test the
local_storage->smap == NULL case in the bpf_local_storage_free()
code path. The idea is to create the local_storage with
the sk_storage_map's selem first. Then add the sk_storage_map2's selem
and then delete the earlier sk_storeage_map's selem.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/progs/local_storage.c       | 29 +++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 19423ed862e3..797c81655a47 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -109,18 +109,17 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
-	int err;
 
 	if (pid != monitored_pid)
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0,
-				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0, 0);
 	if (!storage)
 		return 0;
 
+	sk_storage_result = -1;
 	if (storage->value != DUMMY_STORAGE_VALUE)
-		sk_storage_result = -1;
+		return 0;
 
 	/* This tests that we can associate multiple elements
 	 * with the local storage.
@@ -130,14 +129,26 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	if (!storage)
 		return 0;
 
-	err = bpf_sk_storage_delete(&sk_storage_map, sock->sk);
-	if (err)
+	if (bpf_sk_storage_delete(&sk_storage_map2, sock->sk))
 		return 0;
 
-	err = bpf_sk_storage_delete(&sk_storage_map2, sock->sk);
-	if (!err)
-		sk_storage_result = err;
+	storage = bpf_sk_storage_get(&sk_storage_map2, sock->sk, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0;
+
+	if (bpf_sk_storage_delete(&sk_storage_map, sock->sk))
+		return 0;
+
+	/* Ensure that the sk_storage_map is disconnected from the storage.
+	 * The storage memory should not be freed back to the
+	 * bpf_mem_alloc of the sk_bpf_storage_map because
+	 * sk_bpf_storage_map may have been gone.
+	 */
+	if (!sock->sk->sk_bpf_storage || sock->sk->sk_bpf_storage->smap)
+		return 0;
 
+	sk_storage_result = 0;
 	return 0;
 }
 
-- 
2.34.1

