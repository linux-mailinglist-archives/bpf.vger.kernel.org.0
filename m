Return-Path: <bpf+bounces-29056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD08BFAF2
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21829285717
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560427E107;
	Wed,  8 May 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2QLi5fR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A027E0E8;
	Wed,  8 May 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164040; cv=none; b=atvHGMBNG/2u74C/F4zWgCmbiT5DHW7W54nt1CodldYPzmifW7lExF0XwfxKHya1PSLOUPHw91yjYo1w3JPjUDFFWZ2ODMc+ui9zoPkZeei8g3BaouGZmrxeaWRbAWDB5UoIBCjMtsOuEIJ7Cc9u6p6+UPmUonzHt0JNXX9EHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164040; c=relaxed/simple;
	bh=txXRaEv7XsztZIwd1QMmXQ5xKR9I4Ul3ciQ/A1mmLcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WV5/6LRgqDPXd4oQ5FkMBaqKNQ6ftPK5mjAZeLoCaGF0d3A1njyZloNehLS3/64WvUrQBt7hFQ91VYdJw1b2R6zRMDn0WKUQbxsNjGSfrrMAJz7jf9NhfxINUFhR0Bh133spM3zzKFsoKT+fxaMxdoJamkqaiIWrcxYjKow2xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2QLi5fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41BCC4AF18;
	Wed,  8 May 2024 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715164039;
	bh=txXRaEv7XsztZIwd1QMmXQ5xKR9I4Ul3ciQ/A1mmLcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L2QLi5fRZV/71Rjv1JJblXbwrMhWq9Vy3QlW3Ly4C9Z/PYBrfEhepzmVpw0j/gF50
	 SPPzN5oKGK1mHB5QBzzTos/oFhDQcVZ+9jsCIJU6ynNs+ZbrgwkSZ6y2Hp8eh6pBna
	 4IzVLtT9RQCgPYnMzbhFdFqpkZQBxWyGcrHOg5Z5Zh7z+ask5bz+IWKhh5xsJ/3Dck
	 fNVk0lIHrxmlLlWHIr6aPG/VRUvXa8Wc4oWb2tKwPvkHxHSQQ6DVfL38xFaGXvQrQ8
	 GQJfsX8W/8vtlJMpHN64s0trzmEjTYUIzFJWyu9q6Oul9l0DwWpA8En8XFkLEGEFXE
	 Te0XxqfDvQbvg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 May 2024 12:26:40 +0200
Subject: [PATCH RFC HID 5/7] WIP: add HID-BPF hooks for hid_hw_raw_requests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-hid_bpf_async_fun-v1-5-558375a25657@kernel.org>
References: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
In-Reply-To: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715164017; l=6301;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=txXRaEv7XsztZIwd1QMmXQ5xKR9I4Ul3ciQ/A1mmLcA=;
 b=L5vkE3xhw8Z/gzOf0YnEwlQX83vc50UzQR01r/jIQk8ZrQryPIXJGR8MxbYYKFaR2ous+QCEl
 PuOab/R8o2YBSEdLwWKb51LeHgojBUF6LLf8e7gW4Yzq3xO30BW163u
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

---
 drivers/hid/bpf/hid_bpf_dispatch.c  | 51 +++++++++++++++++++++++++++++++++++++
 drivers/hid/bpf/hid_bpf_jmp_table.c |  1 +
 drivers/hid/hid-core.c              |  8 +++++-
 include/linux/hid_bpf.h             | 14 ++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 55c9e74c2465..7aeab3f9f2c7 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -45,6 +45,11 @@ __weak noinline int hid_bpf_device_event(struct hid_bpf_ctx *ctx)
 	return 0;
 }
 
+__weak noinline int hid_bpf_raw_request(struct hid_bpf_ctx *ctx)
+{
+	return 0;
+}
+
 u8 *
 dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type, u8 *data,
 			      u32 *size, int interrupt, u64 source)
@@ -71,6 +76,9 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
 	memcpy(ctx_kern.data, data, *size);
 
+	if (*size)
+		ctx_kern.ctx.reportnum = data[0];
+
 	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_DEVICE_EVENT, &ctx_kern, false);
 	if (ret < 0)
 		return ERR_PTR(ret);
@@ -86,6 +94,49 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 }
 EXPORT_SYMBOL_GPL(dispatch_hid_bpf_device_event);
 
+u8 *
+dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
+			      unsigned char reportnum, u8 *buf,
+			      u32 *size, enum hid_report_type rtype,
+			      enum hid_class_request reqtype,
+			      u64 source)
+{
+	struct hid_bpf_ctx_kern ctx_kern = {
+		.ctx = {
+			.hid = hdev,
+			.report_type = rtype,
+			.reqtype = reqtype,
+			.allocated_size = *size,
+			.size = *size,
+			.source = source,
+			.reportnum = reportnum,
+		},
+		.data = buf,
+	};
+	int ret;
+
+	if (rtype >= HID_REPORT_TYPES)
+		return ERR_PTR(-EINVAL);
+
+	/* no program has been attached yet */
+	// if (!hdev->bpf.device_data)
+	// 	return buf;
+
+	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RAW_REQUEST, &ctx_kern, true);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (ret) {
+		if (ret > ctx_kern.ctx.allocated_size)
+			return ERR_PTR(-EINVAL);
+
+		*size = ret;
+	}
+
+	return ctx_kern.data;
+}
+EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
+
 /**
  * hid_bpf_rdesc_fixup - Called when the probe function parses the report
  * descriptor of the HID device
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index 4cceff354962..e183dc2835c7 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -64,6 +64,7 @@ static int hid_bpf_max_programs(enum hid_bpf_prog_type type)
 {
 	switch (type) {
 	case HID_BPF_PROG_TYPE_DEVICE_EVENT:
+	case HID_BPF_PROG_TYPE_RAW_REQUEST:
 		return HID_BPF_MAX_PROGS_PER_DEV;
 	case HID_BPF_PROG_TYPE_RDESC_FIXUP:
 		return 1;
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b8414ce62e7b..7d468f6dbefe 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2407,6 +2407,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 			 __u64 source)
 {
 	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
+	u32 size = (u32)len; /* max_buffer_size is 16 KB */
 
 	if (hdev->ll_driver->max_buffer_size)
 		max_buffer_size = hdev->ll_driver->max_buffer_size;
@@ -2414,7 +2415,12 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 	if (len < 1 || len > max_buffer_size || !buf)
 		return -EINVAL;
 
-	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
+	buf = dispatch_hid_bpf_raw_requests(hdev, reportnum, buf, &size, rtype,
+			      reqtype, source);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	return hdev->ll_driver->raw_request(hdev, reportnum, buf, size,
 					    rtype, reqtype);
 }
 
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 6bcaf19f1cc2..1cd36bfdd608 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -52,10 +52,12 @@ struct hid_bpf_ctx {
 	__u64 source;
 	const struct hid_device *hid;
 	enum hid_report_type report_type;
+	enum hid_class_request reqtype; /* for HID_BPF_PROG_TYPE_RAW_REQUEST */
 	union {
 		__s32 retval;
 		__s32 size;
 	};
+	__u8 reportnum;
 };
 
 /**
@@ -77,6 +79,7 @@ enum hid_bpf_attach_flags {
 /* Following functions are tracepoints that BPF programs can attach to */
 int hid_bpf_device_event(struct hid_bpf_ctx *ctx);
 int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx);
+int hid_bpf_raw_request(struct hid_bpf_ctx *ctx);
 
 /*
  * Below is HID internal
@@ -90,6 +93,7 @@ enum hid_bpf_prog_type {
 	HID_BPF_PROG_TYPE_UNDEF = -1,
 	HID_BPF_PROG_TYPE_DEVICE_EVENT,			/* an event is emitted from the device */
 	HID_BPF_PROG_TYPE_RDESC_FIXUP,
+	HID_BPF_PROG_TYPE_RAW_REQUEST,
 	HID_BPF_PROG_TYPE_MAX,
 };
 
@@ -140,6 +144,11 @@ struct hid_bpf_link {
 #ifdef CONFIG_HID_BPF
 u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
 				  u32 *size, int interrupt, u64 source);
+u8 *dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
+				  unsigned char reportnum, __u8 *buf,
+				  u32 *size, enum hid_report_type rtype,
+				  enum hid_class_request reqtype,
+				  __u64 source);
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
@@ -149,6 +158,11 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
 						u8 *data, u32 *size, int interrupt,
 						u64 source) { return data; }
+static inline u8 *dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
+						unsigned char reportnum, u8 *buf,
+						u32 *size, enum hid_report_type rtype,
+						enum hid_class_request reqtype,
+						u64 source) { return buf; }
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}

-- 
2.44.0


