Return-Path: <bpf+bounces-41817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD899B6FA
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336101C20F4B
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01B0199EA3;
	Sat, 12 Oct 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g9FPxh3M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14111946B
	for <bpf@vger.kernel.org>; Sat, 12 Oct 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765475; cv=none; b=h7UzrhmsTSFH2DRZXnJdHTTAOh9fQtc++2keEF9JK0GAbZUiyPHXi8g/OzMBYDLtcD2j9eOkTaJR5XKKd6KGHFLMXo1uAdej/LiAfzcCoYfE0fwqEJhjcFuZ3c5h1NamzmPSB/WtaHmuKcRg/I7ZBvvcOcPVwBbKTDWGq30vQvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765475; c=relaxed/simple;
	bh=bXAZxQrUSgwvLIqRZs34eCylg8ZrJTxQV5OuqBCZfW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEMFLOXJmlRJmJUAPHzbVpizm0ULsIWHwxWq27a5abnOWgaDXVCgi8mwZHhbqnQY1uPWHum7O9chA+llHkwf9IGGrG4iBQjpXsnpWoC9gmrgnkjcM8oRFZ/T13BO1lskdJQPbXqypiSbEVtLmaETyafSE+x7QbmxxrQT1IE5FFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g9FPxh3M; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4604b48293dso17264481cf.0
        for <bpf@vger.kernel.org>; Sat, 12 Oct 2024 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728765472; x=1729370272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GKzx0WEl2PUdiT+xgCmCWo/YkkIMAIwSTOo1wNjkLs=;
        b=g9FPxh3McTeiB37mWc1FoFUSezH1n3frbUf4rmS731SsGrZvCUFvh5e9tXxThBwm+M
         IJyGDdFUTV5zr7MRO6Xov8pPn5VOqgZBV6j/IholUk6NY9DxYkq3M/EBSSRVJQ8A7sBG
         tE6ZLqYrpGodEHbgsUIyDDcs93/TDaVHyGFZF8vDxz6ZLkHoQBSuYj+SmrHwaIZ1H6WY
         SwMi/E0hT1NYMwNG9gIBM1iPmXnS4CwiHxILgKpqmTcRqIdd5I9Ej+qOci1NW/Y2gshu
         gd5gqjZnnTEGDy7wl4gX/nez8ZOmgQUN24VvHXnGsY8RxwrGBZ6gN71x9elVMLBbsLgE
         G8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728765472; x=1729370272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GKzx0WEl2PUdiT+xgCmCWo/YkkIMAIwSTOo1wNjkLs=;
        b=brrEkxnBrWeRuoObKUN0hyszbRzDmd95kEXrOOkf86/akILoW4ztnBxWnG9A/R4Br2
         KN1+EVJiYrzbeQ/XuLPbNiOGjP0QVomzIEn4VS/IPY2gmcGPnPjMOkPtiFesWn0UWR6B
         2P7GA3cQidW2L3KZdW5+4wrxyxyviMOWjv6k6W8YTuKs9wbBwzOO+izue6kx7b3drxQ/
         58DXu010wWE4c9IciLMspM6/5xw4OUnADs9/LXSu0ndQmqi5BbXVeey/URG6kQsAYegg
         l8eDTY597X0fctl5UkWb6xtKvr7zRsLdglvsJSjnEgq8BnYhIhfF16proTu46eTI4tAy
         yFcg==
X-Gm-Message-State: AOJu0YyXZZE9+MCpG8PDAowRpG7kFkKeeVXxhP0rSnrWhtdp/2GSVi1T
	9J6fYnHlnN1AWc35UuZzVou+z90f1+q2ErmHtpJNXOVg+dIb1AklaYio5Rx56YMeuDzaixOyzSG
	X
X-Google-Smtp-Source: AGHT+IHhbf2/8VKlYSb5iXF0A8iLMbSrP6540ei4eokR2VR4+vA8Co7ynLWR/qUpSVXLZ2p81vJKRg==
X-Received: by 2002:ac8:7e93:0:b0:45d:8e3c:9c22 with SMTP id d75a77b69052e-4604b3a29a9mr89723841cf.30.1728765472599;
        Sat, 12 Oct 2024 13:37:52 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427895fdsm27803371cf.16.2024.10.12.13.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:37:51 -0700 (PDT)
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
	mykolal@fb.com,
	shuah@kernel.org,
	bhole_prashant_q7@lab.ntt.co.jp,
	jakub@cloudflare.com,
	xiyou.wangcong@gmail.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 1/2] selftests/bpf: Fix msg_verify_data in test_sockmap
Date: Sat, 12 Oct 2024 20:37:30 +0000
Message-Id: <20241012203731.1248619-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241012203731.1248619-1-zijianzhang@bytedance.com>
References: <20241012203731.1248619-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Function msg_verify_data should have context of bytes_cnt and k instead of
assuming they are zero. Otherwise, test_sockmap with data integrity test
will report some errors. I also fix the logic related to size and index j

1/ 6  sockmap::txmsg test passthrough:FAIL
2/ 6  sockmap::txmsg test redirect:FAIL
7/12  sockmap::txmsg test apply:FAIL
10/11  sockmap::txmsg test push_data:FAIL
11/17  sockmap::txmsg test pull-data:FAIL
12/ 9  sockmap::txmsg test pop-data:FAIL
13/ 1  sockmap::txmsg test push/pop data:FAIL
...
Pass: 24 Fail: 52

After applying this patch, some of the errors are solved, but for push,
pull and pop, we may need more fixes to msg_verify_data, added a TODO

10/11  sockmap::txmsg test push_data:FAIL
11/17  sockmap::txmsg test pull-data:FAIL
12/ 9  sockmap::txmsg test pop-data:FAIL
...
Pass: 37 Fail: 15

Besides, added a custom errno EDATAINTEGRITY for msg_verify_data, we
shall not ignore the error in txmsg_cork case.

Fixes: 753fb2ee0934 ("bpf: sockmap, add msg_peek tests to test_sockmap")
Fixes: 16edddfe3c5d ("selftests/bpf: test_sockmap, check test failure")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 3e02d7267de8..8249f3c1fbd6 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -56,6 +56,8 @@ static void running_handler(int a);
 #define BPF_SOCKHASH_FILENAME "test_sockhash_kern.bpf.o"
 #define CG_PATH "/sockmap"
 
+#define EDATAINTEGRITY 2001
+
 /* global sockets */
 int s1, s2, c1, c2, p1, p2;
 int test_cnt;
@@ -510,23 +512,25 @@ static int msg_alloc_iov(struct msghdr *msg,
 	return -ENOMEM;
 }
 
-static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz)
+/* TODO: Add verification logic for push, pull and pop data */
+static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz,
+				 unsigned char *k_p, int *bytes_cnt_p)
 {
-	int i, j = 0, bytes_cnt = 0;
-	unsigned char k = 0;
+	int i, j, bytes_cnt = *bytes_cnt_p;
+	unsigned char k = *k_p;
 
-	for (i = 0; i < msg->msg_iovlen; i++) {
+	for (i = 0, j = 0; i < msg->msg_iovlen && size; i++, j = 0) {
 		unsigned char *d = msg->msg_iov[i].iov_base;
 
 		/* Special case test for skb ingress + ktls */
 		if (i == 0 && txmsg_ktls_skb) {
 			if (msg->msg_iov[i].iov_len < 4)
-				return -EIO;
+				return -EDATAINTEGRITY;
 			if (memcmp(d, "PASS", 4) != 0) {
 				fprintf(stderr,
 					"detected skb data error with skb ingress update @iov[%i]:%i \"%02x %02x %02x %02x\" != \"PASS\"\n",
 					i, 0, d[0], d[1], d[2], d[3]);
-				return -EIO;
+				return -EDATAINTEGRITY;
 			}
 			j = 4; /* advance index past PASS header */
 		}
@@ -536,7 +540,7 @@ static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz)
 				fprintf(stderr,
 					"detected data corruption @iov[%i]:%i %02x != %02x, %02x ?= %02x\n",
 					i, j, d[j], k - 1, d[j+1], k);
-				return -EIO;
+				return -EDATAINTEGRITY;
 			}
 			bytes_cnt++;
 			if (bytes_cnt == chunk_sz) {
@@ -546,6 +550,8 @@ static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz)
 			size--;
 		}
 	}
+	*k_p = k;
+	*bytes_cnt_p = bytes_cnt;
 	return 0;
 }
 
@@ -602,6 +608,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		float total_bytes, txmsg_pop_total;
 		int fd_flags = O_NONBLOCK;
 		struct timeval timeout;
+		unsigned char k = 0;
+		int bytes_cnt = 0;
 		fd_set w;
 
 		fcntl(fd, fd_flags);
@@ -696,7 +704,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 						iov_length * cnt :
 						iov_length * iov_count;
 
-				errno = msg_verify_data(&msg, recv, chunk_sz);
+				errno = msg_verify_data(&msg, recv, chunk_sz, &k, &bytes_cnt);
 				if (errno) {
 					perror("data verify msg failed");
 					goto out_errno;
@@ -704,7 +712,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 				if (recvp) {
 					errno = msg_verify_data(&msg_peek,
 								recvp,
-								chunk_sz);
+								chunk_sz,
+								&k,
+								&bytes_cnt);
 					if (errno) {
 						perror("data verify msg_peek failed");
 						goto out_errno;
@@ -812,7 +822,7 @@ static int sendmsg_test(struct sockmap_options *opt)
 				s.bytes_sent, sent_Bps, sent_Bps/giga,
 				s.bytes_recvd, recvd_Bps, recvd_Bps/giga,
 				peek_flag ? "(peek_msg)" : "");
-		if (err && txmsg_cork)
+		if (err && err != -EDATAINTEGRITY && txmsg_cork)
 			err = 0;
 		exit(err ? 1 : 0);
 	} else if (rxpid == -1) {
-- 
2.20.1


