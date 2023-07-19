Return-Path: <bpf+bounces-5267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F13B75919D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FA41C20E19
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9B125BE;
	Wed, 19 Jul 2023 09:28:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F1111BB
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:28:45 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5CE10D4
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so7012713f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689758922; x=1692350922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ox7+dO2lf7lgMqaaTMVSFAPK5+oYnmrVK+bXEJp/W0=;
        b=Y2Mpy8bAABv4S46y7WZ90sd+XQqYerSsyNFK/fOu5v+1aFTrKSRh157qWeb2fcZFET
         3ujI6G+AWSuXWleaTkj6PW77kImZOuxsWPr7WNqnFQavys+x/jC3mNS/2wvq9oPGpcjL
         ImbPB9uXkyRaLUm0kcv4RFO36Acn2QJwhaJmqA8PJ+uv0+RTDSkazJVLRUrl23PZ+/02
         ecJIYrKOIHzmWw/jlH1nyYB2JcUFO5WCC8ouKj2wH6g0rs+5gwlOnFDOHLnsr5xhP8dH
         JWHA4RLKDXHv9KafdYTVQB5yC3/jsIRiF6R1i/Ru/iOcG4Jkc1WDhl6Fh44r47q1KG9R
         5JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758922; x=1692350922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ox7+dO2lf7lgMqaaTMVSFAPK5+oYnmrVK+bXEJp/W0=;
        b=JTgcxSsx8Hc9tkRTMZllGgsAGguEuofTVFdIQ8uh7r+g1kuQcIz/Vr/jV90mH0J/44
         4rZlq9zrkowQRhJLSZ2gRxZ+WUe9ixORpjeF9hDyNk1SPYKdmDLWYyOzVIa1woB7MxG3
         J/+zZfLNcmipEHyV/BGBeFBVKSLaR1nXQCqIDfmYjsE2SN6q3tnXxrVc6GLpYy/FUqXJ
         0VIhpnPRrCjoShmm9H86bgyZ+Ga7jjpIWUwUqouhIZ2R+kpor5eVYeGrr0TInN0aW9Il
         Usw4DhLZ37ddvhaxJjhCZDwiOH8M3i2qftO/GvQ0Qh0ha6qpPAzBdrvJsq/5U0H2hwqs
         gyIQ==
X-Gm-Message-State: ABy/qLbugs7KU9rpUvm6FvYLibST3HPly9Hj2eAlyoiI4Bit6+KYZHDG
	5DnTyzxljKNa2ChG1VUIzfiF1w==
X-Google-Smtp-Source: APBJJlFFjbihNqB2C1H/22PKc4G/vqLpNf4xB0qRfHVT9SwRQy1zNL5ufYtH9malvGJfo8NCXO/WNA==
X-Received: by 2002:a05:6000:18d:b0:314:4ba7:b024 with SMTP id p13-20020a056000018d00b003144ba7b024mr16716585wrx.9.1689758922063;
        Wed, 19 Jul 2023 02:28:42 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id r18-20020adff112000000b0031435c2600esm4857213wro.79.2023.07.19.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:28:41 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/4] bpf: consider CONST_PTR_TO_MAP as trusted pointer to struct bpf_map
Date: Wed, 19 Jul 2023 09:29:50 +0000
Message-Id: <20230719092952.41202-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719092952.41202-1-aspsk@isovalent.com>
References: <20230719092952.41202-1-aspsk@isovalent.com>
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

Add the BTF id of struct bpf_map to the reg2btf_ids array. This makes the
values of the CONST_PTR_TO_MAP type to be considered as trusted by kfuncs.
This, in turn, allows users to execute trusted kfuncs which accept `struct
bpf_map *` arguments from non-tracing programs.

While exporting the btf_bpf_map_id variable, save some bytes by defining
it as BTF_ID_LIST_GLOBAL_SINGLE (which is u32[1]) and not as BTF_ID_LIST
(which is u32[64]).

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/btf_ids.h | 1 +
 kernel/bpf/map_iter.c   | 3 +--
 kernel/bpf/verifier.c   | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

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
index 05123feab378..803b91135ca0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5419,6 +5419,7 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
 #endif
+	[CONST_PTR_TO_MAP] = btf_bpf_map_id,
 };
 
 static bool is_trusted_reg(const struct bpf_reg_state *reg)
-- 
2.34.1


