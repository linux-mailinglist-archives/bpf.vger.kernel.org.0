Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7200D16655A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 18:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBTRxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 12:53:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33838 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgBTRxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so3339143wme.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Adu6TFrPNSr18eey8+2tPmGfp+2eqe2mYVGsncyEkDQ=;
        b=Rx0luW6pGwCXCc8qCCqt+RFGihCY4OijwO71VThmmQFmAjf4MrKJzpkU7zKnp05oNH
         t0j2cMFMgg0MyhDSExfeNTqxIR4wUbTBQ9OehhS1E90aoTtWhZafYOb7ij8LmsDh2z6V
         0CW6vl9fuGiR8IMgwDf9no8Oqay/cUVB8QzxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Adu6TFrPNSr18eey8+2tPmGfp+2eqe2mYVGsncyEkDQ=;
        b=U34kZLgbz/laZo3OWYBS/PvB1od4UCdYkZd8pQ1lA0ETPA/HZ/m0GZxs0Z725SfAjE
         5o8JZX7oVBnXP5G6sjFgTCDn8Crp2q814P+xNVvdWIVM1AiSSRXPNWcl1lB3hE2c7Jk/
         i8yYsYZY5S+dRpLcaSWpAZj+1Dx/LjRS7Moojb/xRjLXI2JMT6CYIgQjeSBkPQueBx5W
         Bv5QWWjqke0fcY+XYg/N1Gfnx7FWuJUkCb27W3v3/jpb2ndRTJjZb23bAEGsKESCRV0t
         0WR04YaT/KBn9PwEOZ67Kg36/X05HP74K92M6muST1F60RAFeZZNJWhM5Xg3bedWUnFl
         ivSQ==
X-Gm-Message-State: APjAAAUn+waI4EVL5ZNddcT7m2TN3po4D+zACIZWt5JOJipDccg22PSw
        QlRpPPaph3/E4B0e12R5KqON+IEzS8o=
X-Google-Smtp-Source: APXvYqw0z9ltTQGr1UG7ZjjOTiaFeE6G8AsIvJWW0WnaT+7vTOCJEX+dmrIG6ZG/8efmggTixAtTpA==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr5626356wmd.69.1582221181234;
        Thu, 20 Feb 2020 09:53:01 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id r5sm363059wrt.43.2020.02.20.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:53:00 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v4 6/8] tools/libbpf: Add support for BPF_PROG_TYPE_LSM
Date:   Thu, 20 Feb 2020 18:52:48 +0100
Message-Id: <20200220175250.10795-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Since BPF_PROG_TYPE_LSM uses the same attaching mechanism as
BPF_PROG_TYPE_TRACING, the common logic is refactored into a static
function bpf_program__attach_btf.

A new API call bpf_program__attach_lsm is still added to avoid userspace
conflicts if this ever changes in the future.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/bpf.c      |  3 ++-
 tools/lib/bpf/libbpf.c   | 46 ++++++++++++++++++++++++++++++++--------
 tools/lib/bpf/libbpf.h   |  4 ++++
 tools/lib/bpf/libbpf.map |  3 +++
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c6dafe563176..73220176728d 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -235,7 +235,8 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	memset(&attr, 0, sizeof(attr));
 	attr.prog_type = load_attr->prog_type;
 	attr.expected_attach_type = load_attr->expected_attach_type;
-	if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
+	if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
+	    attr.prog_type == BPF_PROG_TYPE_LSM) {
 		attr.attach_btf_id = load_attr->attach_btf_id;
 	} else if (attr.prog_type == BPF_PROG_TYPE_TRACING ||
 		   attr.prog_type == BPF_PROG_TYPE_EXT) {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514b1a524abb..d11139d5e76b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2351,16 +2351,14 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
 
 static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
 {
-	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	    prog->type == BPF_PROG_TYPE_LSM)
 		return true;
 
 	/* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
 	 * also need vmlinux BTF
 	 */
-	if (prog->type == BPF_PROG_TYPE_TRACING && !prog->attach_prog_fd)
-		return true;
-
-	return false;
+	return prog->type == BPF_PROG_TYPE_TRACING && !prog->attach_prog_fd;
 }
 
 static int bpf_object__load_vmlinux_btf(struct bpf_object *obj)
@@ -4855,7 +4853,8 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.insns = insns;
 	load_attr.insns_cnt = insns_cnt;
 	load_attr.license = license;
-	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	    prog->type == BPF_PROG_TYPE_LSM) {
 		load_attr.attach_btf_id = prog->attach_btf_id;
 	} else if (prog->type == BPF_PROG_TYPE_TRACING ||
 		   prog->type == BPF_PROG_TYPE_EXT) {
@@ -4940,6 +4939,7 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 	int err = 0, fd, i, btf_id;
 
 	if (prog->type == BPF_PROG_TYPE_TRACING ||
+	    prog->type == BPF_PROG_TYPE_LSM ||
 	    prog->type == BPF_PROG_TYPE_EXT) {
 		btf_id = libbpf_find_attach_btf_id(prog);
 		if (btf_id <= 0)
@@ -6179,6 +6179,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)	\
 }								\
 
 BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
+BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
 BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
 BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
 BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
@@ -6245,6 +6246,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
 				      struct bpf_program *prog);
 static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
 				     struct bpf_program *prog);
+static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
+				   struct bpf_program *prog);
 
 struct bpf_sec_def {
 	const char *sec;
@@ -6291,6 +6294,10 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace/", EXT,
 		.is_attach_btf = true,
 		.attach_fn = attach_trace),
+	SEC_DEF("lsm/", LSM,
+		.is_attach_btf = true,
+		.expected_attach_type = BPF_LSM_MAC,
+		.attach_fn = attach_lsm),
 	BPF_PROG_SEC("xdp",			BPF_PROG_TYPE_XDP),
 	BPF_PROG_SEC("perf_event",		BPF_PROG_TYPE_PERF_EVENT),
 	BPF_PROG_SEC("lwt_in",			BPF_PROG_TYPE_LWT_IN),
@@ -6553,6 +6560,7 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
 }
 
 #define BTF_TRACE_PREFIX "btf_trace_"
+#define BTF_LSM_PREFIX "bpf_lsm_"
 #define BTF_MAX_NAME_SIZE 128
 
 static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
@@ -6580,6 +6588,9 @@ static inline int __find_vmlinux_btf_id(struct btf *btf, const char *name,
 	if (attach_type == BPF_TRACE_RAW_TP)
 		err = find_btf_by_prefix_kind(btf, BTF_TRACE_PREFIX, name,
 					      BTF_KIND_TYPEDEF);
+	else if (attach_type == BPF_LSM_MAC)
+		err = find_btf_by_prefix_kind(btf, BTF_LSM_PREFIX, name,
+					      BTF_KIND_FUNC);
 	else
 		err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
 
@@ -7354,7 +7365,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
 	return bpf_program__attach_raw_tracepoint(prog, tp_name);
 }
 
-struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
+/* Common logic for all BPF program types that attach to a btf_id */
+static struct bpf_link *bpf_program__attach_btf(struct bpf_program *prog)
 {
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link_fd *link;
@@ -7376,7 +7388,7 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
 	if (pfd < 0) {
 		pfd = -errno;
 		free(link);
-		pr_warn("program '%s': failed to attach to trace: %s\n",
+		pr_warn("program '%s': failed to attach to: %s\n",
 			bpf_program__title(prog, false),
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return ERR_PTR(pfd);
@@ -7385,10 +7397,26 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
 	return (struct bpf_link *)link;
 }
 
+struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
+{
+	return bpf_program__attach_btf(prog);
+}
+
+struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
+{
+	return bpf_program__attach_btf(prog);
+}
+
 static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
 				     struct bpf_program *prog)
 {
-	return bpf_program__attach_trace(prog);
+	return bpf_program__attach_btf(prog);
+}
+
+static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
+				   struct bpf_program *prog)
+{
+	return bpf_program__attach_btf(prog);
 }
 
 struct bpf_link *bpf_program__attach(struct bpf_program *prog)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3fe12c9d1f92..3f72323f205b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -243,6 +243,8 @@ bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_trace(struct bpf_program *prog);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_lsm(struct bpf_program *prog);
 struct bpf_map;
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(struct bpf_map *map);
 struct bpf_insn;
@@ -316,6 +318,7 @@ LIBBPF_API int bpf_program__set_socket_filter(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_tracepoint(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_raw_tracepoint(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_kprobe(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_lsm(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sched_cls(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
@@ -338,6 +341,7 @@ LIBBPF_API bool bpf_program__is_socket_filter(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_tracepoint(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_raw_tracepoint(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_kprobe(const struct bpf_program *prog);
+LIBBPF_API bool bpf_program__is_lsm(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_sched_cls(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_sched_act(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_xdp(const struct bpf_program *prog);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b035122142bb..8df332a528a0 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -227,10 +227,13 @@ LIBBPF_0.0.7 {
 		bpf_probe_large_insn_limit;
 		bpf_prog_attach_xattr;
 		bpf_program__attach;
+		bpf_program__attach_lsm;
 		bpf_program__name;
 		bpf_program__is_extension;
+		bpf_program__is_lsm;
 		bpf_program__is_struct_ops;
 		bpf_program__set_extension;
+		bpf_program__set_lsm;
 		bpf_program__set_struct_ops;
 		btf__align_of;
 		libbpf_find_kernel_btf;
-- 
2.20.1

