Return-Path: <bpf+bounces-34726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159479303ED
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 07:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97E628379F
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 05:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0644C7B;
	Sat, 13 Jul 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2xxOnfK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7028689
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850177; cv=none; b=H6+7fqDPKgSIa9pZ0hEYlVJZTuklQitu8dlppW3lOrgwqMU/W9M2v/GXIu/m4IlCUc+hewqxGVnDhUWlgGwMWZ+MG/6aNY4RmrKcSGvdYN4tw96UnWwCsWISNIZkIv+023zXe0WnnDa0U5hcawjAQmKrVMIDR/WeAFheRvILPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850177; c=relaxed/simple;
	bh=7khdQnEJ0ug3UX1cbBYgoEiTvh2APvh8tRPXDUxKH6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nv/h/YWQ115W/NmMyd/bgnB660SKksznvOhF6fPOd0TXXbmlfLFRAO6tNPpRk2oAclBonodNZ3V+rUEBWA0YBJ3aimefnyT2tJXs9VTeHRV5wiqkIw15x9qSQJDsLzVLl3KM7sDSpKPTEP5yQR45yK1IaHno+wtnEWSYG6aryBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2xxOnfK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6510c0c8e29so25766927b3.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 22:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850174; x=1721454974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vygrSp4r5MkVvW5GrKzhp80O2jMP7V18WOP+Br2r2Tc=;
        b=b2xxOnfKOdH0IxbptLZQtsz3Q/SF9g2ZOyNIQqerd1TqF/yG4cVXG0VYsSoewZh3+n
         ywE6skLWBRWLY8klXgBUVDzg9rXKu7jj3hu/NMS+c/UjpN0NtfRGwFVwxJ4s3j4xwErL
         IfzDzhVy+K5sxm2YDDrP0oDDnCJLYwH4bm9dp4ZnAjaZINcbfaw/Jww0Xp+yk4UnnlGu
         qwYVxmWg2X2yHzgLp3rlhEcNmdH+nA4r/MzvjeJQFNXc6Qdl+cT1H1kkKafWfUTkFAyg
         lCsWA+JW96qbCS3E85H/74qQ/akcnhCauMqoCH7zLca+W/Z+Mfxq5lC7HTv4zQyJL7P3
         2t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850174; x=1721454974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vygrSp4r5MkVvW5GrKzhp80O2jMP7V18WOP+Br2r2Tc=;
        b=fza+VownLeVXLpxZPrt9xSTjGBm6iAO/FIWa6dTzmjVm3DEyMm5mOv2tRG+bQYB8aH
         0lCvsmoJJ9/O3boPVBKM/Q57tQ7pymigDEyag3UhEm3Fv7AQdcoPWaaI16DhCyZSZSp7
         vAr2dFIzbx4TljUZUXfuL7gtRsAsBZynx+jOpgEShqTWi5b9aQ8IDK/OI2+4PuDnBZkc
         CIdR2b1oTs/ILniGoDXUfb1v0Nr6pJIQdYOhQ5oGmN/T1mSu2H0pi06fqbfBWPNB+Y7b
         NfvqWx1Z0ylRf/J1UCzTpY4XiCg1vY4PbJL9qrkX8GIzHxvd+WlmB+bCODWpqw1W3LjI
         VVuA==
X-Gm-Message-State: AOJu0Yz9NY6hePzCOeRYfc/ffQgC6VFnwkHXGCjJ4XZaUjv3KutSING9
	/UdkP0lw4erdqs8vSFhHxnjDctNwpOf0DQ5S3+Tf5sXRGLF71Ivin98MGcya
X-Google-Smtp-Source: AGHT+IFCgMWXh2B9PSfNdtEQYGYfg1XjiHm8QpZrR/9FZvCbBUUtNmgue6PHXNYuOMPm4a1L/fiSxQ==
X-Received: by 2002:a05:690c:6c84:b0:652:e90f:cd15 with SMTP id 00721157ae682-658ef34123amr159729057b3.25.1720850174556;
        Fri, 12 Jul 2024 22:56:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1e:9d09:4e82:b45e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc445165dsm761927b3.105.2024.07.12.22.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:56:14 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/4] selftests/bpf: Monitor traffic for tc_redirect/tc_redirect_dtime.
Date: Fri, 12 Jul 2024 22:55:50 -0700
Message-Id: <20240713055552.2482367-3-thinker.li@gmail.com>
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

Enable traffic monitoring for the test case tc_redirect/tc_redirect_dtime.
The traffic log is only printed when the subtest fails.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 327d51f59142..345f8ce93b29 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -900,6 +900,7 @@ static void test_udp_dtime(struct test_tc_dtime *skel, int family, bool bpf_fwd)
 static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 {
 	struct test_tc_dtime *skel;
+	struct tmonitor_ctx *tmon = NULL;
 	struct nstoken *nstoken;
 	int hold_tstamp_fd, err;
 
@@ -934,6 +935,9 @@ static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 	if (!ASSERT_OK(err, "disable forwarding"))
 		goto done;
 
+	tmon = traffic_monitor_start(NS_DST);
+	ASSERT_NEQ(tmon, NULL, "traffic_monitor_start");
+
 	test_tcp_clear_dtime(skel);
 
 	test_tcp_dtime(skel, AF_INET, true);
@@ -958,6 +962,9 @@ static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 	test_udp_dtime(skel, AF_INET6, false);
 
 done:
+	if (env.subtest_state->error_cnt)
+		traffic_monitor_report(tmon);
+	traffic_monitor_stop(tmon);
 	test_tc_dtime__destroy(skel);
 	close(hold_tstamp_fd);
 }
-- 
2.34.1


