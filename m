Return-Path: <bpf+bounces-43096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5559AF3A7
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CF81F22FF2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7902010E5;
	Thu, 24 Oct 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MVcLDHu2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6251FAF08
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801784; cv=none; b=oPot/aksGkqAK9lhhfr5cp4ohUvLvCVSoQUUN62psxrEr3yjDEI7lj7bwHzhEJHLDAaF8ow5KQV/9/ypX4K26ytGEA5625iwuJKhujIJMEd6NH5EKLry4Z97aqB8kO+be367KRIFA/jCaEYiuJ4rqFTs3J3ZHN9TgUVjJvkCm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801784; c=relaxed/simple;
	bh=eb8puX70Jevci/jH+kFlG74v8H4lVm245VUWlkHYLkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mT8TNiX6kYN0MTfA8l0uP4+Z32wVtxL+t+fvyt6MQNe77BYQNDCGvqHWrb3E7NW/g7yDx7sn+oHvm5NDBFLyppe7JuoxbVkrlcRqMgSIJIk4E8Vmr7REt16oN5vyokq6kNPVGhjfCNCYxu3qRv4i0nYDh0u9CyKzJi/4Daguero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MVcLDHu2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a23ad00eso21700441cf.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729801780; x=1730406580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K+TwNwMyKCU5VO2n/DGvMfeeWGd67kJlM6/di+nJ0A=;
        b=MVcLDHu2jqELr1aPNMrBtSCDfPlz4a2ddedcvWl6diC1Hg0YXzVWiQ4NLri7LsAbKu
         QrNcnieb65vLuvPfAozD6x6frjdKy2HM7qk/t/VAwQ+P2vA5a2SxRM9y+CCwOpRipNde
         RY71/lR3LWyFK70oZJgmjrwZ0CcdvRXH1zDMETKncm9kMC4ePW5qkqdWAXsoXVJsEzAe
         /CU6QVLf35CsSfwVlpuWqlO6wzRvk2MAX/HfKU/Hya6w6+UI7qVK1tCOt8CRrTp7Qhfc
         N6Tbk0cUcSs723uTMfWS8pQ+Ag6dK9YEXEkdVdxXcW2LS/B2955xuygthlpKJC+dZ5g6
         4blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801780; x=1730406580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K+TwNwMyKCU5VO2n/DGvMfeeWGd67kJlM6/di+nJ0A=;
        b=kc1wFTcMIZIFQec+ByIgWa49fJbXFKqsrAlJmlYOyLOu1NM1e0dM8Gp/acqjTPdz+Y
         JDTPyjje7HVgItmTlQWOmSakznxVD0JJbHPVqMvGJLBfil2xJv29Q3Pyt+Isz4vDPSsX
         z19ehJpb39ca+jmMEkOono8UePbuXJ5m1SWUR4VHZqNyxqo4ycgGWXMHK+Y2gpx0+dSc
         8khoMR54rFgPN18ZkxwQTjUcjMkXOQOCFCZI+gk6mYs0ov22UHHfSMaWhGXO1v4LHV/P
         OYBCJAxEEmkzTA57q8kPyG0qVOKUz27hXZfI2AnNW787Yh4F1qWYWTMVrSOSyLh1bqpd
         MKCw==
X-Gm-Message-State: AOJu0YyzVhMMtthy3fZN9PnlhOSXikQDQb0upMu6XlHlJSYJU0a1Vg1d
	LGMrap82FyAPzkOQH9CKVf/nAi90TFzc0jLYRNdhD3lSaH1LD2alTi1H8qyJiqb/4Yq6BNUptaH
	d
X-Google-Smtp-Source: AGHT+IGZG7ZZO05/orT0GzKUg+/9P6kA1RW6MDvA631CpjLO2NmplDdmA3uqovSW4Bk3vKnm4Mf7iQ==
X-Received: by 2002:a05:622a:11c8:b0:460:854f:a1c with SMTP id d75a77b69052e-461252d167emr54644721cf.27.1729801780473;
        Thu, 24 Oct 2024 13:29:40 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm55486081cf.52.2024.10.24.13.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:29:40 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 4/8] selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
Date: Thu, 24 Oct 2024 20:29:13 +0000
Message-Id: <20241024202917.3443231-5-zijianzhang@bytedance.com>
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

Add push/pop checking for msg_verify_data in test_sockmap, except for
pop/push with cork tests, in these tests the logic will be different.
1. With corking, pop/push might not be invoked in each sendmsg, it makes
the layout of the received data difficult
2. It makes it hard to calculate the total_bytes in the recvmsg
Temporarily skip the data integrity test for these cases now, added a TODO

Fixes: ee9b352ce465 ("selftests/bpf: Fix msg_verify_data in test_sockmap")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 106 ++++++++++++++++++++-
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 5f4558f1f004..61a747afcd05 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -88,6 +88,10 @@ int ktls;
 int peek_flag;
 int skb_use_parser;
 int txmsg_omit_skb_parser;
+int verify_push_start;
+int verify_push_len;
+int verify_pop_start;
+int verify_pop_len;
 
 static const struct option long_options[] = {
 	{"help",	no_argument,		NULL, 'h' },
@@ -514,12 +518,41 @@ static int msg_alloc_iov(struct msghdr *msg,
 	return -ENOMEM;
 }
 
-/* TODO: Add verification logic for push, pull and pop data */
+/* In push or pop test, we need to do some calculations for msg_verify_data */
+static void msg_verify_date_prep(void)
+{
+	int push_range_end = txmsg_start_push + txmsg_end_push - 1;
+	int pop_range_end = txmsg_start_pop + txmsg_pop - 1;
+
+	if (txmsg_end_push && txmsg_pop &&
+	    txmsg_start_push <= pop_range_end && txmsg_start_pop <= push_range_end) {
+		/* The push range and the pop range overlap */
+		int overlap_len;
+
+		verify_push_start = txmsg_start_push;
+		verify_pop_start = txmsg_start_pop;
+		if (txmsg_start_push < txmsg_start_pop)
+			overlap_len = min(push_range_end - txmsg_start_pop + 1, txmsg_pop);
+		else
+			overlap_len = min(pop_range_end - txmsg_start_push + 1, txmsg_end_push);
+		verify_push_len = max(txmsg_end_push - overlap_len, 0);
+		verify_pop_len = max(txmsg_pop - overlap_len, 0);
+	} else {
+		/* Otherwise */
+		verify_push_start = txmsg_start_push;
+		verify_pop_start = txmsg_start_pop;
+		verify_push_len = txmsg_end_push;
+		verify_pop_len = txmsg_pop;
+	}
+}
+
 static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz,
-				 unsigned char *k_p, int *bytes_cnt_p)
+			   unsigned char *k_p, int *bytes_cnt_p,
+			   int *check_cnt_p, int *push_p)
 {
-	int i, j, bytes_cnt = *bytes_cnt_p;
+	int bytes_cnt = *bytes_cnt_p, check_cnt = *check_cnt_p, push = *push_p;
 	unsigned char k = *k_p;
+	int i, j;
 
 	for (i = 0, j = 0; i < msg->msg_iovlen && size; i++, j = 0) {
 		unsigned char *d = msg->msg_iov[i].iov_base;
@@ -538,6 +571,37 @@ static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz,
 		}
 
 		for (; j < msg->msg_iov[i].iov_len && size; j++) {
+			if (push > 0 &&
+			    check_cnt == verify_push_start + verify_push_len - push) {
+				int skipped;
+revisit_push:
+				skipped = push;
+				if (j + push >= msg->msg_iov[i].iov_len)
+					skipped = msg->msg_iov[i].iov_len - j;
+				push -= skipped;
+				size -= skipped;
+				j += skipped - 1;
+				check_cnt += skipped;
+				continue;
+			}
+
+			if (verify_pop_len > 0 && check_cnt == verify_pop_start) {
+				bytes_cnt += verify_pop_len;
+				check_cnt += verify_pop_len;
+				k += verify_pop_len;
+
+				if (bytes_cnt == chunk_sz) {
+					k = 0;
+					bytes_cnt = 0;
+					check_cnt = 0;
+					push = verify_push_len;
+				}
+
+				if (push > 0 &&
+				    check_cnt == verify_push_start + verify_push_len - push)
+					goto revisit_push;
+			}
+
 			if (d[j] != k++) {
 				fprintf(stderr,
 					"detected data corruption @iov[%i]:%i %02x != %02x, %02x ?= %02x\n",
@@ -545,15 +609,20 @@ static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz,
 				return -EDATAINTEGRITY;
 			}
 			bytes_cnt++;
+			check_cnt++;
 			if (bytes_cnt == chunk_sz) {
 				k = 0;
 				bytes_cnt = 0;
+				check_cnt = 0;
+				push = verify_push_len;
 			}
 			size--;
 		}
 	}
 	*k_p = k;
 	*bytes_cnt_p = bytes_cnt;
+	*check_cnt_p = check_cnt;
+	*push_p = push;
 	return 0;
 }
 
@@ -612,6 +681,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		unsigned char k = 0;
 		int bytes_cnt = 0;
+		int check_cnt = 0;
+		int push = 0;
 		fd_set w;
 
 		fcntl(fd, fd_flags);
@@ -637,6 +708,10 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		}
 		total_bytes += txmsg_push_total;
 		total_bytes -= txmsg_pop_total;
+		if (data) {
+			msg_verify_date_prep();
+			push = verify_push_len;
+		}
 		err = clock_gettime(CLOCK_MONOTONIC, &s->start);
 		if (err < 0)
 			perror("recv start time");
@@ -712,7 +787,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 						iov_length :
 						iov_length * iov_count;
 
-				errno = msg_verify_data(&msg, recv, chunk_sz, &k, &bytes_cnt);
+				errno = msg_verify_data(&msg, recv, chunk_sz, &k, &bytes_cnt,
+							&check_cnt, &push);
 				if (errno) {
 					perror("data verify msg failed");
 					goto out_errno;
@@ -722,7 +798,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 								recvp,
 								chunk_sz,
 								&k,
-								&bytes_cnt);
+								&bytes_cnt,
+								&check_cnt,
+								&push);
 					if (errno) {
 						perror("data verify msg_peek failed");
 						goto out_errno;
@@ -1636,6 +1714,8 @@ static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 {
+	bool data = opt->data_test;
+
 	/* Test basic pop */
 	txmsg_pass = 1;
 	txmsg_start_pop = 1;
@@ -1654,6 +1734,12 @@ static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 	txmsg_pop = 2;
 	test_send_many(opt, cgrp);
 
+	/* TODO: Test for pop + cork should be different,
+	 * - It makes the layout of the received data difficult
+	 * - It makes it hard to calculate the total_bytes in the recvmsg
+	 * Temporarily skip the data integrity test for this case now.
+	 */
+	opt->data_test = false;
 	/* Test pop + cork */
 	txmsg_redir = 0;
 	txmsg_cork = 512;
@@ -1667,10 +1753,13 @@ static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 	txmsg_start_pop = 1;
 	txmsg_pop = 2;
 	test_send_many(opt, cgrp);
+	opt->data_test = data;
 }
 
 static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 {
+	bool data = opt->data_test;
+
 	/* Test basic push */
 	txmsg_pass = 1;
 	txmsg_start_push = 1;
@@ -1689,12 +1778,19 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 	txmsg_end_push = 2;
 	test_send_many(opt, cgrp);
 
+	/* TODO: Test for push + cork should be different,
+	 * - It makes the layout of the received data difficult
+	 * - It makes it hard to calculate the total_bytes in the recvmsg
+	 * Temporarily skip the data integrity test for this case now.
+	 */
+	opt->data_test = false;
 	/* Test push + cork */
 	txmsg_redir = 0;
 	txmsg_cork = 512;
 	txmsg_start_push = 1;
 	txmsg_end_push = 2;
 	test_send_many(opt, cgrp);
+	opt->data_test = data;
 }
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
-- 
2.20.1


