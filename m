Return-Path: <bpf+bounces-56357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC177A95A35
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 02:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827897A2B77
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D25638F91;
	Tue, 22 Apr 2025 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYCuuv8P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07715E90
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745281900; cv=none; b=WaG1ePQiyFNTr/PKfJdGot/fJpVFnhQDvfygWhW3Vz4hUdu+mU1nXKC/LB29lFJ/zceIHQ+3+yWzbGAigJ3GMHwSXT3tl8tINsy4Y9At6qUmHqWSHOID4XdNSeoYowu7egTB90o7IdWJPGdwM2GoGkCCsUSGn1wmlTh0WCDAkBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745281900; c=relaxed/simple;
	bh=7SJGdcAeKChMYqXySE/DUPmuVHOrPHSsrGdivpz1wG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4BXlrFMdneN/uNOQOMUtIUqgpJuD/kwI1Bi4Nw231afE8kwVkE2LKYzOWsMEjMwbV8JwV8U8YT5k3DPX41A4x3Zjd12x86rhZhqBmAKlhubpPA1AafAKtF6NfUbKH79BJ8VnmKMH0mPiLmM9qndkk8DLakGQiHPIpvGMV4qP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYCuuv8P; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224341bbc1dso42664845ad.3
        for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745281898; x=1745886698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2gsqBJgMB7iiqg4J5PmIk0v6fBczouhJKt61oCH0xSo=;
        b=WYCuuv8PSko96/JY8MvJwqyhcAkIK5Gx4BrV4Zz7IU5PhMfAhtT3qM0s5P1NljyczO
         fOc2RRHDARAnNb9BD+BvWWoReR9+lCXHaJXBHl8OxUuHKs1AWfFVdcXe2J3f8hzkjmEA
         aq+LDNaUhH5h3595FTfDfut45/g6rWtPy5JNEq1vkxpS6kOU6z/c5DsewSiFRnMAx4dy
         aCGo6ZD3v95f+ukPZ50yUdikkOf3OpEL8nrsE7BHGkwBgd4c+IVhw0W3g1t8fDGb56P3
         HOWNZDhQeYbnTEkg3MvWIr/CQI/bGAkChFXJriQE9HxXEKJTzIsDUxCLPfffCRkE4Ha7
         52Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745281898; x=1745886698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gsqBJgMB7iiqg4J5PmIk0v6fBczouhJKt61oCH0xSo=;
        b=Nfl2OpGnSK2apiCG68suB8qPmpc5bRgOnkvk1PMvVQErfhBEbxsSG7IUJjFvxfRIV8
         AtLSvriA8D/ijZakqO9AbXIc+nhbilmRkLN4Ufxaq+RRkmxNeNIPDfaXoYhOlcVBW/6M
         nLy6BozTB4n4mX+rnUp3AgT8WPIfbIZt5oj13rH8KNNkSyUt2pu0OVQSRfxlJ0tasT07
         UOV6NoZru3N8Q/mcvtYncDD5zpBqPG4cFoXaiW43OhSr0Uw29AMUCPsIQMiXoqvueWfS
         bzZVrrjErh3JwPSYwoKbqkCedqtTj52jzxSmb4RFA5uTU9TcEzauqJqs6ZMN3fh8cCBX
         eKFg==
X-Gm-Message-State: AOJu0YwrGsXCN/Aoi9uKRQY5SOqspXEt8jhbKlPyqcoEUmYdVtyUyqNF
	4G/GG0Kjk7hZngX/zSM8QeFpBeWbP7+JaWFbBsBdwJ6jBTK12DfSe/VgAg==
X-Gm-Gg: ASbGnctJWe9X7U/ZwXX+pjNE4hcvzHU5EyhF5Ww7dp49c9ZGRhkv71K65DtKlipn9bt
	WmXPqvfeW/7nQ8xmg83bo9xnGEI/SnxUbqJBSQ1A2R6vzfSLwL7XRMNETA6qQrHqecCXYvbi/m+
	xIDbucga9lEXe/Lk9RR6bGrfgfyOcslyhn5QCsxmClXLOI9mpqg7lmbiVJBlTiLsaB/SKcMwHk8
	1ubVaMX2YrO+WVnQsZjeqi1hcni8tMbSIra6ixl8ZoxSqsSt93jF5ETI6inXfZhugo9Pk5ImGX2
	Xi6bgMDEXj7KHfDKU7owESgVPr0kwBi3Wq5UaAHZmdmsfn4AUQuCAT/2mV+NqvTNGCzvVlPoAw=
	=
X-Google-Smtp-Source: AGHT+IE4+SuV5gabU5QPJGH2CJLUenp9+JvudgvQX05fboYRN4FzhIeuL8XDUyH/6aWsFm4xw8EJLA==
X-Received: by 2002:a17:902:e88f:b0:223:58ff:c722 with SMTP id d9443c01a7336-22c535acbf9mr194080375ad.28.1745281898173;
        Mon, 21 Apr 2025 17:31:38 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:3a24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4b58sm71826375ad.109.2025.04.21.17.31.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Apr 2025 17:31:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf] bpf: Add namespace to BPF internal symbols
Date: Mon, 21 Apr 2025 17:31:34 -0700
Message-Id: <20250422003134.68527-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add namespace to BPF internal symbols used by light skeleton
to prevent abuse and document with the code their allowed usage.

Fixes: b1d18a7574d0 ("bpf: Extend sys_bpf commands for bpf_syscall programs.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/preload/bpf_preload_kern.c |  1 +
 kernel/bpf/syscall.c                  | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 2fdf3c978db1..6657b272bb51 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -89,5 +89,6 @@ static void __exit fini(void)
 }
 late_initcall(load);
 module_exit(fini);
+MODULE_IMPORT_NS("BPF_SKEL_INTERNAL");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Embedded BPF programs for introspection in bpffs");
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6..bf19b9d68699 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1583,7 +1583,11 @@ struct bpf_map *bpf_map_get(u32 ufd)
 
 	return map;
 }
-EXPORT_SYMBOL(bpf_map_get);
+/*
+ * Only light skeleton is allowed to call functions from
+ * BPF_SKEL_INTERNAL namespace. It's an internal API.
+ */
+EXPORT_SYMBOL_NS(bpf_map_get, "BPF_SKEL_INTERNAL");
 
 struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 {
@@ -3364,7 +3368,7 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 	bpf_link_inc(link);
 	return link;
 }
-EXPORT_SYMBOL(bpf_link_get_from_fd);
+EXPORT_SYMBOL_NS(bpf_link_get_from_fd, "BPF_SKEL_INTERNAL");
 
 static void bpf_tracing_link_release(struct bpf_link *link)
 {
@@ -6020,7 +6024,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 		return ____bpf_sys_bpf(cmd, attr, size);
 	}
 }
-EXPORT_SYMBOL(kern_sys_bpf);
+EXPORT_SYMBOL_NS(kern_sys_bpf, "BPF_SKEL_INTERNAL");
 
 static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.func		= bpf_sys_bpf,
-- 
2.47.1


