Return-Path: <bpf+bounces-20220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F84E83A7C4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 12:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC23C28A64A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B0D2C697;
	Wed, 24 Jan 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttT56/t6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89520B27;
	Wed, 24 Jan 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095635; cv=none; b=ZJlkJ3U62KhM6R8tUIqCQM08IM/87ZL8fFBeYXH5CFOgL0ugeIGRXm9+BJoF6QlPAQ0qnQ9ybI389EcI7dhGZ73ulV64MlzcErkQPsC83zdW3bKV/B+Pb1uSXCp3xfupudm5Q2jYgLYWQu7rjr7ie0o1BLK8t0jpZxzBrt9qrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095635; c=relaxed/simple;
	bh=XHE/yawxz8RP6uJcT7i19Grs5czFtDjl1+kkvP0DkQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rui87B5Ju719/Xelw+422TqEWGoXFPPVsOM8yPxkyhmo14ofYXRZBh1egXp/FLsoRDVE8LFxybOOYAutIiH2e78EumWpMJz98phRtJTVD76z0OizLbI6Umr+7kf6+RJVfIBOWunic6u8UQr3T59TlfFmOan5pl2+FdU8x8c0Fvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttT56/t6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09869C43399;
	Wed, 24 Jan 2024 11:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706095634;
	bh=XHE/yawxz8RP6uJcT7i19Grs5czFtDjl1+kkvP0DkQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ttT56/t6i1u1e5GXsUuJC+f7xIL9+QcELG2F3VeRyseqTPe1F+BsTtXYJmBxPkLG1
	 nuBAL2U1CawbfAXGql8UfQwpNAoQxlWie1kjKZqL4J3ZFa+f56nJAkYe+mhkvG1xRS
	 JBZ8leE3SzaD4QHFulF+wNfL3Wg/EyOpOTtY35WTd2tBWxP+AWLs9U2oDJkyTkoiBj
	 ikKlPfCJhYSH2EutoEUXYyOX10kVsWsWTa6XdO8nq+V8r5K1zs2IaQdNy/to46BiJI
	 CDwJgK180lromW5euyeHXMl/cJLZXZ5Q7uqS7x/2Kqo4T4VxEW+Sgknp5B2seZGj+s
	 P6kTkcrmjE8Pw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 24 Jan 2024 12:26:58 +0100
Subject: [PATCH v2 2/3] HID: bpf: actually free hdev memory after attaching
 a HID-BPF program
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-b4-hid-bpf-fixes-v2-2-052520b1e5e6@kernel.org>
References: <20240124-b4-hid-bpf-fixes-v2-0-052520b1e5e6@kernel.org>
In-Reply-To: <20240124-b4-hid-bpf-fixes-v2-0-052520b1e5e6@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706095628; l=4059;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=XHE/yawxz8RP6uJcT7i19Grs5czFtDjl1+kkvP0DkQ4=;
 b=QXqr+XUGPx4hzl/DZp/IzeoVCAwBH9PIvKU4rjuY/ybMH0dhuWa7kuZr72lTOv7WjPns+RfYs
 tFiXVXeNMTWD8AW4hUb+pzlj/UgwcjwpUcevoB0cyl4hySH0FWdNZM1
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that I got my reference counts wrong and each successful
bus_find_device() actually calls get_device(), and we need to manually
call put_device().

Ensure each bus_find_device() gets a matching put_device() when releasing
the bpf programs and fix all the error paths.

Cc: stable@vger.kernel.org
Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c  | 29 +++++++++++++++++++++++------
 drivers/hid/bpf/hid_bpf_jmp_table.c | 19 ++++++++++++++++---
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 5111d1fef0d3..7903c8638e81 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -292,7 +292,7 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
 	struct hid_device *hdev;
 	struct bpf_prog *prog;
 	struct device *dev;
-	int fd;
+	int err, fd;
 
 	if (!hid_bpf_ops)
 		return -EINVAL;
@@ -311,14 +311,24 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
 	 * on errors or when it'll be detached
 	 */
 	prog = bpf_prog_get(prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	if (IS_ERR(prog)) {
+		err = PTR_ERR(prog);
+		goto out_dev_put;
+	}
 
 	fd = do_hid_bpf_attach_prog(hdev, prog_fd, prog, flags);
-	if (fd < 0)
-		bpf_prog_put(prog);
+	if (fd < 0) {
+		err = fd;
+		goto out_prog_put;
+	}
 
 	return fd;
+
+ out_prog_put:
+	bpf_prog_put(prog);
+ out_dev_put:
+	put_device(dev);
+	return err;
 }
 
 /**
@@ -345,8 +355,10 @@ hid_bpf_allocate_context(unsigned int hid_id)
 	hdev = to_hid_device(dev);
 
 	ctx_kern = kzalloc(sizeof(*ctx_kern), GFP_KERNEL);
-	if (!ctx_kern)
+	if (!ctx_kern) {
+		put_device(dev);
 		return NULL;
+	}
 
 	ctx_kern->ctx.hid = hdev;
 
@@ -363,10 +375,15 @@ noinline void
 hid_bpf_release_context(struct hid_bpf_ctx *ctx)
 {
 	struct hid_bpf_ctx_kern *ctx_kern;
+	struct hid_device *hid;
 
 	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
+	hid = (struct hid_device *)ctx_kern->ctx.hid; /* ignore const */
 
 	kfree(ctx_kern);
+
+	/* get_device() is called by bus_find_device() */
+	put_device(&hid->dev);
 }
 
 /**
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index 12f7cebddd73..85a24bc0ea25 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -196,6 +196,7 @@ static void __hid_bpf_do_release_prog(int map_fd, unsigned int idx)
 static void hid_bpf_release_progs(struct work_struct *work)
 {
 	int i, j, n, map_fd = -1;
+	bool hdev_destroyed;
 
 	if (!jmp_table.map)
 		return;
@@ -220,6 +221,12 @@ static void hid_bpf_release_progs(struct work_struct *work)
 		if (entry->hdev) {
 			hdev = entry->hdev;
 			type = entry->type;
+			/*
+			 * hdev is still valid, even if we are called after hid_destroy_device():
+			 * when hid_bpf_attach() gets called, it takes a ref on the dev through
+			 * bus_find_device()
+			 */
+			hdev_destroyed = hdev->bpf.destroyed;
 
 			hid_bpf_populate_hdev(hdev, type);
 
@@ -232,12 +239,18 @@ static void hid_bpf_release_progs(struct work_struct *work)
 				if (test_bit(next->idx, jmp_table.enabled))
 					continue;
 
-				if (next->hdev == hdev && next->type == type)
+				if (next->hdev == hdev && next->type == type) {
+					/*
+					 * clear the hdev reference and decrement the device ref
+					 * that was taken during bus_find_device() while calling
+					 * hid_bpf_attach()
+					 */
 					next->hdev = NULL;
+					put_device(&hdev->dev);
 			}
 
-			/* if type was rdesc fixup, reconnect device */
-			if (type == HID_BPF_PROG_TYPE_RDESC_FIXUP)
+			/* if type was rdesc fixup and the device is not gone, reconnect device */
+			if (type == HID_BPF_PROG_TYPE_RDESC_FIXUP && !hdev_destroyed)
 				hid_bpf_reconnect(hdev);
 		}
 	}

-- 
2.43.0


