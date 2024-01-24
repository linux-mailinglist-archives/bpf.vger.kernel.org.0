Return-Path: <bpf+bounces-20219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B3683A7C0
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 12:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141BC1C22441
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974021B805;
	Wed, 24 Jan 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+XBhu0r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A61B5B7;
	Wed, 24 Jan 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095633; cv=none; b=a3onsswWyhjlAUiuQPMJexa9LchGaHMQDImU2+sPa+fXMaAY/P0ikcodvyslCTqFtg/5uF4QlP4ROPQDuvi3HH8y2jxOe7DHyXlLR8pT4hbseRyDOrvNyUFFhk2CRiWE6q6r8l3qxQ2kkFiAjkpNeoK1f7ba3y17LYR5gIV+U5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095633; c=relaxed/simple;
	bh=uVELG2D3yAB3gDPQDcO8hwwRXTdJoMEq6wobEUQHMOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7g2Gd0v6RhwidDMstAdEhGqUsuPIWqbbXmqSGKfM2RyqdYkUEN/JqnM/suT1iylSGz7T1jFnXEJYCPliuBE3g8kw8g0Pqb3Ssb1gK8ZRrQDbuP81o2FwXAXGMvo+QTiES5SQmcAT+D4uAqp1/HlhzcmYgenFGP8hp3cA8VbvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+XBhu0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA31C433F1;
	Wed, 24 Jan 2024 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706095632;
	bh=uVELG2D3yAB3gDPQDcO8hwwRXTdJoMEq6wobEUQHMOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X+XBhu0rwUii8VGyeQxY2tkfehe3xSCsoaXh1hBZFb+XU8Xvk0yKcK2M8oHSP/IX2
	 ophtUdek+SQPVnbij+LGCv9PFggaWpr6yzfuDUU6c5E5mzKlybQ6DbtX0iFpQwSkCb
	 l96Vabgha7AMPke2hA/VvdYfEmtQAiihJKQc5fBoZEI4IzqC/rZuiWDcBQOqwXqLjf
	 qhxbmC1LV+LWkqidiSdszf2dXyaYGNBxbF1e54QHlt2AWn5jOuN1Du9UASTKBvA3++
	 c05/kND9agBpLFhIEHFg1DveqYTbzBS4wjNxNc7AdbNFcn7JwFBf3lB4G3J7cDAirC
	 ZNyoZmmgTYuSQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 24 Jan 2024 12:26:57 +0100
Subject: [PATCH v2 1/3] HID: bpf: remove double fdget()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-b4-hid-bpf-fixes-v2-1-052520b1e5e6@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706095628; l=6033;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=uVELG2D3yAB3gDPQDcO8hwwRXTdJoMEq6wobEUQHMOI=;
 b=apDsKIEWyNfCpXGZA6EyF/iv6Yn4XY2u2a08/LLp0roDFdowJu+uerjWhuu/Pk7YDMg7QLHWl
 B6X4xzJP+dXD4r5g3jSrZnJiJ+Vm7fYeGZe9mTgqav5v5KqSZnMifNq
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When the kfunc hid_bpf_attach_prog() is called, we called twice fdget():
one for fetching the type of the bpf program, and one for actually
attaching the program to the device.

The problem is that between those two calls, we have no guarantees that
the prog_fd is still the same file descriptor for the given program.

Solve this by calling bpf_prog_get() earlier, and use this to fetch the
program type.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/bpf/CAO-hwJJ8vh8JD3-P43L-_CLNmPx0hWj44aom0O838vfP4=_1CA@mail.gmail.com/T/#t
Cc: stable@vger.kernel.org
Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
* add missing Fixes tag in the commit description
---
 drivers/hid/bpf/hid_bpf_dispatch.c  | 66 ++++++++++++++++++++++++-------------
 drivers/hid/bpf/hid_bpf_dispatch.h  |  4 +--
 drivers/hid/bpf/hid_bpf_jmp_table.c | 20 ++---------
 3 files changed, 49 insertions(+), 41 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d9ef45fcaeab..5111d1fef0d3 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -241,6 +241,39 @@ int hid_bpf_reconnect(struct hid_device *hdev)
 	return 0;
 }
 
+static int do_hid_bpf_attach_prog(struct hid_device *hdev, int prog_fd, struct bpf_prog *prog,
+				  __u32 flags)
+{
+	int fd, err, prog_type;
+
+	prog_type = hid_bpf_get_prog_attach_type(prog);
+	if (prog_type < 0)
+		return prog_type;
+
+	if (prog_type >= HID_BPF_PROG_TYPE_MAX)
+		return -EINVAL;
+
+	if (prog_type == HID_BPF_PROG_TYPE_DEVICE_EVENT) {
+		err = hid_bpf_allocate_event_data(hdev);
+		if (err)
+			return err;
+	}
+
+	fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fd, prog, flags);
+	if (fd < 0)
+		return fd;
+
+	if (prog_type == HID_BPF_PROG_TYPE_RDESC_FIXUP) {
+		err = hid_bpf_reconnect(hdev);
+		if (err) {
+			close_fd(fd);
+			return err;
+		}
+	}
+
+	return fd;
+}
+
 /**
  * hid_bpf_attach_prog - Attach the given @prog_fd to the given HID device
  *
@@ -257,18 +290,13 @@ noinline int
 hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
 {
 	struct hid_device *hdev;
+	struct bpf_prog *prog;
 	struct device *dev;
-	int fd, err, prog_type = hid_bpf_get_prog_attach_type(prog_fd);
+	int fd;
 
 	if (!hid_bpf_ops)
 		return -EINVAL;
 
-	if (prog_type < 0)
-		return prog_type;
-
-	if (prog_type >= HID_BPF_PROG_TYPE_MAX)
-		return -EINVAL;
-
 	if ((flags & ~HID_BPF_FLAG_MASK))
 		return -EINVAL;
 
@@ -278,23 +306,17 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
 
 	hdev = to_hid_device(dev);
 
-	if (prog_type == HID_BPF_PROG_TYPE_DEVICE_EVENT) {
-		err = hid_bpf_allocate_event_data(hdev);
-		if (err)
-			return err;
-	}
+	/*
+	 * take a ref on the prog itself, it will be released
+	 * on errors or when it'll be detached
+	 */
+	prog = bpf_prog_get(prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
 
-	fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fd, flags);
+	fd = do_hid_bpf_attach_prog(hdev, prog_fd, prog, flags);
 	if (fd < 0)
-		return fd;
-
-	if (prog_type == HID_BPF_PROG_TYPE_RDESC_FIXUP) {
-		err = hid_bpf_reconnect(hdev);
-		if (err) {
-			close_fd(fd);
-			return err;
-		}
-	}
+		bpf_prog_put(prog);
 
 	return fd;
 }
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf_dispatch.h
index 63dfc8605cd2..fbe0639d09f2 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.h
+++ b/drivers/hid/bpf/hid_bpf_dispatch.h
@@ -12,9 +12,9 @@ struct hid_bpf_ctx_kern {
 
 int hid_bpf_preload_skel(void);
 void hid_bpf_free_links_and_skel(void);
-int hid_bpf_get_prog_attach_type(int prog_fd);
+int hid_bpf_get_prog_attach_type(struct bpf_prog *prog);
 int __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type, int prog_fd,
-			  __u32 flags);
+			  struct bpf_prog *prog, __u32 flags);
 void __hid_bpf_destroy_device(struct hid_device *hdev);
 int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 		     struct hid_bpf_ctx_kern *ctx_kern);
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index eca34b7372f9..12f7cebddd73 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -333,15 +333,10 @@ static int hid_bpf_insert_prog(int prog_fd, struct bpf_prog *prog)
 	return err;
 }
 
-int hid_bpf_get_prog_attach_type(int prog_fd)
+int hid_bpf_get_prog_attach_type(struct bpf_prog *prog)
 {
-	struct bpf_prog *prog = NULL;
-	int i;
 	int prog_type = HID_BPF_PROG_TYPE_UNDEF;
-
-	prog = bpf_prog_get(prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	int i;
 
 	for (i = 0; i < HID_BPF_PROG_TYPE_MAX; i++) {
 		if (hid_bpf_btf_ids[i] == prog->aux->attach_btf_id) {
@@ -350,8 +345,6 @@ int hid_bpf_get_prog_attach_type(int prog_fd)
 		}
 	}
 
-	bpf_prog_put(prog);
-
 	return prog_type;
 }
 
@@ -388,19 +381,13 @@ static const struct bpf_link_ops hid_bpf_link_lops = {
 /* called from syscall */
 noinline int
 __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
-		      int prog_fd, __u32 flags)
+		      int prog_fd, struct bpf_prog *prog, __u32 flags)
 {
 	struct bpf_link_primer link_primer;
 	struct hid_bpf_link *link;
-	struct bpf_prog *prog = NULL;
 	struct hid_bpf_prog_entry *prog_entry;
 	int cnt, err = -EINVAL, prog_table_idx = -1;
 
-	/* take a ref on the prog itself */
-	prog = bpf_prog_get(prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
-
 	mutex_lock(&hid_bpf_attach_lock);
 
 	link = kzalloc(sizeof(*link), GFP_USER);
@@ -467,7 +454,6 @@ __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
  err_unlock:
 	mutex_unlock(&hid_bpf_attach_lock);
 
-	bpf_prog_put(prog);
 	kfree(link);
 
 	return err;

-- 
2.43.0


