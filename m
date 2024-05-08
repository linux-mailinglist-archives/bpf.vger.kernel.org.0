Return-Path: <bpf+bounces-29058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB958BFAF8
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3BE280DB1
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC281729;
	Wed,  8 May 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW/Vy9Ib"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D981205;
	Wed,  8 May 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164047; cv=none; b=dHEpGDOvhKDKVT4xYZqpgRiywgsliYblr7/i+aSd1zFeUcXpy1utrnqaj2ykJ8wtXaIkEtYT4pAhonMvBj6Wc1dSLxhQDyIrrnxKTVEXYUIla534nS7gBmI/5knM8bvzd/cjhSfOS8XhkhHIGzkGe+1SlIMlwF8UepR5Mo9fKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164047; c=relaxed/simple;
	bh=gUKFJUJPIS9WSId/kAlnSuXYsqfcoTxB16GBAeCmvtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBKS7nZbMkrmCtTMRKHWUj5Sr1rhNOylokKVymU7G4886rF7RLBFcjAAT298uf+nf/wD9GgQycWQwso4wIekCKLUJWemmOZOtsZrH/CPQq0iKhDmt2J362JhSjqMuY2rOGXL6WR+X7waHyr00M0HZsFELFthgwh1WwGUVxKYag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW/Vy9Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C82C113CC;
	Wed,  8 May 2024 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715164046;
	bh=gUKFJUJPIS9WSId/kAlnSuXYsqfcoTxB16GBAeCmvtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BW/Vy9IbQHb6Xu1wRBvlOofA1YOU0lJykkWaritCmqUuu82LaZPvVSmzavHJHYAGv
	 KJ5e5cVTv51gGM8WAgzeyss9pf7Y+bKSe/O4h1YJzKVmRdU33YNxSYvrYmaTXaC85M
	 31PQ0G7uuQp/3CelVX7u/yVbr9ouxiaY/X724DKJM+rO7XjdyJm9nPSedm22ewCyYc
	 KIc3uWMU7INsxwsblwsfFTrRqiKsL02mRHapHByqGH3WACX1NGHTk5znv+yYj4YmcS
	 qf0OEjbCznyTHLkdJQ3cKWEjxWRCEGFzvlBMAqY+9sASq9q/T2p3NJVBtwGHtacuU0
	 rB9y1qGx0hMKg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 May 2024 12:26:42 +0200
Subject: [PATCH RFC HID 7/7] HID: bpf: prevent infinite recursions with
 hid_hw_raw_requests hooks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-hid_bpf_async_fun-v1-7-558375a25657@kernel.org>
References: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
In-Reply-To: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715164017; l=6266;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=gUKFJUJPIS9WSId/kAlnSuXYsqfcoTxB16GBAeCmvtM=;
 b=0bdx+qfpQLf9Bz1Uqnyq7kMhIlO/zMh96gqCYtYn9gWtjJlHx6wCndVGc6OyN4s5jmDj+RZtN
 HrqpptNkGzUCZCimmxCtyLvnNQ/y3DJ1PkfkFrenAxEd8/e00SPShD6
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When we attach a sleepable hook to hid_hw_raw_requests, we can (and in
many cases should) call ourself hid_bpf_raw_request(), to actaully fetch
data from the device itself.

However, this means that we might enter an infinite loop between
hid_hw_raw_requests trace and hid_bpf_raw_request() call.

To prevent that, if a hid_bpf_raw_request() call is emitted, we prevent
any sleepable bpf trace to hid_hw_raw_requests(). This way we can always
trace/monitor/filter the incoming bpf requests, while preventing those
loops to happen.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 7 ++++---
 drivers/hid/hid-core.c             | 6 +++---
 drivers/hid/hidraw.c               | 4 ++--
 include/linux/hid.h                | 2 +-
 include/linux/hid_bpf.h            | 6 +++---
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 7aeab3f9f2c7..79cac293ba29 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -99,7 +99,7 @@ dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 			      unsigned char reportnum, u8 *buf,
 			      u32 *size, enum hid_report_type rtype,
 			      enum hid_class_request reqtype,
-			      u64 source)
+			      u64 source, bool from_bpf)
 {
 	struct hid_bpf_ctx_kern ctx_kern = {
 		.ctx = {
@@ -122,7 +122,7 @@ dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 	// if (!hdev->bpf.device_data)
 	// 	return buf;
 
-	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RAW_REQUEST, &ctx_kern, true);
+	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RAW_REQUEST, &ctx_kern, !from_bpf);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
@@ -536,7 +536,8 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      size,
 					      rtype,
 					      reqtype,
-					      (__u64)ctx);
+					      (__u64)ctx,
+					      true); /* prevent infinite recursions */
 
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7d468f6dbefe..d53f465a4ccb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2404,7 +2404,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 			 unsigned char reportnum, __u8 *buf,
 			 size_t len, enum hid_report_type rtype,
 			 enum hid_class_request reqtype,
-			 __u64 source)
+			 __u64 source, bool from_bpf)
 {
 	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
 	u32 size = (u32)len; /* max_buffer_size is 16 KB */
@@ -2416,7 +2416,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 		return -EINVAL;
 
 	buf = dispatch_hid_bpf_raw_requests(hdev, reportnum, buf, &size, rtype,
-			      reqtype, source);
+			      reqtype, source, from_bpf);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -2442,7 +2442,7 @@ int hid_hw_raw_request(struct hid_device *hdev,
 		       unsigned char reportnum, __u8 *buf,
 		       size_t len, enum hid_report_type rtype, enum hid_class_request reqtype)
 {
-	return __hid_hw_raw_request(hdev, reportnum, buf, len, rtype, reqtype, 0);
+	return __hid_hw_raw_request(hdev, reportnum, buf, len, rtype, reqtype, 0, false);
 }
 EXPORT_SYMBOL_GPL(hid_hw_raw_request);
 
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 6d2a6d38e42a..4ba3131de614 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -151,7 +151,7 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 	}
 
 	ret = __hid_hw_raw_request(dev, buf[0], buf, count, report_type,
-				   HID_REQ_SET_REPORT, (__u64)file);
+				   HID_REQ_SET_REPORT, (__u64)file, false);
 
 out_free:
 	kfree(buf);
@@ -228,7 +228,7 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	}
 
 	ret = __hid_hw_raw_request(dev, report_number, buf, count, report_type,
-				   HID_REQ_GET_REPORT, (__u64)file);
+				   HID_REQ_GET_REPORT, (__u64)file, false);
 
 	if (ret < 0)
 		goto out_free;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index dac2804b4562..24d0d7c0bd33 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1129,7 +1129,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 			 unsigned char reportnum, __u8 *buf,
 			 size_t len, enum hid_report_type rtype,
 			 enum hid_class_request reqtype,
-			 __u64 source);
+			 __u64 source, bool from_bpf);
 int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source);
 int hid_hw_raw_request(struct hid_device *hdev,
 		       unsigned char reportnum, __u8 *buf,
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 1cd36bfdd608..6b2ac815572c 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -105,7 +105,7 @@ struct hid_bpf_ops {
 				  unsigned char reportnum, __u8 *buf,
 				  size_t len, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
-				  __u64 source);
+				  __u64 source, bool from_bpf);
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
 				    __u64 source);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
@@ -148,7 +148,7 @@ u8 *dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  unsigned char reportnum, __u8 *buf,
 				  u32 *size, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
-				  __u64 source);
+				  __u64 source, bool from_bpf);
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
@@ -162,7 +162,7 @@ static inline u8 *dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 						unsigned char reportnum, u8 *buf,
 						u32 *size, enum hid_report_type rtype,
 						enum hid_class_request reqtype,
-						u64 source) { return buf; }
+						u64 source, bool from_bpf) { return buf; }
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}

-- 
2.44.0


