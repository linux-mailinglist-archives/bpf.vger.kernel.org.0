Return-Path: <bpf+bounces-70765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47B0BCE28B
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A983A2674
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984E02FBDF0;
	Fri, 10 Oct 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtEqD895"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A32F3622
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118600; cv=none; b=PC06crmvgF4RAokrzbX6fUmCLXZYCikSrV6bFQUPtVff2PFfTXQpnDiNUlgZNsStaeyRF9eIP9PMVrdlv5SByI21Vq1RLijhqhp1HtdNgXxSh5IiR0HTNGCQ6RRgTpdTahWQW2h772l8+9xazbAjLC2K7mQKMeJ1Yefa9gVybTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118600; c=relaxed/simple;
	bh=HkW2uhOCSv0da1DuuAqv9lQkotThUeSdBsL94afQqRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmJczEA8ckWc0A/rpW0PelX0iMIBm9rmi3fT4yooTdU2QmQB6NXqzo9qcYIZOAB++tji3KcjBfWnAyWAei8epHroi2utttI3wNmGF9mxMXJFFOblSx72jgcmaFtcijNyncYbWmxQU679YnDJXqOTsaOxkrWQQJMMYdq6ddve4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtEqD895; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7930132f59aso3322321b3a.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118598; x=1760723398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHbpxQMFMOwT2AhBvB0I0iDBDiuT0DEM49ayAeHNaVQ=;
        b=UtEqD895vPJmR/8xDTga6SbaZR4IyENsRTCKcJZN1A/vdt5XUpfNrxmhclVf0imMBp
         /VH16yPZVacX+pI+ITDdPc4KSTzxzDlsUv7Z8MWdRb44GA6duQmLRe6uhC6xNOjbaJyg
         11+wC3+OG3VIquWOowMO4/tetOrzz5iYkRvf77NdQ33MKsSHqnAMV5wEiJpKQqmXF4h6
         Xqz+V8K4Eg4/X/QC2fz/s9FH/GjMid6uJotS5aCN7y2rhSE7hh0grVCSm8n7l83XVu2V
         o+obIMQ0k57EtbqbBBe1onSzD+dLCudo3pyX8fTY+H938gtGM+7XSFPcyyxjuu+PrGiA
         u/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118598; x=1760723398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHbpxQMFMOwT2AhBvB0I0iDBDiuT0DEM49ayAeHNaVQ=;
        b=CP6HCav/t6lJBxYjwlpC6Cs1SuWckmFgOhFr/IM9toKowDoIg/dFvgOVONi6+W+soj
         /OLLastKJdPN2bHh4zx1mmvqCfjErbztM15PjxjQM23SA5oPJjM5LZWHaRBufBxrfING
         me4MNRaAlIe9kC5s0wko+y+wx+mtTODMdJ4akrwS5ui+ZmmPH9F/GDcNTXCHrF6aMVxN
         2BRD5ENAXsWmO3HdXR2IV5hy28zZMQG0s/eEA/KsMY8gFqEvYjUZ2n/687gHMcjl5l71
         FQci/Z4nIw/E3OblWUdz4Dnf5YUvuxbF6U1XS9e9OU7KIDN5WV0wbIWW9DtkpCOJ+LFf
         fWEA==
X-Gm-Message-State: AOJu0YwIF8JdR4nxbCAbp53o2lvAaaCmbs9M5rfz+//B/hK5HhHyayet
	vOh1DJ+FzP/wDIMcp6JT171Ca4QetUE7tOm88hozZSZd5n9/+rm5sFABacYtQQ==
X-Gm-Gg: ASbGncvGn1RSHXW4ZM+a+2I6uVVk41y7iwXjHkFHkindyfusbb7v39gjPCBUB+DRC9R
	1ugzQZUA07dPbRK9aQH4GnlE3XqcW44ZSRwClssb5sDUmmE4QIqp7/RbpfnTKbZd4EXjwLBmVUh
	3EmdToFnYgckIIC3n2u6h9Uqr+JzGarVk3p8KB/tkyoi0U+haoJVMo2Hwr0YzwskW9dECpr9l9M
	+2T9f57+/gP3g7I7QC+SL5R6nbtR82vS8wJHP+ekmBy+BGk1lHb+1iUTcqwfsQMaFHh5sbgmJY8
	MXyKpEdbru6zfd/Uum2aoSMULY7cX80gsNLP9dRQBzI28bZZaJs23F5gqM7pH5s+xXqabxl/DIm
	tCgRgRm6e1gznXieoDDSlLyTYuW9vtQGh87OR+W+TS3U=
X-Google-Smtp-Source: AGHT+IEJ9PDvkBIXSPW92jfBXGJpVfvGo5MLAgGKb7FyFsSC5gsr2SzxiEAUHfOzdCpnZd/5+/2E1w==
X-Received: by 2002:a05:6a00:80c:b0:782:5ca1:e1c with SMTP id d2e1a72fcca58-7938723daa6mr15091340b3a.21.1760118597383;
        Fri, 10 Oct 2025 10:49:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0606f0sm3703948b3a.15.2025.10.10.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:49:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH v1 bpf-next 3/4] libbpf: Add bpf_struct_ops_associate_prog() API
Date: Fri, 10 Oct 2025 10:49:52 -0700
Message-ID: <20251010174953.2884682-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010174953.2884682-1-ameryhung@gmail.com>
References: <20251010174953.2884682-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low-level wrapper API for BPF_STRUCT_OPS_ASSOCIATE_PROG command in
bpf() syscall.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      | 18 ++++++++++++++++++
 tools/lib/bpf/bpf.h      | 19 +++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 38 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..230fc2fa98f9 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1397,3 +1397,21 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
 	return libbpf_err_errno(err);
 }
+
+int bpf_struct_ops_associate_prog(int map_fd, int prog_fd,
+				  struct bpf_struct_ops_associate_prog_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, struct_ops_assoc_prog);
+	union bpf_attr attr;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_struct_ops_associate_prog_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.struct_ops_assoc_prog.map_fd = map_fd;
+	attr.struct_ops_assoc_prog.prog_fd = prog_fd;
+
+	err = sys_bpf(BPF_STRUCT_OPS_ASSOCIATE_PROG, &attr, attr_sz);
+	return libbpf_err_errno(err);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d61..99fe189ca7c6 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -733,6 +733,25 @@ struct bpf_prog_stream_read_opts {
 LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 				    struct bpf_prog_stream_read_opts *opts);
 
+struct bpf_struct_ops_associate_prog_opts {
+	size_t sz;
+	size_t :0;
+};
+#define bpf_struct_ops_associate_prog_opts__last_field sz
+/**
+ * @brief **bpf_struct_ops_associate_prog** associate a BPF program with a
+ * struct_ops map.
+ *
+ * @param map_fd FD for the struct_ops map to be associated with a BPF progam
+ * @param prog_fd FD for the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0 on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_struct_ops_associate_prog(int map_fd, int prog_fd,
+					     struct bpf_struct_ops_associate_prog_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..3a156a663210 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_struct_ops_associate_prog;
 } LIBBPF_1.6.0;
-- 
2.47.3


