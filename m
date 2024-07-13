Return-Path: <bpf+bounces-34728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA5B9303EE
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 07:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE82C1F211C4
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 05:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AA947A62;
	Sat, 13 Jul 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg0CQ5cM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898C45945
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850179; cv=none; b=s9hv/7mm3Sb0fKGkZ/1MZdStyzM86weHtqpsfu5Fdl6VefToC0zjk/6g2dun5LZ7sdD7Sg7rP2lKhKtaMEjvDsSX7ZQqg/kFjtJAtdlAdpgJHz2JWJpN6LCTeslXRo/sDp5zwa3SzsWV5ne0oqcMlgFnWeCB/GWbS1UAjbw6eBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850179; c=relaxed/simple;
	bh=/PCfE3BTYZYNQYmPCbC+tDIFS7AphJIHGF3r2T1S7H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/vs/DTHq+skP4GU4GA7sVrqtey+Xb/rtn3LVdj8lRfa8kybp7jxHTw6sq/UUBu/H1/GVxS2BLlf6IoD44R+nj8gR+hR3Be53qcsyFPFmtnuOwfoHUPANHlA6l3z+4VIJbH/GeeqEvt6QHpmRcGQrrBIrF47vII5nbTLs1mR/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg0CQ5cM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64b29539d86so24624107b3.2
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 22:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850177; x=1721454977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyk8Zo+IJe2i1qbmhcGTVbWi2DljTxMOeCNJyTmtkME=;
        b=Lg0CQ5cMMO8ezXcvVyzWx7QPl6xNEOfG6E+c50pFaWLBOYqIQJM9HUX+EQzV65Y8SI
         Ok/5JrCVnOhlyWzaP4t67kJygytuIJxJ1tQP/j3xUBvl/A1tzQ9rBiPiG9mGT4q4dSw/
         mLzM2VE4SpGewMeUEoz+BFl1JDtruu/g616ouPbfCroDPTe/B8MPYLx1bZa7Rksfluq8
         yrTL3/KGgCPL2fcl0ZzLW4vstDbYSBpissmj9CjCsib7D4wzbcB7VCxJ+wzPCr0FVxid
         +Xdnl7HK4ORhuqBCRlh4DaBVmz7xkYGuTUOTn5AhAP8Gjz/Ls9O6/1H422o1leJlMD2G
         OJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850177; x=1721454977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyk8Zo+IJe2i1qbmhcGTVbWi2DljTxMOeCNJyTmtkME=;
        b=HmA2VE1xsZ9Fm5Ms/lYEi4cg1uVwXVIwPY+dOPyHJUWIeD8CSxWpd7ifYjkcYro/pO
         ZYDU4U5VBGFLOcdJhS2MmHsX2SrQmxbHFwrckHjeUSzx5GE73jgnpIh9tCyhGU7NSV6b
         BPPTAccWqWOwcZwxBGGUgeBSlhtAN7XYaQPS/9v/I7FGRh7DgwkVG1qOhyYr6w4RTDbF
         hriJncysvYwQ4+wMGwzXwvAW7TjdM2jKH3QYXWtuTDxBwSLtHDLkxclROQylCXhkCbwF
         8m59N9Ur//sXRIjzHvwO5afsxuYnfiy3mUryZaXBnpY8MQ5TBTHlyZQwDzbE+YcFonzo
         eDNw==
X-Gm-Message-State: AOJu0YwW6gkR28XtRT0kXCwtaIwG5AnzOHpQfrv1EFrjB/+sHrJ6bglx
	eR5Q9T2iBYUgF/oAfOLBztfSWNmwODumRZaqE6oKw+4Yy5BmgPhriINUrHPM
X-Google-Smtp-Source: AGHT+IG/zWTVLACZV1/KV9cHluY91/6fKiS5ISfzkqgow/OaBn9Zi8MIttBQwoh+ZAV4erqeHF7KjQ==
X-Received: by 2002:a05:690c:fd4:b0:627:dfbd:3175 with SMTP id 00721157ae682-658ee79113emr210296167b3.10.1720850176872;
        Fri, 12 Jul 2024 22:56:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1e:9d09:4e82:b45e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc445165dsm761927b3.105.2024.07.12.22.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:56:16 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Monitor traffic for select_reuseport.
Date: Fri, 12 Jul 2024 22:55:52 -0700
Message-Id: <20240713055552.2482367-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713055552.2482367-1-thinker.li@gmail.com>
References: <20240713055552.2482367-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the subtests of select_reuseport.
The subtest prints the traffic log only ifit fails.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/select_reuseport.c  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 64c5f5eb2994..567e8083e7cf 100644
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
@@ -808,9 +810,16 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		if (!test__start_subtest(s))
 			continue;
 
+		tmon = traffic_monitor_start(NULL);
+		ASSERT_TRUE(tmon, "traffic_monitor_start");
+
 		setup_per_test(sotype, family, inany, t->no_inner_map);
 		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
+
+		if (env.subtest_state->error_cnt)
+			traffic_monitor_report(tmon);
+		traffic_monitor_stop(tmon);
 	}
 }
 
-- 
2.34.1


