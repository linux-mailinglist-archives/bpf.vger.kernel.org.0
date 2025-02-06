Return-Path: <bpf+bounces-50611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23987A2A002
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF41882326
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EFF223702;
	Thu,  6 Feb 2025 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO3WAayp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645302236F0;
	Thu,  6 Feb 2025 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819110; cv=none; b=taKWdb38cbl3c1WkntvwMwHkrCkaXp/wDVQQJ0GZT/thHO6jB1du/xDb8vy3KaQxo21PXHEzupo2kS7W4U5D3JTXHw6XK11u+zUgSmVpeJPHn0Zdup/DcZ6SVpk2UqOCa/bqrnpOb+WG+2bLaa+FQhft6TDANxde5Kt7E0dZaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819110; c=relaxed/simple;
	bh=5UNsqffCMdMGGL5yDqg/97mtD3zI0y0ZIN93jMf2U7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uDmVekcS4TgJJgCsvD/JjuQtDv0GhQyBDE+8Ebi01kgT7Zp3qcoFVrBsWla7yBlgOyWP1uxgISycnH0Zm5eA536mORYwHktlCLm6OEPnWCc0OUe2L8BQu8hV4j9ZYX8Fi004P8msr2HBze+59Ki6JDsL+ZUSv5PJpdTuSSZVgVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO3WAayp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f08b44937so7866705ad.1;
        Wed, 05 Feb 2025 21:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738819108; x=1739423908; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RNV+3WZEEZipZbsxDZaU3uaX0wsZtbiLD9o/9Y+Y6vM=;
        b=GO3WAaypcihIc/lwz8Xf7n/ojv9MdaQAzW3/CUXe+ZWs87azTzD1u/T++SDsOIK9cT
         AQ8sJOqN0z4RhdIz9d9XwO3f8sC8nR05JZ4MECPCr21Kg/CE9fhDzx/aVrrHqiBSAqsy
         bAwqBiv3iyVQpIx0ZpY4U+roip8GaL+KOQdEYk62JiQRZGT24bpwMwLzWV2sbEwXofBF
         uKMtPuraUV53Ltq35JGJy+A0AnnBR3HPWAZVvwHw2LvWhPiTkR18oyYCjZSF8FrhPBDP
         asSTEmfrFJ488OSlFz/Svuai2ZKPApIlvPOgRO+xNMP5Rkzye7bUNyCuz9ermjZm+tPq
         rL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819108; x=1739423908;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNV+3WZEEZipZbsxDZaU3uaX0wsZtbiLD9o/9Y+Y6vM=;
        b=f1cIwsmHOTQW/+WUdjCcoyBTtu40DwARQi3QubLfeDptkA40tm/qZ4dZZkynz99eyu
         qCPeciMkXU4BhCFhsNE1HF3Q4THSVJA5s9W3pKXOEQazxQcpfwanJRnB+BKF6IEDYHL6
         lrw9UsIGnr4FAdfEEx7DcRV6FtDdOYs03VLYFdKb4//ZGDoUoWmNCN3tYlrhsb8sNx0Y
         2D0nVcUM8JS3RERy0eikAOQnUYyR+xVYQfqgVNiypuFgKsdTp61pDN5dvYGq2V3BrCqF
         Rxn3FvINOclMyg74GYwqJXS5qqUECV14eYrMsz+lv6ECLjNx1IzcmEpiTAKTrsZVTkAx
         h88w==
X-Forwarded-Encrypted: i=1; AJvYcCXlP0Jo4N2zho2xrM2TtdYlyHEy9xX9n2GORgiLcUFl7fUjpIR3m6RhH2JRFxxNDzS0n5jq2hrunW5CxrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFjaNx1eEcXXLROeAeCcaX67kr/YobN+JC9gwol+Wc7p+HugE
	vtUtXESLdOcwR8qMyncHoYxRlByAWKI+Ds+nSROhvYixtYKqBZZj
X-Gm-Gg: ASbGnct0CAiLZIKZfNuBIP8Isi6mxKtgUmL+3LOjjHtiqGpmhPmMJXxLqqE4iMdal4u
	RIJaOrdUQjOCr8gnOKfvJmq8vNep8bwyNUV44rz/25mh/8Dl1qdD0Nvhd+z7z64Ry5OT6vJzuIT
	YICdDufUGlhHwiBFra4ulZUvSkdWZfKLA2LfRaRvZN5zXlSH4Bvpw71O3rqqCP6lNBUeA+P5aot
	3kHrKeNyyOTzyeEewtF7eev9jgVrtcegahFeJkj3IEvOs/HHYXrKfZYcBPP9f2JQ3KFx9Of3Xnu
	8o5IJPi3+mCUmwp2
X-Google-Smtp-Source: AGHT+IHvqq7pbk9T2ef28zGLGCHwloX0OLnOTGXvTJTPciVkWsXkGAA1qRfvrsa7txbJH6ji8vrZiQ==
X-Received: by 2002:a05:6a20:158a:b0:1db:ddba:8795 with SMTP id adf61e73a8af0-1ede88cac85mr9528445637.36.1738819108461;
        Wed, 05 Feb 2025 21:18:28 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad29f3sm394519b3a.53.2025.02.05.21.18.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2025 21:18:28 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Thu,  6 Feb 2025 13:15:57 +0800
Message-Id: <20250206051557.27913-5-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250206051557.27913-1-chen.dylane@gmail.com>
References: <20250206051557.27913-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Add selftests for prog_kfunc feature probing.

 ./test_progs -t libbpf_probe_kfuncs
 #153     libbpf_probe_kfuncs:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 4ed46ed58a7b..8f249ca7d5d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -126,3 +126,121 @@ void test_libbpf_probe_helpers(void)
 		ASSERT_EQ(res, d->supported, buf);
 	}
 }
+
+static int module_btf_fd(char *module)
+{
+	int fd, err;
+	__u32 id = 0, len;
+	struct bpf_btf_info info;
+	char name[64];
+
+	while (true) {
+		err = bpf_btf_get_next_id(id, &id);
+		if (err && (errno == ENOENT || errno == EPERM))
+			return 0;
+		if (err) {
+			err = -errno;
+			return err;
+		}
+		fd = bpf_btf_get_fd_by_id(id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			err = -errno;
+			return err;
+		}
+		len = sizeof(info);
+		memset(&info, 0, sizeof(info));
+		info.name = ptr_to_u64(name);
+		info.name_len = sizeof(name);
+		err = bpf_btf_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			err = -errno;
+			goto err_out;
+		}
+		/* find target module btf */
+		if (!strcmp(name, module))
+			break;
+
+		close(fd);
+	}
+
+	return fd;
+err_out:
+	close(fd);
+	return err;
+}
+
+void test_libbpf_probe_kfuncs(void)
+{
+	int ret, kfunc_id, fd;
+	char *kfunc = "bpf_cpumask_create";
+	struct btf *vmlinux_btf = NULL;
+	struct btf *module_btf = NULL;
+
+	vmlinux_btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(vmlinux_btf, "btf_parse"))
+		return;
+
+	kfunc_id = btf__find_by_name_kind(vmlinux_btf, kfunc, BTF_KIND_FUNC);
+	if (!ASSERT_GT(kfunc_id, 0, kfunc))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 0, NULL);
+	if (!ASSERT_EQ(ret, 1, "kfunc in vmlinux support"))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, 0, NULL);
+	if (!ASSERT_EQ(ret, 0, "kfunc in vmlinux not suuport"))
+		goto cleanup;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, -1, 0, NULL);
+	if (!ASSERT_EQ(ret, 0, "invalid kfunc id:-1"))
+		goto cleanup;
+
+	ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, 0, NULL);
+	if (!ASSERT_ERR(ret, "invalid prog type:100000"))
+		goto cleanup;
+
+	if (!env.has_testmod)
+		goto cleanup;
+
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!ASSERT_OK_PTR(module_btf, "load module BTF"))
+		goto cleanup;
+
+	kfunc_id = btf__find_by_name(module_btf, "bpf_kfunc_call_test1");
+	if (!ASSERT_GT(kfunc_id, 0, "func not found"))
+		goto cleanup;
+
+	fd = module_btf_fd("bpf_testmod");
+	if (!ASSERT_GT(fd, 0, "module btf fd"))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_kfunc_call_test1 in bpf_testmod */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, fd, NULL);
+	if (!ASSERT_EQ(ret, 1, "kfunc in module btf support"))
+		goto cleanup_fd;
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_kfunc_call_test1
+	 * in bpf_testmod
+	 */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, fd, NULL);
+	if (!ASSERT_EQ(ret, 0, "kfunc in module btf not support"))
+		goto cleanup_fd;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, -1, fd, NULL);
+	if (!ASSERT_EQ(ret, 0, "invalid kfunc id in module btf"))
+		goto cleanup_fd;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 100, NULL);
+	ASSERT_EQ(ret, 0, "invalid btf fd in module btf");
+
+cleanup_fd:
+	close(fd);
+cleanup:
+	btf__free(vmlinux_btf);
+	btf__free(module_btf);
+}
-- 
2.43.0


