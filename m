Return-Path: <bpf+bounces-40417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F39886E1
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9551F22A4A
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0458175B;
	Fri, 27 Sep 2024 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhdjbVpe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DCF191;
	Fri, 27 Sep 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446670; cv=none; b=teANBmqAYXYoD/loesA8si7469Z8MHDH21qYHxCHOycsbxd0d1lQc58uKbHcYc3C+8AnJgxS/LivteK0RYaPojk2/PZPTIF5gmVtt0bFVWPJyLANAdBUwkqZSNv+k3vvr5yE2qPus3YpVB1hroULy3drYv2l0ZeK7ml6d9vMU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446670; c=relaxed/simple;
	bh=1TuZ25MJ9whfide80+hSRQq95cprrnR1mCj7R+DiV5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EsaC1+Qolaat/9WKeGO/XDNa6rWkZLmALCy5c2nAw1mRTd4RFtXB8un4+GuRSqOgRgDie0tpfCXGeAxKAIXVc7s5WkVHgS+PfDZ77au2sY2XnMiIFSqCR1o5ICcO94NslIyXbLtaYU8TQPuN027KTI7EytuOnhXPvClARbhloH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhdjbVpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A6DC4CEC4;
	Fri, 27 Sep 2024 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727446669;
	bh=1TuZ25MJ9whfide80+hSRQq95cprrnR1mCj7R+DiV5A=;
	h=From:Date:Subject:To:Cc:From;
	b=PhdjbVpeVFwFAoX4Bx6STsjMaOYkSeN2GC25bPK7AoYbuu8wzObifBRDKBOOtN4sZ
	 PEbsk50p/pLH880ju37ulcEIUBSbkmcX/aji4tdrTOAZtNUHYGe5JwaY0HjcNRsgGr
	 8yQenHlkv7DJSGSrkkhUs5OKIrXDDKjgNXZ7kmIno8N0tGtoF0Z7jqPk5rC1DwVyXS
	 bfRp0FdyYgqW6yD94o+3QeB7F5fZL9+tG1nZkE1W/5HxgvonYI6Ek3X6l99mluGHQP
	 7Kdfg6bgeiTNzF9Mkj6QIMI/WIU3bRxCj84mD0qRP9Iui2+2D+UWy/SmY4dhqd0CCM
	 ZXQRam5hiLKhw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 27 Sep 2024 16:17:41 +0200
Subject: [PATCH HID] HID: bpf: fix cfi stubs for hid_bpf_ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-fix-hid-bpf-stubs-v1-1-5bbf125f247c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIS+9mYC/x2MOQqAMBAAvyJbuxDjbW2hbxALj41uoyGrIoh/N
 1gOzMwDQo5JoAoecHSx8L55iMIApnXYFkKePYNWOlGlztHwjSvPOFqDcpyjoClUWkZDlseTBt9
 ZR176nx00bQ39+343fHP3aAAAAA==
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, stable@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727446666; l=2048;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=1TuZ25MJ9whfide80+hSRQq95cprrnR1mCj7R+DiV5A=;
 b=yCMgfsrFEDdJDNrozHUfZNJzFPJooHAd09U2ZfloFYeJJ7xf4kGO/EB7BfOjuFwBmM0wHq3nm
 FfvbevSB0l/AFHYER4e4xj/crN/2v6+q5KEBliO8QtV/EmxVjZIWJrA
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

With the introduction of commit e42ac1418055 ("bpf: Check unsupported ops
from the bpf_struct_ops's cfi_stubs"), a HID-BPF struct_ops containing
a .hid_hw_request() or a .hid_hw_output_report() was failing to load
as the cfi stubs were not defined.

Fix that by defining those simple static functions and restore HID-BPF
functionality.

This was detected with the HID selftests suddenly failing on Linus' tree.

Cc: stable@vger.kernel.org # v6.11+
Fixes: 9286675a2aed ("HID: bpf: add HID-BPF hooks for hid_hw_output_report")
Fixes: 8bd0488b5ea5 ("HID: bpf: add HID-BPF hooks for hid_hw_raw_requests")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Hi,

This commit should directly go in Linus tree before we start creating
topic branches for 6.13 given that the CI is now failing on our HID
master branch.

Cheers,
Benjamin
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index cd696c59ba0f..702c22fae136 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -276,9 +276,23 @@ static int __hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx)
 	return 0;
 }
 
+static int __hid_bpf_hw_request(struct hid_bpf_ctx *ctx, unsigned char reportnum,
+				enum hid_report_type rtype, enum hid_class_request reqtype,
+				u64 source)
+{
+	return 0;
+}
+
+static int __hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, u64 source)
+{
+	return 0;
+}
+
 static struct hid_bpf_ops __bpf_hid_bpf_ops = {
 	.hid_device_event = __hid_bpf_device_event,
 	.hid_rdesc_fixup = __hid_bpf_rdesc_fixup,
+	.hid_hw_request = __hid_bpf_hw_request,
+	.hid_hw_output_report = __hid_bpf_hw_output_report,
 };
 
 static struct bpf_struct_ops bpf_hid_bpf_ops = {

---
base-commit: 13882369ceb9b0953f9f5ff8563bbccfd80d0ffd
change-id: 20240927-fix-hid-bpf-stubs-f80591a673c2

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


