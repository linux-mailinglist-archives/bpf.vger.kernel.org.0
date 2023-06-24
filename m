Return-Path: <bpf+bounces-3354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8CF73C687
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FB281F55
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4EA5695;
	Sat, 24 Jun 2023 03:14:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD27F;
	Sat, 24 Jun 2023 03:14:30 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C9E47;
	Fri, 23 Jun 2023 20:14:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668711086f4so941540b3a.1;
        Fri, 23 Jun 2023 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576468; x=1690168468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfktoJD/McKDXPEAYo4ZmtHg2u99iMZJ4yXppCi89l0=;
        b=p9mkB7i8fY1miNgqCh6JzjUWcWvHiL0PawOU6UygHWwc+NlcsE84WrTwEf5bcwYIcT
         EA5d9aLOcDm2I0Q2LAq4fj9nEW8+cn5+wxUPgCVKJZyB+xhTlwvekHYug/SIrddf7RgH
         aM9N3NTIq2NAuPTaPNuS/kr6BA37g6AKnL5UOCxZcZ82fmZOF0VHh3tQv9EYvc24AO8T
         8R0qvr2cgHm6pV2GE2zr1h2W/6S5UdMZeOU5SDbNrWZIko/mNUJslUWHW+C0kXQ9tuji
         pKam6fFroXtJzRnCkxcUNcywmhZpMKMx+YkJS+rTtVVc1hnF0oO0B36KnTxmxJ3l/qaw
         oICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576468; x=1690168468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfktoJD/McKDXPEAYo4ZmtHg2u99iMZJ4yXppCi89l0=;
        b=RL6uxtxVTT05sMzkH8I1LnQRJOQrBQgHNr5k5/lZAof8FRJ4UMQjwHoCJeCvtPMd07
         upR4YroeKiQbqZW3MqkcB6M86x0lvlklsX27xAsC3YE4uymTHD6HG8kzUv0e1fk2Kz5G
         1lhpOHNeM5+bcDOk+FwyktnMiNs9ILrL7X7ohmkWVIGY4Y+cP+avj8lSb1VgH4SmIb+2
         vAQDq6ooV6+VkHkjKzPPBtrhaa3d0DG/JpCSYfPBR6G5FVWS0z3HZKaLQ94EWN0nU/WG
         Y8OtWvyjQsdJ9VIyRN5BESa8mykp0U5+peuubL5f5y7Qvlr2SNLVfPzPFxjzl5EdULUW
         f3Mg==
X-Gm-Message-State: AC+VfDzfWTm/44E6iLO5/P4SYM0L/l45ZAM/4Sx6cf3w3ktq6RNo2rFt
	d6lK7RtPEOBzohMyfZKtQ8I=
X-Google-Smtp-Source: ACHHUZ4uWXjbFvD/+zsgvTmQ5PbSmoCb8Lesk1eF/FTZ3JCp2aHhqcGP60ZcgOvtl9NpG8TPRexELA==
X-Received: by 2002:a05:6a00:2186:b0:65e:1d92:c0cc with SMTP id h6-20020a056a00218600b0065e1d92c0ccmr42129758pfi.10.1687576468479;
        Fri, 23 Jun 2023 20:14:28 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id t16-20020aa79390000000b0065dd1e7c3c2sm195221pfe.184.2023.06.23.20.14.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:28 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 13/13] bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
Date: Fri, 23 Jun 2023 20:13:33 -0700
Message-Id: <20230624031333.96597-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
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


