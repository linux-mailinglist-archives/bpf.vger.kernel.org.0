Return-Path: <bpf+bounces-10849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECB57AE564
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 08:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 80F56281A65
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341D63BE;
	Tue, 26 Sep 2023 05:59:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738C4C67;
	Tue, 26 Sep 2023 05:59:41 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B72F2;
	Mon, 25 Sep 2023 22:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6bfFaZTvpZ2ZZyiYDgAPyUZxcdsEioTye12nuqDnhRk=; b=KesGhcAmLK5anKh623dL2t8hbj
	9dawV2InFkKEYmiovp0Y2IJPTHTAzP4ivnMPOd4souo928roexMs0LN37b2XSwqIPikakQB3qh24/
	Lk3A924zMyfyc76y1GTmn3e/XlmrPQcgiy2uuimW6LL8FRd4aAjp6uS8Rvk8Y5n5/UfZ8n5io6i3O
	rpiknjsRqSnCetrlY8kxfo1c+X/yaoI4zzZN52vuYIbjepgsdiYcQT3EVc7x8gwCur7REami8/KUL
	oaoUKzK2toHYjbKB13zk87ZvCWzL24O3Rq435z/BugfFQL/dZeTawHTesNRd+vSWssKvXlsJmidL9
	X9S5PEIg==;
Received: from mob-194-230-148-205.cgn.sunrise.net ([194.230.148.205] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ql16e-0006np-R3; Tue, 26 Sep 2023 07:59:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 4/8] libbpf: Add link-based API for meta
Date: Tue, 26 Sep 2023 07:59:09 +0200
Message-Id: <20230926055913.9859-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230926055913.9859-1-daniel@iogearbox.net>
References: <20230926055913.9859-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27042/Mon Sep 25 09:37:53 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This adds bpf_program__attach_meta() API to libbpf. Overall it is very
similar to tcx. The API looks as following:

  LIBBPF_API struct bpf_link *
  bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
                           bool peer_device, const struct bpf_meta_opts *opts);

The struct bpf_meta_opts is done in similar way as struct bpf_tcx_opts.
bpf_program__attach_meta() compared to bpf_program__attach_tcx() has one
additional argument, that is peer_device. The latter denotes whether the
program should be attached to the relative peer of ifindex or whether it
should be attached to ifindex itself.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/bpf.c      | 16 +++++++++++
 tools/lib/bpf/bpf.h      |  5 ++++
 tools/lib/bpf/libbpf.c   | 61 ++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h   | 15 ++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b0f1913763a3..f1335333b63c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -810,6 +810,22 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, tcx))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_META_PRIMARY:
+	case BPF_META_PEER:
+		relative_fd = OPTS_GET(opts, meta.relative_fd, 0);
+		relative_id = OPTS_GET(opts, meta.relative_id, 0);
+		if (relative_fd && relative_id)
+			return libbpf_err(-EINVAL);
+		if (relative_id) {
+			attr.link_create.meta.relative_id = relative_id;
+			attr.link_create.flags |= BPF_F_ID;
+		} else {
+			attr.link_create.meta.relative_fd = relative_fd;
+		}
+		attr.link_create.meta.expected_revision = OPTS_GET(opts, meta.expected_revision, 0);
+		if (!OPTS_ZEROED(opts, meta))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 74c2887cfd24..175cfb95a175 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -415,6 +415,11 @@ struct bpf_link_create_opts {
 			__u32 relative_id;
 			__u64 expected_revision;
 		} tcx;
+		struct {
+			__u32 relative_fd;
+			__u32 relative_id;
+			__u64 expected_revision;
+		} meta;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b4758e54a815..4d4da8ba2179 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -121,6 +121,8 @@ static const char * const attach_type_name[] = {
 	[BPF_TCX_INGRESS]		= "tcx_ingress",
 	[BPF_TCX_EGRESS]		= "tcx_egress",
 	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
+	[BPF_META_PRIMARY]		= "meta",
+	[BPF_META_PEER]			= "meta",
 };
 
 static const char * const link_type_name[] = {
@@ -137,6 +139,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_NETFILTER]		= "netfilter",
 	[BPF_LINK_TYPE_TCX]			= "tcx",
 	[BPF_LINK_TYPE_UPROBE_MULTI]		= "uprobe_multi",
+	[BPF_LINK_TYPE_META]			= "meta",
 };
 
 static const char * const map_type_name[] = {
@@ -8910,6 +8913,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE), /* deprecated / legacy, use tcx */
 	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE), /* deprecated / legacy, use tcx */
 	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE), /* deprecated / legacy, use tcx */
+	SEC_DEF("meta",			SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("tracepoint+",		TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("tp+",			TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("raw_tracepoint+",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
@@ -12019,11 +12023,11 @@ static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_li
 }
 
 static struct bpf_link *
-bpf_program_attach_fd(const struct bpf_program *prog,
-		      int target_fd, const char *target_name,
-		      const struct bpf_link_create_opts *opts)
+bpf_program_attach_fd_type(const struct bpf_program *prog,
+			   int target_fd, const char *target_name,
+			   enum bpf_attach_type attach_type,
+			   const struct bpf_link_create_opts *opts)
 {
-	enum bpf_attach_type attach_type;
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, link_fd;
@@ -12038,8 +12042,6 @@ bpf_program_attach_fd(const struct bpf_program *prog,
 	if (!link)
 		return libbpf_err_ptr(-ENOMEM);
 	link->detach = &bpf_link__detach_fd;
-
-	attach_type = bpf_program__expected_attach_type(prog);
 	link_fd = bpf_link_create(prog_fd, target_fd, attach_type, opts);
 	if (link_fd < 0) {
 		link_fd = -errno;
@@ -12053,6 +12055,16 @@ bpf_program_attach_fd(const struct bpf_program *prog,
 	return link;
 }
 
+static struct bpf_link *
+bpf_program_attach_fd(const struct bpf_program *prog,
+		      int target_fd, const char *target_name,
+		      const struct bpf_link_create_opts *opts)
+{
+	return bpf_program_attach_fd_type(prog, target_fd, target_name,
+					  bpf_program__expected_attach_type(prog),
+					  opts);
+}
+
 struct bpf_link *
 bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd)
 {
@@ -12106,6 +12118,43 @@ bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
 	return bpf_program_attach_fd(prog, ifindex, "tcx", &link_create_opts);
 }
 
+struct bpf_link *
+bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
+			 bool peer_device, const struct bpf_meta_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
+	enum bpf_attach_type attach_type;
+	__u32 relative_id;
+	int relative_fd;
+
+	if (!OPTS_VALID(opts, bpf_meta_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	relative_id = OPTS_GET(opts, relative_id, 0);
+	relative_fd = OPTS_GET(opts, relative_fd, 0);
+	attach_type = peer_device ? BPF_META_PEER : BPF_META_PRIMARY;
+
+	/* validate we don't have unexpected combinations of non-zero fields */
+	if (!ifindex) {
+		pr_warn("prog '%s': target netdevice ifindex cannot be zero\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+	if (relative_fd && relative_id) {
+		pr_warn("prog '%s': relative_fd and relative_id cannot be set at the same time\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	link_create_opts.meta.expected_revision = OPTS_GET(opts, expected_revision, 0);
+	link_create_opts.meta.relative_fd = relative_fd;
+	link_create_opts.meta.relative_id = relative_id;
+	link_create_opts.flags = OPTS_GET(opts, flags, 0);
+
+	return bpf_program_attach_fd_type(prog, ifindex, "meta", attach_type,
+					  &link_create_opts);
+}
+
 struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 					      int target_fd,
 					      const char *attach_func_name)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0e52621cba43..827d29cf9a06 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -800,6 +800,21 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
 			const struct bpf_tcx_opts *opts);
 
+struct bpf_meta_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 flags;
+	__u32 relative_fd;
+	__u32 relative_id;
+	__u64 expected_revision;
+	size_t :0;
+};
+#define bpf_meta_opts__last_field expected_revision
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
+			 bool peer_device, const struct bpf_meta_opts *opts);
+
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 57712321490f..2dd4fe2cba3d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -397,6 +397,7 @@ LIBBPF_1.3.0 {
 		bpf_obj_pin_opts;
 		bpf_object__unpin;
 		bpf_prog_detach_opts;
+		bpf_program__attach_meta;
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
-- 
2.34.1


