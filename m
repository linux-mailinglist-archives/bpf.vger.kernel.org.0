Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282E4127F98
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLTPmV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:42:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41936 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfLTPmT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so9846278wrw.8
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zWF1EvSsIPmLOxhaJXNA5ILlHc0a+yRKkyOT6dTzZ0=;
        b=ekYYzsl5m79LwnzVS7qykSQ/bDpL/PQ3sz6ILbns2uGcBdHs9gFfdJCiZU35xAZvBt
         ALSFkkfruiwXpSdgmiS+xMCO3kqNS44kbO5+hwzdk3Xqh5cdHWQhqi2L6d2gr9RCm/fl
         O5KtaLptB41j8CC4qrlMKbhgZ90Xylo/7IOfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zWF1EvSsIPmLOxhaJXNA5ILlHc0a+yRKkyOT6dTzZ0=;
        b=SB6jWpPCrJXJf5PES8iPRIbSDZp1uyHSN5EpKe7zOpblDL3aGF85lypmJ9sGLy62Ig
         yAoLPFadc9wrr+Ao2bKUWM7YJoERbtAVUZ464SpXPXe75udKAyLJLxe/+LOVaPQ7WZvY
         exkH2qO9Bbzxg+Pj1WL9PpH79LtlDGDP1ONiGimmz0n2ZrTvu0e2YBJYY3T6LjaofbLY
         iiZA0dPxx/Y3b41bSVZIIffsnOBVK3rCTNmND5HNGZyULMacStWmlVQMQRatkpyisASq
         qD+Dut3MwGww9R8R4uIfYQS7WIQLD9CBQNvOmd294XLKHGqDepIWeWZvRJUpPSndF/Dp
         aCKg==
X-Gm-Message-State: APjAAAWAd73+QBm8Gxe1sKw93n8CIid5aQrX0+qQFM+nA44i+2TVV6aU
        tvnyZ2cmfuUPIQJ3E7Zvz2P1xg==
X-Google-Smtp-Source: APXvYqwhzZbMjbi+ZJg+l9hDKucUyaSA8WMPRiw5JVHGlJMxsqgRYJf0NTeCQOf2APAkXBjQt/dlOA==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr16601729wrv.148.1576856537603;
        Fri, 20 Dec 2019 07:42:17 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:17 -0800 (PST)
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
Subject: [PATCH bpf-next v1 11/13] tools/libbpf: Add bpf_program__attach_lsm
Date:   Fri, 20 Dec 2019 16:42:06 +0100
Message-Id: <20191220154208.15895-12-kpsingh@chromium.org>
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

Add functionality in libbpf to attach eBPF program to LSM hooks.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c   | 127 +++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h   |   2 +
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b0b27d8e5a37..ab2b23b4f21f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5122,8 +5122,8 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 	return -ESRCH;
 }
 
-static inline int __btf__typdef_with_prefix(struct btf *btf, const char *name,
-					    const char *prefix)
+static inline int __btf__type_with_prefix(struct btf *btf, const char *name,
+					  const char *prefix)
 {
 
 	size_t prefix_len = strlen(prefix);
@@ -5149,9 +5149,9 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	}
 
 	if (attach_type == BPF_TRACE_RAW_TP)
-		err = __btf__typdef_with_prefix(btf, name, BTF_TRACE_PREFIX);
+		err = __btf__type_with_prefix(btf, name, BTF_TRACE_PREFIX);
 	else if (attach_type == BPF_LSM_MAC)
-		err = __btf__typdef_with_prefix(btf, name, BTF_LSM_PREFIX);
+		err = __btf__type_with_prefix(btf, name, BTF_LSM_PREFIX);
 	else
 		err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
 
@@ -5502,6 +5502,18 @@ struct bpf_link_fd {
 	int fd; /* hook FD */
 };
 
+/*
+ * The other attach types allow the link to be destroyed by using an ioctl or
+ * an operation on some file descriptor that describes the attachment. An LSM
+ * hook can have multiple programs attached to each hook, so the link needs to
+ * specify the program that must be detached when the link is destroyed.
+ */
+struct bpf_link_lsm {
+	struct bpf_link link;
+	int hook_fd;
+	int prog_fd;
+};
+
 static int bpf_link__destroy_perf_event(struct bpf_link *link)
 {
 	struct bpf_link_fd *l = (void *)link;
@@ -5876,6 +5888,113 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
 	return (struct bpf_link *)link;
 }
 
+
+static int bpf_link__destroy_lsm(struct bpf_link *link)
+{
+	struct bpf_link_lsm *ll = container_of(link, struct bpf_link_lsm, link);
+	char errmsg[STRERR_BUFSIZE];
+	int ret;
+
+	ret = bpf_prog_detach2(ll->prog_fd, ll->hook_fd, BPF_LSM_MAC);
+	if (ret < 0) {
+		ret = -errno;
+		pr_warn("failed to detach from hook: %s\n",
+			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+		return ret;
+	}
+	close(ll->hook_fd);
+	return 0;
+}
+
+static const char *__lsm_hook_name(const char *title)
+{
+
+	int i;
+
+	if (!title)
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < ARRAY_SIZE(section_names); i++) {
+		if (section_names[i].prog_type != BPF_PROG_TYPE_LSM)
+			continue;
+
+		if (strncmp(title, section_names[i].sec,
+			    section_names[i].len)) {
+			pr_warn("title for a LSM prog must begin with '%s'\n",
+				section_names[i].sec);
+			return ERR_PTR(-EINVAL);
+		}
+
+		return title + section_names[i].len;
+	}
+
+	pr_warn("could not find section information for BPF_PROG_TYPE_LSM\n");
+	return ERR_PTR(-ESRCH);
+}
+
+struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
+{
+	char hook_path[PATH_MAX] = "/sys/kernel/security/bpf/";
+	const char *title, *hook_name;
+	char errmsg[STRERR_BUFSIZE];
+	int prog_fd, target_fd, ret;
+	struct bpf_link_lsm *link;
+
+	title = bpf_program__title(prog, false);
+	if (IS_ERR(title)) {
+		pr_warn("could not determine title of the program\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	hook_name = __lsm_hook_name(title);
+	if (IS_ERR(hook_name)) {
+		pr_warn("could not determine LSM hook name from title '%s'\n",
+			title);
+		return ERR_PTR(-EINVAL);
+	}
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("program '%s': can't attach before loaded\n", title);
+		return ERR_PTR(-EINVAL);
+	}
+
+	link = malloc(sizeof(*link));
+	if (!link)
+		return ERR_PTR(-ENOMEM);
+	link->link.destroy = &bpf_link__destroy_lsm;
+
+	/* Attach the BPF program to the given hook */
+	strncat(hook_path, hook_name,
+		sizeof(hook_path) - (strlen(hook_path) + 1));
+	target_fd = open(hook_path, O_RDWR);
+	if (target_fd < 0) {
+		ret = -errno;
+		pr_warn("program '%s': failed to open to hook '%s': %s\n",
+			title, hook_path,
+			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+		return ERR_PTR(ret);
+	}
+
+	ret = bpf_prog_attach(prog_fd, target_fd, BPF_LSM_MAC,
+			      BPF_F_ALLOW_OVERRIDE);
+	if (ret < 0) {
+		ret = -errno;
+		pr_warn("program '%s': failed to attach to hook '%s': %s\n",
+			title, hook_name,
+			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+		goto error;
+	}
+
+	link->hook_fd = target_fd;
+	link->prog_fd = prog_fd;
+	return &link->link;
+
+error:
+	close(target_fd);
+	return ERR_PTR(ret);
+}
+
 enum bpf_perf_event_ret
 bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 			   void **copy_mem, size_t *copy_size,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9cd69d602c82..655f27ad6ece 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -256,6 +256,8 @@ bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_trace(struct bpf_program *prog);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_lsm(struct bpf_program *prog);
 struct bpf_insn;
 
 /*
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 3d396149755d..5d64ba9b2a43 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -213,4 +213,5 @@ LIBBPF_0.0.7 {
 	global:
 		bpf_program__is_lsm;
 		bpf_program__set_lsm;
+		bpf_program__attach_lsm;
 } LIBBPF_0.0.6;
-- 
2.20.1

