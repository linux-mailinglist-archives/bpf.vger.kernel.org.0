Return-Path: <bpf+bounces-14870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA57E89FA
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F10280E72
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18D125B6;
	Sat, 11 Nov 2023 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKaN9oTC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50811CBB
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 09:00:48 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F33C3C
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:46 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2ec9a79bdso1815226b6e.3
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699693246; x=1700298046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFjO+CyfkmWqCo5n7HHoe1Xd34s9tb2wdltbsbA06/g=;
        b=LKaN9oTCAjVft00g1ocsUcaXGnGUlLntCiZ+NgQnd9rOMLG9rYEgxmJlRjhwj+i8eu
         O+YQWKibeqNYIDvW9LXvsxI4hBu/mEE3Sh9su1kOkk/MQaNIYudEfaakuk5fZGjTIHGw
         jhxBtbEYREZbBfd5n+hEJYZ0nMifLbQ1J1P5vrj+bEtC/vGXxy2W6g5UIkjQ3hdikfyD
         03X+Hj8Gsn0Z4VnrUc5FfMrbz2e8zX/0k7ej+VTUXBV6FS5/uRVza9bcdCk5Yahh+mHf
         e3F2Ui5MCoethDHqpv8Z2kjkzmSH0vLmVTAtgsUM0zk+tM0wIbv2mLX52Jfr4+oZJKuG
         dxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699693246; x=1700298046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFjO+CyfkmWqCo5n7HHoe1Xd34s9tb2wdltbsbA06/g=;
        b=nCXWj8zjzHW40BBDWNiniaxzDvxGLuBYfGQfgjYlXYUrhJpKZb/Z51zKH+CrGWLG1/
         kn1s9wycyGKg7gefQAXUV0uYsORM6zWrZFb6QtD64UgmnC7zXJIVr/eZZZyhQHMIBkbm
         MqznYjdfa2Gffq6q9EpJSqLG+MKgJ8ARyBeA0D1SQFuBeEnB5eF5g4vj9HLfvM5icQUA
         jJn4/loukJBCoJjVZr/24nXkVp/HPDoNHjuEV4ZNvBJNKEBYsEbXjKRrAsWaKFgM2JeD
         LAgF2NQqOXxRBbskwsIyWISM/Ew1qfuznhuFvmszeSBgtrDlKv75GncWKfoVAbrbixwP
         AboQ==
X-Gm-Message-State: AOJu0YyMRor3RfDGY9VVzGZvdryj5tvCPfWMkXZ2P8CB0RIfD5QZgO5l
	0dqU9ahodKjBPoYe2uX4lg0=
X-Google-Smtp-Source: AGHT+IEFUnhMrhf1L2FrTkdLXk7qWdTUBqCl6MiQXpgvPCxTtYdSB2e/WrW5sf6tZ8aQfxbgJUPa7g==
X-Received: by 2002:a05:6808:2391:b0:3b5:75d3:14aa with SMTP id bp17-20020a056808239100b003b575d314aamr2472984oib.25.1699693246215;
        Sat, 11 Nov 2023 01:00:46 -0800 (PST)
Received: from vultr.guest ([45.63.84.83])
        by smtp.gmail.com with ESMTPSA id fh38-20020a056a00392600b006b2e07a6235sm894254pfb.136.2023.11.11.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:00:45 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 5/6] selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
Date: Sat, 11 Nov 2023 09:00:33 +0000
Message-Id: <20231111090034.4248-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231111090034.4248-1-laoar.shao@gmail.com>
References: <20231111090034.4248-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new cgroup helper function, get_cgroup1_hierarchy_id(), has been
introduced to obtain the ID of a cgroup1 hierarchy based on the provided
cgroup name. This cgroup name can be obtained from the /proc/self/cgroup
file.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 52 ++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 63bfa72..5aa133b 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -637,3 +637,55 @@ unsigned long long get_classid_cgroup_id(void)
 	format_classid_path(cgroup_workdir);
 	return get_cgroup_id_from_path(cgroup_workdir);
 }
+
+/**
+ * get_cgroup1_hierarchy_id - Retrieves the ID of a cgroup1 hierarchy from the cgroup1 subsys name.
+ * @subsys_name: The cgroup1 subsys name, which can be retrieved from /proc/self/cgroup. It can be
+ * a named cgroup like "name=systemd", a controller name like "net_cls", or multi-contollers like
+ * "net_cls,net_prio".
+ */
+int get_cgroup1_hierarchy_id(const char *subsys_name)
+{
+	char *c, *c2, *c3, *c4;
+	bool found = false;
+	char line[1024];
+	FILE *file;
+	int i, id;
+
+	if (!subsys_name)
+		return -1;
+
+	file = fopen("/proc/self/cgroup", "r");
+	if (!file) {
+		log_err("fopen /proc/self/cgroup");
+		return -1;
+	}
+
+	while (fgets(line, 1024, file)) {
+		i = 0;
+		for (c = strtok_r(line, ":", &c2); c && i < 2; c = strtok_r(NULL, ":", &c2)) {
+			if (i == 0) {
+				id = strtol(c, NULL, 10);
+			} else if (i == 1) {
+				if (!strcmp(c, subsys_name)) {
+					found = true;
+					break;
+				}
+
+				/* Multiple subsystems may share one single mount point */
+				for (c3 = strtok_r(c, ",", &c4); c3;
+				     c3 = strtok_r(NULL, ",", &c4)) {
+					if (!strcmp(c, subsys_name)) {
+						found = true;
+						break;
+					}
+				}
+			}
+			i++;
+		}
+		if (found)
+			break;
+	}
+	fclose(file);
+	return found ? id : -1;
+}
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index e71da4e..ee05364 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -20,6 +20,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 int create_and_get_cgroup(const char *relative_path);
 void remove_cgroup(const char *relative_path);
 unsigned long long get_cgroup_id(const char *relative_path);
+int get_cgroup1_hierarchy_id(const char *subsys_name);
 
 int join_cgroup(const char *relative_path);
 int join_root_cgroup(void);
-- 
1.8.3.1


