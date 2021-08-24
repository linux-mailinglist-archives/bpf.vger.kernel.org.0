Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281F73F55E7
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 04:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhHXCo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 22:44:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45469 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233815AbhHXCoz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 22:44:55 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6D91C5C00E6;
        Mon, 23 Aug 2021 22:44:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 23 Aug 2021 22:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=3voj+wuwV49+M
        Jgt0JSmO+SsOyMpEpeXM0TkdlTOE6A=; b=w6TmDVR6zghqm8Tks8cB3nAy7wMGp
        UrFNjvCk0+LiC7TlsyhiTspK1VObYpkSAuc9ciIbwj9DUI1JTImOAzm4wis4KcOF
        9Hxr62YeVIDZ6GDYK6JZqk1N8iaEs6bql5nvF2liRVnJF8WpJ+G6UBqvdcMvlcAL
        0jRVVHdFnDVTw26LtGKsyVI8yeZQfEtDMZumVMUmV4oAWJg9D8a8Wq5QymIXk6h3
        vFaC0F6/IOJEOiDSFr6OaJ2s/qs+f7+JE94zhW15nqbT9nH5R5jHzaiscxnf86zK
        A6cF0Z07UuxJaYP/Kd9BXJIoF7ZLHPR/5MYdqzXasFYN1WKVKT2ZiENTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3voj+wuwV49+MJgt0JSmO+SsOyMpEpeXM0TkdlTOE6A=; b=RelSlPJI
        ygbDS3va6496d/6R5vUnXpqJCOzIReKlX+m5M4YS8n5xJh4R8rRUfzuREdXX86rJ
        eMkkgctY4y8AyzByz68ev5kiPQJGn2B+vwi8+P5MGvubtYV+RaKAxFzdc8E9/wJe
        izTgJRB+Yd9YO+H7lPeqNNEuZTw+eTi5/i/Boqts+zarvB2v0959Mnex3lnDbHIj
        BpFTYxv/Fhs/2eBgF0ANosxSAq7Dwi7wx15p+t4RAwV0kXpYVXU8Z961r+GEZb8m
        Yo89fZfgDLZolqNL1ixm5kLgDLO9/oJeLWahFZtjcl8++24QekxYgf+98AZQf3Cy
        RvU49BSmlTj6NQ==
X-ME-Sender: <xms:-1wkYfcWZ3pNzwriYwA19-2y80iXXuxxPz_T3LQMwpzeYj97TFVoWQ>
    <xme:-1wkYVPNMGIB8wGkFydK13uwg5NbfJfxXjTRWEaZYY5B39ugYwKcl72POm_8Php3h
    0lewnSz0Tr0MYXc9g>
X-ME-Received: <xmr:-1wkYYhWJOEALDQ6RtW6KYrZm3PSa7HNUDJNkXakA9y76mfDjLFkTAVbwkJyIcMRmQlbVEBaZ60FPb1iWTFc8noJeRE8NndubXGfDZh9VEFWOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtiedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucevlhhushhtvghrufhiiigv
    pedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:-1wkYQ90enzgnydVbxXuaDqjntbd1OZeDIooCJ-gb5QN9GQtFlDnNg>
    <xmx:-1wkYbuogEDv7R1vGccBgOfJkUQwKuvUq4BE37xCprr3LS77jr6-LA>
    <xmx:-1wkYfF1qkXKUX7O78fs0XxdcEAcuN8bPEGtrDYsVDEWJlV6WpnnIA>
    <xmx:-1wkYVJ_BSSBHfTiglbJW55xzYkeUL8YtouayDvguj4A6bePC8UGsA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 22:44:10 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 5/5] bpf: selftests: Add bpf_task_pt_regs() selftest
Date:   Mon, 23 Aug 2021 19:43:50 -0700
Message-Id: <5581eb8800f6625ec8813fe21e9dce1fbdef4937.1629772842.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629772842.git.dxu@dxuuu.xyz>
References: <cover.1629772842.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test retrieves the uprobe's pt_regs in two different ways and
compares the contents in an arch-agnostic way.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/task_pt_regs.c   | 47 +++++++++++++++++++
 .../selftests/bpf/progs/test_task_pt_regs.c   | 29 ++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_pt_regs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
new file mode 100644
index 000000000000..53f0e0fa1a53
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <linux/ptrace.h>
+#include "test_task_pt_regs.skel.h"
+
+void test_task_pt_regs(void)
+{
+	struct test_task_pt_regs *skel;
+	struct bpf_link *uprobe_link;
+	size_t uprobe_offset;
+	ssize_t base_addr;
+	bool match;
+
+	base_addr = get_base_addr();
+	if (!ASSERT_GT(base_addr, 0, "get_base_addr"))
+		return;
+	uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
+
+	skel = test_task_pt_regs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
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
+	if (!ASSERT_EQ(skel->bss->uprobe_res, 1, "check_uprobe_res"))
+		goto cleanup;
+
+	match = !memcmp(&skel->bss->current_regs, &skel->bss->ctx_regs,
+			sizeof(skel->bss->current_regs));
+	ASSERT_TRUE(match, "check_regs_match");
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
2.33.0

