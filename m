Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0EB446B54
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 00:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhKEXpj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 19:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhKEXpj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 19:45:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE4BC061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 16:42:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u141so2247717pfc.4
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 16:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RcW1TMa8i021xAugZ9tpKPX8GKQUfG/oqDAu9xJXZmM=;
        b=Pv8rS/p5EmImmdZp30MnevnHIJq2GuZ6HDn3OO1y5xjMHk9w9oqTsnM5vgkM2aJvsi
         XMcE8vi94i+/viqgq+i3/fk50y/Hr2Gt6WyT/iAp+qAoYDsFSZ4IhvMS7fIXO8sdMHP3
         wdW/FU9Ml6sJwJseV8rE4TjUUJiA0YU1ykreQ0vyKKv/baUKz19+W9Mim28E3TkR6WWP
         BiTyuxdCV8frJ37vn1L6XCehlKXlbebGB3DBo0pOCZmz1QRFsBiv+KYMHdShPbPd56TL
         fcqlGCFp1KdKia2IZwhVyeHgQX0FSXGxHpNAvhEusXsgEDVib3B/VmT2g9bJmlDr6K0S
         WvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RcW1TMa8i021xAugZ9tpKPX8GKQUfG/oqDAu9xJXZmM=;
        b=32ja5HoUVqVmA8kQ1sLsRbvu23Huuybi5m9NT5dAEUQIYPeRsel17UiS8493KPQ85Y
         o8puXoQxrqcIhzWwClWK/w55YHj7VAgeBrkGp06GGTIZE6UNMx1Ei+o7AnSkvTZ7c+R9
         Bjy9Ll1ERX4TzS68I6kWwqMSuPdWNWIIOz9GsHjqiyOST7ei1OxMUxFBBR3wLDEAgZfx
         CUWDQsSN8wF2ylL7Tpr+d/o/N+0fhQpgzabUF8Jz10tqtHjBwXqfVLnPIc4AN/IYJJ1g
         /Nz/sdbSqgWf76ORI2bVXQ1GdTtMdgMRHWpc19ckFwayBIxYq0mQ7lGaGJrZpIvZpcxm
         frkg==
X-Gm-Message-State: AOAM530iWjBB8yPaQdFOaJtN5lQyy2c/uSeiQ95shiSSmqeHgRnz6rb4
        fPtrQH5GNnC0p/XLfVvKtgu3UqWQmURUqA==
X-Google-Smtp-Source: ABdhPJyNklMlwqOGPFoi0OJEQMc7iv9JOix1Ir7etzL1rcCWkKJK3wD8wE6f9LwKxKqHE8+FqKI7bQ==
X-Received: by 2002:a63:82c7:: with SMTP id w190mr30106542pgd.13.1636155778556;
        Fri, 05 Nov 2021 16:42:58 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id c198sm6838557pga.6.2021.11.05.16.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:42:58 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 4/6] selftests/bpf: Fix non-C89 loop variable declaration instances
Date:   Sat,  6 Nov 2021 05:12:41 +0530
Message-Id: <20211105234243.390179-5-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105234243.390179-1-memxor@gmail.com>
References: <20211105234243.390179-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4129; h=from:subject; bh=SI9IDJn+6GPGCEu0/Mil2+ybHWj1m+z829zOGoWH/B8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhhb9AJEgQp7uhXVRR4q7lsZg4gW9cny2TS6B4q+tQ HZwwmCOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYYW/QAAKCRBM4MiGSL8RytJAD/ 9/v/1cd/XBEx+7jW0KyiVTZKzfP6rdVbRgNNK1skDWONkZ2N56ehp98J1QgMaqdroVuDDLeHUuf7om X3hl5R0PEZIJkb6UKZN+qc1c2VXCePRyU+atb76sZS3+U00q0U0gX8hLaqm6ZR0ypvTDHPbjLUrLwW UXQp0+CdVimSZh1wfDdmKT9b5gsYpvlj8PptQFatgZYAw1XS7L8XfSdI2Zt2+cYCMVsOVOILIrOa40 r0oKfBKEKI3YpunHXZYZPy0erYHG+MFc+sJGWKy7KXmQhGw7xD3ADzm4Q1GTtjylnMh8qeswEqNRx4 DDyQwOK5ah4YVv/ZRMIJla/rfqolN2uU61BjjqgCC9aNb/o2q9ZL+vufqXCsdLcE1LkNJbGnL5TANa F4fS9kGB1EtiQ3MKSz28AiTZfbVZR8PbZ5G6RFgKMWfESViQuTwnc8gl42SN2S1X/Ko85uavi1eB/d HPryZXwTA74BXW4dx0Ex/NkEJ4mi8kaaN/GBIhYTiA8gAdsosEmM0NAbYMWgjOVpViKMyy9RojJLZ5 3J4kfrEvQY6okwbytSxRqWASDfKE4IhxNqXxfTwpYygL5+dDXvP/vJHfA/Yoq5UcwkVXxFB5ZvWcZF HyKR3hU45XxJIige/qD3hiURBV7h6popvm2UfTrczXu3u6J4lHxuScPuV1QQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the `int i` declaration inside the for statement. This is non-C89
compliant. Doing all of them in this change since they are trivial.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/d_path.c      | 4 ++--
 tools/testing/selftests/bpf/prog_tests/timer_mim.c   | 6 +++---
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c | 4 ++--
 tools/testing/selftests/bpf/test_progs.c             | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 0a577a248d34..cc787ad68081 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -103,7 +103,7 @@ void test_d_path(void)
 {
 	struct test_d_path__bss *bss;
 	struct test_d_path *skel;
-	int err;
+	int err, i;
 
 	skel = test_d_path__open_and_load();
 	if (CHECK(!skel, "setup", "d_path skeleton failed\n"))
@@ -130,7 +130,7 @@ void test_d_path(void)
 		  "trampoline for filp_close was not called\n"))
 		goto cleanup;
 
-	for (int i = 0; i < MAX_FILES; i++) {
+	for (i = 0; i < MAX_FILES; i++) {
 		CHECK(strncmp(src.paths[i], bss->paths_stat[i], MAX_PATH_LEN),
 		      "check",
 		      "failed to get stat path[%d]: %s vs %s\n",
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
index 949a0617869d..f12536c32e2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
@@ -6,9 +6,9 @@
 
 static int timer_mim(struct timer_mim *timer_skel)
 {
+	int err, prog_fd, key1 = 1, i;
 	__u32 duration = 0, retval;
 	__u64 cnt1, cnt2;
-	int err, prog_fd, key1 = 1;
 
 	err = timer_mim__attach(timer_skel);
 	if (!ASSERT_OK(err, "timer_attach"))
@@ -23,7 +23,7 @@ static int timer_mim(struct timer_mim *timer_skel)
 
 	/* check that timer_cb[12] are incrementing 'cnt' */
 	cnt1 = READ_ONCE(timer_skel->bss->cnt);
-	for (int i = 0; i < 100; i++) {
+	for (i = 0; i < 100; i++) {
 		cnt2 = READ_ONCE(timer_skel->bss->cnt);
 		if (cnt2 != cnt1)
 			break;
@@ -41,7 +41,7 @@ static int timer_mim(struct timer_mim *timer_skel)
 
 	/* check that timer_cb[12] are no longer running */
 	cnt1 = READ_ONCE(timer_skel->bss->cnt);
-	for (int i = 0; i < 100; i++) {
+	for (i = 0; i < 100; i++) {
 		usleep(200); /* 100 times more than interval */
 		cnt2 = READ_ONCE(timer_skel->bss->cnt);
 		if (cnt2 == cnt1)
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index faa22b84f2ee..e5b8666e59eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -335,7 +335,7 @@ static void test_xdp_bonding_redirect_multi(struct skeletons *skeletons)
 {
 	static const char * const ifaces[] = {"bond2", "veth2_1", "veth2_2"};
 	int veth1_1_rx, veth1_2_rx;
-	int err;
+	int err, i;
 
 	if (bonding_setup(skeletons, BOND_MODE_ROUNDROBIN, BOND_XMIT_POLICY_LAYER23,
 			  BOND_ONE_NO_ATTACH))
@@ -346,7 +346,7 @@ static void test_xdp_bonding_redirect_multi(struct skeletons *skeletons)
 		goto out;
 
 	/* populate the devmap with the relevant interfaces */
-	for (int i = 0; i < ARRAY_SIZE(ifaces); i++) {
+	for (i = 0; i < ARRAY_SIZE(ifaces); i++) {
 		int ifindex = if_nametoindex(ifaces[i]);
 		int map_fd = bpf_map__fd(skeletons->xdp_redirect_multi_kern->maps.map_all);
 
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index c65986bd9d07..0096051e7560 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1146,7 +1146,7 @@ static int server_main(void)
 	/* run serial tests */
 	save_netns();
 
-	for (int i = 0; i < prog_test_cnt; i++) {
+	for (i = 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test = &prog_test_defs[i];
 		struct test_result *result = &test_results[i];
 
-- 
2.33.1

