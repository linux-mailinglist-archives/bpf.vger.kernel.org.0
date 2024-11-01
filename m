Return-Path: <bpf+bounces-43711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA39B8D1B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF177B23A7A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04B156C69;
	Fri,  1 Nov 2024 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiogFHe8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F931156C52
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449673; cv=none; b=W6EYlQTpzDOt9IwE3yiXw+RrtWCurNELBoav7I/OepJtc+XlEkjinsvIKCzId+xzaEU6jXwBLbCBZj6Hu5k+5pSq6CMvH5ESXlhULFI+VRdBgsnsBkQrj2QD/xrcxXOVosBPrnWXSndst12Itg57KwEjPRT5lLvYDOnZrh1Rf8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449673; c=relaxed/simple;
	bh=2azOUKkW1qpsPh7P5XLSRVMwHTp2sN0E93+B7yRTU0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjB7I929tP8XMek+s6d5gJPrk/8alIAdlwefQubuYQyoQUEZD6TkLRGsrYRWIf8sbgktcnYJ5RGVqzm3aHVj4UWeKTkHzVckdkG0DYOuV4BANQvFv2kKSxqGhvmfijMh6hQy69meZy52Om7sjeHXK+rKFQx3rz9Qyz9xn3H37Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiogFHe8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730449667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxjwiNNKdy4coJdgtkDIceMU9DTST9THVGr11+oAkrM=;
	b=eiogFHe869VHkFpRRbHYAIah8sZFxDDv/Tqc0yqSjGbC1eLdGxaBKeJPIACpDP57foN4Z6
	TPj3uQsdeGDkLxoLQ2e4Z4zhsNu0khsZiLhP/1KPDUUfxkXD0QEhWfqpqnZFh26jyWFDpZ
	aAKJynrLJVBIPJwXubWTqjogCM+KAB4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-cn6jvzZgOL-HTBIY30ruXw-1; Fri,
 01 Nov 2024 04:27:44 -0400
X-MC-Unique: cn6jvzZgOL-HTBIY30ruXw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E2C1195608C;
	Fri,  1 Nov 2024 08:27:42 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EB161956052;
	Fri,  1 Nov 2024 08:27:36 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Disable warnings on unused flags for Clang builds
Date: Fri,  1 Nov 2024 09:27:13 +0100
Message-ID: <2d349e9d5eb0a79dd9ff94b496769d64e6ff7654.1730449390.git.vmalik@redhat.com>
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

There exist compiler flags supported by GCC but not supported by Clang
(e.g. -specs=...). Currently, these cannot be passed to BPF selftests
builds, even when building with GCC, as some binaries (urandom_read and
liburandom_read.so) are always built with Clang and the unsupported
flags make the compilation fail (as -Werror is turned on).

Add -Wno-unused-command-line-argument to these rules to suppress such
errors.

This allows to do things like:

    $ CFLAGS="-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1" \
      make -C tools/testing/selftests/bpf

Without this patch, the compilation would fail with:

    [...]
    clang: error: argument unused during compilation: '-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1' [-Werror,-Wunused-command-line-argument]
    make: *** [Makefile:273: /bpf-next/tools/testing/selftests/bpf/liburandom_read.so] Error 1
    [...]

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b43d7db8d2c..edef5df08cb2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -274,6 +274,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
 		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
+		     -Wno-unused-command-line-argument \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,--version-script=liburandom_read.map \
 		     -fPIC -shared -o $@
@@ -282,6 +283,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 	$(call msg,BINARY,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
 		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
+		     -Wno-unused-command-line-argument \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,-rpath=. -o $@
-- 
2.47.0


