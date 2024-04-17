Return-Path: <bpf+bounces-27073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9268A8E43
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 23:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF17B21854
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F09A6A329;
	Wed, 17 Apr 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhZ2ZDQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD75171A1
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390251; cv=none; b=eT6jbIhFfAN8Fu+D1Yp0EsndRDBfg7Wsblj2pALvbEj33MuSHzwOZ1C7n6BHrmKC5zHlrjr9ml6TU/Hx7YLX8RHmMqJuvwLuokQ/2OalEjkb1U784orNoQZ4xcdaianxke3KZzsRLjIu1LFpjDZomiqe6xpNYH6qiXgdnugwfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390251; c=relaxed/simple;
	bh=Y6EsO5JHDGRxEPSWkrTgvgJWgXntC9got2OFAmrmgwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t7NU3Ctc1Kr8jMJho/3JUFNCCDU/xf+Sher64R11HO5O+HIaS4DgTEu8UkoX8M9BM3hiGvz4e9CFUPvCZA4KWJEIK68pQQLcysJbB7Ea2VXQORC/AX05JDcQiFCK8dLiEQingReq7Pqr5C+dfSORshxizo3SjBpotvv44cubdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhZ2ZDQ9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso1574815ad.1
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713390249; x=1713995049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=egXMDOBgzy/FaMzkfbxlGQDDVDhdlpYieFiBCnpaxqU=;
        b=FhZ2ZDQ9YnN8l/uIxKDhMAa7jwdIr3+uYU8dOFnLAMbFt8r6ePHzNhHPqYXGkBcsj2
         ZmcIiSE7wauVALHjBdvNEp/BcMu44irYOlbPJN5Ehg5EbmiTg/LIm80sIFHhWN/L/uFi
         jrEonZU963gSNCDUJOI4QG38YC6SS0vrlkiLMCAv2u5aNq+2RZ0qdXImvP4Ri6WZnaHG
         GUp4F2QEdCSKdNuaJqSnFAp/XzzMmVSStmwV+i0EJjKD6KBedtBmZnLHb9GOusj/CXzS
         +rJBjsNSyIUjslPwYHBXJ/zIzrEXO1DlKhuWzLwI4KYJL30QaQYNWa8h1RFrcB6g3NMa
         m7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713390249; x=1713995049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egXMDOBgzy/FaMzkfbxlGQDDVDhdlpYieFiBCnpaxqU=;
        b=Swf3e+tjEciBIazUlHlH8F5ilY0dUk+Tesu5WTWrKKJXWVuAbEnKTxx73+thyhNGBf
         IOPqd8X50nlJT9CifU2z3boSQFk8jamDLTn3Qwdw1K7mtrzb6HawLzycdT2l8TS615/E
         KDtpNBVwZIOVbngk+1sX+7PnYmQOVZro4+4LuW+hfRhNnPFUluLQSvXaTrmhMX58BqT/
         Jx/zhjz8uwV6G5bvJR1efbo2GQ0f8+mlyUwRZzibLHjN+YF6+uSAnJQvaDdK/M3jO4Ew
         tZmECdJXXfHlQ7eBDUYzNE7BxZ49Nr6hxG/G9CihEkPjIyHZ/19yT88RvzUeUTtGzztR
         /Kpw==
X-Gm-Message-State: AOJu0Yzfb+OGekRhGM/cd0ivYJandSKQLPae4m4A9wnohebcMHN+4OWm
	u017YsnRVmdHdb++kyOv2BHwTdWDmjtryXSmBomQLbMDaNKTiAcz6vGPHg==
X-Google-Smtp-Source: AGHT+IGKRj+kluVhjj5lljBeocLaOL9Odt+W3c35T3+rLF99wHqm+eRURFw8X015Y/qEzlEyfPTB/w==
X-Received: by 2002:a17:902:7c88:b0:1e4:4045:481b with SMTP id y8-20020a1709027c8800b001e44045481bmr870855pll.29.1713390249040;
        Wed, 17 Apr 2024 14:44:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::7:e1e2])
        by smtp.gmail.com with ESMTPSA id jz15-20020a170903430f00b001e4e8278847sm107399plb.56.2024.04.17.14.44.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 14:44:08 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Fix JIT of is_mov_percpu_addr instruction.
Date: Wed, 17 Apr 2024 14:44:06 -0700
Message-Id: <20240417214406.15788-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The codegen for is_mov_percpu_addr instruction works for rax/r8 registers
only. Fix it to generate proper x86 byte code for other registers.

Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2b5a475c4dd0..673fdbd765d7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1439,7 +1439,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 #ifdef CONFIG_SMP
 				/* add <dst>, gs:[<off>] */
 				EMIT2(0x65, add_1mod(0x48, dst_reg));
-				EMIT3(0x03, add_1reg(0x04, dst_reg), 0x25);
+				EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
 				EMIT((u32)(unsigned long)&this_cpu_off, 4);
 #endif
 				break;
-- 
2.43.0


