Return-Path: <bpf+bounces-15211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4307EE7A0
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32497280FA4
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C64655C;
	Thu, 16 Nov 2023 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIh5lIdB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DAB196
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:18 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ea82246069so604587fac.3
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163797; x=1700768597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H608VgudrD6edIFRUAcWatdKfbzlLpKzpDlMJ9cjEko=;
        b=hIh5lIdBC6+EPSIvkMAYz3bGGguUsjoye+rGJbyjkJp66/Lplt4C+V/s+04OFfOVWY
         5EQiTVfyVgRydzEVvvWECiKjI6HJ+vtUrr4aCl28CHZOC/LsRrbbUhEmL+mZoLD2203r
         +saBysJegI6EtXCmh6E3oICXFIpiN68cTtO1DnAFBJ4vi++2VTrqXM0Os0lmdUnlsyqw
         9eKV/+Z99marLk41rf5uKZtW37OGS01odisCNY3PPu9tsMeng4YnRhF2ypSOqZvvs03h
         bzVyS8w3WlCS2iW+ZSKzgXxjjLekXxKg2apzq71wlxXQo9A6ierKmE+iwcsSKyMumBIk
         PI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163797; x=1700768597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H608VgudrD6edIFRUAcWatdKfbzlLpKzpDlMJ9cjEko=;
        b=tx6VdmaMp+eDek1GQgjv0V3RgwNuJPyFV3caxijPd4JyS52rs7ChTv7tWpkEqbOxap
         4UBfKRa8mVuEHBjVjA3/r2REbbtdAyWVuitVBwNy67hoYTUVQbokBgdNZ/08mbJ/6qGN
         SYz4IjNYs6FbAiIMeqI6kBxXU7ye5Smw2OIbKeew7Nmp7hb9qoAlTcDlSnCHJ7l0xC/b
         Ho6Q4FXKncPO4Kw5wF9Yi3n++HwxRfgUokNfpQd2cwbASil4EszPmyWgg9KgnJGocWnb
         wnKsi3Uk9jd5LQSDNrX8ziKUuqdFj7BehbA8ZtCpmLfZdjEBaMKW0CenUPptEWgPWaGE
         xlRQ==
X-Gm-Message-State: AOJu0YxPICAd7wMrvqlLx1h6kEbQeU7NExDV4aLgSkmlHSKDQjC7kCUj
	eR4QBz5Oym4cBZQuvVAkZIfU8FfpXWCx+A==
X-Google-Smtp-Source: AGHT+IHwSJE6619ha6eECv5rLmMoTewrpN/6/+wEImi9C1t9xTxyeIHIUziT1V54Rj1wHj0uxpZgwQ==
X-Received: by 2002:a05:6871:4594:b0:1f4:d347:df08 with SMTP id nl20-20020a056871459400b001f4d347df08mr21598736oab.17.1700163796857;
        Thu, 16 Nov 2023 11:43:16 -0800 (PST)
Received: from localhost (fwdproxy-vll-120.fbsv.net. [2a03:2880:12ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id cj3-20020a05687c040300b001e11ad88f7csm6506oac.30.2023.11.16.11.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:16 -0800 (PST)
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
Subject: [PATCH v1 bpf-next  3/9] bpftool: open and load bpf object
Date: Thu, 16 Nov 2023 11:42:30 -0800
Message-Id: <20231116194236.1345035-4-chantr4@gmail.com>
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

Add an initial test that excercises opening and loading a bpf object.

    BPFTOOL_PATH=../bpftool
    CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER="sudo -E" cargo test --
    --nocapture
        Finished test [unoptimized + debuginfo] target(s) in 0.04s
         Running unittests src/main.rs
    (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)

    running 2 tests
    Running command "../bpftool" "version"
    Running command "../bpftool" "map" "list" "--json"
    test bpftool_tests::run_bpftool ... ok
    test bpftool_tests::run_bpftool_map_list ... ok

    test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
    out; finished in 0.19s

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../selftests/bpf/bpftool_tests/Cargo.toml    |  3 ++
 .../bpf/bpftool_tests/src/bpftool_tests.rs    | 50 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml b/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
index 35c834082351..cc1fa65189f2 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
+++ b/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
@@ -5,7 +5,10 @@ edition = "2021"
 
 # See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
 [dependencies]
+anyhow = "1"
 libbpf-rs = "0.21"
+serde = { version = "1", features = ["derive"] }
+serde_json = "1"
 
 [build-dependencies]
 libbpf-cargo = "0.21"
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
index 35eb35831dce..fb58898a4a1a 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
@@ -3,11 +3,49 @@ mod bpftool_tests_skel {
     include!(concat!(env!("OUT_DIR"), "/bpftool_tests.skel.rs"));
 }
 
+use anyhow::Result;
+use bpftool_tests_skel::BpftoolTestsSkel;
+use bpftool_tests_skel::BpftoolTestsSkelBuilder;
+use libbpf_rs::skel::OpenSkel;
+use libbpf_rs::skel::SkelBuilder;
+use serde::Deserialize;
+use serde::Serialize;
+
 use std::process::Command;
 
 const BPFTOOL_PATH_ENV: &str = "BPFTOOL_PATH";
 const BPFTOOL_PATH: &str = "/usr/sbin/bpftool";
 
+/// A struct representing a pid entry from map/prog dump
+#[derive(Serialize, Deserialize, Debug)]
+struct Pid {
+    comm: String,
+    pid: u64,
+}
+
+/// A struct representing a map entry from `bpftool map list -j`
+#[derive(Serialize, Deserialize, Debug)]
+struct Map {
+    name: Option<String>,
+    id: u64,
+    r#type: String,
+    #[serde(default)]
+    pids: Vec<Pid>,
+}
+
+/// Setup our bpftool_tests.bpf.c program.
+/// Open and load and return an opened object.
+fn setup() -> Result<BpftoolTestsSkel<'static>> {
+    let mut skel_builder = BpftoolTestsSkelBuilder::default();
+    skel_builder.obj_builder.debug(false);
+
+    let open_skel = skel_builder.open()?;
+
+    let skel = open_skel.load()?;
+
+    Ok(skel)
+}
+
 /// Run a bpftool command and returns the output
 fn run_bpftool_command(args: &[&str]) -> std::process::Output {
     let mut cmd = Command::new(std::env::var(BPFTOOL_PATH_ENV).unwrap_or(BPFTOOL_PATH.to_string()));
@@ -22,3 +60,15 @@ fn run_bpftool() {
     let output = run_bpftool_command(&["version"]);
     assert!(output.status.success());
 }
+
+/// A test to validate that we can list maps using bpftool
+#[test]
+fn run_bpftool_map_list() {
+    let _skel = setup().expect("Failed to set up BPF program");
+    let output = run_bpftool_command(&["map", "list", "--json"]);
+
+    let maps = serde_json::from_slice::<Vec<Map>>(&output.stdout).expect("Failed to parse JSON");
+
+    assert!(output.status.success(), "bpftool returned an error.");
+    assert!(!maps.is_empty(), "No maps were listed");
+}
-- 
2.39.3


