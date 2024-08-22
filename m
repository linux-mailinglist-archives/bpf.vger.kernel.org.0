Return-Path: <bpf+bounces-37829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2558595AFD0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C981F24DC0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D5E16B75C;
	Thu, 22 Aug 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaKYOr4G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946391D12EA
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313703; cv=none; b=L4OnuGx49pju7PUNU5RFT9yD0pIL2Rz43xSxQz5oqn1nnBYCEW0uoNjwQYCK6hLwF2GHnwP7866l1vxYYemaDo1bolQENw7SDC31zlq2998ETmNoXnycURMXBC4po0RoD65/Efw6ecHATZo/J/kiy7O4XcAW8svhLej0FbXPajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313703; c=relaxed/simple;
	bh=V5aOnTr78I0jU8MhQ86zT0M/kiulXrllO7BScSGB4ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7qIaIKOsDvFm0ylkWY/RMr7BvwONIo+wG6oa9ONfhwMe38S0ZmksRMouhuX+CqL48r76/X0jvqss8rkSTy8n9IZiyNHWRNFMI6tmW2yab+KPZGYi2IuqVi0lFp+ysS0f81TNqmVCqvDIz9PjZC8G4LTgv6hzv5OsX5F/ceds8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaKYOr4G; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2020b730049so4528865ad.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724313701; x=1724918501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAITIfs/42/uJpsE+wuS1AtoXo5+sJEHyyQdwWrjb98=;
        b=GaKYOr4GWTZbwJBV0AvCjU6J4AOxmnpeFzkM2cT1XJHmerAP5110ZkqnXzVbxr5hYJ
         v2uMe+mlSuVjPce2rSZF2RIio7iOSTJsh19cFAViUiJ5HdoRvdhW4vvOXdjM4EJ8kqRR
         zsVseDlojdCUcfWYSoaNMBVetoBTHWQLJzb5J7bvoQJ0iCn3d+1lmRdytoDlkqqfdWVo
         53+gBKxcQl6WKJCYFp2Gsj+yIioOlYEJVlT9388rSqQrY9+W/PMcWZSXM+GFXQhod3p1
         4Pi9ROXsyWD365S0RNEMyfwfT6mC4nTQcBzsYVxrARwQAUqOCkS0WclukhV2AzT+1/RK
         C7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724313701; x=1724918501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAITIfs/42/uJpsE+wuS1AtoXo5+sJEHyyQdwWrjb98=;
        b=bcJu6V+uEI1p92wpQTJ4UUuyyGJerlfrZHvg9/uC0U57dZMFvQvy96VuTZ6Q/mYBnh
         0M6dsp/tfLrPKeiuS5YEzv+ZHEafUB4HQLCoS5AqiqIKenJqhdvQJQwh+i4xjsWImU5R
         WeWYGnLyk9GMvnGVaBt26NsbaOlsONCY+7f45oNgPJypXsVnPYON8TMtmFqYg77hCbRY
         gIi1J/wG33NnDsseDAfCShm9pA1iYdG/uJo6sclaLQNz9UQqCHNlAGpf4dvRjN8s1oik
         8xh7ehvPqlWqX8XQtmOBKi2y7nhFfB05FCWZYURVHqDJKhNq+hEbSDGm07CvnadNc9ej
         PN8w==
X-Gm-Message-State: AOJu0Yx5db4Ot+y+qVI9QV1DHr4pN4VOKQjpqbITqbKpmNr/kLpNO9qo
	sq9Cq5fj6nMqBJRcO/7AHmJOjm8yax3SiHgQhpAa69Gwo+Ln7eW1ODd3JU7D
X-Google-Smtp-Source: AGHT+IGQyfvtUkw7KzCiRTgduS44J6pU1O+j740KFb8wd0JSMiCRILqHTh78ToCHNbHaIWBR7tQC0A==
X-Received: by 2002:a17:902:e549:b0:202:2b3c:9ae1 with SMTP id d9443c01a7336-2038890d5demr11465765ad.39.1724313700479;
        Thu, 22 Aug 2024 01:01:40 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f093sm7233445ad.63.2024.08.22.01.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:01:40 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	cnitlrt@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos
Date: Thu, 22 Aug 2024 01:01:23 -0700
Message-ID: <20240822080124.2995724-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822080124.2995724-1-eddyz87@gmail.com>
References: <20240822080124.2995724-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of malformed relocation record of kind BPF_CORE_TYPE_ID_LOCAL
referencing a non-existing BTF type, function bpf_core_calc_relo_insn
would cause a null pointer deference.

Fix this by adding a proper check upper in call stack, as malformed
relocation records could be passed from user space.

Simplest reproducer is a program:

    r0 = 0
    exit

With a single relocation record:

    .insn_off = 0,          /* patch first instruction */
    .type_id = 100500,      /* this type id does not exist */
    .access_str_off = 6,    /* offset of string "0" */
    .kind = BPF_CORE_TYPE_ID_LOCAL,

See the link for original reproducer or next commit for a test case.

Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_type_by_id().")
Reported-by: Liu RuiTong <cnitlrt@gmail.com>
Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com/
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c9338fb397fc..5de424d3a795 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8910,6 +8910,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	struct bpf_core_cand_list cands = {};
 	struct bpf_core_relo_res targ_res;
 	struct bpf_core_spec *specs;
+	const struct btf_type *type;
 	int err;
 
 	/* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
@@ -8919,6 +8920,13 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	if (!specs)
 		return -ENOMEM;
 
+	type = btf_type_by_id(ctx->btf, relo->type_id);
+	if (!type) {
+		bpf_log(ctx->log, "relo #%u: bad type id %u\n",
+			relo_idx, relo->type_id);
+		return -EINVAL;
+	}
+
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
 		int i;
-- 
2.45.2


