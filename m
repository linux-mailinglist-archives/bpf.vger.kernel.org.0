Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB9142421D
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhJFQEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhJFQEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 12:04:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12287C061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 09:03:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so2839226pgu.13
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXH1xXwANkEkMk5xSeRQcDW2a2cM2/Gh6zLAoIsLD9U=;
        b=BJqs5wldx3tul/E5oCCclzRw6Mw0p74UnU1ehA+cRK6IZ7998IDtD512N2ESzauEK4
         EzzhD8GgNSgpOjx/qi+K+t9v0BbV+NVapc+UzALJKwopr4wUoYRhEYP4b44CRhZBMxd8
         KhyNjY5aOVmsxuKfjXDWeeXIjmDvTuDAugXs91hS2lrmlUDypwC7/e6dNgzwLkp7lmiI
         /fnq8HYrtAQadxY9Q1sRDY/B71TjQntxdQlmw3sETTNMES31YOtjb2xafSFVahiRl1u/
         aMXq91MkZl3sDWz/vhdtr0cI6w2lDZOc/pcPnBcpbwTokyqJWRzJUyhyQAPJqQ0tcwnf
         nMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXH1xXwANkEkMk5xSeRQcDW2a2cM2/Gh6zLAoIsLD9U=;
        b=XYziUbt4tWVeef+Kgws4v35poQSbt41wAzok/X+L50+2W8bEyT6kW37+4EbQ7T+yAy
         WHov8CZvNnIwPmNJKk96lWIxWq/vNJXRArRah/Zme9ftU7T+mHZs8yaBVKkSB52lWgCQ
         vWeYHcK8LfxaV95Z5VpSnopX4BOGGB3JS+u8mt+0EAcg7L3VCF1/EAsduJwWWwhyLyK2
         GKxXprutiOq81kb01ozcWLRA/Ndaz/Rg+CSBCh3pNv3IrTEUrYxrnTs7bLr8Yxfnfbcy
         IOicb25CFditN+8Q5bjKoim8og/D9v97WooSph0eGtGxkw2T4n5AlWB/GO/3mNT5ef4A
         pRbg==
X-Gm-Message-State: AOAM530StuDYbnFu/KQ1lyNBMCPJX/Av6rr8WglocR0V280t6U2OiFcn
        Ex/S4Wr1tCECos/6ycZytj0nH6FGk2Y=
X-Google-Smtp-Source: ABdhPJy8b/0ZbmEMJkl97JI3FWf7uFRNXhkHRcoT+Cn/10fMlDUOuWfUlPsw05FXWv17xuBp6wXlNA==
X-Received: by 2002:a62:3893:0:b0:44b:9369:5de5 with SMTP id f141-20020a623893000000b0044b93695de5mr36647346pfa.40.1633536182212;
        Wed, 06 Oct 2021 09:03:02 -0700 (PDT)
Received: from localhost.localdomain ([98.47.144.235])
        by smtp.gmail.com with ESMTPSA id x19sm20906098pfn.105.2021.10.06.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:03:01 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test bpf_export_errno behavior with cgroup/sockopt
Date:   Wed,  6 Oct 2021 09:02:42 -0700
Message-Id: <ee26bf5f68535bdb902b711a36f6334fad36d58d.1633535940.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633535940.git.zhuyifei@google.com>
References: <cover.1633535940.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

The tests checks how different ways of interacting with the helper
(getting errno, setting EUNATCH, EISCONN, and legacy reject
returning 0 without setting errno), produce different results in
both the setsockopt syscall and the errno value returned by the
helper. A few more tests verify the interaction between the
exported errno and the retval in getsockopt context.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/cgroup_export_errno.c      | 472 ++++++++++++++++++
 .../progs/cgroup_export_errno_getsockopt.c    |  45 ++
 .../progs/cgroup_export_errno_setsockopt.c    |  52 ++
 3 files changed, 569 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_export_errno.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_export_errno_getsockopt.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_export_errno_setsockopt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_export_errno.c b/tools/testing/selftests/bpf/prog_tests/cgroup_export_errno.c
new file mode 100644
index 000000000000..c472267f8427
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_export_errno.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2021 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include <network_helpers.h>
+
+#include "cgroup_export_errno_setsockopt.skel.h"
+#include "cgroup_export_errno_getsockopt.skel.h"
+
+#define SOL_CUSTOM	0xdeadbeef
+
+static int zero;
+
+static void test_setsockopt_set(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_setsockopt *obj;
+	struct bpf_link *link_set_eunatch = NULL;
+
+	obj = cgroup_export_errno_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that sets EUNATCH, assert that
+	 * we actually get that error when we run setsockopt()
+	 */
+	link_set_eunatch = bpf_program__attach_cgroup(obj->progs.set_eunatch,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eunatch, "cg-attach-set_eunatch"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
+				   &zero, sizeof(int)), "setsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EUNATCH, "setsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 1, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eunatch);
+
+	cgroup_export_errno_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_set_and_get(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_setsockopt *obj;
+	struct bpf_link *link_set_eunatch = NULL, *link_get_errno = NULL;
+
+	obj = cgroup_export_errno_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that sets EUNATCH, and one that gets the
+	 * previously set errno. Assert that we get the same errno back.
+	 */
+	link_set_eunatch = bpf_program__attach_cgroup(obj->progs.set_eunatch,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eunatch, "cg-attach-set_eunatch"))
+		goto close_bpf_object;
+	link_get_errno = bpf_program__attach_cgroup(obj->progs.get_errno,
+						    cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_errno, "cg-attach-get_errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
+				   &zero, sizeof(int)), "setsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EUNATCH, "setsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 2, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->errno_value, EUNATCH, "errno_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eunatch);
+	bpf_link__destroy(link_get_errno);
+
+	cgroup_export_errno_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_default_zero(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_setsockopt *obj;
+	struct bpf_link *link_get_errno = NULL;
+
+	obj = cgroup_export_errno_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that gets the previously set errno.
+	 * Assert that, without anything setting one, we get 0.
+	 */
+	link_get_errno = bpf_program__attach_cgroup(obj->progs.get_errno,
+						    cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_errno, "cg-attach-get_errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_OK(setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
+				  &zero, sizeof(int)), "setsockopt"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 1, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->errno_value, 0, "errno_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_get_errno);
+
+	cgroup_export_errno_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_default_zero_and_set(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_setsockopt *obj;
+	struct bpf_link *link_get_errno = NULL, *link_set_eunatch = NULL;
+
+	obj = cgroup_export_errno_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that gets the previously set errno, and then
+	 * one that sets the errno to EUNATCH. Assert that the get does not
+	 * see EUNATCH set later, and does not prevent EUNATCH from being set.
+	 */
+	link_get_errno = bpf_program__attach_cgroup(obj->progs.get_errno,
+						    cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_errno, "cg-attach-get_errno"))
+		goto close_bpf_object;
+	link_set_eunatch = bpf_program__attach_cgroup(obj->progs.set_eunatch,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eunatch, "cg-attach-set_eunatch"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
+				   &zero, sizeof(int)), "setsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EUNATCH, "setsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 2, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->errno_value, 0, "errno_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_get_errno);
+	bpf_link__destroy(link_set_eunatch);
+
+	cgroup_export_errno_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_override(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_setsockopt *obj;
+	struct bpf_link *link_set_eunatch = NULL, *link_set_eisconn = NULL;
+	struct bpf_link *link_get_errno = NULL;
+
+	obj = cgroup_export_errno_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that sets EUNATCH, then one that sets EISCONN,
+	 * and then one that gets the exported errno. Assert both the syscall
+	 * and the helper sees the last set errno.
+	 */
+	link_set_eunatch = bpf_program__attach_cgroup(obj->progs.set_eunatch,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eunatch, "cg-attach-set_eunatch"))
+		goto close_bpf_object;
+	link_set_eisconn = bpf_program__attach_cgroup(obj->progs.set_eisconn,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eisconn, "cg-attach-set_eisconn"))
+		goto close_bpf_object;
+	link_get_errno = bpf_program__attach_cgroup(obj->progs.get_errno,
+						    cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_errno, "cg-attach-get_errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
+				   &zero, sizeof(int)), "setsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EISCONN, "setsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 3, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->errno_value, EISCONN, "errno_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eunatch);
+	bpf_link__destroy(link_set_eisconn);
+	bpf_link__destroy(link_get_errno);
+
+	cgroup_export_errno_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_legacy_eperm(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_setsockopt *obj;
+	struct bpf_link *link_legacy_eperm = NULL, *link_get_errno = NULL;
+
+	obj = cgroup_export_errno_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that return a reject without setting errno
+	 * (legacy reject), and one that gets the errno. Assert that for
+	 * backward compatibility the syscall result in EPERM, and this
+	 * is also visible to the helper.
+	 */
+	link_legacy_eperm = bpf_program__attach_cgroup(obj->progs.legacy_eperm,
+						       cgroup_fd);
+	if (!ASSERT_OK_PTR(link_legacy_eperm, "cg-attach-legacy_eperm"))
+		goto close_bpf_object;
+	link_get_errno = bpf_program__attach_cgroup(obj->progs.get_errno,
+						    cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_errno, "cg-attach-get_errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
+				   &zero, sizeof(int)), "setsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EPERM, "setsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 2, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->errno_value, EPERM, "errno_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_legacy_eperm);
+	bpf_link__destroy(link_get_errno);
+
+	cgroup_export_errno_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_legacy_no_override(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_setsockopt *obj;
+	struct bpf_link *link_set_eunatch = NULL, *link_legacy_eperm = NULL;
+	struct bpf_link *link_get_errno = NULL;
+
+	obj = cgroup_export_errno_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that sets EUNATCH, then one that return a reject
+	 * without setting errno, and then one that gets the exported errno.
+	 * Assert both the syscall and the helper's errno are unaffected by
+	 * the second prog (i.e. legacy rejects does not override the errno
+	 * to EPERM).
+	 */
+	link_set_eunatch = bpf_program__attach_cgroup(obj->progs.set_eunatch,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eunatch, "cg-attach-set_eunatch"))
+		goto close_bpf_object;
+	link_legacy_eperm = bpf_program__attach_cgroup(obj->progs.legacy_eperm,
+						       cgroup_fd);
+	if (!ASSERT_OK_PTR(link_legacy_eperm, "cg-attach-legacy_eperm"))
+		goto close_bpf_object;
+	link_get_errno = bpf_program__attach_cgroup(obj->progs.get_errno,
+						    cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_errno, "cg-attach-get_errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
+				   &zero, sizeof(int)), "setsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EUNATCH, "setsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 3, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->errno_value, EUNATCH, "errno_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eunatch);
+	bpf_link__destroy(link_legacy_eperm);
+	bpf_link__destroy(link_get_errno);
+
+	cgroup_export_errno_setsockopt__destroy(obj);
+}
+
+static void test_getsockopt_get(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_getsockopt *obj;
+	struct bpf_link *link_get_errno = NULL;
+	int buf;
+	socklen_t optlen = sizeof(buf);
+
+	obj = cgroup_export_errno_getsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach getsockopt that gets previously set errno. Assert that the
+	 * error from kernel is in retval_value and not errno_value.
+	 */
+	link_get_errno = bpf_program__attach_cgroup(obj->progs.get_errno,
+						    cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_errno, "cg-attach-get_errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(getsockopt(sock_fd, SOL_CUSTOM, 0,
+				   &buf, &optlen), "getsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EOPNOTSUPP, "getsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 1, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->errno_value, 0, "errno_value"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->retval_value, -EOPNOTSUPP, "errno_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_get_errno);
+
+	cgroup_export_errno_getsockopt__destroy(obj);
+}
+
+static void test_getsockopt_override(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_getsockopt *obj;
+	struct bpf_link *link_set_eisconn = NULL;
+	int buf;
+	socklen_t optlen = sizeof(buf);
+
+	obj = cgroup_export_errno_getsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach getsockopt that sets errno to EISCONN. Assert that this
+	 * overrides the value from kernel.
+	 */
+	link_set_eisconn = bpf_program__attach_cgroup(obj->progs.set_eisconn,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eisconn, "cg-attach-set_eisconn"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(getsockopt(sock_fd, SOL_CUSTOM, 0,
+				   &buf, &optlen), "getsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EISCONN, "getsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 1, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eisconn);
+
+	cgroup_export_errno_getsockopt__destroy(obj);
+}
+
+static void test_getsockopt_retval_no_clear_errno(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_export_errno_getsockopt *obj;
+	struct bpf_link *link_set_eisconn = NULL, *link_clear_retval = NULL;
+	int buf;
+	socklen_t optlen = sizeof(buf);
+
+	obj = cgroup_export_errno_getsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach getsockopt that sets errno to EISCONN, and one that clears
+	 * retval. Assert that the clearing retval does not clear EISCONN.
+	 */
+	link_set_eisconn = bpf_program__attach_cgroup(obj->progs.set_eisconn,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eisconn, "cg-attach-set_eisconn"))
+		goto close_bpf_object;
+	link_clear_retval = bpf_program__attach_cgroup(obj->progs.clear_retval,
+						       cgroup_fd);
+	if (!ASSERT_OK_PTR(link_clear_retval, "cg-attach-clear_retval"))
+		goto close_bpf_object;
+
+	if (!ASSERT_ERR(getsockopt(sock_fd, SOL_CUSTOM, 0,
+				   &buf, &optlen), "getsockopt"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(errno, EISCONN, "getsockopt-errno"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 2, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eisconn);
+	bpf_link__destroy(link_clear_retval);
+
+	cgroup_export_errno_getsockopt__destroy(obj);
+}
+
+void test_cgroup_export_errno(void)
+{
+	int cgroup_fd = -1;
+	int sock_fd = -1;
+
+	cgroup_fd = test__join_cgroup("/cgroup_export_errno");
+	if (!ASSERT_GE(cgroup_fd, 0, "cg-create"))
+		goto close_fd;
+
+	sock_fd = start_server(AF_INET, SOCK_DGRAM, NULL, 0, 0);
+	if (!ASSERT_GE(sock_fd, 0, "start-server"))
+		goto close_fd;
+
+	if (test__start_subtest("setsockopt-set"))
+		test_setsockopt_set(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("setsockopt-set_and_get"))
+		test_setsockopt_set_and_get(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("setsockopt-default_zero"))
+		test_setsockopt_default_zero(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("setsockopt-default_zero_and_set"))
+		test_setsockopt_default_zero_and_set(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("setsockopt-override"))
+		test_setsockopt_override(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("setsockopt-legacy_eperm"))
+		test_setsockopt_legacy_eperm(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("setsockopt-legacy_no_override"))
+		test_setsockopt_legacy_no_override(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("getsockopt-get"))
+		test_getsockopt_get(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("getsockopt-override"))
+		test_getsockopt_override(cgroup_fd, sock_fd);
+
+	if (test__start_subtest("getsockopt-retval_no_clear_errno"))
+		test_getsockopt_retval_no_clear_errno(cgroup_fd, sock_fd);
+
+close_fd:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_export_errno_getsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_export_errno_getsockopt.c
new file mode 100644
index 000000000000..2429e66b325a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_export_errno_getsockopt.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2021 Google LLC.
+ */
+
+#include <errno.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+__u32 invocations = 0;
+__u32 assertion_error = 0;
+__u32 errno_value = 0;
+__u32 retval_value = 0;
+
+SEC("cgroup/getsockopt")
+int get_errno(struct bpf_sockopt *ctx)
+{
+	errno_value = bpf_export_errno(0);
+	retval_value = ctx->retval;
+	__sync_fetch_and_add(&invocations, 1);
+
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int set_eisconn(struct bpf_sockopt *ctx)
+{
+	__sync_fetch_and_add(&invocations, 1);
+
+	if (bpf_export_errno(EISCONN))
+		assertion_error = 1;
+
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int clear_retval(struct bpf_sockopt *ctx)
+{
+	__sync_fetch_and_add(&invocations, 1);
+
+	ctx->retval = 0;
+
+	return 1;
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_export_errno_setsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_export_errno_setsockopt.c
new file mode 100644
index 000000000000..f8585e100863
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_export_errno_setsockopt.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2021 Google LLC.
+ */
+
+#include <errno.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+__u32 invocations = 0;
+__u32 assertion_error = 0;
+__u32 errno_value = 0;
+
+SEC("cgroup/setsockopt")
+int get_errno(struct bpf_sockopt *ctx)
+{
+	errno_value = bpf_export_errno(0);
+	__sync_fetch_and_add(&invocations, 1);
+
+	return 1;
+}
+
+SEC("cgroup/setsockopt")
+int set_eunatch(struct bpf_sockopt *ctx)
+{
+	__sync_fetch_and_add(&invocations, 1);
+
+	if (bpf_export_errno(EUNATCH))
+		assertion_error = 1;
+
+	return 0;
+}
+
+SEC("cgroup/setsockopt")
+int set_eisconn(struct bpf_sockopt *ctx)
+{
+	__sync_fetch_and_add(&invocations, 1);
+
+	if (bpf_export_errno(EISCONN))
+		assertion_error = 1;
+
+	return 0;
+}
+
+SEC("cgroup/setsockopt")
+int legacy_eperm(struct bpf_sockopt *ctx)
+{
+	__sync_fetch_and_add(&invocations, 1);
+
+	return 0;
+}
-- 
2.33.0

