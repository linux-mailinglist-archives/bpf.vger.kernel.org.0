Return-Path: <bpf+bounces-44171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C69BF936
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889ED1F22934
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40820CCF3;
	Wed,  6 Nov 2024 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X3rgrRxm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C420C486
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931979; cv=none; b=XFQsMU25IwzJ0Bo4N6FvOu+zeUCNv8pBcGzKOJk9yaKRyPizE3+RNNjh5PcTEfDUQ5i1BUKdQWM63fO0IYLmEdVxVhMLzNl+pI43NsQKzYECyki68MfTdmZBzUOa+qHOzWuX3ElfIqWNFl9POuESyfDQEYm2mPwSvaIO2m3/7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931979; c=relaxed/simple;
	bh=vEjvDL/9pRsbu/Y5kaMsh5Pz+1UMjjvbAxje0DPqRyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1344lNoP0qHINZT0KEMOHXMbcPJEfurNUs6iBFzKsVc2nqviDEqWOeKq6SRoYDHKSOOF2m9M6mvWyxC78khQtZxgRJpYT19SkPzTmmyNCHtAgImv5/A2qQFF+yLHOm2Ec4YJkdGiR/k2nbxNjaM6Xa/oEn460IsfjIf2PZ18hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X3rgrRxm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1505ef7e3so20966485a.0
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931976; x=1731536776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eexa5HYKEVjD6R3rV24Gretx25puKESuMNQoJZf1TdY=;
        b=X3rgrRxmdmGBbO4wbWMcSzIdKHcKWt6JST22FPdov87ccqB5eI8qwhJ81zItraPXrH
         NJ1NVnJfpwTlSsSI7qY5RXxVcoUP2jzQM9NJbD4LA94ykYL2+6UtYk67yGWWZ/ke9WhR
         cewi4vcwdZlU6d3LLSuMSe/LRw5EL7VYTcLEZwIcLxVDVjDcL3YQv/SmErSJWA/d9Y7b
         0DnzWhkrauaOQuMnZcq50Qm2BMcxCB6NTi1VPUpSjGazLMwYM3aFiflKXwgWjJ97GuVd
         l1mjfeH6s5FgLUodxt3RLrXq4RrxVQ9ILZJyjsG9zxFplk2xKJi5JCa7wP1NB9xgZ6JC
         LsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931976; x=1731536776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eexa5HYKEVjD6R3rV24Gretx25puKESuMNQoJZf1TdY=;
        b=jv4YCzCc2O1oUj0Xm+eTiY9ikgzVGtQTNqix2qH13vRklb4uxPc4LCTMwvhLW3CLTX
         8ee0hZFC3fwH1D5MDYduvM75ZnopBfQEjl2f5Q9xK4GPoxzA0qFpSp9gureoP28JmwLM
         yBySW9wha4y9jlOPfgNZRy+bP+a8FmKq4CuVmLM/xJ355BVh0tql8pE4HjgNlIm2tZiw
         Z0Ypn1G+QT0bxzxCHMlteKYeif+oygdhVr5py2iSKoEUmJcRozKXvixKrkdESSeYN/+O
         SqpYDDfhoUg+h0viXSj/X8ohKU8Zw0kh3eqA6bcFqleWR3LyaiUWUy+4pjqQNGpvg7K0
         0ODw==
X-Gm-Message-State: AOJu0YztZXqZ56DqacWs7jfS3wKJ+ODPTRg5BbJb3OzdursdlSThOV6/
	jWQHmAjcWkN9ZZuezgQd7w/c3e92mSivP3knvWXHfuTPRzp0omsjsS9koZIQZSGL1jrRCl+UsB0
	/
X-Google-Smtp-Source: AGHT+IGetZqTTQLie0fDUOt815GdjRKTeDYpP+FuwDi/1WHXqOgmx6xtqwZxNrFwJSssoGEjMtlNQw==
X-Received: by 2002:a05:620a:4104:b0:7b1:4fab:9fb0 with SMTP id af79cd13be357-7b193eed9famr5864837585a.18.1730931975987;
        Wed, 06 Nov 2024 14:26:15 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:15 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf-next 3/8] selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
Date: Wed,  6 Nov 2024 22:25:15 +0000
Message-Id: <20241106222520.527076-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106222520.527076-1-zijianzhang@bytedance.com>
References: <20241106222520.527076-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

total_bytes in msg_loop_rx should also take push into account, otherwise
total_bytes will be a smaller value, which makes the msg_loop_rx end early.

Besides, total_bytes has already taken pop into account, so we don't need
to subtract some bytes from iov_buf in sendmsg_test. The additional
subtraction may make total_bytes a negative number, and msg_loop_rx will
just end without checking anything.

Fixes: 18d4e900a450 ("bpf: Selftests, improve test_sockmap total bytes counter")
Fixes: d69672147faa ("selftests, bpf: Add one test for sockmap with strparser")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 1d59bed90d80..5f4558f1f004 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -606,8 +606,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		}
 		clock_gettime(CLOCK_MONOTONIC, &s->end);
 	} else {
+		float total_bytes, txmsg_pop_total, txmsg_push_total;
 		int slct, recvp = 0, recv, max_fd = fd;
-		float total_bytes, txmsg_pop_total;
 		int fd_flags = O_NONBLOCK;
 		struct timeval timeout;
 		unsigned char k = 0;
@@ -628,10 +628,14 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		total_bytes = (float)iov_length * (float)cnt;
 		if (!opt->sendpage)
 			total_bytes *= (float)iov_count;
-		if (txmsg_apply)
+		if (txmsg_apply) {
+			txmsg_push_total = txmsg_end_push * (total_bytes / txmsg_apply);
 			txmsg_pop_total = txmsg_pop * (total_bytes / txmsg_apply);
-		else
+		} else {
+			txmsg_push_total = txmsg_end_push * cnt;
 			txmsg_pop_total = txmsg_pop * cnt;
+		}
+		total_bytes += txmsg_push_total;
 		total_bytes -= txmsg_pop_total;
 		err = clock_gettime(CLOCK_MONOTONIC, &s->start);
 		if (err < 0)
@@ -800,8 +804,6 @@ static int sendmsg_test(struct sockmap_options *opt)
 
 	rxpid = fork();
 	if (rxpid == 0) {
-		if (txmsg_pop || txmsg_start_pop)
-			iov_buf -= (txmsg_pop - txmsg_start_pop + 1);
 		if (opt->drop_expected || txmsg_ktls_skb_drop)
 			_exit(0);
 
-- 
2.20.1


