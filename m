Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E3D4576B2
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 19:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhKSSx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235164AbhKSSxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:53:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB4E061AF0;
        Fri, 19 Nov 2021 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637347848;
        bh=SVqYRpHO2+fLQfeXMid2HFYTiomGqjvNZomQSG7moFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKYH30/twI+lsHkEeCKu3P44AvIE70mIeW/T5QAwtHoNLNTKA+kSe8bM6g2OgSURa
         2Y6rzOuf9ShzbRjLNSAdcWnVdx8SC5M1x8fylc/4vE0T7ETgZLuGQG5hJ1rClfs183
         d6NzbX1rbYcfQXiZ12bjkohkteHo7wWQOhGUN2R1wtPH9YOvfu4DWBkjGQv/CXyM63
         LJb98NSOilO62G++FQ05djqRlUc2HcHJ+kOTNxOiBrKjvlvyrnGPZzYgZ0ZnXN3pHG
         /61jS/krtQsBU2EZlFHkchpkclriqHrNfNazTrjPpisojC4/bSFkG/1k9120fJGMoX
         paTclOD5e4d1w==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [RFC bpf-next 4/6] bpf: create a header for struct bpf_link
Date:   Fri, 19 Nov 2021 10:50:41 -0800
Message-Id: <20211119185043.3937836-5-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119185043.3937836-1-kuba@kernel.org>
References: <20211119185043.3937836-1-kuba@kernel.org>
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
index 47f0a3cfec24..1302e0737699 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpf-cgroup-types.h>
+#include <linux/bpf-link.h>
 #include <linux/bpfptr.h>
 
 struct bpf_verifier_env;
@@ -945,15 +946,6 @@ struct bpf_array_aux {
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

