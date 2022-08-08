Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF258CA1F
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbiHHOHa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiHHOH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E926DE
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D7E960C21
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB6DC433D6;
        Mon,  8 Aug 2022 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967647;
        bh=yNNrr42ZMVMIxsMzww5ClyIb5wB6bW/QUlKoQaG2UlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSLTKv1ujf4veYARDaxEQP8RLd4Sg5rQPaIcGbyELX6x3SASaOtyR4wxgCM8V6YuQ
         DXkI2P+JfYwKFlHpbxZX4QGcYB1RmFD39rFk0lEt6iQrGuZeKyTQy3+GomZhK8sQfu
         cbenNCw0GcsnEcFmwyrNBpozvAHYFCDaAtekiT/Oja+UmowC+LbstTHmlv89azWs9b
         HE2SNwUyj6r38P0NvFcclX+iagHfRC4V203fDYC43DHn2TSjGRa/n5tirkTC4vSfE3
         UzT2uYn3H9bNn+Sjs9A9OlbqZn+wVInIQbL9fQUe77Xvb4+5PxmvBCTerQ16+HZLaN
         7BQ8/ew/zLCrA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 05/17] bpf: Add bpf_tramp_id object
Date:   Mon,  8 Aug 2022 16:06:14 +0200
Message-Id: <20220808140626.422731-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
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

Adding bpf_tramp_id object that allows to store multiple BTF
function ids together with their resolved addresses.

It will be used in following changes to identify and attach
multiple functions to trampolines.

The bpf_tramp_id object will be shared between trampoline and
link in following changes, so it keeps refcount for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     | 12 ++++++++++++
 kernel/bpf/trampoline.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 32168ea92551..a5738d57f6bd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -27,6 +27,7 @@
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/refcount.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -846,6 +847,15 @@ struct bpf_tramp_image {
 	};
 };
 
+struct bpf_tramp_id {
+	u32 max;
+	u32 cnt;
+	u32 obj_id;
+	u32 *id;
+	void **addr;
+	refcount_t refcnt;
+};
+
 struct bpf_shim_tramp_link;
 
 struct bpf_trampoline {
@@ -917,6 +927,8 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline
 struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
+struct bpf_tramp_id *bpf_tramp_id_alloc(u32 cnt);
+void bpf_tramp_id_put(struct bpf_tramp_id *id);
 int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 #define BPF_DISPATCHER_INIT(_name) {				\
 	.mutex = __MUTEX_INITIALIZER(_name.mutex),		\
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 56899d63c08c..c0983ff5aa3a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -149,6 +149,44 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
 			   PAGE_SIZE, true, ksym->name);
 }
 
+struct bpf_tramp_id *bpf_tramp_id_alloc(u32 max)
+{
+	struct bpf_tramp_id *id;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (id) {
+		id->id = kcalloc(max, sizeof(u32), GFP_KERNEL);
+		id->addr = kcalloc(max, sizeof(*id->addr), GFP_KERNEL);
+		if (!id->id || !id->addr) {
+			kfree(id->id);
+			kfree(id->addr);
+			kfree(id);
+			return NULL;
+		}
+		id->max = max;
+		refcount_set(&id->refcnt, 1);
+	}
+	return id;
+}
+
+__maybe_unused
+static struct bpf_tramp_id *bpf_tramp_id_get(struct bpf_tramp_id *id)
+{
+	refcount_inc(&id->refcnt);
+	return id;
+}
+
+void bpf_tramp_id_put(struct bpf_tramp_id *id)
+{
+	if (!id)
+		return;
+	if (!refcount_dec_and_test(&id->refcnt))
+		return;
+	kfree(id->addr);
+	kfree(id->id);
+	kfree(id);
+}
+
 static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 {
 	struct bpf_trampoline *tr;
-- 
2.37.1

