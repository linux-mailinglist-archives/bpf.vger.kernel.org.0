Return-Path: <bpf+bounces-29053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBA38BFAE9
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CF8B2486B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71247EF0C;
	Wed,  8 May 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p57F73eg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D77B3F3;
	Wed,  8 May 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164027; cv=none; b=aZRq9E9FYDmBQrN1CSzjI7kydi2/WVqUdJU5SHCn5Q5U42wtqE/O5mKAo5vWOlDb7/3wxztWuHPJOJqCbjWB4mfHZoe8rCVzn8mqQbXj0dohfg07srb//7jMmg+X4fcCCLl4rprg97PZOz1JHvLnELD1C/w5A+MwXl3ozMAO3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164027; c=relaxed/simple;
	bh=bd0bpoEpyiLdDsGWlz0RnhORzoCPz+ID4XTIfN6BdpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fi6wzyIcXAQu64eOkmzXY93Q+qOzXEhF/VCoBkgpVKySfXVk50FPBDuMeQ1OoGw0H5q1ftqd/QAdq2oOyoeBt62nrpZRbX0OAbeA3544dMmLHLP7ehkLS5gqoE8nIJq0JBIPgUqh8w5gnvZCz4WAEPElGhETIw7oJOWSQ5c6rgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p57F73eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D8FC113CC;
	Wed,  8 May 2024 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715164027;
	bh=bd0bpoEpyiLdDsGWlz0RnhORzoCPz+ID4XTIfN6BdpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p57F73eg6+Cuv4pzTtpVG5k7Vp8P00tYl1jA07QvzNhFVGOHKguaGmK0FlxZclNAq
	 9NLlXEH0qhXPBduigM7huFareruneH+0MhmZ8BQCvc1MwgUdaBkJumiF8DoV+hHjmC
	 cIT+ZM2C3SAV4km1NoifpisYDJMIRIrj41uQ/XSdc80KLRRaob39cJuQYG5x3tUquT
	 vOpD8lOO7ZPnHIe31j1PRGhrTNDMxvCM57Fdjzv3sQORWIdxb71VNGjCcLqtNibg1J
	 /bdR8W++yCqtsyG4bxcdV0MAYUn+go9q+pya4KZrQJYb34Bf5XYa+Hl/crV/UkmWMt
	 zQkq60jdU6xXg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 May 2024 12:26:37 +0200
Subject: [PATCH RFC HID 2/7] selftests/hid: fix bpf programs for the new
 attachment logic
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-hid_bpf_async_fun-v1-2-558375a25657@kernel.org>
References: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
In-Reply-To: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715164017; l=7780;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=bd0bpoEpyiLdDsGWlz0RnhORzoCPz+ID4XTIfN6BdpY=;
 b=mH6bdPSwcblq8+CUzC9rHRJxufsXsTLq/qcKkKsIW8FdyaHkhLr9xo47pKu7Fs+8xPSqrUcct
 KSsNmdbPASVBN2VQdRf0AeVqDhfrX14BtCD83r1zv1PFcYhddoqy9aZ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Now each program needs to ship its own attach prog. To make things
simpler we define __HID_BPF_PROG() and the various sub-macros per
hid-bpf type of program.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c              |  6 +---
 tools/testing/selftests/hid/progs/hid.c            | 40 +++++-----------------
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 29 +++++++++++++++-
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index f825623e3edc..7fed9f599b62 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -90,7 +90,6 @@ static unsigned char rdesc[] = {
 static __u8 feature_data[] = { 1, 2 };
 
 struct attach_prog_args {
-	int prog_fd;
 	unsigned int hid;
 	int retval;
 	int insert_head;
@@ -556,9 +555,6 @@ static void load_programs(const struct test_program programs[],
 	err = hid__load(self->skel);
 	ASSERT_OK(err) TH_LOG("hid_skel_load failed: %d", err);
 
-	attach_fd = bpf_program__fd(self->skel->progs.attach_prog);
-	ASSERT_GE(attach_fd, 0) TH_LOG("locate attach_prog: %d", attach_fd);
-
 	for (int i = 0; i < progs_count; i++) {
 		struct bpf_program *prog;
 
@@ -566,7 +562,7 @@ static void load_programs(const struct test_program programs[],
 							programs[i].name);
 		ASSERT_OK_PTR(prog) TH_LOG("can not find program by name '%s'", programs[i].name);
 
-		args.prog_fd = bpf_program__fd(prog);
+		attach_fd = bpf_program__fd(prog);
 		args.hid = self->hid_id;
 		args.insert_head = programs[i].insert_head;
 		err = bpf_prog_test_run_opts(attach_fd, &tattr);
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index f67d35def142..b721d1256836 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -4,18 +4,10 @@
 
 char _license[] SEC("license") = "GPL";
 
-struct attach_prog_args {
-	int prog_fd;
-	unsigned int hid;
-	int retval;
-	int insert_head;
-};
-
 __u64 callback_check = 52;
 __u64 callback2_check = 52;
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx)
+HID_BPF_DEVICE_EVENT(hid_first_event, struct hid_bpf_ctx *hid_ctx)
 {
 	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
 
@@ -29,8 +21,7 @@ int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx)
 	return hid_ctx->size;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_second_event, struct hid_bpf_ctx *hid_ctx)
+HID_BPF_DEVICE_EVENT(hid_second_event, struct hid_bpf_ctx *hid_ctx)
 {
 	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
 
@@ -42,8 +33,7 @@ int BPF_PROG(hid_second_event, struct hid_bpf_ctx *hid_ctx)
 	return hid_ctx->size;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_change_report_id, struct hid_bpf_ctx *hid_ctx)
+HID_BPF_DEVICE_EVENT(hid_change_report_id, struct hid_bpf_ctx *hid_ctx)
 {
 	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
 
@@ -55,16 +45,6 @@ int BPF_PROG(hid_change_report_id, struct hid_bpf_ctx *hid_ctx)
 	return 9;
 }
 
-SEC("syscall")
-int attach_prog(struct attach_prog_args *ctx)
-{
-	ctx->retval = hid_bpf_attach_prog(ctx->hid,
-					  ctx->prog_fd,
-					  ctx->insert_head ? HID_BPF_FLAG_INSERT_HEAD :
-							     HID_BPF_FLAG_NONE);
-	return 0;
-}
-
 struct hid_hw_request_syscall_args {
 	/* data needs to come at offset 0 so we can use it in calls */
 	__u8 data[10];
@@ -181,13 +161,12 @@ static const __u8 rdesc[] = {
 	0xc0,			/* END_COLLECTION */
 };
 
-SEC("?fmod_ret/hid_bpf_rdesc_fixup")
-int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hid_ctx)
+HID_BPF_RDESC_FIXUP(hid_rdesc_fixup, struct hid_bpf_ctx *hid_ctx)
 {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4096 /* size */);
 
 	if (!data)
-		return 0; /* EPERM check */
+		return -22; /* EPERM check */
 
 	callback2_check = data[4];
 
@@ -200,8 +179,7 @@ int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hid_ctx)
 	return sizeof(rdesc) + 73;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx)
+HID_BPF_DEVICE_EVENT(hid_test_insert1, struct hid_bpf_ctx *hid_ctx)
 {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
 
@@ -217,8 +195,7 @@ int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx)
 	return 0;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_test_insert2, struct hid_bpf_ctx *hid_ctx)
+HID_BPF_DEVICE_EVENT(hid_test_insert2, struct hid_bpf_ctx *hid_ctx)
 {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
 
@@ -234,8 +211,7 @@ int BPF_PROG(hid_test_insert2, struct hid_bpf_ctx *hid_ctx)
 	return 0;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_test_insert3, struct hid_bpf_ctx *hid_ctx)
+HID_BPF_DEVICE_EVENT(hid_test_insert3, struct hid_bpf_ctx *hid_ctx)
 {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
 
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 9cd56821d0f1..9826880e88d1 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -82,11 +82,20 @@ enum hid_bpf_attach_flags {
 	HID_BPF_FLAG_MAX,
 };
 
+struct attach_prog_args {
+	unsigned int hid;
+	int retval;
+	int insert_head;
+};
+
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,
 			      const size_t __sz) __ksym;
-extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
+extern int hid_bpf_attach_prog_impl(unsigned int hid_id,
+				    enum hid_bpf_prog_type type,
+				    int (prog_fn)(struct hid_bpf_ctx *hid_ctx),
+				    u32 flags, void *aux) __ksym;
 extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
 extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
 extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
@@ -101,4 +110,22 @@ extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
 				__u8 *data,
 				size_t buf__sz) __ksym;
 
+#define __HID_BPF_PROG(type, name, arg)                                                            \
+	static int __##name(arg);                                                                  \
+	SEC("syscall")                                                                             \
+	int name(struct attach_prog_args *ctx)                                                     \
+	{                                                                                          \
+		ctx->retval = hid_bpf_attach_prog_impl(ctx->hid,                                   \
+						  type,                                            \
+						  __##name,                                        \
+						  ctx->insert_head ? HID_BPF_FLAG_INSERT_HEAD :    \
+								     HID_BPF_FLAG_NONE,            \
+						  NULL);                                           \
+		return 0;                                                                          \
+	}                                                                                          \
+	static int __##name(arg)
+
+#define HID_BPF_DEVICE_EVENT(name, arg) __HID_BPF_PROG(HID_BPF_PROG_TYPE_DEVICE_EVENT, name, arg)
+#define HID_BPF_RDESC_FIXUP(name, arg) __HID_BPF_PROG(HID_BPF_PROG_TYPE_RDESC_FIXUP, name, arg)
+
 #endif /* __HID_BPF_HELPERS_H */

-- 
2.44.0


