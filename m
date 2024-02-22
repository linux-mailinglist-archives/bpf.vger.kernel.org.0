Return-Path: <bpf+bounces-22535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AE8605AB
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 23:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F22840BB
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D012D21B;
	Thu, 22 Feb 2024 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj+nZwzY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB913792A
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640796; cv=none; b=SL2Btlva86KHruBI+xSaPm4c9WPjhmr0nbDJHWZhQgbdyJQMB3xuezRavXTLFQYX9emLzDRgnOphUxoWP8UFBNUBKWy5kZeT6qQKsA89y5b5AC195W/uCjB/QxDHjq+mOh1DQcXpsMp9VX4bBr4CGtP/8KxB4VMZrBSsUeNGlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640796; c=relaxed/simple;
	bh=xHL0akAEglGOwsUZTmTuC24f6eHkZmXrL9gCcjz+37Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKsyKRpG2Hz1muByVu7pMgrbHW/RTAXswCl2LHHXtuqOj5vxgs/hSJwDj1bhkQCbc9KpY3OHG43++zzNIHS24+uHN+ZmmBnTRRsExmWxndQRVXlTICJvIR4lXeXVRBlS0VR0CDRX2DJlqElTzdeI4P45llOySez3JNRcDUZCE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj+nZwzY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6083cabc2f9so2766107b3.1
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 14:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708640793; x=1709245593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXLAX7ArfBFQiuOv1Px8GCmtaMpXT3tYhEK+eN8KW9Q=;
        b=Uj+nZwzYZXAmHFKkDOb4isRJz+FaP4H+LwKoVT70IkT2vJkOibwZKsO7zCcmYPFn7I
         lgjPJcC2teaxAqjMigTyTglWRiW1BU+otTlSBXLONkNSjnIk2uR170cVM8066WrloEYt
         pTTpfRA++fsO9L77xqjaPchwOZyK39AsEpQ099eT7vBo+1aYaP08R6RWLybFqBVdIGrQ
         jS+5lRsI694j+pzRX4Dp3+yCs2FGs3itJpaAKY9DaYfb4vkznG+3bMO6RVnXulNp4rF7
         Q++HX5ESFzq7liL01iD4tgaF22fWmGA9z+BpUjnl45MGMMPf4si5rMIF8qGZ4gDl9d2T
         KP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640793; x=1709245593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXLAX7ArfBFQiuOv1Px8GCmtaMpXT3tYhEK+eN8KW9Q=;
        b=uYCH9ffdx2Dcf5fmbktWiwJc85Uw2W0hXkNJkl17hPW6e1IhL3SHERB3govkSfLjTr
         cu8uvlG0c7ri9dWUiWAjYaebQUV0qUkqVJ74KF5oUfb/UObxT1ro8TW2d8Xc9z/ARk8t
         FzGLzqzoK6CAP8zUYJ4XeaTnYD9DUqgY0MO7dTt+2zvwnQDpS88qUH2/a7d7Cll550R9
         6rMXrR8Cxds3SvlMHmjO7nQ7g2Wif9fV3gZFw5m/0MlY7Cj+4WB2pqT6KOTBbe7osTxg
         nZ/qopi1VfGoAli5C1H+elHN4F1jDr18c/j1U3IYD0ldJCIagvHWQG2kMVINmM/MWqPF
         uaqA==
X-Gm-Message-State: AOJu0YyVdsUdPuCqS4fiYIZ3nRZz9UtdA0tY9xrVdK2I5nwcjfGCLHq7
	1VYYHnfWvioKdUPeY+rgQ2husmYETkKWveXybDFCTm3k/TTlDZzJTSqgHEmg
X-Google-Smtp-Source: AGHT+IGEW5DbpSO5evf4OlY+ObZqc/2Ezh5WKHYSL7iQIBFfEbH93rppifTdPc7T5b5gK2zD8DKPVw==
X-Received: by 2002:a0d:e808:0:b0:607:d9f7:e884 with SMTP id r8-20020a0de808000000b00607d9f7e884mr482817ywe.4.1708640793287;
        Thu, 22 Feb 2024 14:26:33 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm3280666ywf.140.2024.02.22.14.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:26:33 -0800 (PST)
From: thinker.li@gmail.com
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
Subject: [PATCH bpf-next v4 5/6] bpftool: Add an example for struct_ops map and shadow type.
Date: Thu, 22 Feb 2024 14:26:23 -0800
Message-Id: <20240222222624.1163754-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222222624.1163754-1-thinker.li@gmail.com>
References: <20240222222624.1163754-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

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


