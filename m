Return-Path: <bpf+bounces-4524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A374C086
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A872811AB
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F87187E;
	Sun,  9 Jul 2023 02:59:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E116185D
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:59:28 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F8E48
	for <bpf@vger.kernel.org>; Sat,  8 Jul 2023 19:59:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262e89a3ee2so1652118a91.1
        for <bpf@vger.kernel.org>; Sat, 08 Jul 2023 19:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871567; x=1691463567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qKQNmDgEbsmo5qrDDGhDZO25ZZ7r2Gtzsmn/56tImQ=;
        b=Hcwc1olL/i08BfZbNG09dq6a8skklHMpD9uRtAxu5TI+V0y5r4GPrTBI6vuLGG9ZZM
         0QQIwdXaEIacRGiqC4fqhSrT7Uk0T+YTDt68iTxRmztrr/3Q1jxbRa3a7Xq7UZm9jGg5
         UAzEnqfTgna9g+6RF4eEKCoqA8J0XqCw1Oi6Fmco9vXBcWZ33SSrKCabN6xAzKVVjF0X
         glHOUoatwTwQ4s2dmhfIWw8byID+5MGomZy3ZwSt0P7T+pnBhBb90/zR4wJe/Gip75ca
         Up2/cf+JOMbX76bLSNIkF4YsejxDb4veSmuFBFjqX6STOhOMhAnRawWLUbpm/ooVIDJV
         ZNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871567; x=1691463567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qKQNmDgEbsmo5qrDDGhDZO25ZZ7r2Gtzsmn/56tImQ=;
        b=KQw7NIyZID3y4TEihX45xeRK4Od9bQTF1thgq4y2MFM7ro7MXaNeHqTrqiejgTHors
         jVs3FuphKDGUzD/9/yGt20YlGHgvuYd2s7djxTyhyXzli1GJdqBuNzQK91zQ+N1yDqnQ
         6J9EgUWWTMVm1H7rerfKV85L8akk+70VrybcPBwmZQaP8rYy8P1X8wHX+JsmbgaIOCc9
         NLDj8OpYGZEXpQ9lugg3dj19OHj7BAiao3kIFrEiPrA/eqamirP1fjJT4qRC7uQjGmJU
         Dip63RDY2Wv6njYIdyLiNKTvCfnlVvuDJRDebdiHjeDrtO/IPR+0pAKn8wXDqSEgqJb5
         lPQA==
X-Gm-Message-State: ABy/qLYwBrRhasolVcevOIeTiTtfYzbBvveNJA0AQx4/WhfWCc00ARm+
	G6Yb6gzeAUVti8uLk5iieoo=
X-Google-Smtp-Source: APBJJlEzqrQD4AFg5nbAczXSXLN6EIin+sMM19P1aRT0nSn22t4oIfN402ibt9nFL0RTIN430I7IUw==
X-Received: by 2002:a17:90a:5b0e:b0:263:4e41:bdb4 with SMTP id o14-20020a17090a5b0e00b002634e41bdb4mr6787757pji.33.1688871567389;
        Sat, 08 Jul 2023 19:59:27 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a68c900b0024e4f169931sm3670659pjj.2.2023.07.08.19.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:59:27 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add selftests for BTF_TYPE_SAFE_TRUSTED_UNION
Date: Sun,  9 Jul 2023 02:59:11 +0000
Message-Id: <20230709025912.3837-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025912.3837-1-laoar.shao@gmail.com>
References: <20230709025912.3837-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add selftests for BTF_TYPE_SAFE_TRUSTED_UNION, the result as follows:

 #141/1   nested_trust/test_read_cpumask:OK
 #141/2   nested_trust/test_skb_field:OK                    <<<<
 #141/3   nested_trust/test_invalid_nested_user_cpus:OK
 #141/4   nested_trust/test_invalid_nested_offset:OK
 #141/5   nested_trust/test_invalid_skb_field:OK            <<<<
 #141     nested_trust:OK

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/progs/nested_trust_failure.c   | 16 ++++++++++++++++
 .../selftests/bpf/progs/nested_trust_success.c   | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/nested_trust_failure.c b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
index 0d1aa6bbace4..ea39497f11ed 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_failure.c
+++ b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
@@ -10,6 +10,13 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, u64);
+} sk_storage_map SEC(".maps");
+
 /* Prototype for all of the program trace events below:
  *
  * TRACE_EVENT(task_newtask,
@@ -31,3 +38,12 @@ int BPF_PROG(test_invalid_nested_offset, struct task_struct *task, u64 clone_fla
 	bpf_cpumask_first_zero(&task->cpus_mask);
 	return 0;
 }
+
+/* Although R2 is of type sk_buff but sock_common is expected, we will hit untrusted ptr first. */
+SEC("tp_btf/tcp_probe")
+__failure __msg("R2 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+int BPF_PROG(test_invalid_skb_field, struct sock *sk, struct sk_buff *skb)
+{
+	bpf_sk_storage_get(&sk_storage_map, skb->next, 0, 0);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_success.c b/tools/testing/selftests/bpf/progs/nested_trust_success.c
index 886ade4aa99d..833840bffd3b 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_success.c
+++ b/tools/testing/selftests/bpf/progs/nested_trust_success.c
@@ -10,6 +10,13 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, u64);
+} sk_storage_map SEC(".maps");
+
 SEC("tp_btf/task_newtask")
 __success
 int BPF_PROG(test_read_cpumask, struct task_struct *task, u64 clone_flags)
@@ -17,3 +24,11 @@ int BPF_PROG(test_read_cpumask, struct task_struct *task, u64 clone_flags)
 	bpf_cpumask_test_cpu(0, task->cpus_ptr);
 	return 0;
 }
+
+SEC("tp_btf/tcp_probe")
+__success
+int BPF_PROG(test_skb_field, struct sock *sk, struct sk_buff *skb)
+{
+	bpf_sk_storage_get(&sk_storage_map, skb->sk, 0, 0);
+	return 0;
+}
-- 
2.30.1 (Apple Git-130)


