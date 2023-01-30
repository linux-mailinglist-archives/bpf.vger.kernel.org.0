Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A86807FD
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 09:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjA3I4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 03:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjA3I4r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 03:56:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C41A95A
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 00:56:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAC57B80EBC
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 08:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB95C433EF;
        Mon, 30 Jan 2023 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675069003;
        bh=oAa5xOSInzrlEWotfa9LU6UpMjmzjIkMkupmJOaQTik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lp88w8FYDWIm4wDwHW8U/QNnLAxPDzDRgveBT1GP2NAmLmp1aEbAV5nXS4Z752YrK
         QiZQwiHNLUhrweKqQnKvbhTcat2vvnenijJstIRRr58TpGo9fzQTyfURxgiGutk3EH
         qxo0L/GK6j4/c7SFoZO9qTPlisxP80OxZ2mK6x6+3SuH4tp06D5vnC9BT/D7GRfoHF
         JjLooh23o3yqIl58KB8FLk5az48bMTrKfFZxVx2KgqFH+SajfHWdjiLzIb1Y3VmSaO
         ShoXol/6ppAYhapzwgBRt5vjvsMumxu8o+7tGe5Ye09Hb97DFj6JJjSkP35HAspTqQ
         Cg/0kCfGN7zLg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv2 bpf-next 5/7] selftests/bpf: Load bpf_testmod for verifier test
Date:   Mon, 30 Jan 2023 09:55:38 +0100
Message-Id: <20230130085540.410638-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130085540.410638-1-jolsa@kernel.org>
References: <20230130085540.410638-1-jolsa@kernel.org>
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
 tools/testing/selftests/bpf/test_verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 8c808551dfd7..ec7bad90595a 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -45,6 +45,7 @@
 #include "bpf_util.h"
 #include "test_btf.h"
 #include "../../../include/linux/filter.h"
+#include "testing_helpers.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -1705,6 +1706,12 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 {
 	int i, passes = 0, errors = 0;
 
+	/* ensure previous instance of the module is unloaded */
+	unload_bpf_testmod(stderr, verbose);
+
+	if (load_bpf_testmod(stderr, verbose))
+		return EXIT_FAILURE;
+
 	for (i = from; i < to; i++) {
 		struct bpf_test *test = &tests[i];
 
@@ -1732,6 +1739,8 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 		}
 	}
 
+	unload_bpf_testmod(stderr, verbose);
+
 	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
 	       skips, errors);
 	return errors ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
2.39.1

