Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B610279362
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgIYVZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 17:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729676AbgIYVZP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Sep 2020 17:25:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601069113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clygwoJ1f9sZLqUhcfeUO7K+/N8tqwPrjcsYeSe/dUM=;
        b=WafvvhI/JVhyrmSgzpOKbdRqkWKBUh7jJ5pomyz+nPWnFHCGoO3PwmgRqhTF3QLP/F9ibR
        +N2Ua0ok4UmDEZjO4e2b3ysJwZrTW6Tk96dE0hdYenXlvpsEMziJChUYVchiVGexIOS/fL
        RB4XUkUYNiGg1iwT7lyiOGOqVjMbX48=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-CDPyqZK7OoyQs6oZ680rIQ-1; Fri, 25 Sep 2020 17:25:11 -0400
X-MC-Unique: CDPyqZK7OoyQs6oZ680rIQ-1
Received: by mail-wr1-f69.google.com with SMTP id d13so1560749wrr.23
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 14:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=clygwoJ1f9sZLqUhcfeUO7K+/N8tqwPrjcsYeSe/dUM=;
        b=hxP0fmIuW9P10ybLUbRzeaP+qrjgZDiklvKe/1qEtQRpp238lRVobAlvV0D/s/9ufy
         x6Vszv3FJeFnkSvoLMH08eyWxpCt0jNoOMFv30EghyuoC5u2xhkp8/cybGpmScOE40jC
         8yueHb4QjyxVQl2vWLbrY7aaAuEzKbXRVmEYM8RbNz5+FeNCOuHWJ/oAdZT28G2JVGlX
         /+tMxyrBauMwHuJxdFkK3UL6Ma2TGbx/bS4ogmpaERj/n6jTq8Xjy8YzrXwf6dysOuB6
         dmUejXKBRRdANhcVIs5BIchpuQwp2ZAzBzeuckH+htlQ17qxU0sCBFfMlnQRNR1VgbMd
         reXA==
X-Gm-Message-State: AOAM530xfIoHR4Xq6JyHrDoxY3dzrWtEoYyNKAxzlFqSjwFOcf6iWTNS
        k0hF1IWJD/TG9VEa/fLbv+QYhbTgloBO9E6hYNKwj87m1eQDiFVoBGiovl+w0swgTS1Cr/a0cIP
        1x0Q4ZdI8j5DR
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr6406510wrt.196.1601069110431;
        Fri, 25 Sep 2020 14:25:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdU1D9isQu44sPuKMZtYea1o9hejuq/1wvwmgX8WXrHg4Y4Xb1C2BSvOonMlfhPzPa5/r2PQ==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr6406490wrt.196.1601069110228;
        Fri, 25 Sep 2020 14:25:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c205sm294450wmd.33.2020.09.25.14.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:25:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 107B6183C5B; Fri, 25 Sep 2020 23:25:09 +0200 (CEST)
Subject: [PATCH bpf-next v9 09/11] selftests/bpf: Adding test for arg
 dereference in extension trace
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 25 Sep 2020 23:25:09 +0200
Message-ID: <160106910903.27725.6944140740491754073.stgit@toke.dk>
In-Reply-To: <160106909952.27725.8383447127582216829.stgit@toke.dk>
References: <160106909952.27725.8383447127582216829.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding test that setup following program:

  SEC("classifier/test_pkt_md_access")
  int test_pkt_md_access(struct __sk_buff *skb)

with its extension:

  SEC("freplace/test_pkt_md_access")
  int test_pkt_md_access_new(struct __sk_buff *skb)

and tracing that extension with:

  SEC("fentry/test_pkt_md_access_new")
  int BPF_PROG(fentry, struct sk_buff *skb)

The test verifies that the tracing program can
dereference skb argument properly.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/trace_ext.c |  111 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_trace_ext.c |   18 +++
 .../selftests/bpf/progs/test_trace_ext_tracing.c   |   25 +++++
 3 files changed, 154 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/trace_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_ext.c b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
new file mode 100644
index 000000000000..924441d4362d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <sys/stat.h>
+#include <linux/sched.h>
+#include <sys/syscall.h>
+
+#include "test_pkt_md_access.skel.h"
+#include "test_trace_ext.skel.h"
+#include "test_trace_ext_tracing.skel.h"
+
+static __u32 duration;
+
+void test_trace_ext(void)
+{
+	struct test_pkt_md_access *skel_pkt = NULL;
+	struct test_trace_ext_tracing *skel_trace = NULL;
+	struct test_trace_ext_tracing__bss *bss_trace;
+	struct test_trace_ext *skel_ext = NULL;
+	struct test_trace_ext__bss *bss_ext;
+	int err, pkt_fd, ext_fd;
+	struct bpf_program *prog;
+	char buf[100];
+	__u32 retval;
+	__u64 len;
+
+	/* open/load/attach test_pkt_md_access */
+	skel_pkt = test_pkt_md_access__open_and_load();
+	if (CHECK(!skel_pkt, "setup", "classifier/test_pkt_md_access open failed\n"))
+		goto cleanup;
+
+	err = test_pkt_md_access__attach(skel_pkt);
+	if (CHECK(err, "setup", "classifier/test_pkt_md_access attach failed: %d\n", err))
+		goto cleanup;
+
+	prog = skel_pkt->progs.test_pkt_md_access;
+	pkt_fd = bpf_program__fd(prog);
+
+	/* open extension */
+	skel_ext = test_trace_ext__open();
+	if (CHECK(!skel_ext, "setup", "freplace/test_pkt_md_access open failed\n"))
+		goto cleanup;
+
+	/* set extension's attach target - test_pkt_md_access  */
+	prog = skel_ext->progs.test_pkt_md_access_new;
+	bpf_program__set_attach_target(prog, pkt_fd, "test_pkt_md_access");
+
+	/* load/attach extension */
+	err = test_trace_ext__load(skel_ext);
+	if (CHECK(err, "setup", "freplace/test_pkt_md_access load failed\n")) {
+		libbpf_strerror(err, buf, sizeof(buf));
+		fprintf(stderr, "%s\n", buf);
+		goto cleanup;
+	}
+
+	err = test_trace_ext__attach(skel_ext);
+	if (CHECK(err, "setup", "freplace/test_pkt_md_access attach failed: %d\n", err))
+		goto cleanup;
+
+	prog = skel_ext->progs.test_pkt_md_access_new;
+	ext_fd = bpf_program__fd(prog);
+
+	/* open tracing  */
+	skel_trace = test_trace_ext_tracing__open();
+	if (CHECK(!skel_trace, "setup", "tracing/test_pkt_md_access_new open failed\n"))
+		goto cleanup;
+
+	/* set tracing's attach target - fentry */
+	prog = skel_trace->progs.fentry;
+	bpf_program__set_attach_target(prog, ext_fd, "test_pkt_md_access_new");
+
+	/* set tracing's attach target - fexit */
+	prog = skel_trace->progs.fexit;
+	bpf_program__set_attach_target(prog, ext_fd, "test_pkt_md_access_new");
+
+	/* load/attach tracing */
+	err = test_trace_ext_tracing__load(skel_trace);
+	if (CHECK(err, "setup", "tracing/test_pkt_md_access_new load failed\n")) {
+		libbpf_strerror(err, buf, sizeof(buf));
+		fprintf(stderr, "%s\n", buf);
+		goto cleanup;
+	}
+
+	err = test_trace_ext_tracing__attach(skel_trace);
+	if (CHECK(err, "setup", "tracing/test_pkt_md_access_new attach failed: %d\n", err))
+		goto cleanup;
+
+	/* trigger the test */
+	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "run", "err %d errno %d retval %d\n", err, errno, retval);
+
+	bss_ext = skel_ext->bss;
+	bss_trace = skel_trace->bss;
+
+	len = bss_ext->ext_called;
+
+	CHECK(bss_ext->ext_called == 0,
+		"check", "failed to trigger freplace/test_pkt_md_access\n");
+	CHECK(bss_trace->fentry_called != len,
+		"check", "failed to trigger fentry/test_pkt_md_access_new\n");
+	CHECK(bss_trace->fexit_called != len,
+		"check", "failed to trigger fexit/test_pkt_md_access_new\n");
+
+cleanup:
+	test_trace_ext_tracing__destroy(skel_trace);
+	test_trace_ext__destroy(skel_ext);
+	test_pkt_md_access__destroy(skel_pkt);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_trace_ext.c b/tools/testing/selftests/bpf/progs/test_trace_ext.c
new file mode 100644
index 000000000000..d19a634d0e78
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_trace_ext.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+#include <linux/bpf.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+
+__u64 ext_called = 0;
+
+SEC("freplace/test_pkt_md_access")
+int test_pkt_md_access_new(struct __sk_buff *skb)
+{
+	ext_called = skb->len;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c b/tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c
new file mode 100644
index 000000000000..52f3baf98f20
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u64 fentry_called = 0;
+
+SEC("fentry/test_pkt_md_access_new")
+int BPF_PROG(fentry, struct sk_buff *skb)
+{
+	fentry_called = skb->len;
+	return 0;
+}
+
+__u64 fexit_called = 0;
+
+SEC("fexit/test_pkt_md_access_new")
+int BPF_PROG(fexit, struct sk_buff *skb)
+{
+	fexit_called = skb->len;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

