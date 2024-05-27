Return-Path: <bpf+bounces-30642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27B8CFEC4
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 13:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E66B22100
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B7013C822;
	Mon, 27 May 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UR5KkQua"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511C13C831
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808834; cv=none; b=PxDLBdPPBPDFwXzrXo+hJ2TTp5xIX9ofyPxd3ppPYhGmJIaLRZnqz21Hyh936LpZ1lZnA1kIScrZKh+4Lv8LPYwqMkMwwTnoIwgctojkS92p6lznPnjT/sln8RjWbhciU07ZPj+M5RZavV++C/Cn/UjMbVtpnEzfDK4aLkjaYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808834; c=relaxed/simple;
	bh=ZVzNevtLO4r/oZu986oCuz7Tf7nkZt7CBBz5HeLDS8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AmFUJo93dWV7B07ea3yyemQtDzbHX3RxU7qTqTFcoZkWBy1nQ9yCkwan70/aB+MDamAOQzFgErbsYpzpPABgYEwCb5i4lsYZX5jO6Q6iR6a0wg7zkoNxRbJDzyc72SQqEwqQ+ysQ5VJn9WzlvX6LX/0+fNxQYBgfKWgmd3drGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UR5KkQua; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6269ad9a6fso353095266b.2
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716808831; x=1717413631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BoYAK6dmFx09JhEtXnjE9H2U5t2605tLty0EV9Pv50=;
        b=UR5KkQuavLgaxZuzLB08mmUoFc/4RnHHhDeR1VthA4j22kY1/vFwhF2EXzac33epqe
         Lf+Rx2/n32cvhzuzCaF7YDpsOfOh4KO9MniLsxs9ivjBIKkojjJSFh7/bCa0nDYBXKkm
         f4AXehF3c26od0x2a00tYa/ieldQvEDtK6pRGY4ZvcssKpZla0Z9cCiVHJEFi+2b/29c
         qYo4nVgk3TquaoBAWlUlUrQLTrPToVBEb/TU3EeqdaLoM+KcNHgJo4J2xJ3avyZaBK7O
         iZ/tBRcNpHAUSQ2cwkLfVSoSkLNaQZHrFys0gYj+1OVOlQmdwSho58+3cmO82m1Nx3yJ
         SFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808831; x=1717413631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BoYAK6dmFx09JhEtXnjE9H2U5t2605tLty0EV9Pv50=;
        b=YmaSIqNsS0wcbX6SabtNP/8BIXR2zz8+VeiYSExqR76k5enxBQbVTbvczo2A9ub0em
         SdAEFlPOcipWV9JbK/HSFfL/7tHd3MAoJjOXrB1cX/cq/Wb3qjhTog0ED+yU82CRBUj9
         cXyM8oI0Bnjv2pWpbahGu1+WI/89AYlFvjKuYuDMAvfiZub4jad2CVlQ23xakfZyk8c3
         jggoCghbIT+yasxx1t955tVAYSccaiy/o0Ib7GK+PxghuHEORTW/u2yMFz6XDNulMu6W
         2DkLeo/Sz0QuLowKSlEW8MI5B+Ya/cxF7ypKqsAvQXPZ3uHODnRq36SDg/nZbiAa+w70
         pXlQ==
X-Gm-Message-State: AOJu0YyS8MkDU65I/BTMzeMMwLNxfPKjy3tHrMxsT5P9Ocnokjy6NBsA
	r0yLAUUDCvyrjO5WHEtYx9wAPurGRQpOPsbeQp6RGxmUJkiFcO+nLYA89eXtav/U3qCoqEzKf6G
	o
X-Google-Smtp-Source: AGHT+IFuFXEfFBSPzyFG4ntczWMr7vkgIu0DW961doLD3ZevjrolFf+UJkELlHvxvWskhe1IJxOkwQ==
X-Received: by 2002:a17:906:2dcd:b0:a59:9a68:7283 with SMTP id a640c23a62f3a-a62641a572dmr480390266b.12.1716808831185;
        Mon, 27 May 2024 04:20:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a630f25943dsm46285166b.41.2024.05.27.04.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:20:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 27 May 2024 13:20:09 +0200
Subject: [PATCH bpf 3/3] selftests/bpf: Cover verifier checks for mutating
 sockmap/sockhash
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sockmap-verify-deletes-v1-3-944b372f2101@cloudflare.com>
References: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
In-Reply-To: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, Hillf Danton <hdanton@sina.com>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.13.0

Verifier enforces that only certain program types can mutate sock{map,hash}
maps, that is update it or delete from it. Add test coverage for these
checks so we don't regress.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_sockmap_mutate.c  | 187 +++++++++++++++++++++
 2 files changed, 189 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c60db8beeb73..1c9c4ec1be11 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -67,6 +67,7 @@
 #include "verifier_search_pruning.skel.h"
 #include "verifier_sock.skel.h"
 #include "verifier_sock_addr.skel.h"
+#include "verifier_sockmap_mutate.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
 #include "verifier_stack_ptr.skel.h"
@@ -183,6 +184,7 @@ void test_verifier_sdiv(void)                 { RUN(verifier_sdiv); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_sock_addr(void)            { RUN(verifier_sock_addr); }
+void test_verifier_sockmap_mutate(void)       { RUN(verifier_sockmap_mutate); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
new file mode 100644
index 000000000000..fe4b123187b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+#define __always_unused __attribute__((unused))
+
+char _license[] SEC("license") = "GPL";
+
+struct sock {
+} __attribute__((preserve_access_index));
+
+struct bpf_iter__sockmap {
+	union {
+		struct sock *sk;
+	};
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sockhash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sockmap SEC(".maps");
+
+enum { CG_OK = 1 };
+
+int zero = 0;
+
+static __always_inline void test_sockmap_delete(void)
+{
+	bpf_map_delete_elem(&sockmap, &zero);
+	bpf_map_delete_elem(&sockhash, &zero);
+}
+
+static __always_inline void test_sockmap_update(void *sk)
+{
+	if (sk) {
+		bpf_map_update_elem(&sockmap, &zero, sk, BPF_ANY);
+		bpf_map_update_elem(&sockhash, &zero, sk, BPF_ANY);
+	}
+}
+
+static __always_inline void test_sockmap_lookup_and_update(void)
+{
+	struct bpf_sock *sk = bpf_map_lookup_elem(&sockmap, &zero);
+
+	if (sk) {
+		test_sockmap_update(sk);
+		bpf_sk_release(sk);
+	}
+}
+
+static __always_inline void test_sockmap_mutate(void *sk)
+{
+	test_sockmap_delete();
+	test_sockmap_update(sk);
+}
+
+static __always_inline void test_sockmap_lookup_and_mutate(void)
+{
+	test_sockmap_delete();
+	test_sockmap_lookup_and_update();
+}
+
+SEC("action")
+__success
+int test_sched_act(struct __sk_buff *skb)
+{
+	test_sockmap_mutate(skb->sk);
+	return 0;
+}
+
+SEC("classifier")
+__success
+int test_sched_cls(struct __sk_buff *skb)
+{
+	test_sockmap_mutate(skb->sk);
+	return 0;
+}
+
+SEC("flow_dissector")
+__success
+int test_flow_dissector_delete(struct __sk_buff *skb __always_unused)
+{
+	test_sockmap_delete();
+	return 0;
+}
+
+SEC("flow_dissector")
+__failure __msg("program of this type cannot use helper bpf_sk_release")
+int test_flow_dissector_update(struct __sk_buff *skb __always_unused)
+{
+	test_sockmap_lookup_and_update(); /* no access to skb->sk */
+	return 0;
+}
+
+SEC("iter/sockmap")
+__success
+int test_trace_iter(struct bpf_iter__sockmap *ctx)
+{
+	test_sockmap_mutate(ctx->sk);
+	return 0;
+}
+
+SEC("raw_tp/kfree")
+__failure __msg("cannot update sockmap in this context")
+int test_raw_tp_delete(const void *ctx __always_unused)
+{
+	test_sockmap_delete();
+	return 0;
+}
+
+SEC("raw_tp/kfree")
+__failure __msg("cannot update sockmap in this context")
+int test_raw_tp_update(const void *ctx __always_unused)
+{
+	test_sockmap_lookup_and_update();
+	return 0;
+}
+
+SEC("sk_lookup")
+__success
+int test_sk_lookup(struct bpf_sk_lookup *ctx)
+{
+	test_sockmap_mutate(ctx->sk);
+	return 0;
+}
+
+SEC("sk_reuseport")
+__success
+int test_sk_reuseport(struct sk_reuseport_md *ctx)
+{
+	test_sockmap_mutate(ctx->sk);
+	return 0;
+}
+
+SEC("socket")
+__success
+int test_socket_filter(struct __sk_buff *skb)
+{
+	test_sockmap_mutate(skb->sk);
+	return 0;
+}
+
+SEC("sockops")
+__success
+int test_sockops_delete(struct bpf_sock_ops *ctx __always_unused)
+{
+	test_sockmap_delete();
+	return CG_OK;
+}
+
+SEC("sockops")
+__failure __msg("cannot update sockmap in this context")
+int test_sockops_update(struct bpf_sock_ops *ctx)
+{
+	test_sockmap_update(ctx->sk);
+	return CG_OK;
+}
+
+SEC("sockops")
+__success
+int test_sockops_update_dedicated(struct bpf_sock_ops *ctx)
+{
+	bpf_sock_map_update(ctx, &sockmap, &zero, BPF_ANY);
+	bpf_sock_hash_update(ctx, &sockhash, &zero, BPF_ANY);
+	return CG_OK;
+}
+
+SEC("xdp")
+__success
+int test_xdp(struct xdp_md *ctx __always_unused)
+{
+	test_sockmap_lookup_and_mutate();
+	return XDP_PASS;
+}

-- 
2.40.1


