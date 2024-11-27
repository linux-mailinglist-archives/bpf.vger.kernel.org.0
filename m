Return-Path: <bpf+bounces-45728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D99DABF1
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B9AB239D1
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCE200BB6;
	Wed, 27 Nov 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="G+29scSU"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9232200BA7;
	Wed, 27 Nov 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725773; cv=none; b=irQgX/1pirPZOOCiga4pDNtEpk4VDRsgDu+DaTCB0/TifDS3YIH7JY8tF+nzrCBIRIHW0dPCR5fB73Xk4JVRVKGTUBF86HVnyhFcpyan2UX1JYzFF7OKFRa6L6bFj/tcxZ5gNNtQL3M7lPaVs2rVpWPi0yFV/foVzW6gZ7bv5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725773; c=relaxed/simple;
	bh=gYEm5B35nIqK8/VYxZLl5rw6/UAnKfqXCZ4Y6fVdcK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FBi2zOoxPtMJTBZmBaoYg5rxynTkrFJ/u+XZn59RTFa/O51NSDRQGh2FSa6T6/gE22RuDKueutIY6zfJgtaaI47+rvG+3jyCpa4T4C6uwCKbwW08l7B2q0ef+4lMUIzzagx+UUNY+IaDsreM+yjxALMVOuM1ZkSNvyStWVe1fcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=G+29scSU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732725768;
	bh=gYEm5B35nIqK8/VYxZLl5rw6/UAnKfqXCZ4Y6fVdcK0=;
	h=From:Date:Subject:To:Cc:From;
	b=G+29scSU7ixvk4g/uC8xB3XZeRTiw8MjzXTTD87YkOtkPK7eSftI2F7RI2pACEFsy
	 i4u8VniohsPVB4hRCCfmvuWoBGagi+fOzgqBs/VqSWjwDYKOZwc5ItsxunC0VxMF2Q
	 NalHGNoONe+C+L8CnNAi5+DwGiuzZLrjP1v7e0/U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 17:42:47 +0100
Subject: [PATCH] HID: bpf: drop unneeded casts discarding const
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-hid-bpf-cast-v1-1-f26424960e84@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAZMR2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNz3YzMFN2kgjTd5MTiEt1UYyMzE4s0sySLNHMloJaCotS0zAqwcdG
 xtbUAn/ppVl4AAAA=
X-Change-ID: 20241127-hid-bpf-cast-e32648f6b8f7
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732725768; l=2876;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gYEm5B35nIqK8/VYxZLl5rw6/UAnKfqXCZ4Y6fVdcK0=;
 b=uo2iRztWNgZDb/AESeKPjybJmDbHTDN1qIq/1WvZQVtNIkNs+OW4VUULtxLb/U3x/ryHJplad
 9S2b2W/WmrPD7PhjsQbtx51+KJTmPnMst6lV/8DRJvRFXCiQ4LW9eQl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In commit 33c0fb85b571 ("HID: bpf: make part of struct hid_device writable")
the const qualifier was dropped from struct hid_bpf_ctx::hid.
The casts are now unnecessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 961b7f35aa673618abbb7bf2edc18cd3ef7c90f4..ec950f8164e20192dd2ddb7753af19cca6c1a036 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -352,7 +352,6 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
 {
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
-	struct hid_device *hdev;
 	u32 report_len;
 
 	/* check arguments */
@@ -371,9 +370,7 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
 	if (*buf__sz < 1)
 		return -EINVAL;
 
-	hdev = (struct hid_device *)ctx->hid; /* discard const */
-
-	report_enum = hdev->report_enum + rtype;
+	report_enum = ctx->hid->report_enum + rtype;
 	report = hid_ops->hid_get_report(report_enum, buf);
 	if (!report)
 		return -EINVAL;
@@ -402,7 +399,6 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 		   enum hid_report_type rtype, enum hid_class_request reqtype)
 {
 	struct hid_bpf_ctx_kern *ctx_kern;
-	struct hid_device *hdev;
 	size_t size = buf__sz;
 	u8 *dma_data;
 	int ret;
@@ -429,13 +425,11 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 		return -EINVAL;
 	}
 
-	hdev = (struct hid_device *)ctx->hid; /* discard const */
-
 	dma_data = kmemdup(buf, size, GFP_KERNEL);
 	if (!dma_data)
 		return -ENOMEM;
 
-	ret = hid_ops->hid_hw_raw_request(hdev,
+	ret = hid_ops->hid_hw_raw_request(ctx->hid,
 					      dma_data[0],
 					      dma_data,
 					      size,
@@ -464,7 +458,6 @@ __bpf_kfunc int
 hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 {
 	struct hid_bpf_ctx_kern *ctx_kern;
-	struct hid_device *hdev;
 	size_t size = buf__sz;
 	u8 *dma_data;
 	int ret;
@@ -478,13 +471,11 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 	if (ret)
 		return ret;
 
-	hdev = (struct hid_device *)ctx->hid; /* discard const */
-
 	dma_data = kmemdup(buf, size, GFP_KERNEL);
 	if (!dma_data)
 		return -ENOMEM;
 
-	ret = hid_ops->hid_hw_output_report(hdev, dma_data, size, (u64)(long)ctx, true);
+	ret = hid_ops->hid_hw_output_report(ctx->hid, dma_data, size, (u64)(long)ctx, true);
 
 	kfree(dma_data);
 	return ret;

---
base-commit: aaf20f870da056752f6386693cc0d8e25421ef35
change-id: 20241127-hid-bpf-cast-e32648f6b8f7

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


