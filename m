Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448124CD71D
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 16:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiCDPID (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 10:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbiCDPID (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 10:08:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D51BE137
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 07:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58A59B82A05
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 15:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5937C340E9;
        Fri,  4 Mar 2022 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646406433;
        bh=x5ZRj+CGv8iKJ9GdTQLORgWIHUbzwClfF0XPRtvYz7k=;
        h=From:To:Cc:Subject:Date:From;
        b=RnyENdkRZAGp96jsvepj7N0vqF+ao15SHeZ20nRWOW8VN5NjqdrRLTjNUYMX86M1O
         ZKizuZhULztld7kRTUQOmvgh3jqYfNvP5IEgiV5TJGcIvsHOB5ebhq6f2GFGkSN/fc
         bSWS3IfcZxNj6RpAsHQbUvEXgfCNYHy9yOeEPuN2MykH4tu6vYArdEctAuaMHqm3Q/
         RBSmJchWRW4qp5V+aRZWL+t28DCRf+sYL2pt75wL28DAEyQDrQZ75p59su8vz+Q6LP
         WFN6T0FDbl5bT040B6YYGKJ2FaO6qDENjWz1XGFkCAodFF92mheQ/UjkAFM2iRCvSO
         y8QuAkstIHunA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     "Geyslan G. Bem" <geyslan@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next] bpf/selftests: Allow vmtest.sh to build statically linked test_progs.
Date:   Fri,  4 Mar 2022 15:07:08 +0000
Message-Id: <20220304150708.729904-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dynamic linking when compiling on the host can cause issues when the
libc version does not match the one in the VM image.
Allow the user to use static compilation when this issue arises:

Before:
  ./vmtest.sh -- ./test_progs -t test_ima
  ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)

After:

  TRUNNER_LDFLAGS=-static ./vmtest.sh -- ./test_progs -t test_ima
  test_ima:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Not using static as the default as some distros may not have dependent
static libraries.

Reported-by: "Geyslan G. Bem" <geyslan@gmail.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/Makefile  | 4 ++--
 tools/testing/selftests/bpf/vmtest.sh | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fe12b4f5fe20..2473c9b0cb2e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -162,7 +162,7 @@ $(MAKE_DIRS):
 
 $(OUTPUT)/%.o: %.c
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) $(TRUNNER_LDFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 
 $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
@@ -468,7 +468,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(RESOLVE_BTFIDS)				\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
 	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
 
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index e0bb04a97e10..9e4d8eefcd07 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -37,6 +37,7 @@ NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
 LOG_FILE="${LOG_FILE_BASE}.log"
 EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
+TRUNNER_LDFLAGS="${TRUNNER_LDFLAGS:=""}"
 
 usage()
 {
@@ -155,7 +156,7 @@ update_selftests()
 	local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"
 
 	cd "${selftests_dir}"
-	${make_command}
+	${make_command} TRUNNER_LDFLAGS="${TRUNNER_LDFLAGS}"
 
 	# Mount the image and copy the selftests to the image.
 	mount_image
-- 
2.35.1.616.g0bdcbb4464-goog

