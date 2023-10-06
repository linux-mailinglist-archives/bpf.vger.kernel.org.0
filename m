Return-Path: <bpf+bounces-11567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39D7BC020
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D132820B4
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0C436A5;
	Fri,  6 Oct 2023 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="glIQtzsV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD941E38
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 20:17:09 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109ABF
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 13:17:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6907e44665bso2232833b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623423; x=1697228223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYgd9NJoGeVd+4g2HyXZYAbiV1zNgq5LXMke4LgVM60=;
        b=glIQtzsVltLJbPBFndOe3pOHcLeCDAEaLQ22HcKgV7jpj++ELRZ/kKVwxirUVEiOTG
         XzsD49z7sXHoG6Dy3IQLvFSdAgQ7FpKTlvC6aIwAfsIJUrFsOVz7EXZcExrW0GapI4j0
         ln04IfZjypBCNGI6nwYayqP8K/oW387tby1h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623423; x=1697228223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYgd9NJoGeVd+4g2HyXZYAbiV1zNgq5LXMke4LgVM60=;
        b=tR/J4w6lRKid8cNTtRNN7IriNkVO3zkjg25Q6+gPQHb7fNEDftk+QyFyq0KxEpL1PF
         ZpRX87nip5AX4W43kddu8YdPZlTMGhw+rU8pWa1bOe7qOcqXU+e+whc+kWxmyggyk+za
         25WcYjYlmacBo8jvH69M+8DBRYgHqle8O+UBmrHg/yDst/67NNdt+TglXI8W3BDjK8Eo
         VFa/cPLnkEdvr4NfWA2GvunIQUS1Qq8p+nUrQREeGYO5qTTwqK+I/UON907CvWdzlmMf
         q9MNyOff073Uce8OXMo+FbzQ20nPuSa8mhntrIpZIBwiJMv1uDzuk9mhjSivhMHsBqVk
         9QXg==
X-Gm-Message-State: AOJu0YzqD42OMtjax3UwHJmz/jCd6SVjrBV89Sr6w8DG5+dPdYr5BFO5
	WIpJQpo8GLmAKSzKAWv1omQVww==
X-Google-Smtp-Source: AGHT+IHNx7VkfRUNypD93pqsPmMMdOU2NO3A55MZeXkGPOgFGJWdkVlpQzoHs03ZJTKJS6nWutO5pQ==
X-Received: by 2002:a05:6a20:324d:b0:14d:7511:1c2 with SMTP id hm13-20020a056a20324d00b0014d751101c2mr8303161pzc.55.1696623423132;
        Fri, 06 Oct 2023 13:17:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b0064f76992905sm1879945pfn.202.2023.10.06.13.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:02 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Song Liu <song@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] bpf: Annotate struct bpf_stack_map with __counted_by
Date: Fri,  6 Oct 2023 13:17:00 -0700
Message-Id: <20231006201657.work.531-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Cn0rZ3uKUzlAqWZVBxaI1s9wb/BhJmGzsMuyAyrT7Jg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGs8PUE7GHQQH9B2FtvPO9v/D7n9b+rl68H2W
 RKqjf8h0JKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrPAAKCRCJcvTf3G3A
 JtaTEACURo4jMkXwmgS7m4ShxZQ4TwAfA6ZzmjYsh6vYRU9jgLzxlVmFZGarKW2zf9Cv86qoTQB
 OuLpPhBaNyLhx6zEvR7V9tnxUwEkqNowljuks8/uiTM7dKUMCX8mPrr0W8i7NY3rag314m42553
 4Qg7E6CGkIv9FjnVwEy+WwyO4gtQ9T6LSBaDiqznryLw4DMRHSPX5FY1RreXN0hu2KlSN6NE/95
 6y+nhBnSpe5AG0WcCaKwduCSLQAYDwu5gSLTQC8ufTlI+8wLVB9RxmJVplQ6ifVtmjwG0mal2Q9
 g4CWK58aEl82E6jwl1ibHfcGfj1BOPSrjGWgcVRQGS4Oz95mMtS36TUv3GF/NGMEYbeVMSAOYF/
 dZ+ZDcDelDkkrftFCQ0GblqS/FPjlacGmdkA99CUVIKR0c9Dwzz2pJCPVrLvu/vVGqSoU2DKd2O
 S/u5edTIQKXF+6S74bRXmCTvYDFgRzeDFVbxJ/gKxodnhRJZOwKgzpFeqz2h5A2DjvMkysoTOLr
 QgNDS9ZfejJ6ptqnkCoFaLOYYEdwTTjLQ/2vQ0ruMLTLZWT6fYMQYrP/Cd9bfrPxcuNg6YA1iqv
 5A2La5ev+YTxG4cMliYTclB/18XZ5/C74z+hmZYBC6SCICu7BofIrV+WBsrWOqzu+iMD2dRwPe0
 DtdkIXf jUFo8IGQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct bpf_stack_map.

Cc: Song Liu <song@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/bpf/stackmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 458bb80b14d5..d6b277482085 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -28,7 +28,7 @@ struct bpf_stack_map {
 	void *elems;
 	struct pcpu_freelist freelist;
 	u32 n_buckets;
-	struct stack_map_bucket *buckets[];
+	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
 };
 
 static inline bool stack_map_use_build_id(struct bpf_map *map)
-- 
2.34.1


