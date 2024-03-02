Return-Path: <bpf+bounces-23228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BD186EDD4
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3312875DF
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08069CA50;
	Sat,  2 Mar 2024 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsbYamJv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEE6FB5
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342395; cv=none; b=DajOqDC7KcWD0v58emzmmMGy1fW4v2rqWrC4IzrZR5cbnYptiLBDB3skWl8xKde6uhCnkM2dcyIZ4RvWjl8FI1MFeHVW8StPoV+MaGxvMJ8NF1a8I55iuDfohvZgP4TvvbsXrZtr9iGQzeA3YKhX9EuUmxuric0W2bCyMCZ7HLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342395; c=relaxed/simple;
	bh=AYRFrFsme20cwtwcfp7bMqH+JFxsSxvqP14s1SLy364=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWaecLM7bgrCXKumX28vNZfi4Gnk4APgcOfJqWVMM+Rf7ysXM3tIHk0ejS4900ss6S8F0lAWj05dSYuVT4UHFhbdMEULhQPPwVYEHFtL5EKd6q+2Rdgn7DTAyblYD/wD1tvHfbPM7DCkm0p9M8TDtGhM5Tfy0ffe6G8brvsY4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsbYamJv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d220e39907so36515831fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342392; x=1709947192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUKVRagEjVbWTLTtfvO897pmVhBdhZlyN2rymNdpliI=;
        b=nsbYamJvxnPBWDit3zGRDvXhrSFPfoeEdZ/D6H1Cyu91oITn5esG49x9YSCsgGpqgI
         97mRvNWTHVdOYkQ8XsuMkAFR1+20FwoM2QXFXwSyyA+Fs7whazFZfCaO/x5ElMFdTncC
         n+vj/cP76CBvc6T2AHaIZPRachz+7ZK/No5IWskPiEMVLuDxeMDge4zH5JkwuIAJYJyi
         MO4mfFNi35v1HWbBVqesXQwTRr3wa6i9EePN83i2+AsSWx0N6P4uGrhKywiaZBspKbJt
         FhLImxN1DGZoJe8yEsD8+rElNqUMqeHB/uIUljFXslfG73vMFaAyXDYA0EouPnAhgf6e
         SPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342392; x=1709947192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUKVRagEjVbWTLTtfvO897pmVhBdhZlyN2rymNdpliI=;
        b=wKyN4bNMTMgesSrudztF2W7jS1j/2c6WCS2uxKPskF/OTCQg1SOd+YAkufM0iv6263
         XPb2RZa4I5gHZCCweiV/VgU7eTRoBh4L+5cM9Uq5k3vfseVq71gkj54/8UZREOlA2hmA
         2kVR2zq3WSphJtMG77H2dTc9k5HuWizhDPdsmsM4sfoxNp4DZ3gcCWfKxbZw4R7mp9tJ
         6T5SRA1Igidc5kIOwmTQWhpR/KkYzKy1aikhp2daLtYjpgd548dFM6NEKeV4hJqm8Wu3
         oysz/hLqtR88S55zfRtguSs6KdMoI8sp5sd3cai5JJQUjVhnbt+DqV4PVPHR5uQgzeb0
         Jeuw==
X-Gm-Message-State: AOJu0YwTeTeKB3cLB4ou05HWQvD6jZDKZv9U8spZSXtX+TlqvyuTBeYD
	J6ggpP2UuZZaQy7DwweeGsIC6v8TQ8IlbNB90tPyM6SGJY8UFr58hcOHg9DP
X-Google-Smtp-Source: AGHT+IGiYTFrX3u59mp1RmF6S0UmGxCBlBaVwTwj0/hpa41SjCiE6XpKgpVvP1Wj9zcDprMXN4QWTw==
X-Received: by 2002:a2e:8612:0:b0:2d2:2c28:f174 with SMTP id a18-20020a2e8612000000b002d22c28f174mr2411478lji.42.1709342392052;
        Fri, 01 Mar 2024 17:19:52 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:51 -0800 (PST)
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
Subject: [PATCH bpf-next v2 15/15] selftests/bpf: test cases for '?' in BTF names
Date: Sat,  2 Mar 2024 03:19:20 +0200
Message-ID: <20240302011920.15302-16-eddyz87@gmail.com>
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

Three test cases to verify when '?' is allowed in BTF names:
- allowed as first character in DATASEC name;
- not allowed as non-first character in DATASEC name;
- not allowed in any position in non-DATASEC names.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 816145bcb647..88c71e3924b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3535,6 +3535,49 @@ static struct btf_raw_test raw_tests[] = {
 	.value_type_id = 1,
 	.max_entries = 1,
 },
+{
+	.descr = "datasec: name '?.foo' is ok",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC ?.data */                            /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0x\0?.foo"),
+},
+{
+	.descr = "datasec: name '.?foo' is not ok",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC ?.data */                            /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0x\0.?foo"),
+	.err_str = "Invalid name",
+	.btf_load_err = true,
+},
+{
+	.descr = "type name '?foo' is not ok",
+	.raw_types = {
+		/* union ?foo; */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FWD, 1, 0), 0), /* [1] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0?foo"),
+	.err_str = "Invalid name",
+	.btf_load_err = true,
+},
 
 {
 	.descr = "float test #1, well-formed",
@@ -4363,6 +4406,9 @@ static void do_test_raw(unsigned int test_num)
 	if (err || btf_fd < 0)
 		goto done;
 
+	if (!test->map_type)
+		goto done;
+
 	opts.btf_fd = btf_fd;
 	opts.btf_key_type_id = test->key_type_id;
 	opts.btf_value_type_id = test->value_type_id;
-- 
2.43.0


