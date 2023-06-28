Return-Path: <bpf+bounces-3666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7517414EB
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38581280D65
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A495DD2F6;
	Wed, 28 Jun 2023 15:27:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A03D2E3;
	Wed, 28 Jun 2023 15:27:58 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A532690;
	Wed, 28 Jun 2023 08:27:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qEX5H-000821-Gp; Wed, 28 Jun 2023 17:27:55 +0200
From: Florian Westphal <fw@strlen.de>
To: <bpf@vger.kernel.org>
Cc: "ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, dxu@dxuuu.xyz"@breakpoint.cc,
	<netdev@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v4 1/2] tools: libbpf: add netfilter link attach helper
Date: Wed, 28 Jun 2023 17:27:37 +0200
Message-Id: <20230628152738.22765-2-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628152738.22765-1-fw@strlen.de>
References: <20230628152738.22765-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new api function: bpf_program__attach_netfilter.

It takes a bpf program (netfilter type), and a pointer to a option struct
that contains the desired attachment (protocol family, priority, hook
location, ...).

It returns a pointer to a 'bpf_link' structure or NULL on error.

Next patch adds new netfilter_basic test that uses this function to
attach a program to a few pf/hook/priority combinations.

v2: change name and use bpf_link_create.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Link: https://lore.kernel.org/bpf/CAEf4BzZrmUv27AJp0dDxBDMY_B8e55-wLs8DUKK69vCWsCG_pQ@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAEf4BzZ69YgrQW7DHCJUT_X+GqMq_ZQQPBwopaJJVGFD5=d5Vg@mail.gmail.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/lib/bpf/bpf.c      |  6 ++++++
 tools/lib/bpf/bpf.h      |  6 ++++++
 tools/lib/bpf/libbpf.c   | 42 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 15 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 70 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ed86b37d8024..1b4f85f3c5b1 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -741,6 +741,12 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_NETFILTER:
+		attr.link_create.netfilter.pf = OPTS_GET(opts, netfilter.pf, 0);
+		attr.link_create.netfilter.hooknum = OPTS_GET(opts, netfilter.hooknum, 0);
+		attr.link_create.netfilter.priority = OPTS_GET(opts, netfilter.priority, 0);
+		attr.link_create.netfilter.flags = OPTS_GET(opts, netfilter.flags, 0);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9aa0ee473754..c676295ab9bf 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -349,6 +349,12 @@ struct bpf_link_create_opts {
 		struct {
 			__u64 cookie;
 		} tracing;
+		struct {
+			__u32 pf;
+			__u32 hooknum;
+			__s32 priority;
+			__u32 flags;
+		} netfilter;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..f193eca16382 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11811,6 +11811,48 @@ static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_l
 	return libbpf_get_error(*link);
 }
 
+struct bpf_link *bpf_program__attach_netfilter(const struct bpf_program *prog,
+					       const struct bpf_netfilter_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	struct bpf_link *link;
+	int prog_fd, link_fd;
+
+	if (!OPTS_VALID(opts, bpf_netfilter_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't attach before loaded\n", prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	link = calloc(1, sizeof(*link));
+	if (!link)
+		return libbpf_err_ptr(-ENOMEM);
+
+	link->detach = &bpf_link__detach_fd;
+
+	lopts.netfilter.pf = OPTS_GET(opts, pf, 0);
+	lopts.netfilter.hooknum = OPTS_GET(opts, hooknum, 0);
+	lopts.netfilter.priority = OPTS_GET(opts, priority, 0);
+	lopts.netfilter.flags = OPTS_GET(opts, flags, 0);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_NETFILTER, &lopts);
+	if (link_fd < 0) {
+		char errmsg[STRERR_BUFSIZE];
+
+		link_fd = -errno;
+		free(link);
+		pr_warn("prog '%s': failed to attach to netfilter: %s\n",
+			prog->name, libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
+		return libbpf_err_ptr(link_fd);
+	}
+	link->fd = link_fd;
+
+	return link;
+}
+
 struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
 {
 	struct bpf_link *link = NULL;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 754da73c643b..10642ad69d76 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -718,6 +718,21 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
 			     int target_fd, const char *attach_func_name);
 
+struct bpf_netfilter_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+
+	__u32 pf;
+	__u32 hooknum;
+	__s32 priority;
+	__u32 flags;
+};
+#define bpf_netfilter_opts__last_field flags
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_netfilter(const struct bpf_program *prog,
+			      const struct bpf_netfilter_opts *opts);
+
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7521a2fb7626..d9ec4407befa 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
 LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
+		bpf_program__attach_netfilter;
 } LIBBPF_1.2.0;
-- 
2.39.3


