Return-Path: <bpf+bounces-43807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E829B9ECA
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 11:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE22282380
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E3716E89B;
	Sat,  2 Nov 2024 10:16:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zulu.geekplace.eu (zulu.geekplace.eu [5.45.100.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3E16FF3B;
	Sat,  2 Nov 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.45.100.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542582; cv=none; b=ekfh0ITP56+/tGLe68KTytLv6zMtONPuruBZDUSz99JnVs14uducRMdX6YPGG1e3de7YSyVRKzgM5h9ZnIogTEYEBstzrv+AMmcaw5s0RdV5N4vxQWSKGRzQirsPTt4ySn8Jf1a1ws/Lh/C2xxhY0JRhSu657NeqssOZAV+Yr1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542582; c=relaxed/simple;
	bh=lq3SCdtwAoRG1X0Xf16GvmV78s1YX00UVljTHU9wKtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WR4CSboCbU4fab3N0o4p8RXH01tSYLKmaPavZR3lo9Kb15oBLxwlXQGytnHTzrq7mtZ/xOcqimfSACeZXzhFmfxFliVo7Own2iujcdOGYHOqE+2o8wm9QJCiBhecZFFnvz9cuWELMBruEY5mc9NcW5DAzsRfP53W8hQU3AfF368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu; spf=pass smtp.mailfrom=geekplace.eu; arc=none smtp.client-ip=5.45.100.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geekplace.eu
Received: from neo-pc.sch (unknown [IPv6:2001:4091:a241:81f5:34fb:50ff:feac:591b])
	by zulu.geekplace.eu (Postfix) with ESMTPA id BD9604A0017;
	Sat,  2 Nov 2024 11:04:56 +0100 (CET)
From: Florian Schmaus <flo@geekplace.eu>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild,bpf: pass make jobs' value to pahole
Date: Sat,  2 Nov 2024 11:04:51 +0100
Message-ID: <20241102100452.793970-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the value of make's -j/--jobs argument to pahole, to avoid out of
memory errors and make pahole respect the "jobs" value of make.

On systems with little memory but many cores, invoking pahole using -j
without argument potentially creates too many pahole instances,
causing an out-of-memory situation. Instead, we should pass make's
"jobs" value as an argument to pahole's -j, which is likely configured
to be (much) lower than the actual core count on such systems.

If make was invoked without -j, either via cmdline or MAKEFLAGS, then
JOBS will be simply empty, resulting in the existing behavior, as
expected.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 scripts/Makefile.btf | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index b75f09f3f424..c3cbeb13de50 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -3,6 +3,8 @@
 pahole-ver := $(CONFIG_PAHOLE_VERSION)
 pahole-flags-y :=
 
+JOBS := $(patsubst -j%,%,$(filter -j%,$(MAKEFLAGS)))
+
 ifeq ($(call test-le, $(pahole-ver), 125),y)
 
 # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
@@ -12,14 +14,14 @@ endif
 
 pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
 
-pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
+pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j$(JOBS)
 
 pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
 
 else
 
 # Switch to using --btf_features for v1.26 and later.
-pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
+pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
-- 
2.45.2


