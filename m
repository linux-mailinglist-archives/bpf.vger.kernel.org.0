Return-Path: <bpf+bounces-46686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4179EDFF1
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 08:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584F8188AEC5
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E32063D1;
	Thu, 12 Dec 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2a6+zli"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AABD205E3E
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987249; cv=none; b=TKTqyqK0WiTO6iL7Yq5Rs8ceEhbgllsDBC0E/3+lrWzZXbHU3ya5B0XXyBqok4y3fWc6vaTPU9xNv4XJGueFqywZFKXSogm7DHbuvMhoCvwrHRgBFIm9kfh6CYumMbkSWy+tnAPPA83GTJPMOmvyYPAoT5fdjNSsXvfbCzUr9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987249; c=relaxed/simple;
	bh=neiKh/ySd/jWshfjyWTkF9MB6iQ7j3Qdp2E1o6QAe5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8SNQONNqAt1MQtjztPeAnJu9+KbkcoWnBcCMaaywOnMG/KbwjvxjcC8vxCb7WspYawckVqixQ0sYgkRvgMGulVXRTFWs9l9RtBODKBZgw1nH782rvdKa9YVDyzsUigTjevIQsDzSgpJAbOrrpu4RwJ82BET1Sdob/iI1zNSOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2a6+zli; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso234234a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 23:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987247; x=1734592047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1zGB1OOo8p1uJ3FThl0NA1SouwQd9pU+CVUXtc95bw=;
        b=Q2a6+zliet8RMb0meB0cZRwp03MDhxGLaHaOSeioQGS7HKvYDGA2+ejr0msQh8S7xC
         tSOnQAKkqRS0XhqsusGW5+e89UGF7FSt2W/UsAtyWnlgr0UzB/nXpRFeQA8aJxbHZgKl
         5VCiZ90B2YL/wueoHX35w9zofJUKPciEEaeEGdGAueg+KSJ542oUg3w5tJv3A1sJL/eR
         NlZgtPBRUNF5kL1m3fp+r61+KNO1XCXbVXsNh0ET5L3wsDdLl9FIWhKi09QH7+Qqm8cD
         eGN9WW8b/TCi5ozxECYdHtLrD2lIB1GZktt6E8qhIpOiBLvKZxKQEE/tImehTedvbBXN
         7Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987247; x=1734592047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1zGB1OOo8p1uJ3FThl0NA1SouwQd9pU+CVUXtc95bw=;
        b=mCoK5kEZBXQJ4IORXer0nBA+9Vh6KfBFLw93Xh2m5zXKxFNuKME57xmgJEw2WmvNlz
         R06Nhx1bmX4mPyQrGI0ZIfsWVs+LvECrN4gySiaGFeUssyKFRyUCNf0FMAi2ZGl2yIeP
         7o4F1ts7ZR7hV6IVfuH7burXeJLR/jn7WKKypqdy89k1/1MJ59WTRcExWMw0TivXq0qx
         CW0KcH0zBImTIj/0INarrHUqBdaJw1qlTma3QpZwUXFvUIOVMYI1edl4FgllARwSDONv
         a6NMq36aSzAUkYzTSv/TYH4Jf5tgq9fZJxrqTDc56JEbBqrjSq0U1JUzIea1SQg2G+9t
         CMuw==
X-Gm-Message-State: AOJu0YyRitq+ZGNCfVsHCqzBvYz6TGUKqEj9HZ9IvDeqAk4FnF92eNAk
	rBriy7egO5wjFLdXjC8lT2BClNEKOrGaFBadtrbASbj5jnclTuC8AGsDwQ==
X-Gm-Gg: ASbGncs008zID/qaTGFc3uPrDHG7LIBafkPMmltFlo9/n/dYeY+16MOiXXXpyx4fm9V
	cd7Nrk5EOm0wEUe+m4j9kKyFfxuFPkZv6UvMPrQ4MhDnZyvNrXQRiA3yj2Y6IyndZzjEWsjUB+S
	2IpZ0MUL/2uSnq4WAi3cfJtPr6NcqaMHrJP0PKGBWeACzxTTUX66Yq0ldtXNTQ8O5QFBVYGT8+y
	WrnMhQMoa+9YTsTXhhiH/Ayp2sMrWH4ULiX0Ijwj7ccajY1amJQ
X-Google-Smtp-Source: AGHT+IG6WA6X/FnjY+7ZBryToB4sosMJaRG16ozT4bn2cykp03BcBsBUGNNTBF9ItLdxhCHkjo8NCg==
X-Received: by 2002:a17:90b:3803:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2f139295908mr4808207a91.14.1733987247177;
        Wed, 11 Dec 2024 23:07:27 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bd8sm600217a91.10.2024.12.11.23.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:07:26 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: extend changes_pkt_data with cases w/o subprograms
Date: Wed, 11 Dec 2024 23:07:11 -0800
Message-ID: <20241212070711.427443-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241212070711.427443-1-eddyz87@gmail.com>
References: <20241212070711.427443-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend changes_pkt_data tests with test cases freplacing the main
program that does not have subprograms. Try four combinations when
both main program and replacement do and do not change packet data.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/changes_pkt_data.c         | 55 +++++++++++++++----
 .../selftests/bpf/progs/changes_pkt_data.c    | 27 ++++++---
 .../bpf/progs/changes_pkt_data_freplace.c     |  6 +-
 3 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
index c0c7202f6c5c..7526de379081 100644
--- a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
@@ -10,10 +10,14 @@ static void print_verifier_log(const char *log)
 		fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log);
 }
 
-static void test_aux(const char *main_prog_name, const char *freplace_prog_name, bool expect_load)
+static void test_aux(const char *main_prog_name,
+		     const char *to_be_replaced,
+		     const char *replacement,
+		     bool expect_load)
 {
 	struct changes_pkt_data_freplace *freplace = NULL;
 	struct bpf_program *freplace_prog = NULL;
+	struct bpf_program *main_prog = NULL;
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct changes_pkt_data *main = NULL;
 	char log[16*1024];
@@ -26,6 +30,10 @@ static void test_aux(const char *main_prog_name, const char *freplace_prog_name,
 	main = changes_pkt_data__open_opts(&opts);
 	if (!ASSERT_OK_PTR(main, "changes_pkt_data__open"))
 		goto out;
+	main_prog = bpf_object__find_program_by_name(main->obj, main_prog_name);
+	if (!ASSERT_OK_PTR(main_prog, "main_prog"))
+		goto out;
+	bpf_program__set_autoload(main_prog, true);
 	err = changes_pkt_data__load(main);
 	print_verifier_log(log);
 	if (!ASSERT_OK(err, "changes_pkt_data__load"))
@@ -33,14 +41,14 @@ static void test_aux(const char *main_prog_name, const char *freplace_prog_name,
 	freplace = changes_pkt_data_freplace__open_opts(&opts);
 	if (!ASSERT_OK_PTR(freplace, "changes_pkt_data_freplace__open"))
 		goto out;
-	freplace_prog = bpf_object__find_program_by_name(freplace->obj, freplace_prog_name);
+	freplace_prog = bpf_object__find_program_by_name(freplace->obj, replacement);
 	if (!ASSERT_OK_PTR(freplace_prog, "freplace_prog"))
 		goto out;
 	bpf_program__set_autoload(freplace_prog, true);
 	bpf_program__set_autoattach(freplace_prog, true);
 	bpf_program__set_attach_target(freplace_prog,
-				       bpf_program__fd(main->progs.dummy),
-				       main_prog_name);
+				       bpf_program__fd(main_prog),
+				       to_be_replaced);
 	err = changes_pkt_data_freplace__load(freplace);
 	print_verifier_log(log);
 	if (expect_load) {
@@ -62,15 +70,38 @@ static void test_aux(const char *main_prog_name, const char *freplace_prog_name,
  * that either do or do not. It is only ok to freplace subprograms
  * that do not change packet data with those that do not as well.
  * The below tests check outcomes for each combination of such freplace.
+ * Also test a case when main subprogram itself is replaced and is a single
+ * subprogram in a program.
  */
 void test_changes_pkt_data_freplace(void)
 {
-	if (test__start_subtest("changes_with_changes"))
-		test_aux("changes_pkt_data", "changes_pkt_data", true);
-	if (test__start_subtest("changes_with_doesnt_change"))
-		test_aux("changes_pkt_data", "does_not_change_pkt_data", true);
-	if (test__start_subtest("doesnt_change_with_changes"))
-		test_aux("does_not_change_pkt_data", "changes_pkt_data", false);
-	if (test__start_subtest("doesnt_change_with_doesnt_change"))
-		test_aux("does_not_change_pkt_data", "does_not_change_pkt_data", true);
+	struct {
+		const char *main;
+		const char *to_be_replaced;
+		bool changes;
+	} mains[] = {
+		{ "main_with_subprogs",   "changes_pkt_data",         true },
+		{ "main_with_subprogs",   "does_not_change_pkt_data", false },
+		{ "main_changes",         "main_changes",             true },
+		{ "main_does_not_change", "main_does_not_change",     false },
+	};
+	struct {
+		const char *func;
+		bool changes;
+	} replacements[] = {
+		{ "changes_pkt_data",         true },
+		{ "does_not_change_pkt_data", false }
+	};
+	char buf[64];
+
+	for (int i = 0; i < ARRAY_SIZE(mains); ++i) {
+		for (int j = 0; j < ARRAY_SIZE(replacements); ++j) {
+			snprintf(buf, sizeof(buf), "%s_with_%s",
+				 mains[i].to_be_replaced, replacements[j].func);
+			if (!test__start_subtest(buf))
+				continue;
+			test_aux(mains[i].main, mains[i].to_be_replaced, replacements[j].func,
+				 mains[i].changes || !replacements[j].changes);
+		}
+	}
 }
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data.c b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
index f87da8e9d6b3..43cada48b28a 100644
--- a/tools/testing/selftests/bpf/progs/changes_pkt_data.c
+++ b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
@@ -4,22 +4,35 @@
 #include <bpf/bpf_helpers.h>
 
 __noinline
-long changes_pkt_data(struct __sk_buff *sk, __u32 len)
+long changes_pkt_data(struct __sk_buff *sk)
 {
-	return bpf_skb_pull_data(sk, len);
+	return bpf_skb_pull_data(sk, 0);
 }
 
 __noinline __weak
-long does_not_change_pkt_data(struct __sk_buff *sk, __u32 len)
+long does_not_change_pkt_data(struct __sk_buff *sk)
 {
 	return 0;
 }
 
-SEC("tc")
-int dummy(struct __sk_buff *sk)
+SEC("?tc")
+int main_with_subprogs(struct __sk_buff *sk)
+{
+	changes_pkt_data(sk);
+	does_not_change_pkt_data(sk);
+	return 0;
+}
+
+SEC("?tc")
+int main_changes(struct __sk_buff *sk)
+{
+	bpf_skb_pull_data(sk, 0);
+	return 0;
+}
+
+SEC("?tc")
+int main_does_not_change(struct __sk_buff *sk)
 {
-	changes_pkt_data(sk, 0);
-	does_not_change_pkt_data(sk, 0);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c b/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
index 0e525beb8603..f9a622705f1b 100644
--- a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
+++ b/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
@@ -4,13 +4,13 @@
 #include <bpf/bpf_helpers.h>
 
 SEC("?freplace")
-long changes_pkt_data(struct __sk_buff *sk, __u32 len)
+long changes_pkt_data(struct __sk_buff *sk)
 {
-	return bpf_skb_pull_data(sk, len);
+	return bpf_skb_pull_data(sk, 0);
 }
 
 SEC("?freplace")
-long does_not_change_pkt_data(struct __sk_buff *sk, __u32 len)
+long does_not_change_pkt_data(struct __sk_buff *sk)
 {
 	return 0;
 }
-- 
2.47.0


