Return-Path: <bpf+bounces-43091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA29AF364
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA5A1C22D50
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF84E216A2E;
	Thu, 24 Oct 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NiVv/J4U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57859215F44
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800816; cv=none; b=BUZc+y4jW3082P+l4Latp88Wop/OCTbc462rLjZ1jPv8hSG8Vw0BdAiUxU1bTdtbJE4CdeH2oiWjG6KE9ShEOx+5YbIIBNlQI5nycq1cgrENj6OVwqoTovcn03X41T64TneifLSJOuEgBp3BRyn8YIV0na7QE+M4/S4LcKSf5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800816; c=relaxed/simple;
	bh=YhhXvISpJMWCXVvLvNjHR458pcrDK6bXpeotwCF1YXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rS7zcm2psbi6O27cZiaaFpdS4+OD/DN3THGtRVBWLI1VWdq5krpJ6TF+FGv/oMqOzGEfjIQcbEcQ1SyRWhOKS5i042/QfF6V9dm69FdcR6SOMhQz0mKOxp5PN8Qw8FjUQRsIYMBPeKm4D/t1MZMbGScbuIjn0F2rhhX6TEmP3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NiVv/J4U; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b15416303aso86469685a.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729800813; x=1730405613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmC3XN9L9q5o4DPFsKbMiWTFpube/+doeBhQaM5ZjWg=;
        b=NiVv/J4U9TWFDKkeY2OdW/SRcaPnxnpwEAjeAcpa2T1lWVOa0RDTABOs1IJnNfsOBU
         1TQsW55zmmUAkk3oyPzx21PuV1oL/iwIQM7PcxYmwZJmuvM53yuPPvJrsMsbjF1vaufX
         JTauX99RCg7x8xjTI7Hiw5Aw9XvJMh5DyxWxm8f6oarRtY70naDHmgNiVPCVmmTq5ANF
         Brj1rPvAcy/ldkSYtIZr5CsarO/wwoff7AqNmvcTBJw5GIgnXszoh48JWRmsqIWPbfVR
         VTZ6ylohMUeRHXeu4heIhepMNLyPfArEZSniEUz0o5FhYQsW1+swsryiFbkPUHHLdYhi
         wuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800813; x=1730405613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmC3XN9L9q5o4DPFsKbMiWTFpube/+doeBhQaM5ZjWg=;
        b=wS8qEx9wVTMr0nx6dE3yscizhMpcgk7m5A1S5IA4W4HnJ3nuokhmcYxv/rNDrdWW2c
         hNdfaPMhNatd3H3VY1IwKhsTOpqp6Lkj2Sv6F+3DVUs2W+cxcUb3At9nAQBMZ3Hub8va
         cJrAPrjD6G31vfT/c076+V3QKxi+/Ex7uel5tftjdfLZigAQAaSpRDP+FBxbrXp/Iw76
         JU5vVmEaH7ldEZXxJMz26Tu7uxZQaxRVURYv0+Xl+GKq27d0anJWVacUAJaH0IfmKFDz
         ox5UftoibNzLixQY1/vOP9oG7VCoOdoF5Zefwl5GOJm8VZs+/f4KSf4y1bI8YXtH1q2h
         fhRw==
X-Gm-Message-State: AOJu0YzjF3S/U3WJVryHDlWz8Aobn/742GO3OV/iJ/YirRMa3w5ivp5K
	aBqcuBJVRrMhGGry/l1RlMXk7woDpDKE7qNaHp5kO3n9ymaXqRPl9vkey3a6FxLgg1x6s+f2GxC
	q
X-Google-Smtp-Source: AGHT+IEviN94HfnuMA6wQ7PcYqk6tqPAt9c5uJDkDq97057FsJJcoYVS+h+Mf5YsR7qHyReboIYvRg==
X-Received: by 2002:a05:620a:247:b0:7b1:4fab:4413 with SMTP id af79cd13be357-7b17e5bd41fmr746423885a.60.1729800812619;
        Thu, 24 Oct 2024 13:13:32 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm518952785a.60.2024.10.24.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:13:32 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	zijianzhang@bytedance.com,
	cong.wang@bytedance.com
Subject: [PATCH v2 bpf-next/net 8/8] bpf, sockmap: Fix sk_msg_reset_curr
Date: Thu, 24 Oct 2024 20:13:06 +0000
Message-Id: <20241024201306.3429177-9-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024201306.3429177-1-zijianzhang@bytedance.com>
References: <20241024201306.3429177-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Found in the test_txmsg_pull in test_sockmap,
```
txmsg_cork = 512;
opt->iov_length = 3;
opt->iov_count = 1;
opt->rate = 512;
```
The first sendmsg will send an sk_msg with size 3, and bpf_msg_pull_data
will be invoked the first time. sk_msg_reset_curr will reset the copybreak
from 3 to 0, then the second sendmsg will write into copybreak starting at
0 which overwrites the first sendmsg. The same problem happens in push and
pop test. Thus, fix sk_msg_reset_curr to restore the correct copybreak.

Fixes: bb9aefde5bba ("bpf: sockmap, updating the sg structure should also update curr")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 net/core/filter.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index fba445b96de8..00491ac4598f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2619,18 +2619,16 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 
 static void sk_msg_reset_curr(struct sk_msg *msg)
 {
-	u32 i = msg->sg.start;
-	u32 len = 0;
-
-	do {
-		len += sk_msg_elem(msg, i)->length;
-		sk_msg_iter_var_next(i);
-		if (len >= msg->sg.size)
-			break;
-	} while (i != msg->sg.end);
+	if (!msg->sg.size) {
+		msg->sg.curr = msg->sg.start;
+		msg->sg.copybreak = 0;
+	} else {
+		u32 i = msg->sg.end;
 
-	msg->sg.curr = i;
-	msg->sg.copybreak = 0;
+		sk_msg_iter_var_prev(i);
+		msg->sg.curr = i;
+		msg->sg.copybreak = msg->sg.data[i].length;
+	}
 }
 
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
-- 
2.20.1


