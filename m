Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7D5528FA
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 03:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiFUB2a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 21:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbiFUB2Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 21:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13681928B
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 18:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A54061596
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 01:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F170C341C5;
        Tue, 21 Jun 2022 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655774903;
        bh=7ru/BD8lvgDJnszDvUzzT9MCF7A89UGdXDKmbwMRzZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xv/w32cd6RNANi9DSN6C5EJ7TEHeR2IsMdXkTyYfBaiPbRtc92bpph6MxHYqZH1HA
         1XbFqxStdZHEhIUW18nNz1+7IArNM2HfUNBNegV3bqEx0Kg5UE8AWzvkCf05YEf98V
         gXUq4ByTEOucws5je9G4P4YmCKzDx1x/cOyLcweo3TtWctbS3SaFexK1DC3G4ZQmuX
         TEAiLy1qN/2YAWMw5PXTlD48AoNex59/4W5RDdVwMHUzXyeAW8vkJ2dtUwNSW1Z/Xx
         COTR4i9+EkQj31BSOvfNUolGaUls7kDFOtmlQ1cAQ75ZWa2KkFH+cYUQrFwip06i4S
         IQDVcylDaTgXg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v2 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
Date:   Tue, 21 Jun 2022 01:28:10 +0000
Message-Id: <20220621012811.2683313-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220621012811.2683313-1-kpsingh@kernel.org>
References: <20220621012811.2683313-1-kpsingh@kernel.org>
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
 kernel/trace/bpf_trace.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4be976cf7d63..b5682d55ebde 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -20,6 +20,7 @@
 #include <linux/fprobe.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/xattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1181,6 +1182,41 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
+				     const char *name, void *value, int size)
+{
+	return __vfs_getxattr(dentry, inode, name, value, size);
+}
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

