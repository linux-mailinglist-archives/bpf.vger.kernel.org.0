Return-Path: <bpf+bounces-530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CE702E7E
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306E62809B0
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BEEC8FA;
	Mon, 15 May 2023 13:39:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE8C8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8058C433D2;
	Mon, 15 May 2023 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157973;
	bh=JLylzNHWR2h+V1Y+doe1HpiwW+SYMJn3c154nt6ozUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcuyFxYflLrjJNa6DlOLgKgiW71CWvovwRKVgjVTr6LbfuQO09897+eJF9XZyHBNX
	 y6fBS2+DTxNpiWm64+Q0ESN4I7GvQI7foyEjV2EVn1UD39aib6KoizLnUAttJ1avcp
	 y8WsV1EOh6I9HnTrUJm2KcODMSr5klpTt1cCvQGmT85xxrYJZDE+4kXgUus+5mvR44
	 JRAf+EiGY5hthf5xSpR25sv1Qm/7LdTvp+C9EFOYSiYMixRL9xpMTSrmZLIrrHFW+z
	 0VT3HvpYUHzKqr7ClXQ+3FkBCdwgBiTWpDqAAVOzMJAbAa7fu/obv+qOAnbBjAh3TH
	 8qrTg9gI/a34g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 09/10] selftests/bpf: Remove extern from kfuncs declarations
Date: Mon, 15 May 2023 15:37:55 +0200
Message-Id: <20230515133756.1658301-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
References: <20230515133756.1658301-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to keep the extern in kfuncs declarations.

Suggested-by: David Vernet <void@manifault.com>
Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index f0755135061d..57f6166911f8 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -10,31 +10,31 @@
 #define __ksym
 #endif
 
-extern struct prog_test_ref_kfunc *
+struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
+void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
-extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
-extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
-extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
-extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
+void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
+int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+void bpf_kfunc_call_int_mem_release(int *p) __ksym;
+u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 
-extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
+void bpf_testmod_test_mod_kfunc(int i) __ksym;
 
-extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
+__u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
-extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
-extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
+int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
+struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
+long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 
-extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
-extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
-extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
-extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
+void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
+void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
+void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
+void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
-extern void bpf_kfunc_call_test_destructive(void) __ksym;
+void bpf_kfunc_call_test_destructive(void) __ksym;
 
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.40.1


