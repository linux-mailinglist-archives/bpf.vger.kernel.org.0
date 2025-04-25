Return-Path: <bpf+bounces-56692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24969A9C9B9
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 14:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BED7188AD40
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689A2500DE;
	Fri, 25 Apr 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn+sV1+2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBB25228A
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585975; cv=none; b=qN/uxcOmpwJwH3cfe+Uf57rXNJKZ45lHQevhiAXYptpGV8tH6W/BmmFkY0lyaU8mgp1tU/5j4rJ3NHRxZHu+RC185GY59grar4T9/eIzEHwA4YVArQ/5OeInXxHu76JAR5D63ZtOS2Y1/dKyF9bpTMBKuVCikt7ZzqdGCfWrQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585975; c=relaxed/simple;
	bh=IyrX07JvnDAMUT4WCHqEf945lgzsSQz5V8yLAjCol2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7Cpb7Kihx9KRM88pFfugH2zBg9CWbr7nc3uPTh1mYCdfjVH88DBFNwjuIIjYKJDgzZbY5c1dnqut83PZ3FhqlcypuUhhuJzOVzyEs4vtmgsZZDRlwt3OOwLdUSTtt+UXyHel+Kt03qPsghJNfvQmyeL3+6QqT6mSk83VrflPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn+sV1+2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so4106057a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745585972; x=1746190772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkempJmOfBnaZd5WGcGSJpBUbgef3mPX5++ho0gwieM=;
        b=Wn+sV1+2t/qi2tGuI4lw1Z9t3BgLf3FY1UrPMfeUqjD9osmTyIRDpF4+g2m4yL5vra
         KnqMwN2OkO+K9xWoZFcLRwFtj1Y20BpEtAjFTZu4RSSMqJ3qTGLgXxhoUylLjUZKua4v
         qCOtZlHhXIZQZY0tt0zxzm1XVAOjsY6DIGtgQL2BGmAXu2ZalkHYtPkrC2qjUbxtaMZp
         m6w9tvIpaKbPeAk50IN9djkComU58z7TRiDaJGb+4/KbHr4W7FPkkiOwEFSTAq33cTRa
         IkdUtaS999qqmHAT63NZ2QCl3HkfwLwt66SPnmMg7+FoWhLuZzX9NApK/mGohbxMNZT2
         qaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585972; x=1746190772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkempJmOfBnaZd5WGcGSJpBUbgef3mPX5++ho0gwieM=;
        b=QNylsmMJ6nCorIdFi46861mNDlzGo/BHZyWBContI6Y19WwMCmm5vO/+Oa/aipzFDr
         DNbzBm7o4zmFEWyb4rQwAOEKe36psFvjKoeFexvgt0lTX5jflKFDewdt/K3HG7/ilGQz
         iUhaeggNpUKoORJzjW4zRGJG8JsxyedTuNTT2PQnEGiPuk7XMAcvSnAGqIxmtxBgPAV2
         nNj4AarTkEdTkvjsvWtr4gIISOV331aAozCwcAfah50IGN8MJEoPSaYVsdtu1DaTxz3l
         LY4vymehgGq2R43SrqZTwF72z81dLLtxS7r+g+jtTUKsA67kSLx06FK+WYeKgb3EeDer
         CGUA==
X-Gm-Message-State: AOJu0Yw/q84lH3veWGDGNA14ohjQvwnRL64RbrenDxGY8YzPciLKovne
	iqkckhpDHwauq/UDHG62p9pmGRJ0KYdvAJG43z8yKtzWuDBlZdpLvR1DAw==
X-Gm-Gg: ASbGncsASEFDHs57QzjQOjRcBLfe1XVoISWgW58q5Jnptvy0Qr9y21pIUogtac3rJas
	TecCT4RNIJ6MgKaIOYqD+yfK8WEK7wGyUdilAmN38BhuqiPKsuqg4ltNKo67jE17jOsdQiUHNS+
	WWTfjlarc0Qclm0XOWDtCja5XllsLquG2vuxjTH8mREMr7i8oP7CBfBnvF/0YmN44VeevxSw8CM
	ZAD/oqneubsIGkwv54vvLTJKR6fHMNjaLEMsW7ZKA1PzvTcoEXh7DhzUipZO95v8d6ebkXehQFN
	SYeNA7e818DFx4yqMfEOlziVeswEBkXtN8lFdrrtB+hFri45eyJo
X-Google-Smtp-Source: AGHT+IHo1oeGZwlmaPbwWc4fTydssh0U7EFKY3hDjd3HQeWRSWAwkCvXTIi1H5IA4QceApraP439DQ==
X-Received: by 2002:a05:6402:280d:b0:5e5:cb92:e760 with SMTP id 4fb4d7f45d1cf-5f722b6943dmr2024070a12.17.1745585971456;
        Fri, 25 Apr 2025 05:59:31 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:eb6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f701106bcbsm1224669a12.10.2025.04.25.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:59:30 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: introduce tests for dynptr copy kfuncs
Date: Fri, 25 Apr 2025 13:58:38 +0100
Message-ID: <20250425125839.71346-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce selftests verifying newly-added dynptr copy kfuncs.
Covering contiguous and non-contiguous memory backed dynptrs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
 .../selftests/bpf/progs/dynptr_success.c      | 201 ++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index e29cc16124c2..62e7ec775f24 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -33,10 +33,19 @@ static struct {
 	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
 	{"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
 	{"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
+	{"test_probe_read_user_dynptr", SETUP_XDP_PROG},
+	{"test_probe_read_kernel_dynptr", SETUP_XDP_PROG},
+	{"test_probe_read_user_str_dynptr", SETUP_XDP_PROG},
+	{"test_probe_read_kernel_str_dynptr", SETUP_XDP_PROG},
+	{"test_copy_from_user_dynptr", SETUP_SYSCALL_SLEEP},
+	{"test_copy_from_user_str_dynptr", SETUP_SYSCALL_SLEEP},
+	{"test_copy_from_user_task_dynptr", SETUP_SYSCALL_SLEEP},
+	{"test_copy_from_user_task_str_dynptr", SETUP_SYSCALL_SLEEP},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
 {
+	char user_data[384] = {[0 ... 382] = 'a', '\0'};
 	struct dynptr_success *skel;
 	struct bpf_program *prog;
 	struct bpf_link *link;
@@ -58,6 +67,10 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 	if (!ASSERT_OK(err, "dynptr_success__load"))
 		goto cleanup;
 
+	skel->bss->user_ptr = user_data;
+	skel->data->test_len[0] = sizeof(user_data);
+	memcpy(skel->bss->expected_str, user_data, sizeof(user_data));
+
 	switch (setup_type) {
 	case SETUP_SYSCALL_SLEEP:
 		link = bpf_program__attach(prog);
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e1fba28e4a86..753d35eb47d9 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -680,3 +680,204 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
 	return XDP_DROP;
 }
+
+void *user_ptr;
+char expected_str[384]; /* Contains the copy of the data pointed by user_ptr */
+__u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};
+
+typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u32 off,
+				    u32 size, const void *unsafe_ptr);
+
+static __always_inline void test_dynptr_probe(void *ptr, bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
+{
+	char buf[sizeof(expected_str)];
+	struct bpf_dynptr ptr_buf;
+	int i;
+
+	err = bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr_buf);
+
+	bpf_for(i, 0, ARRAY_SIZE(test_len)) {
+		__u32 len = test_len[i];
+
+		err = err ?: bpf_read_dynptr_fn(&ptr_buf, 0, test_len[i], ptr);
+		if (len > sizeof(buf))
+			break;
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0);
+
+		if (err || bpf_memcmp(expected_str, buf, len))
+			err = 1;
+
+		/* Reset buffer and dynptr */
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_write(&ptr_buf, 0, buf, len, 0);
+	}
+	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
+}
+
+static __always_inline void test_dynptr_probe_str(void *ptr,
+						  bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
+{
+	char buf[sizeof(expected_str)];
+	struct bpf_dynptr ptr_buf;
+	__u32 cnt, i;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr_buf);
+
+	bpf_for(i, 0, ARRAY_SIZE(test_len)) {
+		__u32 len = test_len[i];
+
+		cnt = bpf_read_dynptr_fn(&ptr_buf, 0, len, ptr);
+		if (cnt != len)
+			err = 1;
+
+		if (len > sizeof(buf))
+			continue;
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0);
+		if (!len)
+			continue;
+		if (err || bpf_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
+			err = 1;
+	}
+	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
+}
+
+static __always_inline void test_dynptr_probe_xdp(struct xdp_md *xdp, void *ptr,
+						  bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
+{
+	struct bpf_dynptr ptr_xdp;
+	char buf[sizeof(expected_str)];
+	__u32 off, i;
+
+	/* Set offset near the seam between buffers */
+	off = 3500;
+
+	err = bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+
+	bpf_for(i, 0, ARRAY_SIZE(test_len)) {
+		__u32 len = test_len[i];
+
+		err = err ?: bpf_read_dynptr_fn(&ptr_xdp, off, len, ptr);
+		if (len > sizeof(buf))
+			continue;
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, off, 0);
+		if (err || bpf_memcmp(expected_str, buf, len))
+			err = 1;
+		/* Reset buffer and dynptr */
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_write(&ptr_xdp, off, buf, len, 0);
+	}
+}
+
+static __always_inline void test_dynptr_probe_str_xdp(struct xdp_md *xdp, void *ptr,
+						      bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
+{
+	struct bpf_dynptr ptr_xdp;
+	char buf[sizeof(expected_str)];
+	__u32 cnt, off, i;
+
+	/* Set offset near the seam between buffers */
+	off = 3500;
+	err = bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+	if (err)
+		return;
+
+	bpf_for(i, 0, ARRAY_SIZE(test_len)) {
+		__u32 len = test_len[i];
+
+		cnt = bpf_read_dynptr_fn(&ptr_xdp, off, len, ptr);
+		if (cnt != len)
+			err = 1;
+
+		if (len > sizeof(buf))
+			continue;
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, off, 0);
+
+		if (!len)
+			continue;
+		if (err || bpf_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
+			err = 1;
+
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_write(&ptr_xdp, off, buf, len, 0);
+	}
+}
+
+SEC("xdp")
+int test_probe_read_user_dynptr(struct xdp_md *xdp)
+{
+	test_dynptr_probe(user_ptr, bpf_probe_read_user_dynptr);
+	if (!err)
+		test_dynptr_probe_xdp(xdp, user_ptr, bpf_probe_read_user_dynptr);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int test_probe_read_kernel_dynptr(struct xdp_md *xdp)
+{
+	test_dynptr_probe(expected_str, bpf_probe_read_kernel_dynptr);
+	if (!err)
+		test_dynptr_probe_xdp(xdp, expected_str, bpf_probe_read_kernel_dynptr);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int test_probe_read_user_str_dynptr(struct xdp_md *xdp)
+{
+	test_dynptr_probe_str(user_ptr, bpf_probe_read_user_str_dynptr);
+	if (!err)
+		test_dynptr_probe_str_xdp(xdp, user_ptr, bpf_probe_read_user_str_dynptr);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int test_probe_read_kernel_str_dynptr(struct xdp_md *xdp)
+{
+	test_dynptr_probe_str(expected_str, bpf_probe_read_kernel_str_dynptr);
+	if (!err)
+		test_dynptr_probe_str_xdp(xdp, expected_str, bpf_probe_read_kernel_str_dynptr);
+	return XDP_PASS;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_dynptr(void *ctx)
+{
+	test_dynptr_probe(user_ptr, bpf_copy_from_user_dynptr);
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_str_dynptr(void *ctx)
+{
+	test_dynptr_probe_str(user_ptr, bpf_copy_from_user_str_dynptr);
+	return 0;
+}
+
+static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u32 off,
+					u32 size, const void *unsafe_ptr)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	return bpf_copy_from_user_task_dynptr(dptr, off, size, unsafe_ptr, task);
+}
+
+static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u32 off,
+					    u32 size, const void *unsafe_ptr)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	return bpf_copy_from_user_task_str_dynptr(dptr, off, size, unsafe_ptr, task);
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_task_dynptr(void *ctx)
+{
+	test_dynptr_probe(user_ptr, bpf_copy_data_from_user_task);
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_task_str_dynptr(void *ctx)
+{
+	test_dynptr_probe_str(user_ptr, bpf_copy_data_from_user_task_str);
+	return 0;
+}
-- 
2.49.0


