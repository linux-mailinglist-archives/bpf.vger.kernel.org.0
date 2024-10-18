Return-Path: <bpf+bounces-42370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD89A3617
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 08:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1311C22CB3
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 06:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEED18BBAE;
	Fri, 18 Oct 2024 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw38EFa3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984418B482
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234174; cv=none; b=Di8EiM+UhFScIjzcqwC2CJAH3oDnFq53qyC8h15adp6O6++nq6ofjRtik9eTncQoycfFB9BcnMX0uIo2vCFdzp7ZCcvqxZRbDf53Jw9YyVqBg8fGoOtnqNe0DYhuuU9DHX8ZhRAF+rrBAMHcDO3XF+vOIUEIry/TovtZGLRLlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234174; c=relaxed/simple;
	bh=Ock5Glzg6zoE58YWkCbPBbP0QkoyZgBAPNa45WkTjbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvTSDV4eL2Zk32hjphYra3y98fdjoHM6S7m1G6PcrdZ7om2LxKQWoCTWNc1vVGpQKLwBzNlQIRk7Ax0CVyLB8MUC7n8MbPHHxn42aJiq2V/RJjPl6RZShyLDc4GpLcMq/hgCr7nHl9GSDpJC/oiwSSA5B13HYYZkpY6Vx9UJsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw38EFa3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729234172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tayFtF0AfxCqFqoTKPczR3luDHUBefcdnlT0+nLuGyA=;
	b=Bw38EFa31Uccm74BhuDZoujlS4sIF2YIfQ8+ohHwvD9+gbvNYfDWE6Jfb0AqRYrViF36pK
	/xr9fgTxbAid6wxEpJkW1zSkldZj+Xy0p5krN9BYrOaLNZIIgjnInJDwmiK7nw79wfFd8B
	VVI1qV+I1J/zHQeuhBfMQpBuQV97HiI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-8tudAKsRO2CjkR4zTzFzTA-1; Fri,
 18 Oct 2024 02:49:28 -0400
X-MC-Unique: 8tudAKsRO2CjkR4zTzFzTA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 795ED1955D42;
	Fri, 18 Oct 2024 06:49:26 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.232])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38BF719560A3;
	Fri, 18 Oct 2024 06:49:19 +0000 (UTC)
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
Subject: [PATCH bpf-next v2 2/3] bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
Date: Fri, 18 Oct 2024 08:49:00 +0200
Message-ID: <820bd20ea460548828ae9a50f5bdbad0700591e5.1729233447.git.vmalik@redhat.com>
In-Reply-To: <cover.1729233447.git.vmalik@redhat.com>
References: <cover.1729233447.git.vmalik@redhat.com>
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


