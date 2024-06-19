Return-Path: <bpf+bounces-32503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6560690E557
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 10:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A521F2187B
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FF278C66;
	Wed, 19 Jun 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNxCCP/I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658C6F308
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784991; cv=none; b=RrknmwFsA4CkcmaOXoxCqm/WJEyTVcJS3cnprCgnwhUlfn8pM2+F79NIYUS9G+XjYk5yzVyC++haaPM4QBC2q/1eFQkQXEjpHvQ+2MsjxR5IsaE4raAjffmdgm5boSNkQqyj4vL7vszto2sh5cmu2pZHpr1rOjI3MUsQPweBE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784991; c=relaxed/simple;
	bh=Uppl2HflRcEXUHLaWKzt215pH1svJLpET6RHp/Tm5Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVS0fwhOchyIAoiF71TITpPqpHSmPPQ/nbnpLRV2Bs+G1dnljh66P3XkIQRf/U1KFFX9EGFGaXh4Y9tKra1ZTP7iqHLX6SaPE0XFu/gQJ18c+oxU4vef4e0QH3rcbhCAqBgbjMGhLurWCWiufZ0qMUjQFAN7TTXAR44zy/o9yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNxCCP/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF6C2BBFC;
	Wed, 19 Jun 2024 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718784990;
	bh=Uppl2HflRcEXUHLaWKzt215pH1svJLpET6RHp/Tm5Lw=;
	h=From:To:Cc:Subject:Date:From;
	b=XNxCCP/I6qzAxTD78K2o/nBtmTkwfv8nUqS662ZoGl3RiM4HfaIaDjjhhv0zX2gAq
	 m10WF2GL4qrKtAlyRF9lBXgRyHp3md4VKBSTTumwXa8wGiYQem5EoBYvEKU9QNLPYv
	 UunTN5SFQPOtWwjuS2C6Ku3OgSnJE5jBpzYtBGxxa6eBU4z6JCA7YcbprWx4YG/Z4k
	 y81On9jxC6B1Jzhf/cv6d57q26CYPEMEtPZqOrUBlluMOKan59fhSOfXBAkaUcR7P/
	 i0jcwjEcE1vO6jcsQQO3bjeF923iJczh67HSPdxhSkWYKHhRRIAnU8DD6M6o2O9YOR
	 KUxelHuJdBM/A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next] bpf: Change bpf_session_cookie return value to __u64 *
Date: Wed, 19 Jun 2024 10:16:24 +0200
Message-ID: <20240619081624.1620152-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts [1] and changes return value for bpf_session_cookie
in bpf selftests. Having long * might lead to problems on 32-bit
architectures.

Fixes: 2b8dd87332cd ("bpf: Make bpf_session_cookie() kfunc return long *")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c                                        | 2 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 +-
 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4b3fda456299..cd098846e251 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3530,7 +3530,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	return session_ctx->is_return;
 }
 
-__bpf_kfunc long *bpf_session_cookie(void)
+__bpf_kfunc __u64 *bpf_session_cookie(void)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index be91a6919315..3b6675ab4086 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
 extern bool bpf_session_is_return(void) __ksym __weak;
-extern long *bpf_session_cookie(void) __ksym __weak;
+extern __u64 *bpf_session_cookie(void) __ksym __weak;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
index d49070803e22..0835b5edf685 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -25,7 +25,7 @@ int BPF_PROG(trigger)
 
 static int check_cookie(__u64 val, __u64 *result)
 {
-	long *cookie;
+	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
-- 
2.45.2


