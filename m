Return-Path: <bpf+bounces-390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4987005B4
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 12:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F0B281B18
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DAEBE71;
	Fri, 12 May 2023 10:34:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C034AD57
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 10:34:55 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9717124B3
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so19250615e9.2
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683887648; x=1686479648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqgT86uPEyXHdOLiPS9BK7uUMEWYpDHmxeePdcp8lT0=;
        b=RmA2o2Za3fPhiNxz1gDJOfd0UmL8yx109vVF32j4Ogt7bY1Za5pLJ66I9zaH2aq5LK
         R9x4fPxwk0wPMCYREJcXBKcc+qxpmxrFCRNjLeT+6lkxBTy7LuyjAqpAxfvpdP3D5JzD
         gsmZYwia5PL0ilfRUF4pfDWXh+pmnd0DXHFRvRBOdyx0OEWGUDWaMLDlxdxr31OCsTUe
         eYEDuIcab0KBd1urK+Lv6/VQSWrlk45hN9u6qgWO3pcK05DiSE191Ju96ENKa8MnCHlt
         Hk9zqBtGWSVPosgClo0XFqjfsKUZSgcNYM6bXl1n6wIvPsvC0uQBkGqKBZa35Kr4oa7C
         AZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887648; x=1686479648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqgT86uPEyXHdOLiPS9BK7uUMEWYpDHmxeePdcp8lT0=;
        b=CvzgSLXeV5rFU/FnwdOPhxwbWwhA/tbRVnppbqmZTsl4i4MxOlHGk4vjvHfV/KCNUc
         OzcHCHE6xn1Nk8Z5m3NPkVH5Hs9mRH7EAvMmhE+vYWdny3+5DFreeoDnw3xi1WKcdqtq
         CD3rnpU6pcUE02nx6WPdCY1z6R4hs1zc+VZEqureBxG6tIv8zbJWzno8a/lboExeWB2h
         xObTQX9rR7f8mXvJ6k51Pn82MIfVEn+IC4dZIUt6D0ubXzXvAVibzwGxdEy2cBdsteef
         rXsOU265dtIw2/k0TznlMs9EY1WGZ5tYUhFwJRrhzwZdQaWiemj8AMx3S1XjdS3PJOhO
         Br8w==
X-Gm-Message-State: AC+VfDwKJQzMWUggOaEbo0rluICu0BO2DaKQhRLKZSnsKcnDqByFgvJi
	4IYfvSSsKVYFnclAIw68+Ne1Ag==
X-Google-Smtp-Source: ACHHUZ4YfrpXcM9nC0GJaw+1zgmFPocYiKWdsbjHnZXaMbrUeQLjWnr3kYxm6s3KdQkAP/SO0yp/Lw==
X-Received: by 2002:a5d:428f:0:b0:2f7:e3aa:677a with SMTP id k15-20020a5d428f000000b002f7e3aa677amr17107257wrq.46.1683887648611;
        Fri, 12 May 2023 03:34:08 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:a162:20e4:626a:dd])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b003078cd719ffsm17946320wrr.95.2023.05.12.03.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:34:08 -0700 (PDT)
From: Quentin Monnet <quentin@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH bpf-next 3/4] bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c
Date: Fri, 12 May 2023 11:33:53 +0100
Message-Id: <20230512103354.48374-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512103354.48374-1-quentin@isovalent.com>
References: <20230512103354.48374-1-quentin@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In order to allow the BPF program in bpftool's pid_iter.bpf.c to compile
correctly on hosts where vmlinux.h does not define
BPF_LINK_TYPE_PERF_EVENT (running kernel versions lower than 5.15, for
example), define and use a local copy of the enum value. This requires
LLVM 12 or newer to build the BPF program.

Fixes: cbdaf71f7e65 ("bpftool: Add bpf_cookie to link output")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 3a4c4f7d83d8..26004f0c5a6a 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -24,6 +24,10 @@ struct perf_event___local {
 	u64 bpf_cookie;
 } __attribute__((preserve_access_index));
 
+enum bpf_link_type___local {
+	BPF_LINK_TYPE_PERF_EVENT___local = 7,
+};
+
 extern const void bpf_link_fops __ksym;
 extern const void bpf_map_fops __ksym;
 extern const void bpf_prog_fops __ksym;
@@ -93,10 +97,13 @@ int iter(struct bpf_iter__task_file *ctx)
 	e.pid = task->tgid;
 	e.id = get_obj_id(file->private_data, obj_type);
 
-	if (obj_type == BPF_OBJ_LINK) {
+	if (obj_type == BPF_OBJ_LINK &&
+	    bpf_core_enum_value_exists(enum bpf_link_type___local,
+				       BPF_LINK_TYPE_PERF_EVENT___local)) {
 		struct bpf_link *link = (struct bpf_link *) file->private_data;
 
-		if (BPF_CORE_READ(link, type) == BPF_LINK_TYPE_PERF_EVENT) {
+		if (link->type == bpf_core_enum_value(enum bpf_link_type___local,
+						      BPF_LINK_TYPE_PERF_EVENT___local)) {
 			e.has_bpf_cookie = true;
 			e.bpf_cookie = get_bpf_cookie(link);
 		}
-- 
2.34.1


