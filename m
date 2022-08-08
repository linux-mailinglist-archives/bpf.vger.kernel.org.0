Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0E158CA1E
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiHHOHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiHHOHU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:07:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9258EE2E
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E762B80EB3
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D425CC433C1;
        Mon,  8 Aug 2022 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967636;
        bh=+Lu9JjGawxYiBoSSMl+YO5W0AaELip0KX2jsCv9Qw+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/aHPsc38oLKpyH/i3KqDEwEeXTw+AEPK/jV2lrE3a8uDSBNEmwTL6ZM88/cyOzpt
         S4c8lHyH57lcurvU2owcwmzOUMTkwyK7x1q72hXbIzBVk8oN+qZ9okuhxeNh40Zrq0
         iB5GvAFVLaq6rDY3hyjtOn139xEJcTSc1HQKVm1CBOKcK3RgWd9gdYd2oa0jVFPoJR
         TrzOnmS4Wvvcp/mxHG0+jQrGillqZs5tAHZ3GxFlhHcdzmEunGLkZ8lVEj89AsZxTC
         1MpjBBkz/9ifSyZqeMyrpVArTR24icH3WRk/SzynHL2Tg1+VGkqx2xnlHABVRhAyq2
         2z51qgYTzHGMQ==
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
Subject: [RFC PATCH bpf-next 04/17] bpf: Add multi tracing attach types
Date:   Mon,  8 Aug 2022 16:06:13 +0200
Message-Id: <20220808140626.422731-5-jolsa@kernel.org>
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

Adding new attach type to identify multi tracing attachment:
  BPF_TRACE_FENTRY_MULTI
  BPF_TRACE_FEXIT_MULTI

Programs with such attach type will use specific link attachment
interface coming in following changes.

This was suggested by Andrii some (long) time ago and turned out
to be easier than having special program flag for that.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  5 +++++
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/syscall.c           | 35 ++++++++++++++++++++++++++++++----
 kernel/bpf/trampoline.c        |  3 +++
 kernel/bpf/verifier.c          |  8 +++++++-
 net/bpf/test_run.c             |  2 ++
 tools/include/uapi/linux/bpf.h |  2 ++
 7 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0617982ca859..32168ea92551 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1256,6 +1256,11 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 
+static inline bool is_tracing_multi(enum bpf_attach_type type)
+{
+	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI;
+}
+
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
 struct bpf_dummy_ops_state {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7bf9ba1329be..fb6bc2c5e9e8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -999,6 +999,8 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 42272909ac08..2e4765c7e6d4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/btf_ids.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -2304,7 +2305,8 @@ static int
 bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 			   enum bpf_attach_type expected_attach_type,
 			   struct btf *attach_btf, u32 btf_id,
-			   struct bpf_prog *dst_prog)
+			   struct bpf_prog *dst_prog,
+			   bool multi_func)
 {
 	if (btf_id) {
 		if (btf_id > BTF_MAX_TYPE)
@@ -2324,6 +2326,14 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		}
 	}
 
+	if (multi_func) {
+		if (prog_type != BPF_PROG_TYPE_TRACING)
+			return -EINVAL;
+		if (!attach_btf || btf_id)
+			return -EINVAL;
+		return 0;
+	}
+
 	if (attach_btf && (!btf_id || dst_prog))
 		return -EINVAL;
 
@@ -2447,6 +2457,16 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+#define DEFINE_BPF_MULTI_FUNC(args...)			\
+	extern int bpf_multi_func(args);		\
+	int __init bpf_multi_func(args) { return 0; }
+
+DEFINE_BPF_MULTI_FUNC(unsigned long a1, unsigned long a2,
+		      unsigned long a3, unsigned long a4,
+		      unsigned long a5, unsigned long a6)
+
+BTF_ID_LIST_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
+
 /* last field in 'union bpf_attr' used by this command */
 #define	BPF_PROG_LOAD_LAST_FIELD core_relo_rec_size
 
@@ -2457,6 +2477,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 	struct btf *attach_btf = NULL;
 	int err;
 	char license[128];
+	bool multi_func;
 	bool is_gpl;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
@@ -2498,6 +2519,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 	if (is_perfmon_prog_type(type) && !perfmon_capable())
 		return -EPERM;
 
+	multi_func = is_tracing_multi(attr->expected_attach_type);
+
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
 	 */
@@ -2516,7 +2539,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 				return -ENOTSUPP;
 			}
 		}
-	} else if (attr->attach_btf_id) {
+	} else if (attr->attach_btf_id || multi_func) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(attach_btf))
@@ -2529,7 +2552,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 	bpf_prog_load_fixup_attach_type(attr);
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
-				       dst_prog)) {
+				       dst_prog, multi_func)) {
 		if (dst_prog)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
@@ -2549,7 +2572,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->aux->attach_btf = attach_btf;
-	prog->aux->attach_btf_id = attr->attach_btf_id;
+	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
 	prog->aux->offload_requested = !!attr->prog_ifindex;
 	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
@@ -2955,6 +2978,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
+		    prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -3429,6 +3454,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 854d0a3b9b31..56899d63c08c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -112,6 +112,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
+		 eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI ||
 		 eatype == BPF_MODIFY_RETURN)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
@@ -529,10 +530,12 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FENTRY_MULTI:
 		return BPF_TRAMP_FENTRY;
 	case BPF_MODIFY_RETURN:
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FEXIT_MULTI:
 		return BPF_TRAMP_FEXIT;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 096fdac70165..5bc2e4183b58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10526,6 +10526,8 @@ static int check_return_code(struct bpf_verifier_env *env)
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			range = tnum_const(0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -14289,6 +14291,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_FEXIT_MULTI ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -14937,6 +14940,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -15093,7 +15098,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		if (!bpf_iter_prog_supported(prog))
 			return -EINVAL;
 		return 0;
-	}
+	} else if (is_tracing_multi(prog->expected_attach_type))
+		return prog->type == BPF_PROG_TYPE_TRACING ? 0 : -EINVAL;
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
 		ret = bpf_lsm_verify_prog(&env->log, prog);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index cbc9cd5058cb..2cb78d4b0d32 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -760,6 +760,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 59a217ca2dfd..94d623affd5f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -999,6 +999,8 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.37.1

