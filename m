Return-Path: <bpf+bounces-35410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50F393A580
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CABD1F231EC
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 18:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279D158A00;
	Tue, 23 Jul 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIYAwb1l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C1157A4F
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759088; cv=none; b=Fo3qvk3rJxUrUHc8eYt3Oq36IC5Xi+kEwhK/eoh3vCMXS29iz6vmEnhBB3vGL62ASN/BH4OdAPKjrO5k5w2CGpO7+h5FApkdrXKSZvlgn2kmT5cH2stzrUHZ0tqESShR0G2kDabFq4XjJMpkmtotSqmPV854tvLgrpN/t2rIsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759088; c=relaxed/simple;
	bh=mRd/DAFv2kIkDKHiswXD1hckOvS0HpTJ03EG5ls+H8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DL4JT7MGZ1xgeLvErX0Ue9PMVjKvgL2n7kp95RIe/MKOhCaI0heGcR9n6IxiEBRFxyw44xMVbad0q+oxj8ScVGe7u2iZAx6hqcwYJBeZLI14f+0brgefvzD+HE7rM0jOgiJJ2pPEHbmNlRZ+6DuAVeBLX1iV2Jn7qnZVxJ3XZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIYAwb1l; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-66108213e88so57968937b3.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721759085; x=1722363885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtLewEWhfeG+Lijjiylaf3g6jdonnBYABUF3GI1qKZc=;
        b=kIYAwb1l+odpgBn418QNKKP3rofuRo7Jqy6xH/VN2XEKgoyX4pFl1sVLNbvvfrldxF
         mFXODc0E3crs2rFJI0swWv9abqQz7oBoKDy7yzJDXEECInit7o2tx5w4E1QJ8wxyE92s
         0aoG2/LH16+/cVaFSnq1Iw72xOm8vA7PFtCyQL47xhb1EM6gzXD1zwz0fmCBXZdOpCCy
         vAF+3JltOcf2jbJzAC70olnwLDucb/gaNSR+3/hBiRRUi3z71h7qQhkcWmLmjqWj8PLf
         Uc8HtMM7TJQfFb2GofTDQR7l1rheZ//dl08VwLaxsQcMcO/Kf43w5a6M7b2IRcUx7K3J
         zCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759085; x=1722363885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtLewEWhfeG+Lijjiylaf3g6jdonnBYABUF3GI1qKZc=;
        b=rLWu8++271SuEyOjl0yUTsylgH6Xhzjq5moK2oKYZDONxP8JTK40eYOx9c5k76pGiH
         KsNfvO8ksjUApjjs5ls4svmvAP8ZkcpP4OPFHVBiM1RErh1zrQd7EaECInwj7aQVYjGE
         ogMpYnlm6iG3raLL7N+QmqqPNoDCZoioGle/DeSCKxH74kPXAyjyAcj0diQnXvCQKk3x
         y4LY7IrnKExTv4/qhR8lt+Yi9Psb+R2O5km5Zl3CUVD4x1Ts2minEkLXVJz0Oh8m3IBE
         D5s25Y9J5uoydMTlBHqJctdLLe12xG1T+tI6xsZglx6YKLtWs2jZTPRgirccVKmDc2M0
         TWVQ==
X-Gm-Message-State: AOJu0YyO+Y5g5esMRnTTnlHLW/d4PqukP4GgCe9SgU6PHPJIsUNqUAIp
	H+HuWVq5Cd2JlD1SgE5LCK4JJ62HwtRzaxkRrzhgxSRj0pS0cvG+2aAU1ngH
X-Google-Smtp-Source: AGHT+IH//MqkZJHOhyOeSXzzPf3teXefBgYR/ZM4lkQFGhPHPt7Iw1O6BmBL0r2w5NuHP5urDrcuAg==
X-Received: by 2002:a05:690c:2fc9:b0:62f:2553:d3b3 with SMTP id 00721157ae682-671f447347fmr6223167b3.29.1721759084904;
        Tue, 23 Jul 2024 11:24:44 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e02a:b5d8:6984:234c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6695293fd9csm20637577b3.69.2024.07.23.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:24:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Monitor traffic for tc_redirect/tc_redirect_dtime.
Date: Tue, 23 Jul 2024 11:24:37 -0700
Message-Id: <20240723182439.1434795-3-thinker.li@gmail.com>
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

Enable traffic monitoring for the test case tc_redirect/tc_redirect_dtime.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 327d51f59142..1be6ea8d6c64 100644
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
@@ -958,6 +962,7 @@ static void test_tc_redirect_dtime(struct netns_setup_result *setup_result)
 	test_udp_dtime(skel, AF_INET6, false);
 
 done:
+	traffic_monitor_stop(tmon);
 	test_tc_dtime__destroy(skel);
 	close(hold_tstamp_fd);
 }
-- 
2.34.1


