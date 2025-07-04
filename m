Return-Path: <bpf+bounces-62457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE701AF9CAD
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225481CA242A
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF6291C03;
	Fri,  4 Jul 2025 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvupd4lz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1528F930
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670253; cv=none; b=EvY73YygFmqb4pabe/TIBjXZ8oC4j2CU6dnA6EQ5TUngunm2Yb+XOdRWL/vtFBshYlwaJbT2PkxPE6wBNNXlQyxjWDJT57I9/ku65BB5XzH7LWjpvfQy2AAg3bDZTaB/ijpZcWSUquzpeHaTgxtTfxUxfO/2xVAVbYeuY+v8QQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670253; c=relaxed/simple;
	bh=1oDYrEgTTfq0m2bqXyKj5wl8mzCSwSD4SKLwysYoLAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCnB7KxldkmIi0o40kAnlaA22El1YJoMZ3CoBu9ZokOuh5kPqDTGFgQx2hnbDC3vXgyXLwtqoRMKkMFzV6Bbt7A2MfpxHdT0oG2/Sf6ZClEGnkG9DWLTt1VEsgYKBvfqv0shFFKeIVCfY027i8YgPmDhNgxcTMtA/xnjP3xrl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dvupd4lz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-749248d06faso1125088b3a.2
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670251; x=1752275051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vsY18MBVjylwvOgxjnjpLof7LX+xp3D6xP/BcpyGyc=;
        b=Dvupd4lzmazDaRruCZD6gDwsZzYD2OuRmHi8lqvH+jCOWdi3G4kmHRzhkQmQBzWrGo
         dv6nTlheCfHz24i+XXTzSWG6OFKnY1dE83g+zhRXB1Nl1ZCTFT2Lm8/3cUnLREz3aasq
         oT0OqC3vBKgxXmYTnBKViAk+1b/b5OYPubVPKef9dq0Covd8D6ZsodGbD8WV5OgRfAVM
         07nI3+mh5kX9p9jZVk64is3NtY+CXDEbNCmz9+zgW6RGw/1tVOxcgdL5XkTVooFBXOV9
         wWb48DGjSgsNr7VKCeVzv4/EQUPlQVtmRSHj93mfU7kFv3+j7jLj9/MggHE16XZVI+z1
         v+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670251; x=1752275051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vsY18MBVjylwvOgxjnjpLof7LX+xp3D6xP/BcpyGyc=;
        b=SUHFPBhvMKZMko3aDmTj8cAhlZrcP7jCBac5iRAYj/peagyYlXvFvajbgHo5o+T/ML
         NYudVv2gSObounpt82qCeoxokVx5X8rA9c8M/gjYpdQCnGqmD45B4eddFXWkLZ9JB4PO
         bZQUJ+o37RgZBiK2K0FU6tf1avbECfqpmvsm+mJ38Pu3zE5rG/upliOin0SeFmfrphPX
         yDboafl4jE5vmyzODcPeS0FXoxqME7HRv9ldIBAsnX7+uKmWfZ5WOHTVGJxpTrEiFakF
         lz7UAgYQYPSR8dAPqHHqckw9j9dOds+60153KIR11lxbtO3H+eXjKkuOhUyniru3snlf
         yg3g==
X-Gm-Message-State: AOJu0Yya0dEZ4Z4PN/QDj/ejRhIgtWGkCaKkIynaOwRfMal2fpUH/9pk
	yo49Ag57cQAMtLxV0mVKUu0vDsj+9XE2rCSA7c03A8eEgV4V1PZxfdWlsreYPA==
X-Gm-Gg: ASbGncsPA4lyKD9D7Gf4zRklmj0tOuXdewAWpRAbYy1RJ1LIu8lW7eaI76HOHtp5sFV
	02m2TEYsroKsCGcbYQir8amJyUCfw2mzTu5PSP/KVnYnpdV2s66c84Lwgec9ifcUZnTfWGKHOtG
	xzStAr59ED/WaZVD+OQ+E5bpxS0Z3d14+VlpZcrd57mzm34yoxlH9ZeeSvAgIcpQ5AXaQsw/Ff8
	+gBoNbruXnFEFRDOSCotzWc5TSo+8HgCXgVsClcY17lw14AEB15NABMdbEXQx9gd47j46raVbzc
	ldEIlU3xuqHAN1Sk5SOkJ2oqrIrgJEl7nqupMy4V1SpMcultj2pd4CLK+w==
X-Google-Smtp-Source: AGHT+IH3Lo0Xls0hXT3u9cq5b8lATsNFWb3Wdvv/+IXOVTCoofBxw6e8O76iCl4VN1BHlTHsV/buQA==
X-Received: by 2002:a05:6a20:4320:b0:220:38d9:8f20 with SMTP id adf61e73a8af0-2271ecce615mr625133637.1.1751670251341;
        Fri, 04 Jul 2025 16:04:11 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: tests for __arg_untrusted void * global func params
Date: Fri,  4 Jul 2025 16:03:54 -0700
Message-ID: <20250704230354.1323244-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
References: <20250704230354.1323244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check usage of __arg_untrusted parameters of primitive type:
- passing of {trusted, untrusted, map value, scalar value, values with
  variable offset} to untrusted `void *`, `char *` or enum is ok;
- varifier represents such parameters as rdonly_untrusted_mem(sz=0).

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_global_ptr_args.c      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 4bd436a35826..b346f669d159 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -260,4 +260,57 @@ int untrusted_to_trusted(void *ctx)
 	return subprog_untrusted2(bpf_get_current_task_btf());
 }
 
+__weak int subprog_void_untrusted(void *p __arg_untrusted)
+{
+	return *(int *)p;
+}
+
+__weak int subprog_char_untrusted(char *p __arg_untrusted)
+{
+	return *(int *)p;
+}
+
+__weak int subprog_enum_untrusted(enum bpf_attach_type *p __arg_untrusted)
+{
+	return *(int *)p;
+}
+
+__weak int subprog_enum64_untrusted(enum scx_public_consts *p __arg_untrusted)
+{
+	return *(int *)p;
+}
+
+SEC("tp_btf/sys_enter")
+__success
+__log_level(2)
+__msg("r1 = {{.*}}; {{.*}}R1_w=trusted_ptr_task_struct()")
+__msg("Func#1 ('subprog_void_untrusted') is global and assumed valid.")
+__msg("Validating subprog_void_untrusted() func#1...")
+__msg(": R1=rdonly_untrusted_mem(sz=0)")
+int trusted_to_untrusted_mem(void *ctx)
+{
+	return subprog_void_untrusted(bpf_get_current_task_btf());
+}
+
+SEC("tp_btf/sys_enter")
+__success
+int anything_to_untrusted_mem(void *ctx)
+{
+	/* untrusted to untrusted mem */
+	subprog_void_untrusted(bpf_core_cast(0, struct task_struct));
+	/* map value to untrusted mem */
+	subprog_void_untrusted(mem);
+	/* scalar to untrusted mem */
+	subprog_void_untrusted(0);
+	/* variable offset to untrusted mem (map) */
+	subprog_void_untrusted((void *)mem + off);
+	/* variable offset to untrusted mem (trusted) */
+	subprog_void_untrusted(bpf_get_current_task_btf() + off);
+	/* variable offset to untrusted char/enum/enum64 (map) */
+	subprog_char_untrusted(mem + off);
+	subprog_enum_untrusted((void *)mem + off);
+	subprog_enum64_untrusted((void *)mem + off);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


