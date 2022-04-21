Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09B450A1BB
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388980AbiDUOLA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388966AbiDUOK5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 10:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA7D23B007
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hi5GUSbAAds08X4ZJP7ddUqEMtipRWnoAKsCpMXwBrE=;
        b=Y2lQH32BgzzVScmB+yciVfBsXrEnqOnyP0+qWhrGBEK8cVTdgAe/vr11HPCjixguqEzM+V
        wRaFoBlVfnClUHNswzL3XNvKFDyho7vxfXkUb1ch3gYqSfuKqTgjOoWD1DyMV5C0mVK8Dt
        ylaox1P6c4dp1ebBw5pGLqLIUdTXHd8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-lT9cCk2hPNGRU7F2P6C5hQ-1; Thu, 21 Apr 2022 10:08:00 -0400
X-MC-Unique: lT9cCk2hPNGRU7F2P6C5hQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF23480346F;
        Thu, 21 Apr 2022 14:07:59 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93CAB40EC002;
        Thu, 21 Apr 2022 14:07:57 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC bpf-next v4 6/7] samples/bpf: add new hid_mouse example
Date:   Thu, 21 Apr 2022 16:07:39 +0200
Message-Id: <20220421140740.459558-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Everything should be available in the selftest part of the tree, but
providing an example without uhid and hidraw will be more easy to
follow for users.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v4:
- dropped the not-yet-implemented rdesc_fixup
- use the new API

changes in v3:
- use the new hid_get_data API
- add a comment for the report descriptor fixup to explain what is done

changes in v2:
- split the series by bpf/libbpf/hid/selftests and samples
---
 samples/bpf/.gitignore      |   1 +
 samples/bpf/Makefile        |  23 +++++++
 samples/bpf/hid_mouse.bpf.c |  59 ++++++++++++++++
 samples/bpf/hid_mouse.c     | 131 ++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 samples/bpf/hid_mouse.bpf.c
 create mode 100644 samples/bpf/hid_mouse.c

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index 0e7bfdbff80a..65440bd618b2 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -2,6 +2,7 @@
 cpustat
 fds_example
 hbm
+hid_mouse
 ibumad
 lathist
 lwt_len_hist
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 8fff5ad3444b..dffca4b04a94 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -60,6 +60,8 @@ tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect
 tprogs-y += xdp_monitor
 
+tprogs-y += hid_mouse
+
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
 LIBBPF_OUTPUT = $(abspath $(BPF_SAMPLES_PATH))/libbpf
@@ -125,6 +127,8 @@ xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
 xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
 
+hid_mouse-objs := hid_mouse.o
+
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
 always-y += sockex1_kern.o
@@ -349,6 +353,8 @@ $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 $(obj)/hbm.o: $(src)/hbm.h
 $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 
+$(obj)/hid_mouse.o: $(obj)/hid_mouse.skel.h
+
 # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
 # TPROGS_CFLAGS causes conflicts
 XDP_SAMPLE_CFLAGS += -Wall -O2 \
@@ -434,6 +440,23 @@ $(BPF_SKELS_LINKED): $(BPF_OBJS_LINKED) $(BPFTOOL)
 	@echo "  BPF GEN-SKEL" $(@:.skel.h=)
 	$(Q)$(BPFTOOL) gen skeleton $(@:.skel.h=.lbpf.o) name $(notdir $(@:.skel.h=)) > $@
 
+# Generate BPF skeletons for non XDP progs
+OTHER_BPF_SKELS := hid_mouse.skel.h
+
+hid_mouse.skel.h-deps := hid_mouse.bpf.o
+
+OTHER_BPF_SRCS_LINKED := $(patsubst %.skel.h,%.bpf.c, $(OTHER_BPF_SKELS))
+OTHER_BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(OTHER_BPF_SRCS_LINKED))
+OTHER_BPF_SKELS_LINKED := $(addprefix $(obj)/,$(OTHER_BPF_SKELS))
+
+$(OTHER_BPF_SKELS_LINKED): $(OTHER_BPF_OBJS_LINKED) $(BPFTOOL)
+	@echo "  BPF GEN-OBJ " $(@:.skel.h=)
+	$(Q)$(BPFTOOL) gen object $(@:.skel.h=.lbpf.o) $(addprefix $(obj)/,$($(@F)-deps))
+	@echo "  BPF GEN-SKEL" $(@:.skel.h=)
+	$(Q)$(BPFTOOL) gen skeleton $(@:.skel.h=.lbpf.o) name $(notdir $(@:.skel.h=_lskel)) > $@
+#	$(call msg,GEN-SKEL,$@)
+#	$(Q)$(BPFTOOL) gen skeleton $< > $@
+
 # asm/sysreg.h - inline assembly used by it is incompatible with llvm.
 # But, there is no easy way to fix it, so just exclude it since it is
 # useless for BPF samples.
diff --git a/samples/bpf/hid_mouse.bpf.c b/samples/bpf/hid_mouse.bpf.c
new file mode 100644
index 000000000000..45cc26b70f5f
--- /dev/null
+++ b/samples/bpf/hid_mouse.bpf.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Note: for the following code to compile, we need HID to be included
+ * in vmlinuz (CONFIG_HID=y).
+ * If HID is compiled as a separate module, we need to use the vmlinux.h
+ * which contains the various hid symbols, it can be generated through:
+ *
+ * $> ./tools/bpf/bpftool/bpftool btf dump \
+ *        file /sys/kernel/btf/hid format c > samples/bpf/vmlinux.h
+ *
+ * Once the code is compiled, the fact that HID is a separate module
+ * or not is not an issue, the same binary will run similarily.
+ */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+extern __u8 *hid_bpf_kfunc_get_data(struct hid_bpf_ctx *ctx,
+				    unsigned int offset,
+				    const size_t __sz) __ksym;
+extern void hid_bpf_kfunc_data_release(__u8 *data) __ksym;
+extern int hid_bpf_kfunc_hw_request(struct hid_bpf_ctx *ctx) __ksym;
+
+#define BUS_USB 3
+
+SEC("fentry/hid_bpf_device_event")
+int BPF_KPROBE(hid_event, struct hid_bpf_ctx *hctx, __s64 type)
+{
+	__u8 *rw_data = hid_bpf_kfunc_get_data(hctx, 0, 5);
+
+	if (!rw_data)
+		return 0;
+
+	if (hctx->bus == BUS_USB) {
+		/* note: the following call prevents the program to be loaded:
+		 * hid_bpf_device_event() is not sleepable when this function is.
+		 */
+		hid_bpf_kfunc_hw_request(hctx);
+
+		bpf_printk("data: %02x %02x %02x", rw_data[0], rw_data[1], rw_data[4]);
+	}
+
+	hid_bpf_kfunc_data_release(rw_data);
+
+	return 0;
+}
+
+SEC("fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_mod_event, struct hid_bpf_ctx *hctx, __s64 type)
+{
+	/* prevent any USB event to go through the HID stack */
+	if (hctx->bus == BUS_USB)
+		return -1;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/hid_mouse.c b/samples/bpf/hid_mouse.c
new file mode 100644
index 000000000000..aace0b959d3b
--- /dev/null
+++ b/samples/bpf/hid_mouse.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Benjamin Tissoires
+ */
+
+/* not sure why but this doesn't get preoperly imported */
+#define __must_check
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <unistd.h>
+
+#include <linux/bpf.h>
+#include <linux/err.h>
+
+#include "bpf_util.h"
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "hid_mouse.skel.h"
+
+static char *sysfs_path;
+static int sysfs_fd;
+static int prog_count;
+
+static bool running = true;
+
+struct prog {
+	int fd;
+	struct bpf_link *link;
+	enum bpf_attach_type type;
+};
+
+static struct prog progs[10];
+
+static void int_exit(int sig)
+{
+	running = false;
+	exit(0);
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"%s: %s /sys/bus/hid/devices/0BUS:0VID:0PID:00ID/uevent\n\n",
+		__func__, prog);
+}
+
+int main(int argc, char **argv)
+{
+	struct hid_mouse_lskel *skel;
+	int prog_fd, err;
+	const char *optstr = "";
+	int opt;
+	char filename[256];
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .repeat = 1,
+	);
+
+	while ((opt = getopt(argc, argv, optstr)) != -1) {
+		switch (opt) {
+		default:
+			usage(basename(argv[0]));
+			return 1;
+		}
+	}
+
+	if (optind == argc) {
+		usage(basename(argv[0]));
+		return 1;
+	}
+
+	sysfs_path = argv[optind];
+	if (!sysfs_path) {
+		perror("sysfs");
+		return 1;
+	}
+
+	skel = hid_mouse_lskel__open_and_load();
+	if (!skel) {
+		fprintf(stderr, "%s  %s:%d", __func__, __FILE__, __LINE__);
+		return -1;
+	}
+
+	err = hid_mouse_lskel__attach(skel);
+	if (err)
+		goto cleanup;
+
+	//prog_fd = bpf_program__fd(skel->progs.hid_event);
+	//err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+//	sysfs_fd = open(sysfs_path, O_RDONLY);
+//
+////	bpf_object__for_each_program(prog, obj) {
+////		progs[prog_count].fd = bpf_program__fd(prog);
+////		progs[prog_count].type = bpf_program__get_expected_attach_type(prog);
+////		progs[prog_count].link = bpf_program__attach(prog);
+////		if (libbpf_get_error(progs[prog_count].link)) {
+////			fprintf(stderr, "bpf_prog_attach: err=%m\n");
+////			progs[prog_count].fd = 0;
+////			progs[prog_count].link = NULL;
+////			goto cleanup;
+////		}
+////		prog_count++;
+////	}
+//
+	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
+//
+////	err = bpf_obj_get_info_by_fd(progs[0].fd, &info, &info_len);
+////	if (err) {
+////		printf("can't get prog info - %s\n", strerror(errno));
+////		goto cleanup;
+////	}
+//
+	while (running)
+		;
+
+ cleanup:
+	hid_mouse_lskel__destroy(skel);
+
+	return err;
+}
-- 
2.35.1

