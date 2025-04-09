Return-Path: <bpf+bounces-55592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E491BA83397
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A958146402C
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01210215777;
	Wed,  9 Apr 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyxKnQiv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3C2147F7;
	Wed,  9 Apr 2025 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235178; cv=none; b=LAOJLMN5gq1TxEp0i1E8Yr5u2Y79oF8m3fViM5F5jEmWB6TSejITWtA3T1fA5gUhOQ7UTMW8/2z9R2z3QiUTwXDGQ2oFFiPPfaXaXFc+fNB+P3Gbdu0bZ7LK+lKc+WFzNOaawm4uSgkBRmdCUj0BAsqrIwu5iso31GZtZAPLqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235178; c=relaxed/simple;
	bh=89/4mUJpr9aktknNh0PQoqcLMbO5zSd3Gu5eTVqHXXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awcTYZtuvHl0dLnl0Elcr9eA3zvHl9SJVEWs5bFO1XsB3AfuEXn6kHV9lTxpWKWPfndHnmCisWSPwZEVh/sA8M4rS0YWLePz6ENN4BsyIuN2HLT5wyjj4/tQ8/c0mp7g4F1U0O+Hpw93WiRlUdXmm975zmEOrG/ONkoYBXzpRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyxKnQiv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2295d78b45cso1891465ad.0;
        Wed, 09 Apr 2025 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235174; x=1744839974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7Vh09nD0sM/32Xv3BcGHrqGV2e/Cdvu6uqMumBsx/Y=;
        b=dyxKnQivq3G2sIpEUyWXU8ENwTmgzOKICdcPi1USP80KLmFxfMBpRl6btR2c6+KNbI
         cSbWsGjCI3AjAtt+eigpcBpk3dLJZkFBajhCZnVJQ2Hfwm+sAaCr/aSxTQNjhI1ee3ws
         h9M9m2NYogOF/Ze9wm4EN63VP+REj/LNmq2dXxpWX9ot0NJSO80qqkbwSNVAQ7JLUlXU
         Wxu8wz7ic1IoHv5haf8k6F9m4UVHeH6UauHrIh3TlzoYLLQBoWP1JetUVksZxqRl7UAR
         U62W4D7JHO0tXnRxjTB4M1Ga32ZN1lBUzQ/N4uDwNQDeigdYIO0xox/wrjiuKBAy/bDq
         Bfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235174; x=1744839974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7Vh09nD0sM/32Xv3BcGHrqGV2e/Cdvu6uqMumBsx/Y=;
        b=kGVoo9OLFx1/ecGs9H0JIGlSEUGHLV9ofJvofMI7M5rxt0SlBM9ZHNmVjQD4ura0Da
         lI/ACpoT6yJvorK38e/V8EfryOYTCkld73w5244uLCgl+9iZLyLHcJRuJDhJXzH/bDHg
         T+Kt/TfzU4H9acEiiQYOXaCMhaPaGZVjHIdkbl3MF3ATN0inCkAaLvl9so5A8jzZkHwW
         O8NEqjMXGfDq0+zk+pSICSZG2XspQoPvbQCUyv+KeiT8TBN+EYHloLkz+9K49deukQTd
         Ri4KIq5bj2+pU2WJjNVHHwR13jSZcvj+hQUVkgJ6UPMc3lIU76x36dBZMvDN67EAPnf3
         FzKQ==
X-Gm-Message-State: AOJu0Yy0AfljnX7dOay+lxpBTj07SH+loYE4Q8vaXURBmceZEPTCw+s3
	315YVYZLtf8/Cq6CSDL5UlGpk9rhyIWcCrv2pTQz+VyvkKqzdpbZQnfu6qvi
X-Gm-Gg: ASbGncu3xWnw9x3bbyN0BvmJsQKF5M+Aaz8I/elTAdifp7ViCA7x7wB9XeJQp4cH8XM
	ocM94Xezyv5vRbVCAA9TIuD9le9jwGEBJzujF3aHOJA7gSURalVjOtLEbMked3h4L4Aud4ephuT
	Mgo7i2q4Qh3ZsxXpmTmoTlQ+jJlFx+eIkJUXl9ZUJdfnx3W03f6/XENQzlVVEZLv4HDt++Nyf6s
	m4Hbgux+3tGOOrrJ9hVqcjspMVO4zAjeku3Rc/6/1cOr/bv0nqnDOhmgiKXiMFYtF2l5O2fZQ4N
	NJTE28692ewwsYPHvYAs11VvBwaT/sBc
X-Google-Smtp-Source: AGHT+IGJBFAuynzAT2nHTkC22zkDKY4M/EKCUuAbsmMGqTBvQFOV5odQc0blrfB//M6D7rKQ+l2TDg==
X-Received: by 2002:a17:902:d48f:b0:223:f639:69df with SMTP id d9443c01a7336-22b42c439demr6564775ad.41.1744235174184;
        Wed, 09 Apr 2025 14:46:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b62917sm17167475ad.11.2025.04.09.14.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:13 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 05/10] bpf: net_sched: Support updating bstats
Date: Wed,  9 Apr 2025 14:46:01 -0700
Message-ID: <20250409214606.2000194-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
References: <20250409214606.2000194-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Add a kfunc to update Qdisc bstats when an skb is dequeued. The kfunc is
only available in .dequeue programs.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/bpf_qdisc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5f4ab4877535..5aff83d7d1d8 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -254,6 +254,15 @@ __bpf_kfunc void bpf_qdisc_reset_destroy_epilogue(struct Qdisc *sch)
 	qdisc_watchdog_cancel(&q->watchdog);
 }
 
+/* bpf_qdisc_bstats_update - Update Qdisc basic statistics
+ * @sch: The qdisc from which an skb is dequeued.
+ * @skb: The skb to be dequeued.
+ */
+__bpf_kfunc void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb)
+{
+	bstats_update(&sch->bstats, skb);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(qdisc_kfunc_ids)
@@ -264,6 +273,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_bstats_update, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 
 BTF_SET_START(qdisc_common_kfunc_set)
@@ -279,6 +289,7 @@ BTF_SET_END(qdisc_enqueue_kfunc_set)
 
 BTF_SET_START(qdisc_dequeue_kfunc_set)
 BTF_ID(func, bpf_qdisc_watchdog_schedule)
+BTF_ID(func, bpf_qdisc_bstats_update)
 BTF_SET_END(qdisc_dequeue_kfunc_set)
 
 enum qdisc_ops_kf_flags {
-- 
2.47.1


