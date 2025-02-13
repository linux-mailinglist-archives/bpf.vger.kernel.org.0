Return-Path: <bpf+bounces-51332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD0A3343A
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 01:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBAF16825A
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 00:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE378F30;
	Thu, 13 Feb 2025 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfy3wvMo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F754D8A3;
	Thu, 13 Feb 2025 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407463; cv=none; b=sBzWQuStsnHxz5kA4/b2Qj6NraRCBn2Ko0JItov3dcuLSnF4tI96HYRNLIb1K6DfBylJ3kwPFggPnUpWMEXWca62fi+Y6IolJLeuS2VlPRuPz4JCHU7Kx9QPtFkLCEuhsBw/ztVXqfHbfZxQvLjkzymh5+cK3Z3oJio88cmDRfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407463; c=relaxed/simple;
	bh=p7TECV5karbQ/M8Ct+PzSyCJNgPYpYc5UNnf8rT4H58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMZx2WwkOlxUG9vywgI+6OhOTnQH99YRjKUjHCRRTHmDPkR45z5wla+1GgkaaJIBPD8JHdPhT9Acz7tElgYTqPgZIW3yw3nlliWHVU/bHC7nfnUBSo2zLSEVeqIGddKF9p1wyqeILRnsc+g2DkjpvnfN6v8pMwYMHBevTvhOYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfy3wvMo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so678264a91.2;
        Wed, 12 Feb 2025 16:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407461; x=1740012261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGuEBAuJgNZZ/66rBKa2gocvE1K8mBfjwGq4YE30f1s=;
        b=Zfy3wvMoF9iSkJKsexCNTi4Gu9AAFW8hptlT+tEVjDRYDPJUZeSGBhj9lOkF4Yghyk
         ucYUUuF4njFBBkaO4ukjxvPzAAYs3Q5T2MzqrFawkJe2KhavSe/ypwKX50RMx0YwSZGq
         LgGzVIH859iJUHsncHHw7ofZJcGZ2cZ7K/17J0OJcQ9s1a1SQ1oCx2cAQvGb1009/4R8
         0ALhxJc4tBt9KQ3uaZiUGERlaD4pMFVUnqD8lyvcs+iUCfA1BPQnUYJn4sjfI1CXzB48
         EMeS1AUOzUUvR5XhVzaZ4oyHBswflgXv1szYqDc9+28VtbdkQgwtyeuUcTP8Q6KKqtw8
         vRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407461; x=1740012261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGuEBAuJgNZZ/66rBKa2gocvE1K8mBfjwGq4YE30f1s=;
        b=ilYJXECajtIyrY01jioOV7beIAi4fc2OtW/ZReFDlKXAKBdEnVF+2d84HQ+UUS5kPb
         opd0jdOtZ4nzMHgfEuKYta6lwK3cTkavU4j7tEqNIb2DUakfjGd6Apv+T0bcf2G/5ID8
         oM1N587zgoRF+K1q96Uo5vU2C0DOEyzziiX2fGQG7euHYyi43+FePxccV6swYk8FPXU3
         cU1xpDY27TuuTY4DzWssPd2zRVFy8Yc49ysg9amY2IuaszZkAZ0Ti/TRaChHWkjpbGR6
         WA6mvv9FG3/RCGoibU7QKZa6uqga0EAutpcPkmi3sLCRb25GRC6Bk8z8DtVCDU7Q/7a4
         WK9g==
X-Forwarded-Encrypted: i=1; AJvYcCWz//WcRCU0jzH9ItCy/3vtr8gm8ibm3WNmAcSGmBQ3kAfXw4HBywAGGWy7OYczxBHSYg1DV60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuY5RHPJn17FwbN9Yr2c+KgEffbWHPCl3vX6NrjRUbofZPkQbR
	5LpWld3Ky4E/UVhy3hVDDwlZCj7irT31KK4EmPE71Ibi0JD9Mfcg
X-Gm-Gg: ASbGncvjUdhi5KC7uRSu6BPHYEWnHJcelv0wkMT06wIv8Df29YtQ1iP2RcFmfqHCYvC
	YOdM2m6GmMHEPSODWmhQx/BaV5NJYelRn9VJHuf54xEicGH361WMP2AeuYO5/4uxyNiQJoCtKnT
	uuhwB9p+Hh4uB1656g7PcJY37V0Q3o3R0bIyr8BdCjqjLKCdZIOInPwcpzQcOXfJ6p1qbB8euYT
	S14v8wjLJnfp3NrF7S/TRnizWVjh/Df1Nz5VGKOczTBiskSCPizBS/YbFqbFxs5QXNriaUwpNUw
	EDagq3EGLk2ygKbRN6ESlTYhAQmGpDmmcgZebajUJYV8LA0tgFvqMw==
X-Google-Smtp-Source: AGHT+IE2GjF2m8S6yZP6CSEQSKdoxU5w6gOKIO+ab3Hy0uKAbVIMDP7NyYdqBtT/fRla+dqrsCnauQ==
X-Received: by 2002:a17:90b:1f8b:b0:2ee:8430:b847 with SMTP id 98e67ed59e1d1-2fbf5bb1e2emr7259645a91.6.1739407460882;
        Wed, 12 Feb 2025 16:44:20 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad3fb8sm63618a91.26.2025.02.12.16.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:44:20 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
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
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next 3/3] selftests/bpf: add rto max for bpf_setsockopt test
Date: Thu, 13 Feb 2025 08:43:54 +0800
Message-Id: <20250213004355.38918-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250213004355.38918-1-kerneljasonxing@gmail.com>
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TCP_BPF_RTO_MAX selftests for active and passive flows
in the BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB and
BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB bpf callbacks.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 .../bpf/prog_tests/tcp_hdr_options.c          | 28 +++++++++++++------
 .../bpf/progs/test_tcp_hdr_options.c          | 26 +++++++++++++++++
 .../selftests/bpf/test_tcp_hdr_options.h      |  3 ++
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..714d48df6b3a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -60,8 +60,9 @@ static void print_hdr_stg(const struct hdr_stg *hdr_stg, const char *prefix)
 
 static void print_option(const struct bpf_test_option *opt, const char *prefix)
 {
-	fprintf(stderr, "%s{flags:0x%x, max_delack_ms:%u, rand:0x%x}\n",
-		prefix ? : "", opt->flags, opt->max_delack_ms, opt->rand);
+	fprintf(stderr, "%s{flags:0x%x, max_delack_ms:%u, rand:0x%x}, max_rto_sec:%u\n",
+		prefix ? : "", opt->flags, opt->max_delack_ms, opt->rand,
+		opt->max_rto_sec);
 }
 
 static void sk_fds_close(struct sk_fds *sk_fds)
@@ -300,13 +301,17 @@ static void fastopen_estab(void)
 	hdr_stg_map_fd = bpf_map__fd(skel->maps.hdr_stg_map);
 	lport_linum_map_fd = bpf_map__fd(skel->maps.lport_linum_map);
 
-	exp_passive_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS;
+	exp_passive_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS |
+				     OPTION_F_MAX_RTO_SEC;
 	exp_passive_estab_in.rand = 0xfa;
 	exp_passive_estab_in.max_delack_ms = 11;
+	exp_passive_estab_in.max_rto_sec = 1;
 
-	exp_active_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS;
+	exp_active_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS |
+				    OPTION_F_MAX_RTO_SEC;
 	exp_active_estab_in.rand = 0xce;
 	exp_active_estab_in.max_delack_ms = 22;
+	exp_active_estab_in.max_rto_sec = 2;
 
 	exp_passive_hdr_stg.fastopen = true;
 
@@ -337,14 +342,17 @@ static void syncookie_estab(void)
 	hdr_stg_map_fd = bpf_map__fd(skel->maps.hdr_stg_map);
 	lport_linum_map_fd = bpf_map__fd(skel->maps.lport_linum_map);
 
-	exp_passive_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS;
+	exp_passive_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS |
+				     OPTION_F_MAX_RTO_SEC;
 	exp_passive_estab_in.rand = 0xfa;
 	exp_passive_estab_in.max_delack_ms = 11;
+	exp_passive_estab_in.max_rto_sec = 1;
 
 	exp_active_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS |
-					OPTION_F_RESEND;
+				    OPTION_F_RESEND | OPTION_F_MAX_RTO_SEC;
 	exp_active_estab_in.rand = 0xce;
 	exp_active_estab_in.max_delack_ms = 22;
+	exp_active_estab_in.max_rto_sec = 2;
 
 	exp_passive_hdr_stg.syncookie = true;
 	exp_active_hdr_stg.resend_syn = true;
@@ -413,13 +421,17 @@ static void __simple_estab(bool exprm)
 	hdr_stg_map_fd = bpf_map__fd(skel->maps.hdr_stg_map);
 	lport_linum_map_fd = bpf_map__fd(skel->maps.lport_linum_map);
 
-	exp_passive_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS;
+	exp_passive_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS |
+				     OPTION_F_MAX_RTO_SEC;
 	exp_passive_estab_in.rand = 0xfa;
 	exp_passive_estab_in.max_delack_ms = 11;
+	exp_passive_estab_in.max_rto_sec = 1;
 
-	exp_active_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS;
+	exp_active_estab_in.flags = OPTION_F_RAND | OPTION_F_MAX_DELACK_MS |
+				    OPTION_F_MAX_RTO_SEC;
 	exp_active_estab_in.rand = 0xce;
 	exp_active_estab_in.max_delack_ms = 22;
+	exp_active_estab_in.max_rto_sec = 2;
 
 	prepare_out();
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
index 5f4e87ee949a..92da239adb49 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
@@ -80,6 +80,9 @@ static void write_test_option(const struct bpf_test_option *test_opt,
 
 	if (TEST_OPTION_FLAGS(test_opt->flags, OPTION_RAND))
 		data[offset++] = test_opt->rand;
+
+	if (TEST_OPTION_FLAGS(test_opt->flags, OPTION_MAX_RTO_SEC))
+		data[offset++] = test_opt->max_rto_sec;
 }
 
 static int store_option(struct bpf_sock_ops *skops,
@@ -124,6 +127,9 @@ static int parse_test_option(struct bpf_test_option *opt, const __u8 *start)
 	if (TEST_OPTION_FLAGS(opt->flags, OPTION_RAND))
 		opt->rand = *start++;
 
+	if (TEST_OPTION_FLAGS(opt->flags, OPTION_MAX_RTO_SEC))
+		opt->max_rto_sec = *start++;
+
 	return 0;
 }
 
@@ -411,6 +417,14 @@ static int set_rto_min(struct bpf_sock_ops *skops, __u8 peer_max_delack_ms)
 			      sizeof(min_rto_us));
 }
 
+static int set_rto_max(struct bpf_sock_ops *skops, __u8 max_rto_sec)
+{
+	__u32 max_rto_ms = max_rto_sec * 1000;
+
+	return bpf_setsockopt(skops, SOL_TCP, TCP_BPF_RTO_MAX, &max_rto_ms,
+			      sizeof(max_rto_ms));
+}
+
 static int handle_active_estab(struct bpf_sock_ops *skops)
 {
 	struct hdr_stg init_stg = {
@@ -459,6 +473,12 @@ static int handle_active_estab(struct bpf_sock_ops *skops)
 			RET_CG_ERR(err);
 	}
 
+	if (active_estab_in.max_rto_sec) {
+		err = set_rto_max(skops, active_estab_in.max_rto_sec);
+		if (err)
+			RET_CG_ERR(err);
+	}
+
 	return CG_OK;
 }
 
@@ -525,6 +545,12 @@ static int handle_passive_estab(struct bpf_sock_ops *skops)
 			RET_CG_ERR(err);
 	}
 
+	if (passive_estab_in.max_rto_sec) {
+		err = set_rto_max(skops, passive_estab_in.max_rto_sec);
+		if (err)
+			RET_CG_ERR(err);
+	}
+
 	return CG_OK;
 }
 
diff --git a/tools/testing/selftests/bpf/test_tcp_hdr_options.h b/tools/testing/selftests/bpf/test_tcp_hdr_options.h
index 56c9f8a3ad3d..c91fad861f84 100644
--- a/tools/testing/selftests/bpf/test_tcp_hdr_options.h
+++ b/tools/testing/selftests/bpf/test_tcp_hdr_options.h
@@ -8,18 +8,21 @@ struct bpf_test_option {
 	__u8 flags;
 	__u8 max_delack_ms;
 	__u8 rand;
+	__u8 max_rto_sec;
 } __attribute__((packed));
 
 enum {
 	OPTION_RESEND,
 	OPTION_MAX_DELACK_MS,
 	OPTION_RAND,
+	OPTION_MAX_RTO_SEC,
 	__NR_OPTION_FLAGS,
 };
 
 #define OPTION_F_RESEND		(1 << OPTION_RESEND)
 #define OPTION_F_MAX_DELACK_MS	(1 << OPTION_MAX_DELACK_MS)
 #define OPTION_F_RAND		(1 << OPTION_RAND)
+#define OPTION_F_MAX_RTO_SEC	(1 << OPTION_MAX_RTO_SEC)
 #define OPTION_MASK		((1 << __NR_OPTION_FLAGS) - 1)
 
 #define TEST_OPTION_FLAGS(flags, option) (1 & ((flags) >> (option)))
-- 
2.43.5


