Return-Path: <bpf+bounces-13217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C877D6454
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 10:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FA2281CF1
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48781C2BE;
	Wed, 25 Oct 2023 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j2ANNlrU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA551C695
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 08:00:27 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5199
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 01:00:26 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce344fa7e4so3578677a34.0
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698220825; x=1698825625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEDb2KxkVSFe4TSUmh3nQ3qzGa9/MUfpXPnNyHh03Dw=;
        b=j2ANNlrUlsw9WLtlsJ/fXP9Pq+4U5oGrj44LQdoMogRIBRVfe5rDe/6a3KF62PSFKU
         5xw/wSUk6uGCyySqjFv4KXDvmmbmm3AjED6sx1tBCnE3YHeaS+XXQ92yHvWDfirBxngb
         TTb4FnJ6Q7YT46JwIVsHSkFAEPdPe0aa/IrXVKNfKe/Qp6pG1z7Ac5G771G2NyrhwpRF
         tiZBT1IgueQmXw2cTeIbYbTsZYArVZcYMBQqyt/7NWEM3w/NfdkJtAKt3whMJVfd24WW
         UJTJUC4w+a1aSvrpULxDdr+Vk4vUrMOOXx57JFAcFtPSwow0SsAMCeR+7BdW56lgAlI8
         lH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220825; x=1698825625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEDb2KxkVSFe4TSUmh3nQ3qzGa9/MUfpXPnNyHh03Dw=;
        b=KE+Obois6ASwdvg4Hy1xnXZ77IeSDIgOzPgoEvtbMWNFh0FIxChXUMkl9zZyXUwG7A
         uyg9ekoLNTMDS3Wy9P5nd1QSzXUN3KHY7ZUeej++SLFuC/JdmSFIMURd5RGhPabOYvcJ
         NZ8MkDvVdIYdPiVsk4mC7IIyDx75MekhhDUIJYKGzOwc37QogDTMvIP6ZdJ3Vs6hHAaW
         eLGHD/ZhNWspzq6cwqBJiBU0IkFK/JZ6jRZyxdBoKuuraVqQfq7KFdaWnD1JOmsp9Nm2
         m+OtnYjC+SzVDNUJ4WPOPeHaYb9y0dcbTomLxgZAV4NQ8BIUT+UJXvlZZe/3D3aiYg8p
         IcXA==
X-Gm-Message-State: AOJu0YynBNim6U2wa9qc46yB4/oqcMyY2IlqTeuawLgH9CJo0D0ut01C
	K0+Iv3gEJhiR1JvXpTDWCZWR/IjqeNytadmcjqQ=
X-Google-Smtp-Source: AGHT+IEjMqibcqyAWYdN8rprIPTaemu6Y4i4SjkitUo13M46iNbSqRloJNVIv6wjqeae53PAfMDcFQ==
X-Received: by 2002:a05:6871:1c5:b0:1d5:a58d:1317 with SMTP id q5-20020a05687101c500b001d5a58d1317mr15280503oad.10.1698220825247;
        Wed, 25 Oct 2023 01:00:25 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id 23-20020a630f57000000b0059cc2f1b7basm8118187pgp.11.2023.10.25.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:00:25 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add test for using css_task iter in sleepable progs
Date: Wed, 25 Oct 2023 15:59:14 +0800
Message-Id: <20231025075914.30979-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231025075914.30979-1-zhouchuyi@bytedance.com>
References: <20231025075914.30979-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This Patch add a test to prove css_task iter can be used in normal
sleepable progs.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../selftests/bpf/progs/iters_task_failure.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
index 6b1588d70652..fe0b19e545d0 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -103,3 +103,22 @@ int BPF_PROG(iter_css_task_for_each)
 	bpf_cgroup_release(cgrp);
 	return 0;
 }
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(iter_css_task_for_each_sleep)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+
+	if (cgrp == NULL)
+		return 0;
+	css = &cgrp->self;
+
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
+
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
-- 
2.20.1


