Return-Path: <bpf+bounces-44458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC3C9C31CD
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 12:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D51C209AA
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C4156257;
	Sun, 10 Nov 2024 11:37:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A414F9FA
	for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731238648; cv=none; b=t4kygroD271gP32TODWbliWEGUQw66AzbchMrTwH39J+rJAnXMKGlenldWdC5HNQ0tdFqIGPjRc0JAeKACP7NMoBYoPlKbtm3izrqXSTwppUlHVTTOAZhTXFHoSnKxpmTg3rI5GX4IrgO78yMHjpjI0vOZ7GP6epZINlktT+p8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731238648; c=relaxed/simple;
	bh=NsWxdg8hRbhORbjcHCZpqKvkIgcFT+cqM/gCQ7gU1r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRCVpQARvweEB5vnW1SnXdpUyBzGeyFnu2Ymhif/gLSj/eACwGh+arI3jbtdzfShGAPxL/zcQ1gxwSUVpgIe6uN9FpvzPSfrcn5ScTe1dFthohwiw3+rhn3pvL4BZYyUIPCDmk9pHkBFq02ebHutMEEpAF7YxtbBvqm0tgj+vzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	aspsk@isovalent.com,
	kees@kernel.org,
	quic_abchauha@quicinc.com,
	martin.kelly@crowdstrike.com,
	mykolal@fb.com,
	shuah@kernel.org,
	yikai.lin@vivo.com,
	Florian Lehner <dev@der-flo.net>
Subject: [bpf-next 1/2] bpf: Add flag to continue batch operation
Date: Sun, 10 Nov 2024 12:29:03 +0100
Message-ID: <20241110112905.64616-2-dev@der-flo.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241110112905.64616-1-dev@der-flo.net>
References: <20241110112905.64616-1-dev@der-flo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce flag for batch operations to continue batch deletes when missing
keys are encountered. This allows to flush maps at once without the need to
keep track of the keys in a map.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/syscall.c           | 14 +++++++++++---
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4162afc6b5d0..b38884cf6fe3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1423,6 +1423,11 @@ enum {
  */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
+/* Flags for batch operations. */
+
+/* If set, continue with batch operation even if a key is missing. */
+#define BPF_F_BATCH_IGNORE_MISSING_KEY		(1U << 1)
+
 /* Flags for BPF_PROG_TEST_RUN */
 
 /* If set, run the test on the cpu specified by bpf_attr.test.cpu */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 58190ca724a2..860d6dc0c6d9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1851,7 +1851,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 			     union bpf_attr __user *uattr)
 {
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
-	u32 cp, max_count;
+	u32 count, cp, max_count;
 	int err = 0;
 	void *key;
 
@@ -1874,6 +1874,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!key)
 		return -ENOMEM;
 
+	count = 0;
 	for (cp = 0; cp < max_count; cp++) {
 		err = -EFAULT;
 		if (copy_from_user(key, keys + cp * map->key_size,
@@ -1890,11 +1891,18 @@ int generic_map_delete_batch(struct bpf_map *map,
 		err = map->ops->map_delete_elem(map, key);
 		rcu_read_unlock();
 		bpf_enable_instrumentation();
-		if (err)
+		if (err) {
+			if (err == -ENOENT &&
+			    (attr->batch.flags & BPF_F_BATCH_IGNORE_MISSING_KEY)) {
+				cond_resched();
+				continue;
+			}
 			break;
+		}
 		cond_resched();
+		count++;
 	}
-	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
+	if (copy_to_user(&uattr->batch.count, &count, sizeof(count)))
 		err = -EFAULT;
 
 	kvfree(key);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4162afc6b5d0..ea03e7e8272b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1423,6 +1423,11 @@ enum {
  */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
+/* Flags for batch operations. */
+
+/* If set, continue with batch operation even if a key is missing. */
+#define BPF_F_BATCH_IGNORE_MISSING_KEY          (1U << 1)
+
 /* Flags for BPF_PROG_TEST_RUN */
 
 /* If set, run the test on the cpu specified by bpf_attr.test.cpu */
-- 
2.47.0


