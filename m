Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C568986E
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjBCMWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 07:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjBCMWV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 07:22:21 -0500
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 04:22:20 PST
Received: from mx.der-flo.net (mx.der-flo.net [IPv6:2001:67c:26f4:224::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB49DED7
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 04:22:20 -0800 (PST)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Florian Lehner <dev@der-flo.net>
Subject: [PATCH] bpf: fix typo in header for bpf_perf_prog_read_value
Date:   Fri,  3 Feb 2023 13:14:39 +0100
Message-Id: <20230203121439.25884-1-dev@der-flo.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix a simple typo in the documentation for bpf_perf_prog_read_value.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ba0f0cfb5e42..17afd2b35ee5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2801,7 +2801,7 @@ union bpf_attr {
  *
  * long bpf_perf_prog_read_value(struct bpf_perf_event_data *ctx, struct bpf_perf_event_value *buf, u32 buf_size)
  * 	Description
- * 		For en eBPF program attached to a perf event, retrieve the
+ * 		For an eBPF program attached to a perf event, retrieve the
  * 		value of the event counter associated to *ctx* and store it in
  * 		the structure pointed by *buf* and of size *buf_size*. Enabled
  * 		and running times are also stored in the structure (see
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ba0f0cfb5e42..17afd2b35ee5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2801,7 +2801,7 @@ union bpf_attr {
  *
  * long bpf_perf_prog_read_value(struct bpf_perf_event_data *ctx, struct bpf_perf_event_value *buf, u32 buf_size)
  * 	Description
- * 		For en eBPF program attached to a perf event, retrieve the
+ * 		For an eBPF program attached to a perf event, retrieve the
  * 		value of the event counter associated to *ctx* and store it in
  * 		the structure pointed by *buf* and of size *buf_size*. Enabled
  * 		and running times are also stored in the structure (see
-- 
2.30.2

