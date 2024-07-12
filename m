Return-Path: <bpf+bounces-34643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E492F8BE
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720831C21CA4
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB4153823;
	Fri, 12 Jul 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYkU00dn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B013F439
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779272; cv=none; b=tjG3rfaq/6SDta0xAMxWGbHAtyFzpl8gLZhuWUL2ZfH7tU/0s4dFQkSAoZZiApAqLfwrHNBL+8rpQdVgcz1K36KLBwqTeCiJPZlLr9m/jXvGT9RTd1CYg790DPXrR8f+kNn2DsCUL2WiR6xVYIYZ4FR6qhe5kHwVNghrj3yoCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779272; c=relaxed/simple;
	bh=g1+jAoMq8Ne+lB0G0K685swodoixr2G/5iQQX4BxL/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcMVtrWi4wBajlSLf4g9XW3C9XNCDppG6jIN0r1wj+eCYhQB4XsCEt5cG6z+kBZFZbm1tiKo/WO0E0Cy9NP8XePC7qMjYv4abMjDPuB69H0RkTQHQ5i1cCmZHUbteFjSINhbcq4qUgO7esMLghhluVboDsS7o+KcTqBwDkEm9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYkU00dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8FEC32782;
	Fri, 12 Jul 2024 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720779272;
	bh=g1+jAoMq8Ne+lB0G0K685swodoixr2G/5iQQX4BxL/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYkU00dnUy/yPRWPe/b9i75w4X3tXWj6/+yn2sX3H7XeiHenaPN+1KcX/b70pLqx2
	 wi3axfK7F/lWQ2Mr8PvHU1aq8WN5s5fXlJztzLi4p0oKlkCWCy+nxPadjN9h6o/7OZ
	 1NuMOSwY2nuTIR2nud+M3k9WhA0XmJFrwGAc2Ge4Hc/nMtYtJL9TSuLEXpeyd+ufRn
	 4CiW2t7p/CrAnkmggABpa4htrB3Fs8qC49wOuI8Nx1H/P+WZC54MgSGJ6zf63yUzfi
	 pC/Bz8i43M7yEYa8z4xl4nyzu+oboOaIMyVV2momZ6+4GyAaWdEOdSdhRCBJQtnfIY
	 NAsMt+QO8QnBA==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] libbpf: handle ENOTSUPP in libbpf_strerror_r
Date: Fri, 12 Jul 2024 18:14:13 +0800
Message-ID: <2437275bb988da5c187b4d0223e5c0c9843fdc76.1720778831.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720778831.git.tanggeliang@kylinos.cn>
References: <cover.1720778831.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The errno 95 (ENOTSUP or EOPNOTSUPP) can be recognized by strerror_r(),
but 524 (ENOTSUPP) can't:

 prog 'basic_alloc3': BPF program load failed: Operation not supported
 prog 'basic_alloc3': failed to load: -95
 failed to load object 'verifier_arena'
 FAIL:unexpected_load_failure unexpected error: -95 (errno 95)

 prog 'inner_map': BPF program load failed: unknown error (-524)
 prog 'inner_map': failed to load: -524
 failed to load object 'bloom_filter_map'
 failed to load BPF skeleton 'bloom_filter_map': -524
 FAIL:bloom_filter_map__open_and_load unexpected error: -524

This patch fixes this by handling ENOTSUPP in libbpf_strerror_r(). With
this change, the new error string looks like:

 prog 'inner_map': BPF program load failed: Operation not supported (-524)

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/lib/bpf/str_error.c | 11 +++++++----
 tools/lib/bpf/str_error.h |  4 ++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
index 5e6a1e27ddf9..10597d5124cd 100644
--- a/tools/lib/bpf/str_error.c
+++ b/tools/lib/bpf/str_error.c
@@ -23,10 +23,13 @@ char *libbpf_strerror_r(int err, char *dst, int len)
 	if (ret == -1)
 		ret = errno;
 	if (ret) {
-		if (ret == EINVAL)
-			/* strerror_r() doesn't recognize this specific error */
-			snprintf(dst, len, "unknown error (%d)", err < 0 ? err : -err);
-		else
+		if (ret == EINVAL) {
+			if (err == ENOTSUPP)
+				snprintf(dst, len, "Operation not supported (%d)", -err);
+			else
+				/* strerror_r() doesn't recognize this specific error */
+				snprintf(dst, len, "unknown error (%d)", err < 0 ? err : -err);
+		} else
 			snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
 	}
 	return dst;
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
index 626d7ffb03d6..c41f6ba133cf 100644
--- a/tools/lib/bpf/str_error.h
+++ b/tools/lib/bpf/str_error.h
@@ -4,6 +4,10 @@
 
 #define STRERR_BUFSIZE  128
 
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
 char *libbpf_strerror_r(int err, char *dst, int len);
 
 #endif /* __LIBBPF_STR_ERROR_H */
-- 
2.43.0


