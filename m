Return-Path: <bpf+bounces-4635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CEF74DEEE
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E24281308
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C31640F;
	Mon, 10 Jul 2023 20:12:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EDA156E2;
	Mon, 10 Jul 2023 20:12:31 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5513E;
	Mon, 10 Jul 2023 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lf3gZj1zsCoOiDY6052oPddd8D0zUBkK+sC6Y9HsYMg=; b=W0wg12k5CgdC3eUJ98/j+wcc6B
	AuaOqLMLpS7oUhZyJJP5iEHPBHL0YAv09KWDrh/QvxtDmADmLmi1iWHJn1eDep4qt74Y7AvlZPVpb
	/VJCutQNSFmEoePsbv0WqkUaHCRpv/0xh7oeSNibNRazAMXJppHT0QMHXbHQZ6hgAyTmQC6e1SwMG
	Xa+wKd/08GwUEcZ69UVxH7B39R4CgzeAxjik3ZltN7nvgAx7xMxZjEm0WAMrAwAOLULn87A98pa/d
	zMtw0uBmf0HgTO4s2CMkdQuT880aJO3FevcCi34SGxDvL0t8FC3ZoIvdZMCSobvTNdeTOy/CRZGlg
	jHKRzylQ==;
Received: from 12.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.12] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIxFD-000E4j-IA; Mon, 10 Jul 2023 22:12:27 +0200
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
Subject: [PATCH bpf-next v4 4/8] libbpf: Add link-based API for tcx
Date: Mon, 10 Jul 2023 22:12:14 +0200
Message-Id: <20230710201218.19460-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230710201218.19460-1-daniel@iogearbox.net>
References: <20230710201218.19460-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement tcx BPF link support for libbpf.

The bpf_program__attach_fd() API has been refactored slightly in order to pass
bpf_link_create_opts pointer as input.

A new bpf_program__attach_tcx() has been added on top of this which allows for
passing all relevant data via extensible struct bpf_tcx_opts.

The program sections tcx/ingress and tcx/egress correspond to the hook locations
for tc ingress and egress, respectively.

For concrete usage examples, see the extensive selftests that have been
developed as part of this series.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/bpf.c      | 19 ++++++++++--
 tools/lib/bpf/bpf.h      |  5 ++++
 tools/lib/bpf/libbpf.c   | 62 ++++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h   | 16 +++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 3dfc43b477c3..d513c226b9aa 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -717,9 +717,9 @@ int bpf_link_create(int prog_fd, int target_fd,
 		    const struct bpf_link_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, link_create);
-	__u32 target_btf_id, iter_info_len;
+	__u32 target_btf_id, iter_info_len, relative_id;
+	int fd, err, relative;
 	union bpf_attr attr;
-	int fd, err;
 
 	if (!OPTS_VALID(opts, bpf_link_create_opts))
 		return libbpf_err(-EINVAL);
@@ -781,6 +781,21 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, netfilter))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TCX_INGRESS:
+	case BPF_TCX_EGRESS:
+		relative = OPTS_GET(opts, tcx.relative_fd, 0);
+		relative_id = OPTS_GET(opts, tcx.relative_id, 0);
+		if (relative > 0 && relative_id)
+			return libbpf_err(-EINVAL);
+		if (relative_id) {
+			relative = relative_id;
+			attr.link_create.flags |= BPF_F_ID;
+		}
+		attr.link_create.tcx.relative_fd = relative;
+		attr.link_create.tcx.expected_revision = OPTS_GET(opts, tcx.expected_revision, 0);
+		if (!OPTS_ZEROED(opts, tcx))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 49e9d88fd9cf..044a74ffc38a 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -401,6 +401,11 @@ struct bpf_link_create_opts {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__u32 relative_fd;
+			__u32 relative_id;
+			__u64 expected_revision;
+		} tcx;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bd621c916783..aa94d4af0ecb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -134,6 +134,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_KPROBE_MULTI]		= "kprobe_multi",
 	[BPF_LINK_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_LINK_TYPE_NETFILTER]		= "netfilter",
+	[BPF_LINK_TYPE_TCX]			= "tcx",
 };
 
 static const char * const map_type_name[] = {
@@ -11845,11 +11846,10 @@ static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_li
 }
 
 static struct bpf_link *
-bpf_program__attach_fd(const struct bpf_program *prog, int target_fd, int btf_id,
-		       const char *target_name)
+bpf_program_attach_fd(const struct bpf_program *prog,
+		      int target_fd, const char *target_name,
+		      const struct bpf_link_create_opts *opts)
 {
-	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts,
-			    .target_btf_id = btf_id);
 	enum bpf_attach_type attach_type;
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
@@ -11867,7 +11867,7 @@ bpf_program__attach_fd(const struct bpf_program *prog, int target_fd, int btf_id
 	link->detach = &bpf_link__detach_fd;
 
 	attach_type = bpf_program__expected_attach_type(prog);
-	link_fd = bpf_link_create(prog_fd, target_fd, attach_type, &opts);
+	link_fd = bpf_link_create(prog_fd, target_fd, attach_type, opts);
 	if (link_fd < 0) {
 		link_fd = -errno;
 		free(link);
@@ -11883,19 +11883,58 @@ bpf_program__attach_fd(const struct bpf_program *prog, int target_fd, int btf_id
 struct bpf_link *
 bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd)
 {
-	return bpf_program__attach_fd(prog, cgroup_fd, 0, "cgroup");
+	return bpf_program_attach_fd(prog, cgroup_fd, "cgroup", NULL);
 }
 
 struct bpf_link *
 bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd)
 {
-	return bpf_program__attach_fd(prog, netns_fd, 0, "netns");
+	return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
 }
 
 struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex)
 {
 	/* target_fd/target_ifindex use the same field in LINK_CREATE */
-	return bpf_program__attach_fd(prog, ifindex, 0, "xdp");
+	return bpf_program_attach_fd(prog, ifindex, "xdp", NULL);
+}
+
+struct bpf_link *
+bpf_program__attach_tcx(const struct bpf_program *prog,
+			const struct bpf_tcx_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
+	__u32 relative_id, flags;
+	int ifindex, relative_fd;
+
+	if (!OPTS_VALID(opts, bpf_tcx_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	relative_id = OPTS_GET(opts, relative_id, 0);
+	relative_fd = OPTS_GET(opts, relative_fd, 0);
+	flags = OPTS_GET(opts, flags, 0);
+	ifindex = OPTS_GET(opts, ifindex, 0);
+
+	/* validate we don't have unexpected combinations of non-zero fields */
+	if (!ifindex) {
+		pr_warn("prog '%s': target netdevice ifindex cannot be zero\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+	if (relative_fd > 0 && relative_id) {
+		pr_warn("prog '%s': relative_fd and relative_id cannot be set at the same time\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+	if (relative_id)
+		flags |= BPF_F_ID;
+
+	link_create_opts.tcx.expected_revision = OPTS_GET(opts, expected_revision, 0);
+	link_create_opts.tcx.relative_fd = relative_fd;
+	link_create_opts.tcx.relative_id = relative_id;
+	link_create_opts.flags = flags;
+
+	/* target_fd/target_ifindex use the same field in LINK_CREATE */
+	return bpf_program_attach_fd(prog, ifindex, "tc", &link_create_opts);
 }
 
 struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
@@ -11917,11 +11956,16 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	}
 
 	if (target_fd) {
+		LIBBPF_OPTS(bpf_link_create_opts, target_opts);
+
 		btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd);
 		if (btf_id < 0)
 			return libbpf_err_ptr(btf_id);
 
-		return bpf_program__attach_fd(prog, target_fd, btf_id, "freplace");
+		target_opts.target_btf_id = btf_id;
+
+		return bpf_program_attach_fd(prog, target_fd, "freplace",
+					     &target_opts);
 	} else {
 		/* no target, so use raw_tracepoint_open for compatibility
 		 * with old kernels
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 10642ad69d76..33f60a318e81 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -733,6 +733,22 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_netfilter(const struct bpf_program *prog,
 			      const struct bpf_netfilter_opts *opts);
 
+struct bpf_tcx_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	int ifindex;
+	__u32 flags;
+	__u32 relative_fd;
+	__u32 relative_id;
+	__u64 expected_revision;
+	size_t :0;
+};
+#define bpf_tcx_opts__last_field expected_revision
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_tcx(const struct bpf_program *prog,
+			const struct bpf_tcx_opts *opts);
+
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a95d39bbef90..2a2db5c78048 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -397,4 +397,5 @@ LIBBPF_1.3.0 {
 		bpf_obj_pin_opts;
 		bpf_program__attach_netfilter;
 		bpf_prog_detach_opts;
+		bpf_program__attach_tcx;
 } LIBBPF_1.2.0;
-- 
2.34.1


