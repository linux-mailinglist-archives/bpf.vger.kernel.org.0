Return-Path: <bpf+bounces-36598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D794AF22
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460F31C210A0
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0513E043;
	Wed,  7 Aug 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zof+V9Rd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0C13DDD1
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053062; cv=none; b=bwf0MXFY70qPB31n3JSsrQbcyvOKNgtePtkVjAfRKdyiZXS0eboOGsxw5oMjh78NYvQBTObmKOIX7cpuOX5z0/5ccreO0HgKDrWmiQXiu48HYfeTyPC04EugCR3VK1AfT33rha+8p5ytt+AZtpMh3vywnTLHS9IlshzjojmD7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053062; c=relaxed/simple;
	bh=7wIP0nj9a2egH90z6cRf9BwLZVqaNqHp/0dFKd5AEQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kD4awHm66mHPza0vbmUPtJS1RuoSqo7rSESGp39/fhSDiueOtrGjgLfs3MSuV6af9h9q4AVaEpmtbXjo24iqVaI7UX5sxzaA8KySQWlFwXH43QLnk689UmctlkSzhgKCLQhgwZarcJ3NJQubC/i8Dtka5fu16ntFBnxp7XlqdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zof+V9Rd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-691bb56eb65so1281757b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053060; x=1723657860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG3k6wqWPbDwV0ySmCsyFRprISwu4asFnhPgKGLKgNk=;
        b=Zof+V9Rd7jb7dwbGRqsBcKX9Fh49fgD6bLMxzRojjlKBc4rdVX0kIFo+p9JFoCeepe
         oO7HwtMPkEUt6feIkJAXbWNc+r8qQzbYk5gfn4S9PrunwBBl/0AZ0nd/Rc+NDNZV5Esj
         GhrVzR6sttDvHnVN3g/FO6E+rkq7WaM/eiTZYStj1YPGePTk1r+blEKMJLfSVHHHFvfs
         GMapyoGgnvGcioyZd7Y4yfRQYJN0JGnYM7Y7Xq9i49GGXCrR37sibbhR65fycovQXcj1
         3s5Lcq8IxNvDjpHamC5Jm1Y/l6A2FnnC5nrCzmSiygUF3K3W1tjhyQr4621WdbjyhH65
         z9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053060; x=1723657860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG3k6wqWPbDwV0ySmCsyFRprISwu4asFnhPgKGLKgNk=;
        b=SQ6Y7j46rUcaXPzRHVBMASDxR93qB1v+c6qPJZ0ltzVHd73tLA1gTpztI9oGVcMQa7
         YDhw7msMbbAJbMdzQzsCKdCFt8YQq39QDxSPTjTUff24GVGFho4JN7ROLO+MHZAPRxA1
         Wp3HURJp0AyLFLQE0/kbZJ75lE2+a9NESkJAylFxwx2FFWZ0tySJdlZMpJ6xShvNe6yK
         Wp2w+eGe756FbbY3wsAgrva4O2zEBws9LqKOCs7S4hR0HrTDlKqZ6auPH2P2Eu3TK9pB
         2Jd4KC0P4eWXvPwv2WkFK0A+wqinhpcI6/ynIW98VK9jCS1jzMsTw3XvkudcjtLNKzvS
         Rgpg==
X-Gm-Message-State: AOJu0Yy0tykakKzlSPUXII71twmocWLvnhBx+WubduNVAwizuvIPp9Kv
	68anMC3MkUZhP/9QfQSWr5qIOXSfdxLWIJ8k5BHtqeME5/ppY0ifsKrgxxMr
X-Google-Smtp-Source: AGHT+IH1430wQPZMQo4RnB0vFwT6JdP1Tdqavwy2EyNaTDcIqbjcz41OkaFDaTtzusJrwwS3eMOHLw==
X-Received: by 2002:a81:bf51:0:b0:64a:b33a:d954 with SMTP id 00721157ae682-689611313e8mr231859617b3.23.1723053060250;
        Wed, 07 Aug 2024 10:51:00 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68fcd1727f3sm14988727b3.90.2024.08.07.10.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:51:00 -0700 (PDT)
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
Subject: [RFC bpf-next v6 4/6] selftests/bpf: Monitor traffic for tc_redirect.
Date: Wed,  7 Aug 2024 10:50:50 -0700
Message-Id: <20240807175052.674250-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807175052.674250-1-thinker.li@gmail.com>
References: <20240807175052.674250-1-thinker.li@gmail.com>
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


