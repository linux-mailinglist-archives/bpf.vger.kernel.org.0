Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1A6807F8
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 09:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjA3I40 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 03:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjA3I4Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 03:56:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DF627D61
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 00:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2309960EF2
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 08:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081B6C433EF;
        Mon, 30 Jan 2023 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675068981;
        bh=sNYaGkEITxM7ZjUJQihW+zWbIAn4vLhlSZUVi40xHXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSkAxTH3W1qGmzFs/T83b6qFoOewleb3dC0m1Tj83u6uS5aq0x4O1AfLfVROcijSG
         8ADo0/Q3kv2/0HO4CX6ldU2Gzrc+ybikUN7r3gzfWXGBGB+zxU3fwhPWWd14EB3tEd
         rQ7oNYi8wcNsEHoLVW9oWKC4VYISot8/jAbqyClqHbOkD5XaVpElZBmLAOynGKkp43
         ZFBCzIwbKPs+w2ynUK/8+Can2GiLtOasBBd6DL0GC03LhItARGwxTy2AmOvw4R7LXH
         qswtZViUoZEHljA7Z0klLxBBx+WvIFntw1dLx1TiMITm0cahxec5jIM9l6K2jd5Vgu
         NkpPSUHz9kIMQ==
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
Subject: [PATCHv2 bpf-next 3/7] selftests/bpf: Do not unload bpf_testmod in load_bpf_testmod
Date:   Mon, 30 Jan 2023 09:55:36 +0100
Message-Id: <20230130085540.410638-4-jolsa@kernel.org>
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

Do not unload bpf_testmod in load_bpf_testmod, instead call
unload_bpf_testmod separatelly.

This way we will be able use un/load_bpf_testmod functions
in other tests that un/load bpf_testmod module.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c      | 11 ++++++++---
 tools/testing/selftests/bpf/testing_helpers.c |  3 ---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index a150c35516ef..9ca718c84890 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1592,9 +1592,14 @@ int main(int argc, char **argv)
 	env.stderr = stderr;
 
 	env.has_testmod = true;
-	if (!env.list_test_names && load_bpf_testmod(env.stderr, verbose())) {
-		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
-		env.has_testmod = false;
+	if (!env.list_test_names) {
+		/* ensure previous instance of the module is unloaded */
+		unload_bpf_testmod(env.stderr, verbose());
+
+		if (load_bpf_testmod(env.stderr, verbose())) {
+			fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
+			env.has_testmod = false;
+		}
 	}
 
 	/* initializing tests */
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index c0eb54bf08b3..ade6208b4a69 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -262,9 +262,6 @@ int load_bpf_testmod(FILE *err, bool verbose)
 {
 	int fd;
 
-	/* ensure previous instance of the module is unloaded */
-	unload_bpf_testmod(err, verbose);
-
 	if (verbose)
 		fprintf(stdout, "Loading bpf_testmod.ko...\n");
 
-- 
2.39.1

