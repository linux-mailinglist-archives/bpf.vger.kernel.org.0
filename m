Return-Path: <bpf+bounces-43100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEB49AF3AB
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1768D282DCC
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9278F21643A;
	Thu, 24 Oct 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZQfG2db5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CF1A7ADE
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801793; cv=none; b=lHdR5OC1CgQx6+n2nIR2UxgfwhI1C2FGkdqxFv//toddnSnYp7wYNE4XjX9FDojprtoIPSCF2aeiV6R/LWu8F5lBGbS2tnnh/baaIP8g804WK/FauQLzuxOOLe+2T9VYg3KmDQPb02ahu251A1f4Im6cJTHRhk8Q78Nm/hxf6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801793; c=relaxed/simple;
	bh=YhhXvISpJMWCXVvLvNjHR458pcrDK6bXpeotwCF1YXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLxjQf6FnY2o8TZDBDdS7y3RV3rrET/2P7pvuAK9cqpi6v+2QayRsojLlg+e8naQMMauQqllmlVVMqV+xnmPjiawNubG2+m8Tufao3GHE0At3DHgj6MyQp+8vNWbdxStXBF5979YphlyKBk0ESh1NctbCL7KDk6x8vT+dG1Yfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZQfG2db5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso1531441276.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729801790; x=1730406590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmC3XN9L9q5o4DPFsKbMiWTFpube/+doeBhQaM5ZjWg=;
        b=ZQfG2db5SCJyZ3A4inuGQ5bWiJ9kXFkjdB/SQEV8CavZVYS+PUYgiujYP/TGgUJ9vx
         RiDbF3vXzBzyoC4QqSoCQMPLJgr2pNxf6rxWhi0nBut9D7MCK1ERy03esyLq5+S4OPxG
         fo0zBnXiDOZ6R9S6CL6yBWuAkqP984OqhQg4/Xv22eqBKpwpFGKSRoS4PMDDPShSw54o
         G6tCuc32YYonpZFA5YiVoX/RWwcMsNFDDRa0z+63gDFnyPF12rof6l7a2bUE7c2p3V6j
         owa5hy8GWAxaQuZVHozDyaP0EI+Y0rNPSdTsSoD7wXgcHcqOts6ZM0JJKZuqvlUmP2Ah
         SZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801790; x=1730406590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmC3XN9L9q5o4DPFsKbMiWTFpube/+doeBhQaM5ZjWg=;
        b=X5DDwvqu4bWMsiR44OGznkH6hUbk4WTUlFyPPns4bWMgH/jk8TWjMPuPt5TeWHwOXA
         iHTvRsR8Ba2RZDX2FJuye1CwQgwwDywWKCDZKhkuZOV2OWLA08RZwQOQVMXIS5raS0sf
         tH9HkLA0l3GewOipEfioQgHb+r2GKlMZF2xwg4n8qqiwtaxw8KSOVMkjb0IKVI3wZdLq
         S3tKwG9rkxAVQO41fHqSyEJMNscePy9z4LA+JnfzgtKhzfgpzYaCcsl+nB8L655Ar+/P
         5xvJBV1wvdHjoZS62GUrdzPivrfDEvtpiwEQupvHcUxZ7MjlYcQFo2BjGCMjNCCIhz+j
         2yqA==
X-Gm-Message-State: AOJu0Yyp0Wt/dOQJphQ7G7DgZ5kbW/DK0wPGn7xLesMYs+W+gTJsFKde
	T3plJS0RnOqnQf059UfXYEU8BE3urRHN9kTficud9tjRmSnpqNdJpMUw7Ttxqf6xS5mPBrlnGRB
	6
X-Google-Smtp-Source: AGHT+IHdKRnD6nq4tKR6kxYLy+UXquO5fzi88lVtvUqzHwDmX60LdHGAq3+j//jbe+2pIFRlXLYmVw==
X-Received: by 2002:a05:6902:1026:b0:e28:6822:a280 with SMTP id 3f1490d57ef6-e2e3a680695mr9235523276.26.1729801790005;
        Thu, 24 Oct 2024 13:29:50 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm55486081cf.52.2024.10.24.13.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:29:48 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 8/8] bpf, sockmap: Fix sk_msg_reset_curr
Date: Thu, 24 Oct 2024 20:29:17 +0000
Message-Id: <20241024202917.3443231-9-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024202917.3443231-1-zijianzhang@bytedance.com>
References: <20241024202917.3443231-1-zijianzhang@bytedance.com>
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


