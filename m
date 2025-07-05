Return-Path: <bpf+bounces-62470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A0FAF9FBB
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 12:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0B3A8DD7
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6F24EAAA;
	Sat,  5 Jul 2025 10:43:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA0248F73;
	Sat,  5 Jul 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751712221; cv=none; b=jm5pbqcWawMcWAYGvu/3y4osY35CZpQdsL5+3wZQLZRU+p5Yxq5qtpsOr4HFbjMH/xp/vxLPt2pN2a9BTwyDWd4SVkLyqB6e9PihYtgWF0VzExWMul9MC9+OdQSEysODddnzDp1wXgIs9lquGTEhBEMrHoUYmlgzGz7nhNHESV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751712221; c=relaxed/simple;
	bh=EEME5udvQ+zaOYypFDpbf5bWaOllYPm0s8sGmQj/QoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gsb4cbVn5by231LeMGqQm18ft7PruDSJTrAG9JlokivN4ZpshOqhcGFoo3zh/3Q8Na5rnmUXEYUcbEOOH3mu6kZMKF1ycBfsSlnqXE5ZGckH/ImOObPzhMncwFdGLz515/FKgfs/1D+mBAI1LxH1gn085eiicz3gzQbIT9sErhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7A730342071;
	Sat, 05 Jul 2025 10:43:34 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sam James <sam@gentoo.org>
Subject: [PATCH] tools/libbpf: add WERROR option
Date: Sat,  5 Jul 2025 11:43:12 +0100
Message-ID: <7e6c41e47c6a8ab73945e6aac319e0dd53337e1b.1751712192.git.sam@gentoo.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the 'WERROR' variable and suppress adding '-Werror' if WERROR=0.

This mirrors what tools/perf and other directories in tools do to handle
-Werror rather than adding it unconditionally.

Signed-off-by: Sam James <sam@gentoo.org>
---
 tools/lib/bpf/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 168140f8e646..9563d37265da 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -77,10 +77,15 @@ else
   CFLAGS := -g -O2
 endif
 
+# Treat warnings as errors unless directed not to
+ifneq ($(WERROR),0)
+  CFLAGS += -Werror
+endif
+
 # Append required CFLAGS
 override CFLAGS += -std=gnu89
 override CFLAGS += $(EXTRA_WARNINGS) -Wno-switch-enum
-override CFLAGS += -Werror -Wall
+override CFLAGS += -Wall
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
-- 
2.50.0


