Return-Path: <bpf+bounces-5030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F901753D23
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CE61C21017
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662A813AD2;
	Fri, 14 Jul 2023 14:20:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C722E551
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 14:20:12 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2817035A2
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:19:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992acf67388so246069066b.1
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689344397; x=1691936397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qk8T3EVPKdRYf+naU4m+YVtLzpGUKvj2gEOLRZFi7k=;
        b=fZmmnLinrKMYrKhEK0Ja70FkcaLdJD7wwVXadLH0V3hRFzduwn6n00RysF14lvageo
         JsAppEggMr42ZWN1aLrpKNzo2qv5GGcBc/1Y/Bp9px2acb1JlEkaYeBmKIbg1OH0tCU3
         nECSVyAnpJZ+Ckza0WyWUMs9e7sQ4oz/c7ccFxMH+P1oM85hBV9vtxQGuvFE6kD5lYwf
         LzO0QciKwgQiKxGjFF2BIeujLoqdIgYuF5SU0iXUABihsf7b8YonSsL7LI1mgQ9XEaGq
         ZAYTaYQ0qsTJILqkKDA7KIw0ZURDZWhHWAqveJQMjOJbqQDsRC0q55gW+99LAHgoFVQD
         rg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344397; x=1691936397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qk8T3EVPKdRYf+naU4m+YVtLzpGUKvj2gEOLRZFi7k=;
        b=VXxYju5rvTW4/lEA5lYBu18v+ENgkI4UXBvU0aRiOT5Q1djLAVkNwihbzVq4C+vQ71
         Tn2vXuux07X3v66mthazgh6XGh8C/8uft4DDk+VmZyyLovo9OxBPFfabiYGqQHnkFLKl
         2/d5zhccFv9m6CGUkcCxuwsAEUCHrKWArx//KJw/JgDj4RrYX3NrlAfRYSPR+iFqyw8f
         frQcZjnaIWfLnn7VtcqdLkNq/B9mYFJBbid9X9PGThZV1+l5CKEssoHZMb4YTbiH/kGO
         nO4tNvkK8thO2dZgmQX/0cy8li1GW40QUjr1ZjVSachU8Qf3XCL/44PUblnwO5xeXvjN
         hWwQ==
X-Gm-Message-State: ABy/qLYu3s07kwi05Go3q0G5fNuYmH8QhQDBuHXJthtazEWsXunAqZ9p
	Jqkn/xRTx+MK5FidPqKMR6tUEw==
X-Google-Smtp-Source: APBJJlE3dUHsS60CUNmtFflD35N+5SzU2TRu3lWZvljtOkzKkJCtJygfCLn+Ia0YaPigbhKdj9mlEQ==
X-Received: by 2002:a17:906:9146:b0:989:450:e585 with SMTP id y6-20020a170906914600b009890450e585mr3728345ejw.45.1689344397549;
        Fri, 14 Jul 2023 07:19:57 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709061d0b00b00982cfe1fe5dsm5469294ejh.65.2023.07.14.07.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:19:57 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Joe Stringer <joe@isovalent.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf: consider CONST_PTR_TO_MAP as trusted pointer to struct bpf_map
Date: Fri, 14 Jul 2023 14:20:58 +0000
Message-Id: <20230714142100.42265-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714142100.42265-1-aspsk@isovalent.com>
References: <20230714141747.41560-1-aspsk@isovalent.com>
 <20230714142100.42265-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch verifier to regard values of type CONST_PTR_TO_MAP as trusted
pointers to struct bpf_map. This allows kfuncs to work with `struct
bpf_map *` arguments.

Save some bytes by defining btf_bpf_map_id as BTF_ID_LIST_GLOBAL_SINGLE
(which is u32[1]), not as BTF_ID_LIST (which is u32[64]).

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/btf_ids.h | 1 +
 kernel/bpf/map_iter.c   | 3 +--
 kernel/bpf/verifier.c   | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 00950cc03bff..a3462a9b8e18 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -267,5 +267,6 @@ MAX_BTF_TRACING_TYPE,
 extern u32 btf_tracing_ids[];
 extern u32 bpf_cgroup_btf_id[];
 extern u32 bpf_local_storage_map_btf_id[];
+extern u32 btf_bpf_map_id[];
 
 #endif
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index d06d3b7150e5..b67996147895 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -78,8 +78,7 @@ static const struct seq_operations bpf_map_seq_ops = {
 	.show	= bpf_map_seq_show,
 };
 
-BTF_ID_LIST(btf_bpf_map_id)
-BTF_ID(struct, bpf_map)
+BTF_ID_LIST_GLOBAL_SINGLE(btf_bpf_map_id, struct, bpf_map)
 
 static const struct bpf_iter_seq_info bpf_map_seq_info = {
 	.seq_ops		= &bpf_map_seq_ops,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b9da95331d7..5663f97ef292 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5419,6 +5419,9 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg)
 	if (reg->ref_obj_id)
 		return true;
 
+	if (reg->type == CONST_PTR_TO_MAP)
+		return true;
+
 	/* If a register is not referenced, it is trusted if it has the
 	 * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
 	 * other type modifiers may be safe, but we elect to take an opt-in
@@ -10052,13 +10055,13 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 	return true;
 }
 
-
 static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #ifdef CONFIG_NET
 	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
 	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
 #endif
+	[CONST_PTR_TO_MAP] = btf_bpf_map_id,
 };
 
 enum kfunc_ptr_arg_type {
-- 
2.34.1


