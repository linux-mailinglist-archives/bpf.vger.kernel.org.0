Return-Path: <bpf+bounces-57282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A6AA7ABB
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899901781B8
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B941E7C1C;
	Fri,  2 May 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1DbSHXP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FC1FFC4B;
	Fri,  2 May 2025 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216990; cv=none; b=RXhiSUSRKQe1ezuZEjl9jmIH1e/o919SSEwc5vHSfP010+kpJhVwvlopjvxmLHkHx1JxV9zPpTEvT1rxIBN+XRuZ6vBz4AOl6pYVMzk/zh9tWt+5il5d61Vjjh/VcdgwKb+Fwwjn48ueDOQ/NhCipbZLsJRedeMoxXUcc1M01us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216990; c=relaxed/simple;
	bh=sPAoZ5v8EV5ThIzG5JgSPL/BClqB1gRZR2TqojgG7zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWXeIw/jDyMQk/jwYWRIBdH2ME+5CxSYgzD+oygZBJ2xipx1JE4eRvFuWCZBjwVXlWQwg7wZ8rBbQc2lyGCecV9kDn9JfNy/87Bh+wV6TCJP5bisb3qqhqAO3hyATNeKkeb4jhWQGF7OUDChkhzDljw2Q2sgPWNHd757mFLRLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1DbSHXP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3705168b3a.2;
        Fri, 02 May 2025 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746216988; x=1746821788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h17nlqMT8L80P7Q8ICigMmkP2aNT4tFSiFhkeYN/QUo=;
        b=g1DbSHXPNYW4aUxmpx2wyW5hSAM/mxq9ShOtV3yRzGUwe19Zcwmrnji/X/w1ptiHKz
         ItPV567+jlm5sdjW6yO1VxLDXmB9HKwNXdU+CFDCvP4pG7uwHpELUL715mwDhmbIvzob
         l5XZRXy8/JHamXcYe5PFtlopPLaNVRSPB/xdX1WdUHWIr2P066hVRehtGaAm6Ac4Pw0V
         2aCVw1l9C7rVTe1VNOlS0/KhmmwnRHoelEjAX3/dKunGJMALmixSb9vLHGEKf58A2Lgi
         ohwCY+8h50XgZ2jdHK231XmFws8NadIwhOvxI5jMQi7XiyHe2ZU5ZwsVTQP6Cp1G+/WP
         tqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746216988; x=1746821788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h17nlqMT8L80P7Q8ICigMmkP2aNT4tFSiFhkeYN/QUo=;
        b=aOIwFqBt+QUqxgY+9cgAazzweNUqexpOmWcU8AHdJmHbdZHPgi4iVbQfpp2/YX+DE+
         Bz2z4GZWaQY1S4O2vc8s7NTca3EhQOQFD8cjOJ/DgwxwAnqwDPbjhQsJe4ILsWgGoSpA
         q/8hhU0S+9Zp3T5gk0niCR/dMAcUugCq030p6/wiXCd1dq773l7fY/H/vP3w95ZZPOVs
         8adiYxYpVV9butfy5deUmvbZ3vrhLV1MIV/9Xi9iRVaHVuMYcZdYto7rZKrd2sKBX/b2
         OQl/Vz1+mISEid1pZx7vxAYUTMytFnUC+W89Fe0GzpfbIlCCeyJm3BKyARZfCjyIgs7K
         FaKg==
X-Gm-Message-State: AOJu0Yxhmq2T0ZdHGaoFtWAz49ZHjlXKD4oR+a+mcB8++Kq/dt3NvJb3
	4l8aSqZhZDXcjJrOgStd4zZokykxAZmVExBeabwgJB3GnMOYvAYQRe2jFQ==
X-Gm-Gg: ASbGncstAHvdQVoyhHKpKudqUN90F2cGxbetAatEVJ8WANrU2LNUbTf9CjHJUMaheF5
	oYBCSdlW92KW0GHRY/eIN4xNaIgcCINR4k3QflHyKSQ1oyxKYYEhFYtH1ZLnKfoZOL0NQqP6j3g
	zV506NsJ3d2q4oA/zotsoM/7caQYI7SyHZCdQgQ8/+uNcxW9pafJ7qZGjoAVTspyq+Iyg4NrY6s
	trlRUHHdvpGN5qgxr6HAdWRtkGu7qza08SyOeyzoipLv3QA0H6vP1CjP++8KEsRvDP9C0w/GMHY
	2cd29cKDl7KGwVUqfAv9Mh0EEfpWzxU=
X-Google-Smtp-Source: AGHT+IEweH86uC30havCbwPr7p/9th8o3uUonZ5IEWyhYFlhgnCY/i2I6HwJc/6nvJPhreoN+isVpg==
X-Received: by 2002:a05:6a21:1fc8:b0:1f5:86f2:ba57 with SMTP id adf61e73a8af0-20cdfdf4e04mr7997679637.30.1746216988315;
        Fri, 02 May 2025 13:16:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b7c5b8sm1051444a12.39.2025.05.02.13.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:16:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v2 3/5] bpf: net_sched: Make some Qdisc_ops ops mandatory
Date: Fri,  2 May 2025 13:16:22 -0700
Message-ID: <20250502201624.3663079-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502201624.3663079-1-ameryhung@gmail.com>
References: <20250502201624.3663079-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch makes all currently supported Qdisc_ops (i.e., .enqueue,
.dequeue, .init, .reset, and .destroy) mandatory.

Make .init, .reset and .destroy mandatory as bpf qdisc relies on prologue
and epilogue to check attach points and correctly initialize/cleanup
resources. The prologue/epilogue will only be generated for an struct_ops
operator only if users implement the operator.

Make .enqueue and .dequeue mandatory as bpf qdisc infra does not provide
a default data path.

Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")
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


