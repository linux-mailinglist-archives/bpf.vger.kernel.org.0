Return-Path: <bpf+bounces-29055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D5B8BFAEF
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90824B2288A
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF917F495;
	Wed,  8 May 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWXo+zV3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBC7FBC3;
	Wed,  8 May 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164036; cv=none; b=Ey7TZAVIVYfcXqmmkeSR65Q+KM7zy/btPCEcItCA3TGP+vzzpSbgS9/48tIWKA6TL0EDKPj0Z5ms9x/U5EbtptvuWJyuC4arG/KhKRsY5+sPmirwNbVDTsiJkEloiaJzwPHzFKPxK41mBOBm0gHARfVY2OpDqypCfwfhyjrSkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164036; c=relaxed/simple;
	bh=QftTIl+0wkJZCH+Lrp6cD6bPgP7GsHhL1DjA/BXgbXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sY3g906KzIHqlCzssbd9ykdU6kUGSOW/z9PoqEX1IPJMgR2AfNyh4vRSw6bn8Qzpk01BdGEUuRQwuki/Em8saloayijakKGNqfZ+XMS3PM0G3JCGodnOf0eR203KNdFzinBIk0yImuOSr5SiKJTxpdCZSaIddGwa4NJl/RVD/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWXo+zV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D442CC113CC;
	Wed,  8 May 2024 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715164036;
	bh=QftTIl+0wkJZCH+Lrp6cD6bPgP7GsHhL1DjA/BXgbXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IWXo+zV3IUH4v68Mg7onrb8YXeW5h+vdC97PPkHMRMF/I1tnwON38S69ghDoUBps7
	 aiQK0/KYEkkb9KPcArT2KgyKhl6SsnG8W8YolHsSRDbQ0HrK92uhjQNS+8Ccspky56
	 jqxKwVBYFp598Kwspxo5d/Ede8YqykPK9l03M1/oCk1PMlb30IhZQrPCVznnt7xsiZ
	 B3rsvuA6JElQBilXY075lX4QNmlWfIwp7h+G7QgfYhp9Xt1NR8aCITciRSIA27W4sR
	 QYkP7Zc0OL+sOLaFo8Pmrk0pmmaU+LV7Q4KVX4ELxCXcPmlo2Tc9LfiMwKBxha83Nj
	 9IYyhvCDUlmqA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 May 2024 12:26:39 +0200
Subject: [PATCH RFC HID 4/7] HID: add source argument to HID low level
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-hid_bpf_async_fun-v1-4-558375a25657@kernel.org>
References: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
In-Reply-To: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715164017; l=11681;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=QftTIl+0wkJZCH+Lrp6cD6bPgP7GsHhL1DjA/BXgbXo=;
 b=RtlkKlyG6QlTinCSzRb8csYtaUbWMKGHM0np5rqv0GpNR0O1JdYG69sKX2WIzIccmFb/+I5lI
 z3EJ4R7eGjJDKji7ofWNPbNVn0slLYdLwNNJKiMHXWkrFKsTlwZ1qUv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This allows to know who actually sent what when we process the request
to the device.
This will be useful for a BPF firewall program to allow or not requests
coming from a dedicated hidraw node client.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 11 +++--
 drivers/hid/hid-core.c             | 85 ++++++++++++++++++++++++--------------
 drivers/hid/hidraw.c               | 10 ++---
 include/linux/hid.h                |  6 +++
 include/linux/hid_bpf.h            | 16 ++++---
 5 files changed, 81 insertions(+), 47 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 7ede657f459b..55c9e74c2465 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -47,7 +47,7 @@ __weak noinline int hid_bpf_device_event(struct hid_bpf_ctx *ctx)
 
 u8 *
 dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type, u8 *data,
-			      u32 *size, int interrupt)
+			      u32 *size, int interrupt, u64 source)
 {
 	struct hid_bpf_ctx_kern ctx_kern = {
 		.ctx = {
@@ -55,6 +55,7 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 			.report_type = type,
 			.allocated_size = hdev->bpf.allocated_data,
 			.size = *size,
+			.source = source,
 		},
 		.data = hdev->bpf.device_data,
 	};
@@ -483,7 +484,8 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      dma_data,
 					      size,
 					      rtype,
-					      reqtype);
+					      reqtype,
+					      (__u64)ctx);
 
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
@@ -522,7 +524,8 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 
 	ret = hid_bpf_ops->hid_hw_output_report(hdev,
 						dma_data,
-						size);
+						size,
+						(__u64)ctx);
 
 	kfree(dma_data);
 	return ret;
@@ -553,7 +556,7 @@ hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf
 
 	hdev = (struct hid_device *)ctx->hid; /* discard const */
 
-	return hid_bpf_ops->hid_input_report(hdev, type, buf, size, 0);
+	return hid_bpf_ops->hid_input_report(hdev, type, buf, size, 0, (__u64)ctx);
 }
 __bpf_kfunc_end_defs();
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b1fa0378e8f4..b8414ce62e7b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2026,19 +2026,9 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 }
 EXPORT_SYMBOL_GPL(hid_report_raw_event);
 
-/**
- * hid_input_report - report data from lower layer (usb, bt...)
- *
- * @hid: hid device
- * @type: HID report type (HID_*_REPORT)
- * @data: report contents
- * @size: size of data parameter
- * @interrupt: distinguish between interrupt and control transfers
- *
- * This is data entry for lower layers.
- */
-int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
-		     int interrupt)
+
+static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
+			      u8 *data, u32 size, int interrupt, u64 source)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
@@ -2058,7 +2048,7 @@ int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data
 	report_enum = hid->report_enum + type;
 	hdrv = hid->driver;
 
-	data = dispatch_hid_bpf_device_event(hid, type, data, &size, interrupt);
+	data = dispatch_hid_bpf_device_event(hid, type, data, &size, interrupt, source);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto unlock;
@@ -2093,6 +2083,23 @@ int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data
 	up(&hid->driver_input_lock);
 	return ret;
 }
+
+/**
+ * hid_input_report - report data from lower layer (usb, bt...)
+ *
+ * @hid: hid device
+ * @type: HID report type (HID_*_REPORT)
+ * @data: report contents
+ * @size: size of data parameter
+ * @interrupt: distinguish between interrupt and control transfers
+ *
+ * This is data entry for lower layers.
+ */
+int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
+		     int interrupt)
+{
+	return __hid_input_report(hid, type, data, size, interrupt, 0);
+}
 EXPORT_SYMBOL_GPL(hid_input_report);
 
 bool hid_match_one_id(const struct hid_device *hdev,
@@ -2393,6 +2400,24 @@ void hid_hw_request(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(hid_hw_request);
 
+int __hid_hw_raw_request(struct hid_device *hdev,
+			 unsigned char reportnum, __u8 *buf,
+			 size_t len, enum hid_report_type rtype,
+			 enum hid_class_request reqtype,
+			 __u64 source)
+{
+	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
+
+	if (hdev->ll_driver->max_buffer_size)
+		max_buffer_size = hdev->ll_driver->max_buffer_size;
+
+	if (len < 1 || len > max_buffer_size || !buf)
+		return -EINVAL;
+
+	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
+					    rtype, reqtype);
+}
+
 /**
  * hid_hw_raw_request - send report request to device
  *
@@ -2410,6 +2435,12 @@ EXPORT_SYMBOL_GPL(hid_hw_request);
 int hid_hw_raw_request(struct hid_device *hdev,
 		       unsigned char reportnum, __u8 *buf,
 		       size_t len, enum hid_report_type rtype, enum hid_class_request reqtype)
+{
+	return __hid_hw_raw_request(hdev, reportnum, buf, len, rtype, reqtype, 0);
+}
+EXPORT_SYMBOL_GPL(hid_hw_raw_request);
+
+int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source)
 {
 	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
 
@@ -2419,10 +2450,11 @@ int hid_hw_raw_request(struct hid_device *hdev,
 	if (len < 1 || len > max_buffer_size || !buf)
 		return -EINVAL;
 
-	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
-					    rtype, reqtype);
+	if (hdev->ll_driver->output_report)
+		return hdev->ll_driver->output_report(hdev, buf, len);
+
+	return -ENOSYS;
 }
-EXPORT_SYMBOL_GPL(hid_hw_raw_request);
 
 /**
  * hid_hw_output_report - send output report to device
@@ -2435,18 +2467,7 @@ EXPORT_SYMBOL_GPL(hid_hw_raw_request);
  */
 int hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len)
 {
-	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
-
-	if (hdev->ll_driver->max_buffer_size)
-		max_buffer_size = hdev->ll_driver->max_buffer_size;
-
-	if (len < 1 || len > max_buffer_size || !buf)
-		return -EINVAL;
-
-	if (hdev->ll_driver->output_report)
-		return hdev->ll_driver->output_report(hdev, buf, len);
-
-	return -ENOSYS;
+	return __hid_hw_output_report(hdev, buf, len, 0);
 }
 EXPORT_SYMBOL_GPL(hid_hw_output_report);
 
@@ -2973,9 +2994,9 @@ EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
 #ifdef CONFIG_HID_BPF
 static struct hid_bpf_ops hid_ops = {
 	.hid_get_report = hid_get_report,
-	.hid_hw_raw_request = hid_hw_raw_request,
-	.hid_hw_output_report = hid_hw_output_report,
-	.hid_input_report = hid_input_report,
+	.hid_hw_raw_request = __hid_hw_raw_request,
+	.hid_hw_output_report = __hid_hw_output_report,
+	.hid_input_report = __hid_input_report,
 	.owner = THIS_MODULE,
 	.bus_type = &hid_bus_type,
 };
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 2bc762d31ac7..6d2a6d38e42a 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -140,7 +140,7 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 
 	if ((report_type == HID_OUTPUT_REPORT) &&
 	    !(dev->quirks & HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP)) {
-		ret = hid_hw_output_report(dev, buf, count);
+		ret = __hid_hw_output_report(dev, buf, count, (__u64)file);
 		/*
 		 * compatibility with old implementation of USB-HID and I2C-HID:
 		 * if the device does not support receiving output reports,
@@ -150,8 +150,8 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 			goto out_free;
 	}
 
-	ret = hid_hw_raw_request(dev, buf[0], buf, count, report_type,
-				HID_REQ_SET_REPORT);
+	ret = __hid_hw_raw_request(dev, buf[0], buf, count, report_type,
+				   HID_REQ_SET_REPORT, (__u64)file);
 
 out_free:
 	kfree(buf);
@@ -227,8 +227,8 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 		goto out_free;
 	}
 
-	ret = hid_hw_raw_request(dev, report_number, buf, count, report_type,
-				 HID_REQ_GET_REPORT);
+	ret = __hid_hw_raw_request(dev, report_number, buf, count, report_type,
+				   HID_REQ_GET_REPORT, (__u64)file);
 
 	if (ret < 0)
 		goto out_free;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8e06d89698e6..dac2804b4562 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1125,6 +1125,12 @@ int __must_check hid_hw_open(struct hid_device *hdev);
 void hid_hw_close(struct hid_device *hdev);
 void hid_hw_request(struct hid_device *hdev,
 		    struct hid_report *report, enum hid_class_request reqtype);
+int __hid_hw_raw_request(struct hid_device *hdev,
+			 unsigned char reportnum, __u8 *buf,
+			 size_t len, enum hid_report_type rtype,
+			 enum hid_class_request reqtype,
+			 __u64 source);
+int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source);
 int hid_hw_raw_request(struct hid_device *hdev,
 		       unsigned char reportnum, __u8 *buf,
 		       size_t len, enum hid_report_type rtype,
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 99ebe7bbb02a..6bcaf19f1cc2 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -48,8 +48,9 @@ struct hid_device;
  */
 struct hid_bpf_ctx {
 	__u32 index;
-	const struct hid_device *hid;
 	__u32 allocated_size;
+	__u64 source;
+	const struct hid_device *hid;
 	enum hid_report_type report_type;
 	union {
 		__s32 retval;
@@ -99,10 +100,12 @@ struct hid_bpf_ops {
 	int (*hid_hw_raw_request)(struct hid_device *hdev,
 				  unsigned char reportnum, __u8 *buf,
 				  size_t len, enum hid_report_type rtype,
-				  enum hid_class_request reqtype);
-	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len);
+				  enum hid_class_request reqtype,
+				  __u64 source);
+	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
+				    __u64 source);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
-				u8 *data, u32 size, int interrupt);
+				u8 *data, u32 size, int interrupt, u64 source);
 	struct module *owner;
 	const struct bus_type *bus_type;
 };
@@ -136,7 +139,7 @@ struct hid_bpf_link {
 
 #ifdef CONFIG_HID_BPF
 u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
-				  u32 *size, int interrupt);
+				  u32 *size, int interrupt, u64 source);
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
@@ -144,7 +147,8 @@ void hid_bpf_device_init(struct hid_device *hid);
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size);
 #else /* CONFIG_HID_BPF */
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
-						u8 *data, u32 *size, int interrupt) { return data; }
+						u8 *data, u32 *size, int interrupt,
+						u64 source) { return data; }
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}

-- 
2.44.0


