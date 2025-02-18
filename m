Return-Path: <bpf+bounces-51857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D065A3A69F
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B8C7A35DE
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD961E521B;
	Tue, 18 Feb 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edGjNkYo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B91E521F
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905285; cv=none; b=X7rkAOpeYZj4rZIt6o9MOv0r8LsyddqXUg4Ji1UZyHGQl72T8jc63CuB7n6k6DjJrxM9ByEhIF3NDXnBNE4hxUGImOulWfclHCphwSrhcTvA1jtWwsc+bpEDUyUo48p5QkTBS8cPC1s0bMibxaK2cW2SW4ULjOnD5Dqg5Sk9Ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905285; c=relaxed/simple;
	bh=Kt3mH95b5H9nc1coou7hewl0NkP5AmQbREHN2zbVopA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVl4/5EqbN5K5d0jwnyDfrMyOCSplwsUzx8RMVHMNmRrLFhrNN6kK0zLm7jaWjmO2IEhbSI0JBxwLwvNhMpzLrlgljpupa/TRlXCHaqsOrWsNVXNbEw2QzMG/oBjYokVWanobtgDhBvpZl/iKjEY9FMVN8R+eLCnrg1QEOELKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edGjNkYo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so6097480a12.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 11:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905282; x=1740510082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYvKg89FXx57N3Mi662936PgeqbMmX7HDtH6IYMmr0o=;
        b=edGjNkYoPT2r5mho3cvBqE0qu6K/DBgjlaU4EXbpgFO724lx7RQ//8cYnqN7EAGEip
         Z6OVWja+pWeMCXBSC/hD88WMOBXOSC2IrHV2vmyGuM6tuVep8lSHs8wm0084ABwjpwfi
         kn2bD/Eonpbfrc74mLh6h9HzBDE3Er0H4NAUP7yexcEY5Uukvjqp4aPVwc8zesfLyETB
         8nEfmkiKK6cBWxl8RA3cc2bxspcRJIJAoVyzc+gmGb6QcMYbw+ANRGxhRtSHSWobiscd
         65agrtT4jsw9daTe+QwqNjV5oxrgcxuNAol3ud7TDMT32d+paQuuzGgGu7UEPSUf5FKs
         z2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905282; x=1740510082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYvKg89FXx57N3Mi662936PgeqbMmX7HDtH6IYMmr0o=;
        b=Fo6DsRwdrqlkFWEa8rAZrNmzzfmJBdIXWGgN7ggjs88nnuVOpm0JWWAjeisT5nhUoI
         WR+iA1A4JfHdrqSslSJc3VbCDWjzpATPlqxva2BO0BZXkTNoyFw8fztvTEs0+ThPjlZl
         nAYD3kmW+ofCtMYOxfxSEBOD7gF/K9eWuBQxCTco9CttimBReKO6rdR+ClMV/RiJcUHm
         n87UMd4WQiihC/yX/xKZW/TWWA5zV6+GGTbvjJNq2l2NggmtixiLEb4Gy//s5pBOMFLb
         jOYc4QGJZGqHKtAbrw+6LAavyDBoSzZevdrUsssivlX1vPJfLQLYolAxNRBHOu8+fwJp
         GSdg==
X-Gm-Message-State: AOJu0YwTkJmrxYSKePi9zzbIcp0pI6cKNlbbZq+wmT60U0zjHMHjqrvR
	gAQE0nHV0ngiDp7kNicSrvawyos3NwjxM2R0nb5Y1JXNnmv2OJYr4aOQTg==
X-Gm-Gg: ASbGnculBh7AWrB5r7nWYsnP+JaxTuT6J0AsoBWQ6A/bciy0TFOCZTcqRSG1Sfr7guA
	k5B4BQGvdkoWwcjBiDG4Vvq0au1MgBRMb2gMYHLR4qmM3BypIPLtKCCIzHwgrFCD18+uOV07YqP
	YtrcUEXDGi7PiCrn5CY3+EsL/FW9zwHSAwyC+QF2jwYQK5njnHNL5k3aCyHbFACl/fZTGA65HK/
	Wk5RXWHmOhp25CAKj2pKUskR/xbjjio6rucUoUAWNCgkEDbBZ0Dg+/gM15NGsqUm7ntxCmHsHgT
	j/J1dtR/1CLSqX5t5tSlJeRz0ifqzA==
X-Google-Smtp-Source: AGHT+IFTwMAKpL59mEL31Pd1VlKOzd9zqznvt5aMoEEBrzM4Oqj5q8TpXFCkwDXKuDtA3T/ISiXEpg==
X-Received: by 2002:a05:6402:440d:b0:5d9:b84:a01f with SMTP id 4fb4d7f45d1cf-5e0360a6974mr13840289a12.18.1739905281554;
        Tue, 18 Feb 2025 11:01:21 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:4cdf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e02ebeaaa1sm6248540a12.5.2025.02.18.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:01:20 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add tests for bpf_dynptr_copy
Date: Tue, 18 Feb 2025 19:00:27 +0000
Message-ID: <20250218190027.135888-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add XDP setup type for dynptr tests, enabling testing for
non-contiguous buffer.
Add 2 tests:
 - test_dynptr_copy - verify correctness for the fast (contiguous
 buffer) code path.
 - test_dynptr_copy_xdp - verifies code paths that handle
 non-contiguous buffer.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 ++
 .../testing/selftests/bpf/prog_tests/dynptr.c | 25 ++++++
 .../selftests/bpf/progs/dynptr_success.c      | 77 +++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 8215c9b3115e..e9c193036c82 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -43,6 +43,14 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym __weak;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym __weak;
 
+/* Description
+ *  Copy data from one dynptr to another
+ * Returns
+ *  Error code
+ */
+extern int bpf_dynptr_copy(struct bpf_dynptr *dst, __u32 dst_off,
+			   struct bpf_dynptr *src, __u32 src_off, __u32 size) __ksym __weak;
+
 /* Description
  *  Modify the address of a AF_UNIX sockaddr.
  * Returns
diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index b614a5272dfd..247618958155 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -10,6 +10,7 @@ enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
 	SETUP_SKB_PROG_TP,
+	SETUP_XDP_PROG,
 };
 
 static struct {
@@ -18,6 +19,8 @@ static struct {
 } success_tests[] = {
 	{"test_read_write", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_data", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_copy_xdp", SETUP_XDP_PROG},
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
@@ -120,6 +123,28 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 
 		break;
 	}
+	case SETUP_XDP_PROG:
+	{
+		char data[5000];
+		int err, prog_fd;
+
+		LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = sizeof(data),
+			    .repeat = 1,
+		);
+
+		prog_fd = bpf_program__fd(prog);
+		if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
+			goto cleanup;
+
+		err = bpf_prog_test_run_opts(prog_fd, &opts);
+
+		if (!ASSERT_OK(err, "test_run"))
+			goto cleanup;
+
+		break;
+	}
 	}
 
 	ASSERT_EQ(skel->bss->err, 0, "err");
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index bfcc85686cf0..8a6b35418e39 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -567,3 +567,80 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
 
 	return 1;
 }
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_copy(void *ctx)
+{
+	char *data = "hello there, world!!";
+	char buf[32] = {'\0'};
+	__u32 sz = strlen(data);
+	struct bpf_dynptr src, dst;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &src);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &dst);
+
+	err = bpf_dynptr_write(&src, 0, data, sz, 0);
+	err = err ?: bpf_dynptr_copy(&dst, 0, &src, 0, sz);
+	err = err ?: bpf_dynptr_read(buf, sz, &dst, 0, 0);
+	err = err ?: __builtin_memcmp(data, buf, sz);
+
+	err = err ?: bpf_dynptr_copy(&dst, 3, &src, 5, sz - 5);
+	err = err ?: bpf_dynptr_read(buf, sz - 5, &dst, 3, 0);
+	err = err ?: __builtin_memcmp(data + 5, buf, sz - 5);
+
+	bpf_ringbuf_discard_dynptr(&src, 0);
+	bpf_ringbuf_discard_dynptr(&dst, 0);
+	return 0;
+}
+
+SEC("xdp")
+int test_dynptr_copy_xdp(struct xdp_md *xdp)
+{
+	struct bpf_dynptr ptr_buf, ptr_xdp;
+	char *data = "qwertyuiopasdfghjkl;";
+	char buf[32] = {'\0'};
+	__u32 len = strlen(data);
+	int i, chunks = 200;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
+
+	bpf_for(i, 0, chunks) {
+		err =  err ?: bpf_dynptr_write(&ptr_buf, i * len, data, len, 0);
+	}
+
+	err = err ?: bpf_dynptr_copy(&ptr_xdp, 0, &ptr_buf, 0, len * chunks);
+
+	bpf_for(i, 0, chunks) {
+		memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, i * len, 0);
+		err = err ?: memcmp(data, buf, len);
+	}
+
+	memset(buf, 0, sizeof(buf));
+	bpf_for(i, 0, chunks) {
+		err = err ?: bpf_dynptr_write(&ptr_buf, i * len, buf, len, 0);
+	}
+
+	err = err ?: bpf_dynptr_copy(&ptr_buf, 0, &ptr_xdp, 0, len * chunks);
+
+	bpf_for(i, 0, chunks) {
+		memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, i * len, 0);
+		err = err ?: memcmp(data, buf, len);
+	}
+
+	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
+
+	err = err ?: bpf_dynptr_copy(&ptr_xdp, 2, &ptr_xdp, len, len * (chunks - 1));
+
+	bpf_for(i, 0, chunks - 1) {
+		memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, 2 + i * len, 0);
+		err = err ?: memcmp(data, buf, len);
+	}
+
+	err = err ?: (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len * chunks) == -E2BIG ? 0 : 1);
+
+	return XDP_DROP;
+}
-- 
2.48.1


