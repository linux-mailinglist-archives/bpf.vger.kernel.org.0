Return-Path: <bpf+bounces-27614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795C8AFDD9
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2226F1F24040
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 01:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E3D101EC;
	Wed, 24 Apr 2024 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB+aYc3v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2DCA7D
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922134; cv=none; b=Bq3WaDp/OkqK3NJ4EUoTe4SY0nn3RaoFWB5Uj1hYwAgNJXH63WayUumGUTdEFBft61gkOCu8nZn1GL9+1MY6ygcXq1CDrMcy5dj+QtXoDI47kzVdciTmL0gEsN0o8W+dvFrmVA28vpdVwAgnGU9TvHoZ1rowY8Lwk43oSJ2rhvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922134; c=relaxed/simple;
	bh=Tdj8PEmhBw//fpzzqQ3cqJbR9zPcqXUGzRE5ORM6SGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URg331a6MUyFsrvkB0/UMxrb0ZepxFtzOHXIQK9sDdjVsdC8yjNX/10mNDcJxy6JkRJhMQk4ETQo8GlQSwhDc0+LtjW5wMQDWMhObSioBdPvzmFoz0HWv7y7V6A1qiaekxFYQIzzB0pzfjeIXf08MHHMNtTBSdlsrsS8uHKpBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB+aYc3v; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2228c4c5ac3so3544553fac.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713922132; x=1714526932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5pj7SymkM183LlMpcQuiaA71zx4yWKamRf7W07OAQc=;
        b=mB+aYc3vDhX2OepIJLrijAdQGiNoWErPKW+906iiHAZFzgo9ckyRZdbRvGuLqG/yEV
         WxzFfBbvdCFtZTrA0yq0j8V6/bcHkRH1ZHEe3HNGNvSm0tKVmRl663V1mVZ2z3mrUYxk
         YNc9c5LRgX8IC7K7J35QopeMKEUlkhTYuAHAYgHTmMSmuZiM4HhGMiPAbP8bHcZrvImv
         Bwi3HLzFSnrnv7vv0Xl3UDQKPimpMkUW3A7BC9vTWtkCc6+WPWToybddXewXFj/iQts3
         VgGShiCkcvcnv/mtDc8kfFNwcjCEpNkI+Ry/GD8KnmL+hb1doXptjCkKpVo59fKwXJiv
         gmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713922132; x=1714526932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5pj7SymkM183LlMpcQuiaA71zx4yWKamRf7W07OAQc=;
        b=VTwITzcnwKMfd1umUfYYfvxHy88B6WZ3vuSrLnv31627omJ0jY4MJSpcaHQovq5pIk
         gcsYQqSJqOadM4jC1BuYzdw6BTC1VI2muIpd2lW/u1UJiOTxm/5CzWkRFD07hKefpWR8
         FwCmbK+JvaKtnlWI2GZSDs0Bc68JxfCrEMX2K8x/5AKOTmG6CYBZjg3cCCjJ2ScZntRG
         n6BiFE2nKZr789HTczn8ITvYuEUHsimhnchbfzxtdfP5OTH+WWuBeGdyp2WqgDR7SOWd
         pPFkRNX9/9KvXMeFKeUG3phnVjWQVcIYHpchqu0Fu0qvyXZdE8otlUj6309nMjyzxLUA
         A/3w==
X-Gm-Message-State: AOJu0Yzf7/RQS/FZIWkuSIDXafmPU2Kvx7U/jfnGxkSFqpJ5pf0yLl+E
	u9STpgXP33keyvdLyWjawEQY4Eqf6z1sp6tC2SPFi8Ih1c/CzAELDfL8ew==
X-Google-Smtp-Source: AGHT+IEOqqexFuVHrPFNcZx9igSN/t37QTx62Ck8bqCrNE/ZDhLcCZoVXMl5jBcasJAoglGovOXqRQ==
X-Received: by 2002:a05:6870:968e:b0:22a:1ce4:c0cf with SMTP id o14-20020a056870968e00b0022a1ce4c0cfmr1233836oaq.55.1713922132280;
        Tue, 23 Apr 2024 18:28:52 -0700 (PDT)
Received: from badger.vs.shawcable.net ([2604:3d08:9880:5900:1fa0:b3a5:f828:f414])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056a003a9800b006ed9d839c4csm10271007pfb.4.2024.04.23.18.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:28:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jemarch@gnu.org,
	thinker.li@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: dummy_st_ops should reject 0 for non-nullable params
Date: Tue, 23 Apr 2024 18:28:21 -0700
Message-Id: <20240424012821.595216-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424012821.595216-1-eddyz87@gmail.com>
References: <20240424012821.595216-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if BPF_PROG_TEST_RUN for bpf_dummy_struct_ops programs
rejects execution if NULL is passed for non-nullable parameter.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index dd926c00f414..d3d94596ab79 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -147,6 +147,31 @@ static void test_dummy_sleepable(void)
 	dummy_st_ops_success__destroy(skel);
 }
 
+/* dummy_st_ops.test_sleepable() parameter is not marked as nullable,
+ * thus bpf_prog_test_run_opts() below should be rejected as it tries
+ * to pass NULL for this parameter.
+ */
+static void test_dummy_sleepable_reject_null(void)
+{
+	__u64 args[1] = {0};
+	LIBBPF_OPTS(bpf_test_run_opts, attr,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+	);
+	struct dummy_st_ops_success *skel;
+	int fd, err;
+
+	skel = dummy_st_ops_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+		return;
+
+	fd = bpf_program__fd(skel->progs.test_sleepable);
+	err = bpf_prog_test_run_opts(fd, &attr);
+	ASSERT_EQ(err, -EINVAL, "test_run");
+
+	dummy_st_ops_success__destroy(skel);
+}
+
 void test_dummy_st_ops(void)
 {
 	if (test__start_subtest("dummy_st_ops_attach"))
@@ -159,6 +184,8 @@ void test_dummy_st_ops(void)
 		test_dummy_multiple_args();
 	if (test__start_subtest("dummy_sleepable"))
 		test_dummy_sleepable();
+	if (test__start_subtest("dummy_sleepable_reject_null"))
+		test_dummy_sleepable_reject_null();
 
 	RUN_TESTS(dummy_st_ops_fail);
 }
-- 
2.34.1


