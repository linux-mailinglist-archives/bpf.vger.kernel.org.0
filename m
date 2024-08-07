Return-Path: <bpf+bounces-36612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864294AFCD
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84921C20EAB
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA2140E30;
	Wed,  7 Aug 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2lnLan5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61B140E4D
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055520; cv=none; b=bMajXqckYSZdE3NlSzk2FChGaeKuNJvt7B++N47ojWRkUI5HEqqQ6bIMmGjHQnc+yMqW1GBB7apYK691kWdjnr+G14o9jY75vMROW0caNBGPGqwEq2ha0h4cBN5mYyy/a8Iz+wsCQeif22y+OlQEtKfii71ILQ2WJlvpEyUFhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055520; c=relaxed/simple;
	bh=7wIP0nj9a2egH90z6cRf9BwLZVqaNqHp/0dFKd5AEQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4+HJ+r75905QQa0jw5RkmK/+Id59Hbr1mBQ81vYrX25tD66pIRR81uqMTeI5blZyrx3VRpgGx/cybhzTd+vLNQcvjyMfBilP352pKdoQ3NzNqEyHFx8rwMt6WuGL2r6M8WCrF0lkXiKcKY6QG0gsmMe07MbyPWoejOwubQYkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2lnLan5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-69483a97848so1381937b3.2
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055518; x=1723660318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG3k6wqWPbDwV0ySmCsyFRprISwu4asFnhPgKGLKgNk=;
        b=F2lnLan5kOsACeNHfDK+cDgZi+05dAB22tID7mXiyfYcvmg+IFWJXJhZcONRoyZwJa
         nrdeBukhMJkJfMJByaI97L6/Jd/XxQ5VsEcUjj0VDbnDfltZGmb0CrBBF8r3S8KMUdpi
         KELcBZBteDxbbHxCpNTlwDckOMuXsKtv+z2TpENu/ErAsS2g5tzVvmxlEgiJhB/Hj1z3
         UU+oJv9vjn4mjL9MbTa4628ZhPcXJgVQ9FJ9+DAuIK2QiiocsMWSRbCgVaFuwxUhlhCK
         ujpcMZ5Wj9yxTCPOgzemwG/n6q2SYvn4IjY6IB2CcrkoxpagmgPfdIAu9oLURHYgMeym
         b0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055518; x=1723660318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG3k6wqWPbDwV0ySmCsyFRprISwu4asFnhPgKGLKgNk=;
        b=hKTXI0Agy050PiERGhuv+t7dStAtSjdKruVbjBsCVIxDU9n/y/fL5kxAh+ZHC/cvWY
         cvGkgVcc0xMCR/lykgnU/jF22psotn61HRM+ageBTylxe0DuKDcu77t1bHP19jMMyOd5
         hxUODmI55L7LaZXAPkYZYGXFWYx5evfQAWBwKJpz7pfgLarx8pMjCJgVHSMWLWMQEylC
         J0LSGZsoxIy37kEQYCyUlSG0d8dgT+L+V/hFrlFn9wFXOT5iuhhvmY4rhgYQbNo1Dg9s
         6bthk5kvCj6vQhS7Yjc4PY0xz9YCvTWxoHW2ZuvWWa3WGezkHFlHuV0vnRLvTrBQwSnx
         BUvA==
X-Gm-Message-State: AOJu0Yxro6+bm5MXvNYSq9iPRgZxGqy1hb5vHZI/RfFBmAatz4gM9wk+
	iJeGIFJN0iLeXxu9g0RT2VhA5UskglWQMKGzsG/He+fDfaUKGy9UhRl8yH8z
X-Google-Smtp-Source: AGHT+IEA826wbiNI3LnPFrw/jIc6PNw/mQw2TI7NH8ICnmP8mJkrJHY5SBAo/2H5312m78+RjEuKJg==
X-Received: by 2002:a81:5c43:0:b0:64b:3246:cc24 with SMTP id 00721157ae682-689634238e2mr210215147b3.29.1723055517929;
        Wed, 07 Aug 2024 11:31:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f4188a9sm20106447b3.2.2024.08.07.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:31:57 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 4/6] selftests/bpf: Monitor traffic for tc_redirect.
Date: Wed,  7 Aug 2024 11:31:47 -0700
Message-Id: <20240807183149.764711-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807183149.764711-1-thinker.li@gmail.com>
References: <20240807183149.764711-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the test case tc_redirect.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 53b8ffc943dc..0001f38ad9c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -68,6 +68,7 @@
 		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
 
 static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST, NULL};
+static struct netns_obj *netns_objs[3];
 
 static int write_file(const char *path, const char *newval)
 {
@@ -87,27 +88,45 @@ static int write_file(const char *path, const char *newval)
 
 static int netns_setup_namespaces(const char *verb)
 {
+	struct netns_obj **ns_obj = netns_objs;
 	const char * const *ns = namespaces;
-	char cmd[128];
 
 	while (*ns) {
-		snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb, *ns);
-		if (!ASSERT_OK(system(cmd), cmd))
-			return -1;
+		if (strcmp(verb, "add") == 0) {
+			*ns_obj = netns_new(*ns, false);
+			if (!*ns_obj) {
+				log_err("netns_new failed");
+				return -1;
+			}
+		} else {
+			if (!*ns_obj) {
+				log_err("netns_obj is NULL");
+				return -1;
+			}
+			netns_free(*ns_obj);
+			*ns_obj = NULL;
+		}
 		ns++;
+		ns_obj++;
 	}
 	return 0;
 }
 
 static void netns_setup_namespaces_nofail(const char *verb)
 {
+	struct netns_obj **ns_obj = netns_objs;
 	const char * const *ns = namespaces;
-	char cmd[128];
 
 	while (*ns) {
-		snprintf(cmd, sizeof(cmd), "ip netns %s %s > /dev/null 2>&1", verb, *ns);
-		system(cmd);
+		if (strcmp(verb, "add") == 0) {
+			*ns_obj = netns_new(*ns, false);
+		} else {
+			if (*ns_obj)
+				netns_free(*ns_obj);
+			*ns_obj = NULL;
+		}
 		ns++;
+		ns_obj++;
 	}
 }
 
-- 
2.34.1


