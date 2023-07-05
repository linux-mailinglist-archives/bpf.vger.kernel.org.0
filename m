Return-Path: <bpf+bounces-4073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A67488CD
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49221C20B7A
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E96612B84;
	Wed,  5 Jul 2023 16:01:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C32125CC
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:01:15 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E46719B3
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 09:00:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so70381705e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688572841; x=1691164841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy7YTz7mkVbodaWV3g7DCdt5cjBQckNjqdd3qDsHsI0=;
        b=MinSECeyWccuUwokEEcqyKWUkdi9kPBNsn1ex5xK/EXYt8tYe+GgMzy/bfPWFT1WG6
         MmtZc43UIOuKGC6a/8NlhrYMFWhb4JlCG7/BTX8e5C0TbDkR7p3JBh+4YzzW3JopCO6F
         P2g3O1RYxpiQ6Bz8W7pwaculR5IE2LRZUJjyEgqtfMctmOiBjVW0xePCc4wkCW/ahbbq
         tddfGXOOjrqR1D54msi2dq63vMtc/kGpdRvxLFNTJ7GFOPr2T20qpOaM76CdeoMDuoht
         UZDJA1T9BqglAwOwirK4J+cRqbOMjZqzaIXHxnTXqPlDrt5POetya75S1T3hacVYFG9c
         I49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572841; x=1691164841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy7YTz7mkVbodaWV3g7DCdt5cjBQckNjqdd3qDsHsI0=;
        b=Hf65V5AV1agUwjeZYwaAANTzud2Jd4coCI4NpmEip5E5OqEn4JVP0JpC9FEpbzuoAS
         SsgVSiwuAl5GE6BBqIUlqnvYE604iEF8M4aclgQXZgEx9DCY2xG3waAF1BJr8kMLFJOG
         8HlcVysnS0ZhOHDF6MhVs8s60MUZdMAlT7wEpvL2b5h3PQ4iNcnfMm8NjjqT53YgJVgB
         P2GUSOEmqLIPjYq54E+8COsn4afgek0Liq22hx9zNWm3VBuW8p/bji82bgmzmscsVWwT
         egefQM93oVIeWEdTNdyMxTW+eGZ8LyUQzH25EqcQL9o9Xox9RDKuQiu6JYaKSnBUo84q
         UEVQ==
X-Gm-Message-State: AC+VfDyk1OAeCd/Wxm0JhpIuDkuggLytsev7wSTVFXY7scld2RppvgVG
	+DXeWKliD1f1VGe85/LwR2+t8Q==
X-Google-Smtp-Source: ACHHUZ40Ik4JBk6ikYG2iHz1zvguiQhUMxYAEVSZkjJMINDznV8vFNBtpOAoJSVB+zWC0YVLyZrRig==
X-Received: by 2002:a05:600c:210e:b0:3fa:9924:1241 with SMTP id u14-20020a05600c210e00b003fa99241241mr15280876wml.4.1688572840513;
        Wed, 05 Jul 2023 09:00:40 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16861950wrn.108.2023.07.05.09.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:00:40 -0700 (PDT)
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
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 2/6] bpf: add a new kfunc to return current bpf_map elements count
Date: Wed,  5 Jul 2023 16:01:35 +0000
Message-Id: <20230705160139.19967-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705160139.19967-1-aspsk@isovalent.com>
References: <20230705160139.19967-1-aspsk@isovalent.com>
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


