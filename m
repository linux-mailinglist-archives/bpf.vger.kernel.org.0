Return-Path: <bpf+bounces-15214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540837EE7A3
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E38A2810ED
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392848CE3;
	Thu, 16 Nov 2023 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNP+GwmI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DE6D4B
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:25 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58786e23d38so672328eaf.3
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163804; x=1700768604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+6v8r+I4Xjr9cce6cYqpibCf+6XfAvex5lLVZa0Wjg=;
        b=YNP+GwmIwiey7qUK//HIz+eyf+qJnuFc4ystRzfVgWHQV6YLcEgxHhqqp3UdI5GpNc
         SPEEtNPythiEiV5t5BXDiVAuYL3/JLBgM/BoRWBD6fY+2Ck6LUIdHp2rGuHiHrIR97tK
         UyrVSv5PnrV9iG134N8JqBW/Rn71tf8nhst0jtTKuzo34gVdATKVBP9JAqzyC1Jl+tkZ
         cXolHhr7Le3UO2369kp0zOQkoZhLdSpdN4zK+5c728Fxl6HejDjTN6/8t5S4jXJ6Hb38
         3lXCPfFV4mkYOcwRJymS4XGLswPyQP/yT9xZ06lHzs7UhTP44Ic3MUPVduVBpY1hr64t
         v99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163804; x=1700768604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+6v8r+I4Xjr9cce6cYqpibCf+6XfAvex5lLVZa0Wjg=;
        b=TzI/Yw2rsURh5szBFen6SlfrxgA+7ffX8+m9Jw32WrIjSEOnKd0dgjeLn6I60mM0y8
         XZcAloQHoSt7AU7rpj9Xoc/ITQ/BZbFG+1bVAQSe/Ak6sHzAuorSsfKRJTDApO0coLqG
         75/Q5rBZCRP8F/kvbo32F/4KPZx5w63bSkCGsKmbv0Rt4HwD39sU9pj1YnOkLqrRtmuF
         BCdjxUz2z7q2mzfYOq0YhDlymoSk/rmZeZnaVn6T8FE64nu1SVgoUEC+TV2zlTBnOTID
         5r9hud1oWpQeBAAg6VtDPxlPPdp/HY2zcB8r+dZqL6UT2oyyKtLwzm0RizZ0OmVg6ARt
         Xaww==
X-Gm-Message-State: AOJu0YwxKhB86Qhns2nSmIpAcxlfjoa1hGiyCE+0G70P623qD0DFTcjY
	jtLdtNk1z52GynTlV0UdchXN5pZRme2l6g==
X-Google-Smtp-Source: AGHT+IGXeb9/ODvyJuHd/BYS1DoqBmh36xMsaSw7pIWGkD9DWkJMgY/Jm5MNKhaYGN+hiVV8YS593Q==
X-Received: by 2002:a4a:de0b:0:b0:58a:231d:750d with SMTP id y11-20020a4ade0b000000b0058a231d750dmr16094942oot.9.1700163804263;
        Thu, 16 Nov 2023 11:43:24 -0800 (PST)
Received: from localhost (fwdproxy-vll-009.fbsv.net. [2a03:2880:12ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a2-20020a4a9882000000b0057b74352e3asm18199ooj.25.2023.11.16.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:23 -0800 (PST)
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
Subject: [PATCH v1 bpf-next  6/9] bpftool: test that we can dump and read the content of a map
Date: Thu, 16 Nov 2023 11:42:33 -0800
Message-Id: <20231116194236.1345035-7-chantr4@gmail.com>
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

This test adds a hardcoded key/value pair to a test map and verify
that bpftool is able to dump its content and read/format it.

    $ BPFTOOL_PATH=../bpftool
    CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER="sudo -E" cargo test --
    --nocapture
        Finished test [unoptimized + debuginfo] target(s) in 0.05s
         Running unittests src/main.rs
    (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)

    running 7 tests
    Running command "../bpftool" "version"
    test bpftool_tests::run_bpftool ... ok
    Running command "../bpftool" "map" "dump" "id" "1848713" "--json"
    Running command "../bpftool" "prog" "list" "--json"
    Running command "../bpftool" "map" "list" "--json"
    Running command "../bpftool" "prog" "list" "--json"
    Running command "../bpftool" "prog" "show" "id" "3160759" "--json"
    Running command "../bpftool" "map" "list" "--json"
    test bpftool_tests::run_bpftool_map_dump_id ... ok
    test bpftool_tests::run_bpftool_prog_show_id ... ok
    test bpftool_tests::run_bpftool_map_pids ... ok
    test bpftool_tests::run_bpftool_prog_pids ... ok
    test bpftool_tests::run_bpftool_prog_list ... ok
    test bpftool_tests::run_bpftool_map_list ... ok

    test result: ok. 7 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
    out; finished in 0.22s

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../bpftool_tests/src/bpf/bpftool_tests.bpf.c |  7 ++
 .../bpf/bpftool_tests/src/bpftool_tests.rs    | 86 +++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
index e2b18dd36207..a90c8921b4ee 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
@@ -11,6 +11,13 @@ struct {
 	__type(value, u64);
 } pid_write_calls SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__type(key, char[6]);
+	__type(value, char[6]);
+} bpftool_test_map SEC(".maps");
+
 int my_pid = 0;
 
 SEC("tp/syscalls/sys_enter_write")
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
index 695a1cbc5be8..90187152c1d1 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
@@ -45,6 +45,37 @@ struct Map {
     pids: Vec<Pid>,
 }
 
+/// A struct representing a formatted map entry from `bpftool map dump -j`
+#[derive(Serialize, Deserialize, Debug)]
+struct FormattedMapItem {
+    key: String,
+    value: String,
+}
+
+type MapVecString = Vec<String>;
+
+/// A struct representing a map entry from `bpftool map dump -j`
+#[derive(Serialize, Deserialize, Debug)]
+struct MapItem {
+    key: MapVecString,
+    value: MapVecString,
+    formatted: Option<FormattedMapItem>,
+}
+
+/// A helper function to convert a vector of strings as returned by bpftool
+/// into a vector of bytes.
+/// bpftool returns key/value in the form of a sequence of strings
+/// hexadecimal numbers. We need to convert them back to bytes.
+/// for instance, the value of the key "key" is represented as ["0x6b","0x65","0x79"]
+fn to_vec_u8(m: &MapVecString) -> Vec<u8> {
+    m.iter()
+        .map(|s| {
+            u8::from_str_radix(s.trim_start_matches("0x"), 16)
+                .unwrap_or_else(|_| panic!("Failed to parse {:?}", s))
+        })
+        .collect()
+}
+
 /// Setup our bpftool_tests.bpf.c program.
 /// Open and load and return an opened object.
 fn setup() -> Result<BpftoolTestsSkel<'static>> {
@@ -114,6 +145,61 @@ fn run_bpftool_map_pids() {
     );
 }
 
+/// A test to validate that we can run `bpftool map dump <id>`
+/// and extract the expected information.
+/// The test adds a key, value pair to the map and then dumps it.
+/// The test validates that the dumped data matches what was added.
+/// It also validate that bpftool was able to format the key/value pairs.
+#[test]
+fn run_bpftool_map_dump_id() {
+    // By having key/value null terminated, we can check that bpftool also returns the
+    // formatted content.
+    let key = b"key\0\0\0";
+    let value = b"value\0";
+    let skel = setup().expect("Failed to set up BPF program");
+    let binding = skel.maps();
+    let bpftool_test_map_map = binding.bpftool_test_map();
+    bpftool_test_map_map
+        .update(key, value, libbpf_rs::MapFlags::NO_EXIST)
+        .expect("Failed to update map");
+    let map_id = bpftool_test_map_map
+        .info()
+        .expect("Failed to get map info")
+        .info
+        .id;
+
+    let output = run_bpftool_command(&["map", "dump", "id", &map_id.to_string(), "--json"]);
+    assert!(output.status.success(), "bpftool returned an error.");
+
+    let items =
+        serde_json::from_slice::<Vec<MapItem>>(&output.stdout).expect("Failed to parse JSON");
+
+    assert_eq!(items.len(), 1);
+
+    let item = items.first().expect("Expected a map item");
+    assert_eq!(to_vec_u8(&item.key), key);
+    assert_eq!(to_vec_u8(&item.value), value);
+
+    // Validate "formatted" values.
+    // The keys and values are null terminated so we need to trim them before comparing.
+    let formatted = item
+        .formatted
+        .as_ref()
+        .expect("Formatted values are missing");
+    assert_eq!(
+        formatted.key,
+        std::str::from_utf8(key)
+            .expect("Invalid UTF-8")
+            .trim_end_matches('\0'),
+    );
+    assert_eq!(
+        formatted.value,
+        std::str::from_utf8(value)
+            .expect("Invalid UTF-8")
+            .trim_end_matches('\0'),
+    );
+}
+
 /// A test to validate that we can list programs using bpftool
 #[test]
 fn run_bpftool_prog_list() {
-- 
2.39.3


