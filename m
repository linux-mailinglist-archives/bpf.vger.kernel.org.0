Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1F8688DDD
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 04:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjBCDSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 22:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjBCDSn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 22:18:43 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24A53B31;
        Thu,  2 Feb 2023 19:18:42 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so3754304pjb.1;
        Thu, 02 Feb 2023 19:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8T4GxvH3ecLMhoa7M3nY3X271thDzk3OTlhfr3JaAo=;
        b=P2kniv+c+Jjutwu7YxBz3n1H/q/DaWJXjCH5FnGUXyQ3JHM7nd8fNOeFFMuJ68dyB1
         srltCs8oOu67F1U31W2arJf/DzqZ5e2IUHm95hod36+Wz8wSnlml/LA2PhvEzJ8LTl77
         +ukxMFCprDtQ61Zxnr9+1p0nQlpYoK2AGRfj/577H29pKSRd5ctZNy/32W97GDnPKDVi
         mHI70Rd53/cwkv3xLrZ2nmlkRBH+9X3xNuFjrzZaEsiqg6kRd748FzIZQFqkK4yGm20K
         8evuF1MbB4jANMspENTD39RHQUHJnfdgymHSQqrB11BSTByxFF1yHkURSRP2eRyhHkiy
         IJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8T4GxvH3ecLMhoa7M3nY3X271thDzk3OTlhfr3JaAo=;
        b=7rccsrJoJNz+RpoxUanHTttAyJHDSNS2O4x2LRXC6dc7gxaiAefrbtw1YkYcMeZDqt
         cxjuoqX/SKki9chTErppID72WksHt9T7chZpBpGKMsd2sq2LVXLmR4afS77Iatu5TY/i
         hUGGg8NDd+eq7Gft6ZaPyW38U464SjmQKFCIXtLoxJn97u4IsFq7QTiy+ta0DJpxRM7k
         jDkyIcgmzJKC4fOwRsB2KuF/R3p1Doalrw/ObuHvgZDmRFuZit6b8749kaQjnhdJNht1
         YwJN/LzYZsMdNtZESFmvPAVlAXKu3X09txstgGUKebqskd9TWTB7t85HW1ELaW5Q2J72
         PfrA==
X-Gm-Message-State: AO0yUKWPAKSzWs13V9tQVSUCnFU9D/46snEzbG5IHgUPzJviu1j8AEKC
        t6ujOAOQKB3fEuylVzxIWrU=
X-Google-Smtp-Source: AK7set8hxFh78t84Wu3vvyZhpeFeVBfycuBPgxdA4MmDzd3t0um/NAueLlybWvLLbhMWrjVolYcSRw==
X-Received: by 2002:a17:902:f2c5:b0:196:8437:1b38 with SMTP id h5-20020a170902f2c500b0019684371b38mr7166029plc.58.1675394321590;
        Thu, 02 Feb 2023 19:18:41 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001899c2a0ae0sm416009pld.40.2023.02.02.19.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 19:18:41 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next 1/2] libbpf: add support to set kprobe/uprobe attach mode
Date:   Fri,  3 Feb 2023 11:17:41 +0800
Message-Id: <20230203031742.1730761-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203031742.1730761-1-imagedong@tencent.com>
References: <20230203031742.1730761-1-imagedong@tencent.com>
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
 tools/lib/bpf/libbpf.c | 26 +++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h | 19 ++++++++++++++++---
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index eed5cec6f510..0d20bf1ee301 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9784,7 +9784,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 	link->link.dealloc = &bpf_link_perf_dealloc;
 	link->perf_event_fd = pfd;
 
-	if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
+	if (kernel_supports(prog->obj, FEAT_PERF_LINK) && !opts->no_link) {
 		DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
 			.perf_event.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0));
 
@@ -10148,16 +10148,28 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	struct bpf_link *link;
 	size_t offset;
 	bool retprobe, legacy;
+	enum probe_mode mode;
 	int pfd, err;
 
 	if (!OPTS_VALID(opts, bpf_kprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	mode = OPTS_GET(opts, mode, PROBE_MODE_DEFAULT);
 	retprobe = OPTS_GET(opts, retprobe, false);
 	offset = OPTS_GET(opts, offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
 	legacy = determine_kprobe_perf_type() < 0;
+	switch (mode) {
+	case PROBE_MODE_LEGACY:
+		legacy = true;
+	case PROBE_MODE_PERF:
+		pe_opts.no_link = true;
+		break;
+	default:
+		break;
+	}
+
 	if (!legacy) {
 		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
 					    func_name, offset,
@@ -10817,10 +10829,12 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	int pfd, err;
 	bool retprobe, legacy;
 	const char *func_name;
+	enum probe_mode mode;
 
 	if (!OPTS_VALID(opts, bpf_uprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	mode = OPTS_GET(opts, mode, PROBE_MODE_DEFAULT);
 	retprobe = OPTS_GET(opts, retprobe, false);
 	ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
@@ -10849,6 +10863,16 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	}
 
 	legacy = determine_uprobe_perf_type() < 0;
+	switch (mode) {
+	case PROBE_MODE_LEGACY:
+		legacy = true;
+	case PROBE_MODE_PERF:
+		pe_opts.no_link = true;
+		break;
+	default:
+		break;
+	}
+
 	if (!legacy) {
 		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
 					    func_offset, pid, ref_ctr_off);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 8777ff21ea1d..7fb474e036a3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -451,8 +451,10 @@ struct bpf_perf_event_opts {
 	size_t sz;
 	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
 	__u64 bpf_cookie;
+	/* don't use bpf_link when attach eBPF pprogram */
+	bool no_link;
 };
-#define bpf_perf_event_opts__last_field bpf_cookie
+#define bpf_perf_event_opts__last_field no_link
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
@@ -461,6 +463,13 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int pfd,
 				    const struct bpf_perf_event_opts *opts);
 
+enum probe_mode {
+	PROBE_MODE_DEFAULT = 0, /* latest supported by kernel */
+	PROBE_MODE_LEGACY,
+	PROBE_MODE_PERF,
+	PROBE_MODE_LINK,
+};
+
 struct bpf_kprobe_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
@@ -470,9 +479,11 @@ struct bpf_kprobe_opts {
 	size_t offset;
 	/* kprobe is return probe */
 	bool retprobe;
+	/* kprobe attach mode */
+	enum probe_mode mode;
 	size_t :0;
 };
-#define bpf_kprobe_opts__last_field retprobe
+#define bpf_kprobe_opts__last_field mode
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
@@ -570,9 +581,11 @@ struct bpf_uprobe_opts {
 	 * binary_path.
 	 */
 	const char *func_name;
+	/* uprobe attach mode */
+	enum probe_mode mode;
 	size_t :0;
 };
-#define bpf_uprobe_opts__last_field func_name
+#define bpf_uprobe_opts__last_field mode
 
 /**
  * @brief **bpf_program__attach_uprobe()** attaches a BPF program
-- 
2.39.0

