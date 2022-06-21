Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE3B553BC8
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 22:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354006AbiFUUq5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354156AbiFUUq4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 16:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206842B1A1
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B162B6185A
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FC4C341CC;
        Tue, 21 Jun 2022 20:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844415;
        bh=5ZMi3z6QKbQw0Q9J7MHsWauSOb4XqeY0Org1meXj0iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYcDSolRNuDvcV7tchH7BXc9fiI/uOHjUySAzVmjxQ1BeP7x5xQXad63srAANXrgi
         AMv969IWFDhu+ZpLKiCDFOFfnrUz6oLPd6ubwe9dnlOcRidquXGpRN49hrieD0zR+h
         MvQBXZ+7FzZAWtNyoHbc+a42vucGtMqsbx0xOGf9ZODz2d4Ol2xWWlafZRp01gp9L+
         1YnMHBRl1U7vxWATy1QUjRzhYVQ3+ZnGm8htWWOI+xNYXUC75IP7URXwQF89h2WRQL
         U06ei4TwLuSSoa7UNyPHkFSuvQuO0M/waUkT6mQ/hYpgK1BLy08wVfF0rqN8npNh8g
         pr8IkynXM+VMw==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v3 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
Date:   Tue, 21 Jun 2022 20:46:41 +0000
Message-Id: <20220621204642.2891979-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220621204642.2891979-1-kpsingh@kernel.org>
References: <20220621204642.2891979-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LSMs like SELinux store security state in xattrs. bpf_getxattr enables
BPF LSM to implement similar functionality. In combination with
bpf_local_storage, xattrs can be used to develop more complex security
policies.

This kfunc wraps around __vfs_getxattr which can sleep and is,
therefore, limited to sleepable programs using the newly added
sleepable_set for kfuncs.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/trace/bpf_trace.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4be976cf7d63..210e29bd0cbb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -20,6 +20,7 @@
 #include <linux/fprobe.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/xattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1181,6 +1182,47 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
+				     const char *name, void *value, int size)
+{
+	return __vfs_getxattr(dentry, inode, name, value, size);
+}
+
+__diag_pop();
+
+BTF_SET_START(bpf_trace_kfunc_ids)
+BTF_ID(func, bpf_getxattr)
+BTF_SET_END(bpf_trace_kfunc_ids)
+
+BTF_SET_START(bpf_trace_sleepable_kfunc_ids)
+BTF_ID(func, bpf_getxattr)
+BTF_SET_END(bpf_trace_sleepable_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_trace_kfunc_set = {
+	.owner = THIS_MODULE,
+	.check_set = &bpf_trace_kfunc_ids,
+	.sleepable_set = &bpf_trace_sleepable_kfunc_ids,
+};
+
+static int __init bpf_trace_kfunc_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&bpf_trace_kfunc_set);
+	if (!ret)
+		return ret;
+
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					&bpf_trace_kfunc_set);
+
+}
+late_initcall(bpf_trace_kfunc_init);
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.37.0.rc0.104.g0611611a94-goog

