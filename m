Return-Path: <bpf+bounces-77930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C13F2CF6D93
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 07:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22CB1301EA2E
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1606B30274B;
	Tue,  6 Jan 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="RIpbdgre"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031D3002B9
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767679828; cv=none; b=mze2IWsByZV5KPQlzwA6fZENNUMdS+2eLHFOBryx06Emmk7/v1igzc2BdN4wGIyhZifH1hLKtG1bEhgwlQHoB1y4NThQMt8QL7HcjM3HTVRt2/VM6yw4bj1BUSaSsWKWgN91k4L3fqrxSM7arP7GTklvd8yqzib9i0s6PD2FReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767679828; c=relaxed/simple;
	bh=5lMTq+jDHAXO97pn6hgL12DM8A/qYSZKuw/3/tksBIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFu82R6JGT0ssbCLT7tpLfWU2aX3rOxtCMiz/5SUhoFSo5J1MYfRsMOFO0QWBHOS7Ezdfn5djhNiZP1Hkmqc3Lr0HQ1LOAb4yN45bFPevd+YHIpeKYUSCag3zPIf7Fgt0Td9HisBA68ji1OKY4ezpx+Z1NCSWFe1AL3ulM4pDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=RIpbdgre; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4edb6e678ddso8706851cf.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 22:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767679826; x=1768284626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ+sPxPtAPJaOUIq014YVm/XhiXKyMCIcTveEf3kXQU=;
        b=RIpbdgreVG28vPGMs0rVBLqaA1sjr47AA8JeXnQBHsYhDBKMYKqYCjpMKcH5EXAzOB
         ap3s5pxSLBcEBgp0V+bjI4Xeyv9kXUSglLN2snhyFXLOjZlimuEXD/pNgS4URiNPdRBf
         VtDJOiy51xqAtaVeLJT/uOYDBRtIQ51SjVWKSWQdhOC/zxNBB7pXGrWgKzFA0aAPtpXl
         p8Qt6ycKfcBWv9RPSZD7pjYxut5dC43QOhgPSEPJWzDESmnyGG70KYN38RYxWliPHzPY
         FHnmzA4T0vVduhdqy1EJWIUu1r+fadlN2zOsjDhHUL/VpFDfi1iF8MhUlxO8NWv4YIrd
         NBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767679826; x=1768284626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJ+sPxPtAPJaOUIq014YVm/XhiXKyMCIcTveEf3kXQU=;
        b=aRoz9G4jypZjLNGqbq+sEEgbUAAMURE45RxfqUeUE4+F0F7H00bODRSVMJ8R7Xop3m
         dAjjmzZH+fvfD0VFkJeY5XkxX53S3vlGD8/od4+nP057kNMA1T/ghVYXbjJdnnTAz5C/
         hVHM+GYAyyxQPgCt9GLTVRWHVtsOGadoUSncKmIdC9MgQ6gwfmmdbNLhafSLfHBQ/GWh
         0BLrfaxtlpIFRuTxy5NsjbJ6PQ7KtrXYDSMEnOOdzxUyUNuggVWycjtxhKtSAZp1XlWp
         PMQMBs3IUuK9bViwzqPEV9er713a/qSPOpmNijR4RRdqQ//Ex2P/C7BH+w0whA9NG1IA
         GOUg==
X-Gm-Message-State: AOJu0Yw8RLHGGDJDYdARdLqe2Ha+sc1rBNhRFwDaIOVoYMsKhE1kLExJ
	aBgK1vLNWaU90X9tNejVSeNHP1A5WOtvEqwyaUBBOt4l1bUGtEuWLD8W+9GwXytGIWrt2Nb2CKD
	ONUPcKB4=
X-Gm-Gg: AY/fxX7dytKMzm17RG8YAEOKZDikvLiWg0kvW124U8SmEvCNtl8F6EtZlWTtNXZXryS
	cr3ZpDGlqMq6zEjVYC4m+wVzRUhq+4Tzm/dBC5C6l41T552hXUqxipKZel1WZqQmjt3JoDu3lfd
	V1RcEXGkgpAeY75jj7ef0AEKZ9TN2Itdumy0o9d+BJSk/wyKuvRs2X3xgew/rm4NMgm101Eb/5P
	dWUmBksx0rn+HObXiw33FOuFPslfWXlAPgH9LPWiiyj46/URACkxAEQpE702CP4TV43+oVPfcMl
	89Yvdz/Fu+XCcOhc1tpOwlKJ4fgvQQUt4KjSjcunu+z7Y+v/SEuDefKV1VUTj5iCu8iuBfrH3YP
	LlOp2HylBHe20FEIO1OspGsBVplERwxHkkZM0coLUUjgy9ru5jCohZur53JIDzMoGBTizoPhQ8s
	tSUkxrPk9EYnxPhY/VFMvQ
X-Google-Smtp-Source: AGHT+IHw2eFWZJsGmcmv7KzQSGisHKA10PqkMLwPNcu8dlcv2KZL12mmiuS9parw+phDcT4UtwvvWQ==
X-Received: by 2002:ac8:5d49:0:b0:4f4:d926:d64b with SMTP id d75a77b69052e-4ffa77b205emr32024111cf.48.1767679825789;
        Mon, 05 Jan 2026 22:10:25 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e363b7sm6845511cf.20.2026.01.05.22.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 22:10:25 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 2/2] selftests/bpf: add tests for arena kfuncs under lock
Date: Tue,  6 Jan 2026 01:09:53 -0500
Message-ID: <20260106-arena-under-lock-v1-2-6ca9c121d826@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106-arena-under-lock-v1-0-6ca9c121d826@etsalapatis.com>
References: <20260106-arena-under-lock-v1-0-6ca9c121d826@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

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

