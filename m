Return-Path: <bpf+bounces-42371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3529A361C
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 08:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7992851DC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 06:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E36418CC0D;
	Fri, 18 Oct 2024 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKJydtIw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484718CBF9
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234185; cv=none; b=NZvudUqPryvyeM+X4zX8xaypbJ8Ee4v++4n7Wx06NsJ8f9V4DfTe7sub08W3oAZmJRk84qWUKVPBUVbphjiR8WqeNiq+oHWXT0e0ALBLATPvVG7916AOd5Xxd8GBNYaYpCA6gWf4cJoqvc/8fYRff8UiXqApRKaKPSMmjeVH3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234185; c=relaxed/simple;
	bh=s6Nnyvpb0DbTv0SZIYTdRqunvQ5rPe9g6uXAZ6zOWAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7S2vRWG1QIXj0C1w1+e0MSca8pTLNredrdHJl+mOuUQRvMZI5qmLDrAdIYHST28PsAnU2DZNxkoBk1azbrJJySmUBED3o2tGum5DK+MR1N9x+p5QDfKrUpxkbeMhr5obPDRrtzJ2IVez2LtTa6xdB85XU6WB81sdS+k4OnxCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKJydtIw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729234182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnIFObe/0lSyr94O7X0ThKJj2A52k6v0sthYbBfvdcc=;
	b=MKJydtIw/q0+hlUJzFKVoeOrIaUyLVwHE4qh70OSMbTuTlEq2Bd5tw+hfi5xnjH4/x1vk1
	oncmnULeF8jMU+NiZF5gBFv2KUe+xAtBYUJzwxa6/JAh3ZvrFqTPlXAlxhx2sWR57nMUPl
	dxAuRL6w8iiIa3WdnDXhKv5nfFuGN7Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-P28HxvajOQa8DqPjkfHtWg-1; Fri,
 18 Oct 2024 02:49:35 -0400
X-MC-Unique: P28HxvajOQa8DqPjkfHtWg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDFC51955F3E;
	Fri, 18 Oct 2024 06:49:32 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.232])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16F3519560A3;
	Fri, 18 Oct 2024 06:49:26 +0000 (UTC)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Disable warnings on unused flags for Clang builds
Date: Fri, 18 Oct 2024 08:49:01 +0200
Message-ID: <370c84ee3a0e8627a09d89fff12f7a285565fb46.1729233447.git.vmalik@redhat.com>
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
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1fc7c38e56b5..3da1a61968b7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -273,6 +273,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
 		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
+		     -Wno-unused-command-line-argument \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,--version-script=liburandom_read.map \
 		     -fPIC -shared -o $@
@@ -281,6 +282,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 	$(call msg,BINARY,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
 		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
+		     -Wno-unused-command-line-argument \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,-rpath=. -o $@
-- 
2.47.0


