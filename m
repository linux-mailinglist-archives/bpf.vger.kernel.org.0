Return-Path: <bpf+bounces-45875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534DA9DE779
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 14:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F97281FE3
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF519F40B;
	Fri, 29 Nov 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="W79bkyBp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790C19DF99
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886761; cv=none; b=coK+kvjkV7Z2MEQ69INSx7j52TtRDr+uzvq1GGSVxx6w7Q/b/nrATiBpMyiP8szNUr3t1gELFSe/AID8YY1SKIlFK+B6C3W36ylCqfG0+mq176vBoP7FDZ9jNp7VIQQV+vg6T9P/lDwDrYk7lgw9f4DGWIF+/rV3BU+LK+pyc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886761; c=relaxed/simple;
	bh=SfiHhxW8L0Lmn3ihd8debUXb8wBmxj5Pu01khKVp4tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ca9VOk03C6XUaoEsgKFijnpLVj0MIeMbHta4L4ifWoeV9o42pzgBgyuaTA3SuVl4LjhugVBHKLrkwaptrDEBk1m9Z0uf4ZX5CJgTPjxZYeyQHF2Rv6SL2MpR3APw6JslOzbvl2BaH6O3GugGnEzO2BiTP2O1sVkA44+XQVPxn4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=W79bkyBp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa545dc7105so252481766b.3
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732886757; x=1733491557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP3QAMrozbgzwuk6m5bfUUTya1nGlDpj7m4OrmHYW7M=;
        b=W79bkyBpaUV1rjtne64H3/eg5E3eKGAaniajZgL3x2/EDl30M1EipJQlspkJeJUHgY
         /SUVqqcneyeMLkWcB4LNHTnAHMveXwaLyfoOw+L5b7XrfqQI+nljtZlrwM4BzZ3oLa4j
         fXtdQShVIY3EnuqLtxVLTxr5EeO/Y2YUFawtntKJg0qbNS101mJ2pgsZAu/6p8X6a8ck
         Voq1VbEgIwnA96MFi0ZJ3fhtGA8P2WBoWMieZz4dG7CV0orP9bVmGOGEhHpurjRBgETV
         tIrdn6XfSvLixflRQKGlAsfQLVu+u1VwnwxcWedGnWo4I3eU0vLt8AA1Z00lb436NVdA
         rm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886757; x=1733491557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP3QAMrozbgzwuk6m5bfUUTya1nGlDpj7m4OrmHYW7M=;
        b=oG6MpimON7Cj5PSDjGO2D9NLsXO5DdfD9YVkXcYd9xWZjUYdZ23Z6K0d6ttfByUcM4
         Tzd5FlfR6rpF7dpq4a0t5DD+kbhtshBLCi4tdAQwMhWCwssu8RLL2TE4Wp0QX/pSMVMH
         ZXADbIeP1aJteTyGXi9pEhnxS+8VMfq3vduxJYuWoquTRV/dJFlnk53fFfa3onAjtWfk
         IdWfIex2YAnLffBpaoGJiAybYqeBkZ0mEW4Su9CKuENt0LVotpUGWQopVlgahr2haYk+
         I4GGgaRVpQl+i4d2TJUoTGfYSoauktRsQxYfSM8OvWPokPGXAirMxmqzr+E1psyUC46w
         duUw==
X-Gm-Message-State: AOJu0YzYXAPXNgZAtp/I/OHxXBHvgxFYGkCXBygdInDVNTMmpQZTA9Pg
	Vk0m+ZSP8d2mXfbBW2ibf9JhH9JZkgQ0KMnV6SXouSioACHaOZdq7LTMU8ZLYHT8JfBBTt0/09R
	e
X-Gm-Gg: ASbGncsvl6HBzcN543GdvftGKe0RII8t/Xp3pHLdQVMx80ygKvh0kTEcfv2nmBPEjQZ
	Z9axK6Hqhg67rmUszQ2xeuVWTyi6K6l25fIUZq9FKYTlg73mRGTQIjTAaFEAxlA9/EZIyKuBsE4
	r8qhseyXVc/BCTZqYsluA8iZiONjJpZnno+jF3icqTJRr5PF3yQszwEZoeDmqrItg5uWf0t1Uf7
	CB71mdM4+YKhUKC2CwrENsBWLMKoqWOiWU5djzKdALuj+pSrZiwI5SFtsnJ25s=
X-Google-Smtp-Source: AGHT+IGyGc7cxDLL4nZQOcckaBf+ME9jmw6o1RXnPptr9L/wHiKZdeOKQ8YNYLWpx0Kwyh9i5ZhNRg==
X-Received: by 2002:a17:906:3d22:b0:a9a:597:8cca with SMTP id a640c23a62f3a-aa5810333b8mr691092766b.45.1732886756783;
        Fri, 29 Nov 2024 05:25:56 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904f33sm173295066b.135.2024.11.29.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:25:56 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v3 bpf-next 4/7] libbpf: prog load: allow to use fd_array_cnt
Date: Fri, 29 Nov 2024 13:28:10 +0000
Message-Id: <20241129132813.1452294-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129132813.1452294-1-aspsk@isovalent.com>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new fd_array_cnt field to bpf_prog_load_opts
and pass it in bpf_attr, if set.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/lib/bpf/bpf.c      | 5 +++--
 tools/lib/bpf/bpf.h      | 5 ++++-
 tools/lib/bpf/features.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index becdfa701c75..0e7f59224936 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -105,7 +105,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
  */
 int probe_memcg_account(int token_fd)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, fd_array_cnt);
 	struct bpf_insn insns[] = {
 		BPF_EMIT_CALL(BPF_FUNC_ktime_get_coarse_ns),
 		BPF_EXIT_INSN(),
@@ -238,7 +238,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, fd_array_cnt);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -311,6 +311,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.line_info_cnt = OPTS_GET(opts, line_info_cnt, 0);
 
 	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
+	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
 
 	if (log_level) {
 		attr.log_buf = ptr_to_u64(log_buf);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a4a7b1ad1b63..435da95d2058 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -107,9 +107,12 @@ struct bpf_prog_load_opts {
 	 */
 	__u32 log_true_size;
 	__u32 token_fd;
+
+	/* if set, provides the length of fd_array */
+	__u32 fd_array_cnt;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field token_fd
+#define bpf_prog_load_opts__last_field fd_array_cnt
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 760657f5224c..5afc9555d9ac 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -22,7 +22,7 @@ int probe_fd(int fd)
 
 static int probe_kern_prog_name(int token_fd)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, fd_array_cnt);
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
-- 
2.34.1


