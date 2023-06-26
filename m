Return-Path: <bpf+bounces-3507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99C73EEF7
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5080E1C209BF
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5315AE7;
	Mon, 26 Jun 2023 23:02:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73212B66
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 23:02:26 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C310E4;
	Mon, 26 Jun 2023 16:02:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DC6B75C00D1;
	Mon, 26 Jun 2023 19:02:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 26 Jun 2023 19:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1687820541; x=
	1687906941; bh=LRmuab6R6ClXxsIAWdYJTaRQBWQe0tQBAwVSwfhEFfo=; b=W
	vGr/IAGBJ68pi0ITGDMOThI/yMAX6bfzgCui+WGs/mNqYRCF5msAqPcRY8BA4Bxz
	VswhWZdEFDv3gz9ZfHHhe831FsjnSgPPhf4w4wrLENtxlzEQUJydvO7/GzJ+B4Dd
	FXYdQ3ujPExgosN0qlvN4STM1HMaRkEyrwTGSjou8O9C46+4CPNHxXYMP6ri0brf
	iTlUOm5eoacHdGzz+8D4o2jNWiiWz9y5+Mf5hX2D7wNpVgGFxVUi1IVmBieud/8W
	mX0eExhyktgWpYgQ6PNHM9/jmlGW/5ce5hTWkSldFrOo6nkx+FfDq5zeFI2Hpnri
	8doXxtygnTC3rly7jHyMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687820541; x=
	1687906941; bh=LRmuab6R6ClXxsIAWdYJTaRQBWQe0tQBAwVSwfhEFfo=; b=D
	NdRYjuJs3JQlLviXVmGUlBxSoRC1pfg2ysGH1jy6WVgxBB4giDyW/fnNETWVBx6b
	7lMaKzMWaYs8J2yCZhRLnB/5wJWPaZe3yVhNBl4C55n6Hq55mScoRheN5zELF871
	twNI2qitcM/glGYECOer1WHFo0Vf7lkOac2O2OseazGn08omZmZH1HHoCVFnguLf
	MX99aqi516JTx3Fnj/c1mONYcBQ7l0tPoGTJsfPntVMR83NEgjel2DBFGXhp0019
	x1ZmRJub4qNVWrGbC3XcEnOBv3FilO6JjPO4VlAtddeQSomXGU6U1IvayG2K6kyB
	hzBF6EU0+izhyXlfKEMwQ==
X-ME-Sender: <xms:_RiaZEYwzvx8JRKLdxtvDbL6nwXyqwHMBeXO2RrStcvP2xS16B3trw>
    <xme:_RiaZPaNp1-5VNOE1HF6t9s_Ox5tgMMTZ3pzPkiDLlnpxQOoXVtbhQgUtEzXJU8xt
    2Ug1P9A5gbM-OVzKA>
X-ME-Received: <xmr:_RiaZO_NCm5G3geUtug41GkVWwZCLXUdpJYgafhEuuwmwQPDE91hi9Mya_QZ61U8vbXweGy1GCAGRXU6mSMe9Fk5cIT-ARtkebMXZohQTIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepjeegveeljeehvdevudduffffleelveejueegjedvhedvhedv
    heethfejgedtieeinecuffhomhgrihhnpehnvghtfhhilhhtvghrrdhpfhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:_RiaZOrU1e5swZ_MyhRAVuKmDRtRJRLcz69QBVu9gU3Unv32V3dgvw>
    <xmx:_RiaZPqnUT6XkkAF0NnXzgBS62UY6p-gasX7GhVSIqx2hWDMax5tVw>
    <xmx:_RiaZMS9DQ2ZKfA_ONjE9wh8xUEWrjvezdhPwHPuAjHYZGvGPBHjZw>
    <xmx:_RiaZPZRvgzZhok9O0q5_9YWmJQJxXGq1cw_MSRuZqWY5kBjaKNcrQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 19:02:19 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	fw@strlen.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dsahern@kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 1/7] tools: libbpf: add netfilter link attach helper
Date: Mon, 26 Jun 2023 17:02:08 -0600
Message-Id: <d98692cd1451b35b0939718f5d4676444aa40069.1687819413.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new api function: bpf_program__attach_netfilter.

It takes a bpf program (netfilter type), and a pointer to a option struct
that contains the desired attachment (protocol family, priority, hook
location, ...).

It returns a pointer to a 'bpf_link' structure or NULL on error.

Next patch adds new netfilter_basic test that uses this function to
attach a program to a few pf/hook/priority combinations.

Co-developed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/bpf.c      |  8 +++++++
 tools/lib/bpf/bpf.h      |  6 +++++
 tools/lib/bpf/libbpf.c   | 47 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 15 +++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 77 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ed86b37d8024..3b0da19715e1 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -741,6 +741,14 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_NETFILTER:
+		attr.link_create.netfilter.pf = OPTS_GET(opts, netfilter.pf, 0);
+		attr.link_create.netfilter.hooknum = OPTS_GET(opts, netfilter.hooknum, 0);
+		attr.link_create.netfilter.priority = OPTS_GET(opts, netfilter.priority, 0);
+		attr.link_create.netfilter.flags = OPTS_GET(opts, netfilter.flags, 0);
+		if (!OPTS_ZEROED(opts, netfilter))
+			return libbpf_err(-EINVAL);
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
index 214f828ece6b..a8b9d5abb55f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11811,6 +11811,53 @@ static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_l
 	return libbpf_get_error(*link);
 }
 
+struct bpf_link *bpf_program__attach_netfilter(const struct bpf_program *prog,
+					       const struct bpf_netfilter_opts *opts)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
+	struct bpf_link *link;
+	int prog_fd, link_fd;
+
+	if (!OPTS_VALID(opts, bpf_netfilter_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	link_create_opts.netfilter.pf = OPTS_GET(opts, pf, 0);
+	link_create_opts.netfilter.hooknum = OPTS_GET(opts, hooknum, 0);
+	link_create_opts.netfilter.priority = OPTS_GET(opts, priority, 0);
+	link_create_opts.netfilter.flags = OPTS_GET(opts, flags, 0);
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
+	link->detach = &bpf_link__detach_fd;
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_NETFILTER, &link_create_opts);
+
+	link->fd = ensure_good_fd(link_fd);
+
+	if (link->fd < 0) {
+		char errmsg[STRERR_BUFSIZE];
+
+		link_fd = -errno;
+		free(link);
+		pr_warn("prog '%s': failed to attach to pf:%d,hooknum:%d:prio:%d: %s\n",
+			prog->name,
+			OPTS_GET(opts, pf, 0),
+			OPTS_GET(opts, hooknum, 0),
+			OPTS_GET(opts, priority, 0),
+			libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
+		return libbpf_err_ptr(link_fd);
+	}
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
2.40.1


