Return-Path: <bpf+bounces-37247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40189528FB
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 07:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A817284ABD
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 05:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150C115E5C9;
	Thu, 15 Aug 2024 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g35rcA8/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A652EAE5
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699985; cv=none; b=pDwtkPPo3/4a4d0Fvs8iY+PDCZvtR2HF8XBFwlUU4r8dyOwmxw9VG+nGwk5FbelJ/1Yd3G6VYP44kqfZqIKkyK2nwCIRba2IMBwVpzkvygiwUpadpxIsqPFoENFTHyn9vUXTlQ+dUGz187lMPUJHsu1+IyvYKSegYqWUnvgjvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699985; c=relaxed/simple;
	bh=yARYmcCIPXWU1e+YrWnUk8b76rJVujT7pRIOGP29AU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OooN/b0xUqsk/2sF5xNjEkQVfQ4HS/Mnc3B45Gs09SUMLT8MilQ1KsBOoswnTZN7dsUC+sriucsprMiEBN544rJqjKkMmEOfakb9C899NR0CgsGJNnrMEKQEg4k9RgUreKo+H7JoiwvZVeiVaIvKejsUW/mx8hvdn8dNCggObCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g35rcA8/; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6afc27735d4so2430477b3.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 22:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723699983; x=1724304783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXEjzjkKbzP8D4or3ldMwFxiPFwaaFk9pfxz/ct8MxI=;
        b=g35rcA8/X3oOGXwvQToHMUCuNgpXNeV+bDUU3LItTg1jdwqYlzeUwYLkpVgqc5Y3z2
         lOKkHM4JROry5sdp8X7jWQMUUr/jaBds4KcsDSf7nxGRP0xUXo5bSV+cWubd4VCdiRN5
         t/s7yceWFfJa8dZztdAJtRHHd7TTkHppVhyyl0a7TW0+nQMGYvy3ZkGQySrmNXDK9PVh
         Ng7oOzZwariCHwvd4hzPTonaCICRLXjyWsM2gdNti0YhAAZRgEIvndXcRatpHnIovEkR
         v1YxlH0VWiE5DIA4t/djRRcG4VO7GPBCqUZVzTrgnoYS5vremJeAOldDOKf18xSfISRC
         ALiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723699983; x=1724304783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXEjzjkKbzP8D4or3ldMwFxiPFwaaFk9pfxz/ct8MxI=;
        b=BX/jT1ZNUvKdeasYBpN2HF8KWGIXwxv73xpD0U7knfFAtrltio0hE+2rzmyQANIv+2
         5ijve1qD68BG7JONykCiC6rsM3AqhZKiNyIqNl7sW8YtZFD2iFcUEZxAHnP9TuZ8RmdW
         pwSGUD25aK/K8dIgMBbhzhZzGuT0KjMXbtBTf5LUQkM/BqDokMU0wo+CfYgwNky5nEqb
         wd29L8ZWv1+XlRCXKiCC4zAiD/QPKtZBQKwSGqjUCmw2NwLihNGWen/mjC9vDitvIUz1
         UV7RxNMeKvP4J5aIdds1MnszKp1N9CFBm4KTUScJJvc7RUsWv6G8YdLPWBnw/bOYI8XC
         2NIA==
X-Gm-Message-State: AOJu0YwH387VLRFE2qZ/G8CPhuky0fv5yrWdt58QrfYgby6rRNRUjvWh
	Q74dSQBS07iWSR04PlppnU/9izS9GLST972+9wyVR4MNJUP/E9GWYwlEyI/K
X-Google-Smtp-Source: AGHT+IHri37kiRqAaUd3yxwv4WS19/daeln/1XpuUAqopYoX9uF1c4ApSVxsK684/t2nNKV+G1TJ1g==
X-Received: by 2002:a05:690c:389:b0:699:7a7a:1853 with SMTP id 00721157ae682-6ac964fe1damr71051857b3.5.1723699982976;
        Wed, 14 Aug 2024 22:33:02 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:11c4:fddc:768f:9072])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9da160c7sm1482307b3.118.2024.08.14.22.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 22:33:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 4/6] selftests/bpf: Monitor traffic for tc_redirect.
Date: Wed, 14 Aug 2024 22:32:52 -0700
Message-Id: <20240815053254.470944-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815053254.470944-1-thinker.li@gmail.com>
References: <20240815053254.470944-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the test case tc_redirect.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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


