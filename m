Return-Path: <bpf+bounces-4247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C983749DEE
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC85128132F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D39453;
	Thu,  6 Jul 2023 13:38:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46B9442
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:38:50 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898F19A0
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 06:38:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so7790395e9.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688650726; x=1691242726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy7YTz7mkVbodaWV3g7DCdt5cjBQckNjqdd3qDsHsI0=;
        b=HDMYjrZwISjk6NudvSM4m4ofwqLjXXYwWLnI8PMnS9wgM+SbzOTfxVR1lv934uU4Ex
         vrtJw9LvW0kUTMxLzndocT9ypY06IKnr7d++ozJQtKFWMJFvGCNTQlg9XeRuThvO3yxS
         Di5BPdROZcvV8HWmW96h8n8l9hSvjpZLhNozzto6Ai6GHVAcebC3Vmp1EKv0sMdSv4wp
         pNb4Crf+/3Yo7T5coM0Ld2yJSjJZwKOkmh0HelQgKt917DphBpNlwNUshhxyTTO6IPDG
         jbO8SxlPNIL3sm/IuA7v2B7xsUU9BFtz1dtPGb3Bcm1JYkJd3pYJNvb2XRhOYjdcvXKr
         JeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650726; x=1691242726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy7YTz7mkVbodaWV3g7DCdt5cjBQckNjqdd3qDsHsI0=;
        b=dbX4PNQWpJGOSVgl8TAOJzq6MObuApIROfplR4VQuy1m3d1s1B+2w0uzGO01cpjk0Y
         NJTTP+K7dyRqTC9TvEr3BZT+qattQLsLefVi356U0RsxDG9ospAk7wvxBSUu3KglQbJ/
         xG8DqoWlzOAxQfTi2ME3y84yIHURsFDPAK/sAaNFqvg52kRh5H/cUapbNYxYYTSa418f
         QwBAq6KHr6Hz7VhEwkBW1lEOEjgNI89aGaEc7aH7TSAtxmuNLsmEgRjtpF3H8dhDLDLK
         gRMRsOkR8azOFTVJH2C61t7/O+AiiYT0xEZXypTxJqyUUnFkQu82sw+xjnA0T2m0dZ/a
         XX3g==
X-Gm-Message-State: ABy/qLay/WzJOxa8zo5WfOpBMsE3SbjevQcV96RnHZXvYp3quzt/GC3/
	arI9nSL6rawwJw7GwyXNRI7XBQ==
X-Google-Smtp-Source: APBJJlFYYZVMQAcvkueaYdmKktBqAjRGMKWhJCwysmM40V9gSWnAUQXwPyEu2CPyCAFa4kfrsoqvYA==
X-Received: by 2002:a7b:c8d1:0:b0:3fa:8fb1:50fe with SMTP id f17-20020a7bc8d1000000b003fa8fb150femr1382821wml.15.1688650726439;
        Thu, 06 Jul 2023 06:38:46 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003f9b3829269sm6754524wmo.2.2023.07.06.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:38:45 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 bpf-next 2/5] bpf: add a new kfunc to return current bpf_map elements count
Date: Thu,  6 Jul 2023 13:39:29 +0000
Message-Id: <20230706133932.45883-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706133932.45883-1-aspsk@isovalent.com>
References: <20230706133932.45883-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A bpf_map_sum_elem_count kfunc was added to simplify getting the sum of the map
per-cpu element counters. If a map doesn't implement the counter, then the
function will always return 0.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/map_iter.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index b0fa190b0979..d06d3b7150e5 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -93,7 +93,7 @@ static struct bpf_iter_reg bpf_map_reg_info = {
 	.ctx_arg_info_size	= 1,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__bpf_map, map),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
 	},
 	.seq_info		= &bpf_map_seq_info,
 };
@@ -193,3 +193,40 @@ static int __init bpf_map_iter_init(void)
 }
 
 late_initcall(bpf_map_iter_init);
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc s64 bpf_map_sum_elem_count(struct bpf_map *map)
+{
+	s64 *pcount;
+	s64 ret = 0;
+	int cpu;
+
+	if (!map || !map->elem_count)
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		pcount = per_cpu_ptr(map->elem_count, cpu);
+		ret += READ_ONCE(*pcount);
+	}
+	return ret;
+}
+
+__diag_pop();
+
+BTF_SET8_START(bpf_map_iter_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_map_sum_elem_count, KF_TRUSTED_ARGS)
+BTF_SET8_END(bpf_map_iter_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_map_iter_kfunc_ids,
+};
+
+static int init_subsystem(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_map_iter_kfunc_set);
+}
+late_initcall(init_subsystem);
-- 
2.34.1


