Return-Path: <bpf+bounces-55829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD46A8705B
	for <lists+bpf@lfdr.de>; Sun, 13 Apr 2025 03:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524A47AFC61
	for <lists+bpf@lfdr.de>; Sun, 13 Apr 2025 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF5481DD;
	Sun, 13 Apr 2025 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3HdMV4J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E52EAE6;
	Sun, 13 Apr 2025 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744508573; cv=none; b=HmUbqCCJZiO+YyslWfcftQODZV3qc2uSc9Nu4Ml5kUeIaoT1UmHsZp8iOFxszIwcuohR6oxcdojjYuBNRsWcy6rDV4IhROKRZEnFCXn0Pov0wdwxWjLae4z1EoSHyfnyPeIcz1QM5W67JUif17ci6VQFJM9eUi35NUobF2Q1Rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744508573; c=relaxed/simple;
	bh=fyN+FVg3fT2FJ0oiCBb5+O1msZWh412pAoNt018U4SI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KwO5Ffczoaj4ZRUFb4tHjFXm4tvoQr/LgLcyzLvp0IpCvjstB4qKjTwx4rOzwBaXEpWm5S4YsY7tkeD5sm/hs/1/bxc4wsMbE1Af7iL7pRaRomQzlStwLgAIBU0QAvAXMWWjH6yCvmu2WI1vYtBGQaKgjb48UaIO+HxAXgiplxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3HdMV4J; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-736c062b1f5so2617158b3a.0;
        Sat, 12 Apr 2025 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744508571; x=1745113371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIwlA/jrR/+vYwN+U4SQPrh49I0dSdxWfxw3rzWdRCM=;
        b=b3HdMV4JfS4ODckmlKn7Pxe+ur4oKmp8L/bA6za0bB7TbiAt597cdTYzNcPHGFJuI+
         9RKwXSPIQ/LCiIADt20fZ32Tr97YRl4gl088h+jFGNH6M4tLe7G9zsTMLNB9vZl48oWO
         2GyKqYrhX1iteme+y2oJuJgizMK9cSwkpAe8xvDagdGvPhmJkTtiutO3HlNJ7A2jqy5I
         wMiRZCzSSQSaMJNDaV1kkvpQKBDe2oP4X6nLrzwhX+GQC14NZ/BQPHzzgkIZFdsHFOO0
         PTK0D64mDsp/RVmPib/l3trKO5mfJHPEU6CoUoL/Kaa4ItVxKT01wSu4sh5yQ1HJEkvB
         Fupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744508571; x=1745113371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIwlA/jrR/+vYwN+U4SQPrh49I0dSdxWfxw3rzWdRCM=;
        b=tdT9OqdIxih9T6cj/skFU9/tiIj5nYaVlcRByBbMVqLy50jNR1wcy9D99ihvMGUTWX
         f3Wf75v7n23CTU5mSWYvvhnRZ4vL0qeaKH0koSXyp/fWl+Eb9z6Uufy2ZquccVpfz4jr
         34gW3HO6zRRHHMW71TTBPPJ11gXhqkPZ5npXXFq9ca/qdt/56V4vb1TrCoIBE0T5hqnp
         IW1L9712JlgX73R4tCjYSbzIchBpgHXH182kVwnlRJ7AW2mEL0XTkktoI7Tmqmdmey8T
         UfiD4t/wyaGFqd2v9r4ojDP2Lr6S8Chk9pCEqRaYR7Lh5YRzaCm4/OaNKnQyKJFniSYb
         U8ig==
X-Forwarded-Encrypted: i=1; AJvYcCUAhg31pH67HtqMyyfo44Mwi1tjqPaEFs+rR7y2FlIFQ6b+cq5lt9PMUMRXv7KlPGyUpqSDp+LWcEFptXZRg5yvK21i@vger.kernel.org, AJvYcCWgRFa0l7FqwLtE71k0OSE+4JDDfLQFmPzj0/qPPIsg43Vosn1NN9/80sdkG0Hso4kcbjBlGIbVSo81ujc3@vger.kernel.org, AJvYcCXUzNLRpka161l0YdHG6AbsREmBoIx1PAr86XVcaIwzNGJuDKG/CkTGYmkTrkgi5CVSnes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDq4iQ4i/IGfdw3+9sIfsBopeVH8BANMlqm4lun+GmqNkrF2YV
	bNNY/Z3HZKb9nhmQzqEwrTPtmgwPS5dRAC2GaYoWFzMwovkiiw3D
X-Gm-Gg: ASbGncunXVuDffYa3HlXyIQjMBa0oPZrhvLe4vTt/eV+RBLHUlyTAWTH0F6ufqXjQ5P
	t5Gg2JJ5/YeqfrQZEOleqEF1zhYNMuDoE7w+axRXoHvnTN5rimyk53MWoaHrIeR0u9q0TFuiq6t
	zJkzCXI6mjXEt1S83TPtwDGWb5gPOeTLfBXvbg6xt8RROEVFdEqC5+0HppwMvvGRvITGv8HRWei
	j195HSPiCd/R1bSza1Wo0mokBoo8OJJXmZSn7RpcqGW5cVMw4O0GyQ/W0TO4/CJaApSNiK8bn6V
	O+3IOqw1k/VUYztNMklwgDiOnVpa63/66xSh58a65gySZPXRx18Bdrs4EmFsNvPlsb0F
X-Google-Smtp-Source: AGHT+IGPjBp715NHbFEd4fvUX5ztQXlOZfQFOwURYcmXVgYjtCJweNh/aeDkIJnhBSMeRTVoEYQz/w==
X-Received: by 2002:a05:6a20:9f07:b0:1fd:f8dc:7c0e with SMTP id adf61e73a8af0-2017979b2demr10545255637.12.1744508571274;
        Sat, 12 Apr 2025 18:42:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de7e21sm7014785a12.21.2025.04.12.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 18:42:50 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf v2] ftrace: fix incorrect hash size in register_ftrace_direct()
Date: Sun, 13 Apr 2025 09:44:44 +0800
Message-Id: <20250413014444.36724-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maximum of the ftrace hash bits is made fls(32) in
register_ftrace_direct(), which seems illogical. So, we fix it by making
the max hash bits FTRACE_HASH_MAX_BITS instead.

Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- thanks for Steven's advice, we fix the problem by making the max hash
  bits FTRACE_HASH_MAX_BITS instead.
---
 kernel/trace/ftrace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1a48aedb5255..d153ad13e0e0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5914,9 +5914,10 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	/* Make a copy hash to place the new and the old entries in */
 	size = hash->count + direct_functions->count;
-	if (size > 32)
-		size = 32;
-	new_hash = alloc_ftrace_hash(fls(size));
+	size = fls(size);
+	if (size > FTRACE_HASH_MAX_BITS)
+		size = FTRACE_HASH_MAX_BITS;
+	new_hash = alloc_ftrace_hash(size);
 	if (!new_hash)
 		goto out_unlock;
 
-- 
2.39.5


