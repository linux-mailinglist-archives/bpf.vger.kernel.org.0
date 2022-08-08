Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8358CA2C
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiHHOI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243127AbiHHOI6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:08:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85701E0FF
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D8160DE0
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0A3C433D6;
        Mon,  8 Aug 2022 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967736;
        bh=eWZqMpYAFiSfLO35cd2yQHt/uZkehHOtMaKBsbdvTJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cACV7ab9mNU2lFda+8QEzYDhssu+vDSKPRxefWp8tdYBb6qr+q7wQBn6FkmDogy2O
         JRh4vyYgBGTxElZpCPOvKKDyXjdKvzXp9Wvb2UzkotrQMjphNtEmasNX5BmeJfdcc9
         nKBRpjpn3PA3/quTKWgrwBeUymoxXmAiKu3T2LAheG8Ks0Vq34Oi81Ar97jOmu57lJ
         SiBXN97pCRFsleV28nIJNCStUqvD2AeVWmgC9sQalKt3rkzMO/H6ySWu7FTuKTHLSd
         iZhFXsIQ3j2Eqi43ZbiRe7CSnIz68vB7yeOSnCvm4KVoO3WITNKcpuo70QAzaq4OsA
         JlmszJVBflhEA==
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
Subject: [RFC PATCH bpf-next 13/17] libbpf: Add support to create tracing multi link
Date:   Mon,  8 Aug 2022 16:06:22 +0200
Message-Id: <20220808140626.422731-14-jolsa@kernel.org>
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

Adding new interface tion to attach programs with
tracing multi link:

  bpf_program__attach_tracing_multi(const struct bpf_program *prog,
                             const char *pattern,
                             const struct bpf_tracing_multi_opts *opts);

The program is attach to functions specified by patter
or by btf IDs specified in bpf_tracing_multi_opts object.

Adding support for new sections to attach programs
with above functions:

   fentry.multi/pattern
   fexit.multi/pattern

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c      |  7 ++++
 tools/lib/bpf/bpf.h      |  4 ++
 tools/lib/bpf/libbpf.c   | 89 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 14 +++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 115 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index efcc06dafbd9..06e6666ee90e 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -713,6 +713,13 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, kprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+		attr.link_create.tracing_multi.btf_ids = (__u64) OPTS_GET(opts, tracing_multi.btf_ids, 0);
+		attr.link_create.tracing_multi.btf_ids_cnt = OPTS_GET(opts, tracing_multi.btf_ids_cnt, 0);
+		if (!OPTS_ZEROED(opts, tracing_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9c50beabdd14..71676228f032 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -321,6 +321,10 @@ struct bpf_link_create_opts {
 		struct {
 			__u64 cookie;
 		} tracing;
+		struct {
+			__u32 *btf_ids;
+			__u32  btf_ids_cnt;
+		} tracing_multi;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0952eac92eab..209a42bed165 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -116,6 +116,8 @@ static const char * const attach_type_name[] = {
 	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_reuseport_select_or_migrate",
 	[BPF_PERF_EVENT]		= "perf_event",
 	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
+	[BPF_TRACE_FENTRY_MULTI]	= "trace_fentry_multi",
+	[BPF_TRACE_FEXIT_MULTI]		= "trace_fexit_multi",
 };
 
 static const char * const link_type_name[] = {
@@ -129,6 +131,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_PERF_EVENT]		= "perf_event",
 	[BPF_LINK_TYPE_KPROBE_MULTI]		= "kprobe_multi",
 	[BPF_LINK_TYPE_STRUCT_OPS]		= "struct_ops",
+	[BPF_LINK_TYPE_TRACING_MULTI]		= "tracing_multi",
 };
 
 static const char * const map_type_name[] = {
@@ -8445,6 +8448,7 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -8477,6 +8481,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fentry.multi/",	TRACING, BPF_TRACE_FENTRY_MULTI, 0, attach_tracing_multi),
+	SEC_DEF("fexit.multi/",		TRACING, BPF_TRACE_FEXIT_MULTI, 0, attach_tracing_multi),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
@@ -10374,6 +10380,89 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return libbpf_get_error(*link);
 }
 
+struct bpf_link *
+bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
+				  const struct bpf_tracing_multi_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	__u32 *btf_ids, cnt, *free_ids = NULL;
+	char errmsg[STRERR_BUFSIZE];
+	int prog_fd, link_fd, err;
+	struct bpf_link *link;
+
+	btf_ids = OPTS_GET(opts, btf_ids, false);
+	cnt = OPTS_GET(opts, cnt, false);
+
+	if (!pattern && !btf_ids && !cnt)
+		return libbpf_err_ptr(-EINVAL);
+	if (pattern && (btf_ids || cnt))
+		return libbpf_err_ptr(-EINVAL);
+
+	if (pattern) {
+		err = bpf_object__load_vmlinux_btf(prog->obj, true);
+		if (err)
+			return libbpf_err_ptr(err);
+
+		cnt = btf__find_by_glob_kind(prog->obj->btf_vmlinux, BTF_KIND_FUNC,
+					     pattern, NULL, &btf_ids);
+		if (cnt <= 0)
+			return libbpf_err_ptr(-EINVAL);
+		free_ids = btf_ids;
+	}
+
+	lopts.tracing_multi.btf_ids = btf_ids;
+	lopts.tracing_multi.btf_ids_cnt = cnt;
+
+	link = calloc(1, sizeof(*link));
+	if (!link)
+		return libbpf_err_ptr(-ENOMEM);
+	link->detach = &bpf_link__detach_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	link_fd = bpf_link_create(prog_fd, 0, prog->expected_attach_type, &lopts);
+	if (link_fd < 0) {
+		err = -errno;
+		pr_warn("prog '%s': failed to attach: %s\n",
+			prog->name, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		goto error;
+	}
+	link->fd = link_fd;
+	free(free_ids);
+	return link;
+error:
+	free(link);
+	free(free_ids);
+	return libbpf_err_ptr(err);
+}
+
+static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	const char *spec;
+	char *pattern;
+	bool is_fexit;
+	int n;
+
+	/* no auto-attach for SEC("fentry.multi") and SEC("fexit.multi") */
+	if (strcmp(prog->sec_name, "fentry.multi") == 0 ||
+	    strcmp(prog->sec_name, "fexit.multi") == 0)
+		return 0;
+
+	is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/");
+	if (is_fexit)
+		spec = prog->sec_name + sizeof("fexit.multi/") - 1;
+	else
+		spec = prog->sec_name + sizeof("fentry.multi/") - 1;
+
+	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
+	if (n < 1) {
+		pr_warn("tracing multi pattern is invalid: %s\n", pattern);
+		return -EINVAL;
+	}
+
+	*link = bpf_program__attach_tracing_multi(prog, pattern, NULL);
+	return libbpf_get_error(*link);
+}
+
 static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *binary_path, uint64_t offset)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 61493c4cddac..07992d8ee06c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -503,6 +503,20 @@ bpf_program__attach_ksyscall(const struct bpf_program *prog,
 			     const char *syscall_name,
 			     const struct bpf_ksyscall_opts *opts);
 
+struct bpf_tracing_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 *btf_ids;
+	size_t cnt;
+	size_t :0;
+};
+
+#define bpf_kprobe_multi_opts__last_field retprobe
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
+				  const struct bpf_tracing_multi_opts *opts);
+
 struct bpf_uprobe_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 119e6e1ea7f1..2168516a75a5 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -358,6 +358,7 @@ LIBBPF_1.0.0 {
 		bpf_obj_get_opts;
 		bpf_prog_query_opts;
 		bpf_program__attach_ksyscall;
+		bpf_program__attach_tracing_multi;
 		btf__add_enum64;
 		btf__add_enum64_value;
 		libbpf_bpf_attach_type_str;
-- 
2.37.1

