Return-Path: <bpf+bounces-61161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC662AE1A1F
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF3E4A20B9
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7728A3E4;
	Fri, 20 Jun 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dldju2PV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42421A425;
	Fri, 20 Jun 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419533; cv=none; b=jVXagAcgJpGHdtLUEu0AvG4T3Kv4KuIHL9QjXocu9IY61zlheN8ZGKnRT0xYnbKDEJLirdl61E5ep+KJZOQduXp9fygLsZmb9DTCrweSpullqszbaBv6fXjsLbj/en8JRxEnTQsKjNRFIM7yKnupGpnzw2ge+dwaszUUjeqAlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419533; c=relaxed/simple;
	bh=wldGJgpWJX2/0ox4U/bhSDHg+C5dlQXJ/dU+3159yuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fbolBHXGIGiVquGPOViWPZiSVyU0u9EEDraeLs0ZI680HrqWtUwZEOZX4FsGUbzoa/jWLPMsdWru6nl2SgjgbfnGnXMEuOfWQAHEaMjZeM0Bgo2dH3049tOKyri2q9WrmxHIf2Y9d1fb2y/fIUr6Z6gCyiXgzvrM+MpxGVAitJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dldju2PV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFFBC4CEE3;
	Fri, 20 Jun 2025 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750419532;
	bh=wldGJgpWJX2/0ox4U/bhSDHg+C5dlQXJ/dU+3159yuc=;
	h=From:To:Cc:Subject:Date:From;
	b=dldju2PVtEAP0iOcKTNK5vE2o3MW/EilJAOJSK3Zx1GIX0B85uwHE0Zjzq3HyMT+V
	 HqBbayBwnJ5Q7J0u56Lb8OyHOi7e7CjiiHbHBwQKDNJ9Rv9aYo4kCH+cUfTeeBlHR/
	 miZPL9NIQkQYSoWD16p407/1I6M3WntWtqTNZY0KWLNS3WFEF5/FB0jRNDKSYilNiT
	 gskxkUb9r4fXjYLKnkdDVV5t+DU76gRayPyDHD6xl4vzh8nvMm1Ie0WL//VL94xHYP
	 ln6rxkqW78au2X2/u3+vYRJ6Ha9AfYmv9CX+4L12K/PmWCpgbM6CgkFD049HJxzwMV
	 zhjT+iPhEqMHA==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] bpf: turn off sanitizer in do_misc_fixups for old clang
Date: Fri, 20 Jun 2025 13:38:31 +0200
Message-Id: <20250620113846.3950478-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang versions before version 18 manage to badly optimize the bpf
verifier, with lots of variable spills leading to excessive stack
usage in addition to likely rather slow code:

kernel/bpf/verifier.c:23936:5: error: stack frame size (2096) exceeds limit (1280) in 'bpf_check' [-Werror,-Wframe-larger-than]
kernel/bpf/verifier.c:21563:12: error: stack frame size (1984) exceeds limit (1280) in 'do_misc_fixups' [-Werror,-Wframe-larger-than]

Turn off the sanitizer in the two functions that suffer the most from
this when using one of the affected clang version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/verifier.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2fa797a6d6a2..7724c7a56d79 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19810,7 +19810,14 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return 0;
 }
 
-static int do_check(struct bpf_verifier_env *env)
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 180100
+/* old clang versions cause excessive stack usage here */
+#define __workaround_kasan  __disable_sanitizer_instrumentation
+#else
+#define __workaround_kasan
+#endif
+
+static __workaround_kasan int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state = env->cur_state;
@@ -21817,7 +21824,7 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
-static int do_misc_fixups(struct bpf_verifier_env *env)
+static __workaround_kasan int do_misc_fixups(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
 	enum bpf_attach_type eatype = prog->expected_attach_type;
-- 
2.39.5


