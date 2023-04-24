Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E032C6ED1F8
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjDXQFV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjDXQFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5350B6A6B
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F4061B3B
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED12C433EF;
        Mon, 24 Apr 2023 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352312;
        bh=EhY7xWSqakRJM6mhVenwnioj+7nt3qIzNwRcwlYuGik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfCmYwSsNZblMKPbXq6E6QkSv4D4H1NZLdZVxQHIKiBJ9Z8Efe1yAcbUl8MYO+jll
         6git68lIRhbJAEiqnlk6v6dEbkS3xCO1C2gqdTtiDXnvIlj9P4yMHtwpReXgyDV80b
         puIaH/uK8Ap0duhOJyCzkG3+eBJsqzLVUlByrzXA/n1pQtLXISShG2XUtVYE+lHpJV
         a5vdgAqNQetB0UY78vOkdaEoiYiE26y8GoGoj18Zd79gNTzm2sqJ9f8VDhYxDWMZfV
         3lW73echsdBX6Yjskpgz/8KCoq3BkZgUukdIvwrKLkHb8VCDFOAsOi2PzG53kn8J14
         TIMjjDktHxZYw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 02/20] bpf: Add cookies support for uprobe_multi link
Date:   Mon, 24 Apr 2023 18:04:29 +0200
Message-Id: <20230424160447.2005755-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to specify cookies array for uprobe_multi link.

The cookies array share indexes and length with other uprobe_multi
arrays (paths/offsets/ref_ctr_offsets).

The cookies[i] value defines cookie for i-the uprobe and will be
returned by bpf_get_attach_cookie helper when called from ebpf
program hooked to that specific uprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/syscall.c     |  2 +-
 kernel/trace/bpf_trace.c | 46 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index debc041c6ca5..77ce2159478d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1581,6 +1581,7 @@ union bpf_attr {
 				__aligned_u64	paths;
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
+				__aligned_u64	cookies;
 			} uprobe_multi;
 		};
 	} link_create;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0b789a33317b..5b2dc7ae8616 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4566,7 +4566,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
+#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.cookies
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type ptype;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b84a7d01abf4..f795cfc00e5f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -87,6 +87,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
 static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
 
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx);
+
 /**
  * trace_call_bpf - invoke BPF program
  * @call: tracepoint event
@@ -1089,6 +1091,18 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_kmulti = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_get_attach_cookie_uprobe_multi, struct pt_regs *, regs)
+{
+	return bpf_uprobe_multi_cookie(current->bpf_ctx);
+}
+
+static const struct bpf_func_proto bpf_get_attach_cookie_proto_umulti = {
+	.func		= bpf_get_attach_cookie_uprobe_multi,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 BPF_CALL_1(bpf_get_attach_cookie_trace, void *, ctx)
 {
 	struct bpf_trace_run_ctx *run_ctx;
@@ -1535,9 +1549,11 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 			&bpf_get_func_ip_proto_kprobe_multi :
 			&bpf_get_func_ip_proto_kprobe;
 	case BPF_FUNC_get_attach_cookie:
-		return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
-			&bpf_get_attach_cookie_proto_kmulti :
-			&bpf_get_attach_cookie_proto_trace;
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI)
+			return &bpf_get_attach_cookie_proto_kmulti;
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
+			return &bpf_get_attach_cookie_proto_umulti;
+		return &bpf_get_attach_cookie_proto_trace;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
@@ -2911,6 +2927,7 @@ struct bpf_uprobe {
 	struct inode *inode;
 	loff_t offset;
 	loff_t ref_ctr_offset;
+	u64 cookie;
 	struct uprobe_consumer consumer;
 };
 
@@ -2923,6 +2940,7 @@ struct bpf_uprobe_multi_link {
 struct bpf_uprobe_multi_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	unsigned long entry_ip;
+	struct bpf_uprobe *uprobe;
 };
 
 static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
@@ -2964,6 +2982,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_uprobe_multi_link *link = uprobe->link;
 	struct bpf_uprobe_multi_run_ctx run_ctx = {
 		.entry_ip = entry_ip,
+		.uprobe = uprobe,
 	};
 	struct bpf_run_ctx *old_run_ctx;
 	int err;
@@ -3005,6 +3024,16 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	return uprobe_prog_run(uprobe, func, regs);
 }
 
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
+{
+	struct bpf_uprobe_multi_run_ctx *run_ctx;
+
+	if (WARN_ON_ONCE(!ctx))
+		return 0;
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	return run_ctx->uprobe->cookie;
+}
+
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	void __user **upaths, __user *upath, __user *old_upath = NULL;
@@ -3014,6 +3043,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	struct bpf_link_primer link_primer;
 	struct bpf_uprobe *uprobes = NULL;
 	struct inode *inode, *old_inode;
+	u64 __user *ucookies, cookie = 0;
 	u32 flags, cnt, i;
 	int err;
 
@@ -3034,6 +3064,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
+	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
 
 	cnt = attr->link_create.uprobe_multi.cnt;
 	if (!cnt)
@@ -3050,6 +3081,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	}
 
 	for (i = 0; i < cnt; i++) {
+		if (ucookies && __get_user(cookie, ucookies + i)) {
+			err = -EFAULT;
+			goto error;
+		}
 		if (uref_ctr_offsets && __get_user(ref_ctr_offset, uref_ctr_offsets + i)) {
 			err = -EFAULT;
 			goto error;
@@ -3090,6 +3125,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		uprobes[i].inode = inode;
 		uprobes[i].offset = offset;
 		uprobes[i].ref_ctr_offset = ref_ctr_offset;
+		uprobes[i].cookie = cookie;
 		uprobes[i].link = link;
 
 		if (flags & BPF_F_UPROBE_MULTI_RETURN)
@@ -3131,4 +3167,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 {
 	return -EOPNOTSUPP;
 }
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
+{
+	return 0;
+}
 #endif /* CONFIG_UPROBES */
-- 
2.40.0

