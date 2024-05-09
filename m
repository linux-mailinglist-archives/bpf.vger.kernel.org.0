Return-Path: <bpf+bounces-29211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CAC8C1455
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CB71C21D18
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE2B770FB;
	Thu,  9 May 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NzwvrwiT"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B717BA9
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277043; cv=none; b=kUhRGH1NyOUZAc94iWTqwq8PV8fWDJowS5Z/sR9ol5c9ofAyBCJrW68qlLVJpYPfqVplUUsVdsMTGLPOkeVh9tgnIv8fDBXKavX5qoc8THJHEjiojECFtLzxCc5591P3MZUfzs4B8bq7dPt3uYELlex0xyxzwYW+MQZAbjDrpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277043; c=relaxed/simple;
	bh=7goRI94EI1jH9w7KOd7a8tevhsEhl0UFeSlzR/OkbC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El3K65nw828VaNa3A7bYLoHF/GZ7DAX6UDRULy0+RFVNQuw/WlG9mlJs0Q479LO0ibEWG4aEARSrQkNCnHKOt6XRoUJkhMLddhPzlqtUn9hmXe0ucbu9itr/InXkQCqbJ5aNsHkVP4WSsly/etyibMFHR19Tl9Y0FLrX4G6K0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NzwvrwiT; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04sXCs5eEyAXX6SuLpRlbNC7WdEEOjc6U7Zoj8L36z8=;
	b=NzwvrwiTlCrQ0Kl7thx91YCO6Rw38j7GGjLpGFK/6GoCFhiIZ0p89RVet1iY1RkN7nh9a4
	anPHiG00INYpZdCHsrzhsGEza8sXqNM/Hz8rNjsvykxx9MAwh0ibS42YW5Bw+LjdAuZclU
	NIwU7diwp+s/YmW5UBhBxVQgmpY5IUc=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 03/10] selftests/bpf: Reuse the tcp_sk() from the bpf_tracing_net.h
Date: Thu,  9 May 2024 10:50:19 -0700
Message-ID: <20240509175026.3423614-4-martin.lau@linux.dev>
In-Reply-To: <20240509175026.3423614-1-martin.lau@linux.dev>
References: <20240509175026.3423614-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch removes the individual tcp_sk implementations from the
tcp-cc tests. The tcp_sk() implementation from the bpf_tracing_net.h
is reused instead.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c | 8 +-------
 tools/testing/selftests/bpf/progs/tcp_ca_update.c         | 8 +-------
 .../testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c  | 8 +-------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c b/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
index 7bb872fb22dd..d6467fcb1deb 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
@@ -1,17 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "vmlinux.h"
-
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
-static inline struct tcp_sock *tcp_sk(const struct sock *sk)
-{
-	return (struct tcp_sock *)sk;
-}
-
 SEC("struct_ops/incompl_cong_ops_ssthresh")
 __u32 BPF_PROG(incompl_cong_ops_ssthresh, struct sock *sk)
 {
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
index b93a0ed33057..8581cad321b6 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_update.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "vmlinux.h"
-
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -10,11 +9,6 @@ char _license[] SEC("license") = "GPL";
 int ca1_cnt = 0;
 int ca2_cnt = 0;
 
-static inline struct tcp_sock *tcp_sk(const struct sock *sk)
-{
-	return (struct tcp_sock *)sk;
-}
-
 SEC("struct_ops/ca_update_1_init")
 void BPF_PROG(ca_update_1_init, struct sock *sk)
 {
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c b/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
index 0724a79cec78..4a369439335e 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "vmlinux.h"
-
+#include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -11,11 +10,6 @@ char _license[] SEC("license") = "GPL";
 
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
-static inline struct tcp_sock *tcp_sk(const struct sock *sk)
-{
-	return (struct tcp_sock *)sk;
-}
-
 static inline unsigned int tcp_left_out(const struct tcp_sock *tp)
 {
 	return tp->sacked_out + tp->lost_out;
-- 
2.43.0


