Return-Path: <bpf+bounces-70258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 082DDBB5931
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58324E1B4B
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD2286402;
	Thu,  2 Oct 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4kJ0Q28"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E12C21DC
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445652; cv=none; b=j79SjoGD83MwdJS8JpoyuJcw7k+sPSphAMjns2BItGHlh/L7i1Wgo5qRqwGOgSorZCCd7QXFljhY0s6AYWMreYlhWRbPszgyEFh+KZvx6ptvOqRehcAExJiKugJakeUyoY90kRnqZ/P79Ewc7CSSJ8RM1kc8IVzMhjCR+/9rZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445652; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeqQOPGTfJ1MHzjOjN/uQ1TjPEqjmOwD9cvcxsDnt9MUv1lEONyYNySVipl7JwVHbAtcpx2BAcV4bxaW1/ETJM/g4zqLXsn8lZ+E/Mv6jB4EFMH2OtFJx+PEPAByyfQUOOe3IQdmsMY4pUGUkdMBGQIZ0s+4v+SgIjUKvB3BWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4kJ0Q28; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27edcbcd158so19970745ad.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445648; x=1760050448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=g4kJ0Q28UKOE+u8NTSGJYLncLcOQ8E2/630/PhDirRnPmksxKInPb1JsOkaBVuxBM8
         +6AsFLkqee/GAC9gjipZ0QvOKiaVqT9J2geHwMYKktdMC5DYeQAOtPV2GUalDOeUpEIq
         Ry9HdpeoufB0Uv3MTFPkC0aAgCq8Kwq0xwqUAo1df2jTr5siILQXuu8fH3sVXq5xEunv
         NoVGCapbxJPP595+KmE1t7+cTZ98sXl1oj5HuEToBWH60SS4UsFhKlb9KIdQ+um8+Rw6
         vcoVGMs1G/et5xAG7sV+YxrpPSI+rSyVFLHthHc8I0Yg2ZDLOqsolj+HgdYvVWtJF1Mt
         D5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445648; x=1760050448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=R1zXiyPYqVpfB7oFXPu/Oqx9WQsRlRcnKrk3uHoEX3yEI8kCG+hMfCnIzRgzPgC5u1
         FHWVlF8q6jolS/Mf+bH4+SLReRO7oLAt0SkALOepj3b/uN6/f5BxQvbnf5Wxq+JG7BW6
         Az7WsFFoR9vIf8YuRfbEhWsL29ItZE8No9vLYbg2Nlf+5X0OjH8SoaEYutw1QxFA9B6C
         7yXJL0gAuGTk6+RGO6B2IvcZHJwCeBxpU2Em3PwjOG7L+f2L9Xr0QFN1Y/YuzejaLRkP
         N3ZRMu6cfBzDZmUr79HOw4opdtqRs6WJcQ4WuEWl7p0n9GGpUKUHR4Pj0dIHQqHH6sM3
         oATw==
X-Gm-Message-State: AOJu0YyWtXZdDAoNaoNEMArW4T4fO2ivFInDluE+Sf+yr/YFNiUZkZCh
	7S3c9idpuScReHZWBZnXMZ/YbXxh/Ph9EHj1LRyIEqMvPOb8ugSj4YWV7w7bdw==
X-Gm-Gg: ASbGnctxivJaWmnGfgRUHLuIBPN+iAiGAG7uJoRSJYp6n5SnWhHR+rVMyNgvnjb+rsN
	wHH/nBQboHnp2r0y3Pw97ckEGhcowA5F3nD7pHct0dBcRNj2WgA5XQCM+s1qX09/iXQQ4hBP9D3
	OHMlv5U3zhGsKNTRIlzippLEC5+kw8muLW7lXVCYZVvVO9z/2FhQ1whejtdKB0TY39dvuLo3pEm
	+Nmp6WaBsFez7MOETKBYR4gp4a0pt8JnSqNdJlnLz3U0M6zC+kNqatPGfJ8ILslJbU1gX445ieA
	t4Kc4iG9PxvNkgZVTWMoxJI1twt37s4c1N9J0aoMq736eqKY22UFEPgnaT7Svzp3NKe6wMy8Jm/
	8My6uFXBVQOqamvXSxIGmrZLqC8vS542Ew/kGig==
X-Google-Smtp-Source: AGHT+IF6X05WN5IpwEmN95+3RykBUaI/cu06lJOa928MKQCsJfqX3kDVxlPrOL7+Fwsx/f40n9Bx2w==
X-Received: by 2002:a17:902:c94c:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-28e9a5f7246mr11314725ad.39.1759445648430;
        Thu, 02 Oct 2025 15:54:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5635sm30716655ad.102.2025.10.02.15.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:08 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 12/12] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Thu,  2 Oct 2025 15:53:51 -0700
Message-ID: <20251002225356.1505480-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cgrp_storage_busy has been removed. Use bpf_bprintf_nest_level
instead. This percpu variable is also in the bpf subsystem so that
if it is removed in the future, BPF-CI will catch this type of CI-
breaking change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 10cba526d3e6..f1642794f70e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -875,8 +875,8 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_F_COMPACT,
-			  "static int bpf_cgrp_storage_busy = (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_bprintf_nest_level", int, BTF_F_COMPACT,
+			  "static int bpf_bprintf_nest_level = (int)2", 2);
 }
 
 struct btf_dump_string_ctx {
-- 
2.47.3


