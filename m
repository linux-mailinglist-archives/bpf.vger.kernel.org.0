Return-Path: <bpf+bounces-22754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02517868583
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 02:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB382873BF
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585E5258;
	Tue, 27 Feb 2024 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoMOBCci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356EB4C8E
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995886; cv=none; b=kIN4ZYlNdQgWRaYeBwS56Dk1tCnD6nTZ1QuZhn4xV7aE5I4oXGn66Aem+4OdEpi1R3wByLL7jiEVp2kpNmDVaGWE3y405rXH/7U+2LS22kNNSjVycVMlRsd3gOSaoFa1nvPKVJV/6Yg7hD1eYro8jEUUdd8LO6DWOUn7FGHGcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995886; c=relaxed/simple;
	bh=kWvE3w/dssfEwW9VwQvUfG+MhBRRVDMss+Cyg3QxDzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrzVlGh/ERhe1uay8Kq3Qy0gmFK9qTIPOuEdOpvbyhERwLntY1N8eaGRlRKirAO22X7Qb6osmEmAO26zwWyl+yWxmBPJiCJlOd7dINNvNldSHu1IMFlM0pURkZzGztTv/ZK8nN+g6zhvUy7B1OITpzDpW9I+0Rv4Q7hNh92XyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoMOBCci; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60915328139so11725887b3.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 17:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995884; x=1709600684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLz74OM2Mxrx78KFBZW+5OCfQUjWPx+I7SN2WTQ9+1I=;
        b=UoMOBCcief9J0XRJYIbhyfa36mf2lIL/LX/MzfwZW0cMrejiChbT3EFaB9c3gX8iea
         T+XbxSV3xZH/KzoJ3iaIXyZf4khpN2AxqIpJrKy7LQJGtOtBC94ekEqPunnU72a0Zeka
         6LG6KMT/NFRP5Hs9226Lgc44b4GZPxpAPxQi645+4DxPLAK13dRUzgvjTHtaJfiSUvYw
         PR2EbFuSNo72o9McaqsdIxdGPhGprQ5ioAlK9NFak1UbZvBt+LSxr30gn5xkSNyCOi8a
         Q/svpfvxFyJkCpGtW5C1+iVvZeHsyZBHqIbPAL2JS5yV8+7EdZYRlbyj+ELvSOhGE0dG
         URVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995884; x=1709600684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLz74OM2Mxrx78KFBZW+5OCfQUjWPx+I7SN2WTQ9+1I=;
        b=cME647qpRFxDPPEMUhuECzpb8WdWZuzqG25e1GSTeLBbL8QvBuIbbyFlVPn6NxV+j0
         BU5o3VNTrCY1cZbspKST3J+IIFr8sL09ztUay+MBPe0IMEugaAWepWmvPhTuq9dd7vae
         sHfeivA+wKq4F8YJl64eI713jkqstyO+eyLUYIuqTthImRhm8yFhAyVY34iZI1/Q+SCe
         iyFfpZrx5Wsja/0qdIsmGcrb1FhoTsW9lk1L7f6A8RN+ZQTG8TXMNoTwuviTTFRQsWyE
         r/eHfEJdxlTrPTer0nJWOxPtdhAoPhFuSYSAEqm6PWHpJCgPwXO0H8PDkclLeoOxi2vS
         aG4w==
X-Gm-Message-State: AOJu0Yxiwbx/P4+z4nchqUS2Ulu6yxcM67V9WJQ1r/HleaPQCIPw5SmU
	hh+tYbRc33DqTXoMrkkODgb4nSDXegxI9MtaS8fN49YfyPPOM2YxrzQZtVzc
X-Google-Smtp-Source: AGHT+IHaUD7UKSHYpt+Q3CMqd7DKyJWeBMjULO2WL76/DPHfT1xKTDzJs5WnOYk+crr6BCsTJLV3IQ==
X-Received: by 2002:a81:6c03:0:b0:608:856f:25cf with SMTP id h3-20020a816c03000000b00608856f25cfmr790575ywc.46.1708995883837;
        Mon, 26 Feb 2024 17:04:43 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5f7:55e:ea3a:9865])
        by smtp.gmail.com with ESMTPSA id l141-20020a0de293000000b00607f8df2097sm1458818ywe.104.2024.02.26.17.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:04:43 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 5/6] bpftool: Add an example for struct_ops map and shadow type.
Date: Mon, 26 Feb 2024 17:04:31 -0800
Message-Id: <20240227010432.714127-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227010432.714127-1-thinker.li@gmail.com>
References: <20240227010432.714127-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example in bpftool-gen.8 explains how to use the pointer of the shadow
type to change the value of a field of a struct_ops map.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst | 58 +++++++++++++++++--
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 5006e724d1bc..62572f5beed9 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -257,18 +257,48 @@ EXAMPLES
   	return 0;
   }
 
-This is example BPF application with two BPF programs and a mix of BPF maps
-and global variables. Source code is split across two source code files.
+**$ cat example3.bpf.c**
+
+::
+
+  #include <linux/ptrace.h>
+  #include <linux/bpf.h>
+  #include <bpf/bpf_helpers.h>
+  /* This header file is provided by the bpf_testmod module. */
+  #include "bpf_testmod.h"
+
+  int test_2_result = 0;
+
+  /* bpf_Testmod.ko calls this function, passing a "4"
+   * and testmod_map->data.
+   */
+  SEC("struct_ops/test_2")
+  void BPF_PROG(test_2, int a, int b)
+  {
+	test_2_result = a + b;
+  }
+
+  SEC(".struct_ops")
+  struct bpf_testmod_ops testmod_map = {
+	.test_2 = (void *)test_2,
+	.data = 0x1,
+  };
+
+This is example BPF application with three BPF programs and a mix of BPF
+maps and global variables. Source code is split across three source code
+files.
 
 **$ clang --target=bpf -g example1.bpf.c -o example1.bpf.o**
 
 **$ clang --target=bpf -g example2.bpf.c -o example2.bpf.o**
 
-**$ bpftool gen object example.bpf.o example1.bpf.o example2.bpf.o**
+**$ clang --target=bpf -g example3.bpf.c -o example3.bpf.o**
+
+**$ bpftool gen object example.bpf.o example1.bpf.o example2.bpf.o example3.bpf.o**
 
-This set of commands compiles *example1.bpf.c* and *example2.bpf.c*
-individually and then statically links respective object files into the final
-BPF ELF object file *example.bpf.o*.
+This set of commands compiles *example1.bpf.c*, *example2.bpf.c* and
+*example3.bpf.c* individually and then statically links respective object
+files into the final BPF ELF object file *example.bpf.o*.
 
 **$ bpftool gen skeleton example.bpf.o name example | tee example.skel.h**
 
@@ -291,7 +321,15 @@ BPF ELF object file *example.bpf.o*.
   		struct bpf_map *data;
   		struct bpf_map *bss;
   		struct bpf_map *my_map;
+		struct bpf_map *testmod_map;
   	} maps;
+	struct {
+		struct {
+			const struct bpf_program *test_1;
+			const struct bpf_program *test_2;
+			int data;
+		} *testmod_map;
+	} struct_ops;
   	struct {
   		struct bpf_program *handle_sys_enter;
   		struct bpf_program *handle_sys_exit;
@@ -304,6 +342,7 @@ BPF ELF object file *example.bpf.o*.
   		struct {
   			int x;
   		} data;
+		int test_2_result;
   	} *bss;
   	struct example__data {
   		_Bool global_flag;
@@ -342,10 +381,16 @@ BPF ELF object file *example.bpf.o*.
 
   	skel->rodata->param1 = 128;
 
+	/* Change the value through the pointer of shadow type */
+	skel->struct_ops.testmod_map->data = 13;
+
   	err = example__load(skel);
   	if (err)
   		goto cleanup;
 
+	/* The result of the function test_2() */
+	printf("test_2_result: %d\n", skel->bss->test_2_result);
+
   	err = example__attach(skel);
   	if (err)
   		goto cleanup;
@@ -372,6 +417,7 @@ BPF ELF object file *example.bpf.o*.
 
 ::
 
+  test_2_result: 17
   my_map name: my_map
   sys_enter prog FD: 8
   my_static_var: 7
-- 
2.34.1


