Return-Path: <bpf+bounces-4420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A166B74AE46
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 11:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D86F28172C
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D011C127;
	Fri,  7 Jul 2023 09:55:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A4C122
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:55:00 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C027268E
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 02:54:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso26399321fa.3
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688723688; x=1691315688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqgT86uPEyXHdOLiPS9BK7uUMEWYpDHmxeePdcp8lT0=;
        b=fzhdyE4ZXiYOt9QIIMez4DitCCDlD8P0+3v17Aad515zN4QTopTYY8QS+VVknMxuRs
         /1UfRoIPZXwZDrSKMnNzVP7gIbAXzWlTrJgNc7L/bXPt2cqD1j3Pdy11NQBo7uir2AI/
         UYDe/fnOuVwSYjFjpFJBhVFueAh7dmhHWi2Uvx3QrcQqoUPbCeZg5anJm5/KFJVTOtil
         O81cw55gHBIg5bAwASvZxd/i9gEexzZnsNVMzpFBeBOi5ckEGkWMwaynPrNolZiFM+Rz
         rcoRJDb8QoCno8xLyXvm0fBvxArbfQWT2rn5VxnO+8XVqpmNvSmUqlLOC/kqaxFCNcey
         LBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688723688; x=1691315688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqgT86uPEyXHdOLiPS9BK7uUMEWYpDHmxeePdcp8lT0=;
        b=LkNjMjcXq03ExEqJrTUyDBvL12f2QLktw8VidoGmZHOmz7A8WvmXhRDIWRKPM3+VxA
         zIl2ZVAy5sw3fWcpUH+8MsNMtujIPEjDHuR0m4jVDmdzCzsTnB1Xj1xmXgH5h8CE+eRA
         xV8lxIlwzaSaPjlXP85rqgRadGekdp6MoTAOsxhbtmYBeubT82KehaJ1D3kRZHAYn7Yv
         0Wi97EpllxNnOXeyAQ7PC3x15W4L3PateAzz4G1snY4RFNoUVacfKrQVhGxfZ0R0wiBp
         eArCfHZGYT/AXtmGshAcKENh9KpHJEEIht6GtscCOC8lZWd6lZ99NxdfSL/PdgkYq0a2
         ZMlg==
X-Gm-Message-State: ABy/qLal4UL39KbWfoGO/sZugitIHCGYTws+Xlmym/3gHzbhagaLyanc
	3qD56rRivUnZZgQq/FHbtjAxCw==
X-Google-Smtp-Source: APBJJlECoLy4mvtORj7gJlkI0UA6r7XXSuyqulwzAz8BUbtqWjxw/NO/oX6WcKQOrBK2MBgcgxX0Kg==
X-Received: by 2002:a2e:7802:0:b0:2b6:cf64:7a8e with SMTP id t2-20020a2e7802000000b002b6cf647a8emr3402127ljc.19.1688723688509;
        Fri, 07 Jul 2023 02:54:48 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:9d9e:aaa3:b629:361])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b003fc00972c3esm622636wmb.48.2023.07.07.02.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 02:54:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/4] bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c
Date: Fri,  7 Jul 2023 10:54:24 +0100
Message-Id: <20230707095425.168126-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707095425.168126-1-quentin@isovalent.com>
References: <20230707095425.168126-1-quentin@isovalent.com>
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


