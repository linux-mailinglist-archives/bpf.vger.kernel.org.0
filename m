Return-Path: <bpf+bounces-61424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4258AE6F3D
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1971417EE88
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5E2E7F32;
	Tue, 24 Jun 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0efa6Lq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA92E62BC
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792221; cv=none; b=PyfvoeKQXL5SFzFOjKVuE8PAuOGoCIi7e7bjLCaMxRRG4afHgSukB4NhN3ftM2dKuhmS05VTvaaxzhLB3AVysbLsgbeMRP/KLQYf0rrtz1hh3bef5NNdEziOmFnI0d9cjVM+UQGGDU7/1b+lcB2HBeLu0Bejbzfy7M0ogjiuYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792221; c=relaxed/simple;
	bh=VGbIl2p+Ra+JgrX+8abtXIulw6a+vUJWQ4g5jx/xyuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoE08I+xSv+Zy5Jctl/dtcQ5xFITuH58rS74eGFmMuJpyFXxF61HQRCPN6QqSpbHiMpAMxWm/PzIZg5OVAkx3FjPNk8z/EfzQOgjKk5jIay8MF8i1VZggJjylv7syP/M5A7dhpmU8xcuX/E0VBt/hanJlYb4XCHnKGmAmJtgr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0efa6Lq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e767ce72eso51571227b3.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750792218; x=1751397018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4swU1MAhchEhqTc/z22YKoRzPrzrODe8DDIe+2xJTg=;
        b=N0efa6LqOQZ9V8MeqC/6EsmL/ESl8lRDgmeqC2GU6oeo5TOc0stkqrs2QbErpZnnNe
         VjYMnj8K1GgR/az08Nmu3fsxqOoabTlfAXpx4GdtuT6kMVapZP9FTfamQ5TbSIU0hruU
         PblP8ZDIr4oKGo7IxFxKapV8Jd0NxGfx+jtASPRMAhR1erBnOLV39ukwoQgpAH5m78q7
         NJ2j6sA8Af1iX+/CaaT/kB7tgSjCuE8BIeTp2aeq01yJXTzm7gV2y9YqEoXvD/jc+757
         mwkrA6KFASDUwMvdSPlyfByun5qv4vH7TZ1PKgKuFp0PPuiG1/4v641ISUBAoV56yt3a
         E49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792218; x=1751397018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4swU1MAhchEhqTc/z22YKoRzPrzrODe8DDIe+2xJTg=;
        b=OFdbJNvnAFAcNb8WIZ4kWyZTY9gjpeX7vDzgd/L843+F0dIqaU39byGmXGRf03PVbv
         DcJzkzagRLThM6ZmfWdZqlgd7Yro4J+JZt7WtJ5TNShLZuu2/h0U7VMBP8AEOkmpQ586
         Faabt64Efi0SeDPcS8AaYewIhOvsnpKywut8u5k4WhQzAXa45lJt//47d/iEv7HvtLT+
         7vxOK2Heltfnox0glThu0n29zKPf+yd8GxWNs+wbCMiEL0m1DzoLuXhUDgG8H5fUH9h7
         7ovDapfNq7+NnWDJTFvB6+XpNWCeQcGl8V0OXcISvBLoiEnp4wOTFWotFS8clufTkDfE
         livw==
X-Gm-Message-State: AOJu0Yw/As5062jwN1ctR51y6GAvzgtcvLDL1c3WMXAy95u7uQfDRdo6
	QzuNrrugd7BWfouLhZ9iV6zu7pdqRRr6LZxAKdg0UVMKgqlgxMNW0EVSP60koDVQ
X-Gm-Gg: ASbGncveIONDZrhK6so0N3XTp8b3vBMVXZLti2kqR0fzLDWL2h+7E1aJfAsA/aBcZ/r
	INCCiiDNwCnb18d2MJCtahr85+Hb4PxavRN9Hi7nU3QLQf3sMVM1139aK0Kfgm7pxvGLRwY+D+/
	wK7R/LWE4tlYMXjAsQ1MDbnuTaEOw2/tfaY/pwJFtmH/tIRjJ3k767TpwKaF4D7ZGUg0iRBg5rf
	d/3bsCGEjEKipKmjfSMsdv2DmbSmPWMT4VGhbVzf1BSjgYaYC4P9YAHazp/8p3+Xj5xadRdaIIV
	Ra7v/x/FwVNv9qQR6i11f0x/OYpOJR9DIAydQ4h9Lje0ksxfB32LnQ==
X-Google-Smtp-Source: AGHT+IFgYhBnLLYPmqXxJ8B+5mZZjYoA9pNEgzci5axUw2wJ53MHSxVmDGqZ5C1SO8iz5BPS5qC0jQ==
X-Received: by 2002:a05:690c:890:b0:714:268:a9f8 with SMTP id 00721157ae682-71406dd9542mr1262347b3.27.1750792217909;
        Tue, 24 Jun 2025 12:10:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4a1625fsm21978407b3.27.2025.06.24.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:10:17 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 3/4] selftests/bpf: allow tests from verifier.c not to drop CAP_SYS_ADMIN
Date: Tue, 24 Jun 2025 12:10:08 -0700
Message-ID: <20250624191009.902874-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624191009.902874-1-eddyz87@gmail.com>
References: <20250624191009.902874-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally prog_tests/verifier.c was developed to run tests ported
from test_verifier binary. test_verifier runs tests with CAP_SYS_ADMIN
dropped, hence this behaviour was copied in prog_tests/verifier.c.
BPF_OBJ_GET_NEXT_ID BPF syscall command fails w/o CAP_SYS_ADMIN and
this prevents libbpf from loading module BTFs.
This commit adds an optout from capability drop.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/verifier.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c9da06741104..cedb86d8f717 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -115,14 +115,16 @@ struct test_val {
 __maybe_unused
 static void run_tests_aux(const char *skel_name,
 			  skel_elf_bytes_fn elf_bytes_factory,
-			  pre_execution_cb pre_execution_cb)
+			  pre_execution_cb pre_execution_cb,
+			  bool drop_sysadmin)
 {
 	struct test_loader tester = {};
-	__u64 old_caps;
+	__u64 caps_to_drop, old_caps;
 	int err;
 
 	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
-	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
+	caps_to_drop = drop_sysadmin ? 1ULL << CAP_SYS_ADMIN : 0;
+	err = cap_disable_effective(caps_to_drop, &old_caps);
 	if (err) {
 		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
 		return;
@@ -137,7 +139,8 @@ static void run_tests_aux(const char *skel_name,
 		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
 }
 
-#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
+#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, true)
+#define RUN_FULL_CAPS(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, false)
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
@@ -272,7 +275,8 @@ void test_verifier_array_access(void)
 {
 	run_tests_aux("verifier_array_access",
 		      verifier_array_access__elf_bytes,
-		      init_array_access_maps);
+		      init_array_access_maps,
+		      true);
 }
 
 static int init_value_ptr_arith_maps(struct bpf_object *obj)
@@ -284,5 +288,6 @@ void test_verifier_value_ptr_arith(void)
 {
 	run_tests_aux("verifier_value_ptr_arith",
 		      verifier_value_ptr_arith__elf_bytes,
-		      init_value_ptr_arith_maps);
+		      init_value_ptr_arith_maps,
+		      true);
 }
-- 
2.47.1


