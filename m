Return-Path: <bpf+bounces-3129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8434739DBF
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E670B1C21079
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B638827;
	Thu, 22 Jun 2023 09:52:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE905689
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:52:38 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C010D2
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:52:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51bdca52424so1818035a12.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687427555; x=1690019555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p52l7OM8oBYDKkmG4vQideP9pR+7XINSme2ToMKa+DI=;
        b=hlxLMMYuhXYO15l8xRyb3306FYmj2mKXRw7AWQpJ3+JRIjwhDyJvJK/YdgW8VYlpfE
         0vR90zeO5Hv9T2paknpda4jA/+CB2HfexoJn35YzwG7Tw/EALClvE5cdJmibCTeOC4Ai
         +ObceAVUTPYseNfmIif3XG0m39cauzMlQK1itCytDA3NCjV0YsHPahlLbYzYdomvqF+g
         vhrb4sPglYfcBNH5bkdOStMBRa+bqnIP6aVbddBMt/8a91Z8i9fMVFb+4skMVKr7a5Te
         ykPhC4P1bhvrA8Dh10m5O8MgeGulGDo38ejzv9to8pBtjB2EmWnY7qNzJICad9yHzeMT
         lIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427555; x=1690019555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p52l7OM8oBYDKkmG4vQideP9pR+7XINSme2ToMKa+DI=;
        b=ETezPihfz8Pxy0LW18CMo2n9+guJE/7uokDGL7HWRj5r919mstfUfHxTVOFmqwMG3h
         XMhg5iesQylx5gRNP71KO8ubRqHbE45MRfB8AqcDvs048OhaxUx+4N6Rq6S+cS4TmG+m
         +23EQMSpO1pocAgtoxTjk95Mp3tGSIb8z5mA8/m7S+23OonyevYjj9i0GTdvPH9LsXZI
         6rPAXj+h4ZxDZhcAPeG6J+0bqnsYW6r+1dDOYEGWJWzeekY3uH6MKamMp4qyKAfqqfg4
         NK2IGnQX5S/6Xe9FuESpzeXhhoywBfoi8PU6YF0BpBKPQfsI/NobYZd3ZzrTj3uPlEC5
         icnA==
X-Gm-Message-State: AC+VfDx8f6ThAWWgx8zSyo3IhxfYF6UfxYW04BcGRBxJPN7aZzxfY2bh
	gf1MjUnPW4VJ2/2QCnPRtZzKtQ==
X-Google-Smtp-Source: ACHHUZ62Mscz6lEk2w3SWWDDhGnupntIfuSE+PY0IIlVgJX6L7H+ghsoUYNkMKNrkIn02dM4o1o2qQ==
X-Received: by 2002:a17:907:94d3:b0:98d:2db6:7f19 with SMTP id dn19-20020a17090794d300b0098d2db67f19mr1063949ejc.23.1687427555566;
        Thu, 22 Jun 2023 02:52:35 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090614cc00b0098951bb4dc3sm3387985ejc.184.2023.06.22.02.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:52:35 -0700 (PDT)
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
Subject: [RFC v2 PATCH bpf-next 1/4] bpf: add percpu stats for bpf_map elements insertions/deletions
Date: Thu, 22 Jun 2023 09:53:27 +0000
Message-Id: <20230622095330.1023453-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622095330.1023453-1-aspsk@isovalent.com>
References: <20230622095330.1023453-1-aspsk@isovalent.com>
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

Add a generic percpu stats for bpf_map elements insertions/deletions in order
to keep track of both, the current (approximate) number of elements in a map
and per-cpu statistics on update/delete operations.

To expose these stats a particular map implementation should initialize the
counter and adjust it as needed using the 'bpf_map_*_elements_counter' helpers
provided by this commit. The counter can be read by an iterator program.

A bpf_map_sum_elements_counter kfunc was added to simplify getting the sum of
the per-cpu values. If a map doesn't implement the counter, then it will always
return 0.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h   | 30 +++++++++++++++++++++++++++
 kernel/bpf/map_iter.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..20292a096188 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -275,6 +275,7 @@ struct bpf_map {
 	} owner;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
+	s64 __percpu *elements_count;
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
@@ -2040,6 +2041,35 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 }
 #endif
 
+static inline int
+bpf_map_init_elements_counter(struct bpf_map *map)
+{
+	size_t size = sizeof(*map->elements_count), align = size;
+	gfp_t flags = GFP_USER | __GFP_NOWARN;
+
+	map->elements_count = bpf_map_alloc_percpu(map, size, align, flags);
+	if (!map->elements_count)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void
+bpf_map_free_elements_counter(struct bpf_map *map)
+{
+	free_percpu(map->elements_count);
+}
+
+static inline void bpf_map_inc_elements_counter(struct bpf_map *map)
+{
+	this_cpu_inc(*map->elements_count);
+}
+
+static inline void bpf_map_dec_elements_counter(struct bpf_map *map)
+{
+	this_cpu_dec(*map->elements_count);
+}
+
 extern int sysctl_unprivileged_bpf_disabled;
 
 static inline bool bpf_allow_ptr_leaks(void)
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index b0fa190b0979..26ca00dde962 100644
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
@@ -193,3 +193,49 @@ static int __init bpf_map_iter_init(void)
 }
 
 late_initcall(bpf_map_iter_init);
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc s64 bpf_map_sum_elements_counter(struct bpf_map *map)
+{
+	s64 *pcount;
+	s64 ret = 0;
+	int cpu;
+
+	if (!map || !map->elements_count)
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		pcount = per_cpu_ptr(map->elements_count, cpu);
+		ret += READ_ONCE(*pcount);
+	}
+	return ret;
+}
+
+__diag_pop();
+
+BTF_SET8_START(bpf_map_iter_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_map_sum_elements_counter, KF_TRUSTED_ARGS)
+BTF_SET8_END(bpf_map_iter_kfunc_ids)
+
+static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (btf_id_set8_contains(&bpf_map_iter_kfunc_ids, kfunc_id) &&
+	    prog->expected_attach_type != BPF_TRACE_ITER)
+		return -EACCES;
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_map_iter_kfunc_ids,
+	.filter = tracing_iter_filter,
+};
+
+static int init_subsystem(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_map_iter_kfunc_set);
+}
+late_initcall(init_subsystem);
-- 
2.34.1


