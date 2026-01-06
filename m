Return-Path: <bpf+bounces-78025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C53CFB5BA
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 00:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F31E1302A386
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 23:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928423016E3;
	Tue,  6 Jan 2026 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="08Vl28CK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E93019C5
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742634; cv=none; b=q7ZMjuE4pcgxiUybc/U26cyDb804FbvN9AfWddyS70qyQdVQTpH4Fm7C6D9vxNqXAfO4Dd3BTwubTUXU7y1xc4S3trrHka+oelT+Mq2b90Sprr0ttscPinXnrsP+/4hRkZHcE/LP71HQ9m+TjS4VeY5j5Xhwh84re9+9FkpIOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742634; c=relaxed/simple;
	bh=5lMTq+jDHAXO97pn6hgL12DM8A/qYSZKuw/3/tksBIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGVE/1v2zPqpW7RqOMQOZxaH/pEVJZ5B3W7R0WCZPf8aQ6JvzqmKh0RLFdnDVSEW1bw0s4l6BXfrOz9u6+g/xxxQGr9cKgYNqQfcp9WPMBDn+d004mOImtr37KsnQ07NjLNrDvcns+lP0LhgH8FtNHf+ErLvtwWpJksgSsIrXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=08Vl28CK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a35a00506so19970616d6.2
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 15:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767742631; x=1768347431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJ+sPxPtAPJaOUIq014YVm/XhiXKyMCIcTveEf3kXQU=;
        b=08Vl28CKT7PBQ6fvSwp0dGiTx6kazL8OKlbNpj1THS2JrEh8dsFrk55k3iIS964niq
         x1hZ/c2nDoe1wHbgkpnyIIdMCPL9RpsskAGpoJm1eF04fCxFRe2amhCc/6CborLdWeER
         XppNuf9z4+7d1rBFQmdyGjBtUMF/q3ViX8Qu3HEa+zhKkbaxsGvxFB2+5PodRkx2vXuj
         qLS0dzEhMO1mAm5tlVCLNhALvvmsRJRl6Z+SOCaxY1tpNv2LiVAUOvWfe7N3wsbLGUs4
         L+mdZjEzlOBHeQh7RB1Cde8TwJaAhoYOteio/eTLolG0XJA0Id8JrBCI1cULLAxCngye
         ZRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742631; x=1768347431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aJ+sPxPtAPJaOUIq014YVm/XhiXKyMCIcTveEf3kXQU=;
        b=mG7I8hAfdgYHBzd7KfC67upugaH4CdzP8GyNQ1o+ITxLX4cmnbsgVG4Mew92aD5xsd
         WTCJwP2/8ZNhKwqx4NvFGzepWYwrDZMlXFBYYauKAqCeiEEbK7muwGeCSCIh22G2wSBP
         Xj/E2qf25YZ0bk6830jAMIpT/09rIToqMIYz46wHZiKJ6vZw0ouHPgA/6FBK3ZgRanDD
         /RILxEO9KpRLbRr/UHDENQ/NbFwmmnmJ6zvHrPS3hjEER4WexXtQhPE17eh2fJsxWaSM
         y0VgRzITBri8FJ/zs1MJqrj+LoWXzh04FTFHXgHDXPWWy6+br68cYsJO+faYcl88plCA
         RJaw==
X-Gm-Message-State: AOJu0YzbdJSKhECtCwfcW52amq492Geju5Qso3J3Tkx2BEG5Q9ggU92g
	QBY9Pn2xMcDZXJSD5FKJnZ++qJVJNVgVsA00rAjA3yx2BpaolqcOfC2gHQkz7wTYv0/9fJsM54w
	My1mxGSs=
X-Gm-Gg: AY/fxX52/0wKETXF3ztx/I6f4/uQIRZG3YXBDXg1zVg4rzZ+wYTMFKqnp5AfvjaYkuV
	hPvu5+LYEE9kUkIqyOLWzbisWpEbO8Ibk8dG9PaE40STU2KcSvQMmQG+dgcdqaz73eJMJ3XFmGy
	BpjZN1kt/4FvAb7zhZ9xOKmGI0q3iQytP0fs8zruCnZvdRbj/7/jvDcnUfKwa1BnL9VP251GbMc
	eiGHH0+ysMl/ADrqabb5oKXA01AYxVoiZy8IGEIhFOxLFKNRrVJ2WVL3P0q9GD3aauWVNKD/XEA
	0fawyUvA6P/ZaIX7Rv4crIbKX4vWuCyvQAK06YQu0Lic1/Pnprw8rFaNIKhZ4T9bReIT/1FkBiZ
	E8yHrdjk/asCe0Th2iWGhcIEGHTnDLOmWusXWwgLkrY7546o2RDLrUUExNpD4LgTbkPNi3vPULs
	8iqh9iHWrDEIJeyPqS
X-Google-Smtp-Source: AGHT+IEl3x6dsYZ/8JO1L9/UAueNQbKGJWkdv0PGgS6jSTA9Fvo+YJdw6c9MEIBzwJrPTYBAfFQbLg==
X-Received: by 2002:a05:6214:5883:b0:88a:2ce5:a049 with SMTP id 6a1803df08f44-890842b4a1dmr10168986d6.62.1767742631100;
        Tue, 06 Jan 2026 15:37:11 -0800 (PST)
Received: from [192.168.0.7] ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907724ef8fsm22590116d6.42.2026.01.06.15.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:37:10 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 06 Jan 2026 18:36:45 -0500
Subject: [PATCH v2 3/3] selftests/bpf: add tests for arena kfuncs under
 lock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-arena-under-lock-v2-3-378e9eab3066@etsalapatis.com>
References: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
In-Reply-To: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, ast@kernel.org, 
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
 eddyz87@gmail.com, song@kernel.org, memxor@gmail.com, 
 yonghong.song@linux.dev, puranjay@kernel.org
X-Mailer: b4 0.14.2

Add selftests to ensure the verifier permits calling the arena
kfunc API while holding a lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/progs/verifier_arena.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 4a9d96344813711a2009cfbb374570e440458be2..c4b8daac4388a9ca415d43d6f1b210dff8a50841 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -10,6 +10,8 @@
 #include "bpf_experimental.h"
 #include "bpf_arena_common.h"
 
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
 	__uint(map_flags, BPF_F_MMAPABLE);
@@ -439,4 +441,40 @@ int iter_maps3(struct bpf_iter__bpf_map *ctx)
 	return 0;
 }
 
+private(ARENA_TESTS) struct bpf_spin_lock arena_bpf_test_lock;
+
+/* Use the arena kfunc API while under a BPF lock. */
+SEC("syscall")
+__success __retval(0)
+int arena_kfuncs_under_bpf_lock(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	bpf_spin_lock(&arena_bpf_test_lock);
+
+	/* Get a separate region of the arena. */
+	page = arena_base(&arena);
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret) {
+		bpf_spin_unlock(&arena_bpf_test_lock);
+		return 1;
+	}
+
+	bpf_arena_free_pages(&arena, page, 1);
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page) {
+		bpf_spin_unlock(&arena_bpf_test_lock);
+		return 2;
+	}
+
+	bpf_arena_free_pages(&arena, page, 1);
+
+	bpf_spin_unlock(&arena_bpf_test_lock);
+#endif
+
+	return 0;
+}
 char _license[] SEC("license") = "GPL";

-- 
2.49.0


