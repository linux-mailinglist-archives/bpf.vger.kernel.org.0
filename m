Return-Path: <bpf+bounces-35412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0609B93A582
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80E9282F5F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C5158A11;
	Tue, 23 Jul 2024 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQw9oKM0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0E1581EB
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759089; cv=none; b=aiJo1cx1hBniMRKfpM3P2BtTUIy5xB9x7mY32cY/0I6ZCLxmFRUD59DAXAPTMdq5Xw4JRk4gl3xV/mBh2xJbgCW5xNUZfs/KPoZ/isgX0GBhtKnpKOsl8xPUQxc+2/CamX7Us/fS3WErrLAZKbMbUpqd1tdhXa17WxgdV9ZTfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759089; c=relaxed/simple;
	bh=+ecSUDmOVWFQ+PWWZMaU1MOuCodvCRs6CB6kwv/0+c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKrgsrvJceIv9UEMc7iyDbtmKLj7TUOEbRn5eQxkJT2uQ0n1VSm8G3daMZXlpx59MVwqrxPgFk4wTuerUjutrg8fR1Ve8Sy0/PkfTO+wuT7/69amMTxN/Up7nW/yJ3ElKNV5CPNDVLcYDWXSvEUSs0Eso7KxCc2IuNftNivhERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQw9oKM0; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-65f880c56b1so58439207b3.3
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721759087; x=1722363887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzRxzWttvw4subNZHdn4qVZZ7tmthLLbteDrOCq8TDQ=;
        b=gQw9oKM04H4QNsi4fK2LD3S8+cp0cuAKHUtLH3orMIGO7w1btuU+PtmE0hCeOx589L
         DVRHBhpp9sSKxQyJPNNZNBrkc82xOYKeWD5Pp6Eah6i7ccbwdx0VfhHZW/r85Vp6c1r7
         v7dGnYpldeKw/29hfaRxkl/7+dvUmasb8IEiz2nHh5mrydtGBHhHIUJsSxnT9+WClI8n
         7aRUQixyyx+PN+I4uLhzq1A6PWuJyWXM7UINOodvaZKAYUz8njdt6msi4jjv1K3OVdA4
         fKHJ1PpMMbiWXifA8nymshMm97+hOkT+GppZS+PnKDTM46elv8NbnqhzLYza+e3RBv4H
         hPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759087; x=1722363887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzRxzWttvw4subNZHdn4qVZZ7tmthLLbteDrOCq8TDQ=;
        b=vBWksG4ycmEcGzE+O/XqqjfaGvK+wi+zPXr4EhT9HE5kpk5x+qNC4MA2bwRZ0yLSo+
         o5/nhMtL8EOHfdKApbWNKuJLhR/6ODukf2JAWy4jbDwplVMAa7CgvG9mFCkstDq/vzvN
         oxv3jmJKOAWpd2dLXUb5aAwYkBQfOxRQVHvgNq6z6ETwoGPri+0bDYV/IbcXAIG7PVFN
         rP9MLvWa6i1Bqhxoe7udnw7Mzj0E2Y3+QFruU1FUR+eqE8Aio/dKnNo+c7oYZKf2pSrf
         vEk6IQmEQjuIwAePOd3b7GahDrMev9lcaAeBrYouhqhMdvbOYG5KZqG74co1Fo/9lKeI
         4Lfw==
X-Gm-Message-State: AOJu0YzA2T3bpkLwyF+BBM7uwP3CNgvy4C83XClhMWkfZXOvxuD5fD5/
	fP9m9uf30utJ3nnvna3LXZgUXjNUxFm8jtJAXIAjA09L/CTxfnXJhOQYDZjL
X-Google-Smtp-Source: AGHT+IGOEBC4SytOUkVXoTONv8NUGvpt9zhm5/nxGjzsPC9uK8hSeOeaKJrUmrnc+lTJuC8aOk6k+g==
X-Received: by 2002:a05:690c:d87:b0:648:baba:542f with SMTP id 00721157ae682-66ad5de0462mr141095807b3.0.1721759086987;
        Tue, 23 Jul 2024 11:24:46 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e02a:b5d8:6984:234c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6695293fd9csm20637577b3.69.2024.07.23.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:24:46 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Monitor traffic for select_reuseport.
Date: Tue, 23 Jul 2024 11:24:39 -0700
Message-Id: <20240723182439.1434795-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723182439.1434795-1-thinker.li@gmail.com>
References: <20240723182439.1434795-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the subtests of select_reuseport.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 64c5f5eb2994..d3039957ee94 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -22,6 +22,7 @@
 
 #include "test_progs.h"
 #include "test_select_reuseport_common.h"
+#include "network_helpers.h"
 
 #define MAX_TEST_NAME 80
 #define MIN_TCPHDR_LEN 20
@@ -795,6 +796,7 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 	};
 	char s[MAX_TEST_NAME];
 	const struct test *t;
+	struct tmonitor_ctx *tmon;
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		if (t->need_sotype && t->need_sotype != sotype)
@@ -808,9 +810,14 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		if (!test__start_subtest(s))
 			continue;
 
+		tmon = traffic_monitor_start(NULL);
+		ASSERT_TRUE(tmon, "traffic_monitor_start");
+
 		setup_per_test(sotype, family, inany, t->no_inner_map);
 		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
+
+		traffic_monitor_stop(tmon);
 	}
 }
 
-- 
2.34.1


