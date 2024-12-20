Return-Path: <bpf+bounces-47479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C169F9AD8
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B695168FED
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C1F229127;
	Fri, 20 Dec 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTHratCg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241342288D6;
	Fri, 20 Dec 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724601; cv=none; b=RydAu6ebdOHvuWxHL7ltofn4aqNqt1EuBnD+eB7Id/pYUITfj9yefL6md0LMVqi0aieUd0EkwAEdpg+rqgwf/OXfXLgxLYWy2MisLP2+eOyGXnXDzu6gR5Hm+OOZYFt2MTqqV9bbLfTGUYknedVlYoyT6Bg0ZdlJKzXOY7IJztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724601; c=relaxed/simple;
	bh=AuQ3ZCg2NNe30v+Ze3MFue3SVQxUbW9Y1NvlIhdZxK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4jwcrtZYO7KiwsN5g8x0zo0CqHbGFRpESdEaA+A4Dy3bGwP4uudwqK0PUZMKABnSerJzEwLp7aLLnBIueFaFX5IM5NFwix5fgEjQ1nT93mLNAd5C72JWghNPPMc9G0RWpeZpUnt5PGQxFPKdkN9JZeEwiiAUrMEJL/dMb9qUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTHratCg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725d9f57d90so1805536b3a.1;
        Fri, 20 Dec 2024 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724599; x=1735329399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZLKP2is0OI6w79iMXmmz62S0UgMKX3j5QlN+oXd+zM=;
        b=PTHratCgf/TxoYxFdoKJA14OazUYaJZLr6acif59UHcybZj9ypRfEDIy77LXWkF7H8
         eDaYN+WiLBtCb3DKZNrNvWra15HqwADshGGsxbvuTkxx/Yevylg88AB5+VUnG+IkrJe8
         NARdgnoNJNL/MFPhsN7Ng3lhO3D6qK78+h3ZjUZR4wQYaj4+oOa0Q/b1QCpKwdECg60D
         t/o9lG/Xn57NQiSLivR4vxF5JjW/IrD/KqkZHWcB3uvXJthbfuZVmIh2U9EUYVItfUDA
         JmbZitZ11tN4HWi4gxv3AozRgXNePu89qY3JiRJbHjyz7RE1gFJh2+lTKcnA+raxYpBl
         siwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724599; x=1735329399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZLKP2is0OI6w79iMXmmz62S0UgMKX3j5QlN+oXd+zM=;
        b=hJCzWnQgvhXIUPOae/6KRhxMFT0pNykgywLsd0poDDdpwBLZyRYgOho1cvqZL2CyyW
         9S3LuhWvrMShXVBgHcl1Tr33xBSw6n7CJe4nmsU8MVwH9LcmR53KTzuX69fXoygzD3oB
         l1zdPaQPN0ZRcQJSV+IanGDYH+3yyeNIul5opb/bBbWZ0l61nUhdzNOPWCTC8QH6aA0Y
         kaAUDyXwpFzFyYekobXylvlkn8V3gnymM+rRy7T82HCGFf+KQ+yheNCCTnUlQCeDNrJM
         +xX6mb8zweTq7D2GSagL3XPLxNTa8lMujV6mH8prrTOgO1iSzzYmIdI/rI3hkTbKiNEq
         uB0w==
X-Gm-Message-State: AOJu0YwwPIcWRHxSZtR0uknUu2v4Mjl5W3Ezd0wP2iouE2Y5fP5yB+qI
	Ih13UgZcxxHNXqOqzWfsOaCzGZbPm0aj3g83yMBR0baqqc+jPE5rmJnCXg==
X-Gm-Gg: ASbGncvu8kDKdSYEZO7iUggPf6WaLIGIzkzgnHQwkrx1NEnpew+6uRSdVc8HBstLJEb
	kN16Ip0dUZ2bwspVdZ/mUj8vAfUp0Krmtt+LnPqgCyUI7DZy7qRR9M7rtBo/da62Qz/Yk+JCVWy
	CkR0RmfvS8PMfWuCmqSF+X9+FbQWbKg7NpTt5jCIME9DBpXQkqOP+EMegnD8vbFGx9am3n1XhQB
	s3mXjD3BfKCOaT9ySBef0ut/mqF4f4v+irF6FhN3kFhtwbe7nWdsAjd1Jal3PyVAYpGGddVL56m
	4/z9+wT/7GfmsEHR7YQPyNQl9Upha7Qt
X-Google-Smtp-Source: AGHT+IGrOECkEeVN4/8ravghWHofV6sc1P57PrfWXiTarVoU3iXl9AP276ivf2YpYODlIFb4JhllpA==
X-Received: by 2002:a05:6a20:e68b:b0:1e1:72ce:fefc with SMTP id adf61e73a8af0-1e5e05a9edemr8395718637.22.1734724599215;
        Fri, 20 Dec 2024 11:56:39 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:38 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 11/14] bpf: net_sched: Allow writing to more Qdisc members
Date: Fri, 20 Dec 2024 11:55:37 -0800
Message-ID: <20241220195619.2022866-12-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
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
index 04ad3676448f..925624c47c3e 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -65,6 +65,12 @@ static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
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
2.47.0


