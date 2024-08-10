Return-Path: <bpf+bounces-36815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ADF94DA28
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 04:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8C91C21120
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 02:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434E13698F;
	Sat, 10 Aug 2024 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyBi5irB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249DE27452
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257345; cv=none; b=S+Q1Sqw5ihgWQw7tjXsbXVobsuEcAATk6jP7w5Li1h7apUreGwH/IoxGRsNrOI4CMY79AaD4PECddDeDEgJz2vxwhItut/4ban2eZ0c5EOojKrebPDDv40PE41QWfoNOFdiW/o7OGscnOQUeZpUPohMRbGvcPkQk+5kWhYTmkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257345; c=relaxed/simple;
	bh=7wIP0nj9a2egH90z6cRf9BwLZVqaNqHp/0dFKd5AEQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+ljMiewD7ZlhNTf2l5x+LXR+kDo/3pZxv09MZST6FDwOqn7ik8HhIWLoiKi6p56FJdXLyYtfDF4PplfDzIWSgwGw1MquJuUu8DHqb9qiphIArioE/tVaegO6AWArvua1+caLH2mrGsyXjIbUV8fgdEuJmIJm58f2u06Ab12Yo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyBi5irB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6510c0c8e29so25190167b3.0
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 19:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723257343; x=1723862143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG3k6wqWPbDwV0ySmCsyFRprISwu4asFnhPgKGLKgNk=;
        b=DyBi5irBwgcOhR782dF9ykkCFFT9VzwGQdvnz6aqKdes0TYlGCOA54HBoL/FEj4uvT
         /bO0bIwDaBPgqyY286bTyarWwcxTpsInzM6tsIse3DJeSIAG/xl8XvQ14MF60AA86EL1
         Iu0LE+bOKpnfhXRzc1BhaYsZhz8FY6wH3YRqB23MvUaisuRWKf1yo8a7JRgWE2ErNBOb
         482v8guQENK7j7b/F+YUrJmeno+SfGmJW3wx8hzKktKHYC2AiyR+gZW6PFVOOvjvPTIX
         lLTI+647j9P0Zv3PYbcTNg5/qA330t6BDE/ouAROCiJ8h9+lUzaXf/g9aUCOuRhcxNkQ
         IZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723257343; x=1723862143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG3k6wqWPbDwV0ySmCsyFRprISwu4asFnhPgKGLKgNk=;
        b=h0heqAfkaLm4yRSf5mrAYmfkXqjxY24X4cyRIBiaoiU/wtIBea4pMXyS7k0HAPS70/
         /64wFcj6+AWDVOHKm/ReoKMk1f/XJihp1JSrxCeeEHkLLUGnxNdqSSypr4Vr3gYMg9rh
         HHhRVH7weURIJo39SVQVfzw83++hjyeMAW1ODfar91c4wU0VtvFL04949kKZdiqGlVJe
         mft3zXE6pWA4TwEvxnkM5qH6Cyhy4fCYgg4WTe1rklM9A8AskU6gFlRe2VV6iiGRi9Nv
         AEbpU8KyVJbhL+yMXkCN5h+3cResIy7ieCAPMbBWRXES9+39QmVaCKyo02vEUWU2O0hx
         UJJQ==
X-Gm-Message-State: AOJu0YzRw3eOYSFCtQSbTGyyPmtNr2u6jmsyOEnRqGVUz/CwXaBIJOs0
	qTGHbxA7tvSwumEDs/ml+CrUyDIyg8B49NH6FRQJ3kq9WxTIJkDzj5sysKZF
X-Google-Smtp-Source: AGHT+IGBa6Ncs6EPuHSUNy+O+f/KELSBORJd1NXvQnrgahorQotFRuLdcQj0smqukMXQWmsgOT0glw==
X-Received: by 2002:a05:690c:2787:b0:630:de2f:79b8 with SMTP id 00721157ae682-69ec578e793mr39655537b3.13.1723257342889;
        Fri, 09 Aug 2024 19:35:42 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b371sm1280147b3.114.2024.08.09.19.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 19:35:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 4/6] selftests/bpf: Monitor traffic for tc_redirect.
Date: Fri,  9 Aug 2024 19:35:32 -0700
Message-Id: <20240810023534.2458227-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810023534.2458227-1-thinker.li@gmail.com>
References: <20240810023534.2458227-1-thinker.li@gmail.com>
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


