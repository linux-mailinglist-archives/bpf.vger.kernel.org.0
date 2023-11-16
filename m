Return-Path: <bpf+bounces-15213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B677EE7A2
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BCD1C20A84
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C348CEA;
	Thu, 16 Nov 2023 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns/jTeg7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC84218D
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:22 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2e73a17a0so721234b6e.3
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163802; x=1700768602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSAFrdd8ohAsBGoigzzsKM5sLuyIw6fjiuYJlf0IDdw=;
        b=Ns/jTeg7ycg+AAMzWBy3yPIdEwsCx0qHTWzh82UbT7rDUMU0i7lRXlTozPkDVbyvMV
         KdmnTbqBKpFp1EqG8Gvx9WRzyYDvbEc2QX8uIGNP15XZDBMtq0/s0Jf1JpAn45Uj/aZH
         1RHnjYie2z2u6RrKPfDHsZ1duw5y+vzoxIezhMwJcYikMoE0Ynj0lh/mujBhJiZMBfw2
         MnjCaOYTxiwbNeGQtpBp5Apw1aVLL/FwCDWSaS1k2LfkxjIooPRWYbM4m5EtgOc9wLZ+
         9OYxOtV/XDYKeMIUT2vJgVYBbSKXR11/YRNcw1xbFzDCmiQsGMbkUiElvRw4nB2tTGGk
         p+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163802; x=1700768602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSAFrdd8ohAsBGoigzzsKM5sLuyIw6fjiuYJlf0IDdw=;
        b=dzJbVzaV3hRvA+PpQcs2Pk1bLk0MdNDoNI9nfj2O13HOyxlkLAiLQ0ZiDk8GmnRIT9
         IZBLUX8b3BiaL/W+Ncj9xhzhvpLfCEmEMlt3uMrBOZVDkCHY7RLfo2+j8s7oaExd8l7C
         CM+vOg5/Gd2+3oEOqqynLouBh/omvR4zdPtLDrHc1nRVbs9NVjsGdqJfxSy1y9GJUpVz
         E5a/EIBUSt7j3ODVIasyM692R6t1ZHayyy+LmS+vEC3xVAU0mj6DXIMc+wBO4I9mARH/
         5Qnrx3QqYh6k9OjzISmkf/ltdZYz8lhdYlLNFvvqOFKqcRXB0ir9Sqh57NsNDfZNtVQ3
         9oPA==
X-Gm-Message-State: AOJu0YwCJnebSBdotuffMIKkDwgMphsg6cys7pX0tZJFlW4EveLXP7rj
	dYL5eQ16zklXaKRx2eWWwh/Lvk6MIRvSsA==
X-Google-Smtp-Source: AGHT+IEYOTGDgZjDSlYphUtBB+oUfAmMtxnxwCu9m6PV3G9pPTFH11l0yi4DMm9s3ZflDOVizi03wg==
X-Received: by 2002:a54:4097:0:b0:3ad:fc3f:1202 with SMTP id i23-20020a544097000000b003adfc3f1202mr18120828oii.53.1700163801747;
        Thu, 16 Nov 2023 11:43:21 -0800 (PST)
Received: from localhost (fwdproxy-vll-116.fbsv.net. [2a03:2880:12ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id n7-20020a05680803a700b003ae3768ba4csm9158oie.58.2023.11.16.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:21 -0800 (PST)
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
Subject: [PATCH v1 bpf-next  5/9] bpftool: add test for bpftool prog
Date: Thu, 16 Nov 2023 11:42:32 -0800
Message-Id: <20231116194236.1345035-6-chantr4@gmail.com>
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

Add tests that validate `bpftool prog list` functions, that we can
associate pids with them, and that we can show a prog by id.

    $ BPFTOOL_PATH=../bpftool
    CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER="sudo -E" cargo test --
    --nocapture
        Finished test [unoptimized + debuginfo] target(s) in 0.05s
         Running unittests src/main.rs
    (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)

    running 6 tests
    Running command "../bpftool" "version"
    test bpftool_tests::run_bpftool ... ok
    Running command "../bpftool" "map" "list" "--json"
    Running command "../bpftool" "prog" "list" "--json"
    Running command "../bpftool" "prog" "list" "--json"
    Running command "../bpftool" "map" "list" "--json"
    Running command "../bpftool" "prog" "show" "id" "3160417" "--json"
    test bpftool_tests::run_bpftool_prog_show_id ... ok
    test bpftool_tests::run_bpftool_map_pids ... ok
    test bpftool_tests::run_bpftool_map_list ... ok
    test bpftool_tests::run_bpftool_prog_pids ... ok
    test bpftool_tests::run_bpftool_prog_list ... ok

    test result: ok. 6 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
    out; finished in 0.20s

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../bpftool_tests/src/bpf/bpftool_tests.bpf.c |  2 +-
 .../bpf/bpftool_tests/src/bpftool_tests.rs    | 79 ++++++++++++++++++-
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
index dbd4e2aad277..e2b18dd36207 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
@@ -14,7 +14,7 @@ struct {
 int my_pid = 0;
 
 SEC("tp/syscalls/sys_enter_write")
-int handle_tp(void *ctx)
+int handle_tp_sys_enter_write(void *ctx)
 {
 	int pid = bpf_get_current_pid_tgid() >> 32;
 
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
index a832b255e988..695a1cbc5be8 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
@@ -8,9 +8,10 @@ mod bpftool_tests_skel {
 use bpftool_tests_skel::BpftoolTestsSkelBuilder;
 use libbpf_rs::skel::OpenSkel;
 use libbpf_rs::skel::SkelBuilder;
+use libbpf_rs::Program;
 use serde::Deserialize;
 use serde::Serialize;
-
+use std::os::fd::AsFd;
 use std::process::Command;
 
 const BPFTOOL_PATH_ENV: &str = "BPFTOOL_PATH";
@@ -23,6 +24,17 @@ struct Pid {
     pid: u64,
 }
 
+/// A struct representing a prog entry from `bpftool prog list -j`
+#[derive(Serialize, Deserialize, Debug)]
+struct Prog {
+    name: Option<String>,
+    id: u32,
+    r#type: String,
+    tag: String,
+    #[serde(default)]
+    pids: Vec<Pid>,
+}
+
 /// A struct representing a map entry from `bpftool map list -j`
 #[derive(Serialize, Deserialize, Debug)]
 struct Map {
@@ -101,3 +113,68 @@ fn run_bpftool_map_pids() {
         map.pids
     );
 }
+
+/// A test to validate that we can list programs using bpftool
+#[test]
+fn run_bpftool_prog_list() {
+    let _skel = setup().expect("Failed to set up BPF program");
+    let output = run_bpftool_command(&["prog", "list", "--json"]);
+
+    let progs = serde_json::from_slice::<Vec<Prog>>(&output.stdout).expect("Failed to parse JSON");
+
+    assert!(output.status.success());
+    assert!(!progs.is_empty(), "No programs were listed");
+}
+
+/// A test to validate that we can find PIDs associated with a program
+#[test]
+fn run_bpftool_prog_pids() {
+    let hook_name = "handle_tp_sys_enter_write";
+
+    let _skel = setup().expect("Failed to set up BPF program");
+    let output = run_bpftool_command(&["prog", "list", "--json"]);
+
+    let progs = serde_json::from_slice::<Vec<Prog>>(&output.stdout).expect("Failed to parse JSON");
+    assert!(output.status.success(), "bpftool returned an error.");
+
+    // `handle_tp_sys_enter_write` is a hook our bpftool_tests.bpf.c attaches
+    // to (tp/syscalls/sys_enter_write).
+    // It should have at least one entry for our current process.
+    let prog = progs
+        .iter()
+        .find(|m| m.name.is_some() && m.name.as_ref().unwrap() == hook_name)
+        .unwrap_or_else(|| panic!("Did not find {} prog", hook_name));
+
+    let mypid = std::process::id() as u64;
+    assert!(
+        prog.pids.iter().any(|p| p.pid == mypid),
+        "Did not find test runner pid ({}) in pids list associated with prog *{}*: {:?}",
+        mypid,
+        hook_name,
+        prog.pids
+    );
+}
+
+/// A test to validate that we can run `bpftool prog show <id>`
+/// an extract the expected information.
+#[test]
+fn run_bpftool_prog_show_id() {
+    let skel = setup().expect("Failed to set up BPF program");
+    let binding = skel.progs();
+    let handle_tp_sys_enter_write = binding.handle_tp_sys_enter_write();
+    let prog_id =
+        Program::get_id_by_fd(handle_tp_sys_enter_write.as_fd()).expect("Failed to get prog ID");
+
+    let output = run_bpftool_command(&["prog", "show", "id", &prog_id.to_string(), "--json"]);
+    assert!(output.status.success(), "bpftool returned an error.");
+
+    let prog = serde_json::from_slice::<Prog>(&output.stdout).expect("Failed to parse JSON");
+
+    assert_eq!(prog_id, prog.id);
+    assert_eq!(
+        handle_tp_sys_enter_write.name(),
+        prog.name
+            .expect("Program handle_tp_sys_enter_write has no name")
+    );
+    assert_eq!("tracepoint", prog.r#type);
+}
-- 
2.39.3


