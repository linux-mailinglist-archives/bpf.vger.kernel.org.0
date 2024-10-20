Return-Path: <bpf+bounces-42528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE24A9A539E
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98428282DA5
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD7F15B0F2;
	Sun, 20 Oct 2024 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FkzS1785"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8A18E028
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422279; cv=none; b=TU2HzCF/0ot2j2igrJf+AoJREpXMDSE0RTjiRrvcrpkKuE+BYYYfZS6c//Ho7TY+lNfzD28JKVHigl9qfrX6GMn8aWGwGgmwuZ2bUvvMrFapocUxcjBKfzRlWoqSldhSvW17Z4MUJbUoBkz2Aqcv+svQyKOz4UNydTMMLpvTXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422279; c=relaxed/simple;
	bh=kRwayV11hsUGTVOSUuLhMlPf6jprZ0sEf9dLS4nrasM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxC5B9Piu0tZlv8rOA8FNwMUS4tmnRh3gqCTV/GPwImrmkjd77gXqX3fv12nclyeSLD40wtHzYXJ3Pm4JEFAfA9xqf1BywIuEX2ZV65Uc1LasmZsmw8nxROE3oIWAhyF1pZvSwoNJAdYY+ET6TsQ3fgwsdVeVbubqzbm9Wta8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FkzS1785; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1467af9dbso266001385a.0
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729422276; x=1730027076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUCvERanlFc1q+AzssYdf9ytVplB8Xkn9H2PGVZUxv8=;
        b=FkzS17851ReGNYRgGs9SkQEL+GNNT5UD6MqaF73CfgZRKrKRK+K66O5Brsyd7EWPFv
         lPrXaLGf19jbxSMIIGLpR1XMZi8yxeB4FzalsqToxdm/QjAriv+pZcKr2O4zILqhSfOF
         Vfc/UOmrkalkFePaFxiPWkwd1jCBdgQ49x8bMQpdMWu9FyhQk3BgTf18cyD7yge046lB
         99GftBxUb0Q2iLA8M8nAhpnuN/JLyqF4C0jeB6Dg9iIy88St1YAXH/pLTJamnzhK1tyD
         Ias4ebCOUusmiw8tJrVHFQF8m+Uu1LRbnRA+XKoY+VY0X1bexjo+OTkifEgdC1ebaXMk
         8csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422276; x=1730027076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUCvERanlFc1q+AzssYdf9ytVplB8Xkn9H2PGVZUxv8=;
        b=keR2uLaWqH1g+PI5OlAkGbGYZwWpeOYYsm9FOmWaqaztpBvnUiW04L4+xXN96wB/Gn
         H7uNlh75wgqvl/WrtK2dVes6aqGQ0DuyLjd7pUEiJPr+hUpYoHhc9riIsE67lckr+Kuc
         f4sCp7bhWRIrvP0awiUuAoT0dq12OzCrcwIB2YCNLxouS8Sg7m8o1KNMq48iclcPTJmC
         enR6sdOLZAlFdacz2Tzeed31WvTEm+7k2BWWP7bJh/nfsh/NkebmBDiZzjWIrer8Y/jF
         +5PvBKk2Q1xv/FKHktNqgqODhv7G0sG7M0DDByxDtT0bXcpUo8dYLcO43jeaGMxwNcAq
         MkYA==
X-Gm-Message-State: AOJu0Yz2eUxaUbSUXoKfzhOM5wC2UfulqAT8p0qXY6VnyHubC20QDBHU
	CkIX0yu35vr0XJz3qJxRWoe36GTSvfPhVJLXqPLYWFacRutIg6nqC9DB6jaykmcE0Vo1XK/Zb+N
	t
X-Google-Smtp-Source: AGHT+IGUi5ruVOvy3vPhPczXAsL3WivLiNyUOw5iT9MnpHEq4evjHjbPnE3Zzsgu/5iDpxvBuSpkhQ==
X-Received: by 2002:a05:620a:1711:b0:7b1:54bf:7185 with SMTP id af79cd13be357-7b157bb5371mr1064334885a.38.1729422276321;
        Sun, 20 Oct 2024 04:04:36 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm6715216d6.0.2024.10.20.04.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:04:36 -0700 (PDT)
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
Subject: [PATCH bpf 8/8] bpf, sockmap: Fix sk_msg_reset_curr
Date: Sun, 20 Oct 2024 11:03:45 +0000
Message-Id: <20241020110345.1468595-9-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241020110345.1468595-1-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
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
index 8e1a8a8d8d55..b725d3a2fdb8 100644
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


