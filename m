Return-Path: <bpf+bounces-3264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E173B9AD
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21C81C21280
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7737945A;
	Fri, 23 Jun 2023 14:16:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D28F5D
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:19 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A4B1FE3;
	Fri, 23 Jun 2023 07:16:17 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b2c3ec38f0so535697a34.1;
        Fri, 23 Jun 2023 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529777; x=1690121777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn+VvMrPWCKqoo4PubFGskWvnQBFZ4/nSXCXeyqhAzE=;
        b=XAZRw8vajFuODFkWd0plHtuUiOq+1ZKOAt8yEy7ldYVPh3llA64dm+uptKo7kKCifh
         SeYIKhVmratGs6p4h0m/+8NSpaAGgcYkyy8chX2OkeWOGFNWGSRPMKwcdrGPJeQH7CgQ
         WmEYxzbTyljLsKpVVPyiv9hahupaRCwjjiyX34AA4RS0vFff8nolx5+5GlKLXU/9ypLa
         JGFuD4uFjwDwn4JOx4b4RDBVv5NWQQsCTFZoPYUliA9jD7zeTFZ/VDf4Fm/4i6qUs//0
         7JBODTBDfmUesKE7MXnPCLitQLITxXRI+46yq0yGIn589obv3chvxF0oJWkJXBhrNT1w
         F9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529777; x=1690121777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn+VvMrPWCKqoo4PubFGskWvnQBFZ4/nSXCXeyqhAzE=;
        b=a1V52yv9qk9MhOq3sG+M1XPmkrsKiW/aiF2hEpe+yrPTg0RdJMcst5mgE2c5YQ+n6U
         Zib4eiuw/faOuxdvrCPl01a69IZqA9do2nVVzJC/GaWiw5xe3s2nvOdO9Wc/wNnYGhBI
         QItWPmGtuYplnF47ZQS/PZ6Y9vQnxSSeDhfXaFccHCg0Y6wdTAisIiSsVfszx+1fWtUh
         PO0wO912WyR02XENfxOtlFi4DP+STWTcA4lO+evPkbpqyjiZQctEa5CgCfaQMeU9eubZ
         1VWposg3jUXX1NspZ5dNMiL1tFHHj2oYpW9fCHZRYYYI1iDANxzZUrZ3QI8vVNwEtnYA
         oONg==
X-Gm-Message-State: AC+VfDwbqRhRhZRL1WVwaKUAlxLQTMvfA9qruADyLLAM1fp5spWLwSnN
	OK3QGuER3B1YGCP2Y0VZEco=
X-Google-Smtp-Source: ACHHUZ4qMvsiDtG0Kn4xihh6gv+bz+axMmIg56sCFqFPVVv/druj3efQuaNd8Mc4SVAFt2vFQGzPvw==
X-Received: by 2002:a9d:6ad1:0:b0:6b5:e4f9:9202 with SMTP id m17-20020a9d6ad1000000b006b5e4f99202mr5134104otq.3.1687529777153;
        Fri, 23 Jun 2023 07:16:17 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:16 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
Date: Fri, 23 Jun 2023 14:15:36 +0000
Message-Id: <20230623141546.3751-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the addition of support for fill_link_info to the kprobe_multi link,
users will gain the ability to inspect it conveniently using the
`bpftool link show`. This enhancement provides valuable information to the
user, including the count of probed functions and their respective
addresses. It's important to note that if the kptr_restrict setting is not
permitted, the probed address will not be exposed, ensuring security.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91..23691ea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6438,6 +6438,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
+			__u32 count;
+			__u32 flags;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6..2123197b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2459,6 +2459,7 @@ struct bpf_kprobe_multi_link {
 	u32 cnt;
 	u32 mods_cnt;
 	struct module **mods;
+	u32 flags;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2548,9 +2549,35 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kfree(kmulti_link);
 }
 
+static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
+						struct bpf_link_info *info)
+{
+	u64 __user *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
+	struct bpf_kprobe_multi_link *kmulti_link;
+	u32 ucount = info->kprobe_multi.count;
+
+	if (!uaddrs ^ !ucount)
+		return -EINVAL;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	info->kprobe_multi.count = kmulti_link->cnt;
+	info->kprobe_multi.flags = kmulti_link->flags;
+
+	if (!uaddrs)
+		return 0;
+	if (ucount < kmulti_link->cnt)
+		return -EINVAL;
+	if (!kallsyms_show_value(current_cred()))
+		return 0;
+	if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
+		return -EFAULT;
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc = bpf_kprobe_multi_link_dealloc,
+	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
@@ -2862,6 +2889,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->addrs = addrs;
 	link->cookies = cookies;
 	link->cnt = cnt;
+	link->flags = flags;
 
 	if (cookies) {
 		/*
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a7b5e91..23691ea 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6438,6 +6438,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
+			__u32 count;
+			__u32 flags;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1


