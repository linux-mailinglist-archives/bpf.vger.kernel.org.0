Return-Path: <bpf+bounces-43088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE29AF361
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7C21C22EA0
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1962216A19;
	Thu, 24 Oct 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JLrVruR1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB41FF02C
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800810; cv=none; b=N7ZThyYRPDZmzpe+GWrYWivVD6x6fs4R3QvCbQfTpgpcdjdkWfgHF3er3i7ooGU1nG9VfUUIsVkplmhx3o6kGzV1VDykfC71wWu76FmAuxgjEZWXoyYh0SpJBzbb8FFvAwMSzM6Mjt4xm1lpRfdi0ki5fzTA0YYVQqjh90hh9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800810; c=relaxed/simple;
	bh=DWOwti3vm2u8IiCa72HOjYzsSxbb+cx9lsbchIICfoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnpU3Qv8Ri9z9MzoUcQV3B8G6eBMqgDNfe7YhxfAOAVNpnDL4a0UyX6DewGiCMRW42QuYYX05CoHLqtsYwXFMCf4ZtLMq22djJeDEHRiX+4GumoMfs1UpEt+7KZCg/hS3B4s2H1lI/5TsqsMR06cGoXokJqbXvJA68B9TW/peiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JLrVruR1; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b14df8f821so91530285a.2
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729800807; x=1730405607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCg7gaVwcg2dVZWa8iWS8H1cWuO7lQC9V7PJRVhPL+k=;
        b=JLrVruR18HOJY/HEI0WNX1B7OVdCdHySy/l2Zgv31zOu1lKdJiJF6cCvAPCT/QQwPB
         LA0JOfNCFMu7gwJYarZeWvf/4c950f3agy0+0f8mlzq/G664oqZ3MpmyCxH25x1rKDpQ
         XWXsFg6XeYlgxtTugudxlBB3NcvYGmPOSX9wZATX1h2qIZkR/WDqsgWU6rSI6wfQb7AJ
         /LOyCfeSvfj2H733baOHZXHRzCnK406iWuDFRnkW7uQ9Cwr2uOCMpZO96WHfl3LBEw/q
         vhhVb6n48MJbihV6nvJO6e5W+58GaAjv2RlQYyZxmTTHmS2NdYwpu6uSgWNp05aoBUkK
         sfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800807; x=1730405607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCg7gaVwcg2dVZWa8iWS8H1cWuO7lQC9V7PJRVhPL+k=;
        b=t2ycRAvSeS4dEo2tkKZdupBUmldJ6DALn2KUoI9tlTYY3sbw32qoW1w8noz4G65Png
         HFuGiObQ7v/4NPvyyZHYE6l5keU2XZMpUhq+hP6DOuhmQNiPHustKy84f3cY1S/HbWmR
         cJ/PVTWBKR40eve9I/bVqH3q5g3GZn77fJr/2DpFIjTSzeJO8q2LkZotry33HnX64KHb
         idr9pZ9NSqj3XTcVWlT4xB4fzGI+NsXKsXakcqLmgw5s1jPl5HDhmTlZhfB3P0YzEyXV
         giC7WQfl6lQWtGOVLBQ1trgtRFXmmfrUBPpHdqoialqNbeo6gzW4jNVjS0W+Nl3CLhCS
         y0EQ==
X-Gm-Message-State: AOJu0YyAn25AqESnZbkuWe0c05C3mBPyg+skWQ6kVP+Je4xs4O+pvNOq
	7iJRB+yFBDv+iLvgzURlpkoInPvh8HisBccWVlX3wtEYNYYbKYn+oDlblqIB1HfFBYvY0j5mRnU
	M
X-Google-Smtp-Source: AGHT+IGetNnHHaAtemGnd4iIDKp1df/mwvQ0tS0XMrLXyEmdn9KJHdNDeVJVyQJvy2LeYyQ3yT6DMw==
X-Received: by 2002:a05:620a:269b:b0:7a9:d14f:2374 with SMTP id af79cd13be357-7b17e5b309emr1045900985a.44.1729800806888;
        Thu, 24 Oct 2024 13:13:26 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm518952785a.60.2024.10.24.13.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:13:26 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next/net 5/8] selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
Date: Thu, 24 Oct 2024 20:13:03 +0000
Message-Id: <20241024201306.3429177-6-zijianzhang@bytedance.com>
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

Add more tests for test_txmsg_push_pop in test_sockmap for better coverage

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 61a747afcd05..e5c7ecbe57e3 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1795,12 +1795,49 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
 {
+	/* Test push/pop range overlapping */
 	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 10;
 	txmsg_start_pop = 5;
 	txmsg_pop = 4;
 	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 1;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 5;
+	txmsg_pop = 16;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 5;
+	txmsg_end_push = 4;
+	txmsg_start_pop = 1;
+	txmsg_pop = 10;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 5;
+	txmsg_end_push = 16;
+	txmsg_start_pop = 1;
+	txmsg_pop = 10;
+	test_send_large(opt, cgrp);
+
+	/* Test push/pop range non-overlapping */
+	txmsg_pass = 1;
+	txmsg_start_push = 1;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 16;
+	txmsg_pop = 4;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 16;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 5;
+	txmsg_pop = 4;
+	test_send_large(opt, cgrp);
 }
 
 static void test_txmsg_apply(int cgrp, struct sockmap_options *opt)
-- 
2.20.1


