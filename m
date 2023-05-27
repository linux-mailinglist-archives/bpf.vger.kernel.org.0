Return-Path: <bpf+bounces-1352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C827134AF
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 14:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E560428182D
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0400611C9A;
	Sat, 27 May 2023 12:27:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8372D52C
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 12:27:14 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510ACF3;
	Sat, 27 May 2023 05:27:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2564dc37c3eso214338a91.0;
        Sat, 27 May 2023 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685190433; x=1687782433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VL5PuRes+RVCKdqZxW7v51sOkxve4QAPNm6Ttixc5s=;
        b=Qh9kmF+GG6oZ9k/HBmLUW9NrdVhMPF6z2Ixu7aT4M98mSmUHXLNoslPmrcnSZu7y5M
         6lw/nyO7E0GdD2glPtE6zy1+SxAA4DwwTFn4m1ZUsqPfhUZkZPOmmtG7NKbJ8c9u/Q92
         /hahinmbZBMWJwdgp6xa2JuuljfGnkHLong1zEHA/xlO83yx/MPTm2ekYXsMuKmLpiX9
         5i18zJQpjpPT0dU5Tu6y4SlpDHlICK/gabEv4i/7A9P55DAoaW879f6H4dzlaI9MhR0u
         uvLAIpce+VK7PBX0r54gdQ56/zzUT2TBj7KyIxkug85umq2YO/HQcG2+wyV5X0Q05Qfk
         zrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685190433; x=1687782433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VL5PuRes+RVCKdqZxW7v51sOkxve4QAPNm6Ttixc5s=;
        b=MffSsjsxLE/jCfONMWbvKKw47/HheeU2avPVRq/i14RvMaxR4AWnKK+YOojoFIpoai
         fYx//ieBR7gEQMHky4BSNNmPgEBJyyvGtk1dW8xHp47AsJL6ZIQN3LsYgzCehuCf1Ar4
         rezDTMSgn3I3K30PzfGReeXkOe9RYxb54nfv7smrBTifU1Zxof5lUS32LSb6Pb1UFY8k
         yklmqa9IH5PPVMTg5e0W6FTa0xtapRRt9ymtkJrf8tgBRBvaPqHR9LSkQzacMK4ELnP0
         DOZ8Q7oj+IAinfzqQ50uM9L10S/7fARPiYVGRAFx8hV+E0Jmf5XvTZdgBwlE3nRVgvWh
         9I0A==
X-Gm-Message-State: AC+VfDz2OhC6JFG11ehwe4Ld5JtcEBHrJcC1neUTm4tE/ukOeDhbILG1
	jtXuaQ/ZTc/0PdWh3jQG4g==
X-Google-Smtp-Source: ACHHUZ71gNc4koAU5A8gsl1WCb1bDvfFBOSXd9pmjKWQ1FUHbaJZSJ34Mi5d8AJjVHRw0AZ3gpQLMg==
X-Received: by 2002:a17:902:74c1:b0:1ac:85b0:1bd8 with SMTP id f1-20020a17090274c100b001ac85b01bd8mr1916521plt.34.1685190432571;
        Sat, 27 May 2023 05:27:12 -0700 (PDT)
Received: from dan.. ([182.209.58.11])
        by smtp.gmail.com with ESMTPSA id jj7-20020a170903048700b001a1d4a985eesm4831328plb.228.2023.05.27.05.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 05:27:12 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: replace open code with for allocated object check
Date: Sat, 27 May 2023 21:27:06 +0900
Message-Id: <20230527122706.59315-1-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From commit 282de143ead9 ("bpf: Introduce allocated objects support"),
With this allocated object with BPF program, (PTR_TO_BTF_ID | MEM_ALLOC)
has been a way of indicating to check the type is the allocated object.

commit d8939cb0a03c ("bpf: Loosen alloc obj test in verifier's
reg_btf_record")
From the commit, there has been helper function for checking this, named
type_is_ptr_alloc_obj(). But still, some of the code use open code to
retrieve this info. This commit replaces the open code with the
type_is_alloc(), and the type_is_ptr_alloc_obj() function.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 086b2a14905b..97c714e8a8bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5891,7 +5891,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 * program allocated objects (which always have ref_obj_id > 0),
 		 * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
 		 */
-		if (atype != BPF_READ && reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+		if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
@@ -7511,7 +7511,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
-	if (meta->func_id == BPF_FUNC_kptr_xchg && type & MEM_ALLOC)
+	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type))
 		type &= ~MEM_ALLOC;
 
 	for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
-- 
2.34.1


