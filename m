Return-Path: <bpf+bounces-4459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D874B5C8
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5F71C21026
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E41171DE;
	Fri,  7 Jul 2023 17:26:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E29171B5;
	Fri,  7 Jul 2023 17:26:03 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950852699;
	Fri,  7 Jul 2023 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pQR4nndkFEbI8YbPRpwRyWS80npSAko3ubwjo8pfZ/I=; b=AaMqDA+tKQzFc+8qZnT8yCiltn
	Xh171i3bguMvA2Pxtxi6HUikBDXf/MPNAq1TeIFtiB2DQledyd7g6V14f9u5XNohbMsiiCq82a8ez
	p+XBCDeGOKcqseiUSJDS/l2Eh6fnAPUvV7uX410YgUtxxYErP7bHOpOlx0MJ/Dtgc23lBiYAl+AtN
	FKhoKLd2sJJb2T2ydio1uLME0x4ahWqwYKfzZdDt8QBffxQwXjzBiVpyk00aHbDb3XazYoWjvyJGO
	doM7m3Imy9Rbn24+r0/7JT7esB0TyuEWrIDf9mrpE4XrKWpud7vcPtGCBGKVtBLeCEYyAwSuEXbpS
	Ab6ZEPSw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qHpCe-000Aww-Ph; Fri, 07 Jul 2023 19:25:08 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	sdf@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	dxu@dxuuu.xyz,
	joe@cilium.io,
	toke@kernel.org,
	davem@davemloft.net,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 3/8] libbpf: Add opts-based attach/detach/query API for tcx
Date: Fri,  7 Jul 2023 19:24:50 +0200
Message-Id: <20230707172455.7634-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230707172455.7634-1-daniel@iogearbox.net>
References: <20230707172455.7634-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26962/Fri Jul  7 09:29:02 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend libbpf attach opts and add a new detach opts API so this can be used
to add/remove fd-based tcx BPF programs. The old-style bpf_prog_detach() and
bpf_prog_detach2() APIs are refactored to reuse the new bpf_prog_detach_opts()
internally.

The bpf_prog_query_opts() API got extended to be able to handle the new
link_ids, link_attach_flags and revision fields.

For concrete usage examples, see the extensive selftests that have been
developed as part of this series.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/bpf.c      | 105 +++++++++++++++++++++++++--------------
 tools/lib/bpf/bpf.h      |  92 ++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.c   |  12 +++--
 tools/lib/bpf/libbpf.map |   1 +
 4 files changed, 157 insertions(+), 53 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 3b0da19715e1..3dfc43b477c3 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -629,55 +629,87 @@ int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
 	return bpf_prog_attach_opts(prog_fd, target_fd, type, &opts);
 }
 
-int bpf_prog_attach_opts(int prog_fd, int target_fd,
-			  enum bpf_attach_type type,
-			  const struct bpf_prog_attach_opts *opts)
+int bpf_prog_attach_opts(int prog_fd, int target,
+			 enum bpf_attach_type type,
+			 const struct bpf_prog_attach_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, expected_revision);
+	__u32 relative_id, flags;
 	union bpf_attr attr;
-	int ret;
+	int ret, relative;
 
 	if (!OPTS_VALID(opts, bpf_prog_attach_opts))
 		return libbpf_err(-EINVAL);
 
+	relative_id = OPTS_GET(opts, relative_id, 0);
+	relative = OPTS_GET(opts, relative_fd, 0);
+	flags = OPTS_GET(opts, flags, 0);
+
+	/* validate we don't have unexpected combinations of non-zero fields */
+	if (relative > 0 && relative_id)
+		return libbpf_err(-EINVAL);
+	if (relative_id) {
+		relative = relative_id;
+		flags |= BPF_F_ID;
+	}
+
 	memset(&attr, 0, attr_sz);
-	attr.target_fd	   = target_fd;
-	attr.attach_bpf_fd = prog_fd;
-	attr.attach_type   = type;
-	attr.attach_flags  = OPTS_GET(opts, flags, 0);
-	attr.replace_bpf_fd = OPTS_GET(opts, replace_prog_fd, 0);
+	attr.target_fd		= target;
+	attr.attach_bpf_fd	= prog_fd;
+	attr.attach_type	= type;
+	attr.attach_flags	= flags;
+	attr.relative_fd	= relative;
+	attr.replace_bpf_fd	= OPTS_GET(opts, replace_fd, 0);
+	attr.expected_revision	= OPTS_GET(opts, expected_revision, 0);
 
 	ret = sys_bpf(BPF_PROG_ATTACH, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
 
-int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
+int bpf_prog_detach_opts(int prog_fd, int target,
+			 enum bpf_attach_type type,
+			 const struct bpf_prog_detach_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, expected_revision);
+	__u32 relative_id, flags;
 	union bpf_attr attr;
-	int ret;
+	int ret, relative;
+
+	if (!OPTS_VALID(opts, bpf_prog_detach_opts))
+		return libbpf_err(-EINVAL);
+
+	relative_id = OPTS_GET(opts, relative_id, 0);
+	relative = OPTS_GET(opts, relative_fd, 0);
+	flags = OPTS_GET(opts, flags, 0);
+
+	/* validate we don't have unexpected combinations of non-zero fields */
+	if (relative > 0 && relative_id)
+		return libbpf_err(-EINVAL);
+	if (relative_id) {
+		relative = relative_id;
+		flags |= BPF_F_ID;
+	}
 
 	memset(&attr, 0, attr_sz);
-	attr.target_fd	 = target_fd;
-	attr.attach_type = type;
+	attr.target_fd		= target;
+	attr.attach_bpf_fd	= prog_fd;
+	attr.attach_type	= type;
+	attr.attach_flags	= flags;
+	attr.relative_fd	= relative;
+	attr.expected_revision	= OPTS_GET(opts, expected_revision, 0);
 
 	ret = sys_bpf(BPF_PROG_DETACH, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
 
-int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
+int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
-	union bpf_attr attr;
-	int ret;
-
-	memset(&attr, 0, attr_sz);
-	attr.target_fd	 = target_fd;
-	attr.attach_bpf_fd = prog_fd;
-	attr.attach_type = type;
+	return bpf_prog_detach_opts(0, target_fd, type, NULL);
+}
 
-	ret = sys_bpf(BPF_PROG_DETACH, &attr, attr_sz);
-	return libbpf_err_errno(ret);
+int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
+{
+	return bpf_prog_detach_opts(prog_fd, target_fd, type, NULL);
 }
 
 int bpf_link_create(int prog_fd, int target_fd,
@@ -841,8 +873,7 @@ int bpf_iter_create(int link_fd)
 	return libbpf_err_errno(fd);
 }
 
-int bpf_prog_query_opts(int target_fd,
-			enum bpf_attach_type type,
+int bpf_prog_query_opts(int target, enum bpf_attach_type type,
 			struct bpf_prog_query_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, query);
@@ -853,18 +884,20 @@ int bpf_prog_query_opts(int target_fd,
 		return libbpf_err(-EINVAL);
 
 	memset(&attr, 0, attr_sz);
-
-	attr.query.target_fd	= target_fd;
-	attr.query.attach_type	= type;
-	attr.query.query_flags	= OPTS_GET(opts, query_flags, 0);
-	attr.query.prog_cnt	= OPTS_GET(opts, prog_cnt, 0);
-	attr.query.prog_ids	= ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
-	attr.query.prog_attach_flags = ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
+	attr.query.target_fd		= target;
+	attr.query.attach_type		= type;
+	attr.query.query_flags		= OPTS_GET(opts, query_flags, 0);
+	attr.query.count		= OPTS_GET(opts, count, 0);
+	attr.query.prog_ids		= ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
+	attr.query.link_ids		= ptr_to_u64(OPTS_GET(opts, link_ids, NULL));
+	attr.query.prog_attach_flags	= ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
+	attr.query.link_attach_flags	= ptr_to_u64(OPTS_GET(opts, link_attach_flags, NULL));
 
 	ret = sys_bpf(BPF_PROG_QUERY, &attr, attr_sz);
 
 	OPTS_SET(opts, attach_flags, attr.query.attach_flags);
-	OPTS_SET(opts, prog_cnt, attr.query.prog_cnt);
+	OPTS_SET(opts, revision, attr.query.revision);
+	OPTS_SET(opts, count, attr.query.count);
 
 	return libbpf_err_errno(ret);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index c676295ab9bf..49e9d88fd9cf 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -312,22 +312,68 @@ LIBBPF_API int bpf_obj_get(const char *pathname);
 LIBBPF_API int bpf_obj_get_opts(const char *pathname,
 				const struct bpf_obj_get_opts *opts);
 
-struct bpf_prog_attach_opts {
-	size_t sz; /* size of this struct for forward/backward compatibility */
-	unsigned int flags;
-	int replace_prog_fd;
-};
-#define bpf_prog_attach_opts__last_field replace_prog_fd
-
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
 			       enum bpf_attach_type type, unsigned int flags);
-LIBBPF_API int bpf_prog_attach_opts(int prog_fd, int attachable_fd,
-				     enum bpf_attach_type type,
-				     const struct bpf_prog_attach_opts *opts);
 LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
 LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
 				enum bpf_attach_type type);
 
+struct bpf_prog_attach_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags;
+	union {
+		int replace_prog_fd;
+		int replace_fd;
+	};
+	int relative_fd;
+	__u32 relative_id;
+	__u64 expected_revision;
+	size_t :0;
+};
+#define bpf_prog_attach_opts__last_field expected_revision
+
+struct bpf_prog_detach_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags;
+	int relative_fd;
+	__u32 relative_id;
+	__u64 expected_revision;
+	size_t :0;
+};
+#define bpf_prog_detach_opts__last_field expected_revision
+
+/**
+ * @brief **bpf_prog_attach_opts()** attaches the BPF program corresponding to
+ * *prog_fd* to a *target* which can represent a file descriptor or netdevice
+ * ifindex.
+ *
+ * @param prog_fd BPF program file descriptor
+ * @param target attach location file descriptor or ifindex
+ * @param type attach type for the BPF program
+ * @param opts options for configuring the attachment
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_prog_attach_opts(int prog_fd, int target,
+				    enum bpf_attach_type type,
+				    const struct bpf_prog_attach_opts *opts);
+
+/**
+ * @brief **bpf_prog_detach_opts()** detaches the BPF program corresponding to
+ * *prog_fd* from a *target* which can represent a file descriptor or netdevice
+ * ifindex.
+ *
+ * @param prog_fd BPF program file descriptor
+ * @param target detach location file descriptor or ifindex
+ * @param type detach type for the BPF program
+ * @param opts options for configuring the detachment
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_prog_detach_opts(int prog_fd, int target,
+				    enum bpf_attach_type type,
+				    const struct bpf_prog_detach_opts *opts);
+
 union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
 struct bpf_link_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
@@ -495,13 +541,31 @@ struct bpf_prog_query_opts {
 	__u32 query_flags;
 	__u32 attach_flags; /* output argument */
 	__u32 *prog_ids;
-	__u32 prog_cnt; /* input+output argument */
+	union {
+		/* input+output argument */
+		__u32 prog_cnt;
+		__u32 count;
+	};
 	__u32 *prog_attach_flags;
+	__u32 *link_ids;
+	__u32 *link_attach_flags;
+	__u64 revision;
+	size_t :0;
 };
-#define bpf_prog_query_opts__last_field prog_attach_flags
+#define bpf_prog_query_opts__last_field revision
 
-LIBBPF_API int bpf_prog_query_opts(int target_fd,
-				   enum bpf_attach_type type,
+/**
+ * @brief **bpf_prog_query_opts()** queries the BPF programs and BPF links
+ * which are attached to *target* which can represent a file descriptor or
+ * netdevice ifindex.
+ *
+ * @param target query location file descriptor or ifindex
+ * @param type attach type for the BPF program
+ * @param opts options for configuring the query
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_prog_query_opts(int target, enum bpf_attach_type type,
 				   struct bpf_prog_query_opts *opts);
 LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
 			      __u32 query_flags, __u32 *attach_flags,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1c6588ad3e75..208aeee31823 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -118,6 +118,8 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
 	[BPF_STRUCT_OPS]		= "struct_ops",
 	[BPF_NETFILTER]			= "netfilter",
+	[BPF_TCX_INGRESS]		= "tcx_ingress",
+	[BPF_TCX_EGRESS]		= "tcx_egress",
 };
 
 static const char * const link_type_name[] = {
@@ -8673,9 +8675,13 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
-	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
-	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE),
-	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE),
+	SEC_DEF("tc/ingress",		SCHED_CLS, BPF_TCX_INGRESS, SEC_NONE), /* alias for tcx */
+	SEC_DEF("tc/egress",		SCHED_CLS, BPF_TCX_EGRESS, SEC_NONE),  /* alias for tcx */
+	SEC_DEF("tcx/ingress",		SCHED_CLS, BPF_TCX_INGRESS, SEC_NONE),
+	SEC_DEF("tcx/egress",		SCHED_CLS, BPF_TCX_EGRESS, SEC_NONE),
+	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE), /* deprecated / legacy, use tcx */
+	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE), /* deprecated / legacy, use tcx */
+	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE), /* deprecated / legacy, use tcx */
 	SEC_DEF("tracepoint+",		TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("tp+",			TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("raw_tracepoint+",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d9ec4407befa..a95d39bbef90 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -396,4 +396,5 @@ LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
 		bpf_program__attach_netfilter;
+		bpf_prog_detach_opts;
 } LIBBPF_1.2.0;
-- 
2.34.1


