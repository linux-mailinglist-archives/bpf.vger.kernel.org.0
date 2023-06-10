Return-Path: <bpf+bounces-2300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14B72A8E8
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 05:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F3C281ABD
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 03:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC95CB8;
	Sat, 10 Jun 2023 03:51:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2083538A
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 03:50:59 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C7359A;
	Fri,  9 Jun 2023 20:50:57 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-75d3f2c9d13so234167385a.1;
        Fri, 09 Jun 2023 20:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686369056; x=1688961056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjnRZ997c0EJsAweMRpMCDSezCDXyn9PqnhVcCtO5Hk=;
        b=FPr04JbVwrHpTaO39GfkrOKBcIigZRfyC1eio7izpllyJsuAgMKEwsWKdz+eTFMgXA
         f9olGDfrXl4H4GQyQJFo+jxjdpOQzhc+6a8mbxNYpx0lYfIzJDFdY+bi0KI/usLZSZj3
         3KhpCCGay9iGs22JEW3GIlUiBKlzHsvUv4teC6VuXlDH8UyZBvsEOPeccpSVa8MK88F8
         0SlIYJo7xo01+0/7SoZbDjHv0ZA8fPbEGp+IVMrQr2p2NxWHe2Bmy/F/p8PGe0ZnIhJV
         WpvUTABR8MfpaXBVfy1UJ7taqkWFpKy9imCPeeghS2qkvWco/b+H313by1vOsVic6cWt
         wd/Q==
X-Gm-Message-State: AC+VfDzz41yoDMVCl/4+Ni8FncdE8GcuwHMcBbHxbZDo3FgZgtftnBQM
	HwggaZTs2f2k+NYXCPeiB8W4YxDDyrEBUTYf
X-Google-Smtp-Source: ACHHUZ7iApw5Ij1CMbzWxs78e9IRfiI42uBiRIiXx1qqI7WkloIK5QsJ8IYXUSGhVB5bHYFD7S5rYg==
X-Received: by 2002:ac8:7f50:0:b0:3f9:d590:82ac with SMTP id g16-20020ac87f50000000b003f9d59082acmr3260032qtk.20.1686369056110;
        Fri, 09 Jun 2023 20:50:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:81d3])
        by smtp.gmail.com with ESMTPSA id t2-20020ac87382000000b003f6bdc221e6sm1667873qtp.53.2023.06.09.20.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 20:50:55 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/5] bpf: Add bpf_cpumask_first_and() kfunc
Date: Fri,  9 Jun 2023 22:50:49 -0500
Message-Id: <20230610035053.117605-1-void@manifault.com>
X-Mailer: git-send-email 2.40.1
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

We currently provide bpf_cpumask_first(), bpf_cpumask_any(), and
bpf_cpumask_any_and() kfuncs. bpf_cpumask_any() and
bpf_cpumask_any_and() are confusing misnomers in that they actually just
call cpumask_first() and cpumask_first_and() respectively.

We'll replace them with bpf_cpumask_any_distribute() and
bpf_cpumask_any_distribute_and() kfuncs in a subsequent patch, so let's
ensure feature parity by adding a bpf_cpumask_first_and() kfunc to
account for bpf_cpumask_any_and() being removed.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 7efdf5d770ca..9416c8ac8a04 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -131,6 +131,21 @@ __bpf_kfunc u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
 	return cpumask_first_zero(cpumask);
 }
 
+/**
+ * bpf_cpumask_first_and() - Return the index of the first nonzero bit from the
+ *			     AND of two cpumasks.
+ * @src1: The first cpumask.
+ * @src2: The second cpumask.
+ *
+ * Find the index of the first nonzero bit of the AND of two cpumasks.
+ * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ */
+__bpf_kfunc u32 bpf_cpumask_first_and(const struct cpumask *src1,
+				      const struct cpumask *src2)
+{
+	return cpumask_first_and(src1, src2);
+}
+
 /**
  * bpf_cpumask_set_cpu() - Set a bit for a CPU in a BPF cpumask.
  * @cpu: The CPU to be set in the cpumask.
@@ -406,6 +421,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cpumask_first, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_first_zero, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_first_and, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_set_cpu, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_clear_cpu, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_test_cpu, KF_RCU)
-- 
2.40.1


