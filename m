Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB20146CA7
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgAWPZY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:25:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45508 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAWPZY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so1679043pfg.12
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBXz/+HfHOngF81JAyD2c1Lf0nH3oQLF/A1Bm83MAWU=;
        b=d/0MZrZbAN11C+az2zlLp250G2ypa/3av0seQ/0QSr+jG3v6b9NOZDnI1c9UHQYo4B
         +R2xcos+42E+Do5H1d7dSKgWGbq+9tb3Lki2Y7GoSWPf6NRIyxIIx4N6a20iizxBKH58
         PAXM3LPJptyTuoGWC8D3lNm/77O9dvohyEC/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBXz/+HfHOngF81JAyD2c1Lf0nH3oQLF/A1Bm83MAWU=;
        b=erNjxk1dZHNvBAzffonKuufts0XqttFouluf9eVc5dxA0+Wd6NZaWws5cM9E1zzbQW
         kFGyVveoCHFMjLAHpt8s3gYZe7DNMcaDyRGucyhC9TYA4uqZFtVGfg7jLsU+g42osle/
         XARDBONlBdJcqnYvWI1sODGajwSAL/k5xu7hwyTjp5cs6RgjSh3qNNSALb/KFG9yevEI
         TgMwrjvGk8+x+mcFbY+MZy+PWcePerEl/c3UG3jmlyyZyXIgROhOrcY/WINJ/vntzMHv
         VVXF4LEcCexlC9uDfUg6GCx/hvO2WKzFQPiHylUPyWbVSd4CanHhtFlj6AiDUsQauroy
         PYOQ==
X-Gm-Message-State: APjAAAXYjtl0Nc6ZIvxfEDUs0JqOqez30Z9hMeqG8g13++rGubyep5oH
        1veU/EVGw+YQp0yxsM/G0RC++w==
X-Google-Smtp-Source: APXvYqyUOkTQzqaZz6MAZ5xw4vwpZpQdJoEMH8IxGXrPbF+e4obAOBSgeHSFBUeHB756Yy0j5pjHwQ==
X-Received: by 2002:aa7:9633:: with SMTP id r19mr8146648pfg.90.1579793123259;
        Thu, 23 Jan 2020 07:25:23 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:22 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH bpf-next v3 08/10] tools/libbpf: Add support for BPF_PROG_TYPE_LSM
Date:   Thu, 23 Jan 2020 07:24:38 -0800
Message-Id: <20200123152440.28956-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123152440.28956-1-kpsingh@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* Add functionality in libbpf to attach eBPF program to LSM hooks
* Lookup the index of the LSM hook in security_hook_heads and pass it in
  attr->lsm_hook_idx

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 tools/lib/bpf/bpf.c      |   6 ++-
 tools/lib/bpf/bpf.h      |   1 +
 tools/lib/bpf/libbpf.c   | 104 +++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h   |   4 ++
 tools/lib/bpf/libbpf.map |   3 ++
 5 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c6dafe563176..60dac1b80e5a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -235,7 +235,10 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	memset(&attr, 0, sizeof(attr));
 	attr.prog_type = load_attr->prog_type;
 	attr.expected_attach_type = load_attr->expected_attach_type;
-	if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
+
+	if (attr.prog_type == BPF_PROG_TYPE_LSM) {
+		attr.lsm_hook_idx = load_attr->lsm_hook_idx;
+	} else if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
 		attr.attach_btf_id = load_attr->attach_btf_id;
 	} else if (attr.prog_type == BPF_PROG_TYPE_TRACING ||
 		   attr.prog_type == BPF_PROG_TYPE_EXT) {
@@ -245,6 +248,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 		attr.prog_ifindex = load_attr->prog_ifindex;
 		attr.kern_version = load_attr->kern_version;
 	}
+
 	attr.insn_cnt = (__u32)load_attr->insns_cnt;
 	attr.insns = ptr_to_u64(load_attr->insns);
 	attr.license = ptr_to_u64(load_attr->license);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index b976e77316cc..cfd59f7c29a7 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -85,6 +85,7 @@ struct bpf_load_program_attr {
 	union {
 		__u32 prog_ifindex;
 		__u32 attach_btf_id;
+		__u32 lsm_hook_idx;
 	};
 	__u32 prog_btf_fd;
 	__u32 func_info_rec_size;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ae34b681ae82..1ecbf6c78b97 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -228,6 +228,7 @@ struct bpf_program {
 	enum bpf_attach_type expected_attach_type;
 	__u32 attach_btf_id;
 	__u32 attach_prog_fd;
+	__u32 lsm_hook_idx;
 	void *func_info;
 	__u32 func_info_rec_size;
 	__u32 func_info_cnt;
@@ -2352,7 +2353,9 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
 
 static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
 {
-	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+
+	if (prog->type == BPF_PROG_TYPE_LSM ||
+	    prog->type == BPF_PROG_TYPE_STRUCT_OPS)
 		return true;
 
 	/* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
@@ -4835,7 +4838,10 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.insns = insns;
 	load_attr.insns_cnt = insns_cnt;
 	load_attr.license = license;
-	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+
+	if (prog->type == BPF_PROG_TYPE_LSM) {
+		load_attr.lsm_hook_idx = prog->lsm_hook_idx;
+	} else if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
 		load_attr.attach_btf_id = prog->attach_btf_id;
 	} else if (prog->type == BPF_PROG_TYPE_TRACING ||
 		   prog->type == BPF_PROG_TYPE_EXT) {
@@ -4845,6 +4851,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 		load_attr.kern_version = kern_version;
 		load_attr.prog_ifindex = prog->prog_ifindex;
 	}
+
 	/* if .BTF.ext was loaded, kernel supports associated BTF for prog */
 	if (prog->obj->btf_ext)
 		btf_fd = bpf_object__btf_fd(prog->obj);
@@ -4914,10 +4921,11 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 }
 
 static int libbpf_find_attach_btf_id(struct bpf_program *prog);
+static __s32 find_lsm_hook_idx(struct bpf_program *prog);
 
 int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 {
-	int err = 0, fd, i, btf_id;
+	int err = 0, fd, i, btf_id, idx;
 
 	if (prog->type == BPF_PROG_TYPE_TRACING ||
 	    prog->type == BPF_PROG_TYPE_EXT) {
@@ -4927,6 +4935,13 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 		prog->attach_btf_id = btf_id;
 	}
 
+	if (prog->type == BPF_PROG_TYPE_LSM) {
+		idx = find_lsm_hook_idx(prog);
+		if (idx < 0)
+			return idx;
+		prog->lsm_hook_idx = idx;
+	}
+
 	if (prog->instances.nr < 0 || !prog->instances.fds) {
 		if (prog->preprocessor) {
 			pr_warn("Internal error: can't load program '%s'\n",
@@ -5084,6 +5099,8 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 		if (prog->type != BPF_PROG_TYPE_UNSPEC)
 			continue;
 
+
+
 		err = libbpf_prog_type_by_name(prog->section_name, &prog_type,
 					       &attach_type);
 		if (err == -ESRCH)
@@ -6160,6 +6177,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)	\
 }								\
 
 BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
+BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
 BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
 BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
 BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
@@ -6226,6 +6244,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
 				      struct bpf_program *prog);
 static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
 				     struct bpf_program *prog);
+static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
+				   struct bpf_program *prog);
 
 struct bpf_sec_def {
 	const char *sec;
@@ -6272,6 +6292,9 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace/", EXT,
 		.is_attach_btf = true,
 		.attach_fn = attach_trace),
+	SEC_DEF("lsm/", LSM,
+		.expected_attach_type = BPF_LSM_MAC,
+		.attach_fn = attach_lsm),
 	BPF_PROG_SEC("xdp",			BPF_PROG_TYPE_XDP),
 	BPF_PROG_SEC("perf_event",		BPF_PROG_TYPE_PERF_EVENT),
 	BPF_PROG_SEC("lwt_in",			BPF_PROG_TYPE_LWT_IN),
@@ -6533,6 +6556,44 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
 	return -EINVAL;
 }
 
+static __s32 find_lsm_hook_idx(struct bpf_program *prog)
+{
+	struct btf *btf = prog->obj->btf_vmlinux;
+	const char *name = prog->section_name;
+	const struct bpf_sec_def *sec_def;
+	const struct btf_type *t;
+	struct btf_member *m;
+	__s32 type_id;
+	int i;
+
+	sec_def = find_sec_def(name);
+	if (!sec_def)
+		return -ESRCH;
+
+	name += sec_def->len;
+
+	type_id = btf__find_by_name_kind(btf, "security_hook_heads",
+					 BTF_KIND_STRUCT);
+	if (type_id < 0) {
+		pr_warn("security_hook_heads not found in vmlinux BTF\n");
+		return type_id;
+	}
+
+	t = btf__type_by_id(btf, type_id);
+	if (!t) {
+		pr_warn("Can't find type for security_hook_heads: %u\n", type_id);
+		return -ESRCH;
+	}
+
+	for (m = btf_members(t), i = 0; i < btf_vlen(t); i++, m++) {
+		if (!strcmp(btf__name_by_offset(btf, m->name_off), name))
+			return i;
+	}
+
+	pr_warn("Can't find lsm_hook_idx for %s in security_hook_heads\n", name);
+	return -ESRCH;
+}
+
 #define BTF_TRACE_PREFIX "btf_trace_"
 #define BTF_MAX_NAME_SIZE 128
 
@@ -7372,6 +7433,43 @@ static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
 	return bpf_program__attach_trace(prog);
 }
 
+struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
+{
+	char errmsg[STRERR_BUFSIZE];
+	struct bpf_link_fd *link;
+	int prog_fd, pfd;
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("program '%s': can't attach before loaded\n",
+			bpf_program__title(prog, false));
+		return ERR_PTR(-EINVAL);
+	}
+
+	link = calloc(1, sizeof(*link));
+	if (!link)
+		return ERR_PTR(-ENOMEM);
+	link->link.detach = &bpf_link__detach_fd;
+
+	pfd = bpf_prog_attach(prog_fd, 0, BPF_LSM_MAC, 0);
+	if (pfd < 0) {
+		pfd = -errno;
+		free(link);
+		pr_warn("program '%s': failed to attach: %s\n",
+			bpf_program__title(prog, false),
+			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		return ERR_PTR(pfd);
+	}
+	link->fd = pfd;
+	return (struct bpf_link *)link;
+}
+
+static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
+				   struct bpf_program *prog)
+{
+	return bpf_program__attach_lsm(prog);
+}
+
 struct bpf_link *bpf_program__attach(struct bpf_program *prog)
 {
 	const struct bpf_sec_def *sec_def;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2a5e3b087002..ef09ca980758 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -239,6 +239,8 @@ bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_trace(struct bpf_program *prog);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_lsm(struct bpf_program *prog);
 struct bpf_map;
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(struct bpf_map *map);
 struct bpf_insn;
@@ -312,6 +314,7 @@ LIBBPF_API int bpf_program__set_socket_filter(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_tracepoint(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_raw_tracepoint(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_kprobe(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_lsm(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sched_cls(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
@@ -334,6 +337,7 @@ LIBBPF_API bool bpf_program__is_socket_filter(const struct bpf_program *prog);
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

