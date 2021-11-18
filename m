Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF4455A62
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbhKRLct (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344060AbhKRLat (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5EJllEejN/3GIbtkSvycpDyvI7AcT8mw9dELbI2aqcU=;
        b=JuurTmzRkzrFDXWQ9ksujEsI4V+UpkI4A7+weCEWj/rTmy4jP8PHc4vqH1jXaSpF2YYAq3
        /ljXfW4mgiT3e25W9+vPcfX5tMjhtk1ZkueUhNRmClp1L0pVOmaNjOgMpaSdwI41a2TUnG
        0B5eXlAsHvoCv3LBRHapEbCBP+P1G7k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-ZnevfoZLOGCpb3uW9uNPiw-1; Thu, 18 Nov 2021 06:27:47 -0500
X-MC-Unique: ZnevfoZLOGCpb3uW9uNPiw-1
Received: by mail-ed1-f69.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso5009510edj.13
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EJllEejN/3GIbtkSvycpDyvI7AcT8mw9dELbI2aqcU=;
        b=WCkZpj3rp5J5TB+wOfmuvDXMUTtNcEZ+SZwi25rI8GDg6tmMqFPDIvJdoP6CDKUyFl
         24jctOGOLRIoN4XqSaAAO+rLDcRNytfmp1dBDFmUmAFeM96CJpmF169WGZYUW3qkLcdW
         wMB42I5OoO71eN6cqqUYnPFwV+7Cjo7LsbVO35vVMz043iZDKhluQC3xLKLkS+P5Elcl
         sJj6Pb3s5t2EN7eGjIHwBTndfTfonR5Y3CU7LmQw5X+4WIUQg94chhN5dkuoxAK70H9F
         /FgSkvh6rMywltLLAKhSVwlmq9OPeCp3K65J23Mc4qhSRizABlmhKDyqDf6dfJZPk4TF
         DguQ==
X-Gm-Message-State: AOAM532almr/3qVqWPrbY32w6ZuWp7TjVbjqf8cUTAK7T73djmsg/pU4
        WpXm2ZkPZ2Ursq+CyQQvsvupnlqZKyYUeBay/vMFMU+Qs6eHHv/HTUAseMznnsR4MhA1QwNEjww
        kgvTnETpD9f2Z
X-Received: by 2002:a05:6402:5158:: with SMTP id n24mr9903603edd.230.1637234866208;
        Thu, 18 Nov 2021 03:27:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjPu4vHCTfCb99ok+0tGXBYvYBwTiNwDraYicGV6XtI232nyS+/2MLQMyBi0gpPqy6ey/I7w==
X-Received: by 2002:a05:6402:5158:: with SMTP id n24mr9903578edd.230.1637234866068;
        Thu, 18 Nov 2021 03:27:46 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id x7sm1054136edd.28.2021.11.18.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:27:45 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 28/29] selftests/bpf: Add ret_mod multi func test
Date:   Thu, 18 Nov 2021 12:24:54 +0100
Message-Id: <20211118112455.475349-29-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
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
index b772fe30ce9b..ffb0be7ea5a5 100644
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
@@ -49,6 +139,8 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	CHECK(skel->bss->fmod_ret_result != 1, "modify_return",
 	      "fmod_ret failed\n");
 
+	if (md)
+		multi_detach(md);
 cleanup:
 	modify_return__destroy(skel);
 }
@@ -56,11 +148,27 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 /* TODO: conflict with get_func_ip_test */
 void serial_test_modify_return(void)
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

