Return-Path: <bpf+bounces-65539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE73B25453
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84751C85738
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46BD2FE571;
	Wed, 13 Aug 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b="IRDsjf7w"
X-Original-To: bpf@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414142FD7C1;
	Wed, 13 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115767; cv=none; b=YsxuTLGLj7ZAZgXqNddB/SDF3B1HfYqzfGfppdf0hQ75oOIXtvncxvQm0pKRe48aknovk9VRAYExzZi2kYr+XWW4m7ryrfVRiL840of7n731P1yzG9cV6ccUFFvzIaL5sutSOnOQYfpapOBNO/ly3rsIXmCcNp/SK0s2iBdvAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115767; c=relaxed/simple;
	bh=djItZj1tv/P0GBUI4QzQhkjOwTsgdwRm040K9C8xyUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NblYf37Y6XWmQTlo3xvYVn88VS6hwhbA4VJA4BxrIPu3hcL0h887/goVeTdU5apH5+04q1DDsrGoEoLmZWKGLME7dF+T7am1CTTP7wRqX9y23tfY0V0jXo/1deJk45rqez7oRJOx7JOyDy6la3QBPGrQqnsZXBx8ZU3azug5xdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev; spf=pass smtp.mailfrom=yuka.dev; dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b=IRDsjf7w; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuka.dev
From: Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
	t=1755115757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGjHGjnND+XLcmoc6stb7T/Y2gjWQ0r/KxkZxrbs9BU=;
	b=IRDsjf7w9zS6UoK/LsRSBg5Tgx9MRXHPWOaDk+JgeW8K1JBdBmGw63YPsdQsqgnymZmkpT
	mPZ+kA9zedjJOybAXGbKQVe0mWnAjJ7YcBIVykYkuD+VoG4IzdsfsIZuwr33Qdq+O5m9xy
	irWMa0CwE50zukYGceScP9NGb5YaLv4=
To: Andrii Nakryiko <andrii@kernel.org>,
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
Cc: Yureka Lilian <yuka@yuka.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] bpf: add test for DEVMAP reuse
Date: Wed, 13 Aug 2025 22:09:11 +0200
Message-ID: <20250813200912.3523279-3-yuka@yuka.dev>
In-Reply-To: <20250813200912.3523279-1-yuka@yuka.dev>
References: <20250813200912.3523279-1-yuka@yuka.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test covers basic re-use of a pinned DEVMAP map,
with both matching and mismatching parameters.

Signed-off-by: Yureka Lilian <yuka@yuka.dev>
---
 .../bpf/prog_tests/pinning_devmap_reuse.c     | 68 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_devmap.c | 20 ++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_devmap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c b/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
new file mode 100644
index 000000000..06befb03b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <test_progs.h>
+
+void test_pinning_devmap_reuse(void)
+{
+	const char *pinpath1 = "/sys/fs/bpf/pinmap1";
+	const char *pinpath2 = "/sys/fs/bpf/pinmap2";
+	const char *file = "./test_pinning_devmap.bpf.o";
+	struct bpf_object *obj1 = NULL, *obj2 = NULL;
+	int err;
+	__u32 duration = 0;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+
+	/* load the object a first time */
+	obj1 = bpf_object__open_file(file, NULL);
+	err = libbpf_get_error(obj1);
+	if (CHECK(err, "first open", "err %d\n", err)) {
+		obj1 = NULL;
+		goto out;
+	}
+	err = bpf_object__load(obj1);
+	if (CHECK(err, "first load", "err %d\n", err))
+		goto out;
+
+	/* load the object a second time, re-using the pinned map */
+	obj2 = bpf_object__open_file(file, NULL);
+	if (CHECK(err, "second open", "err %d\n", err)) {
+		obj2 = NULL;
+		goto out;
+	}
+	err = bpf_object__load(obj2);
+	if (CHECK(err, "second load", "err %d\n", err))
+		goto out;
+
+	/* we can close the reference safely without
+	 * the map's refcount falling to 0
+	 */
+	bpf_object__close(obj1);
+	obj1 = NULL;
+
+	/* now, swap the pins */
+	err = renameat2(0, pinpath1, 0, pinpath2, RENAME_EXCHANGE);
+	if (CHECK(err, "swap pins", "err %d\n", err))
+		goto out;
+
+	/* load the object again, this time the re-use should fail */
+	obj1 = bpf_object__open_file(file, NULL);
+	err = libbpf_get_error(obj1);
+	if (CHECK(err, "third open", "err %d\n", err)) {
+		obj1 = NULL;
+		goto out;
+	}
+	err = bpf_object__load(obj1);
+	if (CHECK(err != -EINVAL, "param mismatch load", "err %d\n", err))
+		goto out;
+
+out:
+	unlink(pinpath1);
+	unlink(pinpath2);
+	if (obj1)
+		bpf_object__close(obj1);
+	if (obj2)
+		bpf_object__close(obj2);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_pinning_devmap.c b/tools/testing/selftests/bpf/progs/test_pinning_devmap.c
new file mode 100644
index 000000000..c855f8f87
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_pinning_devmap.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} pinmap1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} pinmap2 SEC(".maps");
-- 
2.50.1


