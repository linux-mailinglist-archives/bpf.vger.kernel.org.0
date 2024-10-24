Return-Path: <bpf+bounces-43086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D59AF35F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581EE2844BA
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE3215F44;
	Thu, 24 Oct 2024 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MWCiMd0S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F72010FA
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800807; cv=none; b=BYGtK4O9ioZJtb7lYDeIWF0rxp+Er1zSZG8BF3DyY42ttTSuWFAJD4VJx4agVV+cYcD3Cei2OZYD0MnnJARnv0DuANuXu5uVRDoq7KDEv3Ko7IAdT/Mi+jrygnFdJTsOezorSnfQhOVjrAUqmVgmjIwKKpxpjRTO10HZAjFG4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800807; c=relaxed/simple;
	bh=y5xG5PZaDIdA5ZRhc0eCzfqeojjrLwjp1ZGtaVGyGM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTK8UjQGEax3uoWnbS8H1y5V7HmEAKY4Ux0bb3jHljkdgIZe50ZhjkqhDjiBKos0M9GW5Nii3VdwBLp+N22dtnzMJKpdWO4eiJY03iAubK/xKQDSz+ncC1NEIC6YpxEnbxgcd90PhhKllFpQ76Jg/peUVn3uhfeVaiPt/Vf+utM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MWCiMd0S; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b14077ec5aso224701685a.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729800804; x=1730405604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEFUQiY7ce/KeA/4yaA7IZEeCrfS6Isv4u/QJ5N6wws=;
        b=MWCiMd0SJOUjqpGXpvy3pnkYpUdNLkBC+zP8wAAoxpFBja0xZY47nqD1R5sEQ4ZATZ
         ihGGVGVr6iwmuamZ2mLwXeavdaqNn6jpLnsCDF+B5FzL96orV8C7A0jk7+AApyHenQ5B
         m6E4nX2fjJTnApHabDhTJJ/aKI6x42xbXvbXgr586XjPwu6eyqclxOXUUFjUeSBd5UHd
         YVyZyzlmjjHiPOGfAuMRYxXiTVWoalPvAVDvgpAlrhZaM5CfUHFUh7bXz1kUhyI5h+cH
         K27HfC2YLzra3IC21qFsfDm1NVH174jr/1PucCIfSPZxIuOcP8OtwiLgw7QdA4n/Z5wc
         IlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800804; x=1730405604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEFUQiY7ce/KeA/4yaA7IZEeCrfS6Isv4u/QJ5N6wws=;
        b=uCMfesuN63liqqlTqKTnUWoy/Kw4pjdcO5sFFf4Je9agyBi4g2YS7Jeu7ViXwcA/yi
         bbQ/vJ2qQWVwgiQv6H1iJltkAd+Dr5C6S2yB4Ov3C5G3g0V5Z5wVMVGtIWBxNb8kHE/0
         m5kLXpPLZ93oSMcLYL1Qsr6VDJhEJQP6HbjCD99G3I5O9vEhWY5IPAJXKdFCh8tE9pqs
         FWI4TqF13mlh83eGJ/OjQm0q8M9QbMsQ/xF8Owk6zBJEvRjTdCKrO5l5JEtW/44Otl4Z
         ylsxQsccKlXP7n4ZwFdFPB/laxnnD++gP1XX/+znwh19aKpof5+VKklxbNolY6G95k+C
         FJEQ==
X-Gm-Message-State: AOJu0YywytmP6xR/KIK71uNxC06rf3RT1WMXwplU9OjsDUrLzUPUsuLv
	s2TlMo0kBkW+IxOQr/VH8z6JYf5n2tReTtfGp5lvJPm4auhi0+O6D+6WUZtMNMKYsjvq1HBVjq/
	e
X-Google-Smtp-Source: AGHT+IHLT4QnGiUWlKsW9FMXZcD4Qbfl68tuAix+jOYkP5dfe5nZ55DAyVJMgTRvOhLofmyjNZqrDQ==
X-Received: by 2002:a05:620a:424e:b0:7ac:aad3:9135 with SMTP id af79cd13be357-7b1865e662fmr516052785a.15.1729800803792;
        Thu, 24 Oct 2024 13:13:23 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm518952785a.60.2024.10.24.13.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:13:23 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next/net 3/8] selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
Date: Thu, 24 Oct 2024 20:13:01 +0000
Message-Id: <20241024201306.3429177-4-zijianzhang@bytedance.com>
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

total_bytes in msg_loop_rx should also take push into account, otherwise
total_bytes will be a smaller value, which makes the msg_loop_rx end early.

Besides, total_bytes has already taken pop into account, so we don't need
to subtract some bytes from iov_buf in sendmsg_test. The additional
subtraction may make total_bytes a negative number, and msg_loop_rx will
just end without checking anything.

Fixes: 18d4e900a450 ("bpf: Selftests, improve test_sockmap total bytes counter")
Fixes: d69672147faa ("selftests, bpf: Add one test for sockmap with strparser")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
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


