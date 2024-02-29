Return-Path: <bpf+bounces-22999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000486C13D
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 07:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945F91C20BB2
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 06:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF801482C8;
	Thu, 29 Feb 2024 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIeZHYeE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0408481A0
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189134; cv=none; b=K+anqtb3FVBE/Vrkw5cj6vY4CJ6l1zRPG890/NLrjxet1r8NmEoJ/zEkhuzS7CK3n8D6co0+b9rUkiMaT7jdSTOcV0z5MV0WDoCx0a/uXJSzrmF5trtKOcyEXKhs3KiGHj5WaaGBDWKMlrtDWkNgO8Yr1qFxS9KtMEnwvqjqYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189134; c=relaxed/simple;
	bh=cmRQcz/NrVVLiapjTGgEKF340eeUFufHN1Irw+TvAfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxRSN7pksuIEAzNZ38CW8wpOCjerkOQ+NTJrBpJXP6sfWn8iMB0XN5NcLSf3dmX9s9e3Wjf4jEzTZxIUVOlg4qKNdpyUqopSjm+E0L9+S8d8pg7LUAvSpfqNxEOzHxBkhAHK0SfE+aWNVtEUOU5LSxjSA9rWRgK56vWU2kAPcMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIeZHYeE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-608ccac1899so5796797b3.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 22:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709189131; x=1709793931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53uBi+79WZX4490gC7mkCpwPxzEhwaxmyoZGGLwLwZg=;
        b=DIeZHYeEVHKWamXjGY8Pc9Pcalk35lH8PRm6rGlC2DR1f6fHEbML1apT7GrWQsnGik
         xpfLetmmfvxswE9YrkbzfYJtKxda4jpqYHkqkMy8tLgZkPptVnJMv+TuSbnjKMKHs6fZ
         iLUCZOHVbhc/1LSdCjiBU6Soq6pUh/A8z/y3GdYSmu1HMGoLJekQhL/94TD4V5sENBp5
         Ky8EKgiU6TUEGUXV+N0Noh+vrREqwjpKtYWljpImPRB/slCFy8IenRrEQuTuyX5n2lN9
         5G+RSp2pdx+p9gI7lTFQ5qmTnPG1rnqy77g/OMLLvWh3NwYvNfWcMGQptia7b+Hpggjm
         TI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709189131; x=1709793931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53uBi+79WZX4490gC7mkCpwPxzEhwaxmyoZGGLwLwZg=;
        b=PyVqfj8+lTM3yFnAq+57pSWFaA3mc/9q3DIk7H9MncfT02300EFjNPNM/3mI6NnBL8
         z27NeBsgUnWEFJhG9sQFbIc667ZopMCfeXM9sGXGlIivRFssA36Ol8ZqxSGWA9X90aUD
         swhpV15zzSwkvhjP7kY9jSuSwxrFzmd35WwONAn+1+HdsdbS8tIPSARr8scIIXJtImC0
         O4mvKEnRPq+2+e5kyyw7g3gm7QNbcNJSs0C5vvOfy5oHz9PO5jcMSt6U9pBLS6Swx6LL
         3Tf0hcQ881gGxuuRoV5x8o0usMjlGSBEZVoBvp2lgMc8wXEQUcZ8/lSrRlEkAPycq6br
         XQ8w==
X-Gm-Message-State: AOJu0YzJBS0jqJ+lkQjgzs4SDBI+V7UX80lNqdNySw/87VJoj7rFpO3w
	pKHo1fHNY38wsUV6Fo8ySLW7N+X5rHP+IsKhNlVNBcglOI54KekhmDhj+Cit
X-Google-Smtp-Source: AGHT+IFK89hDyUBYwCOFTpupOlVFZ/X3MioVE7sSV86pLZBRP03AbuBnZEoeZ+0oF0WrG0Ik7VCNyQ==
X-Received: by 2002:a0d:e9c1:0:b0:609:7576:586b with SMTP id s184-20020a0de9c1000000b006097576586bmr138988ywe.37.1709189131503;
        Wed, 28 Feb 2024 22:45:31 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc86:35de:12f4:eec9])
        by smtp.gmail.com with ESMTPSA id p14-20020a817e4e000000b006048e2331fcsm208581ywn.91.2024.02.28.22.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 22:45:31 -0800 (PST)
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
Subject: [PATCH bpf-next v6 4/5] bpftool: Add an example for struct_ops map and shadow type.
Date: Wed, 28 Feb 2024 22:45:22 -0800
Message-Id: <20240229064523.2091270-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229064523.2091270-1-thinker.li@gmail.com>
References: <20240229064523.2091270-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example in bpftool-gen.8 explains how to use the pointer of the shadow
type to change the value of a field of a struct_ops map.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
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


