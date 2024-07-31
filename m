Return-Path: <bpf+bounces-36165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A8943677
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146C4B210C9
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA714F9C4;
	Wed, 31 Jul 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVJ73sIt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0721465A8
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454311; cv=none; b=YMtQpSvjg6BF1NyNMI7QZ7Q30PFs/fME+Lp9zgI6RzXIdr+cg/pozBRJzLhl3e06MLB2EPcxsNLizmBTIcEGe8jWq2SYvaLKwCvMAABR2ACOq+Ducp+qpGduFQkEaWMfL29KVUAZHFSgeS1x/iYiGsW/f6Bo+PBriJw3RjyO3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454311; c=relaxed/simple;
	bh=9l5TZpQYJX292sQiPuN9GiryRoLcktl/Kj9PK7KuJ2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOi78PWKuiL/Nt7EiLXou7pCEwDCh3v11xdD+AP+yLiUxA10Z4mp3YqQ1cP+ecXyi08e6drvu3B/A2phr6ZxI11CDefa5UGscSe9JcnN8rEJdLiuj7Tp49CX5G/GfIu2H/rhXrBuqbfXqJdJiRVGnS9apoiQ1QOLe+zgvBbsNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVJ73sIt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6678a45eaa3so49984917b3.2
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722454308; x=1723059108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyxm0AmLNi80xUSYtbcFWXBAssuvtxaDhxLwvHH8pME=;
        b=dVJ73sIt4ZHuN7/zbwwm0Ug1xUvPPkUosDykREuySdLyw71qM49CDbH+h9x92iiYXF
         ootExDD8qWcqxz9pbQeybIf1gG5lp8T/Zt/ByhI2cKbf5TcMGRtfgV1KFRQNK3uKZp4K
         oVtI5BzWPB3yadkOn1zIKLFETc5AtAqQawB7TPB2C8tAfqYQ8s3byxKSjbhfmcb/x50G
         yDlnj4U/IYuTjab8XQVaOcZ4j9KoEVC3TfdN0THciLMdkHiWPfaH69LdTbWurFokYYKD
         CoHp6zOc219ZsBvbGvEKEXxJq8Zmc60OjyrsJ9dj6poXD0/yPNiffvsrZHSaDhPSVTnQ
         At+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454308; x=1723059108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyxm0AmLNi80xUSYtbcFWXBAssuvtxaDhxLwvHH8pME=;
        b=vcZvkW2BweydJSUiq3xug3TvJYqcHsmRd6tjCxkmogsKGuIt2K0LGhEYUCZRz4tpZO
         71PTDLDyI04IKmoSxCuBUV3VJlrpReClw/WLgiBHljrKOCQRTbpIgmo98IF6CXcQ07eu
         j3VhAgyCEcf82x/be5sLv2Fq/znp9Xone+M7qkNkD9C4/bVVSiWNBSm2bGM53jzbnpul
         pYYItiqc/0YiUDjHNoCTNyCl4IyE/09Szd3oiK9+vEz0EjOJtZ8hKIZteWacaHoFaysZ
         iLXtkc3BMcgNA3Zp3NKUJJBqSXf0zNVGG7ZGSJWTrYxYXDpVJEmvd62iWtMrpqrvqK6p
         tePw==
X-Gm-Message-State: AOJu0YxJvZbRIYkGXjs6RUHPBXmcLsGZPNeDfAsFRYKDUvnKZ1HnHodp
	OHrkDRJJAL4keHgkzM1EuIlMgYsA5j0UJfZLB9wOOSuo4FJyIA89ry+Uk+v0
X-Google-Smtp-Source: AGHT+IFEP0C4aJoeVElWatIaWDFiNm0qOiIId0FmbgSabW4WQRLe6kETfpLbDXl3DxP2OkzfszQ5vQ==
X-Received: by 2002:a0d:f786:0:b0:63b:ce21:da7f with SMTP id 00721157ae682-6874dcc48b7mr1465817b3.21.1722454308420;
        Wed, 31 Jul 2024 12:31:48 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c6db:9dfe:1d13:3b2e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024ab1sm30891597b3.91.2024.07.31.12.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:31:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/6] selftests/bpf: Monitor traffic for tc_redirect.
Date: Wed, 31 Jul 2024 12:31:38 -0700
Message-Id: <20240731193140.758210-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731193140.758210-1-thinker.li@gmail.com>
References: <20240731193140.758210-1-thinker.li@gmail.com>
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
index 53b8ffc943dc..54da6b1f23c1 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -68,6 +68,7 @@
 		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
 
 static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST, NULL};
+static struct netns_obj *netns_objs[3];
 
 static int write_file(const char *path, const char *newval)
 {
@@ -88,13 +89,25 @@ static int write_file(const char *path, const char *newval)
 static int netns_setup_namespaces(const char *verb)
 {
 	const char * const *ns = namespaces;
-	char cmd[128];
+	struct netns_obj **ns_obj = netns_objs;
 
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
@@ -102,12 +115,18 @@ static int netns_setup_namespaces(const char *verb)
 static void netns_setup_namespaces_nofail(const char *verb)
 {
 	const char * const *ns = namespaces;
-	char cmd[128];
+	struct netns_obj **ns_obj = netns_objs;
 
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


