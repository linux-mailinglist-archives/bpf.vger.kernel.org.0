Return-Path: <bpf+bounces-57164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB241AA6639
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AA24C5BF9
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60EC26773C;
	Thu,  1 May 2025 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4PGHaRk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC7265CCF;
	Thu,  1 May 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138631; cv=none; b=TOoGdpba8TGuBgk6mO6t5BuZ2hP2rctV0qL81bbWyGWwu8tQSmdrGUblxYJMEJLTp/6jkfRVGtwauZjNkrlUCIcG996JKu3soVWjHdZW4l4VRMr53/yql2X5wtlQGRQ8jARcYRKa9bzMQWkIMZv7t4WB5iSvp+IWf9f+X8CgN54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138631; c=relaxed/simple;
	bh=aPLae31w59iujbZOh5YfgMrd4kdQuqHF02bPKe1yosY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCZvDpSnKiK4CudcamafzpgC+NBxTzQqCklVkEpsxAJ9Gth3uMludakeZHEiYhjvyXOFdQMlmktYCk1i6iDbkXe85EpaCqelhfCm3qvJ8zB3KEKK86KgMesNWXgFpJGQ5XvzpS8kJDeAH/c29c7gEB7HG7MoaCDpcQK1WyO6bn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4PGHaRk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so1237101a91.2;
        Thu, 01 May 2025 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746138629; x=1746743429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQPL2VUJkkrYH3B5AKeP1PZEpyMagTH7pOj/MvkjKRo=;
        b=c4PGHaRkHxmgbkJ5OIRmC1O5b7ZJi+VDRHu34Dh0zY3sEOaoV14UdaQCleekx2kO8T
         AMAg7IES1eBunRtiKPLhCD76L+fRsfxNLCJxfgPGbL3ljKAkebKQ69910+MKOcro6gtK
         1sGZ0r3id5k7zPK3sbhIxLI9qhJjuDwpu4Yb9ew15j6VN1wxsA6/kPyEC2uu4A0C7gsT
         2sMS3kqy+ZxQbpFuumqdU4+612YtiueNANTIDOwE+FEAtPelYu0PgHOPE045d1Ho5ohr
         FEveScJsakz1S3uANfKyashuaOCIMG6Cz7I9W5pej8sJ1S7E2VKfjC3dkhdFUuPHSpfM
         LybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138629; x=1746743429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQPL2VUJkkrYH3B5AKeP1PZEpyMagTH7pOj/MvkjKRo=;
        b=kSqjjjT5EYkyl8KquDHF12rwwLghAAorhlBzTkpUEWVjK9coFOndepD94lpDNgv6Js
         dryhU+QuK7sifjLZ7HaCaFGq8SgyFMSucrdx6uGcYazg2dKJ5/4lkY5JIGAct7KvQ8Yy
         nHvo/ilH3gWeXZ4ku3QTRPjL1B/HZoG2OSy5UKTvRZCMYR0/PMMnHBBc+XvVl7mcKck6
         DgELi99UMA6gqbr8q5egmCXlXggjkIPwSOsiTk3c5PFPjS87WklUJx0tEciFia6YjqxU
         mg+oosIuX29OrLjpLBH/bUhGaOVEQL8bJtGEoLpsSaSqxtip+OANKSzI0ocG3192dHmE
         N/Lw==
X-Gm-Message-State: AOJu0YwgPiWlirt07CJEUqpa5AcH6VtPIz4lXjmTVf2mnRtLKjGhPizb
	vH6ixj+bQwYIrmnVrv1m5OQ4EgmfuYBEQGfbFIeKDdPCGmIBuvWJCU/jmg==
X-Gm-Gg: ASbGncs4toYVi1lXyoweS5sMsVr5zJxJZ1r0TBRHBUalT4Uod7CTNeSejk28b8UHOX7
	5kXbAX1fHp7I+7vk+yTRsfSQjpAODND+cEO7vfVN1LDGE/6G9H+zCPRpY/G4UtYeo/rm4uo1Xg3
	c2WQmu/4RgLtlnO3nDWOMP9deuM99QJoMyLFg9PuSXkI1d5I0xBovQ25uREFpxun09QlsPM1StL
	dRmIYKZuCBPJTDI+S0bKHtDwZGXmN4RrBA+OjAk/a3l+SyIhPVCRT8O0P+D40G6xeKV92YMjpzC
	0Y32j5h/slRCcjN1rF/uinscbizLrbs=
X-Google-Smtp-Source: AGHT+IHTgu9Wr1cCTre9U+RrL1ktTgKtFlfwrrgBx6OctfeN4YxpCpA2FXAGqwAbuFcu/h+QITmXIg==
X-Received: by 2002:a17:90b:4986:b0:301:1d9f:4ba2 with SMTP id 98e67ed59e1d1-30a4e621fcfmr1081524a91.28.1746138628909;
        Thu, 01 May 2025 15:30:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4763f992sm1448493a91.40.2025.05.01.15.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:30:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v1 3/5] bpf: net_sched: Make some Qdisc_ops ops mandatory
Date: Thu,  1 May 2025 15:30:23 -0700
Message-ID: <20250501223025.569020-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223025.569020-1-ameryhung@gmail.com>
References: <20250501223025.569020-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch makes all currently supported Qdisc_ops (i.e., .enqueue,
.dequeue, .init, .reser, and .destroy) mandatory.

Make .init, .reset and .destroy mandatory as bpf qdisc relies on prologue
and epilogue to check attach points and correctly initialize/cleanup
resources. The prologue/epilogue will only be generated for an struct_ops
operator only if users implement the operator.

Make .enqueue and .dequeue mandatory as bpf qdisc infra does not provide
a default data path.

Fixes: Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/sched/bpf_qdisc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index a8efc3ff2b7e..7ea8b54b2ab1 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -395,6 +395,17 @@ static void bpf_qdisc_unreg(void *kdata, struct bpf_link *link)
 	return unregister_qdisc(kdata);
 }
 
+static int bpf_qdisc_validate(void *kdata)
+{
+	struct Qdisc_ops *ops = (struct Qdisc_ops *)kdata;
+
+	if (!ops->enqueue || !ops->dequeue || !ops->init ||
+	    !ops->reset || !ops->destroy)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int Qdisc_ops__enqueue(struct sk_buff *skb__ref, struct Qdisc *sch,
 			      struct sk_buff **to_free)
 {
@@ -432,6 +443,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.verifier_ops = &bpf_qdisc_verifier_ops,
 	.reg = bpf_qdisc_reg,
 	.unreg = bpf_qdisc_unreg,
+	.validate = bpf_qdisc_validate,
 	.init_member = bpf_qdisc_init_member,
 	.init = bpf_qdisc_init,
 	.name = "Qdisc_ops",
-- 
2.47.1


