Return-Path: <bpf+bounces-43710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86419B8D1A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 09:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542CF1F23894
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6DB1684A0;
	Fri,  1 Nov 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoRq5p6B"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D1165F1F
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449663; cv=none; b=Ou1VNRE2BiGELXGLOvoOzP+DwXNAQRlmnjc/HsDC7VVZTbkOpmxqodc2ijJW+thp2S5JlhKa+Z4Y+8FQZs5sdPTjv72I63O16XmtxLyEX4lU41uidzMUP7n2QgjQiIoHDxFY0IVtesAhrHT8lvX+l45RbCnXvagCOe09WWS0yTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449663; c=relaxed/simple;
	bh=8wURDG6IGpefe/5XTIW4c7yRD0izuxlWGmJeMlZ+yjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBWXgFVdYzhz5900zFDgz4iH69MePI1IDS3KLBbukSke8q71jvXep5UZDiP/xybQfYGuh7YWcqlkmTrbk/WrifjGlGkmgebGTwxw1hW3SDbipLrYzcJHewrLyg0gnVUWgylqRCiKY3bceRnsSFfXtsgzkLhZ7ecHt1Lf/eTeV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoRq5p6B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730449660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLoTFCjDrmTaXGp+2vVrFPa0rTPAjDXnBPNITOaBT60=;
	b=XoRq5p6BlWLdei9aAKbqOLocj1e9OARAgoCloI5wdyuTralJ2P6XyS4uQ/21zOT6dolvjL
	SPKeSiu0dDFZddQdZXZqlXKzTWEhxOdpSFEuNXl6B1ydnOyVGXjWnZrK2BOclh9Ggf0eWc
	UD8lj4GGrxjh8u2PZFWLRqS/IUUtIVg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-vs86iW14N-a_uBwPC68pGg-1; Fri,
 01 Nov 2024 04:27:38 -0400
X-MC-Unique: vs86iW14N-a_uBwPC68pGg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1228519560A5;
	Fri,  1 Nov 2024 08:27:36 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 969D01956052;
	Fri,  1 Nov 2024 08:27:30 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v3 2/3] bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
Date: Fri,  1 Nov 2024 09:27:12 +0100
Message-ID: <acec3108b62d4df1436cda777e58e93e033ac7a7.1730449390.git.vmalik@redhat.com>
In-Reply-To: <cover.1730449390.git.vmalik@redhat.com>
References: <cover.1730449390.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When building selftests with CFLAGS set via env variable, the value of
CFLAGS is propagated into bpftool Makefile (called from selftests
Makefile). This makes the compilation fail as _GNU_SOURCE is defined two
times - once from selftests Makefile (by including lib.mk) and once from
bpftool Makefile (by calling `llvm-config --cflags`):

    $ CFLAGS="" make -C tools/testing/selftests/bpf
    [...]
    CC      /bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
    <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
    <command-line>: note: this is the location of the previous definition
    cc1: all warnings being treated as errors
    [...]

Filter out -D_GNU_SOURCE from the result of `llvm-config --cflags` in
bpftool Makefile to prevent this error.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Acked-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index ba927379eb20..a4263dfb5e03 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -147,7 +147,11 @@ ifeq ($(feature-llvm),1)
   # If LLVM is available, use it for JIT disassembly
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
-  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
+  # llvm-config always adds -D_GNU_SOURCE, however, it may already be in CFLAGS
+  # (e.g. when bpftool build is called from selftests build as selftests
+  # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
+  # compilation error due to redefinition. Let's filter it out here.
+  CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
   LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
-- 
2.47.0


