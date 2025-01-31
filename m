Return-Path: <bpf+bounces-50235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F9A2435A
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044A6188ABD4
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E801B1F4E3C;
	Fri, 31 Jan 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2LXlrWR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F99B1F4E24;
	Fri, 31 Jan 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351780; cv=none; b=EGG7g0TYfcpEIWZ3X6iRTa56abGUtFP6zJpCfvHz2m/4DrYipv7IfeTvJYcr2m8uW2EXtcYkvS4G53AWzLYv60DG7ywKrf3c8JlTgoBUCnAqrigcuo42O697A1YcaGUFJdOBkkzyzC1aDeivvWNq1vJ027tNrrtxzPihAmYYiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351780; c=relaxed/simple;
	bh=yLFNWHhOTiarDSo9Sp1rvBts/yC/10vhC6dx3FQyXNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHHvGEx11URKeF+E2BBN2DPjTg+u47T4eU38gOwBA6VlUSokJg0PA5TTz1//lcoJ/3aPeaSpin2UXmBXCI8afg+ofGl6taBxiK4DiFLVQFMBx/fu2Tm15tTgM4FsvFeQSYsn0pOAeCxCHkmh1gN0nV8gdtGf0soak9WRDs2w3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2LXlrWR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso3239411a91.3;
        Fri, 31 Jan 2025 11:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351778; x=1738956578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbaWVWR/t9s3rvWCPWr9riionS64waNGKaWVDFN+gfw=;
        b=i2LXlrWRI+kF35/OfingDg3LTUq3BxSetnHUsJSpbHYKFrU//KtRyeaKH0O1u3hODs
         MicncTtDe4a6SgR+wj/Slx84exWoGXbFIEOg372dgkc7updvEFphi2hicQDgHs/UT7HH
         bfP04fiDsNWAMbkbDSClHd4EtAt9egbfSFxbMDEwLl3J435fqY1DvD1bG3YRcrWG4sYE
         TcAoIFGDcyvSXZ0dK1qSd2LnPtiqfMMLgWQhYwumvDG2+YCn7OMTbBYb/u+E7+8wtMWP
         KPqbc5iR4bkK95gqhNEGuT3BAQEbVd+nAsnz0p1SRwi89JyQKYZ8D50L/ovSwpeV//7P
         kCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351778; x=1738956578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbaWVWR/t9s3rvWCPWr9riionS64waNGKaWVDFN+gfw=;
        b=Dfhcw3c3UUxteNpudniqHYb/vJ1/N2BCYpP2oiO9B9PArLXTzm7uAx5cocuv5BzN/F
         2bXdUbtbfrskk8HasI2mRmm15K5e3MdajW3lwgKERlNzOelBS2FZKKVYPyk4U005mNWq
         yTETk7UR7JWv8Ist+MpivQhxEdxqdTZKeDg7+dNXKjJibME3trbPv9DmVHO16G7XQpdf
         mp1v1hxxgDmKZbQVe8APasD82wz7nQx/gMzwv8eiiPBST4jAagfwbPaj+zYSt7c4xcAS
         CNA4Kx8XD0pIDzEalLw0nlZT/WW/lpx4TalDtA7WTYYn4RtoyaxvETnJ4CoSyFO/5cHh
         lk/w==
X-Gm-Message-State: AOJu0YwUjadP3wEhFFGYFbKPn8EEMjhDmgXeY6m3T9HpXMf/1JpzLI1f
	dQwBhueuBixzI382cPRzDbcJgi+vLmzsv2Ms7EX/UIY0koaNp8t6KyvIOIDwOpQ=
X-Gm-Gg: ASbGnctgRYW72Mr80wzcGRo5cJddT8NnguqXITj4zyiLENT8m8aB/MC7PgydloHvsbA
	l9Y0ce0FZfNsgDjYokLP7qut3rCQMro2GFeL5xxrZWEjjE7BCLN33c+ap6kn58DP12scBIIFEu3
	qXUZLFDlanB6eq48nIRS/bcugaxVYJKwQFAVd1xMV4mftbQj6vYdsVW3StvzJ5z8ClccrAlHKM7
	fzE7gEEG1eSeh8psFgcvdsB2OsjpaWSzZ1AxoA3DWqa0EiAPNsEOLwXYZmhyYkYYF5bvLdu4Alk
	kGmb8KnWpLSCR/0CoPkTzWsECu46tvcinG4SyS1PbmpBNKHQEKuGKiZVFqOZcdokjQ==
X-Google-Smtp-Source: AGHT+IFu8HWzuVOZ1Rz3rEV4JKYix6XxyoSSJfcBCf5ZmgRj4hznKWqOf/sWJHUduTI6YlArLunnEQ==
X-Received: by 2002:a17:90b:4ec3:b0:2f7:4cce:ae37 with SMTP id 98e67ed59e1d1-2f83ac00165mr20647338a91.18.1738351778350;
        Fri, 31 Jan 2025 11:29:38 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:38 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 14/18] bpf: net_sched: Allow writing to more Qdisc members
Date: Fri, 31 Jan 2025 11:28:53 -0800
Message-ID: <20250131192912.133796-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Allow bpf qdisc to write to Qdisc->limit and Qdisc->q.qlen.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 2427343d8a10..b8f02ff8734e 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -68,6 +68,12 @@ static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	switch (off) {
+	case offsetof(struct Qdisc, limit):
+		end = offsetofend(struct Qdisc, limit);
+		break;
+	case offsetof(struct Qdisc, q) + offsetof(struct qdisc_skb_head, qlen):
+		end = offsetof(struct Qdisc, q) + offsetofend(struct qdisc_skb_head, qlen);
+		break;
 	case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc, qstats) - 1:
 		end = offsetofend(struct Qdisc, qstats);
 		break;
-- 
2.47.1


