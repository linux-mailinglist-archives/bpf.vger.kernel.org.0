Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9802F679C0F
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjAXOhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjAXOhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:37:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3EC47EFC
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 06:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9745F6122D
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 14:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369A1C433EF;
        Tue, 24 Jan 2023 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674571023;
        bh=qEk6OSwmjSdv8HNX1Fw7nPPDtf0v4WB0NU2yw1tziJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENEHNm+YNe++LN41M2PihcP3MW6IYwlFbMGjZzG87jwyb/E0pZKImmavh1MuXYHnF
         EcfJPF/MkjY6sXxAQZc6SdR4SltEcVBcNh/xNVr4raXcylBf8pkxEKjReEQUY4Usih
         FF8HIJDeiFmSWHzGl8LBDJTv/6QPu1r0Uxe5dsXFGWjFR9UqmFUJBrjWPl/zW2QKaa
         u6FyJoHWmqdoEp7wXpfrTwzNqBqGIbZsVxmvTDSRzSk9JFNh0jHgegFpO5+I4Nbc75
         XVvVXmGJA7Y+NoHnzVnVtCj63Bny9TRk7ySV7KA0EaOHe6Ww6bXUR+8qniS3qdweGh
         GhUdOTkdXAn6Q==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: Load bpf_testmod for verifier test
Date:   Tue, 24 Jan 2023 15:36:24 +0100
Message-Id: <20230124143626.250719-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124143626.250719-1-jolsa@kernel.org>
References: <20230124143626.250719-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Loading bpf_testmod kernel module for verifier test. We will
move all the tests kfuncs into bpf_testmod in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 8c808551dfd7..298accb082c8 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -45,6 +45,7 @@
 #include "bpf_util.h"
 #include "test_btf.h"
 #include "../../../include/linux/filter.h"
+#include "testing_helpers.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -1705,6 +1706,9 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 {
 	int i, passes = 0, errors = 0;
 
+	if (load_bpf_testmod(stderr, verbose))
+		return EXIT_FAILURE;
+
 	for (i = from; i < to; i++) {
 		struct bpf_test *test = &tests[i];
 
@@ -1732,6 +1736,8 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 		}
 	}
 
+	unload_bpf_testmod(stderr, verbose);
+
 	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
 	       skips, errors);
 	return errors ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
2.39.1

