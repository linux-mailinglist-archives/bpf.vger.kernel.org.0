Return-Path: <bpf+bounces-41973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4693799DECF
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C818283E50
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A3418B488;
	Tue, 15 Oct 2024 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2McxCIK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D618B477
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975317; cv=none; b=fraViFG342x0MQ0yOREn5EPVnbsVdVxd4EGSptHyySaxeE9j3IeBZZwbRmT2sMdGHkz7pjIYJ3gtHaGMUCaqeRLck0MG4kUc2ceuIdev5Ad7q1TbRqXJ/Oa63hFBSEC7NX5391d+x9sb8NaIFGpugynHp7G12XhX5p28/q5ms0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975317; c=relaxed/simple;
	bh=iRNCHG+nM0zWHSBJmF/VRZb62djRDYbMMhyDjcYCDV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qilgZ1BV0eFI+St8LaFNRwDnp96rnkNo8gJhQqzi825ZBNrV708YuPz6pKKGDzbVHB5MKFhm5i0JxFOi8iC199pr64qP9cUTMKxT878ELdj3b2d222wnv7/45TjkorjG6iTWcjd+L2Ty/rxPnDYTQKjtnAPWORqrwBpl8HNkHbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2McxCIK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728975313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiX5TxHge8wYnZ04p0ykii5Ay1RFTMDGgmp1ST+PfKs=;
	b=T2McxCIKNXWs01SNpK0kiIOsnGwFmCtkaU8zGMPYNMwumeL6Aso8FqQ0b+QqBOcqtGxsR3
	QbNrh6lS1Ad0jWWy/q9XETM9S3o4UCUiREPUaNe/eu+wD1jXLheNKygbdrdnEyy2qJuq3O
	1IxS/pWsa+QhrkLVv/Ahhri/UXrKHOE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-Vpi0lhgAMVejkzDJ29VY5Q-1; Tue,
 15 Oct 2024 02:55:04 -0400
X-MC-Unique: Vpi0lhgAMVejkzDJ29VY5Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 309D719560A2;
	Tue, 15 Oct 2024 06:55:02 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F8D71956056;
	Tue, 15 Oct 2024 06:54:57 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 2/3] bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
Date: Tue, 15 Oct 2024 08:54:41 +0200
Message-ID: <507d699068777b78a5720e617c99fb19a9bb8a89.1728975031.git.vmalik@redhat.com>
In-Reply-To: <cover.1728975031.git.vmalik@redhat.com>
References: <cover.1728975031.git.vmalik@redhat.com>
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

Let bpftool Makefile check if _GNU_SOURCE is already defined and if so,
do not let llvm-config add it again.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/bpf/bpftool/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index ba927379eb20..2b5a713d71d8 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -147,7 +147,13 @@ ifeq ($(feature-llvm),1)
   # If LLVM is available, use it for JIT disassembly
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
-  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
+  # When bpftool build is called from another Makefile which already sets
+  # -D_GNU_SOURCE, do not let llvm-config add it again as it will cause conflict.
+  ifneq ($(filter -D_GNU_SOURCE=,$(CFLAGS)),)
+    CFLAGS += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
+  else
+    CFLAGS += $(shell $(LLVM_CONFIG) --cflags)
+  endif
   LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
-- 
2.47.0


