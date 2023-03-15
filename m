Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5891E6BBAAD
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 18:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCORQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCORQJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 13:16:09 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88475867FB
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 10:16:06 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 048482407C2
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1678900565; bh=T7oQUm+ypc/roZDz1Lt9WOrkLZYufjpjFKViVcE1cQY=;
        h=From:To:Cc:Subject:Date:From;
        b=C3sm/WA59iZI1PZBTwNJZWT3M2/y7fy9w0nTeOuVW0e5joy7XsaeCZYkU/3zv4GIW
         lx0p0nOO6mCP2LQPd4Kx1PIEsAj7LFmVJfRM8JJEZuJh/VNk8bqfQLZ6cZDkIsH3xs
         0CTvjj1NyT4G9hDN6en83S08hv3SdkYOUQxgTXCqzIM7/GfxBhXJSkxfRU8OZA/xKn
         xtK36wrWOX8kHF9MCPNpP+6CI67NIrYmrBrV5Gpq2KhoI4/vJwXyNDy7+oS/Ns307L
         52xgh+EI2UkFw3RoCPQDlCOpwWxdd4btS3zxdDme9yX5Y72QT5CxhFX4Nq2e+4bQ9S
         faI/W4hOZiPJg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PcH9J0YxWz9rxM;
        Wed, 15 Mar 2023 18:16:04 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH bpf-next] libbpf: Ignore warnings about "inefficient alignment"
Date:   Wed, 15 Mar 2023 17:15:50 +0000
Message-Id: <20230315171550.1551603-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some consumers of libbpf compile the code base with different warnings
enabled. In a report for perf, for example, -Wpacked was set which
caused warnings about "inefficient alignment" to be emitted on a subset
of supported architectures.
With this change we silence specifically those warnings, as we
intentionally worked with packed structs.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Link: https://lore.kernel.org/bpf/CA+G9fYtBnwxAWXi2+GyNByApxnf_DtP1-6+_zOKAdJKnJBexjg@mail.gmail.com/
Fixes: 1eebcb60633f ("libbpf: Implement basic zip archive parsing support")
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/zip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
index f561aa..3f26d62 100644
--- a/tools/lib/bpf/zip.c
+++ b/tools/lib/bpf/zip.c
@@ -16,6 +16,10 @@
 #include "libbpf_internal.h"
 #include "zip.h"
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpacked"
+#pragma GCC diagnostic ignored "-Wattributes"
+
 /* Specification of ZIP file format can be found here:
  * https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT
  * For a high level overview of the structure of a ZIP file see
@@ -119,6 +123,8 @@ struct local_file_header {
 	__u16 extra_field_length;
 } __attribute__((packed));
 
+#pragma GCC diagnostic pop
+
 struct zip_archive {
 	void *data;
 	__u32 size;
-- 
2.34.1

