Return-Path: <bpf+bounces-34727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2324C9303EF
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 07:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B04B22194
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 05:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC47C45976;
	Sat, 13 Jul 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6R0mo1g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366443ADE
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850178; cv=none; b=OB54qD2hKufNIky5PefQBIYAGPSwT9NPffHNNwKbmL56ScYM9y1TVpRzw8lRj8bgpeekSOtqfVhFc/kdZUbg0h+Ti23EKCAVdoBWtGqh+YSRTAxJQ1RLBE/RmKIbgHUllWoywVENg+Sjd8X+6+L9prmUM8cykM/OZj3VlP+3Xgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850178; c=relaxed/simple;
	bh=5UB+H7afer7Q1F/cRx1O9WOZqOcKTx6nxD7GHnP5t1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBW1fR9ghM+mRzeUroQScR0RnlLN2+XvlgTWjQ54odYx80QDk/mQdCxyXJeNqnM8Vybx0Sd2JA7oaAUK6/PR4jQghiwMqbv0sQ+GggeQIHjcswpi8Vyuc26silK+lt7ZNUcF6A/jrSuDaY0G0E5c35kIWzbs3aiFOngGmRyyLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6R0mo1g; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65cd720cee2so24356957b3.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 22:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850176; x=1721454976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65cVLOLQcbcCMiFNilAC6jq20HN1woAX0MoCJC3+7Ns=;
        b=c6R0mo1g9BiHWzYnP3UzDzc/q5hgLuJK9Odguclyc867yB90FmnqpL8riZWcrIkRkY
         tADcPIarojttEt+0G8ReaSrB3LLvOVFGSUWcjh+0RZ9q5Br5KZi6PmVw0MS6Xxlvg/Hx
         +sp3/0YK4uQM8r7ATIPdr1QzHWDol9z6qNVDglPO9WyLJ69pjizNKmtEseu7C/ywCxix
         MH6Z+2XVRYFPTHgR/uxYWnt31b98W1AzzO+y1q0/m3x0fceC+Cw4Rvk4u3Dol+fBuXox
         H08tOOAt1Zobdqzd+2YVtkzkpSYo5tM1mOx0bnfn2G+PqwAwXIHFd2YY5Irxj0ttYG6b
         qCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850176; x=1721454976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65cVLOLQcbcCMiFNilAC6jq20HN1woAX0MoCJC3+7Ns=;
        b=e9vv6dDLYhLAbHmy+UHODQ0J+6gBEolbgaDbIMgEoDhL336fcx9tA38iQBpYX4W9YE
         /euU4CB+OGzX9GragacTUCV4qAwktBnuarAsASXahgGJMqwhLbnmP2VmkpEZDzTEahMv
         Y6k8X0Yt7TFwOY0Dg6JxCiI7UqGaquTyoDm1EJX1b2dasV1UNpLjOsXr+fBoXvEkoP7s
         yBgLpQrzZ5iqR0GOLe52Mxc6A4ffgiDEWxiVURWFxF2nHN8XHcxuKa+cKCWjJ2DcWgPz
         lxNJ0mvPTWFia+qErj/Ko6unzgELdu+QK6t4+wLDmKgijQOhSgvX4n+6UQE3cYLzHkZP
         CPlg==
X-Gm-Message-State: AOJu0Yx8Qeq+wlzY7Fc8mqZiI6Rc/CspH2LAvsKkp8wdG9ReVSwARegf
	MbHSRVs8NYdMLm68E4Zd2G7vg1vVjzfWMHzMgaMGTvdByehRzipLPb1a3w3r
X-Google-Smtp-Source: AGHT+IGIz2dY8fjKUXGjpaVNnTNr7CawK7GI4VGXv3FS0/KgT45h26zLHgUhOk7purt08uaaiYTi5A==
X-Received: by 2002:a05:690c:648a:b0:64b:14bf:2fcf with SMTP id 00721157ae682-658ee79084fmr179437727b3.8.1720850175772;
        Fri, 12 Jul 2024 22:56:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1e:9d09:4e82:b45e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc445165dsm761927b3.105.2024.07.12.22.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:56:15 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/4] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Fri, 12 Jul 2024 22:55:51 -0700
Message-Id: <20240713055552.2482367-4-thinker.li@gmail.com>
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

Enable traffic monitor for each subtest of sockmap_listen.
A subtest prints the traffic log only if it fails.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/sockmap_listen.c  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index e91b59366030..617d73671a90 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -28,6 +28,7 @@
 #include "test_sockmap_listen.skel.h"
 
 #include "sockmap_helpers.h"
+#include "network_helpers.h"
 
 static void test_insert_invalid(struct test_sockmap_listen *skel __always_unused,
 				int family, int sotype, int mapfd)
@@ -1893,14 +1894,23 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 {
 	const char *family_name, *map_name;
 	char s[MAX_TEST_NAME];
+	struct tmonitor_ctx *tmon;
 
 	family_name = family_str(family);
 	map_name = map_type_str(map);
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
+
+	tmon = traffic_monitor_start(NULL);
+	ASSERT_TRUE(tmon, "traffic_monitor_start");
+
 	inet_unix_skb_redir_to_connected(skel, map, family);
 	unix_inet_skb_redir_to_connected(skel, map, family);
+
+	if (env.subtest_state->error_cnt)
+		traffic_monitor_report(tmon);
+	traffic_monitor_stop(tmon);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.34.1


