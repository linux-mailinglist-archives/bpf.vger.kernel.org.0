Return-Path: <bpf+bounces-12744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D87D0362
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A720428233C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182833E008;
	Thu, 19 Oct 2023 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DvIiDqaj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316F171B6;
	Thu, 19 Oct 2023 20:50:05 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF68124;
	Thu, 19 Oct 2023 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ORIi9H6LZC6oKU2ilTN6TDXwj7O7Am6C11fwhRW35oM=; b=DvIiDqajbjMbO+cy5DZjZT1x8S
	vhjRoWrRevBmemkoCNiADTysbvD7YBZeA+JEC46qP1aBAhg6R+KNmkfNupGTDFGzh9gh5PCYGWOkg
	2cGJfGlXlkILRzk6yQ+2bslBDYDXE9npSR5KMOa1a1RnGZIJU99XEexgs0VyqLmEEubatJBV2iU6q
	qP6W4RLFcdi/BD4Q7LQsgJymjfmy4lDjsENWkAyUogDI3jkOHhhtaTCf+duUXYyBOW8y/8d6ecic0
	hwXUs2vW13LIhLhnQaKkDVCmw6f+Ey8aJwfZ2k2ipKtbTsivNvdApMLI7qAUCT2n01pJJaIn2N95S
	+vlOPYgA==;
Received: from 21.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.21] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qtZxo-000Ndt-Np; Thu, 19 Oct 2023 22:49:52 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	sdf@google.com,
	toke@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 3/7] libbpf: Add link-based API for netkit
Date: Thu, 19 Oct 2023 22:49:15 +0200
Message-Id: <20231019204919.4203-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231019204919.4203-1-daniel@iogearbox.net>
References: <20231019204919.4203-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27066/Thu Oct 19 09:45:47 2023)
X-Spam-Level: *

This adds bpf_program__attach_netkit() API to libbpf. Overall it is very
similar to tcx. The API looks as following:

  LIBBPF_API struct bpf_link *
  bpf_program__attach_netkit(const struct bpf_program *prog, int ifindex,
                             const struct bpf_netkit_opts *opts);

The struct bpf_netkit_opts is done in similar way as struct bpf_tcx_opts
for supporting bpf_mprog control parameters. The attach location for the
primary and peer device is derived from the program section "netkit/primary"
and "netkit/peer", respectively.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/bpf.c      | 16 ++++++++++++++++
 tools/lib/bpf/bpf.h      |  5 +++++
 tools/lib/bpf/libbpf.c   | 39 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 15 +++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 76 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b0f1913763a3..9dc9625651dc 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -810,6 +810,22 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, tcx))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_NETKIT_PRIMARY:
+	case BPF_NETKIT_PEER:
+		relative_fd = OPTS_GET(opts, netkit.relative_fd, 0);
+		relative_id = OPTS_GET(opts, netkit.relative_id, 0);
+		if (relative_fd && relative_id)
+			return libbpf_err(-EINVAL);
+		if (relative_id) {
+			attr.link_create.netkit.relative_id = relative_id;
+			attr.link_create.flags |= BPF_F_ID;
+		} else {
+			attr.link_create.netkit.relative_fd = relative_fd;
+		}
+		attr.link_create.netkit.expected_revision = OPTS_GET(opts, netkit.expected_revision, 0);
+		if (!OPTS_ZEROED(opts, netkit))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 74c2887cfd24..d0f53772bdc0 100644
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
+		} netkit;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a295f6acf98f..e067be95da3c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -126,6 +126,8 @@ static const char * const attach_type_name[] = {
 	[BPF_TCX_INGRESS]		= "tcx_ingress",
 	[BPF_TCX_EGRESS]		= "tcx_egress",
 	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
+	[BPF_NETKIT_PRIMARY]		= "netkit_primary",
+	[BPF_NETKIT_PEER]		= "netkit_peer",
 };
 
 static const char * const link_type_name[] = {
@@ -142,6 +144,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_NETFILTER]		= "netfilter",
 	[BPF_LINK_TYPE_TCX]			= "tcx",
 	[BPF_LINK_TYPE_UPROBE_MULTI]		= "uprobe_multi",
+	[BPF_LINK_TYPE_NETKIT]			= "netkit",
 };
 
 static const char * const map_type_name[] = {
@@ -8915,6 +8918,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE), /* deprecated / legacy, use tcx */
 	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE), /* deprecated / legacy, use tcx */
 	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE), /* deprecated / legacy, use tcx */
+	SEC_DEF("netkit/primary",	SCHED_CLS, BPF_NETKIT_PRIMARY, SEC_NONE),
+	SEC_DEF("netkit/peer",		SCHED_CLS, BPF_NETKIT_PEER, SEC_NONE),
 	SEC_DEF("tracepoint+",		TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("tp+",			TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("raw_tracepoint+",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
@@ -12126,6 +12131,40 @@ bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
 	return bpf_program_attach_fd(prog, ifindex, "tcx", &link_create_opts);
 }
 
+struct bpf_link *
+bpf_program__attach_netkit(const struct bpf_program *prog, int ifindex,
+			   const struct bpf_netkit_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
+	__u32 relative_id;
+	int relative_fd;
+
+	if (!OPTS_VALID(opts, bpf_netkit_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	relative_id = OPTS_GET(opts, relative_id, 0);
+	relative_fd = OPTS_GET(opts, relative_fd, 0);
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
+	link_create_opts.netkit.expected_revision = OPTS_GET(opts, expected_revision, 0);
+	link_create_opts.netkit.relative_fd = relative_fd;
+	link_create_opts.netkit.relative_id = relative_id;
+	link_create_opts.flags = OPTS_GET(opts, flags, 0);
+
+	return bpf_program_attach_fd(prog, ifindex, "netkit", &link_create_opts);
+}
+
 struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 					      int target_fd,
 					      const char *attach_func_name)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 475378438545..0dd83910ae9a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -800,6 +800,21 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
 			const struct bpf_tcx_opts *opts);
 
+struct bpf_netkit_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 relative_fd;
+	__u32 relative_id;
+	__u64 expected_revision;
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_netkit_opts__last_field flags
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_netkit(const struct bpf_program *prog, int ifindex,
+			   const struct bpf_netkit_opts *opts);
+
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index cc973b678a39..b52dc28dc8af 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -398,6 +398,7 @@ LIBBPF_1.3.0 {
 		bpf_object__unpin;
 		bpf_prog_detach_opts;
 		bpf_program__attach_netfilter;
+		bpf_program__attach_netkit;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
 		ring__avail_data_size;
-- 
2.34.1


