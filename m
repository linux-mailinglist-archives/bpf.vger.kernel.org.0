Return-Path: <bpf+bounces-35961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038A940225
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 02:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353CA1C221FC
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A49F4A11;
	Tue, 30 Jul 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKn3wNiD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271362913
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299278; cv=none; b=H3kiWBJeOmkFjKitxdU4qlwqyH4SgxCgssZFRcOjfNKgi3argwHQIp8k72ngjcAd8LKCk/siSQvnpj4UfE0xwsIIW2CoqPsG1JTLudAe6oAh+fJGx18c2wshr86snBbMsZ7ajXqB7DNcAzHV+JWSeWx10yLELrcTtF+YQPYmiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299278; c=relaxed/simple;
	bh=CpUecYRYnebb/gp3JFq86EMp0MNxjVoYAtJmMiJImVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MieMaduqII2a8HaxoWpFVfh296fASsi+iE+/LC/oqGOD3w1hQY8C1qBpRC3JxRiygcNeCnaglclovBaloGZ+wAwLUfyYNagpfAUjK+BYsbowqvvNni+EAvXkuxAIVQXgbV1sYCX8ZRVRyutP3vqr448pNJlhvSMZgFXu/QWeON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKn3wNiD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66a048806e6so26521117b3.3
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299276; x=1722904076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob0IQo5VtuFaTpbx4j1x6xe3io9IQvZFt0/7bBXepPw=;
        b=AKn3wNiDgs4YzjvzEuz3NBB3kiUjy9d3TwHOIDZ98FMI4rn/ynNLxlSzowwIXpNKe+
         g54yK78G8EfbS5SbpQ0kFu4Ij2C60WBcns3HMfxbkozRw/UVwTD7gRinoJI6/Bs6rKc9
         wU5ze8PIF+ylspF4OQG/YsPnhq4LLAa5KXu2IUXSOKCtbF1vFR488KA8zTNawVItPBty
         /OD/w+4Nh7mZxlIju4Xe3wkLncM4WtwkoEsVkuULGhGKKC3Up2Pv1Zzk21I3AW2ZADlz
         aXezc8FZV0LcqDLOfgByF0CnOA834VxGCwnQWigTgks533PQRu4zjdsThZUV02P/L4AQ
         +y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299276; x=1722904076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob0IQo5VtuFaTpbx4j1x6xe3io9IQvZFt0/7bBXepPw=;
        b=f6mXrgtEjDjpTJ151jN6Lu2Htz1mA6jAPS8waRzK889mvQuDPGu0ZZXw4Kzt353PVd
         XWNMANlBAG16hdqsVP6m7veRVymlgFcd9sxV5qBEEQPOBcoUWS3nT0+rgdShxevK1Heu
         RaNmNSECSu5XFEgGldUVZ9KCezuxUsOXlODP47HRqEkeZrHB40Aroqt8Q0I3LAfDhx7l
         n5ouUTCnK/qhiHK7bojeprW67TtZHd9c7r2NiGLrrH9NBQ3Qxlc0KoiQcTo99Xx7RE4s
         pf0PmshzGC72BWf1ky/YXUulPfanYc5JhPjikoA8zr6SJMQu+z+3zmyTltOcy0Jq9MrW
         mCHQ==
X-Gm-Message-State: AOJu0YwrsPq8x7kVOE2SE2frtbReTjiaabPBmB7ZwDUddnMLOq8C4zlQ
	1g4rEpqNUVHCh4u1O+uy/2xjprlf7BJCtWEAwJ6cS90gJVfHcvVadmdnN59Y
X-Google-Smtp-Source: AGHT+IGIeMrbNT1t4AwdyI94iCbtHwabUa4nPFdOICHQ3bo03aQJ2cMRJcR5loA8WclfMn8aahVKuQ==
X-Received: by 2002:a81:8106:0:b0:65c:703:bd5f with SMTP id 00721157ae682-67a06539ccbmr115614917b3.12.1722299276056;
        Mon, 29 Jul 2024 17:27:56 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5695:a85f:7b5f:e238])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44c698sm23052177b3.135.2024.07.29.17.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:27:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/6] selftests/bpf: Monitor traffic for tc_redirect.
Date: Mon, 29 Jul 2024 17:27:43 -0700
Message-Id: <20240730002745.1484204-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730002745.1484204-1-thinker.li@gmail.com>
References: <20240730002745.1484204-1-thinker.li@gmail.com>
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
 .../selftests/bpf/prog_tests/tc_redirect.c    | 48 ++++++++++++++-----
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 327d51f59142..46d397c5c79a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -68,6 +68,7 @@
 		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
 
 static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST, NULL};
+static struct netns_obj *netns_objs[3];
 
 static int write_file(const char *path, const char *newval)
 {
@@ -85,29 +86,52 @@ static int write_file(const char *path, const char *newval)
 	return 0;
 }
 
-static int netns_setup_namespaces(const char *verb)
+enum NETNS_VERB {
+	NETNS_ADD,
+	NETNS_DEL,
+};
+
+static int netns_setup_namespaces(enum NETNS_VERB verb)
 {
 	const char * const *ns = namespaces;
-	char cmd[128];
+	struct netns_obj **ns_obj = netns_objs;
 
 	while (*ns) {
-		snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb, *ns);
-		if (!ASSERT_OK(system(cmd), cmd))
-			return -1;
+		if (verb == NETNS_ADD) {
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
 
-static void netns_setup_namespaces_nofail(const char *verb)
+static void netns_setup_namespaces_nofail(enum NETNS_VERB verb)
 {
 	const char * const *ns = namespaces;
-	char cmd[128];
+	struct netns_obj **ns_obj = netns_objs;
 
 	while (*ns) {
-		snprintf(cmd, sizeof(cmd), "ip netns %s %s > /dev/null 2>&1", verb, *ns);
-		system(cmd);
+		if (verb == NETNS_ADD) {
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
 
@@ -1250,17 +1274,17 @@ static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
 	({                                                                                  \
 		struct netns_setup_result setup_result = { .dev_mode = mode, };             \
 		if (test__start_subtest(#name))                                             \
-			if (ASSERT_OK(netns_setup_namespaces("add"), "setup namespaces")) { \
+			if (ASSERT_OK(netns_setup_namespaces(NETNS_ADD), "setup namespaces")) { \
 				if (ASSERT_OK(netns_setup_links_and_routes(&setup_result),  \
 					      "setup links and routes"))                    \
 					test_ ## name(&setup_result);                       \
-				netns_setup_namespaces("delete");                           \
+				netns_setup_namespaces(NETNS_DEL);                          \
 			}                                                                   \
 	})
 
 static void *test_tc_redirect_run_tests(void *arg)
 {
-	netns_setup_namespaces_nofail("delete");
+	netns_setup_namespaces_nofail(NETNS_DEL);
 
 	RUN_TEST(tc_redirect_peer, MODE_VETH);
 	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
-- 
2.34.1


