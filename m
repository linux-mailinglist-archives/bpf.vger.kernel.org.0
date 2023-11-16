Return-Path: <bpf+bounces-15208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861847EE79D
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234581F25651
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D61E48CC7;
	Thu, 16 Nov 2023 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs3pXLP/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E7196
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:12 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce327458a6so580786a34.1
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163791; x=1700768591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzaCTZlR32Fo7kXCFMno+T8cUIukwclcqaYQngZoWNg=;
        b=Gs3pXLP/En9touuD8wvV9BdA8B3/iWixJJ37PfwdvRTcjRcb16tLExxnbBfLTd95U8
         ilNqoZCU7f9Q3kZgsmbEb9O2JrRiSJLH7IlI36pQRyYUY2NXCvTtnON+dyjQ/cCyn2aY
         f/GChVQEqZR+EUyaUBx0YF54+zzX+kkgRBeOxxdU6OXBq4g9Duil2p+uKZN1sFkEZlGM
         PFFFm98DiiceiFINy8vRaETdyxQT1+vdmzYPEV16CUZkG9RxfAxDmGebFrqDY/BF6SK6
         BImLdC04yXOrZ9DDu+JMDGYgcP9v6kS8PGbSgxxbTpVzCtXCLx0uG1FPdN8onHrsH9wm
         SaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163791; x=1700768591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzaCTZlR32Fo7kXCFMno+T8cUIukwclcqaYQngZoWNg=;
        b=HUDBOdrtlS+nJXJYtetyq8/elyBiiK3z/YnSNkZ5RI50iKRaUKbxLgz/0DiEyqeTtO
         ZVdIWnpNqVwTqohlA+R3/RPWPT4bJ1+zg8O49zvFLPdyUrYZ+X6yTuEmVIL7l0UlzFjC
         KYqXSj2gDxHAOHUMmIg/SsSYl/tik99NdTS8yBLzROTBIrHy45w74v/sZf9zlRye9uV6
         7ufyD4XL6KpqY+qQb+WAQO2Hi4dQcckbjb7OjFrRqiaBGGcqRPvO2wVPXb8i+07D2ejC
         jCYYzShIJ16SRKsrvkHQr+ngm90bFHgf8BBG3v5TSrGTYgJONlPuXb2BKjubkkhFs08v
         rkbQ==
X-Gm-Message-State: AOJu0YyMqP+Afn7KpgQjSdCgb7XjwWf7w4USF2x46WPAR1qtTWja8QeI
	rncgXRuBudRvKjTmk91JqLMWRocjbbFW2A==
X-Google-Smtp-Source: AGHT+IFslngQ1DYj4pVuDT5Fjs1/u0NGmtT3UH47hpOeJNRG0PYrf8uKuGE0xWjeQK4eb4wCw0L5JQ==
X-Received: by 2002:a9d:7387:0:b0:6bd:9f5:a9a with SMTP id j7-20020a9d7387000000b006bd09f50a9amr1195158otk.18.1700163791013;
        Thu, 16 Nov 2023 11:43:11 -0800 (PST)
Received: from localhost (fwdproxy-vll-001.fbsv.net. [2a03:2880:12ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id q3-20020a9d6543000000b006cd09ba046fsm1164otl.61.2023.11.16.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:10 -0800 (PST)
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
Subject: [PATCH v1 bpf-next  1/9] bpftool: add testing skeleton
Date: Thu, 16 Nov 2023 11:42:28 -0800
Message-Id: <20231116194236.1345035-2-chantr4@gmail.com>
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

Add minimal cargo project to test bpftool.
An environment variable `BPFTOOL_PATH` can be used to provide the path
to bpftool, defaulting to /usr/sbin/bpftool

    $ cargo check --tests
        Finished dev [unoptimized + debuginfo] target(s) in 0.00s
    $ cargo clippy --tests
        Finished dev [unoptimized + debuginfo] target(s) in 0.05s
    $ BPFTOOL_PATH='../bpftool' cargo test -- --nocapture
        Finished test [unoptimized + debuginfo] target(s) in 0.05s
         Running unittests src/main.rs
    (target/debug/deps/bpftool_tests-172b867215e9364e)

    running 1 test
    Running command "../bpftool" "version"
    test bpftool_tests::run_bpftool ... ok

    test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
    out; finished in 0.00s

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../selftests/bpf/bpftool_tests/.gitignore    |  3 +++
 .../selftests/bpf/bpftool_tests/Cargo.toml    |  4 ++++
 .../bpf/bpftool_tests/src/bpftool_tests.rs    | 20 +++++++++++++++++++
 .../selftests/bpf/bpftool_tests/src/main.rs   |  3 +++
 4 files changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/.gitignore
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/src/main.rs

diff --git a/tools/testing/selftests/bpf/bpftool_tests/.gitignore b/tools/testing/selftests/bpf/bpftool_tests/.gitignore
new file mode 100644
index 000000000000..cf8177c6aabd
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/target/**
+/Cargo.lock
diff --git a/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml b/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
new file mode 100644
index 000000000000..34df3002003f
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
@@ -0,0 +1,4 @@
+[package]
+name = "bpftool_tests"
+version = "0.1.0"
+edition = "2021"
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
new file mode 100644
index 000000000000..251dbf3861fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+use std::process::Command;
+
+const BPFTOOL_PATH_ENV: &str = "BPFTOOL_PATH";
+const BPFTOOL_PATH: &str = "/usr/sbin/bpftool";
+
+/// Run a bpftool command and returns the output
+fn run_bpftool_command(args: &[&str]) -> std::process::Output {
+    let mut cmd = Command::new(std::env::var(BPFTOOL_PATH_ENV).unwrap_or(BPFTOOL_PATH.to_string()));
+    cmd.args(args);
+    println!("Running command {:?}", cmd);
+    cmd.output().expect("failed to execute process")
+}
+
+/// Simple test to make sure we can run bpftool
+#[test]
+fn run_bpftool() {
+    let output = run_bpftool_command(&["version"]);
+    assert!(output.status.success());
+}
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/main.rs b/tools/testing/selftests/bpf/bpftool_tests/src/main.rs
new file mode 100644
index 000000000000..6b4ffcde7406
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/main.rs
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+#[cfg(test)]
+mod bpftool_tests;
-- 
2.39.3


