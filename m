Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44872646E1
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 15:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgIJNYk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 09:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730650AbgIJNKx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 09:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599743404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxoWDrTG5yV8ILjFLjzLOABm6GkXZ8lP0vOJBmq5UxE=;
        b=aPx1hIcDkXOIh2z4ok+W0oKce/mC8wajQg5SFdLEVUjgBc4tH/iamO18KTH+3Uthp9KHSr
        eBcCViYYxsqvfAKeuzbxU+bu+8PDosUE/eUtx+iz4HxjlzdAhmAugu2tOarNF1+GwZE6Wr
        hkItFJU2+vZoKhO/aFzYsT2p+XhKtjk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-o2_mHB0dPsC9E2dc9ln-1g-1; Thu, 10 Sep 2020 09:10:03 -0400
X-MC-Unique: o2_mHB0dPsC9E2dc9ln-1g-1
Received: by mail-wr1-f71.google.com with SMTP id n15so2220732wrv.23
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 06:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VxoWDrTG5yV8ILjFLjzLOABm6GkXZ8lP0vOJBmq5UxE=;
        b=GMS/rP7LkREJ6yd6oQFtRLBsN6w2gQISunU0sQM9h/idInIv57Dp9kqzPEGuc169xB
         yHacrlXVGqmFbMMKOiyHzE7IjZ/Ejnw1/nve1mPpYr0eCDI4LnmiQcB+AIT0Ck3wLpWM
         mL12Qd3PzXuSGfmntOycVKkWXIM4Xagdn58xxAlfw6JNRUDmU4JkYumqMphvRekKhV5M
         kAJerhX5soobzWJCDmmZgD6a1qGvzWLf2NqT3lONmSqc4sUjKbnzkcqyxWU5WHdCLAN8
         YltjO5kNgzihIVKjYdNiBDu24uawUI+v13Am6fyVOFEuaqbObgqZj+rej9QIjcs0rVRR
         tIQQ==
X-Gm-Message-State: AOAM5333ocnL1HEqA+6IaS0PpJI1Mr/gz+pCvVS61/2E0X/EF6PatNch
        bIf2DKKm4STvOyFp+SH0z16em10C+I1HdC+cnJisyiSKFPVxB5XJJw/VnQqZR0nbkq+YJdR14p4
        k0i6aT9v0Eex2
X-Received: by 2002:adf:e481:: with SMTP id i1mr8810700wrm.391.1599743401686;
        Thu, 10 Sep 2020 06:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDH0rsLUEvTJsJA6cwWs9Kf3LpGyuHRCy9tgmpbTUrEU6Vc0CvgUB/7HdPrrvhEQyW+wMT4A==
X-Received: by 2002:adf:e481:: with SMTP id i1mr8810644wrm.391.1599743401070;
        Thu, 10 Sep 2020 06:10:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t188sm3803408wmf.41.2020.09.10.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:10:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6C2481829D4; Thu, 10 Sep 2020 15:09:59 +0200 (CEST)
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Adding test for arg
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
Date:   Thu, 10 Sep 2020 15:09:59 +0200
Message-ID: <159974339934.129227.6311067668742466993.stgit@toke.dk>
In-Reply-To: <159974338947.129227.5610774877906475683.stgit@toke.dk>
References: <159974338947.129227.5610774877906475683.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
---
 tools/testing/selftests/bpf/prog_tests/trace_ext.c |   93 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_trace_ext.c |   18 ++++
 .../selftests/bpf/progs/test_trace_ext_tracing.c   |   25 +++++
 3 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/trace_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_ext.c b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
new file mode 100644
index 000000000000..1089dafb4653
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <sys/stat.h>
+#include <linux/sched.h>
+#include <sys/syscall.h>
+
+#include "test_trace_ext.skel.h"
+#include "test_trace_ext_tracing.skel.h"
+
+static __u32 duration;
+
+void test_trace_ext(void)
+{
+	struct test_trace_ext_tracing *skel_trace = NULL;
+	struct test_trace_ext_tracing__bss *bss_trace;
+	const char *file = "./test_pkt_md_access.o";
+	struct test_trace_ext *skel_ext = NULL;
+	struct test_trace_ext__bss *bss_ext;
+	int err, prog_fd, ext_fd;
+	struct bpf_object *obj;
+	char buf[100];
+	__u32 retval;
+	__u64 len;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
+	if (CHECK_FAIL(err))
+		return;
+
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+			    .attach_prog_fd = prog_fd,
+	);
+
+	skel_ext = test_trace_ext__open_opts(&opts);
+	if (CHECK(!skel_ext, "setup", "freplace/test_pkt_md_access open failed\n"))
+		goto cleanup;
+
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
+	ext_fd = bpf_program__fd(skel_ext->progs.test_pkt_md_access_new);
+
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts_trace,
+			    .attach_prog_fd = ext_fd,
+	);
+
+	skel_trace = test_trace_ext_tracing__open_opts(&opts_trace);
+	if (CHECK(!skel_trace, "setup", "tracing/test_pkt_md_access_new open failed\n"))
+		goto cleanup;
+
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
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
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
+	test_trace_ext__destroy(skel_ext);
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_trace_ext.c b/tools/testing/selftests/bpf/progs/test_trace_ext.c
new file mode 100644
index 000000000000..a6318f6b52ee
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
+volatile __u64 ext_called = 0;
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
index 000000000000..9e52a831446f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+volatile __u64 fentry_called = 0;
+
+SEC("fentry/test_pkt_md_access_new")
+int BPF_PROG(fentry, struct sk_buff *skb)
+{
+	fentry_called = skb->len;
+	return 0;
+}
+
+volatile __u64 fexit_called = 0;
+
+SEC("fexit/test_pkt_md_access_new")
+int BPF_PROG(fexit, struct sk_buff *skb)
+{
+	fexit_called = skb->len;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

