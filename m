Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4844F349B74
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 22:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhCYVMH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 17:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhCYVLv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 17:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616706711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlGDo/RcYeA5m4cect+KpXswi7G/nCn2CqYsQ+YjVg0=;
        b=Z9ebUxyFw0xUh9YNm1p735Ybb8H+VAFU4qCLAgmpwFtZe6YfdhyADRorrU0Y6XP141DIBo
        RHGD6iYtN3DbdoH75Vzpfhet1zllAoZhY0vsCV104pBValS6xibf4YcwmjcjnQ911FQkUt
        oMOVJRJY/wx3UA0SDdpguCrBEmiIwZo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-_214n4EjOtWcYe36NkLWjg-1; Thu, 25 Mar 2021 17:11:48 -0400
X-MC-Unique: _214n4EjOtWcYe36NkLWjg-1
Received: by mail-ej1-f70.google.com with SMTP id gv58so3177356ejc.6
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 14:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlGDo/RcYeA5m4cect+KpXswi7G/nCn2CqYsQ+YjVg0=;
        b=JNgu6GtddJpH/0XTcrbEulv1cMgcrRa3L0tGFNhwY8gdjM2ewLjwKzWxfTJxMGCq1R
         kBAlBXO0tkJXMEhnvMwaYgBE7UWIlX1hJW6kGbhW5H2g82XV0JX/HH/4NPgC+o9G19BN
         nVZvYZo44VZClStJGR9RllKvX0ghLfJvDK7PCS9zbC1S757qao9Xj4AXSM1y1cAWDGtW
         OxQEhaj7KJgdAwPkggCT4RtD8gzN3Qt2iWD6ETzujYls/IK1Sd4yzqKxThDeETOiE408
         qhuiaPtb0GGYITvryGZP+dKpR+eNDj3v+8BCUppVzDsIqbiwpn9mbq+/6kaseoZOqejJ
         1Z9w==
X-Gm-Message-State: AOAM530I8XCB1bdL309wJejt5dJGfT3ocWzJxa15VKPj7t0Vx40ybwer
        EMFqkeviVIkaRXmc6XsddMyZVtbSdjXUCy2kvSNkvlf7I+KBjK5yyaGskc0f8OGg35HqmfFPgRs
        CW0OD4dWfTYhT
X-Received: by 2002:a17:907:b06:: with SMTP id h6mr11721525ejl.144.1616706706828;
        Thu, 25 Mar 2021 14:11:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV91xj7stafOjFdpFlgWeWMBqeffBoCSoVClDRD7zgxzF+eMvN86Tz0UAKzI4F3xrZuBWPHg==
X-Received: by 2002:a17:907:b06:: with SMTP id h6mr11721476ejl.144.1616706706281;
        Thu, 25 Mar 2021 14:11:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k12sm3208706edo.50.2021.03.25.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 14:11:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 59DD11801A3; Thu, 25 Mar 2021 22:11:45 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Clark Williams <williams@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf/selftests: test that kernel rejects a TCP CC with an invalid license
Date:   Thu, 25 Mar 2021 22:11:22 +0100
Message-Id: <20210325211122.98620-2-toke@redhat.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210325211122.98620-1-toke@redhat.com>
References: <20210325211122.98620-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a selftest to check that the verifier rejects a TCP CC struct_ops
with a non-GPL license.

v2:
- Use a minimal struct_ops BPF program instead of rewriting bpf_dctcp's
  license in memory.
- Check for the verifier reject message instead of just the return code.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 44 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_nogpltcp.c        | 19 ++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_nogpltcp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 37c5494a0381..a09c716528e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -6,6 +6,7 @@
 #include <test_progs.h>
 #include "bpf_dctcp.skel.h"
 #include "bpf_cubic.skel.h"
+#include "bpf_nogpltcp.skel.h"
 
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
@@ -227,10 +228,53 @@ static void test_dctcp(void)
 	bpf_dctcp__destroy(dctcp_skel);
 }
 
+static char *err_str = NULL;
+static bool found = false;
+
+static int libbpf_debug_print(enum libbpf_print_level level,
+			      const char *format, va_list args)
+{
+	char *log_buf;
+
+	if (level != LIBBPF_WARN ||
+	    strcmp(format, "libbpf: \n%s\n")) {
+		vprintf(format, args);
+		return 0;
+	}
+
+	log_buf = va_arg(args, char *);
+	if (!log_buf)
+		goto out;
+	if (err_str && strstr(log_buf, err_str) != NULL)
+		found = true;
+out:
+	printf(format, log_buf);
+	return 0;
+}
+
+static void test_invalid_license(void)
+{
+	libbpf_print_fn_t old_print_fn = NULL;
+	struct bpf_nogpltcp *skel;
+
+	err_str = "struct ops programs must have a GPL compatible license";
+	old_print_fn = libbpf_set_print(libbpf_debug_print);
+
+	skel = bpf_nogpltcp__open_and_load();
+	if (CHECK(skel, "bpf_nogplgtcp__open_and_load()", "didn't fail\n"))
+		bpf_nogpltcp__destroy(skel);
+
+	CHECK(!found, "errmsg check", "expected string '%s'", err_str);
+
+	libbpf_set_print(old_print_fn);
+}
+
 void test_bpf_tcp_ca(void)
 {
 	if (test__start_subtest("dctcp"))
 		test_dctcp();
 	if (test__start_subtest("cubic"))
 		test_cubic();
+	if (test__start_subtest("invalid_license"))
+		test_invalid_license();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_nogpltcp.c b/tools/testing/selftests/bpf/progs/bpf_nogpltcp.c
new file mode 100644
index 000000000000..2ecd833dcd41
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_nogpltcp.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "X";
+
+void BPF_STRUCT_OPS(nogpltcp_init, struct sock *sk)
+{
+}
+
+SEC(".struct_ops")
+struct tcp_congestion_ops bpf_nogpltcp = {
+	.init           = (void *)nogpltcp_init,
+	.name           = "bpf_nogpltcp",
+};
-- 
2.31.0

