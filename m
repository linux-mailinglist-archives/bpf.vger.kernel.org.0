Return-Path: <bpf+bounces-29054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA38BFAEC
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C648281766
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0BD7F7E4;
	Wed,  8 May 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dozZWbA7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858557F495;
	Wed,  8 May 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164032; cv=none; b=DtuZGZ4YkEG9zu8IYQEvB1AwPYr5QKF+EdWOwbgs17nW8tvJwOGwSDeK6D/sQ5rDUxRtLiuCo7rAcNvFtPa/VY+iuAcnIa8bgisMP0ot6LegIo+T4sRf6/bCed9NytfuE1E3Qt/4x83RU4byckWM0Em0QAxnq91Cv/1JLTgps+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164032; c=relaxed/simple;
	bh=yRElYtxSrjJS1S+NuYjEj+esa/1rVxgpScohSpbdgc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWAyETcBIN5i2jAw4CYkbn31fiNMg4FZteBaT6aULlPfpF6AAmgMl8HDum6R1+1sne0HoSyvCZEm0kGxII6HN2JA+82v9T7VrLIOaZOrVQKPLN9KM+bo8EMEAbFjJXkrIiHecz/TLShx6SspQ9zA8gEiFd8HahhfS2PxO0EuQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dozZWbA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE6CC113CC;
	Wed,  8 May 2024 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715164032;
	bh=yRElYtxSrjJS1S+NuYjEj+esa/1rVxgpScohSpbdgc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dozZWbA7Udmqltz21rs6/txk/ZyuLvUSu8sZRDh+dRSyzKSTqkbVtKGuTTG86S4eY
	 DIarepV3ngCrtn81Nh8Xkv24kNr1aZ+9K61Sjx0Y2eKZ6vxW3FGu4HB/RXLL9xI9BS
	 a2L5Oo6hHdzB5A8vYSaf77uUWsMkvUYTu0GuqmRVMAR6xv+hz9c3uXNwmBFfhquC8H
	 AogVnRwvXefw2dvQSY45EZmiwezmAriUbDb8uPJNCZBQB+mVAfuP+kE8QxPHQuCajW
	 olnycBuUP1ukhNGQvE+5JI5PfPbHQ79cjnKNVKmnSmuf5mJc2dagPREhbGLA0HPffg
	 9oaSkrhCJnzuQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 May 2024 12:26:38 +0200
Subject: [PATCH RFC HID 3/7] HID: bpf: allow for sleepable bpf hooks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-hid_bpf_async_fun-v1-3-558375a25657@kernel.org>
References: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
In-Reply-To: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715164017; l=9599;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=yRElYtxSrjJS1S+NuYjEj+esa/1rVxgpScohSpbdgc4=;
 b=enS81y14TCoq9l82YaO3J5dTidgfDU+CWpMW7s6skXSuJy/PDKOlP6grCCEKVDcReW5YT7XOD
 ph5OhtvimcPC9c6inZB6SQyuYFN2kf91Jbpm+SVqmxNqCy7hpgJ/IL5
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c  | 111 ++++++++++++++++++++++--------------
 drivers/hid/bpf/hid_bpf_dispatch.h  |   4 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c |  30 +++++++---
 3 files changed, 92 insertions(+), 53 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 81073db6c617..7ede657f459b 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -70,7 +70,7 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
 	memcpy(ctx_kern.data, data, *size);
 
-	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_DEVICE_EVENT, &ctx_kern);
+	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_DEVICE_EVENT, &ctx_kern, false);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
@@ -122,7 +122,7 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
 
 	memcpy(ctx_kern.data, rdesc, min_t(unsigned int, *size, HID_MAX_DESCRIPTOR_SIZE));
 
-	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RDESC_FIXUP, &ctx_kern);
+	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RDESC_FIXUP, &ctx_kern, false);
 	if (ret < 0)
 		goto ignore_bpf;
 
@@ -205,7 +205,7 @@ int hid_bpf_reconnect(struct hid_device *hdev)
 
 static int do_hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
 				  hid_bpf_cb_t prog_fn, struct bpf_prog *prog,
-				  __u32 flags)
+				  __u32 flags, bool sleepable)
 {
 	int fd, err;
 
@@ -213,7 +213,7 @@ static int do_hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_typ
 	if (err)
 		return err;
 
-	fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fn, prog, flags);
+	fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fn, prog, flags, sleepable);
 	if (fd < 0)
 		return fd;
 
@@ -228,6 +228,56 @@ static int do_hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_typ
 	return fd;
 }
 
+static int
+hid_bpf_attach_prog(unsigned int hid_id, enum hid_bpf_prog_type prog_type,
+		    hid_bpf_cb_t prog_fn, __u32 flags, void *prog__aux,
+		    bool sleepable)
+{
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)prog__aux;
+	struct bpf_prog *prog = aux->prog;
+	struct hid_device *hdev;
+	struct device *dev;
+	int err, fd;
+
+	if (!hid_bpf_ops)
+		return -EINVAL;
+
+	if ((flags & ~HID_BPF_FLAG_MASK))
+		return -EINVAL;
+
+	if (prog_type < 0 || prog_type >= HID_BPF_PROG_TYPE_MAX)
+		return -EINVAL;
+
+	dev = bus_find_device(hid_bpf_ops->bus_type, NULL, &hid_id, device_match_id);
+	if (!dev)
+		return -EINVAL;
+
+	hdev = to_hid_device(dev);
+
+	/*
+	 * take a ref on the prog itself, it will be released
+	 * on errors or when it'll be detached
+	 */
+	prog = bpf_prog_inc_not_zero(prog);
+	if (IS_ERR(prog)) {
+		err = PTR_ERR(prog);
+		goto out_dev_put;
+	}
+
+	fd = do_hid_bpf_attach_prog(hdev, prog_type, prog_fn, prog, flags, sleepable);
+	if (fd < 0) {
+		err = fd;
+		goto out_prog_put;
+	}
+
+	return fd;
+
+ out_prog_put:
+	bpf_prog_put(prog);
+ out_dev_put:
+	put_device(dev);
+	return err;
+}
 /* Disables missing prototype warnings */
 __bpf_kfunc_start_defs();
 
@@ -272,50 +322,22 @@ __bpf_kfunc int
 hid_bpf_attach_prog_impl(unsigned int hid_id, enum hid_bpf_prog_type prog_type,
 			 hid_bpf_cb_t prog_fn__async, __u32 flags, void *prog__aux)
 {
-	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)prog__aux;
-	struct bpf_prog *prog = aux->prog;
-	struct hid_device *hdev;
-	struct device *dev;
-	int err, fd;
-
-	if (!hid_bpf_ops)
-		return -EINVAL;
-
-	if ((flags & ~HID_BPF_FLAG_MASK))
-		return -EINVAL;
-
-	if (prog_type < 0 || prog_type >= HID_BPF_PROG_TYPE_MAX)
-		return -EINVAL;
+	return hid_bpf_attach_prog(hid_id, prog_type, prog_fn__async, flags, prog__aux, false);
+}
 
-	dev = bus_find_device(hid_bpf_ops->bus_type, NULL, &hid_id, device_match_id);
-	if (!dev)
+__bpf_kfunc int
+hid_bpf_attach_sleepable_prog_impl(unsigned int hid_id, enum hid_bpf_prog_type prog_type,
+				   hid_bpf_cb_t prog_fn__s_async, __u32 flags, void *prog__aux)
+{
+	switch (prog_type) {
+	case HID_BPF_PROG_TYPE_RAW_REQUEST:
+		/* OK */
+		break;
+	default:
 		return -EINVAL;
-
-	hdev = to_hid_device(dev);
-
-	/*
-	 * take a ref on the prog itself, it will be released
-	 * on errors or when it'll be detached
-	 */
-	prog = bpf_prog_inc_not_zero(prog);
-	if (IS_ERR(prog)) {
-		err = PTR_ERR(prog);
-		goto out_dev_put;
-	}
-
-	fd = do_hid_bpf_attach_prog(hdev, prog_type, prog_fn__async, prog, flags);
-	if (fd < 0) {
-		err = fd;
-		goto out_prog_put;
 	}
 
-	return fd;
-
- out_prog_put:
-	bpf_prog_put(prog);
- out_dev_put:
-	put_device(dev);
-	return err;
+	return hid_bpf_attach_prog(hid_id, prog_type, prog_fn__s_async, flags, prog__aux, true);
 }
 
 /**
@@ -538,6 +560,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(hid_bpf_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
 BTF_ID_FLAGS(func, hid_bpf_attach_prog_impl, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_attach_sleepable_prog_impl, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf_dispatch.h
index 60455a2af216..f9833603e49f 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.h
+++ b/drivers/hid/bpf/hid_bpf_dispatch.h
@@ -14,10 +14,10 @@ typedef int (*hid_bpf_cb_t)(struct hid_bpf_ctx *hid_ctx);
 
 int __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
 			  int (prog_fn__async)(struct hid_bpf_ctx *hid_ctx),
-			  struct bpf_prog *prog, __u32 flags);
+			  struct bpf_prog *prog, __u32 flags, bool sleepable);
 void __hid_bpf_destroy_device(struct hid_device *hdev);
 int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
-		     struct hid_bpf_ctx_kern *ctx_kern);
+		     struct hid_bpf_ctx_kern *ctx_kern, bool is_sleepable);
 int hid_bpf_reconnect(struct hid_device *hdev);
 
 struct bpf_prog;
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index 8d53d41b599b..4cceff354962 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -39,6 +39,7 @@ struct hid_bpf_prog_entry {
 struct hid_bpf_prog_cb {
 	struct bpf_prog *prog;
 	void *fn;
+	bool sleepable;
 };
 
 struct hid_bpf_jmp_table {
@@ -99,14 +100,20 @@ static int hid_bpf_program_count(struct hid_device *hdev,
 }
 
 int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
-		     struct hid_bpf_ctx_kern *ctx_kern)
+		     struct hid_bpf_ctx_kern *ctx_kern, bool is_sleepable)
 {
 	struct hid_bpf_prog_list *prog_list;
 	bpf_callback_t prog_fn;
 	int i, idx, err = 0;
 
-	rcu_read_lock();
-	prog_list = rcu_dereference(hdev->bpf.progs[type]);
+	if (is_sleepable) {
+		prog_list = READ_ONCE(hdev->bpf.progs[type]);
+		rcu_read_lock_trace();
+		might_fault();
+	} else {
+		rcu_read_lock();
+		prog_list = rcu_dereference(hdev->bpf.progs[type]);
+	}
 
 	if (!prog_list)
 		goto out_unlock;
@@ -117,6 +124,10 @@ int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 		if (!test_bit(idx, jmp_table.enabled))
 			continue;
 
+		/* prevent a sleepable program to be run in a non sleepable context */
+		if (!is_sleepable && jmp_table.prog_cbs[idx].sleepable)
+			continue;
+
 		ctx_kern->ctx.index = idx;
 		prog_fn = jmp_table.prog_cbs[idx].fn;
 		migrate_disable();
@@ -129,7 +140,10 @@ int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 	}
 
  out_unlock:
-	rcu_read_unlock();
+	if (is_sleepable)
+		rcu_read_unlock_trace();
+	else
+		rcu_read_unlock();
 
 	return err;
 }
@@ -279,7 +293,7 @@ static void hid_bpf_release_progs(struct work_struct *work)
  * Insert the given BPF program represented by its function call in the jmp table.
  * Returns the index in the jump table or a negative error.
  */
-static int hid_bpf_insert_prog(struct bpf_prog *prog, hid_bpf_cb_t prog_fn)
+static int hid_bpf_insert_prog(struct bpf_prog *prog, hid_bpf_cb_t prog_fn, bool sleepable)
 {
 	int i, index = -1, err = -EINVAL;
 
@@ -289,6 +303,7 @@ static int hid_bpf_insert_prog(struct bpf_prog *prog, hid_bpf_cb_t prog_fn)
 			/* mark the index as used */
 			jmp_table.prog_cbs[i].fn = prog_fn;
 			jmp_table.prog_cbs[i].prog = prog;
+			jmp_table.prog_cbs[i].sleepable = sleepable;
 			index = i;
 			__set_bit(i, jmp_table.enabled);
 		}
@@ -340,7 +355,8 @@ static const struct bpf_link_ops hid_bpf_link_lops = {
 /* called from syscall */
 noinline int
 __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
-		      hid_bpf_cb_t prog_fn, struct bpf_prog *prog, __u32 flags)
+		      hid_bpf_cb_t prog_fn, struct bpf_prog *prog, __u32 flags,
+		      bool sleepable)
 {
 	struct bpf_link_primer link_primer;
 	struct hid_bpf_link *link;
@@ -370,7 +386,7 @@ __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
 		goto err_unlock;
 	}
 
-	prog_table_idx = hid_bpf_insert_prog(prog, prog_fn);
+	prog_table_idx = hid_bpf_insert_prog(prog, prog_fn, sleepable);
 	/* if the jmp table is full, abort */
 	if (prog_table_idx < 0) {
 		err = prog_table_idx;

-- 
2.44.0


