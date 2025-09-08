Return-Path: <bpf+bounces-67718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E46B491D0
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EE8443C9C
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F730CD89;
	Mon,  8 Sep 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LNmxtXCB"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9522A7F2
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342254; cv=none; b=mNKrL/IahmNGX8tN4TZ7VLhoN8JHtJKXATNcoOHoqbwe4xFiBoBmEKXC/4o4DrQSJ8Yg89C4P1j6rg7dDJqbAejCSMncWQhqExVU7NijKCxmOZLdHisSOfrxi+LcnAt10T31XYhLNVUNkklYJAdbBJB5+qvIklXR2u/GH0eb/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342254; c=relaxed/simple;
	bh=YQciru/no9rYt0heBhrUUSJD/c695M+LjSVW7KSK+NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJ+sDuUp1aFvaQRKnIui7FzUIe6F0FOfGhPJfpsFo4FOVHSaFp7MW8Lxm6eDS2i2fX2J5KtdoiC8DaRxjXWsMxyYfAp32/LIOBPBC89vzkyAhVVnqqHbA+yk/S+neaQprvUkP6ar/9uOWzg0n6o6pLtnTczugm60/j9+WwzfCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LNmxtXCB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757342250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SfHMaktv+lFufqT2EDO2Hx7fri4jA3FR33agqyfQ4U=;
	b=LNmxtXCBEnSAzIebE3lLq18X2+OlhyY+kBa9ioRFdgP+XtR+0pahTWVDDzfh0Sc1NIP8vk
	Cfw72M+ZXKAQ6GapxU7spqMfbx6Up39y7Dxof/V8BtQIPTip3MKa3U3bNrzU7M7mRnxiRY
	c7WxyH+7IVAddb/vxUBmk1nUbk9w8UQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v5 5/9] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps
Date: Mon,  8 Sep 2025 22:36:40 +0800
Message-ID: <20250908143644.30993-6-leon.hwang@linux.dev>
In-Reply-To: <20250908143644.30993-1-leon.hwang@linux.dev>
References: <20250908143644.30993-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
allow updating values for all CPUs with a single value for both
update_elem and update_batch APIs.

Introduce support for the BPF_F_CPU flag in percpu_array maps to allow:

* update value for specified CPU for both update_elem and update_batch
  APIs.
* lookup value for specified CPU for both lookup_elem and lookup_batch
  APIs.

The BPF_F_CPU flag is passed via:

* map_flags of lookup_elem and update_elem APIs along with embedded cpu
  info.
* elem_flags of lookup_batch and update_batch APIs along with embedded
  cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  7 ++++++-
 kernel/bpf/arraymap.c | 12 +++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ef7f7c6a864c2..67122f852f16d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3754,7 +3754,12 @@ struct bpf_prog *bpf_prog_find_from_stack(void);
 
 static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 {
-	return false;
+	switch (map_type) {
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index d02cce3202840..93acd4c93a3a8 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -301,6 +301,11 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 map_f
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
 	u32 size;
+	int err;
+
+	err = bpf_map_check_cpu_flags(map_flags, false);
+	if (unlikely(err))
+		return err;
 
 	if (unlikely(index >= array->map.max_entries))
 		return -ENOENT;
@@ -383,10 +388,11 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
 	u32 size;
+	int err;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	err = bpf_map_check_cpu_flags(map_flags, true);
+	if (unlikely(err))
+		return err;
 
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
-- 
2.50.1


