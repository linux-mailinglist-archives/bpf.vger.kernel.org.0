Return-Path: <bpf+bounces-53991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B0A6006B
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F60881035
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2411F4180;
	Thu, 13 Mar 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnDOkxOD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4A1F3FCB;
	Thu, 13 Mar 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892609; cv=none; b=NkG31UyQcxNRQ4157Yixy5kgJCqUpZr0hQWH3tBSMrq/SZzeUm/Jet551cLr4IEiJElk6LBzfPQmKKx9H4vEo5tX8LPfXTCd9UrJ28AXPHEbaqOHj5N4pZv0iiGDoDUvtUfivH3vMdBuGfTL2PD8qeGsSE4KzO6rXFurejRE0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892609; c=relaxed/simple;
	bh=oVv2JtaDPIKhZsdywXA46ACT2BCLo0/oHTOdRQDrkDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HENwQ5gVOT/5J6d30tVMSv+hRY9CL7kpzX2xyuYuobcdtCH/W/mvevFqsqfapLOuK2kizxkwLfiEftVtC29ugXzVoMhO/XtfnC6lWDr+Ody8QwyGSwuyKmbQCIjvcs3LL8do3L0ZRaXwGrSQc7GPbVPwNL4IrXFbFhcyVQTJ9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnDOkxOD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22349bb8605so31092855ad.0;
        Thu, 13 Mar 2025 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892607; x=1742497407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GH5rMBh11R0Ev4mXMfCpLP6RKJCsJzPSkJfSqyVzrk=;
        b=mnDOkxODZsXOTZQ9qDL8iiPkQaMHPGMHMiPcbpP93+afrz6tS+LrSnnkEg1ytNKnIh
         KznVIjf4s/UzECDUj/EIDS4dQ5hZbcRa9eCuPGBh/vMVLwTSI2qB51znSD8OObV3Tgkw
         UUo66bqqMcGdHEYMZMYJu8kMVZeu8gwnGMj69iljI0xLohHjiq/XZVTILxpAXT0z3wbm
         NtHV8pOWHwRLMEpQCOpMq6u/TEFnb68aXw+CJojWooeyT9WjTKx/Ot1lJpeCeELeLBZI
         pWNX7lIeT/GCWovI6PDNEzrKZwasz5RqtyauQMySxvxUAVb5/OBqamJprfQbudSh65LX
         Deiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892607; x=1742497407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GH5rMBh11R0Ev4mXMfCpLP6RKJCsJzPSkJfSqyVzrk=;
        b=FD9yjcnDe4fwgPmWy0shyeGZuGbk4qvX2RRiQPaCj25V829I0NKaV6GWqBW/3K14lT
         dWudkWCoqJK/zsqCfrcof8yK7hTAOPff7HeA4tWXaMm+U2cOj8zKqL9qWPP8lLPjq4xL
         Y+ykQDqFq6JoSzF+LGGi8xkMiMHgFQo6Aq2XlkP1AlakXrGdn6TMFT0i8VN/y8KjJgeD
         MxbXnNOkcv6FTWibm4QNNluPFfgTHzskJvyUXm1YOypMXt+brCTQXbFN4RUkVAsw3ZLy
         2ekbfU+vRW2/16BSC7y9tAKuQim1xLaESebVFv3M6vsGtgtcU6diDb6221v0MbWgc3c0
         2cJA==
X-Gm-Message-State: AOJu0Yzud7xERVn1TEf66AtPS2cgls79KP1Zog7MOSyziJ4bwognnMg9
	dkQYjQtg1jfhsMusYt3V0mY9scVCI5WHhuwbamy6RSm+qsYQTsK9qfHYSz0QUHQNTA==
X-Gm-Gg: ASbGnctED947SDf+RR7CDiSfApzu4sQJDiWTfw8NnCDGLqyjkYmQQXLwhqGyoh9TSvb
	Su0+737HEbH74fxkdyKA5GfrxBTkKoF+GSongXHtXAcVSxPYwc7AUNJMtfTnauruFaAgpZDZPVO
	29L7PwQ10EknVevnPrPeOWTWNyj1etDczHF5r6q33zoeVLetysPsxhVYOPEy3eQFoxWj/nYOH+C
	C/OmLHRTdbaOpAsA4Bg4gbZHahuJXPW/7B40eoK7hDA6NFrfPpjHL2HvCrR5rKcU5F1FDkawxWB
	+LhgKmMKGV5g2N4mPHWGrArKPhZgYtww4qAb42Ngmd3yUOfhfIeTkhwnxxfE4GWd4kSJTgqfjSH
	UxWusndFgozwjYk9znqc=
X-Google-Smtp-Source: AGHT+IEaZLQ5SVTNwT5WE9ZJPQ5WCSpIZ5M8IeqsbZumlsj2hhjlUpxPjFHs6E9RQThKfNWL7eOYbA==
X-Received: by 2002:a05:6a21:2d87:b0:1ee:d06c:cddc with SMTP id adf61e73a8af0-1f5bd8c2cacmr1377381637.30.1741892606779;
        Thu, 13 Mar 2025 12:03:26 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:26 -0700 (PDT)
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
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 08/13] bpf: net_sched: Allow writing to more Qdisc members
Date: Thu, 13 Mar 2025 12:03:02 -0700
Message-ID: <20250313190309.2545711-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
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
index 6ad3050275a4..e4e7a5879869 100644
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


