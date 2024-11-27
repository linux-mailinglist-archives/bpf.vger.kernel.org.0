Return-Path: <bpf+bounces-45727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52CD9DABEE
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4960DB22BFB
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BEF200BB3;
	Wed, 27 Nov 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QcKYLaJS"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D21194125;
	Wed, 27 Nov 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725726; cv=none; b=q9YOuYO55rJ2wombu2xWRDtgQsLlPEkv1ICjrNvUDPPgCNX7vZpctPul5R8WtVgj6jjnrGpkJUuJ4Zh66cBKEovCIQLLEGc9O6WBO5MuxIeCNBuprNyapwnCROt4ae6jvhGQOlRyAo4PoqkbrXF+Ew+1xD35aSnusyNHvvJH2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725726; c=relaxed/simple;
	bh=erQtu4JgZKngcUhIzaKILRT4/skRmzyFTgWtono2Tkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eivAFLubduB32rnFOgORf7z1HKV3ZkvvzPvsJJplGr74WqWdJZ8u/HJBjejiW9nEk1RyscpUp/S4QzvfmxSCGiUFXAQdzyNCTw9XG425waIOar5j7K1GcVt0HdfRCfJjaVVJlKYtPHlfL+Ag/Uc0+eVy8tYCCXqmvoGBFRuiq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QcKYLaJS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732725720;
	bh=erQtu4JgZKngcUhIzaKILRT4/skRmzyFTgWtono2Tkk=;
	h=From:Date:Subject:To:Cc:From;
	b=QcKYLaJS1KIA/YGIqoiZGUc8D46x1XRRpakYNSGyxb4ac35c0CzpTLi42VFrjjRru
	 L2YNzG7Vp8P8QNW3og9gbeLRQZvflYQPSPEzg3A13ZKJ+VoRGpmSHRh1yBoy8Ug6d/
	 ZiNIuWAfoQKn2QqMjkJXwquIRzyuXOl0r7Xt5WHk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 17:41:56 +0100
Subject: [PATCH] HID: bpf: constify hid_ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-hid-bpf-ops-v1-1-f9e41bfa3afd@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANNLR2cC/x3MQQqAIBBA0avIrBtQEYyuEi20xpyNikIE4t2Tl
 m/xf4dGlanBJjpUerhxThNqEXBGl25CvqZBS22U0hYjX+hLwFwa+mDV6pzR5CXMolQK/P63/Rj
 jAx8Cwl5dAAAA
X-Change-ID: 20241127-hid-bpf-ops-bf718aa42eb0
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732725719; l=1974;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=erQtu4JgZKngcUhIzaKILRT4/skRmzyFTgWtono2Tkk=;
 b=5lMgAu8lsd7wE8RTgxVU349OaG9xJ/astH2bDYBldY179e9rFI2kxuVFcq009okk5h6EKqb+y
 TAaJaT6+QGyC5AakWic27feTww5wIkPZZjsghiXRVovDCVx4fck/kpg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The hid_ops struct is never modified. Mark it as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 2 +-
 drivers/hid/hid-core.c             | 2 +-
 include/linux/hid_bpf.h            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 961b7f35aa673618abbb7bf2edc18cd3ef7c90f4..e8be9ab51d6323b6ee356be3f7c49b958984fb59 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include "hid_bpf_dispatch.h"
 
-struct hid_ops *hid_ops;
+const struct hid_ops *hid_ops;
 EXPORT_SYMBOL(hid_ops);
 
 u8 *
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 98bef39642a9e3008e60a60fa887b8328ccd50f5..33a19197332488bd232dcee510d9da9ffec770bc 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -3064,7 +3064,7 @@ int hid_check_keys_pressed(struct hid_device *hid)
 EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
 
 #ifdef CONFIG_HID_BPF
-static struct hid_ops __hid_ops = {
+static const struct hid_ops __hid_ops = {
 	.hid_get_report = hid_get_report,
 	.hid_hw_raw_request = __hid_hw_raw_request,
 	.hid_hw_output_report = __hid_hw_output_report,
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index a6876ab29004892b78eb32135ec52cd0417503fe..a2e47dbcf82c8bbbc547ebc18c82e11bfe8c6236 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -78,7 +78,7 @@ struct hid_ops {
 	const struct bus_type *bus_type;
 };
 
-extern struct hid_ops *hid_ops;
+extern const struct hid_ops *hid_ops;
 
 /**
  * struct hid_bpf_ops - A BPF struct_ops of callbacks allowing to attach HID-BPF

---
base-commit: aaf20f870da056752f6386693cc0d8e25421ef35
change-id: 20241127-hid-bpf-ops-bf718aa42eb0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


