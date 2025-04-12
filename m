Return-Path: <bpf+bounces-55812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25AA86D4D
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 15:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909BE19E6D46
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288B1EA7C8;
	Sat, 12 Apr 2025 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYfqEYQy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174F1E2852;
	Sat, 12 Apr 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744464840; cv=none; b=uCGmLi5NDfpgWa23wffcl/j3inSjFrmSjJ4568iSF3Fm6l1ICumP4ggbog8Qs1mjNffNDUrNc2XQ6eYjFB2zCuzALfgMGnj9YDusCsCtP0WJnUNZAgsA6gi3PykV4S0Q9vKJ4l+fPdtXwAXRB6NvPkLP2mEd9xYAbF3Evp0HH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744464840; c=relaxed/simple;
	bh=h0IwcTng9sclCvcywK+wNMxJpwXXKHjRD7dMWtaA31g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Od+2Vp4Z0XB6UE/zXFBWJ0uUSBN2Nu63Hf4AiadG5nvd/JbcKvr86VsT4TUyp+sXDWPufgqdi+m7IG6oSzDPnWPjXQ6QFjwHG3F1W2bKWUIlxCE56evUHZsWjuO7SgknO3bQHuPWHbnrylsK51QnqYnK6eYK+0OK3mThoXXash8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYfqEYQy; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-739be717eddso2227652b3a.2;
        Sat, 12 Apr 2025 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744464838; x=1745069638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PikjTMv10qhp5875nc5HxqEEn+j7NbvWOkALbBYBqJI=;
        b=QYfqEYQyo5hUPP/RgpLOPp9eKP7NJhbKV1G32UdtK+m+yopsLEtYr23EeabVkFj4EX
         Lv/1byYFwhMuTNTEOPu3tyswWqmHAzYs2YA6HOIliICEqraeRmiWU1moIZA0rAsh3t3C
         FKwp1T855vGVhcdlrKkq72N+saRCV8ZQ9UPT2+TpXmRJkZt+T1WCb2BsEJ/h2ZzGCMNJ
         atctHHFXNQg/O2hryL9GcpSgJIFWITFTbni+qElHzuZPwTVta8vUfOFH8W0ChIPxLs0B
         hhgwVh8rtTd4pbGY/r0oICz+4qQFQGPnVnrcqVTY0icWzO2/Vm3pKiRqGAbHch8gVMC6
         7j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744464838; x=1745069638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PikjTMv10qhp5875nc5HxqEEn+j7NbvWOkALbBYBqJI=;
        b=DKryjsO3fLByaYBtaNjyNMO7Fp6TObuqFGbnqxCG7PeR2AZearedoyMqIAcFPcHhgy
         2lR8hgptXEWbrPUo/uDwcXvwBhFOpS9Wo/TZ05tWRpt8G2IWfPyDv/EFIhI0JhiX4GTM
         XZNhKl5lk5Rh2XlU1eQxbHRhFVmokZV5l9+bQA08sj1ZiGAXV2sLxsMymyKiR9RErUa8
         IklSwp6M7O87+pGLEysBZkqpI6KofcIDS+W5O6OSg5Bh7kVb48oM1+KYQUh6stn88lxw
         2hvu0S7GtntNzrlwAr6v8w2zgahpZE/JhUI+p9+yOA2yUSiTGmraKTEZiWHNtjb3lux5
         I1hA==
X-Forwarded-Encrypted: i=1; AJvYcCVOWLD+zvDVfrltagng8uoIhPZ2y4ELewc2/0GO8VGLEhW8B0SF6oAzqkjZWv51rcnI3Pmdcut6s8j+juw8@vger.kernel.org, AJvYcCVQFy70YID1YKKP5LSWZHv6JEwqltcCihqfMl4Q10mWsemEclZCvT0hXIrvGZxmnhXwrkM=@vger.kernel.org, AJvYcCWM7fzNuyIl3T3IKJCWcsMdnI+QgX7l7EYyVhhr9Bsk/zIpT+9TxSPT6On2Lf3/82J4G5me7jedHCpNNfrV9mlNPDOo@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAkIUYHLjZy8V7iokJYU1t8psMBMIXSfUzhRi+AD+myRKJzFf
	F1u/oIEHiTw6X5RzNbKggdmoLOCIIXgIfKe5KTmixvvLqOWpcAjs
X-Gm-Gg: ASbGncu7sAH0itwVtkLM1M0ZZQGSkzX8G6ak9QBbKfDilXbQtQCPcqnlH6JWxO8+3x9
	mU9TUZZcLiSKVBzD44L32EvMLsYFFGzA9Ch95L+9iSgNstcYwodoBKRfZtAnMfyqcNXthqE62WR
	1LqnbLfMkaqECFXtlevWkKbR+O1tugMNyyzBgdAm0SGDGdQlCyU18kL2F5faYuSAQ/stIugOB9X
	DZSIazeXc2j8TMacZQs6Q8wLdaZajAQS08DYdF1yAh+mbNdpfuwRRC+pS2+DIyp3zSxnql0btrS
	IRC5mgyF0Fy2s5TKJVYzrEMDd38bcaizVm4IxHDGQD1NBCGnnh/tr5hjxw==
X-Google-Smtp-Source: AGHT+IGYYIUq1yejVEDqyycBAs4SDGA//9qNS7UbRYVxxKNawUS4ATaqgEWFUwX7Xip1qOlbiA/U3Q==
X-Received: by 2002:a05:6300:210b:b0:1f5:7873:3041 with SMTP id adf61e73a8af0-201797a39aemr8992770637.18.1744464837671;
        Sat, 12 Apr 2025 06:33:57 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a12c8ac4sm6473395a12.46.2025.04.12.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 06:33:57 -0700 (PDT)
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
Subject: [PATCH bpf] ftrace: fix incorrect hash size in register_ftrace_direct()
Date: Sat, 12 Apr 2025 21:33:48 +0800
Message-Id: <20250412133348.92718-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The max ftrace hash bits is made fls(32) in register_ftrace_direct(),
which seems illogical, and it seems to be a spelling mistake.

Just fix it.

(Do I misunderstand something?)

Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1a48aedb5255..7697605a41e6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5914,7 +5914,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	/* Make a copy hash to place the new and the old entries in */
 	size = hash->count + direct_functions->count;
-	if (size > 32)
+	if (size < 32)
 		size = 32;
 	new_hash = alloc_ftrace_hash(fls(size));
 	if (!new_hash)
-- 
2.39.5


