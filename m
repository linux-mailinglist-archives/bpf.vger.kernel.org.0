Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CEF5E9D86
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiIZJZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 05:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiIZJYX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 05:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62AA43E53
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664184210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s2lHTvZs+V7Gx9PPCaD6yMDf7ghWzItrMiu0Sn+royw=;
        b=LoYE2jvQkccjU7rrAbgudpwysv5esnMtnKmDBypN9JFsik+q0caQCUn4ENMkJie1STMQTB
        09VB81krksIDh9rhyRfDuTO61Q8NTcv1rcWuhz+p1mf0CX1jCbIgaVfyWDX21EzmUetmSf
        rXxuZ/xHDMoutVV7pa4zTJMrUpCZ0cU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-fIDBChgdNhahNk1stzT04Q-1; Mon, 26 Sep 2022 05:23:23 -0400
X-MC-Unique: fIDBChgdNhahNk1stzT04Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C9A085A59D;
        Mon, 26 Sep 2022 09:23:23 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EA94492CA4;
        Mon, 26 Sep 2022 09:23:22 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, liuhangbin@gmail.com,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH bpf-next] selftests: bpf: test_kmod.sh: fix passing arguments via function
Date:   Mon, 26 Sep 2022 12:23:20 +0300
Message-Id: <20220926092320.564631-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the tests are run in a function $@ there actually contains
function arguments, not the script ones.

Pass "$@" to the function as well.

Fixes: 272d1f4cfa3c ("selftests: bpf: test_kmod.sh: Pass parameters to the module")
Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---

I have to admit that I messed up with testing of the last test_kmod.sh
patch and it paid immediatly. Feeling really ashamed.

---
 tools/testing/selftests/bpf/test_kmod.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmod.sh b/tools/testing/selftests/bpf/test_kmod.sh
index d4a4279c0181..50dca53ac536 100755
--- a/tools/testing/selftests/bpf/test_kmod.sh
+++ b/tools/testing/selftests/bpf/test_kmod.sh
@@ -29,6 +29,7 @@ test_run()
 	sysctl -w net.core.bpf_jit_harden=$2 2>&1 > /dev/null
 
 	echo "[ JIT enabled:$1 hardened:$2 ]"
+	shift 2
 	dmesg -C
 	if [ -f ${OUTPUT}/lib/test_bpf.ko ]; then
 		insmod ${OUTPUT}/lib/test_bpf.ko "$@" 2> /dev/null
@@ -64,9 +65,9 @@ test_restore()
 
 rc=0
 test_save
-test_run 0 0
-test_run 1 0
-test_run 1 1
-test_run 1 2
+test_run 0 0 "$@"
+test_run 1 0 "$@"
+test_run 1 1 "$@"
+test_run 1 2 "$@"
 test_restore
 exit $rc
-- 
2.37.3

