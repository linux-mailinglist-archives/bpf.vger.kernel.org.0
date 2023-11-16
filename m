Return-Path: <bpf+bounces-15216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104507EE7A4
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CAF281170
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D348CE9;
	Thu, 16 Nov 2023 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8fkaHwp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DDB1A8
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:31 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b58d96a3bbso707018b6e.1
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163810; x=1700768610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sudKXxJ9RIg5eZUc/cLdi0zWYdDkByV1m7wl+o4clvk=;
        b=W8fkaHwpivqLxvnRrui+ajKlQGmVHuNxw6Ps8DTPVZvwBTshiJdHUxw7C04YgZcn/t
         Dij0HllbXw8PQpyp6Y7YUMbFP5WmtwOBX/zsZT+I2MvY9dzek8juAlmgKSTBEV7I9b3u
         L33I9c/Jcuk3kLBtq2DM4Y7gChnJRQo78yTlVciS2+9Q/Zu3doSOD3z/qo+c52SSbtiH
         Pw+RXlgqmuINoX9S+CLbgG9u9R4rc3hSSoZ0AYV3xs4htjLtPx8YwrvShesEhciYmKKZ
         O9ug2t5Ko/Ssvr6Gu+FvzNss0TdJ5SPGXSHsJ2+eI5CoH31Dfrd2gsQttP782aExse2M
         GO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163810; x=1700768610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sudKXxJ9RIg5eZUc/cLdi0zWYdDkByV1m7wl+o4clvk=;
        b=cMSFEEu2Pn1xxVNosx/1Eyxx25V2/bRzcONvFok9UxGUeBZjWDPlUJKVlx6t1zZ9f9
         54bC26bQhCIUkje945Q+Huh7G9y6JpEC15/F0RIJzhnoMBwPbKyQorNd9pK4UyymYVL9
         Y1S5x4Ck5sRxb9Eeu5H7seGH519kDzDtJePECFtQVrwEujJOnfZoRR9H0L6niCH7f74s
         so9Y7bMPojYMFp3cYnXZ6uzY15oVB7h+3TAf4eRqWx7HszGlzxpqueBi0I/PGlYTg70g
         u9DSmu4Bb7BpicQyUNsLDpxb6QQ5s6H2T84XDLyMXyTS5GnBXWyRhtAkGrLjMKiWR7/q
         TgFg==
X-Gm-Message-State: AOJu0Yx2ej/oh3Wktujks1H1O4SdUFyWBr2ryPQAjU8VfcC3vLQFmg13
	fQ0xfkRUTwy+hdLwYi5hDT8PlOAtWwCFDg==
X-Google-Smtp-Source: AGHT+IECxCm6RFuB9dSEt460/YSwr3+MveZkvEMRziCLrXhzDAhFeFgQGEHZqlrxEUwFebI1cdjYAQ==
X-Received: by 2002:a05:6808:164d:b0:3ad:c476:9ad9 with SMTP id az13-20020a056808164d00b003adc4769ad9mr22001196oib.4.1700163809961;
        Thu, 16 Nov 2023 11:43:29 -0800 (PST)
Received: from localhost (fwdproxy-vll-006.fbsv.net. [2a03:2880:12ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id b23-20020a056808011700b003afdc0f000esm14846oie.9.2023.11.16.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:29 -0800 (PST)
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
Subject: [PATCH v1 bpf-next  8/9] bpftool: Add bpftool_tests README.md
Date: Thu, 16 Nov 2023 11:42:35 -0800
Message-Id: <20231116194236.1345035-9-chantr4@gmail.com>
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

A README.md explaining how to run bpftool tests.

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../selftests/bpf/bpftool_tests/README.md     | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/README.md

diff --git a/tools/testing/selftests/bpf/bpftool_tests/README.md b/tools/testing/selftests/bpf/bpftool_tests/README.md
new file mode 100644
index 000000000000..8ee5d656f6f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/README.md
@@ -0,0 +1,91 @@
+## About the testing Framework
+
+The testing framework uses [RUST's testing framework](https://doc.rust-lang.org/rustc/tests/index.html)
+and [libbpf-rs](https://docs.rs/libbpf-rs/latest/libbpf_rs/).
+
+The former takes care of scheduling tests and reporting their successes/failures.
+The latter is used to load bpf programs, maps, and possibly interact with them
+programatically through libbpf API.
+This allows us to set the environment we want to test and check that `bpftool`
+does what we expect.
+
+This document assumes you have [`cargo` and `rust` installed](https://doc.rust-lang.org/cargo/getting-started/installation.html).
+
+## Testing bpftool
+
+This should be no different than typical [`cargo test`](https://doc.rust-lang.org/cargo/commands/cargo-test.html)
+but there is a few subtleties to consider when running `bpftool` tests:
+
+1. bpftool needs to run with root privileges for the most part. So the runner needs to run as root.
+1. each tests load a program, possibly modify it, and check expectations. In order to be deterministic, tests need to run serially.
+
+### Environment variable
+
+A few environment variable can be used to control the behaviour of the tests:
+- `RUST_TEST_THREADS`: This should be set to 1 to run one test at a time and avoid tests to step onto each others.
+- `BPFTOOL_PATH`: Allow passing an alternate location for `bpftool`. Default: `/usr/sbin/bpftool`
+
+### Running the test suite
+
+Here are a few options to make this happen:
+
+```
+# build the test binary, extract the test executable location
+# and run it with sudo, 1 test at a time.
+eval sudo BPFTOOL_PATH=$(pwd)/../bpftool RUST_TEST_THREADS=1 \
+    $(cargo test --no-run \
+        --message-format=json | jq '. | select(.executable != null ).executable' \
+    )
+```
+
+or alternatively, one can use the [`CARGO_TARGET_<triple>_RUNNER` environment variable](https://doc.rust-lang.org/cargo/reference/environment-variables.html#:~:text=CARGO_TARGET_%3Ctriple%3E_RUNNER).
+
+The benefit of that approach is that compilation errors will show directly in the terminal.
+
+```
+CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER="sudo -E" \
+    BPFTOOL_PATH=$(pwd)/../bpftool \
+    RUST_TEST_THREADS=1 \
+    cargo test
+```
+
+### Running tests against built kernel/bpftool
+
+Using [vmtest](https://github.com/danobi/vmtest):
+
+```
+$ KERNEL_REPO=~/devel/bpf-next/
+$ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "BPFTOOL_PATH=$KERNEL_REPO/tools/bpf/bpftool/bpftool RUST_TEST_THREADS=1 cargo test"
+=> bzImage
+===> Booting
+===> Setting up VM
+===> Running command
+    Finished test [unoptimized + debuginfo] target(s) in 2.06s
+     Running unittests src/main.rs (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)
+
+running 11 tests
+test bpftool_tests::run_bpftool ... ok
+test bpftool_tests::run_bpftool_map_dump_id ... ok
+test bpftool_tests::run_bpftool_map_list ... ok
+test bpftool_tests::run_bpftool_map_pids ... ok
+test bpftool_tests::run_bpftool_prog_list ... ok
+test bpftool_tests::run_bpftool_prog_pids ... ok
+test bpftool_tests::run_bpftool_prog_show_id ... ok
+test bpftool_tests::run_bpftool_struct_ops_can_unregister_id ... ok
+test bpftool_tests::run_bpftool_struct_ops_can_unregister_name ... ok
+test bpftool_tests::run_bpftool_struct_ops_dump_name ... ok
+test bpftool_tests::run_bpftool_struct_ops_list ... ok
+
+test result: ok. 11 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 1.88s
+```
+
+the return code will be 0 on success, non-zero otherwise.
+
+
+## Caveat
+
+Currently, libbpf-sys crate either uses a vendored libbpf, or the system one.
+This could possibly limit tests against features that are being introduced.
+
+That being said, this is not a blocker now, and can be fixed upstream.
+https://github.com/libbpf/libbpf-sys/issues/70 tracks this on libbpf-sys side.
-- 
2.39.3


