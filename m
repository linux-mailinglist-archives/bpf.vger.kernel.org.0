Return-Path: <bpf+bounces-31603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8B69008F2
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA20D28DE4B
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B191D19AD9E;
	Fri,  7 Jun 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+AMlEOa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13419AD6D;
	Fri,  7 Jun 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774124; cv=none; b=FfXnJlkypDKDcu/jGeRgt3ACMGpa4BTsZ70AY6GkOB07pwTYQkIrA7n1eZLvyu/togIxj3oNp1QB8CSw9brZgyvjb8Y3xdbnzyouepYI3sjKi1HZeuGsqYa2FOKAG2ltjc6v5pyFHAvz7/zj4NTOulvdfxVw5pTWwZyJnBrZjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774124; c=relaxed/simple;
	bh=J8ZF6C8Acr6IPD2yIJBTMvvGlgpexK1V/B1ceSx8p08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXO5a4/NJIZ9ZVT2FaV5+4XvAEVdiR5ZHuCNp/aK1sRZdd6l/8brt5d+R1ewkWaLqtP055NqRxOQu6fIejiSypA8h791hdiJ1JfhYy7ckdtCUikeWt271PVa/73utp3wktp5KOPakmHulWGW4jxtHNOsb5M8cmMS/2aaTJXFXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+AMlEOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBFFC4AF08;
	Fri,  7 Jun 2024 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774124;
	bh=J8ZF6C8Acr6IPD2yIJBTMvvGlgpexK1V/B1ceSx8p08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V+AMlEOaHIeYC9YmMLrOuL5aI8AwbE+/mhu2Al1rkEsThmGib1+Ud/W8QCwGu41p3
	 CNuyDXS6lLqgy9fF1vKb03WydxFzXN3aaLnU5h3W4jWmBsMaqeoZPo12yfEKDyeIHT
	 gsetYDNXerVt2y8zjJd31Xflh/ExnWSdvm/lURgfPJsAULsiYnrHl1ZCE2OoEfbHin
	 tZbs0SykECMr8APxsclCYk7MXw2By3Q51tTu6kG59czLKSdYWhiQGR+Z6zcgquwWRm
	 NHoUb5zsFxLPn7G93lAPpJi8OzVuuPzKKblV3GdkxahuHN7CzWZm2NyeRc/fX8vZtX
	 u3/Eeq+N8XgPw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:25 +0200
Subject: [PATCH HID v2 05/16] HID: samples: convert the 2 HID-BPF samples
 into struct_ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-5-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=10418;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=J8ZF6C8Acr6IPD2yIJBTMvvGlgpexK1V/B1ceSx8p08=;
 b=DqK7awAanMRmHfwg/HsMQK9qIxkXQfsKwfqEsA1jpM412Zk+HqnISavAY8UTLMYtU2JPBAfqt
 SF8y/rHdEYBCSRpfrV/RFrf8pkx/nKUX+fwDn3fDjb5zMeU9RrQb0O4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is mostly mechanical: attach_prog is dropped, and
the SEC are converted into struct_ops.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2 but the commit message.
---
 samples/hid/Makefile               |  5 ++--
 samples/hid/hid_bpf_attach.bpf.c   | 18 -------------
 samples/hid/hid_bpf_attach.h       | 14 ----------
 samples/hid/hid_mouse.bpf.c        | 26 +++++++++++++++----
 samples/hid/hid_mouse.c            | 39 ++++++++--------------------
 samples/hid/hid_surface_dial.bpf.c | 10 +++++--
 samples/hid/hid_surface_dial.c     | 53 +++++++++++---------------------------
 7 files changed, 57 insertions(+), 108 deletions(-)

diff --git a/samples/hid/Makefile b/samples/hid/Makefile
index c128ccd49974..8ea59e9631a3 100644
--- a/samples/hid/Makefile
+++ b/samples/hid/Makefile
@@ -16,7 +16,6 @@ LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
 LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
 
-EXTRA_HEADERS := hid_bpf_attach.h
 EXTRA_BPF_HEADERS := hid_bpf_helpers.h
 
 hid_mouse-objs := hid_mouse.o
@@ -207,8 +206,8 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(EXTRA_BPF_HEADERS_SRC) $(obj)/vmlinux.h
 LINKED_SKELS := hid_mouse.skel.h hid_surface_dial.skel.h
 clean-files += $(LINKED_SKELS)
 
-hid_mouse.skel.h-deps := hid_mouse.bpf.o hid_bpf_attach.bpf.o
-hid_surface_dial.skel.h-deps := hid_surface_dial.bpf.o hid_bpf_attach.bpf.o
+hid_mouse.skel.h-deps := hid_mouse.bpf.o
+hid_surface_dial.skel.h-deps := hid_surface_dial.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/hid/hid_bpf_attach.bpf.c b/samples/hid/hid_bpf_attach.bpf.c
deleted file mode 100644
index d4dce4ea7c6e..000000000000
--- a/samples/hid/hid_bpf_attach.bpf.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2022 Benjamin Tissoires
- */
-
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include "hid_bpf_attach.h"
-#include "hid_bpf_helpers.h"
-
-SEC("syscall")
-int attach_prog(struct attach_prog_args *ctx)
-{
-	ctx->retval = hid_bpf_attach_prog(ctx->hid,
-					  ctx->prog_fd,
-					  0);
-	return 0;
-}
diff --git a/samples/hid/hid_bpf_attach.h b/samples/hid/hid_bpf_attach.h
deleted file mode 100644
index 35bb28b49264..000000000000
--- a/samples/hid/hid_bpf_attach.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright (c) 2022 Benjamin Tissoires
- */
-
-#ifndef __HID_BPF_ATTACH_H
-#define __HID_BPF_ATTACH_H
-
-struct attach_prog_args {
-	int prog_fd;
-	unsigned int hid;
-	int retval;
-};
-
-#endif /* __HID_BPF_ATTACH_H */
diff --git a/samples/hid/hid_mouse.bpf.c b/samples/hid/hid_mouse.bpf.c
index 7c8b453ccb16..bd901fa855c9 100644
--- a/samples/hid/hid_mouse.bpf.c
+++ b/samples/hid/hid_mouse.bpf.c
@@ -5,8 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include "hid_bpf_helpers.h"
 
-SEC("fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_y_event, struct hid_bpf_ctx *hctx)
+static int hid_y_event(struct hid_bpf_ctx *hctx)
 {
 	s16 y;
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 9 /* size */);
@@ -51,8 +50,7 @@ int BPF_PROG(hid_y_event, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
-SEC("fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_x_event, struct hid_bpf_ctx *hctx)
+static int hid_x_event(struct hid_bpf_ctx *hctx)
 {
 	s16 x;
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 9 /* size */);
@@ -69,7 +67,19 @@ int BPF_PROG(hid_x_event, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC("struct_ops/device_event")
+int BPF_PROG(hid_event, struct hid_bpf_ctx *hctx, enum hid_report_type type)
+{
+	int ret = hid_y_event(hctx);
+
+	if (ret)
+		return ret;
+
+	return hid_x_event(hctx);
+}
+
+
+SEC("struct_ops/rdesc_fixup")
 int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
@@ -109,4 +119,10 @@ int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+SEC(".struct_ops.link")
+struct hid_bpf_ops mouse_invert = {
+	.rdesc_fixup = (void *)hid_rdesc_fixup,
+	.device_event = (void *)hid_event,
+};
+
 char _license[] SEC("license") = "GPL";
diff --git a/samples/hid/hid_mouse.c b/samples/hid/hid_mouse.c
index 018f1185f203..4b80d4e4c154 100644
--- a/samples/hid/hid_mouse.c
+++ b/samples/hid/hid_mouse.c
@@ -29,7 +29,6 @@
 #include <bpf/libbpf.h>
 
 #include "hid_mouse.skel.h"
-#include "hid_bpf_attach.h"
 
 static bool running = true;
 
@@ -76,18 +75,11 @@ static int get_hid_id(const char *path)
 int main(int argc, char **argv)
 {
 	struct hid_mouse *skel;
-	struct bpf_program *prog;
+	struct bpf_link *link;
 	int err;
 	const char *optstr = "";
 	const char *sysfs_path;
-	int opt, hid_id, attach_fd;
-	struct attach_prog_args args = {
-		.retval = -1,
-	};
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattr,
-			    .ctx_in = &args,
-			    .ctx_size_in = sizeof(args),
-	);
+	int opt, hid_id;
 
 	while ((opt = getopt(argc, argv, optstr)) != -1) {
 		switch (opt) {
@@ -108,7 +100,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	skel = hid_mouse__open_and_load();
+	skel = hid_mouse__open();
 	if (!skel) {
 		fprintf(stderr, "%s  %s:%d", __func__, __FILE__, __LINE__);
 		return -1;
@@ -120,27 +112,18 @@ int main(int argc, char **argv)
 		fprintf(stderr, "can not open HID device: %m\n");
 		return 1;
 	}
-	args.hid = hid_id;
+	skel->struct_ops.mouse_invert->hid_id = hid_id;
 
-	attach_fd = bpf_program__fd(skel->progs.attach_prog);
-	if (attach_fd < 0) {
-		fprintf(stderr, "can't locate attach prog: %m\n");
+	err = hid_mouse__load(skel);
+	if (err < 0) {
+		fprintf(stderr, "can not load HID-BPF program: %m\n");
 		return 1;
 	}
 
-	bpf_object__for_each_program(prog, *skel->skeleton->obj) {
-		/* ignore syscalls */
-		if (bpf_program__get_type(prog) != BPF_PROG_TYPE_TRACING)
-			continue;
-
-		args.retval = -1;
-		args.prog_fd = bpf_program__fd(prog);
-		err = bpf_prog_test_run_opts(attach_fd, &tattr);
-		if (err) {
-			fprintf(stderr, "can't attach prog to hid device %d: %m (err: %d)\n",
-				hid_id, err);
-			return 1;
-		}
+	link = bpf_map__attach_struct_ops(skel->maps.mouse_invert);
+	if (!link) {
+		fprintf(stderr, "can not attach HID-BPF program: %m\n");
+		return 1;
 	}
 
 	signal(SIGINT, int_exit);
diff --git a/samples/hid/hid_surface_dial.bpf.c b/samples/hid/hid_surface_dial.bpf.c
index 1f80478c0918..d8d0fb07391f 100644
--- a/samples/hid/hid_surface_dial.bpf.c
+++ b/samples/hid/hid_surface_dial.bpf.c
@@ -10,7 +10,7 @@
 #define HID_UP_BUTTON		0x0009
 #define HID_GD_WHEEL		0x0038
 
-SEC("fmod_ret/hid_bpf_device_event")
+SEC("struct_ops/device_event")
 int BPF_PROG(hid_event, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 9 /* size */);
@@ -101,7 +101,7 @@ int set_haptic(struct haptic_syscall_args *args)
 }
 
 /* Convert REL_DIAL into REL_WHEEL */
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC("struct_ops/rdesc_fixup")
 int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
@@ -130,5 +130,11 @@ int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+SEC(".struct_ops.link")
+struct hid_bpf_ops surface_dial = {
+	.rdesc_fixup = (void *)hid_rdesc_fixup,
+	.device_event = (void *)hid_event,
+};
+
 char _license[] SEC("license") = "GPL";
 u32 _version SEC("version") = 1;
diff --git a/samples/hid/hid_surface_dial.c b/samples/hid/hid_surface_dial.c
index 4bc97373a708..9dd363845a85 100644
--- a/samples/hid/hid_surface_dial.c
+++ b/samples/hid/hid_surface_dial.c
@@ -31,7 +31,6 @@
 #include <bpf/libbpf.h>
 
 #include "hid_surface_dial.skel.h"
-#include "hid_bpf_attach.h"
 
 static bool running = true;
 
@@ -86,34 +85,6 @@ static int get_hid_id(const char *path)
 	return (int)strtol(str_id, NULL, 16);
 }
 
-static int attach_prog(struct hid_surface_dial *skel, struct bpf_program *prog, int hid_id)
-{
-	struct attach_prog_args args = {
-		.hid = hid_id,
-		.retval = -1,
-	};
-	int attach_fd, err;
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattr,
-			    .ctx_in = &args,
-			    .ctx_size_in = sizeof(args),
-	);
-
-	attach_fd = bpf_program__fd(skel->progs.attach_prog);
-	if (attach_fd < 0) {
-		fprintf(stderr, "can't locate attach prog: %m\n");
-		return 1;
-	}
-
-	args.prog_fd = bpf_program__fd(prog);
-	err = bpf_prog_test_run_opts(attach_fd, &tattr);
-	if (err) {
-		fprintf(stderr, "can't attach prog to hid device %d: %m (err: %d)\n",
-			hid_id, err);
-		return 1;
-	}
-	return 0;
-}
-
 static int set_haptic(struct hid_surface_dial *skel, int hid_id)
 {
 	struct haptic_syscall_args args = {
@@ -144,10 +115,10 @@ static int set_haptic(struct hid_surface_dial *skel, int hid_id)
 int main(int argc, char **argv)
 {
 	struct hid_surface_dial *skel;
-	struct bpf_program *prog;
 	const char *optstr = "r:";
+	struct bpf_link *link;
 	const char *sysfs_path;
-	int opt, hid_id, resolution = 72;
+	int err, opt, hid_id, resolution = 72;
 
 	while ((opt = getopt(argc, argv, optstr)) != -1) {
 		switch (opt) {
@@ -189,7 +160,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	skel = hid_surface_dial__open_and_load();
+	skel = hid_surface_dial__open();
 	if (!skel) {
 		fprintf(stderr, "%s  %s:%d", __func__, __FILE__, __LINE__);
 		return -1;
@@ -201,15 +172,21 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	skel->struct_ops.surface_dial->hid_id = hid_id;
+
+	err = hid_surface_dial__load(skel);
+	if (err < 0) {
+		fprintf(stderr, "can not load HID-BPF program: %m\n");
+		return 1;
+	}
+
 	skel->data->resolution = resolution;
 	skel->data->physical = (int)(resolution / 72);
 
-	bpf_object__for_each_program(prog, *skel->skeleton->obj) {
-		/* ignore syscalls */
-		if (bpf_program__get_type(prog) != BPF_PROG_TYPE_TRACING)
-			continue;
-
-		attach_prog(skel, prog, hid_id);
+	link = bpf_map__attach_struct_ops(skel->maps.surface_dial);
+	if (!link) {
+		fprintf(stderr, "can not attach HID-BPF program: %m\n");
+		return 1;
 	}
 
 	signal(SIGINT, int_exit);

-- 
2.44.0


