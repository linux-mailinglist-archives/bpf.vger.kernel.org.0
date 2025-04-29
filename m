Return-Path: <bpf+bounces-56974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF7AA1B4B
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7A11BC2FC0
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50A25E811;
	Tue, 29 Apr 2025 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzSLKY4k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098F227BA9;
	Tue, 29 Apr 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954492; cv=none; b=fuukYMeuzKcH6OxjsCPzZ3YFqvreSYMlSv0akEfPAn10+E2DoF2FYDlMWaXq0j98yVMOqzRTlgq8mj6uXDAphQOhnvKeUAiAyq09ivbw1Hu6UvOTU1LhEFqMzc68N2cuUwtAldIUNi50B6KrR/73IG/kIWiBBE/Wap9Mnj823FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954492; c=relaxed/simple;
	bh=/uEhL2QTOqVoY+LJlqHAxirfqxnq9SrGRg0mlrNOA5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/TaXgUeqcreh/rTixxO4t1ZQdZhvm1HJVWTYCby5hDF53W7D5/cRelgCUYMnDfhJ1dRr5RXokfNKv6WyCtemZv0QL0h9sVdehjGXoPo1ZFpN9Y2g6u6JBYIzwrt/1af3yhYkYBTwMdN+X2gWH9bKGYCfbKhJRef9152BRUpawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzSLKY4k; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-309fac646adso202818a91.1;
        Tue, 29 Apr 2025 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745954490; x=1746559290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrzSBj/GX65Yoq6eFuCE2DeuZRQldG04kcKan9gJomA=;
        b=CzSLKY4kX64Y9XkmxNiA/wA+yQWDZ6fEiicN0rQlQ5OYh0INqRM5VXzlScvzPEnScy
         YOqUCDV27M6V3M9mlhIH9kI1a9ADIXFwIBTzxRtXpJyOC3RbQQteIr0GJb8S4sx3EB5m
         DroBFaL4SAFGTtGZYCJ53kGwL8G3PXE/N/JbcjZNoQk+Dm1rqwKQ4JDalsPr0XrRBAIR
         +hP0IDA67aKrj2r11+fsWbXvl1oHlz9ulTkJl+i1YbHc2wo5lZWZ2zfiLU8ZNoTYgumF
         aPFQl4lBEFBz6aBuvHBWnbCZXfWbmKAd/pHOyX0ySYB88Uh+dsLCqBwpy/jrh9ReRTOK
         NnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745954490; x=1746559290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrzSBj/GX65Yoq6eFuCE2DeuZRQldG04kcKan9gJomA=;
        b=vNBmrV58sUlKnP34Xfz4MrTSxAGALOY2/5B/UgfLescXet5E+79abuOuI1WTAYIwek
         SrDofJUVYlrtAq4bDOQaoY+D2DXz+XfNao6Vl8JB3eHxUZ0ddkmlEXYAdQQXa657LP1j
         03h/+cnExjHwJWayWRKCXDCQwlqQj3hgMhzhPQGqooc+Th4hJvq2cjw6DEd2VVWwy+Pz
         NRPUzWsslH5j9RcPnr53TFHEpOtA+L/oH0dRi2r2B1pUgnouSwLOE38eqY+l0qRqbQTg
         EGbT23ccUcZL7vD8EL2NoNG1LvXCcwyu9CHDKIQXRLXvpGXN1AOfgy+Qno4Nn6IWKdg3
         /y0g==
X-Gm-Message-State: AOJu0YyNem1sZ3wlyuPGn/m/h2xdi1q6D/PbboXjAJwWVqPuMNVfjj7O
	szcUnFFva52Wy+7PUngf1Fc8jhArmB+Z20gkNppY1AAwoV7In/CWs/jVPw==
X-Gm-Gg: ASbGncvMR+yT2XDocW7ruwvTBn0MmpyKH71FRaiXq6N5CQvtPEDgeWICAY6fx8A+TBN
	TVsbj6VluJ+TdZiL8I3LCWwjjCfbEGtVkATdrCiYCGemQi6BsfcbYV4vHPusl+Ty1hSQ4SQRGBS
	j7Bw/33HUR6V38i0Jk0M+hpu2SOxbL6IojHz0qLYHHamKxQi8sIkIMS3sAkaHyG5OEdV488D56H
	u9HYZU6rL/ckfUd542g+ryaO+teTrxiaF2KaWd3wq7jP6tDFYVRdJ9MhtUWQx1cI+lyByRKQdx1
	s7ny+pg7tF4ka83KWDjRkM747RyLl68c
X-Google-Smtp-Source: AGHT+IHWHvLzOE9edourtqJE04WUabgjj1czw56Azm2yajn62KoSzipTKQa1/pSH/2TfyjDu+FWRAQ==
X-Received: by 2002:a17:90b:3904:b0:2fc:aaf:74d3 with SMTP id 98e67ed59e1d1-30a33c98820mr116483a91.4.1745954489711;
        Tue, 29 Apr 2025 12:21:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f7754d52sm10903923a91.19.2025.04.29.12.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 12:21:29 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v2 1/1] bpf: net_sched: Fix using bpf qdisc as default qdisc
Date: Tue, 29 Apr 2025 12:21:28 -0700
Message-ID: <20250429192128.3860571-1-ameryhung@gmail.com>
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

Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/sched/sch_api.c     | 4 ++--
 net/sched/sch_generic.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index db6330258dda..c5e3673aadbe 100644
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
+		bpf_module_put(default_qdisc_ops, default_qdisc_ops->owner);
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


