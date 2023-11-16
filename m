Return-Path: <bpf+bounces-15215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CC17EE7A5
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04A1B20AAC
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABEA48CF3;
	Thu, 16 Nov 2023 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOnhOMYA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1784D50
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:27 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b6d80daae8so752709b6e.2
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163807; x=1700768607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrWhBCNz4UmXv7NkWcd22Z4lzc3/kxqEnof8fA00d/U=;
        b=KOnhOMYA1vik2A+MsdaqrjI92/dr+vVB4tfS+IKAHKYEWtNoMgNeypNkLNDTQRci4t
         9uodgthdoTBSpM/87JpwS9M30wI1m1MqdTWN9WnGpapBllfZ2YjsfhELTGOCbVb6vafj
         ZhR38W58sJl/qDMa2/C8I/01ESk3veNJLhp3DnVnv7wvnop1MvN2Z+fO4sn0IdVC6Bu7
         z2o4/7PNcRQlZFW4AwCQ6C9Pw2Qx3u3eKuBu8dUs74xtzC0BJrXriTPo+b9ZqT/p7Jdu
         LfOgw+daKV6fKvPSBXaDZ0+ebgxwZYs59k/Jp1wOzR3sBXonAjavxj72o5Mh1kyvpwVz
         LwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163807; x=1700768607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrWhBCNz4UmXv7NkWcd22Z4lzc3/kxqEnof8fA00d/U=;
        b=pcNFovCGeYyjaPDa0WXvlEuJaGq1oFl3dFf/SD0tsFmTFc45w/6MH9o0BUbWhgvyYE
         AHaZIuQQv5UAW2p6/e6Lj1NikrhwfiZNS7QZbvOvwIzivMnEOrwAsiS6o2863AuVH5N8
         7jLvZIvSwfUkvKgujcqFKFox5D0Kl0zBhpo/mRhE7uyLAAH1jREEMPPglVtIZHpTzC3j
         82KcIHMDFMT+8J7KrMVC5/QrpYMIdLRKS63Kj4t401e41Xu4gmC6FLhHifizCSYw2pUL
         f4fvbiFVZmKUqPiOEHCB6Czxsh3Eh2xzkZ1MBg6vP621jxagIIBBq8VCQbvqD2GLiLCq
         6UqQ==
X-Gm-Message-State: AOJu0YyjfwXh4t10vT3Ez1TziSTw8LcDiSMhOZrVq/uOy2+cZ8LD0u3E
	E4Aa5YmP1mAiPC5vfJObLQSZQ+MvExATVA==
X-Google-Smtp-Source: AGHT+IHMKwWIEzxhuNTNCBWoCe385B3Bz7MiP0Pewia9yc6zHHthpHRnI3LuvNiT4rcg7aLvN4O8lw==
X-Received: by 2002:a05:6808:208e:b0:3af:611c:c74f with SMTP id s14-20020a056808208e00b003af611cc74fmr23128136oiw.5.1700163806849;
        Thu, 16 Nov 2023 11:43:26 -0800 (PST)
Received: from localhost (fwdproxy-vll-006.fbsv.net. [2a03:2880:12ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id v16-20020a056808005000b003b2e7231faasm13362oic.28.2023.11.16.11.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:26 -0800 (PST)
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
Subject: [PATCH v1 bpf-next  7/9] bpftool: Add struct_ops tests
Date: Thu, 16 Nov 2023 11:42:34 -0800
Message-Id: <20231116194236.1345035-8-chantr4@gmail.com>
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

Add test to verify that we can:
- unregister a struct_ops by id and name
- list struct_ops
- dump a struct_ops by name

    $ RUST_TEST_THREADS=1 BPFTOOL_PATH=../tools/build/bpftool/bpftool
    CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER="sudo -E" cargo test --
    --nocapture
        Finished test [unoptimized + debuginfo] target(s) in 0.05s
         Running unittests src/main.rs
    (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)

    running 11 tests
    test bpftool_tests::run_bpftool ... Running command
    "../tools/build/bpftool/bpftool" "version"
    ok
    test bpftool_tests::run_bpftool_map_dump_id ... Running command
    "../tools/build/bpftool/bpftool" "map" "dump" "id" "1851884" "--json"
    ok
    test bpftool_tests::run_bpftool_map_list ... Running command
    "../tools/build/bpftool/bpftool" "map" "list" "--json"
    ok
    test bpftool_tests::run_bpftool_map_pids ... Running command
    "../tools/build/bpftool/bpftool" "map" "list" "--json"
    ok
    test bpftool_tests::run_bpftool_prog_list ... Running command
    "../tools/build/bpftool/bpftool" "prog" "list" "--json"
    ok
    test bpftool_tests::run_bpftool_prog_pids ... Running command
    "../tools/build/bpftool/bpftool" "prog" "list" "--json"
    ok
    test bpftool_tests::run_bpftool_prog_show_id ... Running command
    "../tools/build/bpftool/bpftool" "prog" "show" "id" "3166535" "--json"
    ok
    test bpftool_tests::run_bpftool_struct_ops_can_unregister_id ... Running
    command "../tools/build/bpftool/bpftool" "struct_ops" "dump" "name"
    "bt_e2e_tco" "--pretty"
    Running command "../tools/build/bpftool/bpftool" "struct_ops"
    "unregister" "id" "1851939"
    ok
    test bpftool_tests::run_bpftool_struct_ops_can_unregister_name ...
    Running command "../tools/build/bpftool/bpftool" "struct_ops" "dump"
    "name" "bt_e2e_tco" "--pretty"
    Running command "../tools/build/bpftool/bpftool" "struct_ops"
    "unregister" "name" "bt_e2e_tco"
    ok
    test bpftool_tests::run_bpftool_struct_ops_dump_name ... Running command
    "../tools/build/bpftool/bpftool" "struct_ops" "dump" "name" "bt_e2e_tco"
    "--pretty"
    ok
    test bpftool_tests::run_bpftool_struct_ops_list ... Running command
    "../tools/build/bpftool/bpftool" "struct_ops" "list" "--json"
    ok

    test result: ok. 11 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
    out; finished in 1.84s

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../bpftool_tests/src/bpf/bpftool_tests.bpf.c |  55 +++++++
 .../bpf/bpftool_tests/src/bpftool_tests.rs    | 145 ++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
index a90c8921b4ee..c59df9d947ed 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
 
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
 
@@ -32,3 +34,56 @@ int handle_tp_sys_enter_write(void *ctx)
 
 	return 0;
 }
+
+// struct_ops example
+
+#define BPF_STRUCT_OPS(name, args...)	\
+	SEC("struct_ops/" #name)			\
+	BPF_PROG(name, args)
+
+void BPF_STRUCT_OPS(tcp_init, struct sock *sk)
+{
+	return;
+}
+
+void BPF_STRUCT_OPS(in_ack_event, struct sock *sk, __u32 flags)
+{
+	return;
+}
+
+__u32 BPF_STRUCT_OPS(ssthresh, struct sock *sk)
+{
+	return 0;
+}
+
+void BPF_STRUCT_OPS(set_state, struct sock *sk, __u8 new_state)
+{
+	return;
+}
+
+void BPF_STRUCT_OPS(cwnd_event, struct sock *sk, enum tcp_ca_event ev)
+{
+	return;
+}
+
+__u32 BPF_STRUCT_OPS(cwnd_undo, struct sock *sk)
+{
+	return 0;
+}
+
+void BPF_STRUCT_OPS(cong_avoid, struct sock *sk, __u32 ack, __u32 acked)
+{
+	return;
+}
+
+SEC(".struct_ops")
+struct tcp_congestion_ops bt_e2e_tco = {
+	.init = (void *)tcp_init,
+	.in_ack_event = (void *)in_ack_event,
+	.cwnd_event = (void *)cwnd_event,
+	.ssthresh = (void *)ssthresh,
+	.cong_avoid = (void *)cong_avoid,
+	.undo_cwnd = (void *)cwnd_undo,
+	.set_state = (void *)set_state,
+	.name = "bt_e2e_tco",
+};
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
index 90187152c1d1..ecb9e92d7bac 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
@@ -7,6 +7,7 @@ mod bpftool_tests_skel {
 use bpftool_tests_skel::BpftoolTestsSkel;
 use bpftool_tests_skel::BpftoolTestsSkelBuilder;
 use libbpf_rs::skel::OpenSkel;
+use libbpf_rs::skel::Skel;
 use libbpf_rs::skel::SkelBuilder;
 use libbpf_rs::Program;
 use serde::Deserialize;
@@ -16,6 +17,7 @@ mod bpftool_tests_skel {
 
 const BPFTOOL_PATH_ENV: &str = "BPFTOOL_PATH";
 const BPFTOOL_PATH: &str = "/usr/sbin/bpftool";
+const STRUCT_OPS_MAP_NAME: &str = "bt_e2e_tco";
 
 /// A struct representing a pid entry from map/prog dump
 #[derive(Serialize, Deserialize, Debug)]
@@ -62,6 +64,34 @@ struct MapItem {
     formatted: Option<FormattedMapItem>,
 }
 
+/// A struct representing the map info from `bpftool struct_ops dump id <id>`
+#[derive(Serialize, Deserialize, Debug)]
+struct MapInfo {
+    name: String,
+    id: u64,
+}
+
+/// A struct representing a struct_ops entry from `bpftool struct_ops list -j`
+#[derive(Serialize, Deserialize, Debug)]
+struct StructOps {
+    name: String,
+    id: u64,
+    kernel_struct_ops: String,
+}
+
+/// A struct representing a struct_ops entry from `bpftool struct_ops dump id <id>`
+#[derive(Serialize, Deserialize, Debug)]
+struct StructOpsCongestion {}
+
+/// A struct representing a struct_ops entry from `bpftool struct_ops dump id <id>`
+/// The returned json seems to be a tuple of two elements.
+/// the first one being a MapInfo, the second one being a StructOpsCongestion.
+#[derive(Serialize, Deserialize, Debug)]
+struct StructOpsDump {
+    bpf_map_info: Option<MapInfo>,
+    bpf_struct_ops_tcp_congestion_ops: Option<StructOpsCongestion>,
+}
+
 /// A helper function to convert a vector of strings as returned by bpftool
 /// into a vector of bytes.
 /// bpftool returns key/value in the form of a sequence of strings
@@ -264,3 +294,118 @@ fn run_bpftool_prog_show_id() {
     );
     assert_eq!("tracepoint", prog.r#type);
 }
+
+/// A test to validate that we can list struct_ops using bpftool
+#[test]
+fn run_bpftool_struct_ops_list() {
+    let _skel = setup().expect("Failed to set up BPF program");
+    let output = run_bpftool_command(&["struct_ops", "list", "--json"]);
+
+    let maps =
+        serde_json::from_slice::<Vec<StructOps>>(&output.stdout).expect("Failed to parse JSON");
+
+    assert!(output.status.success(), "bpftool returned an error.");
+    assert!(!maps.is_empty(), "No maps were listed");
+}
+
+/// A test to validate that we can dump a struct_ops program using its name
+#[test]
+fn run_bpftool_struct_ops_dump_name() {
+    let _skel = setup().expect("Failed to set up BPF program");
+    let output = run_bpftool_command(&[
+        "struct_ops",
+        "dump",
+        "name",
+        STRUCT_OPS_MAP_NAME,
+        "--pretty",
+    ]);
+
+    assert!(output.status.success(), "bpftool returned an error.");
+
+    let struct_ops =
+        serde_json::from_slice::<Vec<StructOpsDump>>(&output.stdout).expect("Failed to parse JSON");
+    assert!(!struct_ops.is_empty(), "No struct_ops were found");
+
+    assert_eq!(
+        struct_ops[0]
+            .bpf_map_info
+            .as_ref()
+            .expect("Missing bpf_map_info field")
+            .name,
+        STRUCT_OPS_MAP_NAME
+    );
+}
+
+/// A test to validate that we can unregister a struct_ops using its id
+#[test]
+fn run_bpftool_struct_ops_can_unregister_id() {
+    let skel = setup().expect("Failed to set up BPF program");
+    let output = run_bpftool_command(&[
+        "struct_ops",
+        "dump",
+        "name",
+        STRUCT_OPS_MAP_NAME,
+        "--pretty",
+    ]);
+
+    let _link = skel
+        .object()
+        .map(STRUCT_OPS_MAP_NAME)
+        .unwrap_or_else(|| panic!("Could not find map {}", STRUCT_OPS_MAP_NAME))
+        .attach_struct_ops()
+        .expect("Could not attach to struct_ops");
+
+    assert!(output.status.success(), "bpftool returned an error.");
+
+    let struct_ops =
+        serde_json::from_slice::<Vec<StructOpsDump>>(&output.stdout).expect("Failed to parse JSON");
+
+    assert!(!struct_ops.is_empty(), "No struct_ops were found");
+
+    let id = struct_ops[0]
+        .bpf_map_info
+        .as_ref()
+        .expect("Missing bpf_map_info field")
+        .id;
+
+    let output = run_bpftool_command(&["struct_ops", "unregister", "id", &id.to_string()]);
+    assert!(
+        output.status.success(),
+        "Failed to unregister struct_ops program: {:?}",
+        output
+    );
+}
+
+/// A test to validate that we can unregister a struct_ops using its name
+#[test]
+fn run_bpftool_struct_ops_can_unregister_name() {
+    let skel = setup().expect("Failed to set up BPF program");
+    let output = run_bpftool_command(&[
+        "struct_ops",
+        "dump",
+        "name",
+        STRUCT_OPS_MAP_NAME,
+        "--pretty",
+    ]);
+
+    let _link = skel
+        .object()
+        .map(STRUCT_OPS_MAP_NAME)
+        .unwrap_or_else(|| panic!("Could not find map {}", STRUCT_OPS_MAP_NAME))
+        .attach_struct_ops()
+        .expect("Could not attach to struct_ops");
+
+    assert!(output.status.success(), "bpftool returned an error.");
+
+    let struct_ops =
+        serde_json::from_slice::<Vec<StructOpsDump>>(&output.stdout).expect("Failed to parse JSON");
+
+    assert!(!struct_ops.is_empty(), "No struct_ops were found");
+
+    let output = run_bpftool_command(&["struct_ops", "unregister", "name", STRUCT_OPS_MAP_NAME]);
+    assert!(
+        output.status.success(),
+        "Failed to unregister struct_ops program: {:?}",
+        output
+    );
+}
-- 
2.39.3


