Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93A2DA0E6
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 20:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502869AbgLNTyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502870AbgLNTyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 14:54:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0318AC061794
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 11:53:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qw4so24222261ejb.12
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 11:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=el0TJ7q4MDmfKGG0DgnylUlh4OW6z1KyD9stwxZA2oM=;
        b=qrE8M8NdgIYQEJhuwz32OyRpHgumS9TgE13cvGkQyMto63GSUspt9H4jDqfa/TfhBx
         ZJuDQ3wmfi8fcoLYwJT+VGZsoaCSHsodcuN1CR8lUo65TsDvJg+Bu/y9zspsEXVOJm/y
         BCX/2GcWu8gKF+0aI3S1gODW7LM5frkYHLn6U35cX1pr6QlhbA8SIJU8Wa4vjJ1SlG9L
         il9fNuuaDUay7ROLkQKLBS2kP8LSn5fYkf0vIzdqnrGhKdcUQ1HD3IRYSJzSanfRtQ89
         rdSnGxHtiOHgNU0kYqhZPRLhXT5CsM7E0KKwrudAACOnkJ832J6hTPEO5y+EAyY+Yes6
         Wtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=el0TJ7q4MDmfKGG0DgnylUlh4OW6z1KyD9stwxZA2oM=;
        b=hvegRulOC4TcpNcxnPS/+gHmJ+fuBr1Xtcs1rlU2ozZmS/zmaG+taPqp2XVeqhdIxC
         G6MjVGrUeWUvPCyoSKrKn8CAHuXVSN28BHZYYfLjJWylnlsyMXMch1GpEp9M/605X4T9
         tGaDDZfhbmQhAgngCwIevvgAutADK1hDr5+NTP+dJv/hfwZeliB5GuzQJVa53nIwpP0m
         rAAvTNQabsG3lt/Op6MeBjcGjENF2QTmD/KklXxcCQR17bTJwsD2ES0sJDE3gEa7TFkg
         kTUNZAYaZBW39xA1+sHgxtNTlRkuJoeIs3khB7FXEDFP+DFLWRz3C4fu0TaBQ8MtvylM
         m4jw==
X-Gm-Message-State: AOAM532E/1nYLoR0j5kjAqqif2KsADgAvCFfyjZRKX0oYd6XgRit3egh
        bHTwngJ0Ljut6uDAH865mFQErPThLPn6AgHpTSM=
X-Google-Smtp-Source: ABdhPJw+bMvKSYV9h7byjX6zYD6ZbmM81sSOsHrK9Pv8wy6e8CkugqIwYy8s5MPW+rg/bxqFHOOPfQ==
X-Received: by 2002:a17:906:6c94:: with SMTP id s20mr3465457ejr.0.1607975607478;
        Mon, 14 Dec 2020 11:53:27 -0800 (PST)
Received: from localhost (bba163592.alshamil.net.ae. [217.165.22.16])
        by smtp.gmail.com with ESMTPSA id rs27sm14814365ejb.21.2020.12.14.11.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:53:27 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add unit tests for global functions
Date:   Mon, 14 Dec 2020 23:52:50 +0400
Message-Id: <4a0f45692b124b7bca139a6c58c131496ec2dc12.1607973529.git.me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1607973529.git.me@ubique.spb.ru>
References: <cover.1607973529.git.me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_global_func9  - check valid scenarios for struct pointers
test_global_func10 - check that the smaller struct cannot be passed as a
                     the larger one
test_global_func11 - check that CTX pointer cannot be passed as a struct
                     pointer
test_global_func12 - check access to a null pointer
test_global_func13 - check access to an arbitrary pointer value

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 .../bpf/prog_tests/test_global_funcs.c        |  5 ++
 .../selftests/bpf/progs/test_global_func10.c  | 29 +++++++++
 .../selftests/bpf/progs/test_global_func11.c  | 19 ++++++
 .../selftests/bpf/progs/test_global_func12.c  | 21 +++++++
 .../selftests/bpf/progs/test_global_func13.c  | 24 ++++++++
 .../selftests/bpf/progs/test_global_func9.c   | 59 +++++++++++++++++++
 6 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 32e4348b714b..c4895e6c83c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -61,6 +61,11 @@ void test_test_global_funcs(void)
 		{ "test_global_func6.o" , "modified ctx ptr R2" },
 		{ "test_global_func7.o" , "foo() doesn't return scalar" },
 		{ "test_global_func8.o" },
+		{ "test_global_func9.o" },
+		{ "test_global_func10.o", "invalid indirect read from stack off -8+4 size 8" },
+		{ "test_global_func11.o", "Caller passes invalid args into func#1" },
+		{ "test_global_func12.o", "invalid mem access 'mem_or_null'" },
+		{ "test_global_func13.o", "Caller passes invalid args into func#1" },
 	};
 	libbpf_print_fn_t old_print_fn = NULL;
 	int err, i, duration = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
new file mode 100644
index 000000000000..61c2ae92ce41
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct Small {
+	int x;
+};
+
+struct Big {
+	int x;
+	int y;
+};
+
+__noinline int foo(const struct Big *big)
+{
+	if (big == 0)
+		return 0;
+
+	return bpf_get_prandom_u32() < big->y;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	const struct Small small = {.x = skb->len };
+
+	return foo((struct Big *)&small) ? 1 : 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
new file mode 100644
index 000000000000..28488047c849
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int x;
+};
+
+__noinline int foo(const struct S *s)
+{
+	return s ? bpf_get_prandom_u32() < s->x : 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	return foo(skb);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
new file mode 100644
index 000000000000..62343527cc59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int x;
+};
+
+__noinline int foo(const struct S *s)
+{
+	return bpf_get_prandom_u32() < s->x;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	const struct S s = {.x = skb->len };
+
+	return foo(&s);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
new file mode 100644
index 000000000000..ff8897c1ac22
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int x;
+};
+
+__noinline int foo(const struct S *s)
+{
+	if (s)
+		return bpf_get_prandom_u32() < s->x;
+
+	return 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	const struct S *s = (const struct S *)(0xbedabeda);
+
+	return foo(s);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func9.c b/tools/testing/selftests/bpf/progs/test_global_func9.c
new file mode 100644
index 000000000000..17217d0fcd81
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func9.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct S {
+	int x;
+};
+
+struct C {
+	int x;
+	int y;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct S);
+} map SEC(".maps");
+
+__noinline int foo(const struct S *s)
+{
+	if (s)
+		return bpf_get_prandom_u32() < s->x;
+
+	return 0;
+}
+
+SEC("cgroup_skb/ingress")
+int test_cls(struct __sk_buff *skb)
+{
+	int result = 0;
+
+	{
+		const struct S s = {.x = skb->len };
+
+		result |= foo(&s);
+	}
+
+	{
+		const __u32 key = 1;
+		const struct S *s = bpf_map_lookup_elem(&map, &key);
+
+		result |= foo(s);
+	}
+
+	{
+		const struct C c = {.x = skb->len, .y = skb->family };
+
+		result |= foo((const struct S *)&c);
+	}
+
+	{
+		result |= foo(NULL);
+	}
+
+	return result ? 1 : 0;
+}
-- 
2.25.1

