Return-Path: <bpf+bounces-41341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C985B995DA8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865A82866F9
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D776048;
	Wed,  9 Oct 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjVnf2kj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751D1E49F
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440002; cv=none; b=h9duOCP9gvkZc21ZnRzXMh/QlHpeAV3HPPa247Xe/lsdSa7hs2qwgRns85Ijkv8bQLmmji3nyqgyj11BmwKcDq55/gYm4GkT61sNcBZSQ2TY0siNAPIY90pI6335wJPSfG6TJXzyiqZAExgxN6jviQ6dObQ9dyo9r+FXub2IfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440002; c=relaxed/simple;
	bh=/teqQn/r0hBporrcIVM0uCyMbgv/R3kx/gya8jrSvyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtM+YfuDZrNHtgTGhFka5LUJe9hhmN0JxtmXh/t85hqSl/zmjeR3pDVj/MqxQIps+JCSOdWLk+svxlleVh3WztIdrLZckJJJlwYTTz0ASHjSpsqT/cu7XtT/nKdU98ZnhNzXAqu2B+MypXZF2Zh7C7oc3mVvbMBrHJ2M7s8BGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjVnf2kj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso4971418a12.1
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440000; x=1729044800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFkWhPmTItJU9grZqoWlnaz0AzjA9TQpCpck29q/bX8=;
        b=cjVnf2kjGDatBVRkq4e0ok5n1STe8aH1kCRhNw03KQ6QrcNvAmVoRLpVmO1QzK2PhX
         cl8HRsuA1AflYJTyoC0PnAV0vrk2cqcHxAEF59SZlhbiCEZ93izcIfKoklA6NS3zv3Fq
         C8CEswQocVlROMMY2JCdfCEyWtKmsV8+wBDkzGMqRwipkGjSKivKnHGOC7+VIG8Sx5Wx
         8hHNk8mw2/Lwg8CwmoG8jlxRyluwzLg8pASuVW7QAgYATPx7y0OVbmdzGoCQXiDmFsEk
         XMfAQw6gAXZgwpzNhuTyWbPHJvhz9aeLYMngkvMIApZwhl5JAxbvNmh68ODZKP+/D4Wj
         LSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440000; x=1729044800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFkWhPmTItJU9grZqoWlnaz0AzjA9TQpCpck29q/bX8=;
        b=WxR7hYym9pVwOE3bOARSquBUj2bGr7kzVaqh4aQW5svfGqXAnomaV+O49TPei5DE5l
         sBy6UCpu2fS/1sqxpgPKZswebZFzJoVwWTuOtgCyH7cONPvjEu4Fw0qJgNDIB4cO7L9P
         I+7w81atKQwUWMPFMRf0NHe3SdtUbXlePO2/w0tIUDCEhhbJ3CJx4241m2vZxfTrPbFW
         rbpCPCSqfahPwBOGo17SuN8A3Z/uCOvOVJMB3EaqcLp8zIVOAMW83mw/c8uRt2IgKPHa
         McUhBLd6GLBwEPhK4SzaBPWW3d6VlkxNB8PKOpzis48DQLAFPCvb5LRIgpLo+Z6vDhKd
         zWJg==
X-Gm-Message-State: AOJu0YwEPlC7vgqigeTeTEwxgEEOUD4ipxQfTi8AYrMna+CV+eD6vidq
	n7MUcyil6yus/kUDD7nu1U16yDYJXGlTx5Jk0bW2ka24DPtbzQVDH3RFBQ==
X-Google-Smtp-Source: AGHT+IHKsBtJ8rKCSyXbTQUdATzVpEKQjwA9XbA21kbAu/zIg9eZXEh2GBOaaQKCo4cbVeFxlAVtdA==
X-Received: by 2002:a17:90b:198e:b0:2e2:af57:37eb with SMTP id 98e67ed59e1d1-2e2af5748ffmr89339a91.41.1728440000619;
        Tue, 08 Oct 2024 19:13:20 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5a7579esm307696a91.51.2024.10.08.19.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:13:19 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: test with a very short loop
Date: Tue,  8 Oct 2024 19:12:54 -0700
Message-ID: <20241009021254.2805446-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009021254.2805446-1-eddyz87@gmail.com>
References: <20241009021254.2805446-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test added is a simplified reproducer from syzbot report [1].
If verifier does not insert checkpoint somewhere inside the loop,
verification of the program would take a very long time.

This would happen because mark_chain_precision() for register r7 would
constantly trace jump history of the loop back, processing many
iterations for each mark_chain_precision() call.

[1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_search_pruning.c       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
index 5a14498d352f..f40e57251e94 100644
--- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -2,6 +2,7 @@
 /* Converted from tools/testing/selftests/bpf/verifier/search_pruning.c */
 
 #include <linux/bpf.h>
+#include <../../../include/linux/filter.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -336,4 +337,26 @@ l0_%=:	r1 = 42;					\
 	: __clobber_all);
 }
 
+/* Without checkpoint forcibly inserted at the back-edge a loop this
+ * test would take a very long time to verify.
+ */
+SEC("kprobe")
+__failure __log_level(4)
+__msg("BPF program is too large.")
+__naked void short_loop1(void)
+{
+	asm volatile (
+	"   r7 = *(u16 *)(r1 +0);"
+	"1: r7 += 0x1ab064b9;"
+	"   .8byte %[jset];" /* same as 'if r7 & 0x702000 goto 1b;' */
+	"   r7 &= 0x1ee60e;"
+	"   r7 += r1;"
+	"   if r7 s> 0x37d2 goto +0;"
+	"   r0 = 0;"
+	"   exit;"
+	:
+	: __imm_insn(jset, BPF_JMP_IMM(BPF_JSET, BPF_REG_7, 0x702000, -2))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.46.2


