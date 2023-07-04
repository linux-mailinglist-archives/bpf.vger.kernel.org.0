Return-Path: <bpf+bounces-3947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A7746C76
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E279280E2A
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6D74695;
	Tue,  4 Jul 2023 08:55:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1291468B
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 08:55:39 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCCC136;
	Tue,  4 Jul 2023 01:55:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-666eec46206so4374563b3a.3;
        Tue, 04 Jul 2023 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688460937; x=1691052937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qaOalho3nqRwTHuUgTDLzMxibsA/eLeaCFoxfQgxC3g=;
        b=Lf8Z0jR9X+Mp/jKqeetxppnVfQtNHdOZ9ErjuTJQ8jvNfPwWsgHViNqq4SpVghiAIn
         PxjnNr43TbIU3qwrjPi03ww8KUe7HRan68O4qX4YI8sMI81bom61e+F5JDE2ptQrAbCV
         6vdFhsUj28XXBp5JIP5Qxgbw3r95MkZFtZgIRyx2/Y8yMwls8Etixib7w7aGRlUkMyRU
         /Fw1WIoxdJH+HbKh4g6AFwNxawG/d13BmrSHCyMwoiTsPd4DelegI8MXkdZMPLZcAjkP
         Bo2JWkQBVmhXSDDEWOtoUMTGXnljk5yQ+iCuLvZTJkbnPxswz+BrvSbXvBfjbnMa8irM
         GlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688460937; x=1691052937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaOalho3nqRwTHuUgTDLzMxibsA/eLeaCFoxfQgxC3g=;
        b=daRafbJGoYte71r7e9ecWrfiZ/ViHVtmZMWVH+U8oNFPMN1yQzIV1px3WYsdWmEr9Z
         2trxnY2hswwovWLpqSQB8JYRu0msQ214saJ+EoKWu6KjyK71wUV7qsd8C3cNGdld8Ty/
         p3RxOmfXnqiRt65eBugbF6xmnd+xGFsuhLhF/XFZFn38FyQ1dT5EMvsrCf8lmXmR7k85
         6Hdmzsacki081ui9iLPQHIluLuiaBW7MxnT3K+VQ2Q3AAS6L0XgmtOp18pKyG5O3/GNc
         1p/AKryALTuw4GcBkWZmTuvY/EN9T/wIacHPgWrg9l6/ywHibM8ogU56fYyPmPDvh4Eg
         +Hqw==
X-Gm-Message-State: AC+VfDyHcH86TXx4wh1GQovGPi+VYOSn+u3tOAOhKFIRf+GYAcEq3vt7
	ybnYzEelsqI0wtp3mVbx/ac=
X-Google-Smtp-Source: ACHHUZ4S70dsmZu1O+752LEEMqHpgjwxNkRfPkOI+GALKcmWQmEo9altAEg7roJBXXQa7RVdTpZukQ==
X-Received: by 2002:a05:6a20:3c92:b0:12c:6268:cd31 with SMTP id b18-20020a056a203c9200b0012c6268cd31mr17011918pzj.47.1688460937461;
        Tue, 04 Jul 2023 01:55:37 -0700 (PDT)
Received: from localhost ([2409:8a3c:3609:db21:fbac:2cf0:59be:e1b8])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0066ebaeb149dsm14443282pfb.88.2023.07.04.01.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 01:55:37 -0700 (PDT)
From: John Sanpe <sanpeqf@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] libbpf: fix some typo of hashmap init
Date: Tue,  4 Jul 2023 16:54:29 +0800
Message-Id: <20230704085429.3110340-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.40.1
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

rename macro parameters to prevent replacing struct members of hashmap

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 tools/lib/bpf/hashmap.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 0a5bf1937a7c..bae3feaf29d0 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -80,14 +80,14 @@ struct hashmap {
 	size_t sz;
 };
 
-#define HASHMAP_INIT(hash_fn, equal_fn, ctx) {	\
-	.hash_fn = (hash_fn),			\
-	.equal_fn = (equal_fn),			\
-	.ctx = (ctx),				\
-	.buckets = NULL,			\
-	.cap = 0,				\
-	.cap_bits = 0,				\
-	.sz = 0,				\
+#define HASHMAP_INIT(_hash_fn, _equal_fn, _ctx) {	\
+	.hash_fn = (_hash_fn),				\
+	.equal_fn = (_equal_fn),			\
+	.ctx = (_ctx),					\
+	.buckets = NULL,				\
+	.cap = 0,					\
+	.cap_bits = 0,					\
+	.sz = 0,					\
 }
 
 void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
-- 
2.40.1


