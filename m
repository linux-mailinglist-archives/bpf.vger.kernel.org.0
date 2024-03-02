Return-Path: <bpf+bounces-23218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFE286EDCA
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB981F23239
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD57490;
	Sat,  2 Mar 2024 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isWawBPd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255A7464
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342384; cv=none; b=Fm7ai4A/pbPc0ilyTqBJENa3KjwcsRZhplkQNJDmypiLZzyW0fqMuDJExCPcuPdkVSUzf7MdQOhJMxydKXC1dsTOduWRNhEp+1C2T5Pu2kKezPGhlItNqFk4tMvx5toUAsh0MTry/Avfj3xd2KJHI+E/nlPFya+XeedTNWVos8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342384; c=relaxed/simple;
	bh=zV/RB5EXo6qwUaRe+c4r7c329aduzNSbkkEXrlo/8L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk3Y8u28WZ+BlBUYA8dvEAsZLEch0UYz+9OiiDzqpcUZbNhoPiCCV8VrGpQIEGueKLcjrlRyu72PQoubfusxdxXP6zV3Cj0HeoyuROz54BpB05+TdiOwLMZKh+tliUIMKzlRUNMaAF9LTHna7gXIELeWB4pW0qSJkVZUY6wDyys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isWawBPd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d311081954so26546761fa.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342380; x=1709947180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki6OFj/2RK5ad0QaqWrtytsE2QFidQdKKWOOEY5Z/2E=;
        b=isWawBPdt2ICtKjc7HmgZPM2hX6l6+NyR+oDycdy7DedPKr2SnVxoSE4MOuY3Qlioj
         HpTdzGH8O2sD3vYAiPSdl6pVJWSHSh9AOBscvUyqNJg6JP50Yr05j3miotzNWzmYvF9f
         ULIt6GDE51uQlz96HJubcxraY2qHmK5BM2P/xRtbZw1cj7N0RKEU+G/ixz55eISO+7xn
         +ANWJ6LvbNhs8uAxDYoAqmnXe9ls4hSRiW1+7Cx9wkRbkiiudgrLz8TN8pSUinmDUFxp
         oWH/pNFEryUS6cLlaGY6t0/8jFP4DqwPTZAtCuMHiT+giC3X/GxkuG52Ye7MCl6jdh22
         6Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342380; x=1709947180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki6OFj/2RK5ad0QaqWrtytsE2QFidQdKKWOOEY5Z/2E=;
        b=vLCMrLM5sS7WPZUQ7E55VMmjJFodxZeBv5lwJBD+MKH4Ewj0Ja2bbnpCdwVLQG0dzS
         o3+dgdS3wGEU9qQrdHztH3eb8khQxR9BNyrlOPpMtIiR8DteehhI0LhpyqT1cXHn/0J1
         SGnTBOaQu7D7zQvX2uAAzITQ0H25Ou+G7m9OGkrVtqJlULPZ2IcLxvyfBIrr9PY1fUdM
         bEGTp2UoHcsGzYwDnmtzH18QysbvZ3SKkl/44uSCQwgsnCcFsN0WhvJBqF8wjhx5v7XT
         Cp/CZtlgC5KPC1508xS8nWvGcgQV7LIHc2ehiJOszO44aAJfPgu9FNc5aNixGN8433V+
         7VMw==
X-Gm-Message-State: AOJu0YzuawfFdCq4BJcEsoknoZCUfe74lSiSwAMq364vOJdoKu01gdRh
	ptJ5LxblM8Le7T45p6XGxuyrJbTC2ptN+GEP+ie95uMWgwbX5cJj0/2tq1l/
X-Google-Smtp-Source: AGHT+IG6aEVx4SSZ1+al5/1POg1gBrwe4nYJaVpWgzZqYms5+svLFp+VRgbdFw5T6cHw3rltGCWSbQ==
X-Received: by 2002:a2e:9bc6:0:b0:2d2:3b18:6ffd with SMTP id w6-20020a2e9bc6000000b002d23b186ffdmr2150465ljj.41.1709342380448;
        Fri, 01 Mar 2024 17:19:40 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:40 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 05/15] selftests/bpf: utility functions to capture libbpf log in test_progs
Date: Sat,  2 Mar 2024 03:19:10 +0200
Message-ID: <20240302011920.15302-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several test_progs tests already capture libbpf log in order to check
for some expected output, e.g bpf_tcp_ca.c, kfunc_dynptr_param.c,
log_buf.c and a few others.

This commit provides a, hopefully, simple API to capture libbpf log
w/o necessity to define new print callback in each test:

    /* Creates a global memstream capturing all output passed to
     * libbpf_print_fn.
     * Returns 0 on success, negative value on failure.
     * On failure the description is printed using PRINT_FAIL and
     * current test case is marked as fail.
     */
    int start_libbpf_log_capture(void)

    /* Destroys global memstream created by start_libbpf_log_capture().
     * Returns a pointer to captured data which has to be freed.
     * Returned buffer is null terminated.
     */
    char *stop_libbpf_log_capture(void)

The intended usage is as follows:

    if (start_libbpf_log_capture())
            return;
    use_libbpf();
    char *log = stop_libbpf_log_capture();
    ASSERT_HAS_SUBSTR(log, "... expected ...", "expected some message");
    free(log);

As a safety measure, free(start_libbpf_log_capture()) is invoked in the
epilogue of the test_progs.c:run_one_test().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 57 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 808550986f30..698c7387b310 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -683,9 +683,65 @@ static const struct argp_option opts[] = {
 	{},
 };
 
+static FILE *libbpf_capture_stream;
+
+static struct {
+	char *buf;
+	size_t buf_sz;
+} libbpf_output_capture;
+
+/* Creates a global memstream capturing all output passed to libbpf_print_fn.
+ * Returns 0 on success, negative value on failure.
+ * On failure the description is printed using PRINT_FAIL and
+ * current test case is marked as fail.
+ */
+int start_libbpf_log_capture(void)
+{
+	if (libbpf_capture_stream) {
+		PRINT_FAIL("%s: libbpf_capture_stream != NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	libbpf_capture_stream = open_memstream(&libbpf_output_capture.buf,
+					       &libbpf_output_capture.buf_sz);
+	if (!libbpf_capture_stream) {
+		PRINT_FAIL("%s: open_memstream failed errno=%d\n", __func__, errno);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Destroys global memstream created by start_libbpf_log_capture().
+ * Returns a pointer to captured data which has to be freed.
+ * Returned buffer is null terminated.
+ */
+char *stop_libbpf_log_capture(void)
+{
+	char *buf;
+
+	if (!libbpf_capture_stream)
+		return NULL;
+
+	fputc(0, libbpf_capture_stream);
+	fclose(libbpf_capture_stream);
+	libbpf_capture_stream = NULL;
+	/* get 'buf' after fclose(), see open_memstream() documentation */
+	buf = libbpf_output_capture.buf;
+	bzero(&libbpf_output_capture, sizeof(libbpf_output_capture));
+	return buf;
+}
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 			   const char *format, va_list args)
 {
+	if (libbpf_capture_stream) {
+		va_list args2;
+
+		va_copy(args2, args);
+		vfprintf(libbpf_capture_stream, format, args2);
+	}
+
 	if (env.verbosity < VERBOSE_VERY && level == LIBBPF_DEBUG)
 		return 0;
 	vfprintf(stdout, format, args);
@@ -1081,6 +1137,7 @@ static void run_one_test(int test_num)
 		cleanup_cgroup_environment();
 
 	stdio_restore();
+	free(stop_libbpf_log_capture());
 
 	dump_test_log(test, state, false, false, NULL);
 }
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 80df51244886..0ba5a20b19ba 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -397,6 +397,9 @@ int test__join_cgroup(const char *path);
 		system(cmd);						\
 	})
 
+int start_libbpf_log_capture(void);
+char *stop_libbpf_log_capture(void);
+
 static inline __u64 ptr_to_u64(const void *ptr)
 {
 	return (__u64) (unsigned long) ptr;
-- 
2.43.0


