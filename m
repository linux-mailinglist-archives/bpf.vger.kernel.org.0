Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB269C6FB
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 09:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjBTIs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 03:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjBTIsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 03:48:30 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD66EAC;
        Mon, 20 Feb 2023 00:48:28 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t1so11686pgi.2;
        Mon, 20 Feb 2023 00:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLxhF1Vcq3GMM6HBucXQZ50MR4RWeTxfqHBKQ6buE0A=;
        b=I4J9EXZYCSGkDr83/Pnd9GkqXLe6mpiAjVHt/Xg5CNf6Iew5Vq+8bdlh9MSxlNFCfL
         FJgq/oEfkFE5ShI1P1i6q7CjwEJ7Jr80FJGibk7nufetPWazxGHkYPvZVJNPpYV9sPBu
         3+NRaQbcNew13+CgZgqOexZLRbZfRfCLPzq8snB+vkUUOjqrjH0fpqye7WPBD5GO3RR7
         cslsrK96Fcf7QeJd7MYBwVJQevbAz2lGorMkC62FFZw06dDBOIbvC3Cqr1iz0hsMIG/g
         TNDSEPySQoT7Y7Nat3bf8dYtyU0BbpEGd/Rf/bx+ZO9dlIEySGbQ7t+EjtwX3rVHPRAm
         WZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLxhF1Vcq3GMM6HBucXQZ50MR4RWeTxfqHBKQ6buE0A=;
        b=2b3c/0JyeQalfyg1SnOH5NVVauoDBEccBDK1ZP3ltaj2yoAXQzVRB0QCwh1LRmLupj
         9Vc4VqRks+OlBhc92KEvqbj+SErVEG8oKSxp3LSJWGJrbBcomjY7QUpkj836MBj88IrY
         STWRi5ch8M22i0GL1gz+4CUjGblxx/9hhFjERIVcihxvrz5+iLq+9FPW50PRQyTLI1Rr
         buOifKiRz+WShqxrqxR4FPAvCx0R06IJhTmSH7cRgYEnrkavUSmv7TgAWUz6r4tjf4mx
         kvQ0RJ7RyVHMkWa2xwG2V8oTjsGQt0qxWexCBB6qe8TkKef68xDoJ2hLQztPqIdziasQ
         fWOg==
X-Gm-Message-State: AO0yUKVRkVJr/FKdEstvm41hunEYSPtzmdPxfvMVRY4MfMjcVoBT9Ak1
        4emPvD7qnmkCY0u9BnbxHp4=
X-Google-Smtp-Source: AK7set91QE5NSsmHRUBpcvHf8sBpNsssH9L+Z8hFG1PjtFZzD9pqJ4oii0pl6ckbnnWU+ZOP+b+cLQ==
X-Received: by 2002:a62:7957:0:b0:5a9:b4b4:6911 with SMTP id u84-20020a627957000000b005a9b4b46911mr3238651pfc.25.1676882907991;
        Mon, 20 Feb 2023 00:48:27 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id n11-20020a62e50b000000b00586fbbdf6e4sm7136378pff.34.2023.02.20.00.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 00:48:27 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v2 1/3] libbpf: add support to set kprobe/uprobe attach mode
Date:   Mon, 20 Feb 2023 16:47:09 +0800
Message-Id: <20230220084711.261642-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230220084711.261642-1-imagedong@tencent.com>
References: <20230220084711.261642-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

By default, libbpf will attach the kprobe/uprobe eBPF program in the
latest mode that supported by kernel. In this patch, we add the support
to let users manually attach kprobe/uprobe in legacy or perf mode.

There are 3 mode that supported by the kernel to attach kprobe/uprobe:

  LEGACY: create perf event in legacy way and don't use bpf_link
  PERF: create perf event with perf_event_open() and don't use bpf_link
  LINK: create perf event with perf_event_open() and use bpf_link

Users now can manually choose the mode with
bpf_program__attach_uprobe_opts()/bpf_program__attach_kprobe_opts().

Link: https://lore.kernel.org/bpf/20230113093427.1666466-1-imagedong@tencent.com/
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v2:
- rename no_link to force_ioctl_attach
- rename probe_mode to probe_attach_mode
- add more doc for probe_attach_mode
- return -ENOTSUP when necessray in bpf_program__attach_uprobe_opts and
  bpf_program__attach_kprobe_opts
---
 tools/lib/bpf/libbpf.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h | 31 ++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 35a698eb825d..724ee5fab839 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9747,7 +9747,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 	link->link.dealloc = &bpf_link_perf_dealloc;
 	link->perf_event_fd = pfd;
 
-	if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
+	if (kernel_supports(prog->obj, FEAT_PERF_LINK) && !opts->force_ioctl_attach) {
 		DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
 			.perf_event.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0));
 
@@ -10106,6 +10106,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 				const struct bpf_kprobe_opts *opts)
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+	enum probe_attach_mode attach_mode;
 	char errmsg[STRERR_BUFSIZE];
 	char *legacy_probe = NULL;
 	struct bpf_link *link;
@@ -10116,11 +10117,30 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	if (!OPTS_VALID(opts, bpf_kprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	attach_mode = OPTS_GET(opts, attach_mode, PROBE_ATTACH_MODE_DEFAULT);
 	retprobe = OPTS_GET(opts, retprobe, false);
 	offset = OPTS_GET(opts, offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
 	legacy = determine_kprobe_perf_type() < 0;
+	switch (attach_mode) {
+	case PROBE_ATTACH_MODE_LEGACY:
+		legacy = true;
+		pe_opts.force_ioctl_attach = true;
+		break;
+	case PROBE_ATTACH_MODE_PERF:
+		if (legacy)
+			return libbpf_err_ptr(-ENOTSUP);
+		pe_opts.force_ioctl_attach = true;
+		break;
+	case PROBE_ATTACH_MODE_LINK:
+		if (!kernel_supports(prog->obj, FEAT_PERF_LINK))
+			return libbpf_err_ptr(-ENOTSUP);
+		break;
+	default:
+		break;
+	}
+
 	if (!legacy) {
 		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
 					    func_name, offset,
@@ -10774,6 +10794,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	char errmsg[STRERR_BUFSIZE], *legacy_probe = NULL;
+	enum probe_attach_mode attach_mode;
 	char full_binary_path[PATH_MAX];
 	struct bpf_link *link;
 	size_t ref_ctr_off;
@@ -10784,6 +10805,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (!OPTS_VALID(opts, bpf_uprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	attach_mode = OPTS_GET(opts, attach_mode, PROBE_ATTACH_MODE_DEFAULT);
 	retprobe = OPTS_GET(opts, retprobe, false);
 	ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
@@ -10812,6 +10834,24 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	}
 
 	legacy = determine_uprobe_perf_type() < 0;
+	switch (attach_mode) {
+	case PROBE_ATTACH_MODE_LEGACY:
+		legacy = true;
+		pe_opts.force_ioctl_attach = true;
+		break;
+	case PROBE_ATTACH_MODE_PERF:
+		if (legacy)
+			return libbpf_err_ptr(-ENOTSUP);
+		pe_opts.force_ioctl_attach = true;
+		break;
+	case PROBE_ATTACH_MODE_LINK:
+		if (!kernel_supports(prog->obj, FEAT_PERF_LINK))
+			return libbpf_err_ptr(-ENOTSUP);
+		break;
+	default:
+		break;
+	}
+
 	if (!legacy) {
 		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
 					    func_offset, pid, ref_ctr_off);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2efd80f6f7b9..ef8f68da42f9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -451,8 +451,11 @@ struct bpf_perf_event_opts {
 	size_t sz;
 	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
 	__u64 bpf_cookie;
+	/* don't use bpf_link when attach eBPF program */
+	bool force_ioctl_attach;
+	size_t :0;
 };
-#define bpf_perf_event_opts__last_field bpf_cookie
+#define bpf_perf_event_opts__last_field force_ioctl_attach
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
@@ -461,6 +464,24 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int pfd,
 				    const struct bpf_perf_event_opts *opts);
 
+
+/**
+ * enum probe_attach_mode - the mode to attach kprobe/uprobe
+ *
+ * force libbpf to attach kprobe/uprobe in specific mode, -ENOTSUP will
+ * be returned if it is not supported by the kernel.
+ */
+enum probe_attach_mode {
+	/* attach probe in latest supported mode by kernel */
+	PROBE_ATTACH_MODE_DEFAULT = 0,
+	/* attach probe in legacy mode */
+	PROBE_ATTACH_MODE_LEGACY,
+	/* create perf event with perf_event_open() syscall */
+	PROBE_ATTACH_MODE_PERF,
+	/* attach probe with bpf_link */
+	PROBE_ATTACH_MODE_LINK,
+};
+
 struct bpf_kprobe_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
@@ -470,9 +491,11 @@ struct bpf_kprobe_opts {
 	size_t offset;
 	/* kprobe is return probe */
 	bool retprobe;
+	/* kprobe attach mode */
+	enum probe_attach_mode attach_mode;
 	size_t :0;
 };
-#define bpf_kprobe_opts__last_field retprobe
+#define bpf_kprobe_opts__last_field attach_mode
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
@@ -570,9 +593,11 @@ struct bpf_uprobe_opts {
 	 * binary_path.
 	 */
 	const char *func_name;
+	/* uprobe attach mode */
+	enum probe_attach_mode attach_mode;
 	size_t :0;
 };
-#define bpf_uprobe_opts__last_field func_name
+#define bpf_uprobe_opts__last_field attach_mode
 
 /**
  * @brief **bpf_program__attach_uprobe()** attaches a BPF program
-- 
2.39.0

