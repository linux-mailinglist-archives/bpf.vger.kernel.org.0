Return-Path: <bpf+bounces-3631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C158740810
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 04:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5806F2811E4
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438EBE4A;
	Wed, 28 Jun 2023 01:57:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F52BA4E;
	Wed, 28 Jun 2023 01:57:31 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838CEDA;
	Tue, 27 Jun 2023 18:57:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668711086f4so337165b3a.1;
        Tue, 27 Jun 2023 18:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917450; x=1690509450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smMeUc5DmNi2lwy4EGV+uTKZDtjMFbrXIGNYOVUZ5Gs=;
        b=XvEvIhM86CnhKh0MD8v5OB1VCZSoCvFBANEUAqcshG+pb7gx6vMwdcHcXGhacPz5OC
         dzOpn5T9RCvCwszlYF+T7XwUFz/ftQKzcsdkeGnSuG6/VpZLhfzQhzKzhZ2tnuuR0ixA
         7aaVFJBkudfejdrOT1V4P/0rk0waJvVkH8CN4OkMmsRRTDNMAnVPZNAa5m/r5Ea8Yr8h
         h+R6nygbgzs8w54MY15/dD4cZRh92ucujhifl3IoxaOgazv8ZKY589fOXmTdk7vWQy2P
         RQZ0ed0OScWddZgcI7mrsBlkOCgYZNy0IUfyL5IM2zHuY4mzrHrPJ2Jt90vbHKzYQqW6
         Qeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917450; x=1690509450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smMeUc5DmNi2lwy4EGV+uTKZDtjMFbrXIGNYOVUZ5Gs=;
        b=i13OEbX+y6zpJMe8j4Kjgz9V9sfsZ5GeATotnIfmB1h+uSIQGc56mI+IVGBRgY5G7X
         asgnFATFbknZCDZzo03cXgDh/MmnQ3oRqHbPKD3n8GaDol0vz2Z9qxc0DqQmvQcNvTLI
         TcYCzsMxbRwBn/aiKVBgkG9YkKCoZ+g/TiSHqwhlLjJHXb/3xcwLUyVzYvYhmZb/MEoe
         kmHLbO4tAbQf/0kRlxKMa+BD4L7C/TnhcMMKQynvkEqNtwBHU0p71jSDkuVS3CFIw45V
         KQgASNPvLqDUpCN66qkdBgWkoTAYubeetfYlcFC5sP67dwqWFE9IIw6gkX6edsC+c+DX
         f8oQ==
X-Gm-Message-State: AC+VfDyPOKL3UuMpV87xnXDcnI0yEhcYp7Xv3LgLyTsfDl93qt+eHdM+
	0q6mGsLmgavxK8xqKcd851c=
X-Google-Smtp-Source: ACHHUZ4h0VwbFvM6lSorEvSu4x8a4hE0merf/XO2OIQII0dgJ1Xy1ru2Gqpgrpv74Yx4Kg7SEj7OLA==
X-Received: by 2002:a05:6a00:b4e:b0:67f:d5e7:4604 with SMTP id p14-20020a056a000b4e00b0067fd5e74604mr2023474pfo.13.1687917449856;
        Tue, 27 Jun 2023 18:57:29 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id e6-20020aa78c46000000b0065ecdefa57fsm98977pfd.0.2023.06.27.18.57.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:57:29 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 13/13] bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
Date: Tue, 27 Jun 2023 18:56:34 -0700
Message-Id: <20230628015634.33193-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Convert bpf_cpumask to bpf_mem_cache_free_rcu.
Note that migrate_disable() in bpf_cpumask_release() is still necessary, since
bpf_cpumask_release() is a dtor. bpf_obj_free_fields() can be converted to do
migrate_disable() there in a follow up.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 938a60ff4295..6983af8e093c 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -9,7 +9,6 @@
 /**
  * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
  * @cpumask:	The actual cpumask embedded in the struct.
- * @rcu:	The RCU head used to free the cpumask with RCU safety.
  * @usage:	Object reference counter. When the refcount goes to 0, the
  *		memory is released back to the BPF allocator, which provides
  *		RCU safety.
@@ -25,7 +24,6 @@
  */
 struct bpf_cpumask {
 	cpumask_t cpumask;
-	struct rcu_head rcu;
 	refcount_t usage;
 };
 
@@ -82,16 +80,6 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
 	return cpumask;
 }
 
-static void cpumask_free_cb(struct rcu_head *head)
-{
-	struct bpf_cpumask *cpumask;
-
-	cpumask = container_of(head, struct bpf_cpumask, rcu);
-	migrate_disable();
-	bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
-	migrate_enable();
-}
-
 /**
  * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
  * @cpumask: The cpumask being released.
@@ -102,8 +90,12 @@ static void cpumask_free_cb(struct rcu_head *head)
  */
 __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 {
-	if (refcount_dec_and_test(&cpumask->usage))
-		call_rcu(&cpumask->rcu, cpumask_free_cb);
+	if (!refcount_dec_and_test(&cpumask->usage))
+		return;
+
+	migrate_disable();
+	bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
+	migrate_enable();
 }
 
 /**
-- 
2.34.1


