Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB874738AF
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 00:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbhLMXmk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 18:42:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53882 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244242AbhLMXmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 18:42:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8683CB8172F
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 23:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC06C3460D;
        Mon, 13 Dec 2021 23:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639438958;
        bh=FcSJ8EzYolLXSsX4kY9V5zxR85EK5N9wvL9+sfRkqjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwZnTs5BqX64cvgG2P3OIvysxJAjzi3cj4KHtqP7lJ35nR1qzblQN8yDuvN71zqU0
         bmJFdpXnHp47b6IdOpJXDaPjhBeBn/KvpNesV/j6hZkf37QoRbGf37Z36uxRMUTJ7H
         IzRBfYs5qIFUwTVFVVKi7TwhRQM592KKJ61DI8rqxGaqiAAi7r5fFAw//h1AP1X4v+
         awHsGoZAPjpGEdKeosW8qQpTu3rMN7Wc0uUP5dOgxnOBiPk1KvGufOMe8r58fvBq86
         0ODsO4PL8YuPs1/PIlBoOgM8+wFnbBDQriRIIyrpzuFHFQI22BLRkqvLqjgbJdv1WZ
         cAVd/3acSoX7Q==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 3/5] bpf: create a header for struct bpf_link
Date:   Mon, 13 Dec 2021 15:42:21 -0800
Message-Id: <20211213234223.356977-4-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234223.356977-1-kuba@kernel.org>
References: <20211213234223.356977-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct bpf_link needs to be embedded by cgroups.
Put it in its own header.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf-link.h | 23 +++++++++++++++++++++++
 include/linux/bpf.h      | 10 +---------
 2 files changed, 24 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/bpf-link.h

diff --git a/include/linux/bpf-link.h b/include/linux/bpf-link.h
new file mode 100644
index 000000000000..d20f049af51a
--- /dev/null
+++ b/include/linux/bpf-link.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
+ */
+#ifndef _LINUX_BPF_MIN_H
+#define _LINUX_BPF_MIN_H 1
+
+#include <uapi/linux/bpf.h>
+
+#include <linux/workqueue.h>
+
+struct bpf_prog;
+struct bpf_link_ops;
+
+struct bpf_link {
+	atomic64_t refcnt;
+	u32 id;
+	enum bpf_link_type type;
+	const struct bpf_link_ops *ops;
+	struct bpf_prog *prog;
+	struct work_struct work;
+};
+
+#endif
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b998347297ec..64bdae62a594 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpf-cgroup-types.h>
+#include <linux/bpf-link.h>
 #include <linux/bpfptr.h>
 
 struct bpf_verifier_env;
@@ -946,15 +947,6 @@ struct bpf_array_aux {
 	struct work_struct work;
 };
 
-struct bpf_link {
-	atomic64_t refcnt;
-	u32 id;
-	enum bpf_link_type type;
-	const struct bpf_link_ops *ops;
-	struct bpf_prog *prog;
-	struct work_struct work;
-};
-
 struct bpf_link_ops {
 	void (*release)(struct bpf_link *link);
 	void (*dealloc)(struct bpf_link *link);
-- 
2.31.1

