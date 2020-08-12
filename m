Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339D5242D5F
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHLQdT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLQdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 12:33:17 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EB6C061385;
        Wed, 12 Aug 2020 09:33:17 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id k1so638748vkb.7;
        Wed, 12 Aug 2020 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FsV6tN7LcqDEjOofCki0Oq8dlSR26H06wV4vGa5fjaI=;
        b=hv+/j9MdhYgykHf3BaW4nHKCRtp7AbbGKtZuDN1gScNdKxN57aDrjKMCqZnhNglvwR
         7ZczlXShBzD6t0ijfV7129P/fm2pptb+tqFPuRAWYdrH8Pf9FVb28O2eFMlG2QWT90aQ
         sESuxVXnZG5mzzeAPqYfQFEAStc4VNLykqtZdg7TzcHpzuq/FH8ywKyYdQragV5qKBkJ
         1AZ+K0B1t9kaYzvVODyIHNRoJeIK6J1JhdnVDjCcrD+A9MZ4UnWsut43Gad5jFBshDJd
         17gnhWPv5yi831HhYDPexZmINYtMAk7GmEf64b3mc4iyzl/haZw/YFrKdnOW0CkMOLoB
         L+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FsV6tN7LcqDEjOofCki0Oq8dlSR26H06wV4vGa5fjaI=;
        b=d/tjRP4yU13APsXbUvpuH6rnxWuEIdb2tTdKciovF3HAWdxix1tBFS8mFAq/KrV7V2
         4pRaTXIJERdA142YxWSEik9yh36lC5Jx3/9ZvoNbmbdC6gjp4FQi6611G42bYzW3AwT1
         6hckFlB10GXqva+VGugYzbvrKdrUskjgNmPe6rEgRPi9zFR4/43HOeiX2rlTduq+xT5r
         +YJpZm4qquOu1TucE0+siyZrHtDKYZS/sEd9u54Xk4EsMpaktm+ZQK82y4qsN+oq62ZW
         nOv2YBHn09ndgw1Pzf2L73aV1OpdMjmH1PplzUl72B3N0vdl0pRrcrjcuGRpXtTNlk+s
         ztzw==
X-Gm-Message-State: AOAM5303vq5ef23D9QpEKxQw6ZovBcgXCsubzlKCMQCXl6h0jp7n8UNT
        WWPa9aDiLb8ayxIjF64sdU24DvXgLdY=
X-Google-Smtp-Source: ABdhPJwe/0VfZJOfrIYPbuN7Gm+7OU2KnRrh1bZFF4HL/vA5eA5mBYC8fM034iC2Ew5JvaQruy4snA==
X-Received: by 2002:a1f:9048:: with SMTP id s69mr191601vkd.73.1597249995853;
        Wed, 12 Aug 2020 09:33:15 -0700 (PDT)
Received: from ebpf-cloudtop.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.googlemail.com with ESMTPSA id e8sm245374uar.11.2020.08.12.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:33:15 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     bpf@vger.kernel.org, linux-block@vger.kernel.org
Cc:     leah.rumancik@gmail.com, orbekk@google.com, harshads@google.com,
        jasiu@google.com, saranyamohan@google.com, tytso@google.com,
        bvanassche@google.com
Subject: [RFC PATCH 2/4] bpf: add protect_gpt sample program
Date:   Wed, 12 Aug 2020 16:33:03 +0000
Message-Id: <20200812163305.545447-3-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200812163305.545447-1-leah.rumancik@gmail.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sample program to protect GUID partition table. Uses IO filter bpf
program type.

Signed-off-by: Kjetil Ørbekk <orbekk@google.com>
Signed-off-by: Harshad Shirwadkar <harshads@google.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 samples/bpf/Makefile           |   3 +
 samples/bpf/protect_gpt_kern.c |  21 ++++++
 samples/bpf/protect_gpt_user.c | 133 +++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 samples/bpf/protect_gpt_kern.c
 create mode 100644 samples/bpf/protect_gpt_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 8403e4762306..f02ae9b2a283 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -53,6 +53,7 @@ tprogs-y += task_fd_query
 tprogs-y += xdp_sample_pkts
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += protect_gpt
 
 # Libbpf dependencies
 LIBBPF = $(TOOLS_PATH)/lib/bpf/libbpf.a
@@ -109,6 +110,7 @@ task_fd_query-objs := bpf_load.o task_fd_query_user.o $(TRACE_HELPERS)
 xdp_sample_pkts-objs := xdp_sample_pkts_user.o $(TRACE_HELPERS)
 ibumad-objs := bpf_load.o ibumad_user.o $(TRACE_HELPERS)
 hbm-objs := bpf_load.o hbm.o $(CGROUP_HELPERS)
+protect_gpt-objs := bpf_load.o protect_gpt_user.o $(TRACE_HELPERS)
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -170,6 +172,7 @@ always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
 always-y += xdpsock_kern.o
+always-y += protect_gpt_kern.o
 
 ifeq ($(ARCH), arm)
 # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
diff --git a/samples/bpf/protect_gpt_kern.c b/samples/bpf/protect_gpt_kern.c
new file mode 100644
index 000000000000..cc49d66c120a
--- /dev/null
+++ b/samples/bpf/protect_gpt_kern.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/blk_types.h>
+#include "bpf/bpf_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define GPT_SECTORS 34
+
+SEC("gpt_io_filter")
+int protect_gpt(struct bpf_io_request *io_req)
+{
+	/* within GPT and not a read operation */
+	if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
+		return IO_BLOCK;
+
+	return IO_ALLOW;
+}
+
+
diff --git a/samples/bpf/protect_gpt_user.c b/samples/bpf/protect_gpt_user.c
new file mode 100644
index 000000000000..21ca25bc78af
--- /dev/null
+++ b/samples/bpf/protect_gpt_user.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <linux/bpf.h>
+#include <errno.h>
+#include "trace_helpers.h"
+#include "bpf_load.h"
+
+/*
+ * user program to load bpf program (protect_gpt_kern) to prevent
+ * writing to GUID parititon table
+ *
+ * argument 1: device where program will be attached (ie. /dev/sda)
+ * argument 2: name for pinned program
+ * argument 3: --attach or --detach to attach/detach program
+ */
+
+static int attach(char *dev, char *path)
+{
+	struct bpf_object *obj;
+	int ret, devfd, progfd;
+
+	progfd = bpf_obj_get(path);
+	if (progfd >= 0) {
+		fprintf(stderr, "Error: object already pinned at given location (%s)\n", path);
+		return 1;
+	}
+
+	ret = bpf_prog_load("protect_gpt_kern.o",
+			    BPF_PROG_TYPE_IO_FILTER, &obj, &progfd);
+	if (ret) {
+		fprintf(stderr, "Error: failed to load program\n");
+		return 1;
+	}
+
+	devfd = open(dev, O_RDONLY);
+	if (devfd == -1) {
+		fprintf(stderr, "Error: failed to open block device %s\n", dev);
+		return 1;
+	}
+
+	ret = bpf_prog_attach(progfd, devfd, BPF_BIO_SUBMIT, 0);
+	if (ret) {
+		fprintf(stderr, "Error: failed to attach program to device\n");
+		close(devfd);
+		return 1;
+	}
+
+	ret = bpf_obj_pin(progfd, path);
+	if (ret != 0) {
+		fprintf(stderr, "Error pinning program: %s\n", strerror(errno));
+		fprintf(stderr, "Detaching program from device\n");
+
+		if (bpf_prog_detach2(progfd, devfd, BPF_BIO_SUBMIT))
+			fprintf(stderr, "Error: failed to detach program\n");
+
+		close(devfd);
+		return 1;
+	}
+
+	close(devfd);
+	printf("Attached protect_gpt program to device %s.\n", dev);
+	printf("Program pinned to %s.\n", path);
+	return 0;
+}
+
+static int detach(char *dev, char *path)
+{
+	int ret, devfd, progfd;
+
+	progfd = bpf_obj_get(path);
+	if (progfd < 0) {
+		fprintf(stderr, "Error: failed to get pinned program from path %s\n", path);
+		return 1;
+	}
+
+	devfd = open(dev, O_RDONLY);
+	if (devfd == -1) {
+		fprintf(stderr, "Error: failed to open block device %s\n", dev);
+		return 1;
+	}
+
+	ret = bpf_prog_detach2(progfd, devfd, BPF_BIO_SUBMIT);
+	if (ret) {
+		fprintf(stderr, "Error: failed to detach program\n");
+		close(devfd);
+		return 1;
+	}
+
+	close(devfd);
+
+	ret = unlink(path);
+	if (ret < 0) {
+		fprintf(stderr, "Error unpinning map at %s: %s\n", path, strerror(errno));
+		return 1;
+	}
+
+	printf("Detached and unpinned program.\n");
+	return 0;
+}
+
+static void usage(char *exec)
+{
+	printf("Usage:\n");
+	printf("\t %s <device> <prog name> --attach\n", exec);
+	printf("\t %s <device> <prog name> --detach\n", exec);
+}
+
+int main(int argc, char **argv)
+{
+	char path[256];
+
+	if (argc != 4) {
+		usage(argv[0]);
+		return 1;
+	}
+
+	strcpy(path, "/sys/fs/bpf/");
+	strcat(path, argv[2]);
+
+	if (strcmp(argv[3], "--attach") == 0)
+		return attach(argv[1], path);
+	else if (strcmp(argv[3], "--detach") == 0)
+		return detach(argv[1], path);
+
+	fprintf(stderr, "Error: invalid flag, please specify --attach or --detach");
+	return 1;
+}
+
-- 
2.28.0.236.gb10cc79966-goog

