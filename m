Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53839127FB1
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLTPmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:42:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41920 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfLTPmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so9845891wrw.8
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=paRFHTiw/4aHrEDwPYYt5DNAc5B07BiR533ZjOOgfNA=;
        b=LSixZOBHgCAqq5f5I3USgUDTDjz3ai4Mcl5c54BhPwpOnGd00SVi46jrFyJI4O+YTj
         OfT49wqSAXZHqc35BN1589wYs++ESJgrkdVSEbxoEEeh1Z3QJqoYWCyEVtQxKDrRzv1f
         h2gBiz2+2tBGjZz/gZdnZ/yzKNgphy5Bd2KR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paRFHTiw/4aHrEDwPYYt5DNAc5B07BiR533ZjOOgfNA=;
        b=QYFf3FFEX0E+/lpVDuVj74DXvYyR3O6RmNx2blC6zjXeY0if/F1t2eUf1atccN00cO
         0zUhxwt/faWhsJsv3jLKT8B00A/PlNDsA0+UaKYW9dkvb36c8owvoJCFJ15CfL16Ie3U
         NEOzCqJaLMzMl0FuJAii8GosNFhPU5IBM3GeMX7/zfuccy5CMpIHFvNYw04eSM2rBVeu
         5iV6wLzCyyvHSXKdZUmUdlwXHwuXVBC+kkj7euimIQduX1v5Lxkzi2ZqLW/uWdlVGCGs
         Iy49UURhCvcsvgZQxGVy6OFz809cTNUuUDAh4FCwEEI8bmFlLz9BnFpH868FibzYcCmU
         gMXQ==
X-Gm-Message-State: APjAAAU8BP+AelvPx/JiKpK4AC2GMQuSNXgQcC8Gs59RQQ7t9XK+q4wG
        9IA+9C9VnNc2c/0HVttm/dul/Q==
X-Google-Smtp-Source: APXvYqxUhzkZqdzoLus5OLbBOFCDlsljW/eOFBtyxNAMOKpkpK3KXKXVADOUkwzlSnIiq/UcP9kD2A==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr16505533wru.150.1576856529739;
        Fri, 20 Dec 2019 07:42:09 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:09 -0800 (PST)
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
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v1 05/13] tools/libbpf: Add support in libbpf for BPF_PROG_TYPE_LSM
Date:   Fri, 20 Dec 2019 16:42:00 +0100
Message-Id: <20191220154208.15895-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Update the libbpf library with functionality to load and
attach a program type BPF_PROG_TYPE_LSM, currently with
only one expected attach type BPF_LSM_MAC.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/bpf.c           |  2 +-
 tools/lib/bpf/bpf.h           |  6 +++++
 tools/lib/bpf/libbpf.c        | 44 +++++++++++++++++++++--------------
 tools/lib/bpf/libbpf.h        |  2 ++
 tools/lib/bpf/libbpf.map      |  6 +++++
 tools/lib/bpf/libbpf_probes.c |  1 +
 6 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 98596e15390f..9c6fb083f7de 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -228,7 +228,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	memset(&attr, 0, sizeof(attr));
 	attr.prog_type = load_attr->prog_type;
 	attr.expected_attach_type = load_attr->expected_attach_type;
-	if (attr.prog_type == BPF_PROG_TYPE_TRACING) {
+	if (needs_btf_attach(attr.prog_type)) {
 		attr.attach_btf_id = load_attr->attach_btf_id;
 		attr.attach_prog_fd = load_attr->attach_prog_fd;
 	} else {
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 3c791fa8e68e..df2a00ff349f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -177,6 +177,12 @@ LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
 				 __u64 *probe_offset, __u64 *probe_addr);
 
+static inline bool needs_btf_attach(enum bpf_prog_type prog_type)
+{
+	return (prog_type == BPF_PROG_TYPE_TRACING ||
+		prog_type == BPF_PROG_TYPE_LSM);
+}
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b20f82e58989..b0b27d8e5a37 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3738,7 +3738,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.insns = insns;
 	load_attr.insns_cnt = insns_cnt;
 	load_attr.license = license;
-	if (prog->type == BPF_PROG_TYPE_TRACING) {
+	if (needs_btf_attach(prog->type)) {
 		load_attr.attach_prog_fd = prog->attach_prog_fd;
 		load_attr.attach_btf_id = prog->attach_btf_id;
 	} else {
@@ -3983,7 +3983,7 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 
 		bpf_program__set_type(prog, prog_type);
 		bpf_program__set_expected_attach_type(prog, attach_type);
-		if (prog_type == BPF_PROG_TYPE_TRACING) {
+		if (needs_btf_attach(prog_type)) {
 			err = libbpf_find_attach_btf_id(prog->section_name,
 							attach_type,
 							attach_prog_fd);
@@ -4933,6 +4933,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)	\
 }								\
 
 BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
+BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
 BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
 BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
 BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
@@ -5009,6 +5010,8 @@ static const struct {
 	BPF_PROG_SEC("lwt_out",			BPF_PROG_TYPE_LWT_OUT),
 	BPF_PROG_SEC("lwt_xmit",		BPF_PROG_TYPE_LWT_XMIT),
 	BPF_PROG_SEC("lwt_seg6local",		BPF_PROG_TYPE_LWT_SEG6LOCAL),
+	BPF_PROG_BTF("lsm/",			BPF_PROG_TYPE_LSM,
+						BPF_LSM_MAC),
 	BPF_APROG_SEC("cgroup_skb/ingress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_INGRESS),
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
@@ -5119,32 +5122,39 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 	return -ESRCH;
 }
 
-#define BTF_PREFIX "btf_trace_"
+static inline int __btf__typdef_with_prefix(struct btf *btf, const char *name,
+					    const char *prefix)
+{
+
+	size_t prefix_len = strlen(prefix);
+	char btf_type_name[128];
+
+	strcpy(btf_type_name, prefix);
+	strncat(btf_type_name, name, sizeof(btf_type_name) - (prefix_len + 1));
+	return btf__find_by_name_kind(btf, btf_type_name, BTF_KIND_TYPEDEF);
+}
+
+#define BTF_TRACE_PREFIX "btf_trace_"
+#define BTF_LSM_PREFIX "lsm_btf_"
+
 int libbpf_find_vmlinux_btf_id(const char *name,
 			       enum bpf_attach_type attach_type)
 {
 	struct btf *btf = bpf_core_find_kernel_btf();
-	char raw_tp_btf[128] = BTF_PREFIX;
-	char *dst = raw_tp_btf + sizeof(BTF_PREFIX) - 1;
-	const char *btf_name;
 	int err = -EINVAL;
-	__u32 kind;
 
 	if (IS_ERR(btf)) {
 		pr_warn("vmlinux BTF is not found\n");
 		return -EINVAL;
 	}
 
-	if (attach_type == BPF_TRACE_RAW_TP) {
-		/* prepend "btf_trace_" prefix per kernel convention */
-		strncat(dst, name, sizeof(raw_tp_btf) - sizeof(BTF_PREFIX));
-		btf_name = raw_tp_btf;
-		kind = BTF_KIND_TYPEDEF;
-	} else {
-		btf_name = name;
-		kind = BTF_KIND_FUNC;
-	}
-	err = btf__find_by_name_kind(btf, btf_name, kind);
+	if (attach_type == BPF_TRACE_RAW_TP)
+		err = __btf__typdef_with_prefix(btf, name, BTF_TRACE_PREFIX);
+	else if (attach_type == BPF_LSM_MAC)
+		err = __btf__typdef_with_prefix(btf, name, BTF_LSM_PREFIX);
+	else
+		err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
+
 	btf__free(btf);
 	return err;
 }
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0dbf4bfba0c4..9cd69d602c82 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -332,6 +332,7 @@ LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_tracing(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_lsm(struct bpf_program *prog);
 
 LIBBPF_API enum bpf_prog_type bpf_program__get_type(struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
@@ -352,6 +353,7 @@ LIBBPF_API bool bpf_program__is_sched_act(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_xdp(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_perf_event(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_tracing(const struct bpf_program *prog);
+LIBBPF_API bool bpf_program__is_lsm(const struct bpf_program *prog);
 
 /*
  * No need for __attribute__((packed)), all members of 'bpf_map_def'
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ddc2c40e482..3d396149755d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -208,3 +208,9 @@ LIBBPF_0.0.6 {
 		btf__find_by_name_kind;
 		libbpf_find_vmlinux_btf_id;
 } LIBBPF_0.0.5;
+
+LIBBPF_0.0.7 {
+	global:
+		bpf_program__is_lsm;
+		bpf_program__set_lsm;
+} LIBBPF_0.0.6;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index a9eb8b322671..203b4ecf7a0b 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -103,6 +103,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
 	default:
 		break;
 	}
-- 
2.20.1

