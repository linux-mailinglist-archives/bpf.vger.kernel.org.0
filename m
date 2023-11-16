Return-Path: <bpf+bounces-15217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D207EE7A6
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B815B20A8B
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1F148CF5;
	Thu, 16 Nov 2023 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqTuGCDi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93690
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:33 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6cd09663b1cso721254a34.3
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163812; x=1700768612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kxCYimjhScHhOiqFD0x0jmkbAuTB3yGg/QItDo0Jk4=;
        b=NqTuGCDiZAxdWZIxine5fKV3r/2O7C+PDIyQf7+0Sbaras+vVTfsaOXCGgbQUdLfq+
         RR2/1UXU/ZPa7LIviw3AUPznCZFb18wxTQnSW26315X6V7R3TQH9hppcocUZuGzUDaqW
         CKfZVyAx/Tdmet6ckGUNjKHcBDA9CkPUv17axZIHP9Datgh6+KL7ZGM76WvIP1+HabgL
         ii6dxHEUROsnhMHgaY4DW2Jk7Nu+9VdEe89FqgGhiVhZwFDHe+zidzPZK7tYJOXBiZdC
         /0GxkbWjdKa1bhHN2KuL69eVkbrAPmfLHf3gfcLZ+kxedaO9MMb8PurmNDDyD6EMoq5m
         grQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163812; x=1700768612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kxCYimjhScHhOiqFD0x0jmkbAuTB3yGg/QItDo0Jk4=;
        b=ic9YsPK58riPFroQ0gqBNS+oxzkFBDyjwtBiFpRyQT79unjv0F11Pk2MYxPuFHTo6T
         seZNdTqfqv63bBKdNscXH0Ket8+YElB6JVGhup2aT+2beB5ffq0J1e2vor/44eErFa0j
         fZTnFMZIl8h1UsIZBppQhizjNCIHWDJS7bcmbuxwnFaE+SPpMG3blZUVKgM9IVSjDGJ1
         Nx/3HQ+LD9YFziUeGLNe9ylZAjRPvcUAc0d4Wm1pMSVl1IICgo2Q98UJZLjLoNrtXj9z
         5GKaNPhFL3FiWv1rlrUwCpftaUVqyXUzzsPROGmpIsv7P3gJgDWgPmgBKEXxfxogDiNS
         BfZg==
X-Gm-Message-State: AOJu0YzJC/389M4DWxz70+Kfk6NUORNTOXLUO8IPO6jDRowUjCZop5zT
	CP/vSzEGLBD1dpu6lvd5NB83vnjzbV/3KA==
X-Google-Smtp-Source: AGHT+IE816fwN7drhSdgULnmKZoWcPgdJQfFW8HEOvmoP5M0nG6DZLR1WBMZoo9Qy9ovtImoR8KoVg==
X-Received: by 2002:a9d:4802:0:b0:6bf:1e78:cc52 with SMTP id c2-20020a9d4802000000b006bf1e78cc52mr9342475otf.25.1700163812495;
        Thu, 16 Nov 2023 11:43:32 -0800 (PST)
Received: from localhost (fwdproxy-vll-116.fbsv.net. [2a03:2880:12ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id em9-20020a056830020900b006d691456571sm1365otb.64.2023.11.16.11.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:32 -0800 (PST)
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
Subject: [PATCH v1 bpf-next  9/9] bpftool: Add Makefile to facilitate bpftool_tests usage
Date: Thu, 16 Nov 2023 11:42:36 -0800
Message-Id: <20231116194236.1345035-10-chantr4@gmail.com>
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

Provide some Makefile targets to run the linter, build the tests, and
run them on the host or in a VM.

    $ make vmtest
    cargo test --no-run --offline
        Finished test [unoptimized + debuginfo] target(s) in 0.05s
      Executable unittests src/main.rs
    (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)
    vmtest -k /data/users/chantra/bpf-next/arch/x86/boot/bzImage
    "RUST_TEST_THREADS=1 BPFTOOL_PATH=../tools/build/bpftool/bpftool cargo
    test"
    => bzImage
    ===> Booting
    ===> Setting up VM
    ===> Running command
        Finished test [unoptimized + debuginfo] target(s) in 2.05s
         Running unittests src/main.rs
    (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)

    running 11 tests
    test bpftool_tests::run_bpftool ... ok
    test bpftool_tests::run_bpftool_map_dump_id ... ok
    test bpftool_tests::run_bpftool_map_list ... ok
    test bpftool_tests::run_bpftool_map_pids ... ok
    test bpftool_tests::run_bpftool_prog_list ... ok
    test bpftool_tests::run_bpftool_prog_pids ... ok
    test bpftool_tests::run_bpftool_prog_show_id ... ok
    test bpftool_tests::run_bpftool_struct_ops_can_unregister_id ... ok
    test bpftool_tests::run_bpftool_struct_ops_can_unregister_name ... ok
    test bpftool_tests::run_bpftool_struct_ops_dump_name ... ok
    test bpftool_tests::run_bpftool_struct_ops_list ... ok

    test result: ok. 11 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
    out; finished in 2.88s

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../selftests/bpf/bpftool_tests/Makefile      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/Makefile

diff --git a/tools/testing/selftests/bpf/bpftool_tests/Makefile b/tools/testing/selftests/bpf/bpftool_tests/Makefile
new file mode 100644
index 000000000000..0b5633cda8b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/Makefile
@@ -0,0 +1,22 @@
+BPFTOOL := ../tools/build/bpftool/bpftool
+
+lint:
+	cargo clippy --tests
+	cargo check --tests
+
+# Build the tests but do not run them.
+build-test:
+	cargo test --no-run --offline
+
+# Run the tests on the host using sudo
+test: build-test
+	RUST_TEST_THREADS=1 BPFTOOL_PATH=$(BPFTOOL) sudo -E $(shell which cargo) test --offline
+
+# Run the tests in a vm. Requires danobi/vmtest.
+vmtest: build-test
+	$(eval repo_root := $(shell git rev-parse --show-toplevel))
+	$(eval kernel_img := $(shell make -s -C $(repo_root) image_name))
+	vmtest -k $(repo_root)/$(kernel_img) "RUST_TEST_THREADS=1 BPFTOOL_PATH=$(BPFTOOL) cargo test"
+
+clean:
+	cargo clean
-- 
2.39.3


