Return-Path: <bpf+bounces-3762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE952743702
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206B11C20952
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67040F9DE;
	Fri, 30 Jun 2023 08:24:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441F6E55E
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:24:23 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57E01FCD
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso2589438e87.0
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688113459; x=1690705459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy7YTz7mkVbodaWV3g7DCdt5cjBQckNjqdd3qDsHsI0=;
        b=h1piDnr/G9t7TA1cZEW2vS/QZhtjJFzjkt81YVhfoAVJJrme2pk2PF9bTb1cmSxmAZ
         MkyNegWQcsmdg0VD2hwE227W3DyLykFuIvpDu2W+tVEfJ3NybEBlDHVmay1+rHPZVOKp
         ydF/Z3YewuUSJUC395IktVCaQXp0zhmvCd7hI2GW2OAOaNypRij5uq9ZP+spEqz2dqms
         UaIwYq+727yoX37yaOWqLlP2vneuIakyYG+sBoHuvRQe9jrQGyc+nEbKSkk3lwIGHc1F
         FDKdICZTiNejbGwrXBgq1CsFIEa7UdjhIkwuU3RqE7mGaoQagZnx2P1pIj7nB/++Ig45
         aiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113459; x=1690705459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy7YTz7mkVbodaWV3g7DCdt5cjBQckNjqdd3qDsHsI0=;
        b=S0U05479M43iz6SoNEF7wFxOdi49LEdQCurXgbFlG6OaUFlao1ae9D3zOc+7XP4NwN
         KMflATd0GcDEyIPsm6eQffMmfCtCL7HYnOPfssYEhiGwg3+6+7bWvuGRgYBDTFRjUZmv
         AkY4AmpzqCKlEvHWx8gShgMv2hM9Ady/l+BbsJBpOJjhKVBAqTYqQBNbx3gwDw8uLDXX
         YuPNW+B8OhqtR7mmqRiogOrgXT5fsnlNO1eHMmrMz5Zb2mmF1ChXw8uoCoW6sR+8bpaG
         bge2KU5KmFhqwRlupjibwN37a/993JmbFOpqjV5+iB1VV0p6tft21/3qXFQ2D33PZ1Vh
         PsmA==
X-Gm-Message-State: ABy/qLbl/Raqisj34nj62aq38kNEwujnvJnv1MnhYML5pcfnWR8A9Vqr
	pweqXMAaUfVzBkLurTtZ0jgcE0+fpwlU9QiHWQW80g==
X-Google-Smtp-Source: APBJJlEwmbkKAm2i7YdTejL13C9Ds4HV9DgRoAh33vQdKCHt91KXGsE1uL2kxE831TtxBdfX4ZcK6w==
X-Received: by 2002:a05:6512:3192:b0:4f4:cebe:a7aa with SMTP id i18-20020a056512319200b004f4cebea7aamr1672323lfe.39.1688113458736;
        Fri, 30 Jun 2023 01:24:18 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm18189941wmb.26.2023.06.30.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:24:18 -0700 (PDT)
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
Subject: [v3 PATCH bpf-next 2/6] bpf: add a new kfunc to return current bpf_map elements count
Date: Fri, 30 Jun 2023 08:25:12 +0000
Message-Id: <20230630082516.16286-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630082516.16286-1-aspsk@isovalent.com>
References: <20230630082516.16286-1-aspsk@isovalent.com>
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


