Return-Path: <bpf+bounces-29233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3778C15E0
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AE71F23BE9
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7718563C;
	Thu,  9 May 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbxhrzLJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07484D15
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284851; cv=none; b=RZN8lh5ZiBfGbGKdemFkUYwMZ0hON0YNMRap8fDKkMVB2i4VjGqsFZ6KNpimVMCL69VDEdCp2dWkI0H12BhluhZwkQXB2ETuwCNjicjAHoF/uA6udOjOgay4aFgeEyQBvjLBndphjJnpaoEcX+girxzP7q7ZmPTruA2KdYe8wHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284851; c=relaxed/simple;
	bh=olG+XfDL3xDdohtjq5mUHNgjYfinvarWZWSY+TyFh0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wc3wRkLYW6J4oQW8aEzbE6g5GpJOqPJp4w4rKmI2hi4PSJqJZMlKmF5q1ojPPJdi6hOemLrrRkgyHb+95U+OrlLgOiXJxMl31t/zCxDyUhbXlqblKR5nkcnIVVnP7NdQdtodCgkUEwmbTbg0U/AgWaA2mFhFH3dDVPEMWp4iFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbxhrzLJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6204c4f4240so18616727b3.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284849; x=1715889649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CLdotFEq8j908dUbT6RbcvFD+YTCI0iXOlq7nFkwSk=;
        b=YbxhrzLJHfALsYA/PUh3m3WC4pHJpa3lO7g+ECbMiaUbh/ATox7Wt71ok3O00i9peh
         sIJDw27zFF36Waua/LrOBQtMWzpBxcu5PDn5wnk4RGSlAc+IpSqvmIZ6PPLHTONDuMu4
         bCFKATO65omrW3g9qKAAhwtosIW6+IlalFJiw5YfP+yH7fINC6/sXa7358MgqbGaw8XG
         PQqbNKxjfuu+SF62l7ABcnpm/5IHBZhJAfsc8vuWH0b00Znf/908z4QLf3SUdtDn0dqg
         5AOdTORHvH0K3RrY/2NaJSHidUh89a/tNXPo5sAKJK3VRncTfKq3FGwjH4NOq6A93aCC
         UE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284849; x=1715889649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CLdotFEq8j908dUbT6RbcvFD+YTCI0iXOlq7nFkwSk=;
        b=XTQoy/MbAXC7h3UwKuRj/ei41XOFXBsZFcovMMEb+r6mHekzh7t0gZj8ntj39qNP1Z
         2gkuYDrKpYNn4RHfJW+BlvD/yiIAqkDbdEgCw+AsKPSW5VTyoJ9yHPF1L8IJNtADo9u7
         91MERZSsYLtFeNbSVjKJ+xkU526emE+6PtMd0NmQJfIFjbQcKiPw3VQDVFkGaLVq+G9d
         Choguv0nb2J2PKeysapoZLheMUi8YRAAA/vRZM2Srb2AQnvM6zwlrKwI5N3nWBUKMgq5
         8AmuImQtK4YsrVyRqQg9wETNWF2cfRbw/shQA/0wzjSMq7OnyIZoKmK3MtJj03BnyA0P
         k7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVexTX81pD2bgvmf3OqEIvVomMEUOxRy70jCjuSA/gspNFccsMENZfyHSoQmPftUQiVYWS5YwaYMrv9Ystgegerw6GL
X-Gm-Message-State: AOJu0YzZAnxMoaChoWP3v7LCkY7PAzIej3vhJxUa509rxdGd401v1VL1
	sL2scIHqn46pApyHWFPBkc8ErbzMvxVO3x0gf4Zy4u9VEDNZ/u6FDhfp00Ow78FgnqBLFfk/yZc
	2/g==
X-Google-Smtp-Source: AGHT+IGZb1++ccVRLEMIHpSPN2qAQJXid7wFD4piJoYbkIu2XX8BrfoTxjJ3q5NtoiGCFIfHJDyo+fBfXww=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:705:b0:de4:5ce5:2656 with SMTP id
 3f1490d57ef6-dee4f301355mr46992276.8.1715284848710; Thu, 09 May 2024 13:00:48
 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:55 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-4-edliaw@google.com>
Subject: [PATCH v3 03/68] selftests: Compile with -D_GNU_SOURCE when including lib.mk
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
unnecessary to add #define _GNU_SOURCE in the source code.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/Makefile | 4 ++--
 tools/testing/selftests/lib.mk   | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f0431e6cb67e..9039f3709aff 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -170,11 +170,11 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 3023e0e2f58f..e782f4c96aee 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -67,7 +67,7 @@ MAKEFLAGS += --no-print-directory
 endif
 
 ifeq ($(KHDR_INCLUDES),)
-KHDR_INCLUDES := -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
+KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
 endif
 
 # In order to use newer items that haven't yet been added to the user's system
@@ -188,6 +188,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.45.0.118.g7fe29c98d7-goog


