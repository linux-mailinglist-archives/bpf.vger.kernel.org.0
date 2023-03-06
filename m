Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2F6AB686
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 07:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCFGtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 01:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCFGtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 01:49:00 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A414E84;
        Sun,  5 Mar 2023 22:48:59 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 132so4858987pgh.13;
        Sun, 05 Mar 2023 22:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678085338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za/vpdgxgsm+vcKArmb0g+j0EgA2JYzJOnUmmwgDoag=;
        b=iMxxTer6BT42HbCC620DT5Z4swrbE97xY0h9UBMRpgo+HYgp46zGcxtrmuW9Hrcxon
         dXXAVpe5frBkyov0u8ICnW7iLoDcscnjgtYPPyIWxDRCKEPOpGaC+QNVNfXRtHk4IXm3
         97M0+/CqZeRf/ZkpsoFEDhdgO1yUK8UHVc4IxXj0EPW7xmRDkcgMHRUjovxptfu2yfGC
         CFjsFhBzJHvpJGLuMtPymSERQb6rbNBNNjWrtEqRyMg7vyZFz7vwxiDvZbVbD0VpqyZE
         DWGSVCPkhTH9pNmIUGMIDYDYK1Az4gARQ/8L784B7ftVvXIlNkvMojnuWnJxpPCj9niv
         vzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678085338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za/vpdgxgsm+vcKArmb0g+j0EgA2JYzJOnUmmwgDoag=;
        b=edFplDpWhCz5Ti6ALZDL+ZUNJrgxPhsDs2J5ds+3dgWKZbM1W2QiBIhdBPrFmGn9FE
         5offZKi/pq+7FRg/zt/d9FPdeZLLXK4tAwS1iEPhg7MiG8PABrV5JG7Hx9JDtcPHRfIB
         RPnZmjRHolmvF/htkoDs16utGPqMZLZ7eFChjq91Sor/SaBJWD/J2yc4ArT3QshkkvY+
         9rCLTZAdJHg0Q1P/APVCr3gBvTSn8QHl80WJPdnquc3Jfggut9pMSg9YeWq4jZOv6qsZ
         3eANySfMIbgzAUdFcYm3zOCAX/uXOGgaxaeLpPO9ESk0qeZZ6DrqWsNlHEemk1NUQynk
         zndA==
X-Gm-Message-State: AO0yUKU8X1SjJhrU5HSHl7yPAOinADEvQaQUuPcbN7wHm4SKBdvicnG0
        7kaazjIuadoWLWof+vV3318=
X-Google-Smtp-Source: AK7set+YuIJ0+xUrBEwuyia7Vvac6m76qXd520bAfmP+CBKQQatvhP2ibz98oAKA6EjkUSluAyPoqQ==
X-Received: by 2002:a62:cf81:0:b0:5dc:4b6:b18d with SMTP id b123-20020a62cf81000000b005dc04b6b18dmr8106767pfg.26.1678085338619;
        Sun, 05 Mar 2023 22:48:58 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78189000000b0061a942c8b62sm2378184pfi.43.2023.03.05.22.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 22:48:58 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v4 1/3] libbpf: add support to set kprobe/uprobe attach mode
Date:   Mon,  6 Mar 2023 14:48:31 +0800
Message-Id: <20230306064833.7932-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230306064833.7932-1-imagedong@tencent.com>
References: <20230306064833.7932-1-imagedong@tencent.com>
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

By default, libbpf will attach the kprobe/uprobe BPF program in the
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
---
v4:
- rename eBPF to BPF in the doc
- use OPTS_GET() to get the value of 'force_ioctl_attach'
- error out on attach mode is not supported
v2:
- rename no_link to force_ioctl_attach
- rename probe_mode to probe_attach_mode
- add more doc for probe_attach_mode
- return -ENOTSUP when necessray in bpf_program__attach_uprobe_opts and
  bpf_program__attach_kprobe_opts
---
 tools/lib/bpf/libbpf.c | 47 +++++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h | 31 +++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dacaae31b76a..77df4d275d22 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9747,7 +9747,8 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 	link->link.dealloc = &bpf_link_perf_dealloc;
 	link->perf_event_fd = pfd;
 
-	if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
+	if (kernel_supports(prog->obj, FEAT_PERF_LINK) && !OPTS_GET(opts, force_ioctl_attach,
+								    false)) {
 		DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
 			.perf_event.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0));
 
@@ -10106,6 +10107,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 				const struct bpf_kprobe_opts *opts)
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+	enum probe_attach_mode attach_mode;
 	char errmsg[STRERR_BUFSIZE];
 	char *legacy_probe = NULL;
 	struct bpf_link *link;
@@ -10116,11 +10118,32 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
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
+		if (legacy || !kernel_supports(prog->obj, FEAT_PERF_LINK))
+			return libbpf_err_ptr(-ENOTSUP);
+		break;
+	case PROBE_ATTACH_MODE_DEFAULT:
+		break;
+	default:
+		return libbpf_err_ptr(-ENOTSUP);
+	}
+
 	if (!legacy) {
 		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
 					    func_name, offset,
@@ -10852,6 +10875,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	const char *archive_path = NULL, *archive_sep = NULL;
 	char errmsg[STRERR_BUFSIZE], *legacy_probe = NULL;
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+	enum probe_attach_mode attach_mode;
 	char full_path[PATH_MAX];
 	struct bpf_link *link;
 	size_t ref_ctr_off;
@@ -10862,6 +10886,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (!OPTS_VALID(opts, bpf_uprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	attach_mode = OPTS_GET(opts, attach_mode, PROBE_ATTACH_MODE_DEFAULT);
 	retprobe = OPTS_GET(opts, retprobe, false);
 	ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
@@ -10903,6 +10928,26 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
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
+		if (legacy || !kernel_supports(prog->obj, FEAT_PERF_LINK))
+			return libbpf_err_ptr(-ENOTSUP);
+		break;
+	case PROBE_ATTACH_MODE_DEFAULT:
+		break;
+	default:
+		return libbpf_err_ptr(-ENOTSUP);
+	}
+
 	if (!legacy) {
 		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
 					    func_offset, pid, ref_ctr_off);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2efd80f6f7b9..38b234de418a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -451,8 +451,11 @@ struct bpf_perf_event_opts {
 	size_t sz;
 	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
 	__u64 bpf_cookie;
+	/* don't use BPF link when attach BPF program */
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
+	/* attach probe in legacy mode, using debugfs/tracefs */
+	PROBE_ATTACH_MODE_LEGACY,
+	/* create perf event with perf_event_open() syscall */
+	PROBE_ATTACH_MODE_PERF,
+	/* attach probe with BPF link */
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

