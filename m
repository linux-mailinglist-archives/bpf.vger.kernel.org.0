Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28941194155
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 15:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCZO2o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 10:28:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgCZO2n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 10:28:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id a9so7207148wmj.4
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkObKwCIgURA74ME8ivypUEyZ46LCsCmO6dne5DHAFc=;
        b=ZxR3eu3egc7v8R0ks70lxMYWPhQpt3+Wo7giShuOVV5w4W8jSGbvL+zv0RxLQABSgw
         4poQwo+RuNqFvkMcxp9FLOawCKhkCv2OVPoZfubL/FLOgeEZ7hOjbkguPHgb/Jzwn9O+
         HEaL0HsDIOw6jxNL5CvrkWxvZQjGxnz+FgTIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkObKwCIgURA74ME8ivypUEyZ46LCsCmO6dne5DHAFc=;
        b=fiGrQ0iG6fpWqQHIMfg95Sjy+vKpgNOAyjmyALFDitMCLPBxyLYgdC0oVp8JRWivKz
         6qkKC6KnG1HoFKBmgBucFR7coTOoXoQ/9UDjJ047L7OdSIIkhU15ayvcLAC8Y97WYv2O
         bf1TW+9npV0u277k2vKCqM9OQZmwDq57R635e8k37XlvIL/CYJRB7X4TcK1W/07OIeXs
         OZNpMjFKbc/1CHRyD6amu7vtG1/SxJg6jjAujjG6VRc9kTx9+Pi1nNM9PzDdok2ILT9c
         XR0bhhyCVcBQenanSWTMOhdfBpMHwVcKpLt1VtqXaINvL0SJoHNh3XIPzLday79m9ve8
         Qodw==
X-Gm-Message-State: ANhLgQ1TuhKMgL1K6kFS/X+QHKvdvy8/j26ItImafmYQt5VgGGlIQVe0
        XoUMuepvJuqiyCd8kuxKW85COg==
X-Google-Smtp-Source: ADFU+vtkAvGLQIrSLeYmWRw+Hp53GbiuD1kbrdEsozj4Ran0UYBwuIpFkVGGcOEZbNMWZIoE6EwD5g==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr246787wmk.48.1585232921120;
        Thu, 26 Mar 2020 07:28:41 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q3sm3643971wru.87.2020.03.26.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:28:40 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v7 6/8] tools/libbpf: Add support for BPF_PROG_TYPE_LSM
Date:   Thu, 26 Mar 2020 15:28:21 +0100
Message-Id: <20200326142823.26277-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326142823.26277-1-kpsingh@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Since BPF_PROG_TYPE_LSM uses the same attaching mechanism as
BPF_PROG_TYPE_TRACING, the common logic is refactored into a static
function bpf_program__attach_btf_id.

A new API call bpf_program__attach_lsm is still added to avoid userspace
conflicts if this ever changes in the future.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/bpf.c      |  3 ++-
 tools/lib/bpf/libbpf.c   | 39 +++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h   |  4 ++++
 tools/lib/bpf/libbpf.map |  3 +++
 4 files changed, 44 insertions(+), 5 deletions(-)

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
index 62903302935e..4059717a6470 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2358,7 +2358,8 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
 
 static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
 {
-	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	    prog->type == BPF_PROG_TYPE_LSM)
 		return true;
 
 	/* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
@@ -4866,7 +4867,8 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.insns = insns;
 	load_attr.insns_cnt = insns_cnt;
 	load_attr.license = license;
-	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	    prog->type == BPF_PROG_TYPE_LSM) {
 		load_attr.attach_btf_id = prog->attach_btf_id;
 	} else if (prog->type == BPF_PROG_TYPE_TRACING ||
 		   prog->type == BPF_PROG_TYPE_EXT) {
@@ -4957,6 +4959,7 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 	int err = 0, fd, i, btf_id;
 
 	if ((prog->type == BPF_PROG_TYPE_TRACING ||
+	     prog->type == BPF_PROG_TYPE_LSM ||
 	     prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
 		btf_id = libbpf_find_attach_btf_id(prog);
 		if (btf_id <= 0)
@@ -6196,6 +6199,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)	\
 }								\
 
 BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
+BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
 BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
 BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
 BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
@@ -6262,6 +6266,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
 				      struct bpf_program *prog);
 static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
 				     struct bpf_program *prog);
+static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
+				   struct bpf_program *prog);
 
 struct bpf_sec_def {
 	const char *sec;
@@ -6312,6 +6318,10 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -6574,6 +6584,7 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
 }
 
 #define BTF_TRACE_PREFIX "btf_trace_"
+#define BTF_LSM_PREFIX "bpf_lsm_"
 #define BTF_MAX_NAME_SIZE 128
 
 static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
@@ -6601,6 +6612,9 @@ static inline int __find_vmlinux_btf_id(struct btf *btf, const char *name,
 	if (attach_type == BPF_TRACE_RAW_TP)
 		err = find_btf_by_prefix_kind(btf, BTF_TRACE_PREFIX, name,
 					      BTF_KIND_TYPEDEF);
+	else if (attach_type == BPF_LSM_MAC)
+		err = find_btf_by_prefix_kind(btf, BTF_LSM_PREFIX, name,
+					      BTF_KIND_FUNC);
 	else
 		err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
 
@@ -7454,7 +7468,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
 	return bpf_program__attach_raw_tracepoint(prog, tp_name);
 }
 
-struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
+/* Common logic for all BPF program types that attach to a btf_id */
+static struct bpf_link *bpf_program__attach_btf_id(struct bpf_program *prog)
 {
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
@@ -7476,7 +7491,7 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
 	if (pfd < 0) {
 		pfd = -errno;
 		free(link);
-		pr_warn("program '%s': failed to attach to trace: %s\n",
+		pr_warn("program '%s': failed to attach: %s\n",
 			bpf_program__title(prog, false),
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return ERR_PTR(pfd);
@@ -7485,12 +7500,28 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
 	return (struct bpf_link *)link;
 }
 
+struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
+{
+	return bpf_program__attach_btf_id(prog);
+}
+
+struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
+{
+	return bpf_program__attach_btf_id(prog);
+}
+
 static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
 				     struct bpf_program *prog)
 {
 	return bpf_program__attach_trace(prog);
 }
 
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
index d38d7a629417..df1be44c8118 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -248,6 +248,8 @@ bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_trace(struct bpf_program *prog);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_lsm(struct bpf_program *prog);
 struct bpf_map;
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(struct bpf_map *map);
 struct bpf_insn;
@@ -321,6 +323,7 @@ LIBBPF_API int bpf_program__set_socket_filter(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_tracepoint(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_raw_tracepoint(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_kprobe(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_lsm(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sched_cls(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
@@ -347,6 +350,7 @@ LIBBPF_API bool bpf_program__is_socket_filter(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_tracepoint(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_raw_tracepoint(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_kprobe(const struct bpf_program *prog);
+LIBBPF_API bool bpf_program__is_lsm(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_sched_cls(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_sched_act(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_xdp(const struct bpf_program *prog);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5129283c0284..ec29d3aa2700 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -243,5 +243,8 @@ LIBBPF_0.0.8 {
 		bpf_link__pin;
 		bpf_link__pin_path;
 		bpf_link__unpin;
+		bpf_program__attach_lsm;
+		bpf_program__is_lsm;
 		bpf_program__set_attach_target;
+		bpf_program__set_lsm;
 } LIBBPF_0.0.7;
-- 
2.20.1

