Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF04767B1
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 03:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhLPCE5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 21:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhLPCEy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 21:04:54 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032E4C061574
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:53 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r9-20020a63d909000000b003312e182b9cso13239273pgg.16
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qEaOxtXfEJd9PtpiGjlJKaDKHjkcefkBSyOvpOlfEaU=;
        b=ibO/xtEa2YdSAwCphKw5hKVJt7dkTjLtrPps4Uc/VNOTvXuXRnVgJVUg/tFzZDIr3L
         G+9A3MfgFfhQKvz1lSoRUC+Wy40he0F+bDel4A/FVl9p9fg8jYjbE2GZWLNsBtwXyDze
         nm9eqE7z//uwRaUGK8d/mM/8YFbtbES7ebtzR/zjsgqdEN47nPIdvWZ+keshGhS4T+Pm
         NpK67LblrHGDei8Xg6WZ/YnKX47PlGZQTaMFcQk3Wxh95KLm97DtqNjy5OhTb03peKn9
         XSvP+xtdGYc/OuFGAylqNBrEXABnK8ZgPpqWo0PmeIOUENLxVTQwigGfSrQ9BnAkcBxl
         fDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qEaOxtXfEJd9PtpiGjlJKaDKHjkcefkBSyOvpOlfEaU=;
        b=like++i3pzPxd4n4kCOW3aMsM5WNdhPo5jzCdiWlOg4EU+W8eZIXX7THiSaXjXg0Vn
         ri9tdVvXPgT8JuEe6D4CF7CNCUizXPfqVpo7dMkjF8Tka3c+G8t9HzlhmnqGyAV7Mg6z
         /XcPrIFIZKusEudTUoqM0vYP+X3mJkSOhk6NFXQv6klpm+i6A7BWLOT5bBSnQqXQ1gwv
         zlRhgN4PU1UDttdIWD0UurPzTKUm2LvocWPzRXiQ8L5Ew3p94BacjbRmiENyNmMuo5aj
         TH38+bxuSR2SJVPks7lcIg4kxERlHn6Kud1bO9kSP79dVq2v29LQZ9E+HzmDzkPoIEVf
         Kq0Q==
X-Gm-Message-State: AOAM530ERvSUmNkgDxpfZF4v+gTIPxEWcYZNdHJ7JkuWLIrOFiTMr9B8
        YZzMWpOSvP3x+7Fh2zBS2LwloDLpTDFtGzUxrgws2O6iIpBS4fInlBAGnBwwNzAhhZJ4LHY8/nJ
        Zw6TejxwncPHERbyhwfaO7/HHRe7ethzh6cK100xNeZU4bz3xRX40THuRCSZX/lg=
X-Google-Smtp-Source: ABdhPJxwgXtJh2jrlqeYIyZgwh2/yHuzisc89vRf3DTBmhe1UgRtd9cf+Z6jjkVPzz/2E8hT1BRU9oODL4kO5w==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90a:c297:: with SMTP id
 f23mr3266942pjt.138.1639620292463; Wed, 15 Dec 2021 18:04:52 -0800 (PST)
Date:   Thu, 16 Dec 2021 02:04:28 +0000
In-Reply-To: <cover.1639619851.git.zhuyifei@google.com>
Message-Id: <43ec60d679ae3f4f6fd2460559c28b63cb93cd12.1639619851.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1639619851.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Test bpf_{get,set}_retval
 behavior with cgroup/sockopt
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The tests checks how different ways of interacting with the helpers
(getting retval, setting EUNATCH, EISCONN, and legacy reject
returning 0 without setting retval), produce different results in
both the setsockopt syscall and the retval returned by the helper.
A few more tests verify the interaction between the retval of the
helper and the retval in getsockopt context.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/cgroup_getset_retval.c     | 481 ++++++++++++++++++
 .../progs/cgroup_getset_retval_getsockopt.c   |  45 ++
 .../progs/cgroup_getset_retval_setsockopt.c   |  52 ++
 3 files changed, 578 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
new file mode 100644
index 000000000000..0b47c3c000c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
@@ -0,0 +1,481 @@
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
+#include "cgroup_getset_retval_setsockopt.skel.h"
+#include "cgroup_getset_retval_getsockopt.skel.h"
+
+#define SOL_CUSTOM	0xdeadbeef
+
+static int zero;
+
+static void test_setsockopt_set(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_setsockopt *obj;
+	struct bpf_link *link_set_eunatch = NULL;
+
+	obj = cgroup_getset_retval_setsockopt__open_and_load();
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
+	cgroup_getset_retval_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_set_and_get(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_setsockopt *obj;
+	struct bpf_link *link_set_eunatch = NULL, *link_get_retval = NULL;
+
+	obj = cgroup_getset_retval_setsockopt__open_and_load();
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
+	link_get_retval = bpf_program__attach_cgroup(obj->progs.get_retval,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_retval, "cg-attach-get_retval"))
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
+	if (!ASSERT_EQ(obj->bss->retval_value, -EUNATCH, "retval_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eunatch);
+	bpf_link__destroy(link_get_retval);
+
+	cgroup_getset_retval_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_default_zero(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_setsockopt *obj;
+	struct bpf_link *link_get_retval = NULL;
+
+	obj = cgroup_getset_retval_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that gets the previously set errno.
+	 * Assert that, without anything setting one, we get 0.
+	 */
+	link_get_retval = bpf_program__attach_cgroup(obj->progs.get_retval,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_retval, "cg-attach-get_retval"))
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
+	if (!ASSERT_EQ(obj->bss->retval_value, 0, "retval_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_get_retval);
+
+	cgroup_getset_retval_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_default_zero_and_set(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_setsockopt *obj;
+	struct bpf_link *link_get_retval = NULL, *link_set_eunatch = NULL;
+
+	obj = cgroup_getset_retval_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach setsockopt that gets the previously set errno, and then
+	 * one that sets the errno to EUNATCH. Assert that the get does not
+	 * see EUNATCH set later, and does not prevent EUNATCH from being set.
+	 */
+	link_get_retval = bpf_program__attach_cgroup(obj->progs.get_retval,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_retval, "cg-attach-get_retval"))
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
+	if (!ASSERT_EQ(obj->bss->retval_value, 0, "retval_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_get_retval);
+	bpf_link__destroy(link_set_eunatch);
+
+	cgroup_getset_retval_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_override(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_setsockopt *obj;
+	struct bpf_link *link_set_eunatch = NULL, *link_set_eisconn = NULL;
+	struct bpf_link *link_get_retval = NULL;
+
+	obj = cgroup_getset_retval_setsockopt__open_and_load();
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
+	link_get_retval = bpf_program__attach_cgroup(obj->progs.get_retval,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_retval, "cg-attach-get_retval"))
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
+	if (!ASSERT_EQ(obj->bss->retval_value, -EISCONN, "retval_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eunatch);
+	bpf_link__destroy(link_set_eisconn);
+	bpf_link__destroy(link_get_retval);
+
+	cgroup_getset_retval_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_legacy_eperm(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_setsockopt *obj;
+	struct bpf_link *link_legacy_eperm = NULL, *link_get_retval = NULL;
+
+	obj = cgroup_getset_retval_setsockopt__open_and_load();
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
+	link_get_retval = bpf_program__attach_cgroup(obj->progs.get_retval,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_retval, "cg-attach-get_retval"))
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
+	if (!ASSERT_EQ(obj->bss->retval_value, -EPERM, "retval_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_legacy_eperm);
+	bpf_link__destroy(link_get_retval);
+
+	cgroup_getset_retval_setsockopt__destroy(obj);
+}
+
+static void test_setsockopt_legacy_no_override(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_setsockopt *obj;
+	struct bpf_link *link_set_eunatch = NULL, *link_legacy_eperm = NULL;
+	struct bpf_link *link_get_retval = NULL;
+
+	obj = cgroup_getset_retval_setsockopt__open_and_load();
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
+	link_get_retval = bpf_program__attach_cgroup(obj->progs.get_retval,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_retval, "cg-attach-get_retval"))
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
+	if (!ASSERT_EQ(obj->bss->retval_value, -EUNATCH, "retval_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eunatch);
+	bpf_link__destroy(link_legacy_eperm);
+	bpf_link__destroy(link_get_retval);
+
+	cgroup_getset_retval_setsockopt__destroy(obj);
+}
+
+static void test_getsockopt_get(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_getsockopt *obj;
+	struct bpf_link *link_get_retval = NULL;
+	int buf;
+	socklen_t optlen = sizeof(buf);
+
+	obj = cgroup_getset_retval_getsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach getsockopt that gets previously set errno. Assert that the
+	 * error from kernel is in both ctx_retval_value and retval_value.
+	 */
+	link_get_retval = bpf_program__attach_cgroup(obj->progs.get_retval,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_retval, "cg-attach-get_retval"))
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
+	if (!ASSERT_EQ(obj->bss->retval_value, -EOPNOTSUPP, "retval_value"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->ctx_retval_value, -EOPNOTSUPP, "ctx_retval_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_get_retval);
+
+	cgroup_getset_retval_getsockopt__destroy(obj);
+}
+
+static void test_getsockopt_override(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_getsockopt *obj;
+	struct bpf_link *link_set_eisconn = NULL;
+	int buf;
+	socklen_t optlen = sizeof(buf);
+
+	obj = cgroup_getset_retval_getsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach getsockopt that sets retval to -EISCONN. Assert that this
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
+	cgroup_getset_retval_getsockopt__destroy(obj);
+}
+
+static void test_getsockopt_retval_sync(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_getsockopt *obj;
+	struct bpf_link *link_set_eisconn = NULL, *link_clear_retval = NULL;
+	struct bpf_link *link_get_retval = NULL;
+	int buf;
+	socklen_t optlen = sizeof(buf);
+
+	obj = cgroup_getset_retval_getsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
+
+	/* Attach getsockopt that sets retval to -EISCONN, and one that clears
+	 * ctx retval. Assert that the clearing ctx retval is synced to helper
+	 * and clears any errors both from kernel and BPF..
+	 */
+	link_set_eisconn = bpf_program__attach_cgroup(obj->progs.set_eisconn,
+						      cgroup_fd);
+	if (!ASSERT_OK_PTR(link_set_eisconn, "cg-attach-set_eisconn"))
+		goto close_bpf_object;
+	link_clear_retval = bpf_program__attach_cgroup(obj->progs.clear_retval,
+						       cgroup_fd);
+	if (!ASSERT_OK_PTR(link_clear_retval, "cg-attach-clear_retval"))
+		goto close_bpf_object;
+	link_get_retval = bpf_program__attach_cgroup(obj->progs.get_retval,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_get_retval, "cg-attach-get_retval"))
+		goto close_bpf_object;
+
+	if (!ASSERT_OK(getsockopt(sock_fd, SOL_CUSTOM, 0,
+				  &buf, &optlen), "getsockopt"))
+		goto close_bpf_object;
+
+	if (!ASSERT_EQ(obj->bss->invocations, 3, "invocations"))
+		goto close_bpf_object;
+	if (!ASSERT_FALSE(obj->bss->assertion_error, "assertion_error"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->retval_value, 0, "retval_value"))
+		goto close_bpf_object;
+	if (!ASSERT_EQ(obj->bss->ctx_retval_value, 0, "ctx_retval_value"))
+		goto close_bpf_object;
+
+close_bpf_object:
+	bpf_link__destroy(link_set_eisconn);
+	bpf_link__destroy(link_clear_retval);
+	bpf_link__destroy(link_get_retval);
+
+	cgroup_getset_retval_getsockopt__destroy(obj);
+}
+
+void test_cgroup_getset_retval(void)
+{
+	int cgroup_fd = -1;
+	int sock_fd = -1;
+
+	cgroup_fd = test__join_cgroup("/cgroup_getset_retval");
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
+	if (test__start_subtest("getsockopt-retval_sync"))
+		test_getsockopt_retval_sync(cgroup_fd, sock_fd);
+
+close_fd:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
new file mode 100644
index 000000000000..b2a409e6382a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
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
+__u32 retval_value = 0;
+__u32 ctx_retval_value = 0;
+
+SEC("cgroup/getsockopt")
+int get_retval(struct bpf_sockopt *ctx)
+{
+	retval_value = bpf_get_retval();
+	ctx_retval_value = ctx->retval;
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
+	if (bpf_set_retval(-EISCONN))
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
diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
new file mode 100644
index 000000000000..d6e5903e06ba
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
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
+__u32 retval_value = 0;
+
+SEC("cgroup/setsockopt")
+int get_retval(struct bpf_sockopt *ctx)
+{
+	retval_value = bpf_get_retval();
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
+	if (bpf_set_retval(-EUNATCH))
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
+	if (bpf_set_retval(-EISCONN))
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
2.34.1.173.g76aa8bc2d0-goog

