Return-Path: <bpf+bounces-68750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46DB83CC6
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C2D7BA700
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869703019A7;
	Thu, 18 Sep 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTKSsrYD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502D2FF144
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187804; cv=none; b=V7Fhf1sowzABkmTJrv63u2kTYXRuMbVUc/Xu0MzeHAhMSNUiRvnNYHEGrNUhU0LS8FRjEv5fDkq59AvqwhLgH0N0xASskW2bOGyB0OfHKp0hzHxGstNUDVU9lhGVRe22NAhlgCRrbMmaWSlX6160juX7dQIQo1qLlgnBVKgwLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187804; c=relaxed/simple;
	bh=Y3H7Atm+SAOvfAiTZ68dY1djAsc0v0+i0ixrTfXxyTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAPU9QBaq0JpzIsA+4xOhbeqqPM2MaV5j9eFBPjG7B+oMrMt0+LdALk3Y+L1ibA7TzxO4+VqrblnwhClwYagh4UMC/s2NYJ43MbUY+PAUZjE87uotIgjef3cC0Y5K9olTt8K0p8twSRQmy8YgJgQCy/nT5zDDxS6BaWhlD5fzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTKSsrYD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so5189555e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187800; x=1758792600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTNwYHdqI9UIo6dZ9voLlmdRD0k928OlgEtZ29wk3cE=;
        b=ZTKSsrYDim/a27eCjXeGNXGtN3RbkjNC57KbEpLaCR/7zWp7U6NsUMbRVN9mFXmb1Z
         v6f8j5AWDKuNvw+hOa+rxk8kmf2hHTudROxML5i1n2RQ/5B11Y6SNcHlpuKOS43YbIKU
         FLRd819a6t+vFeQ+mPR7kklmYvdQ241OiFwlvDn5py2tZ/LMhpd4IuTyBg9cUxy9rbmW
         SXZSD8Gm3h/VxNxpRvLTxl/pIuR9r9vHvYmPQGNSC4gH1J6pNEerlR8Ts0dWfZRVS72u
         79lXXsVE2/vdbmseCANTHJ4tc+jQHW6Es47Pl1vsrNYq+Dxqm//9tjW4GOCILkXxQ34v
         Ku1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187800; x=1758792600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTNwYHdqI9UIo6dZ9voLlmdRD0k928OlgEtZ29wk3cE=;
        b=OOC0p0DvHGKzPT0iTJ/yumdCzeV3nyooCGwDzID2V7QgecmUX4rCbSHSk9xvgwrbeu
         hKB0m2uwCgCDEQK07lJsE7ii6hBA6ypmQQt7CvkM/+NvIDJBfWdebGU2m6sMwcGs4Rm2
         IyeosC+z3gahJUewH/rDPIVofAmXc90XNOC3hTyy2se0mwc8rd9GxRip1fritn7ll8iM
         mZ8A+o3oRFw77IbbdgXYgmDvsjqi0tUl2NKe4jnZQJfYWIWXs2yonnMy2I8jXKCFHDsJ
         QIl4UM0MODzCJF7zmxZBDyAb5Oevce/Teik9Cb0szy5kWIQwIAr9aof084K3bpsFOVk4
         YlXg==
X-Gm-Message-State: AOJu0YxRXqVffONZHs9xaB2t3gu1PC5F23zQUQ/ZaP9iV95cEWT0Evr3
	eacC82LpVOwOobZwgVuXMMMRmvkHu/QeNSB0DWyghr3Q06qp6xfQgIeL/0xlaw==
X-Gm-Gg: ASbGncsxzaDHM239Hheb3GaHJvKFCteHEWdixcQWqHug/sF3FNaHtPApZ+gjLV5Zeeq
	nU1/soQWQVyQPh5pdzsRfau68uGzNKhDAUJcdwAq8gd5pAC4Nnv/BlsDTpmLM+vbrdlXerL4Yqo
	U4KUBa5lALXdGqz/d4PxW79RKQ5QRWC0pe0WLKaMJ5tEel4S3AW2ZC/K2402oJCR7gYaFsL5L4h
	tcaaEMH9VMU0WKwXfWmkW5m0LBhAXLWRzwC7aQCLXDdF+6WN3kuukPobOFIMj6NZurYH4skhxMe
	FzAc31Rtp2Ygj4GDkGnsvkJ3pycpdTiqvfLmkm6ZMdpVVZZkixVqebzrN/3CDxSEIERYnnnVARw
	5WLgvNrXW6AVGbxMn9gLsVCibF5Nsmqz0a8vU/uiY3WYuSQCQJRFd8KUL5ZME
X-Google-Smtp-Source: AGHT+IFpKnqhVHkulG0jblZQU5akKzGQ8V8VjA7te+ChAxeLal5CVXvZsasknIyKZuMdKtBDNpHvjw==
X-Received: by 2002:a05:600c:34c8:b0:45b:8b95:7119 with SMTP id 5b1f17b1804b1-464f81642e8mr27149645e9.8.1758187799966;
        Thu, 18 Sep 2025 02:29:59 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm34359705e9.0.2025.09.18.02.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:29:59 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: fix build with new LLVM
Date: Thu, 18 Sep 2025 09:36:06 +0000
Message-Id: <20250918093606.454541-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The progs/stream.c BPF program now uses arena helpers, so it includes
bpf_arena_common.h, which conflicts with the declarations generated
in vmlinux.h. This leads to the following build errors with the recent
LLVM:

    In file included from progs/stream.c:8:
    .../tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error: conflicting types for 'bpf_arena_alloc_pages'
       47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
          |               ^
    .../tools/testing/selftests/bpf/tools/include/vmlinux.h:229284:14: note: previous declaration is here
     229284 | extern void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
            |              ^

    ... etc

Fix this by analogy with the 6a8260147745 ("bpf: selftests: Do not
use generated kfunc prototypes for arena progs") commit by adding the
BPF_NO_KFUNC_PROTOTYPES. As the test uses other kfuncs, declare them
specifically.

Fixes: 86f2225065be ("selftests/bpf: Add tests for arena fault reporting")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/progs/stream.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 4a5bd852f10c..900da666d182 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
@@ -7,6 +9,13 @@
 #include "bpf_experimental.h"
 #include "bpf_arena_common.h"
 
+/*
+ * Declare kfuncs here, as BPF_NO_KFUNC_PROTOTYPES is used
+ * to exclude improper arena kfuncs declarations
+ */
+extern int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __weak __ksym;
+extern void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __weak __ksym;
+
 struct arr_elem {
 	struct bpf_res_spin_lock lock;
 };
-- 
2.34.1


