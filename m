Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923B74F0B15
	for <lists+bpf@lfdr.de>; Sun,  3 Apr 2022 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiDCQKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiDCQKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 12:10:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4B3982F
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 09:08:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id yy13so15352003ejb.2
        for <bpf@vger.kernel.org>; Sun, 03 Apr 2022 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmF+ymoe8wOdYdz0lGumCQH9uSAZdCIQqrCOPr17rPc=;
        b=DUookdZRR1A1cAEMlfp9QfVjiJQbPsOUrsssj+mvZHHxh9ZBA5z7zYUkM7zpSFQdFb
         h0UY4bTaH9y6ezfABiJ36g3pkyDyuAFk/TIQnKREjHMEKdb9HZsBLaSvuYRABrN6L213
         uzo2LGK6VIoFvEkBT4ojXPaHBvxvmseLACYqYe8pb6GdYNTWNOA4yGZ7JN3ExdDr5zPv
         QswYYzUc6DB+bpppDmYDDtGjCudeEpsKCugVHRaxsOreBLFBfM9dMMlOi97pGsKWFlGy
         EAgwUZmLZ2Nyd9uYcupeEZrw9J9OmUqk4QygMzn6M725NhPX8PHTEumBOelHBBHicBX9
         TwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmF+ymoe8wOdYdz0lGumCQH9uSAZdCIQqrCOPr17rPc=;
        b=sS5uO5vWufT1s4bYSae6akWYKUwtGQNF6xE3vClPXZIEclTByjO27uz0AfS2OXClG9
         fXQ6F/pf5/KSJZDiYYQQkl7dM2Fj8PVoTb3eZ906Eu6o1T13HMGm78QoV85j0PxrdC66
         LFXXmZCpiYpR1q8OdJpqkgbNvBfpZ0DAGWq3f+9gZ0ivrmPwAmJO1Xehh38/H+oALa/i
         Rg7Iuh3w90aow95rk7X1UMwg+JEOMHqqsnOcgegBD53/fNONze7R2sRMrl/gqoOOJsLg
         H+4SfBs/4dhB9NHioN0LEIRLUnURslWT3wI/rxkhSzSypHwRgB7ht+YXv1RuieqEas98
         jpJQ==
X-Gm-Message-State: AOAM5304e+Cu9CXdFTT5e+hboPHlYjlyYU3BHXJXkmfUGUTotKVxoXvI
        e0hi44D2QjJvarJPcuV8Dkx/qRSbk1Puyg==
X-Google-Smtp-Source: ABdhPJw2LA+K8BX4UEtJ9kWe4Cqd8IZFPZZu7hoGmYfNWILcnIChlaw0xTu/LzFqGizIyZHjLoHb8w==
X-Received: by 2002:a17:907:3e8d:b0:6e7:f1fe:5912 with SMTP id hs13-20020a1709073e8d00b006e7f1fe5912mr728542ejc.314.1649002095848;
        Sun, 03 Apr 2022 09:08:15 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-030-091.094.222.pools.vodafone-ip.de. [94.222.30.91])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm3332053ejl.185.2022.04.03.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:08:15 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, yhs@fb.com,
        songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH bpf-next 2/2] libbpf: Allow setting bpf_prog priority
Date:   Sun,  3 Apr 2022 18:07:18 +0200
Message-Id: <20220403160718.13730-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403160718.13730-1-9erthalion6@gmail.com>
References: <20220403160718.13730-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce prio field in opts structures (bpf_tracepoint_opts,
bpf_link_create_opts, bpf_perf_event_opts) to pass a priority value for
the bpf_prog when a new bpf link is created. This value will be further
used in perf_event_set_bpf_prog to specify in which order to execute
bpf_progs attached to the same tracepoint.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 kernel/bpf/syscall.c   | 3 ++-
 tools/lib/bpf/bpf.c    | 1 +
 tools/lib/bpf/bpf.h    | 1 +
 tools/lib/bpf/libbpf.c | 4 +++-
 tools/lib/bpf/libbpf.h | 6 ++++--
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 72fb3d2c30a4..629852b35b21 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3009,7 +3009,8 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 	}
 
 	event = perf_file->private_data;
-	err = perf_event_set_bpf_prog(event, prog, attr->link_create.perf_event.bpf_cookie, 0);
+	err = perf_event_set_bpf_prog(event, prog, attr->link_create.perf_event.bpf_cookie,
+								  attr->link_create.perf_event.prio);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_file;
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index cf27251adb92..029c9809bf9b 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -851,6 +851,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 		break;
 	case BPF_PERF_EVENT:
 		attr.link_create.perf_event.bpf_cookie = OPTS_GET(opts, perf_event.bpf_cookie, 0);
+		attr.link_create.perf_event.prio = OPTS_GET(opts, perf_event.prio, 0);
 		if (!OPTS_ZEROED(opts, perf_event))
 			return libbpf_err(-EINVAL);
 		break;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f4b4afb6d4ba..9a8ec9081ba7 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -412,6 +412,7 @@ struct bpf_link_create_opts {
 	union {
 		struct {
 			__u64 bpf_cookie;
+			__u32 prio;
 		} perf_event;
 		struct {
 			__u32 flags;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 809fe209cdcc..e09c00b53772 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9912,7 +9912,8 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 
 	if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
 		DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
-			.perf_event.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0));
+			.perf_event.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0),
+			.perf_event.prio = OPTS_GET(opts, prio, 0));
 
 		link_fd = bpf_link_create(prog_fd, pfd, BPF_PERF_EVENT, &link_opts);
 		if (link_fd < 0) {
@@ -10663,6 +10664,7 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
 		return libbpf_err_ptr(-EINVAL);
 
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
+	pe_opts.prio = OPTS_GET(opts, prio, 0);
 
 	pfd = perf_event_open_tracepoint(tp_category, tp_name);
 	if (pfd < 0) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 05dde85e19a6..30f1808a4b49 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -394,8 +394,9 @@ struct bpf_perf_event_opts {
 	size_t sz;
 	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
 	__u64 bpf_cookie;
+	__u32 prio;
 };
-#define bpf_perf_event_opts__last_field bpf_cookie
+#define bpf_perf_event_opts__last_field prio
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
@@ -508,8 +509,9 @@ struct bpf_tracepoint_opts {
 	size_t sz;
 	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
 	__u64 bpf_cookie;
+	__u32 prio;
 };
-#define bpf_tracepoint_opts__last_field bpf_cookie
+#define bpf_tracepoint_opts__last_field prio
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_tracepoint(const struct bpf_program *prog,
-- 
2.32.0

