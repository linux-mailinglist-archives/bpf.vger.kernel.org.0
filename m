Return-Path: <bpf+bounces-56460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA403A97AC5
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 00:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A57A745E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 22:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029E2C2AD6;
	Tue, 22 Apr 2025 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enc5uyOm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE31EE7DD;
	Tue, 22 Apr 2025 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362692; cv=none; b=mNf6vsl9l+WzX2IK3QVzjwxuu0ogtfj3JBDhC7pE6ojCLUGMplW5ftDokHbfAV/d09rZHagZAJ4wITDpm/rzuwVB2E6/z7iJFfuC1ijXefxnjxgZ07Btda7bM7QHmDP/BehVxrr/Vpx3KzTTgMY3UEYkY+Xiacaqao/kE/UoMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362692; c=relaxed/simple;
	bh=qhoCRr6iJ4JDLDgkjS7q5wQsu+zo9f5E/xP7W721KYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2DKYlDkhIpSIb12FtLfKef3BJB2ZM7pp0Wdy3n9HFDZj/XoZe2e/CMZ3DU2LrSEYynJ/JkWxfI34tqy27YGYH2/iYAqetBV4xxHHtTc6Cas5HkJz2J3FQKnDQQXvsUgLyPRrKBohhnDphJhX9v/Arpda1paq4keqQp9tdpz4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Enc5uyOm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227c7e57da2so50486765ad.0;
        Tue, 22 Apr 2025 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362690; x=1745967490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g4+iUhVe7p621IQ4rwytm2VMPB/Jrbhsqc2u60r7Vr8=;
        b=Enc5uyOmJyyj6YrMRhlPm9GHn0rVAAinO1qWl7tfHs/1VYoyelSY6whgqhart3+T0y
         iKkUvwFN5098bH4sYBTM7G5ODFeOEfvBQjfeM7L7lpu3qwt59LqY+jbSfSDDElnvh8Vs
         PrSvSiChT9j1A3iI5Il4tW35ZKMKRnju6u7OqsKZIWwr/+mQSET6f7DOVCFhXYpJZYws
         LCH6DktUg/AFrq75PxaoaJDoAM/11DvaHVDYIGeKH5Ui9EVmz5wCl7GC/ImwhbC+wW/b
         jtV1uGKiCUtrzNItYjsFZYIgpn+/76YPFgttsK6/xkdABu+z9EdNdMUWBIPnLqGsIscQ
         XMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362690; x=1745967490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4+iUhVe7p621IQ4rwytm2VMPB/Jrbhsqc2u60r7Vr8=;
        b=syPfK4bsH8nbD/GQ/A4TZveHSadf9Jw9tsvL1ng96UewjvLlG5l84wljAnYbZqy65P
         aZ5a1GOoJMG7hmvpIiGET6F0xFKL2dOGoBA5swxzonkCl8lf8a+zwTTTaxAWA1YACPtr
         xPrTLlEOPxnrYNeihua5Zjq0ymD1SiRuLwkmbV6sUNvUFvcpJdH8BhAVGKOhGYiH3VrP
         aa4xXQiMyBKKTT0QlfGgWUDCwMN+E+TbDge5ZAmSjpgAmPz4qc/eyfjglck+orJXgDzi
         IocxGA77IizIeZQBi4nGkH5a3Z4phRLCpuvtIN82oZOq5CknDnEsc+0tuIip5du0Zh/J
         BcxQ==
X-Gm-Message-State: AOJu0YyDKgd7qqm/cXGFQtFKnwiXtSarGgYjG4aRiw+DUUgylTgkPts2
	TdsISnh3X6/QQKUHOLMCKA7Y/CtVtvOTzUkUHdn1zIoZDydX7SYs7qJVEQ==
X-Gm-Gg: ASbGncu+ihrzOVjryW4OwzG3BcJoCBcLTgOyKn2x93JHkS0UH6H4KhoGd4xRUYUhHSo
	mpMKsAxBeeEmBTZFTJe8ZbH1PuuRC/v5ktS/crrhfFo3HIu4cg2jf+hr/P8cAri4PuuXYNcvlEP
	mDNkFTqDf7Oa5s1c77HlYnoDAD+ChH8GzbRI8tWWyhTcuR655yUnFbiXVevHoRfPn9HmFWobCxt
	U7uxlqF0g5Ys4jsKAYJgs4DYvjL2JB2CkUga2iM8dW7I0IIBEVUG5OV8vU9i0R6KulSvKAJzC2I
	jhjEaItfbQjEeqDZ2BJufte/nWOz+Yqj3ZGGa9MTqA==
X-Google-Smtp-Source: AGHT+IFwK/lAXaOceQuK5Hi0GaDdk7yxxO7EC4ESy6jL8Ksqb4no5JEI1f7zjK7yyRvDNqWW40Ia8w==
X-Received: by 2002:a17:902:ea07:b0:223:88af:2c30 with SMTP id d9443c01a7336-22c5357f3b2mr224090895ad.16.1745362689627;
        Tue, 22 Apr 2025 15:58:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bde12bsm91100035ad.40.2025.04.22.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:58:09 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net] bpf: net_sched: Fix using bpf qdisc as default qdisc
Date: Tue, 22 Apr 2025 15:58:08 -0700
Message-ID: <20250422225808.3900221-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bpf_try_module_get()/bpf_module_put() instead of try_module_get()/
module_put() when handling default qdisc since users can assign a bpf
qdisc to it.

To trigger the bug:
$ bpftool struct_ops register bpf_qdisc_fq.bpf.o /sys/fs/bpf
$ echo bpf_fq > /proc/sys/net/core/default_qdisc

Fixes: c8240344956e (bpf: net_sched: Support implementation of Qdisc_ops in bpf)
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/sched/sch_api.c     | 4 ++--
 net/sched/sch_generic.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index db6330258dda..1cda7e7feb32 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -208,7 +208,7 @@ static struct Qdisc_ops *qdisc_lookup_default(const char *name)
 
 	for (q = qdisc_base; q; q = q->next) {
 		if (!strcmp(name, q->id)) {
-			if (!try_module_get(q->owner))
+			if (!bpf_try_module_get(q, q->owner))
 				q = NULL;
 			break;
 		}
@@ -238,7 +238,7 @@ int qdisc_set_default(const char *name)
 
 	if (ops) {
 		/* Set new default */
-		module_put(default_qdisc_ops->owner);
+		bpf_module_put(ops, default_qdisc_ops->owner);
 		default_qdisc_ops = ops;
 	}
 	write_unlock(&qdisc_mod_lock);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index e6fda9f20272..7d2836d66043 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1002,14 +1002,14 @@ struct Qdisc *qdisc_create_dflt(struct netdev_queue *dev_queue,
 {
 	struct Qdisc *sch;
 
-	if (!try_module_get(ops->owner)) {
+	if (!bpf_try_module_get(ops, ops->owner)) {
 		NL_SET_ERR_MSG(extack, "Failed to increase module reference counter");
 		return NULL;
 	}
 
 	sch = qdisc_alloc(dev_queue, ops, extack);
 	if (IS_ERR(sch)) {
-		module_put(ops->owner);
+		bpf_module_put(ops, ops->owner);
 		return NULL;
 	}
 	sch->parent = parentid;
-- 
2.47.1


