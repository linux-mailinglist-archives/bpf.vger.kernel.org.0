Return-Path: <bpf+bounces-41972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1666799DECE
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98F02837CD
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 06:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE818B468;
	Tue, 15 Oct 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TULafigA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A364D8DA
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975313; cv=none; b=TbhW3asen1eSOT48gk8FzCLFil0Qc6P2GPDJUcJjT+PQ3+iWIrkiiTuJpo/yQn+V0ET697MG16LFtaBh26amzX2BoN2xh4mSmwSR9QUGxEYjs/AmjnPmWOI8wn76VVxQBYxY4xTvJgUTaR7jDhfviuNf47bpUyBnEVJzo6ifeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975313; c=relaxed/simple;
	bh=7q7eNhYq0nSPIYCuo2p0TJmlz2iqDNoPpwPFsrblBzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry+ZXvX5R/jO+szZobHYd/gWqYm3ApjZc4fSu066iVGb3zGLgWjV8LXhPTKnwQ8nnhYHvHl4dt93VRoGL1qWiM9OuO5HqB2M8HSyRmx5yRf+bFq47bD4TC+kM7Yf1JojG+/6ksXAL9b52WtUYEHWeLoSBJS0tof2hI2adr/Zbs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TULafigA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728975311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yxq/V/sDAxI1qUwT5vlBZFr/9AEbrny+p5ruhBtCUQ=;
	b=TULafigAf2hciVEOvm5sXuvFSHBnuC9gHLuqj7P27Ea1UwPXlG/Z+pSz8wf0YXK/4Uzibl
	c4TtfyKDO3QaUr9W/n/aqZycRipgpSV9UBbA9VpVOn1arXnZnuR/m1Tb5GeJ5zdt3CqVEb
	knV56FmAi9LqY9xW22//eg39iDZ3HF0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-IW9vLsdzNomqLZ-7bcCv4w-1; Tue,
 15 Oct 2024 02:55:09 -0400
X-MC-Unique: IW9vLsdzNomqLZ-7bcCv4w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7DB219560A1;
	Tue, 15 Oct 2024 06:55:06 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94A761956056;
	Tue, 15 Oct 2024 06:55:02 +0000 (UTC)
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Allow ignoring some flags for Clang builds
Date: Tue, 15 Oct 2024 08:54:42 +0200
Message-ID: <08becac5b0b536d918adeb90efd63bdd7dcc856c.1728975031.git.vmalik@redhat.com>
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

There exist compiler flags supported by GCC but not supported by Clang
(e.g. -specs=...). Currently, these cannot be passed to BPF selftests
builds, even when building with GCC, as some binaries (urandom_read and
liburandom_read.so) are always built with Clang and the unsupported
flags make the compilation fail (as -Werror is turned on).

Add new Makefile variable CLANG_FILTEROUT_FLAGS which can be used by
users to specify which flags (from the user-provided CFLAGS or LDFLAGS)
should be filtered out for Clang invocations.

This allows to do things like:

    $ CFLAGS="-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1" \
      CLANG_FILTEROUT_FLAGS="-specs=%" \
      make -C tools/testing/selftests/bpf

Without this patch, the compilation would fail with:

    [...]
    clang: error: argument unused during compilation: '-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1' [-Werror,-Wunused-command-line-argument]
    make: *** [Makefile:273: /bpf-next/tools/testing/selftests/bpf/liburandom_read.so] Error 1
    [...]

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d81583b2aef9..89662fe0470a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -31,6 +31,11 @@ SAN_LDFLAGS	?= $(SAN_CFLAGS)
 RELEASE		?=
 OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
 
+# Some flags supported by GCC are not supported by Clang.
+# This variable allows users to specify such flags so that they can use custom
+# CFLAGS and binaries built with Clang do not fail to build.
+CLANG_FILTEROUT_FLAGS ?=
+
 LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
@@ -271,7 +276,7 @@ endif
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
 	$(call msg,LIB,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
-		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
+		     $(filter-out -static $(CLANG_FILTEROUT_FLAGS),$(CFLAGS) $(LDFLAGS)) \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,--version-script=liburandom_read.map \
@@ -280,7 +285,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
-		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
+		     $(filter-out -static $(CLANG_FILTEROUT_FLAGS),$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,-rpath=. -o $@
-- 
2.47.0


