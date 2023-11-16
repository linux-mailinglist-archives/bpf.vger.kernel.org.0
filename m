Return-Path: <bpf+bounces-15210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA87EE79F
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4921F2567F
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659E748CEA;
	Thu, 16 Nov 2023 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpr5lRdq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5718D
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:15 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1efabc436e4so617773fac.1
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163794; x=1700768594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rv85a8FjKpza20e5qCpINaXLe3icI43373bIc5/Wuw0=;
        b=Vpr5lRdqNtRJXC4wHSEHtnPXuBmqlkltcJwr7PgNNiCSmgdNdRXDSv0Q0YLqxzgbvw
         L2W0AFS83H6qy8/4uJvS5l0n80L10vUctgVNWF7aDIVu4DrXx1tObrKtwWeEoy8H62qZ
         XjecCbPWxn5hMbky0esRpD4HyB38JK3yK7qtt3RMrZu1xXdJWXjUH/1kv9e8FoZgFikp
         jc2brpxOyUyYh86CUmfZcWqiDHMMTgg5A+1/H5abuwX2qDVns00mzd/jrxJqDJdcrDF4
         YoPAkPYOCrk91R5K0wlJw5n97xWtGvLluZrf/aVyLxYi8lABXvKePutdsDxA0OlSmuU1
         LraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163794; x=1700768594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rv85a8FjKpza20e5qCpINaXLe3icI43373bIc5/Wuw0=;
        b=lOdR5gFSFqPar+abYkvHutKRyjmCfZgEHZCLZ9xaZA9nlu7/STgOi3RSFaarKFgX5i
         ZtTCblqzijeBJAo2F13CYhtjphiXCyDj6j6JFCEQHc6Dj6dMOmjahT9Ze3nHLybm8L6M
         Oj2npJyCcz3FkX8NjCQY1y+18Ee0a/+/sFlIZjJjjQZCrOb9+Qe7fPZbAu/FDk9PGc4h
         GOL1XsvphsbXgpNbIY4Nu8pO0g6xD7oR9gxe6CS8bi3gmYdyfYpUTZLXSmgWe6qQPVM/
         GxisvdrrRnYnfqD3woEZDid8o7aZ6kp6gm95JCLbD+utiW0RuYumH359CWab0hvRXpqM
         Y2fA==
X-Gm-Message-State: AOJu0YxsaK0w+UZvkfNNIALfO822kuGJa0EOj7xr1ZYUy8ZUdnIp8Y3k
	UaLPXp+CrybkdRNHCZaghdlrrlzDXIwpMg==
X-Google-Smtp-Source: AGHT+IHRuJ5u6gtR5PO+ZqC6Ca0fOQdiZGK6JJYWzyQ/V8AHQ/ugcktFU7FxeryQSYJEg/Dk7NAbyg==
X-Received: by 2002:a05:6871:53ca:b0:1f0:597d:fe30 with SMTP id hz10-20020a05687153ca00b001f0597dfe30mr19754981oac.44.1700163794063;
        Thu, 16 Nov 2023 11:43:14 -0800 (PST)
Received: from localhost (fwdproxy-vll-007.fbsv.net. [2a03:2880:12ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id zb8-20020a05687126c800b001efc94cc21bsm3880oab.58.2023.11.16.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:13 -0800 (PST)
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
Subject: [PATCH v1 bpf-next  2/9] bpftool: add libbpf-rs dependency and minimal bpf program
Date: Thu, 16 Nov 2023 11:42:29 -0800
Message-Id: <20231116194236.1345035-3-chantr4@gmail.com>
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

Setting up the basic requirements to build a bpf program using
libbpf-rs.

    $ cargo test
       Compiling bpftool_tests v0.1.0
    (/data/users/chantra/bpf-next/tools/bpf/bpftool/testing)
        Finished test [unoptimized + debuginfo] target(s) in 0.64s
         Running unittests src/main.rs
    (target/debug/deps/bpftool_tests-b5112057d979eb52)

    running 1 test
    test bpftool_tests::run_bpftool ... ok

    test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
    out; finished in 0.00s

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../selftests/bpf/bpftool_tests/Cargo.toml    |  7 +++++++
 .../selftests/bpf/bpftool_tests/build.rs      | 17 ++++++++++++++++
 .../bpftool_tests/src/bpf/bpftool_tests.bpf.c | 20 +++++++++++++++++++
 .../bpf/bpftool_tests/src/bpf/vmlinux.h       |  1 +
 .../bpf/bpftool_tests/src/bpftool_tests.rs    |  4 ++++
 5 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/build.rs
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
 create mode 120000 tools/testing/selftests/bpf/bpftool_tests/src/bpf/vmlinux.h

diff --git a/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml b/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
index 34df3002003f..35c834082351 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
+++ b/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
@@ -2,3 +2,10 @@
 name = "bpftool_tests"
 version = "0.1.0"
 edition = "2021"
+
+# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
+[dependencies]
+libbpf-rs = "0.21"
+
+[build-dependencies]
+libbpf-cargo = "0.21"
diff --git a/tools/testing/selftests/bpf/bpftool_tests/build.rs b/tools/testing/selftests/bpf/bpftool_tests/build.rs
new file mode 100644
index 000000000000..ce01824fcd1d
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/build.rs
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+use libbpf_cargo::SkeletonBuilder;
+use std::env;
+use std::path::PathBuf;
+
+const SRC: &str = "src/bpf/bpftool_tests.bpf.c";
+
+fn main() {
+    let mut out =
+        PathBuf::from(env::var_os("OUT_DIR").expect("OUT_DIR must be set in build script"));
+    out.push("bpftool_tests.skel.rs");
+    SkeletonBuilder::new()
+        .source(SRC)
+        .build_and_generate(&out)
+        .unwrap();
+    println!("cargo:rerun-if-changed={SRC}");
+}
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
new file mode 100644
index 000000000000..8b92171145de
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+int my_pid = 0;
+
+SEC("tp/syscalls/sys_enter_write")
+int handle_tp(void *ctx)
+{
+	int pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	bpf_printk("BPF triggered from PID %d.\n", pid);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/vmlinux.h b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/vmlinux.h
new file mode 120000
index 000000000000..f9515b260426
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/vmlinux.h
@@ -0,0 +1 @@
+../../../tools/include/vmlinux.h
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
index 251dbf3861fe..35eb35831dce 100644
--- a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
+++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+mod bpftool_tests_skel {
+    include!(concat!(env!("OUT_DIR"), "/bpftool_tests.skel.rs"));
+}
+
 use std::process::Command;
 
 const BPFTOOL_PATH_ENV: &str = "BPFTOOL_PATH";
-- 
2.39.3


