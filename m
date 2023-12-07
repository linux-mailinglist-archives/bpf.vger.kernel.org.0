Return-Path: <bpf+bounces-17042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A8680931D
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB00B20D55
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397455C2F;
	Thu,  7 Dec 2023 21:09:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5A1719;
	Thu,  7 Dec 2023 13:08:57 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b37405f64aso44411539f.2;
        Thu, 07 Dec 2023 13:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983337; x=1702588137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mJOqg3+xAvM9f6KK768X58MK+6lOJSs4ZpbCqNq8kc=;
        b=bOfTXr150LjyXg/4wfdc/W2o6Ie9+NcNwwh6royulFcBM6akVz0kEjm2gukDoFWdJE
         Q76g7l/sYBWIEedjuN6ayeXCMekjr6E/KvvCYzhUoQthfLCWGWsGHolqhhnZnb5/Cuvw
         R13dF1RcIVNIN/pzZD0nsAhJ3Iu90u2ia7OereI8p+abhVQEoLw5dyL/6+QwRMXIT9kw
         Ccp7d5agY9buk4RClVLJSlZitEo+inErmiIINzyw+I52+MOHLwGzoeuEwxG9KVmiX+Ob
         ZtvGXnKAtL8HkkLs9d/jAAWZJQcGkAPzS73or5D+gQVeY5h7QQvpFphmUuxKFkdTyM3T
         btrw==
X-Gm-Message-State: AOJu0YxtkIpsPfFoxapJKogv/G0FeiaM2XWCqYvDgxpx5VgWZMQcX1dE
	ugdUbu8ootfviNgvo82K+/QwTmo2tMUY1LFA
X-Google-Smtp-Source: AGHT+IGkDTH6918Om38gACwKcVpSczHLJTV1sqKE0lavWzE4WWx1VSuKkyGCMaqiUZF5ySLUSXkcfg==
X-Received: by 2002:a6b:f80f:0:b0:7b6:e765:1d17 with SMTP id o15-20020a6bf80f000000b007b6e7651d17mr2661506ioh.40.1701983336753;
        Thu, 07 Dec 2023 13:08:56 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f12-20020a02cacc000000b0042b530d29c3sm119386jap.164.2023.12.07.13.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:08:56 -0800 (PST)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_cpumask_weight() kfunc
Date: Thu,  7 Dec 2023 15:08:42 -0600
Message-ID: <20231207210843.168466-2-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231207210843.168466-1-void@manifault.com>
References: <20231207210843.168466-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can be useful to query how many bits are set in a cpumask. For
example, if you want to perform special logic for the last remaining
core that's set in a mask. Let's therefore add a new
bpf_cpumask_weight() kfunc which checks how many bits are set in a mask.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/cpumasks.rst |  2 +-
 kernel/bpf/cpumask.c           | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.rst
index a22b6ad105fb..b5d47a04da5d 100644
--- a/Documentation/bpf/cpumasks.rst
+++ b/Documentation/bpf/cpumasks.rst
@@ -352,7 +352,7 @@ can be used to query the contents of cpumasks.
 
 .. kernel-doc:: kernel/bpf/cpumask.c
    :identifiers: bpf_cpumask_first bpf_cpumask_first_zero bpf_cpumask_first_and
-                 bpf_cpumask_test_cpu
+                 bpf_cpumask_test_cpu bpf_cpumask_weight
 
 .. kernel-doc:: kernel/bpf/cpumask.c
    :identifiers: bpf_cpumask_equal bpf_cpumask_intersects bpf_cpumask_subset
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index e01c741e54e7..7499b7d8c06f 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -405,6 +405,17 @@ __bpf_kfunc u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
 	return cpumask_any_and_distribute(src1, src2);
 }
 
+/**
+ * bpf_cpumask_weight() - Return the number of bits in @cpumask.
+ * @cpumask: The cpumask being queried.
+ *
+ * Count the number of set bits in the given cpumask.
+ */
+__bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
+{
+	return cpumask_weight(cpumask);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
@@ -432,6 +443,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_full, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.42.1


