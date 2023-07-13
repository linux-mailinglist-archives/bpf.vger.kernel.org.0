Return-Path: <bpf+bounces-4908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9D675168A
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE93828149F
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E85EDF;
	Thu, 13 Jul 2023 02:56:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749B7C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:56:54 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABB7172C
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:53 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b74791c948so201042a34.3
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689217012; x=1691809012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxUPFBNzGA3RNGVhkEqCRbkqkt+roNxXy3BtCDDwq7Q=;
        b=fdKrC13fhDmV7gj1vYhuO1ySY4tOHTkqcDJNTwnRCnWKnLbqGhVnaTEhaH/utV24mU
         TPTrGsdWJAvpkDA40hKAhwNSv8ehMr8FcUe8UcEByVX5m/wQjkm5U1d9eHzk4yaaA/Ba
         aqNq4N0JzQ1z51AoiQQtu3erXq5C9pwZm5O746w/IVyIhhxk0IOY0m5S1F93tDBIPIcX
         TBg7zKzsX4XzhcJV25a7CHwjld+XcsofILFv10qyOA+zEHiS4E6UwH92CV8la5rB6/ID
         txcLv/cgL8eoHiLctYacN6I1Lckivo3lov67Z91kuKMX2bV1cjEpeeJrQ//X9IIwqaNj
         S0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217012; x=1691809012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxUPFBNzGA3RNGVhkEqCRbkqkt+roNxXy3BtCDDwq7Q=;
        b=h2XyrJkt79WFPXMhNHUg13NsMcDfMYWXcAGhBXgBzWndjeG+F7iDDgdXRnRD8NKG9v
         b226KXeMfrQu9ONBTb4ZQGPt5qiHkmgMyor6RIpfwr0aU6Gyru60Atq1sj0/YtxMo+az
         dihXCI97SqbJuxdxWQMRXJp60hTGQPFrOfTCpGEQqftw4DxeUMtw+17wIPxrg8YVjXvx
         BWGR8LLtchSJ8fEMu36wh1L9qfjRmgb9P6/R90DesyzKOgNSQeq19lBW0V9B6N8W6z42
         lqUU5WVU/gDuamJY51c5ZKJHRmm8qlUp2rKMlM45w/Y2ihYw0DN7SFLeH9IVgqWbxIQr
         1+9g==
X-Gm-Message-State: ABy/qLY7cXgCl9skK2rqHX8tD8YoErRzHlC07X/A5jq3pMpGqRYrmUoS
	e09TEVPh4ls9sx6XYHhE/1A=
X-Google-Smtp-Source: APBJJlFLSFXK9q34M9UzCso4QIWUv8JkKN4vcTVyN5L7UpZq+VA5mP5u/boWrp9Gb96kRyzt7q9/Ew==
X-Received: by 2002:a05:6870:d783:b0:1b7:2d92:58d6 with SMTP id bd3-20020a056870d78300b001b72d9258d6mr682755oab.32.1689217012687;
        Wed, 12 Jul 2023 19:56:52 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:a97:5400:4ff:fe81:66ad])
        by smtp.gmail.com with ESMTPSA id lr3-20020a17090b4b8300b00260a5ecd273sm4416681pjb.1.2023.07.12.19.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:56:52 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/4] selftests/bpf: Add selftests for nested_trust
Date: Thu, 13 Jul 2023 02:56:40 +0000
Message-Id: <20230713025642.27477-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230713025642.27477-1-laoar.shao@gmail.com>
References: <20230713025642.27477-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add selftests for nested_strust to check whehter PTR_UNTRUSTED is cleared
as expected, the result as follows:

 #141/1   nested_trust/test_read_cpumask:OK
 #141/2   nested_trust/test_skb_field:OK                    <<<<
 #141/3   nested_trust/test_invalid_nested_user_cpus:OK
 #141/4   nested_trust/test_invalid_nested_offset:OK
 #141/5   nested_trust/test_invalid_skb_field:OK            <<<<
 #141     nested_trust:OK

The #141/2 and #141/5 are newly added.

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
2.39.3


