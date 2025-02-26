Return-Path: <bpf+bounces-52679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B6A469D2
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742531883BFC
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF42233D72;
	Wed, 26 Feb 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH70IvTQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F42719597F
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594738; cv=none; b=jEcViOVDEIfOlPi5645Csn/+L7xGTBOhluJ5FxjILXl38jAjJxqLY83O9JBlv7m6A0JTtUTDQapT/ZwVzn/dnwgs1RLDTzyGq3o2vMCQX1An/fCIOkLDIGin+gzPpv5QTBiODOveSaIX5moNmtTU7fQUbQPGz6tlzmGl2vyIokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594738; c=relaxed/simple;
	bh=Ygwc2D41ymtMAAbVJXhc78CltmObejr+JTpgXxGtkOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ62s3H+YUSvh/zTxII675OLn+kG5WflDuV3b+lfdb4/3zn4mtSCyjOPC61pgRFzztt688RGw2z7YFpG+CxQQN7EKfB5STBtNueezMiL6FmklbEPy6rXIDF5qHRvqoAJMVNmu8onuKUH1UZcANTa3IHl6CnfvGmz9sPpKP6yaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH70IvTQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so1325935e9.3
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740594734; x=1741199534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw0wPlPb9YgMeKJoz/JvQyduRzfrBwTB0MVE63lyzHg=;
        b=UH70IvTQLUErAQqV2bwMn3gB7n+Jv5VAGow84Fw7oThR+TACExIzSUQCn7auNW9rf/
         k3NOsFdPvF7XGQoYtzFQkanjBNfqgWJdA6ibxZvAN47a99+onG8qOsSLhACt8dBTsvU3
         W1iqXhU2LVqyVXVTftSG96mq44+Wl7OS8k/EZbD4M0njLvRjl+zBlipdSKNHyHNw0JOv
         hj8bvsmVKkR1vmPTT9CHq/auerSX3R33JNvaKDQUUnF8w9M2/8KeIIj/Eq2WRJ+ThyE9
         kqO50cxX4msOeoHfZ4v+xfzQ/GgJfFNg4lHjJ1zCZcx72Z+4rm8eJ2yBjD8bJFNKu5OD
         5u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594734; x=1741199534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw0wPlPb9YgMeKJoz/JvQyduRzfrBwTB0MVE63lyzHg=;
        b=ubH5Rd/48INiWUCnaw8LFiIDNbpowRTU3uZQ29iAGBCkdbqJxxfnPnZo38QQSOX1uT
         ANTlD7SLPHB9V0EsqzZDPfd3LT+fc4AiDlT6yO4OuyfauZBALwLBea3pjoVpTdhoX3Fr
         3YvXbPWvZDGr5ZtpiElA0OnNleb4+azxSnyWgR9MXMmhH5DCyB++bq7bLDZ4dGMHtJk+
         jKR+W7UJtFNFhGCceREqrUobyxz3Tq+oRat9f+FR2V6Tg3617Do/aHD0WbFm3nW75Gty
         dz8o4w2ZQyNhQLHT8AwOhrmUTvouEOrkB3U1sIniU/TqSd2KST+Kc/9BT4gKL94mwXDn
         7pOg==
X-Gm-Message-State: AOJu0YyZSUDFo966x1ig0M009tl+JJ4QlB2yv2kSkLvbwUgOciCbbWAy
	HxQ6idDSfKXfpZmPKRbQ4qQOIXLXn8c3R1Cka5WwcL/qVYjhs40+OvnPZw==
X-Gm-Gg: ASbGnct1MuKefSac7Z3JOypU51luaztgjLsBrD9+YgXyJMwYovkgXqC+/aOu66hmxVw
	6+9lkwePJgXLte2CnLZBnRE7VAbZFF+mgZKl0T47xUpwwDnzG9GvyffKEBd3/CCbC2yQFvS0o0Q
	YyKOnNyAyePcYMLM07tNFTxyoxJZI2OA3+LNJBnZCgI7jPpg1a/Luzu05VCkcjtqe9PJUwiOWoi
	nPyrzJx20fqGo3rQq65AU40zXM7+u7in4k7TkoRwHh79kC4mp1E7EL90mROv3XYV86XfS0VWm3s
	s7Aqqr+poh0smUJ+iOsEHYbXloMNC2HyZWxLEQVDVnfv2CIIuP9Tm6RWFNtP2tePBvXYhke4q/0
	jBG7Di70PbTgS9XNDYbkQSSbWUMHa4oQ=
X-Google-Smtp-Source: AGHT+IHlijb0igdVazZOx8QL12EkMTyNu2BE5UrClU2exuHsJYa7mSZHaaaLWzyqZmeNdODYTSqDaA==
X-Received: by 2002:a05:600c:4687:b0:439:9aca:3285 with SMTP id 5b1f17b1804b1-439b6ad5cbfmr166466115e9.6.1740594734077;
        Wed, 26 Feb 2025 10:32:14 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866afesm6520531f8f.18.2025.02.26.10.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:32:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 2/3] bpf/helpers: introduce bpf_dynptr_copy kfunc
Date: Wed, 26 Feb 2025 18:32:00 +0000
Message-ID: <20250226183201.332713-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
References: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introducing bpf_dynptr_copy kfunc allowing copying data from one dynptr to
another. This functionality is useful in scenarios such as capturing XDP
data to a ring buffer.
The implementation consists of 4 branches:
  * A fast branch for contiguous buffer capacity in both source and
destination dynptrs
  * 3 branches utilizing __bpf_dynptr_read and __bpf_dynptr_write to copy
data to/from non-contiguous buffer

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6600aa4492ec..264afa0effb0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2770,6 +2770,60 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
 	return 0;
 }
 
+/**
+ * bpf_dynptr_copy() - Copy data from one dynptr to another.
+ * @dst_ptr: Destination dynptr - where data should be copied to
+ * @dst_off: Offset into the destination dynptr
+ * @src_ptr: Source dynptr - where data should be copied from
+ * @src_off: Offset into the source dynptr
+ * @size: Length of the data to copy from source to destination
+ *
+ * Copies data from source dynptr to destination dynptr
+ */
+__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
+				struct bpf_dynptr *src_ptr, u32 src_off, u32 size)
+{
+	struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
+	struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
+	void *src_slice, *dst_slice;
+	char buf[256];
+	u32 off;
+
+	src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
+	dst_slice = bpf_dynptr_slice_rdwr(dst_ptr, dst_off, NULL, size);
+
+	if (src_slice && dst_slice) {
+		memmove(dst_slice, src_slice, size);
+		return 0;
+	}
+
+	if (src_slice)
+		return __bpf_dynptr_write(dst, dst_off, src_slice, size, 0);
+
+	if (dst_slice)
+		return __bpf_dynptr_read(dst_slice, size, src, src_off, 0);
+
+	if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
+	    bpf_dynptr_check_off_len(src, src_off, size))
+		return -E2BIG;
+
+	off = 0;
+	while (off < size) {
+		u32 chunk_sz = min_t(u32, sizeof(buf), size - off);
+		int err = 0;
+
+		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
+		if (err)
+			return err;
+		err = __bpf_dynptr_write(dst, dst_off + off, buf, chunk_sz, 0);
+		if (err)
+			return err;
+
+		off += chunk_sz;
+	}
+	return 0;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -3218,6 +3272,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_dynptr_copy)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
-- 
2.48.1


