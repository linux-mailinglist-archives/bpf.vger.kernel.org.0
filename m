Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923D73F8F0E
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243637AbhHZTnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243632AbhHZTnE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s1ZTGe/UoYnoQvh13a27N1ppHSSL1B6a+t6brCKLLcE=;
        b=if83h5QsWY+l1+BQimlcy279ljo2pjV4fU8WehdGO//L38mMuZxYGOa6wgdBnzC8oQ+6VA
        wZjDH/HAht8UVWQn1VUb2neewvD3N+XfXDenPcRUTWqPCXhbPrPYybCXxC+7Xau4+0/cEV
        Gr8J4yP3EoL51WPHoDrlunESInFbfIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-FT84-1_LO86SNdFG0zjxMw-1; Thu, 26 Aug 2021 15:42:13 -0400
X-MC-Unique: FT84-1_LO86SNdFG0zjxMw-1
Received: by mail-wr1-f72.google.com with SMTP id o9-20020a5d6849000000b001574518a85aso1194916wrw.11
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1ZTGe/UoYnoQvh13a27N1ppHSSL1B6a+t6brCKLLcE=;
        b=smMJJdLTMQbxynpZ9FmE1HRvkA8ob3CRw6rlPNMWXNGmtr9NWadpo8mISlAbwvPxEF
         WNTYl+fHQ9430p3ZuYAEWQIBBFL+7Q4z08+OVg6tgjtKBR/T0gQs7Skpn19vHS0ifj9Z
         o1sneys+Mzu7nNhRtMITjIHY4RKsmlhTiqTv8IdvUEuygbu/5tWnETJB/YI4c1W4VHvT
         nw7AJNVq5+mQhlmAYlw7Cn4TcpMkugTvwinV5e42wYTvPuNwXfRPZ55NTPTUNF/xTJSs
         bgSDyVsZ+0UwRiumX9d/dgUdlBTXFRBRYLYKU1m9nyRuXNHlggXfBlWur9+JDVVtZ3m0
         mtMg==
X-Gm-Message-State: AOAM531a2tR1k1/rn9pwQCdrdpDOkKNxjKK+km2jbsG2yuZolzkymjgr
        R+i8eROCV0M5l+8fS3xQMTGvJ5BecVagyIEW9n1o2u5TOHsM0yhSQUtiEEnwu40/Qo55t9FCGYq
        TWYwgh3llq8PF
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr15575546wmq.159.1630006931864;
        Thu, 26 Aug 2021 12:42:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCKcQiJSVwruqkLwerb4RepMP4yAha4C4WOLcw9+AfBwsUrdhovlrq4XZznn+xhUvmxg7e6A==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr15575526wmq.159.1630006931617;
        Thu, 26 Aug 2021 12:42:11 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id f20sm3372228wml.38.2021.08.26.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:42:11 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 27/27] selftests/bpf: Add ret_mod multi func test
Date:   Thu, 26 Aug 2021 21:39:22 +0200
Message-Id: <20210826193922.66204-28-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding extra test to existing modify_return test to
test this with multi func program attached on top
of the modify return program.

Because the supported wildcards do not allow us to
match both bpf_fentry_test* and bpf_modify_return_test,
adding extra code to look it up in kernel's BTF.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/modify_return.c  | 114 +++++++++++++++++-
 .../selftests/bpf/progs/multi_modify_return.c |  17 +++
 2 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/multi_modify_return.c

diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index 97fec70c600b..9876104ad5b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -5,13 +5,100 @@
  */
 
 #include <test_progs.h>
+#include <bpf/btf.h>
 #include "modify_return.skel.h"
+#include "multi_modify_return.skel.h"
 
 #define LOWER(x) ((x) & 0xffff)
 #define UPPER(x) ((x) >> 16)
 
 
-static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
+struct multi_data {
+	struct multi_modify_return *skel;
+	int link_fentry;
+	int link_fexit;
+	__u32 btf_ids[9];
+};
+
+static int multi_btf_ids(struct multi_data *md)
+{
+	__u32 i, nr_types, ids_cnt;
+	struct btf *btf;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return -1;
+
+	nr_types = btf__get_nr_types(btf);
+
+	for (i = 1; i <= nr_types; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *name;
+		bool match;
+
+		if (!btf_is_func(t))
+			continue;
+
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+		match = strncmp(name, "bpf_modify_return_test",
+				sizeof("bpf_modify_return_test") - 1) == 0;
+		match |= strncmp(name, "bpf_fentry_test",
+				 sizeof("bpf_fentry_test") - 1) == 0;
+		if (!match)
+			continue;
+
+		md->btf_ids[ids_cnt] = i;
+		ids_cnt++;
+	}
+
+	btf__free(btf);
+	return ASSERT_EQ(ids_cnt, 9, "multi_btf_ids") ? 0 : -1;
+}
+
+static int multi_attach(struct multi_data *md)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts);
+	int prog_fd;
+
+	md->skel = multi_modify_return__open_and_load();
+	if (!ASSERT_OK_PTR(md->skel, "multi_attach_check__load"))
+		return -1;
+
+	opts.multi.btf_ids = md->btf_ids;
+	opts.multi.btf_ids_cnt = 9;
+
+	prog_fd = bpf_program__fd(md->skel->progs.test1);
+
+	md->link_fentry = bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY, &opts);
+	if (!ASSERT_GE(md->link_fentry, 0, "bpf_link_create"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(md->skel->progs.test2);
+
+	md->link_fexit = bpf_link_create(prog_fd, 0, BPF_TRACE_FEXIT, &opts);
+	if (!ASSERT_GE(md->link_fexit, 0, "bpf_link_create"))
+		goto cleanup_close;
+
+	return 0;
+
+cleanup_close:
+	close(md->link_fentry);
+cleanup:
+	multi_modify_return__destroy(md->skel);
+	return -1;
+}
+
+static void multi_detach(struct multi_data *md)
+{
+	close(md->link_fentry);
+	close(md->link_fexit);
+	multi_modify_return__destroy(md->skel);
+}
+
+static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret,
+		     struct multi_data *md)
 {
 	struct modify_return *skel = NULL;
 	int err, prog_fd;
@@ -27,6 +114,9 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	if (CHECK(err, "modify_return", "attach failed: %d\n", err))
 		goto cleanup;
 
+	if (md && !ASSERT_OK(multi_attach(md), "multi_attach"))
+		goto cleanup;
+
 	skel->bss->input_retval = input_retval;
 	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0, NULL, 0,
@@ -49,17 +139,35 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	CHECK(skel->bss->fmod_ret_result != 1, "modify_return",
 	      "fmod_ret failed\n");
 
+	if (md)
+		multi_detach(md);
 cleanup:
 	modify_return__destroy(skel);
 }
 
 void test_modify_return(void)
 {
+	struct multi_data data = {};
+
+	run_test(0 /* input_retval */,
+		 1 /* want_side_effect */,
+		 4 /* want_ret */,
+		 NULL /* no multi func test */);
+	run_test(-EINVAL /* input_retval */,
+		 0 /* want_side_effect */,
+		 -EINVAL /* want_ret */,
+		 NULL /* no multi func test */);
+
+	if (!ASSERT_OK(multi_btf_ids(&data), "multi_attach"))
+		return;
+
 	run_test(0 /* input_retval */,
 		 1 /* want_side_effect */,
-		 4 /* want_ret */);
+		 4 /* want_ret */,
+		 &data);
 	run_test(-EINVAL /* input_retval */,
 		 0 /* want_side_effect */,
-		 -EINVAL /* want_ret */);
+		 -EINVAL /* want_ret */,
+		 &data);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/multi_modify_return.c b/tools/testing/selftests/bpf/progs/multi_modify_return.c
new file mode 100644
index 000000000000..34754e438c96
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/multi_modify_return.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+SEC("fentry.multi/bpf_fentry_test*")
+int BPF_PROG(test1, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	return 0;
+}
+
+SEC("fexit.multi/bpf_fentry_test*")
+int BPF_PROG(test2, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f, int ret)
+{
+	return 0;
+}
-- 
2.31.1

