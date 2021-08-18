Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299F73F0EB5
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 01:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhHRXme (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 19:42:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34493 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234882AbhHRXmc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 19:42:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FB4C5C00BE;
        Wed, 18 Aug 2021 19:41:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 18 Aug 2021 19:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=L906x9jn1af2k
        uPVRce6Z0F5sCoQjvZs1jCic4dwp5k=; b=QfsLsRNS+AqvTUCoz3KTX3pgZeqPH
        tb0Y5ZveW2ckkopo/YDP7AHpxyC367i9DsfeE1rML9ZPMeETi0QEvKGdeS6Qa7v9
        1nae5Os80B539Oc01KH3Ywwop6glej5lPjITZM/ojV80FAMrz9R/U2QrOu5ORGhO
        42TysI9Qr/VMo9SrAO8CgpIzICR9V1xDx1gPK7TWFQT2zySk6ymrcokSVB0WpO20
        2pesy6/FZkm41cYMIu9rRIqBf/NETzdGMzWQbwomYBVluwNmDL9hRz0S9PUIcrrJ
        otWw653jdUd9sDiMgot7JPEY7mhqI7LkS0TCEL2fB1i2c+TJI3vJPO11Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=L906x9jn1af2kuPVRce6Z0F5sCoQjvZs1jCic4dwp5k=; b=ROImkayA
        zKh4duHKgDv32d0rqt0BClTu5VmFEH6iAHZqC38LWZFFOxYkZVgNH7wNRKLxkZ6e
        CFhcfrLe/p2mMPkvZLyXi4MFCgmNxuIcdl/BHfMIFhFbsiFzD01YaBEPWP75dPTH
        Lj5OUyZvitS46m47ouzRjbiW3S6387IJfrgh3ABLucbYlZnRl3a7d+M0ozOH+34m
        ab/Qj/M8CGeSNlIZF0fWt4nAmVy5Os2fc34BiJZT3hhIQ1Ofk49I9THESrDEKgL9
        FifDxQcqJhM+M9Cc9KEAtsuvSYHbsk9LPCPItxkVvW3JMUrFQYpGYC/u5P9ElifT
        s5L+6e0KSgFMMA==
X-ME-Sender: <xms:xJodYbT-l-wn_P8mT7AUz6h2vVTEa9EUW3jNn8hOKmmSb4g0eQH_bA>
    <xme:xJodYcxGc3mOBqFq3Eb_A93tm7ubqKsKDqBVaXWBLI8W43HJOkzE0cEJ36xhP4pgY
    eTSfFqM67kj7oKdoA>
X-ME-Received: <xmr:xJodYQ3FIGtoKtTqzOoQysph8J1uxWjzWaSzU_1BsNRmYSTfgWMTvZAJlpg4FZBCG6YoaxuYTTvj9EicSr0rS17XdHVPbcVHKgEL9ubcxJSt_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfekudelkefhteevhfeggf
    dvgeefjeefgfeuvddutdfhgffghfehtdeuueetfeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:xJodYbAA3UDKIwPsqYNUKp7L_uEnL0mF1cR2OXpS9PHP8TwaPvUOEg>
    <xmx:xJodYUgvO6tFRZwb4_JZ97FRq5wQVBgIPs9TUMtD7I_pqB8vDRYvaQ>
    <xmx:xJodYfpt9JuAnv8mZ5u4p-Oy1CdAod5RGWmPa0NRnn69SCwzvfOFLA>
    <xmx:xJodYce2OuxBVnsNEcRPyAZzcgXouqgqte0WsBpcCPcRqSd7TKtkMw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 19:41:55 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] bpf: selftests: Add bpf_task_pt_regs() selftest
Date:   Wed, 18 Aug 2021 16:41:42 -0700
Message-Id: <dda52cfef588adf7cf231af7c247b526868c5aef.1629329560.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629329560.git.dxu@dxuuu.xyz>
References: <cover.1629329560.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test retrieves the uprobe's pt_regs in two different ways and
compares the contents in an arch-agnostic way.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/task_pt_regs.c   | 50 +++++++++++++++++++
 .../selftests/bpf/progs/test_task_pt_regs.c   | 29 +++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_pt_regs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
new file mode 100644
index 000000000000..3f0fc2267c1c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <linux/ptrace.h>
+#include "test_task_pt_regs.skel.h"
+
+void test_task_pt_regs(void)
+{
+	int duration = 0;
+	struct test_task_pt_regs *skel;
+	struct bpf_link *uprobe_link;
+	size_t uprobe_offset;
+	ssize_t base_addr;
+	bool match;
+
+	base_addr = get_base_addr();
+	if (CHECK(base_addr < 0, "get_base_addr",
+		  "failed to find base addr: %zd", base_addr))
+		return;
+	uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
+
+	skel = test_task_pt_regs__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+	if (CHECK(!skel->bss, "check_bss", ".bss wasn't mmap()-ed\n"))
+		goto cleanup;
+
+	uprobe_link = bpf_program__attach_uprobe(skel->progs.handle_uprobe,
+						 false /* retprobe */,
+						 0 /* self pid */,
+						 "/proc/self/exe",
+						 uprobe_offset);
+	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe"))
+		goto cleanup;
+	skel->links.handle_uprobe = uprobe_link;
+
+	/* trigger & validate uprobe */
+	get_base_addr();
+
+	if (CHECK(skel->bss->uprobe_res != 1, "check_uprobe_res",
+		  "wrong uprobe res: %d\n", skel->bss->uprobe_res))
+		goto cleanup;
+
+	match = !memcmp(&skel->bss->current_regs, &skel->bss->ctx_regs,
+			sizeof(skel->bss->current_regs));
+	CHECK(!match, "check_regs_match", "registers did not match");
+
+cleanup:
+	test_task_pt_regs__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
new file mode 100644
index 000000000000..6c059f1cfa1b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct pt_regs current_regs = {};
+struct pt_regs ctx_regs = {};
+int uprobe_res = 0;
+
+SEC("uprobe/trigger_func")
+int handle_uprobe(struct pt_regs *ctx)
+{
+	struct task_struct *current;
+	struct pt_regs *regs;
+
+	current = bpf_get_current_task_btf();
+	regs = (struct pt_regs *) bpf_task_pt_regs(current);
+	__builtin_memcpy(&current_regs, regs, sizeof(*regs));
+	__builtin_memcpy(&ctx_regs, ctx, sizeof(*ctx));
+
+	/* Prove that uprobe was run */
+	uprobe_res = 1;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.32.0

