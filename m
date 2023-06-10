Return-Path: <bpf+bounces-2301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8757D72A8EA
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 05:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7ED1C2118C
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 03:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1763DA;
	Sat, 10 Jun 2023 03:51:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9363D1
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 03:51:02 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7D35B6;
	Fri,  9 Jun 2023 20:51:00 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6260f03b76dso17869976d6.1;
        Fri, 09 Jun 2023 20:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686369059; x=1688961059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+QjjC2Q6R+F5tehvijFrBV+74kCnxo9UVFUil+fcVI=;
        b=Mq+DBsf+GXQa0lrFwRYRtzYUZQ9a2Mt5MM/4diyDzXM3BnxavAZzQ9az5obUjv5/Cw
         leKyOjU43ieRJ7sLes0jhpCS1cr/EP/+8aiCn78m2i8nEBW2kinvijS3bEFT6uFLF+Nh
         CSEWFcPwwlsRj8ftMywdRo6CoaslzL7g+07C7XLIOL1MUuTWF+p3x5PW787WdEX0MUnR
         FlJa39Oir7KrbNF6aidAB/i5N70OhE2A1cFfcugNKy6AFtEdP7awP4QmecL54GA9gf2y
         BLXvJAz9ySL/PdbwrLLOyO7NuoRZeVLAsIl30gQ0AZF76s6N6sXvErFg5/Qa3DA+xqYe
         XTzA==
X-Gm-Message-State: AC+VfDyUhsZ0T0kxb5H+REGzoj4PIPsMAJO1+PqH9OuDTSYkINFcN7yC
	oVxyrrTSRkhrPnhPz6qSEO/XOSsYc0eurCQD
X-Google-Smtp-Source: ACHHUZ5tYNaIDKICZ6JhsznroPEuzY9A32/9H5uiEEIis//9qoZlNNp5nIk55b8pk9B8onAEg+H8Sg==
X-Received: by 2002:a05:6214:b68:b0:623:9126:8d7b with SMTP id ey8-20020a0562140b6800b0062391268d7bmr5436418qvb.28.1686369059185;
        Fri, 09 Jun 2023 20:50:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:81d3])
        by smtp.gmail.com with ESMTPSA id a18-20020a0ce392000000b005fe4a301350sm1599968qvl.48.2023.06.09.20.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 20:50:58 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	tj@kernel.org
Subject: [PATCH bpf-next 3/5] bpf: Replace bpf_cpumask_any* with bpf_cpumask_any_distribute*
Date: Fri,  9 Jun 2023 22:50:51 -0500
Message-Id: <20230610035053.117605-3-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610035053.117605-1-void@manifault.com>
References: <20230610035053.117605-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We currently export the bpf_cpumask_any() and bpf_cpumask_any_and()
kfuncs. Intuitively, one would expect these to choose any CPU in the
cpumask, but what they actually do is alias to cpumask_first() and
cpmkas_first_and().

This is useless given that we already export bpf_cpumask_first() and
bpf_cpumask_first_and(), so this patch replaces them with kfuncs that
call cpumask_any_distribute() and cpumask_any_and_distribute(), which
actually choose any CPU from the cpumask (or the AND of two cpumasks for
the latter).

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 9416c8ac8a04..938a60ff4295 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -382,7 +382,7 @@ __bpf_kfunc void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask
 }
 
 /**
- * bpf_cpumask_any() - Return a random set CPU from a cpumask.
+ * bpf_cpumask_any_distribute() - Return a random set CPU from a cpumask.
  * @cpumask: The cpumask being queried.
  *
  * Return:
@@ -391,26 +391,28 @@ __bpf_kfunc void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask
  *
  * A struct bpf_cpumask pointer may be safely passed to @src.
  */
-__bpf_kfunc u32 bpf_cpumask_any(const struct cpumask *cpumask)
+__bpf_kfunc u32 bpf_cpumask_any_distribute(const struct cpumask *cpumask)
 {
-	return cpumask_any(cpumask);
+	return cpumask_any_distribute(cpumask);
 }
 
 /**
- * bpf_cpumask_any_and() - Return a random set CPU from the AND of two
- *			   cpumasks.
+ * bpf_cpumask_any_and_distribute() - Return a random set CPU from the AND of
+ *				      two cpumasks.
  * @src1: The first cpumask.
  * @src2: The second cpumask.
  *
  * Return:
- * * A random set bit within [0, num_cpus) if at least one bit is set.
+ * * A random set bit within [0, num_cpus) from the AND of two cpumasks, if at
+ *   least one bit is set.
  * * >= num_cpus if no bit is set.
  *
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
  */
-__bpf_kfunc u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
+__bpf_kfunc u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
+					       const struct cpumask *src2)
 {
-	return cpumask_any_and(src1, src2);
+	return cpumask_any_and_distribute(src1, src2);
 }
 
 __diag_pop();
@@ -438,8 +440,8 @@ BTF_ID_FLAGS(func, bpf_cpumask_subset, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_empty, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_full, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
-BTF_ID_FLAGS(func, bpf_cpumask_any, KF_RCU)
-BTF_ID_FLAGS(func, bpf_cpumask_any_and, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.40.1


