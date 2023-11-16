Return-Path: <bpf+bounces-15212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97F27EE7A1
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF2B1F25288
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306848CF7;
	Thu, 16 Nov 2023 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv55Vuc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A81A8
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:20 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1f4bbf525c7so580961fac.0
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163799; x=1700768599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etSYgH62EA674SBlOtz+kIIlTGcfq6rOe2EK9PTrnDA=;
        b=Xv55Vuc+7UOR6KsVxouSaPjdAPRhslCVfMV8D/8BPBRihwvWugLhfqauNRSQaqZesP
         8pq2KkDNJofU1Fwu4IhR2rC9/5VDKcNvsffvCpbJrZXAdpbvGm0hOyxPD6KlQkldYn18
         CRxAlEQB/7pEr0dr14e08Tps+h0ZflkGM+mT8fqa38Qm7LWXc01Ur1Ezh6h9C3COHUW2
         VOimcH06mXqg+4rKrxxZD08aVhd4LZhYBbpEqpgHyo7dMOswC95hGq3O/0iwwK7YG0nz
         5kC+dcm33bIDAhKwJSxViDJ2nu2XCPEOPdvdsJEARxwFH1BkGY9InD9LSXhpYE49NXhK
         YaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163799; x=1700768599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etSYgH62EA674SBlOtz+kIIlTGcfq6rOe2EK9PTrnDA=;
        b=MuJD0ut5xY5/vXh5jThtue/cdRMq5L7JtCEHd18uxkEuW7LE/+kqPmSyrd/ZfGaSQt
         pa+VpJ6E8wF4kHx7k/rJ3F52LFdZpKuwv0sTB6WNihsRDNT1SWDttMra2KOIQglP+Poq
         0guCFNHYcneFJliS3cVA0CU0uoG7SdFGJW4gZRvsGpGaNaZZqNDLxrc0n2oHbwU5lZQ8
         A/8+dIYl0izCCclddfn40gnhg5B697ao7YsqLwxa8nQ724z4p/XvwFkUPYxj+cm0an1z
         /+gATdfxTejbEaTSidSy0FenKm6fpIfbC1yUydx3zFuXZLC73GIiObF7OAGj8U0IHJyR
         fhmg==
X-Gm-Message-State: AOJu0YxbxzRNKz9YGsn8c3YNH8TDEt/ETnsY+Y/lNsroLjgqbxx9gtF8
	OiwOLwNOCuZhvvkSD/nz0ISYOlDRnhnMuQ==
X-Google-Smtp-Source: AGHT+IH0LtnOgrSu7lUA1etmI7ZncIaM4KKZfsPmnfTJzFtYWule60pBlZQL5XAYiOj4NiT3OqKWFQ==
X-Received: by 2002:a05:6870:b254:b0:1ef:9292:1dcc with SMTP id b20-20020a056870b25400b001ef92921dccmr1437434oam.14.1700163799300;
        Thu, 16 Nov 2023 11:43:19 -0800 (PST)
Received: from localhost (fwdproxy-vll-003.fbsv.net. [2a03:2880:12ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id dv11-20020a0568716e8b00b001eb64e95c8bsm4335oac.57.2023.11.16.11.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:18 -0800 (PST)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org,
	quentin@isovalent.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH v1 bpf-next  4/9] bpftool: Add test to verify that pids are associated to maps.
Date: Thu, 16 Nov 2023 11:42:31 -0800
Message-Id: <20231116194236.1345035-5-chantr4@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231116194236.1345035-1-chantr4@gmail.com>
References: <20231116194236.1345035-1-chantr4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../bpftool_tests/src/bpf/bpftool_tests.bpf.c |  7 +++++
 .../bpf/bpftool_tests/src/bpftool_tests.rs    | 29 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
index 8b92171145de..dbd4e2aad277 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
@@ -4,6 +4,13 @@
 
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10240);
+	__type(key, u32);
+	__type(value, u64);
+} pid_write_calls SEC(".maps");
+
 int my_pid = 0;
 
 SEC("tp/syscalls/sys_enter_write")
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
index fb58898a4a1a..a832b255e988 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
@@ -72,3 +72,32 @@ fn run_bpftool_map_list() {
     assert!(output.status.success(), "bpftool returned an error.");
     assert!(!maps.is_empty(), "No maps were listed");
 }
+
+/// A test to validate that we can find PIDs associated with a map
+#[test]
+fn run_bpftool_map_pids() {
+    let map_name = "pid_write_calls";
+
+    let _skel = setup().expect("Failed to set up BPF program");
+    let output = run_bpftool_command(&["map", "list", "--json"]);
+
+    let maps = serde_json::from_slice::<Vec<Map>>(&output.stdout).expect("Failed to parse JSON");
+
+    assert!(output.status.success(), "bpftool returned an error.");
+
+    // `pid_write_calls` is a map our bpftool_tests.bpf.c uses. It should have at least
+    // one entry for our current process.
+    let map = maps
+        .iter()
+        .find(|m| m.name.is_some() && m.name.as_ref().unwrap() == map_name)
+        .unwrap_or_else(|| panic!("Did not find {} map", map_name));
+
+    let mypid = std::process::id() as u64;
+    assert!(
+        map.pids.iter().any(|p| p.pid == mypid),
+        "Did not find test runner pid ({}) in pids list associated with map *{}*: {:?}",
+        mypid,
+        map_name,
+        map.pids
+    );
+}
-- 
2.39.3


