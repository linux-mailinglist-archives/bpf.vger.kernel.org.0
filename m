Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D298689F1A
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjBCQYU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjBCQYS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:24:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8AA6B8C
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:24:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B5BBB82AEF
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6455DC433EF;
        Fri,  3 Feb 2023 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441454;
        bh=8Ealxpb4bLu/iMD2rD/Lif0uou5Lhx0WZHzXtE9hLm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQzoKLO6n++3LRzAhO48ZzbfTtPyMaaf5CYeTlqCi4nKbTWRFMvxK5uGFQkpkqQch
         s7MnJBMCw7RcryJ0DU4qIDWps2T+uH9feeWJ785hld8+U5gRW6vTylJp0djsIllCdP
         pQS5CTw+i4OG9OpGs71Z3K5/FGEYGh3Cc3xQdTm6YwpBdZPi+RRBx08kll1NHgqpH9
         9daEEmgCMalFP75pVJc8w3xU8fS+T1pZNamgJSTH8wnlHtgsc/ajOItAOWQnQA2GM4
         xMHlx3eJje/Uf3PMp09NwgPWHa0OVH1J4MeszWHLmjFwOH1fF0P2JsqdTvEbYx8sU5
         3crn1rgHRlQMA==
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
Subject: [PATCHv3 bpf-next 3/9] selftests/bpf: Use only stdout in un/load_bpf_testmod functions
Date:   Fri,  3 Feb 2023 17:23:30 +0100
Message-Id: <20230203162336.608323-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203162336.608323-1-jolsa@kernel.org>
References: <20230203162336.608323-1-jolsa@kernel.org>
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

We are about to use un/load_bpf_testmod functions in couple tests
and it's better  to print output to stdout,  so it's aligned with
tests ASSERT macros output, which use stdout as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/testing_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 3a9e7e8e5b14..fd22c64646fc 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -244,14 +244,14 @@ static int delete_module(const char *name, int flags)
 void unload_bpf_testmod(bool verbose)
 {
 	if (kern_sync_rcu())
-		fprintf(stderr, "Failed to trigger kernel-side RCU sync!\n");
+		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
 	if (delete_module("bpf_testmod", 0)) {
 		if (errno == ENOENT) {
 			if (verbose)
 				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
 			return;
 		}
-		fprintf(stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
 		return;
 	}
 	if (verbose)
@@ -270,11 +270,11 @@ int load_bpf_testmod(bool verbose)
 
 	fd = open("bpf_testmod.ko", O_RDONLY);
 	if (fd < 0) {
-		fprintf(stderr, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
+		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
 		return -ENOENT;
 	}
 	if (finit_module(fd, "", 0)) {
-		fprintf(stderr, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
 		close(fd);
 		return -EINVAL;
 	}
-- 
2.39.1

