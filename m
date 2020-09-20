Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0875B271352
	for <lists+bpf@lfdr.de>; Sun, 20 Sep 2020 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgITK1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Sep 2020 06:27:47 -0400
Received: from mx.der-flo.net ([193.160.39.236]:44384 "EHLO mx.der-flo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgITK1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Sep 2020 06:27:47 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 06:27:47 EDT
Received: by mx.der-flo.net (Postfix, from userid 110)
        id C338C43FED; Sun, 20 Sep 2020 12:20:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.der-flo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from linux.home (unknown [IPv6:2a02:1203:ecb0:3930:146b:10e2:afb5:be30])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 2B85843EE3;
        Sun, 20 Sep 2020 12:20:19 +0200 (CEST)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next] bpf: lift hashtab key_size limit
Date:   Sun, 20 Sep 2020 12:19:35 +0200
Message-Id: <20200920101935.57378-1-dev@der-flo.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently key_size of hashtab is limited to MAX_BPF_STACK.

As the key of hashtab can also be a value from a per cpu map it can be
larger than MAX_BPF_STACK.
---
 kernel/bpf/hashtab.c                    | 16 +++++-----------
 tools/testing/selftests/bpf/test_maps.c |  2 +-
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index fe0e06284..fcac16cd4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -390,17 +390,11 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	    attr->value_size == 0)
 		return -EINVAL;
 
-	if (attr->key_size > MAX_BPF_STACK)
-		/* eBPF programs initialize keys on stack, so they cannot be
-		 * larger than max stack size
-		 */
-		return -E2BIG;
-
-	if (attr->value_size >= KMALLOC_MAX_SIZE -
-	    MAX_BPF_STACK - sizeof(struct htab_elem))
-		/* if value_size is bigger, the user space won't be able to
-		 * access the elements via bpf syscall. This check also makes
-		 * sure that the elem_size doesn't overflow and it's
+	if ((attr->key_size + attr->value_size) >= KMALLOC_MAX_SIZE -
+	    sizeof(struct htab_elem))
+		/* if key_size + value_size is bigger, the user space won't be
+		 * able to access the elements via bpf syscall. This check
+		 * also makes sure that the elem_size doesn't overflow and it's
 		 * kmalloc-able later in htab_map_update_elem()
 		 */
 		return -E2BIG;
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 754cf6117..9b2a096f0 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1225,7 +1225,7 @@ static void test_map_large(void)
 {
 	struct bigkey {
 		int a;
-		char b[116];
+		char b[4096];
 		long long c;
 	} key;
 	int fd, i, value;
-- 
2.26.2

