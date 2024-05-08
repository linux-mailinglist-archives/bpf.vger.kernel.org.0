Return-Path: <bpf+bounces-29057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB548BFAF5
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787941F22687
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361DE80C04;
	Wed,  8 May 2024 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twAoqDhV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913180BE3;
	Wed,  8 May 2024 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164043; cv=none; b=mT0Nw1tDFSKbbbgXPhH0m/208SMrOho6z4Dt51jng8mWVExDXTkLhl7QOxraMrTIeOj8c/WcJVHeQ8R/mGdt51F3iSALeUglm1AQM2NvDJ33mrolpknBdnAbfN7Oi5CPX8uffX9bLJjz490I7oztGjcS0MpV1vItTr7k8vFb0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164043; c=relaxed/simple;
	bh=9waEZf/wX6l7KSv3TGWZ2a108xaQGTbk2eaVsTu2CFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQpotUruvX8iUNP6wd9/va9LAU2snu+fKPWwXlkQLM3CvRcRyi+sMr34mXEP7ANwStPu8dOlCB77DGBPZxN61Vv1DIv9x14jCQgD9W0ob2RtJi0geQ0Vaf29NF51kXLFZuTfZiRzjT5Sr/5D3GBiU3NIrdE4hgUIW8BGvWjjtzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twAoqDhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CCBC113CC;
	Wed,  8 May 2024 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715164043;
	bh=9waEZf/wX6l7KSv3TGWZ2a108xaQGTbk2eaVsTu2CFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=twAoqDhVc6j+5cG9bW/+SnuFXZ3pnTIo2y+Gk+ayDG0rjPn4uPRlGk2H9ojZ2RPHf
	 jC5xlsET5/XMxYps4uA2N8IVhKu8/8S+H6n7qWZXavKTVQ8DLwNqB58gPV4xM3ebH/
	 iYuONRYgXYBbmhLI/pPziCOnwqiY9UL/salBWxBSoXJBH89rm0DpZNmREPoZS+XAti
	 yKLp/URvcrbf/hs6PkyB8689xqahuHt4dDHjRz5b/oc3+FRjvu05k12cNTlUbY2R9p
	 oZ/OspzoWTtshJiljk7jVX6+kxivQUE+QKyFd7Rpz21/hWYuCKbXPXdd7BYqxG5Ze5
	 xagE4OLoPb6jA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 May 2024 12:26:41 +0200
Subject: [PATCH RFC HID 6/7] WIP: selftests/hid: add tests for
 hid_hw_raw_request HID-BPF hooks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-hid_bpf_async_fun-v1-6-558375a25657@kernel.org>
References: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
In-Reply-To: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715164017; l=8381;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=9waEZf/wX6l7KSv3TGWZ2a108xaQGTbk2eaVsTu2CFc=;
 b=HYLnB3YF5tVYYctI5AVxJ0cl2CSHeXhATB4kXQdS4os/a2n8SPgf/9Ta30cNl2pc2X4p1Y5yK
 DshsY4hqrQHDCHCd0UR+0sFqMypD9zTVGD6HxnBy1EzEVrqUA7uFCNJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c              | 55 ++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 51 ++++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 39 +++++++++------
 3 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 7fed9f599b62..522fc32a5c38 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -469,6 +469,8 @@ static void detach_bpf(FIXTURE_DATA(hid_bpf) * self)
 		close(self->hidraw_fd);
 	self->hidraw_fd = 0;
 
+	// hid__detach(self->skel);
+
 	for (i = 0; i < ARRAY_SIZE(self->hid_links); i++) {
 		if (self->hid_links[i])
 			close(self->hid_links[i]);
@@ -572,6 +574,8 @@ static void load_programs(const struct test_program programs[],
 		self->hid_links[i] = args.retval;
 	}
 
+	// hid__attach(self->skel);
+
 	self->hidraw_fd = open_hidraw(self->dev_id);
 	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
 }
@@ -871,6 +875,57 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
 	ASSERT_EQ(args.data[1], 2);
 }
 
+/*
+ * Call hid_hw_raw_request against the given uhid device,
+ * check that the program is called and does the expected.
+ */
+TEST_F(hid_bpf, test_hid_filter_raw_request_call)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_filter_raw_request" },
+		{ .name = "hid_test_raw_request" },
+	};
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* first check that we did not attach to device_event */
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 42);
+	ASSERT_EQ(buf[2], 0) TH_LOG("leftovers_from_previous_test");
+
+	/* now check that our program is preventing hid_hw_raw_request() */
+
+	/* emit hid_hw_raw_request from hidraw */
+	/* Get Feature */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 0x1; /* Report Number */
+	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	ASSERT_LT(err, 0) TH_LOG("unexpected success while reading HIDIOCGFEATURE: %d", err);
+
+	/* remove our bpf program and check that we can now emit commands */
+
+	/* detach the program */
+	detach_bpf(self);
+
+	self->hidraw_fd = open_hidraw(self->dev_id);
+	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
+
+	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	ASSERT_GE(err, 0) TH_LOG("error while reading HIDIOCGFEATURE: %d", err);
+}
+
 /*
  * Attach hid_insert{0,1,2} to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index b721d1256836..64aaa279bec4 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -226,3 +226,54 @@ HID_BPF_DEVICE_EVENT(hid_test_insert3, struct hid_bpf_ctx *hid_ctx)
 
 	return 0;
 }
+
+// SEC("fentry/hidraw_open")
+// int BPF_PROG(hidraw_open, struct inode *inode, struct file *file)
+// {
+// 	bpf_printk("inode: %llx, file: %llx", (u64)inode, (u64)file);
+// 	return 0;
+// }
+
+HID_BPF_RAW_REQUEST(hid_test_filter_raw_request, struct hid_bpf_ctx *hctx)
+{
+	bpf_printk("in %s:%d", __func__, __LINE__);
+	return 0;
+}
+
+HID_BPF_SLEEPABLE_RAW_REQUEST(hid_test_raw_request, struct hid_bpf_ctx *hctx)
+{
+	struct test_report buf = {
+		.data = {2, 3, 4, 5, 6, 7},
+	};
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 2 /* size */);
+	int ret;
+
+	bpf_printk("in %s, hctx: %llx source: %llx", __func__, (u64)hctx, hctx->source);
+
+	if (!data)
+		return 0; /* EPERM check */
+	bpf_printk("in %s:%d", __func__, __LINE__);
+
+	if (hctx->source) {
+		hid_bpf_input_report(hctx, HID_INPUT_REPORT, buf.data, sizeof(buf.data));
+
+		/* still forward the request as-is to the device, hid-bpf will not
+		 * call us again.
+		 */
+
+		data[0] = hctx->reportnum;
+
+		ret = hid_bpf_hw_request(hctx,
+					 data,
+					 2,
+					 hctx->report_type,
+					 hctx->reqtype);
+		bpf_printk("ret: %d", ret);
+		if (ret)
+			return ret;
+		return -1;
+	}
+
+	bpf_printk("in %s:%d", __func__, __LINE__);
+	return 0;
+}
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 9826880e88d1..779ec151c717 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -56,17 +56,6 @@ enum hid_report_type {
 	HID_REPORT_TYPES,
 };
 
-struct hid_bpf_ctx {
-	__u32 index;
-	const struct hid_device *hid;
-	__u32 allocated_size;
-	enum hid_report_type report_type;
-	union {
-		__s32 retval;
-		__s32 size;
-	};
-} __attribute__((preserve_access_index));
-
 enum hid_class_request {
 	HID_REQ_GET_REPORT		= 0x01,
 	HID_REQ_GET_IDLE		= 0x02,
@@ -88,6 +77,20 @@ struct attach_prog_args {
 	int insert_head;
 };
 
+struct hid_bpf_ctx {
+	__u32 index;
+	__u32 allocated_size;
+	__u64 source;
+	const struct hid_device *hid;
+	enum hid_report_type report_type;
+	enum hid_class_request reqtype; /* for HID_BPF_PROG_TYPE_RAW_REQUEST */
+	union {
+		__s32 retval;
+		__s32 size;
+	};
+	__u8 reportnum;
+} __attribute__((preserve_access_index));
+
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,
@@ -96,6 +99,10 @@ extern int hid_bpf_attach_prog_impl(unsigned int hid_id,
 				    enum hid_bpf_prog_type type,
 				    int (prog_fn)(struct hid_bpf_ctx *hid_ctx),
 				    u32 flags, void *aux) __ksym;
+extern int hid_bpf_attach_sleepable_prog_impl(unsigned int hid_id,
+					      enum hid_bpf_prog_type type,
+					      int (prog_fn)(struct hid_bpf_ctx *hid_ctx),
+					      u32 flags, void *aux) __ksym;
 extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
 extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
 extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
@@ -110,12 +117,12 @@ extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
 				__u8 *data,
 				size_t buf__sz) __ksym;
 
-#define __HID_BPF_PROG(type, name, arg)                                                            \
+#define __HID_BPF_PROG(type, name, arg, sleepable)                                                 \
 	static int __##name(arg);                                                                  \
 	SEC("syscall")                                                                             \
 	int name(struct attach_prog_args *ctx)                                                     \
 	{                                                                                          \
-		ctx->retval = hid_bpf_attach_prog_impl(ctx->hid,                                   \
+		ctx->retval = hid_bpf_attach_##sleepable##prog_impl(ctx->hid,                      \
 						  type,                                            \
 						  __##name,                                        \
 						  ctx->insert_head ? HID_BPF_FLAG_INSERT_HEAD :    \
@@ -125,7 +132,9 @@ extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
 	}                                                                                          \
 	static int __##name(arg)
 
-#define HID_BPF_DEVICE_EVENT(name, arg) __HID_BPF_PROG(HID_BPF_PROG_TYPE_DEVICE_EVENT, name, arg)
-#define HID_BPF_RDESC_FIXUP(name, arg) __HID_BPF_PROG(HID_BPF_PROG_TYPE_RDESC_FIXUP, name, arg)
+#define HID_BPF_DEVICE_EVENT(name, arg) __HID_BPF_PROG(HID_BPF_PROG_TYPE_DEVICE_EVENT, name, arg, )
+#define HID_BPF_RDESC_FIXUP(name, arg) __HID_BPF_PROG(HID_BPF_PROG_TYPE_RDESC_FIXUP, name, arg, )
+#define HID_BPF_RAW_REQUEST(name, arg) __HID_BPF_PROG(HID_BPF_PROG_TYPE_RAW_REQUEST, name, arg, )
+#define HID_BPF_SLEEPABLE_RAW_REQUEST(name, arg) __HID_BPF_PROG(HID_BPF_PROG_TYPE_RAW_REQUEST, name, arg, sleepable_)
 
 #endif /* __HID_BPF_HELPERS_H */

-- 
2.44.0


