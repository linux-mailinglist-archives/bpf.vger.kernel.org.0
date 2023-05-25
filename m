Return-Path: <bpf+bounces-1199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB577101EC
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 02:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00761C20D8F
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 00:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201B1C02;
	Thu, 25 May 2023 00:13:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733218E
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 00:13:33 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10AB3
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 17:13:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53474b0c494so842757a12.3
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 17:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684973612; x=1687565612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5E4vRfBNz/13m8k16DYn3/KmOzBbeXrs05rXf1mSAxg=;
        b=XgHJpx4cekyqITk3oj2gK9MM6BfvhaUzUgA2LL+XQsmzLafXB/OihSR/PX/ORjB9Kj
         juPdzTsiwDanWiSwxylmi0PD94b4seEnPvOU60XZquYONzNu36RgAAdQ4K4mClGdtpyZ
         qcyQltXeo0XJxPU/wUdf942uh/F16qcJfYeJOgB/kxHX2yuFr1tEWzWJx4FbcXAXBtQ4
         F3scBEvXXi3FpXxK31wRn9LlID1ylD4hrG7BJ+20j4P1CCcQs0QSGgN7noCLzSw5K73/
         ESY8Myl8q49tDv7NzuHyTrbvOHaCgrYit9m+f5UzFCKxB/01wJHxuV9bXiVE/5C2fQgT
         0jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684973612; x=1687565612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5E4vRfBNz/13m8k16DYn3/KmOzBbeXrs05rXf1mSAxg=;
        b=IGZxIjIHV0IUe9o+Gf1YQ+NTJzyZEFZJ/nFlhKjX0ZcyQxaoMwzJkzeE5rGLpJQGXT
         QM4Ds+sBdDdBFb+nxnaLPd3jB9LSHN5aMgS4DbWqRUOQdXqXlvUara729B5Wys1pNjfo
         y2XclWASoNutb81dKq7zNiU6SOsS/OaQOIYHqHf9uKTj5mKNaAbU1gRMflh6cxVmxxUo
         tFRXQhekGyCh1MZElaP74MoHubKWyR6ATQHW3wVTn7i5InnonqDpha94/dwkjYNsmmCD
         C0OLXNjUgDbM6O+oWsM1wLuGTxUFPjkWpaN5nfbuMUtaBQHeMEdXOBKiO+dedi+V7miu
         QEhA==
X-Gm-Message-State: AC+VfDzkPrHVMmznEA9nyGxg3Sf1ahLFZ0kc+KFVDxzVnrgmIpJ2UNZj
	m2ZdbwyUljC64JVtZXuLDu+MHVGAcxY=
X-Google-Smtp-Source: ACHHUZ4mZnkapLk8uWAWg3dOJJ4AbhcQaye8WzdL2hXQClafFTXCq3ZKeqSVDJuRYtbSYKkvVGhZHw==
X-Received: by 2002:a17:902:c944:b0:1ae:66cf:b90f with SMTP id i4-20020a170902c94400b001ae66cfb90fmr22296983pla.66.1684973611668;
        Wed, 24 May 2023 17:13:31 -0700 (PDT)
Received: from toolbox.. ([98.42.24.125])
        by smtp.gmail.com with ESMTPSA id n19-20020a170902969300b001a527761c31sm48200plp.79.2023.05.24.17.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 17:13:31 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org
Cc: inwardvessel@gmail.com
Subject: [PATCH bpf-next] libbpf: change var type in datasec resize func
Date: Wed, 24 May 2023 17:13:23 -0700
Message-Id: <20230525001323.8554-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
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

This changes a local variable type that stores a new array id to match
the return type of btf__add_array().

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5cca00979aae..1ceb3a97dadc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9444,8 +9444,8 @@ static int map_btf_datasec_resize(struct bpf_map *map, __u32 size)
 	struct btf_var_secinfo *var;
 	const struct btf_type *array_type;
 	const struct btf_array *array;
-	int vlen, element_sz;
-	__u32 nr_elements, new_array_id;
+	int vlen, element_sz, new_array_id;
+	__u32 nr_elements;
 
 	/* check btf existence */
 	btf = bpf_object__btf(map->obj);
-- 
2.40.0


