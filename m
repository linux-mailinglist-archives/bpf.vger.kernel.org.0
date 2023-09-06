Return-Path: <bpf+bounces-9340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C83D79409B
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A4281445
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C6310942;
	Wed,  6 Sep 2023 15:43:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396710791
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 15:43:12 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E911990
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 08:43:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-56a3e6bce68so12780a12.1
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694014987; x=1694619787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DERp2+RhbO95qOoNSPh3y49/4Hj0CNbKkM4WkG1l21c=;
        b=TEeGKBWOlTH8JSM/jX+JSRcgqcw4H+zdAuqncdMxuE1Hg5LeC1xLdXOlU+Brqm+RYi
         kNl6J3BUz+EIauEWmihyH26cL0wjC2KdwmII8RxxH8JbNRds5GMUx8cqD/zrBLq0RrYJ
         +UuMPXhmM8c7RSbuezc1m9eUGAU+xSj/0vdVhLX8luSiG3Dyw2mYEoqsxtEPVDRFK/ua
         FTSX5F5r86LkVe+KpxR7J/Eoz6OAm6KvW0RocVvIU9FxafgZ3Cxm04qu5sSmxm5n6aYi
         UvKR4fFTp37L59TueFRIQIEiMOk8nmCer7kB1iVIjhSK3ZqIlb/bfB8K2Cbe0SatN0Ox
         Z2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694014987; x=1694619787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DERp2+RhbO95qOoNSPh3y49/4Hj0CNbKkM4WkG1l21c=;
        b=HNgswQ+55DtKT1ZAIOsKoDYD7IuNzIRE0DlYl9+P7I2vPrfZuchp/LJvC7ZfnrgHoL
         phmWGUj/asqUWFtApCaFH0ohPTsdApSqdqR+1IeYLPB5p+i4/t/VXOCyWy+GmT780OGS
         1jeAMsx7VyLOCDZyF7D+cCt+aFBHHJDYHobjfVwsjPPBjb5yM1DmQORRW0Px7A91EEuW
         8MtlTniOlGUi7nna8uIT1jI942atifOppfTV5X2Zhzcc4YWYffqdJUrBChYZnRmXRmFQ
         5mH5L7W5vG6enOEY6VvpRVUM3yMjD1IOeLSia3BEhhku0ieY5cUSZuYzYqCqQF1bQQS2
         Vy7Q==
X-Gm-Message-State: AOJu0YyclMIeRqi0Sa6Lyy0FDCuHxLLZrHu95D2ejMs0fgVHc3CnNjAs
	7yOvF9hfUE+uffh1ZJllDXGOhAksfh8=
X-Google-Smtp-Source: AGHT+IF3SxoTPKpn/UmE53NfnaYCUX2kidMKvZHYIBtT9pDP+Nim/4cZ/iK7bqyl/s7Lc5s//mrAHA==
X-Received: by 2002:a05:6a20:9799:b0:142:8731:bed1 with SMTP id hx25-20020a056a20979900b001428731bed1mr13379139pzc.41.1694014986981;
        Wed, 06 Sep 2023 08:43:06 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79205000000b0068c0fcb40d3sm10959050pfo.211.2023.09.06.08.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:43:06 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Correct map_fd to data_fd in tailcalls
Date: Wed,  6 Sep 2023 23:42:56 +0800
Message-ID: <20230906154256.95461-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Get and check data_fd. It should not check map_fd again.

Meanwhile, correct some 'return' to 'goto out'.

Thank the suggestion from Maciej in "bpf, x64: Fix tailcall infinite
loop"[0] discussions.

[0] https://lore.kernel.org/bpf/e496aef8-1f80-0f8e-dcdd-25a8c300319a@gmail.com/T/#m7d3b601066ba66400d436b7e7579b2df4a101033

Fixes: 79d49ba048ec ("bpf, testing: Add various tail call test cases")
Fixes: 3b0379111197 ("selftests/bpf: Add tailcall_bpf2bpf tests")
Fixes: 5e0b0a4c52d3 ("selftests/bpf: Test tail call counting with bpf2bpf and data on stack")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 58fe2c586ed76..09c189761926c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -271,11 +271,11 @@ static void test_tailcall_count(const char *which)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	err = bpf_map_lookup_elem(data_fd, &i, &val);
@@ -352,11 +352,11 @@ static void test_tailcall_4(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
@@ -442,11 +442,11 @@ static void test_tailcall_5(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
@@ -631,11 +631,11 @@ static void test_tailcall_bpf2bpf_2(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	err = bpf_map_lookup_elem(data_fd, &i, &val);
@@ -805,11 +805,11 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	val.noise = noise;
@@ -872,7 +872,7 @@ static void test_tailcall_bpf2bpf_6(void)
 	ASSERT_EQ(topts.retval, 0, "tailcall retval");
 
 	data_fd = bpf_map__fd(obj->maps.bss);
-	if (!ASSERT_GE(map_fd, 0, "bss map fd"))
+	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
 		goto out;
 
 	i = 0;

base-commit: 05ae0b55e72dca3e22598c7f231b86b6c3b69d83
-- 
2.41.0


