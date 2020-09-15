Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD12126B8BD
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 02:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIPAtp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 20:49:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53194 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726416AbgIOLlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 07:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600170069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ist6ICOumSRBraLgSW7wo1uwMrtCf6dm1hc1MMJ+rlY=;
        b=JIq3gdvON6Io2aEwT/hrvI0hdRy9R7mJ/DR/zFp/HhGvTRiKO4qIEpx8BALJ4VEHp6pesB
        kzD8VcqmK9iUMm+QiORziHsMvki9qMOTXvEQulrHk7I9GVgtyP/XdteJM0b2rrvJYC45Sf
        l3jrsexxFnLtLUKUWiJdFV3Bnw8Os8w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-5qorGvn6Nduq9h1kngkTmQ-1; Tue, 15 Sep 2020 07:41:08 -0400
X-MC-Unique: 5qorGvn6Nduq9h1kngkTmQ-1
Received: by mail-ej1-f72.google.com with SMTP id m24so1162678ejr.9
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 04:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ist6ICOumSRBraLgSW7wo1uwMrtCf6dm1hc1MMJ+rlY=;
        b=nhH6VQm5iTM18QqIdWd8GQl3b8ltwfg2QuL5aFqnBV4Co6oBV2qAEzTEzEaH2GmYi2
         RCEkSzEqnFGCr7gQFVjDNKXrGnhnhb7QR1rhzSiVfYXarsfV/o16zWMoiWIK48D3iKPW
         guNyRf0ue1V+Vwteu5UeVZChFjoyYOmRu7KRgHZxZAhRmL4ZpDX2oneMGfKz6Zh9b6bl
         wQR0JCCJCiwsExrAQOgBpg6OZBGNEjevQkrfxlbAjMX9nXdNzmj3F3lq9spSlM00rfr6
         vNoke2GKynTPQmrnFxaOHFwTyIlpneDZz5Vs3RmLVFZKMRLhvYi86CxwPvMg4nDt8l2m
         nbrw==
X-Gm-Message-State: AOAM531vviElUQlm2+bdg8BMxRbud4mjY/Z3EALEQmjik8k2vLvt6bnP
        9tZu4s/09kxni0EA935yTFGVjg3i03Yp/e/KK3FF82zNSHb4QTmq4SebEkYAtJvYntIhRNiRHZZ
        gG2WRvRpIBThH
X-Received: by 2002:a05:6402:1859:: with SMTP id v25mr22261142edy.118.1600170066911;
        Tue, 15 Sep 2020 04:41:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQWkToaB6AbD5lnEP8upIc1ncP3zVhO2kamQLiOQv66zji1ipSiuUyuaFD2vsy03/ZCKNOFw==
X-Received: by 2002:a05:6402:1859:: with SMTP id v25mr22261113edy.118.1600170066657;
        Tue, 15 Sep 2020 04:41:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id dt8sm9615308ejc.113.2020.09.15.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:41:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CE5A21829CB; Tue, 15 Sep 2020 13:41:05 +0200 (CEST)
Subject: [PATCH bpf-next v5 8/8] selftests/bpf: Adding test for arg
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
Date:   Tue, 15 Sep 2020 13:41:05 +0200
Message-ID: <160017006573.98230.17217160170336621916.stgit@toke.dk>
In-Reply-To: <160017005691.98230.13648200635390228683.stgit@toke.dk>
References: <160017005691.98230.13648200635390228683.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/trace_ext.c |  113 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_trace_ext.c |   18 +++
 .../selftests/bpf/progs/test_trace_ext_tracing.c   |   25 ++++
 3 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/trace_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_ext.c b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
new file mode 100644
index 000000000000..49b554f560a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
@@ -0,0 +1,113 @@
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
+	CHECK(err || retval, "",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
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

