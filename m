Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48390689F1C
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjBCQYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBCQYd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:24:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B1A6C31
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:24:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B10061F72
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F5EC433EF;
        Fri,  3 Feb 2023 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441465;
        bh=ezccFv4heL8FQl8SJ4uv1sDVpD9zQulszGW8H+xPaxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3mt38Tk6CEmrxichSlfY0T1I2bp7QqjI9KAxh8q0wNXF0qMvaAt8OlFqWLU/vyvv
         nYF41Q9vI6ySPQIDFPK+/VkR4QZaclUH0du+O30mutv5r6NFxYNtpJ7r9zX4rn+4I/
         +C9xWEUj+D9GWcuwBGWwaVn6+vlFOPirxuJkHwrXyZbNBmksUdNFLXO8U69N/g0Cgp
         y9udicmW6d8Im8edM6tNhIrgwA6YN49YjRDsN/kkN92e3TkDmP3svEM3oEQoldH7Y7
         gUJCmvKrWt+xhCMlrtdoT/jRy+1W0OquNLXmhXnASrcf5ifXJInAmbLPjUqPopkrmI
         t3TOgRKWMN6kg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv3 bpf-next 4/9] selftests/bpf: Do not unload bpf_testmod in load_bpf_testmod
Date:   Fri,  3 Feb 2023 17:23:31 +0100
Message-Id: <20230203162336.608323-5-jolsa@kernel.org>
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

Do not unload bpf_testmod in load_bpf_testmod, instead call
unload_bpf_testmod separatelly.

This way we will be able use un/load_bpf_testmod functions
in other tests that un/load bpf_testmod module.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c      | 11 ++++++++---
 tools/testing/selftests/bpf/testing_helpers.c |  3 ---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 39ceb6a1bfc6..0b4925cf6331 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1592,9 +1592,14 @@ int main(int argc, char **argv)
 	env.stderr = stderr;
 
 	env.has_testmod = true;
-	if (!env.list_test_names && load_bpf_testmod(verbose())) {
-		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
-		env.has_testmod = false;
+	if (!env.list_test_names) {
+		/* ensure previous instance of the module is unloaded */
+		unload_bpf_testmod(verbose());
+
+		if (load_bpf_testmod(verbose())) {
+			fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
+			env.has_testmod = false;
+		}
 	}
 
 	/* initializing tests */
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index fd22c64646fc..3872c36c17d4 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -262,9 +262,6 @@ int load_bpf_testmod(bool verbose)
 {
 	int fd;
 
-	/* ensure previous instance of the module is unloaded */
-	unload_bpf_testmod(verbose);
-
 	if (verbose)
 		fprintf(stdout, "Loading bpf_testmod.ko...\n");
 
-- 
2.39.1

