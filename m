Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501FD69D90C
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 03:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjBUCzV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 21:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjBUCzB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 21:55:01 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8494D2D57;
        Mon, 20 Feb 2023 18:54:36 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id bh1so3524290plb.11;
        Mon, 20 Feb 2023 18:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUWQmp5W8Kb/uIgiFWjF+mchWuzL4yG/Sn9X8F8cwr0=;
        b=MNnplTUEN5wJIC1J7wEdQVJ5LmKkg3rvaRnqaZre5mNRTB6eSvNrhFdD0akR2cxhtg
         qs6YKupDOOWPPaP85cXB7JIw8iVJaWISA5JwEnsmDSzeDQ1zQ4yD6kpqUqpSqCEGb5iI
         bFTMXiaMjgK8889+RMtdbD63y/N/XX/VUpiaA43acdWMKOnQMSqkLw9LvYsjl5upPQW8
         Jem43AWYhJYcHTL2cNy85bs5hDi8UVe8vrg0PlsYsVXXofo4wzadpmvZyHYQsF33ao89
         cR7+VhHNs9c/2Dvy2mtE2YfKkOaObGE61G59nMJoRpv4+bM6cmk0F4W7KHVvrHXmwosT
         3jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUWQmp5W8Kb/uIgiFWjF+mchWuzL4yG/Sn9X8F8cwr0=;
        b=zfBoYCXuB+1s4BxhbdukAhFbbyICseCCtEEQM01FGI5MxDZ9UjRN5s//lpj6JCMHd+
         XFYwvvSxucnTEThqUX7t0s76lPgCb9Or6RGCKbM6N+ZuJXQ2mEmXWZcbMtWnoJ1l39w/
         2Q1GBf6STAzpquSXEgevHXvrlIUWs+pTy9ZXttDCuHkkp6bZD804pQBiStT+eViJn5XX
         fs+nkFtIop4tQ90YYB4qE+uZaVyrkwsQx+vsnj7n6at7PPq1gHizF2Mp5POpAEcaHfLs
         +yhUv2fxC7qMY04A9whVjCpfX4hmuc7ua1Jr+fXjsoGUWBDn0mHuqR+E41yqbRKeebfz
         KX8A==
X-Gm-Message-State: AO0yUKWieGqeDnJ6RcTmyrBP3Zrd1i+/DZUiSQ2tmD7/72GHGhV08QMC
        jkrv/LXNPlUqG28mVjK1ZTE=
X-Google-Smtp-Source: AK7set+KEvKlHyUDq0SyBMWLid2Dd4t0MSywmg9svJudMZzxx0JQwoYBvy/MXAHwnfPw5j1wgXf++Q==
X-Received: by 2002:a17:903:18e:b0:19a:5933:936e with SMTP id z14-20020a170903018e00b0019a5933936emr6947129plg.38.1676948071724;
        Mon, 20 Feb 2023 18:54:31 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902e90300b0019a837be977sm8590156pld.271.2023.02.20.18.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:54:31 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v3 1/3] libbpf: add support to set kprobe/uprobe attach mode
Date:   Tue, 21 Feb 2023 10:53:45 +0800
Message-Id: <20230221025347.389047-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230221025347.389047-1-imagedong@tencent.com>
References: <20230221025347.389047-1-imagedong@tencent.com>
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
Reviewed-by: Biao Jiang <benbjiang@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
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
index 05c4db355f28..d07a0d7b9edd 100644
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

