Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B486C937C
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjCZJXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjCZJWv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1EA271;
        Sun, 26 Mar 2023 02:22:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id ga7so5890736qtb.2;
        Sun, 26 Mar 2023 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7x7mlObk0mq6o5G4acCq3J/Q3Teazds0AbiZGRGfrs=;
        b=jH3+gOe0IubDUQiVblq9CC8G+sjt1vhQU+uyAo7rRHDtbXyRUrTQxeklq+IOr53MbF
         +JYKWg1fZnDvfmrwc+gsil+GBkuqcn2x09nVlYt0LXju/gaIOUm3TRiZfMcRNEKDLmY2
         sHZTTsTM7IQQuu7BP0hWxOYAsdg1RiD4HM8lNSWRZc2DiOY9zbVyy4viinugjDtW5OeL
         HBXxrunxHvVUw08WRg41zi+FecGZpIJ+EJTWpWdbOYwQ06eKSTp0a7ERHLAkglIRyWBf
         MZrumVFQ/Gt3TqWo47rtHv7aWHQZXeacEhaVZi2bRBHmgiXq+ykd/ZtjMXYCTsaTzyvz
         vKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7x7mlObk0mq6o5G4acCq3J/Q3Teazds0AbiZGRGfrs=;
        b=3tSr0Pb7PiLPyRM8+r+jfKfjhskfqOO1gQjF7l55tQ4NxIyYAPsmqqjiHJ5lfEoRum
         C5ARxjqq8PpAIixfa/P8Koh7UuADOzIUk3w3Ri7thPID4G889z8Myl/7f6Eli0f9L7xE
         EwmFcuBL75X0hiAsH2f/xEUGIClYVhDYIYDl+29uJYJxnbsucCDuOI1Bh/BkpVAIjEJP
         ZPVDaEoIrstcu39qAd8hZ/TffdaC/s0ikBvu8SQKRd7jzJ5vBAmUt7OytvW1AFDHBmuV
         4VqW51gHKa1cC3UWAJSdZH8fStRT6yFykSOL8tCoin/o6vqyu9dByljSVIWlKRxAr2Z5
         r8Ew==
X-Gm-Message-State: AAQBX9fsiALRR3nnyX/VR6BN8BgizeZecIbj8xwaNdq5JsmQXP28Fgno
        NBJePNfP2vLooIUNOSHNMEs=
X-Google-Smtp-Source: AKy350ZWZWKF7vBQ3o37aJcdEl7aHQL8ZhsChADAhPyug9b+hHQnb7kOo9oRsLXo54i0B5djN2emww==
X-Received: by 2002:a05:622a:494:b0:3e4:e5bf:a24c with SMTP id p20-20020a05622a049400b003e4e5bfa24cmr1497323qtx.62.1679822548595;
        Sun, 26 Mar 2023 02:22:28 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:28 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 13/13] selftests/bpf: Add selftest for bpf namespace
Date:   Sun, 26 Mar 2023 09:22:08 +0000
Message-Id: <20230326092208.13613-14-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A simple test case is added for the newly introduced bpf namespcae.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/Makefile     |  3 +-
 tools/testing/selftests/bpf/test_bpfns.c | 76 ++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/test_bpfns.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4a8ef11..55f0aeb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -40,7 +40,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
-	test_progs-no_alu32
+	test_progs-no_alu32 test_bpfns
 
 # Also test bpf-gcc, if present
 ifneq ($(BPF_GCC),)
@@ -255,6 +255,7 @@ $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
+$(OUTPUT)/test_bpfns: $(TESTING_HELPERS)
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
diff --git a/tools/testing/selftests/bpf/test_bpfns.c b/tools/testing/selftests/bpf/test_bpfns.c
new file mode 100644
index 0000000..7baebe2
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_bpfns.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE 1
+#endif
+#include <unistd.h>
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <linux/sched.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+static int create_bpf_map(const char *name)
+{
+	static struct bpf_map_create_opts map_opts = {
+		.sz = sizeof(map_opts),
+	};
+	unsigned int value;
+	unsigned int key;
+	int map_fd;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, name, sizeof(key),
+							sizeof(value), 1, &map_opts);
+	if (map_fd < 0)
+		fprintf(stderr, "%s - Failed to create map\n", strerror(errno));
+	return map_fd;
+}
+
+
+int main(int argc, char *argv[])
+{
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	struct clone_args args = {
+		.flags = 0x400000000ULL,	/* CLONE_NEWBPF */
+		.exit_signal = SIGCHLD,
+	};
+	int map_fd, child_map_fd;
+	pid_t pid;
+
+	/* Create a map in init bpf namespace. */
+	map_fd = create_bpf_map("map_in_init");
+	if (map_fd < 0)
+		exit(EXIT_FAILURE);
+	pid = syscall(__NR_clone3, &args, sizeof(struct clone_args));
+	if (pid < 0) {
+		fprintf(stderr, "%s - Failed to create new process\n", strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	if (pid == 0) {
+		struct bpf_map_info info = {};
+
+		/* In a new bpf namespace, it is the first map. */
+		child_map_fd = create_bpf_map("map_in_bpfns");
+		if (child_map_fd < 0)
+			exit(EXIT_FAILURE);
+		bpf_obj_get_info_by_fd(child_map_fd, &info, &info_len);
+		assert(info.id == 1);
+		exit(EXIT_SUCCESS);
+	}
+
+	if (waitpid(pid, NULL, 0) != pid) {
+		fprintf(stderr, "Failed to wait on child process\n");
+		exit(EXIT_FAILURE);
+	}
+
+	return 0;
+}
-- 
1.8.3.1

