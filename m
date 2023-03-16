Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E468F6BC223
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 01:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCPAII (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 20:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjCPAIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 20:08:04 -0400
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [IPv6:2001:41d0:1004:224b::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26F9DE2D
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 17:07:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678925255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xGdSHEe2nzn1GtQdzfAeuGSG3462sq2SEamb/HqoPb4=;
        b=f1QteKkX/VHHMu+JL5dP0c95nRTUj0JVp+xTZ2jnSq/h3zqHQ5Va1sg1iC4Sf3E5HSERib
        kE8TNEQq7soYR/7T4ok0u3a/A1TMpsZ4zq4Rc0RrEu893VPhG3NYbj/poH02cuoYEDnAsb
        dIcsk7bvn9OYREQKiFV8AnsXGBTG1Z4=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] selftests/bpf: Use ASSERT_EQ instead ASSERT_OK for testing memcmp result
Date:   Wed, 15 Mar 2023 17:07:25 -0700
Message-Id: <20230316000726.1016773-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

In tcp_hdr_options test, it ensures the received tcp hdr option
and the sk local storage have the expected values. It uses memcmp
to check that. Testing the memcmp result with ASSERT_OK is confusing
because ASSERT_OK will print out the errno which is not set.
This patch uses ASSERT_EQ to check for 0 instead.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 5cf85d0f9827..13bcaeb028b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -151,7 +151,7 @@ static int check_hdr_opt(const struct bpf_test_option *exp,
 			 const struct bpf_test_option *act,
 			 const char *hdr_desc)
 {
-	if (!ASSERT_OK(memcmp(exp, act, sizeof(*exp)), hdr_desc)) {
+	if (!ASSERT_EQ(memcmp(exp, act, sizeof(*exp)), 0, hdr_desc)) {
 		print_option(exp, "expected: ");
 		print_option(act, "  actual: ");
 		return -1;
@@ -169,7 +169,7 @@ static int check_hdr_stg(const struct hdr_stg *exp, int fd,
 		  "map_lookup(hdr_stg_map_fd)"))
 		return -1;
 
-	if (!ASSERT_OK(memcmp(exp, &act, sizeof(*exp)), stg_desc)) {
+	if (!ASSERT_EQ(memcmp(exp, &act, sizeof(*exp)), 0, stg_desc)) {
 		print_hdr_stg(exp, "expected: ");
 		print_hdr_stg(&act, "  actual: ");
 		return -1;
-- 
2.34.1

