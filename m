Return-Path: <bpf+bounces-62712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9DBAFDAA9
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 00:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45740168C8A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC4123ED69;
	Tue,  8 Jul 2025 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQsCdkvD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B881A841A
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012546; cv=none; b=O3gCWXs0Wa55eAgiFJXAIIFFI84VIS4TX/rrTcj3Mu5HkzT5Wfy2XzJLm5ou4M7aHvBQ4/QBXqBcR/kd2hlR8wXYyw2auSw2Yh1aAPgapCYe7xWiDFEFPD6PhT6VtoCGHUrYxYCCVX/OSd+Rwd8RZl/Dk+MVFUPpeyqvXpvUQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012546; c=relaxed/simple;
	bh=jla9LWbFRwtZnpRT6q1BOV+PSjuZ4OFpi7LdNC9s5Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOU+UpZdrfcIXseFj/FNat/WwkK4e6JGj7uqklNQn0KSuqFfhFRX9DJ5B30j1dn3V/dSltMSC6mWy7MyZupWQK5L8FPk3pfuZtHafOxS7DTfFmp8DAhxRgd6Xjq8xN9RxFgwXTh/KP3x809iW1Cv/i6Bn9a4+aBjNjMbGjemtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQsCdkvD; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7111d02c777so39887237b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752012544; x=1752617344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVL1tJW9UCtJ+4gtd3EeFqijLJs0neJCMndT8HVj6A8=;
        b=kQsCdkvDvrFVc0fQVmBce5J8c7ehJlAtAdxcptiID01cxHKJ2ueyV6wy/CKqLlmKx7
         TvpjZh7T5ZMYQRBVflk9EzhR4QRKc7tSpDvbF5B1WYfHzCDlqaS+i69KSoGoMFB1FxcE
         63tpCx/fDmapQuzZY58JeWmkGoGuAlQjV/DV+csJDfY/vAL25K4XvEBoe1SZRj0ySrBD
         pNpIHI6bBo2xjvkXpxy8Q/vF5rVXoj4e0TfnqI4eRZm8aKyysrJll5ghgaXMWlQtNJOL
         3VPoGmJFh8frVj1vVfYWC5oFmM47lZYOINutkf2yCOqm7HrRqnmq5qZ53AVXx7Ozk9Wb
         G6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752012544; x=1752617344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVL1tJW9UCtJ+4gtd3EeFqijLJs0neJCMndT8HVj6A8=;
        b=iJt0EFodx3Eyu1qu5aw0BKc6rLIduiWIibhh20+ZvAxDkv9Tpe19dA1yupV9rVsMY/
         DwdmUexTFU38CgB1IaqHqRz7VCH9+MP7Wx6QK5uXmyOqtFS9w8Bga+Uy91QtRh3WpBTN
         HUtb6v0ecTC7TazWMZCKuXXnPgRwR8ulhOIqQSOpb9YJI5Nev0aExFnRerRXuOIIRi95
         x/raFfNSL63n+NHKEuUZ1u3aYmKtTRPerw2q9+Xb3OOGfUmAXIfPvbw3IU8/hrBlC1Ce
         ff182nfJrqLoxLXZZiHlp8gv2inKgepVAuIqPURrJXmgkf7fZD+9SKSJUcu3+Ok+0a4j
         LcvQ==
X-Gm-Message-State: AOJu0Ywj+Ej+WpcsLZo0hob4aSxGogNziDBSOwB5pL8UstJ+LKPyos4y
	hZaIuAGICAspGAC+zZrbFOnnSmgLowLlwDZtl2dXbz2inHjaEEuP9if9MDBnttGA
X-Gm-Gg: ASbGnctrU22bJz6jhhGg4wxeaEO3txhmnmzHKmOx+GXB382FDoEUrQ1zZIi7hCGQ/T5
	kVMf1cVZOiTsw0CLeS1XHWzK4WCOYoKWd9qwb40z8y52hiAIfocu043SubkCNIlxEbaTy+nGHMt
	xiZQg7GVljVR/5aed7aV11oNrfGhe2rXb6oXnErTXsF3Kx5AsJppzlsQVrKLhB0VN4pOPxXh1Bf
	7dSevdGtt91qwNYyR387VG+JF9gHpassybOMP5RQKWhgqhLGZE5rLQ+sXNGFr4PklctYjRIjI9l
	YDgTC82WVHMdhSQjM29wjE03UKewKlrWQPciNU1hDsxvPYs7TmN1
X-Google-Smtp-Source: AGHT+IGrZE2+Sa2JNmaJLfqgdaswVwgDU7aJ8sp92gRBMP5eR3yudpWCBxjsXDCOgABHfB5RaGzgkQ==
X-Received: by 2002:a05:690c:6609:b0:70e:d35:fbdf with SMTP id 00721157ae682-717b198863bmr6244157b3.17.1752012544079;
        Tue, 08 Jul 2025 15:09:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-716659a162bsm22912487b3.49.2025.07.08.15.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 15:09:03 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Amery Hung <ameryhung@gmail.com>
Subject: [PATCH bpf-next v1] selftests/bpf: remove enum64 case from __arg_untrusted test suite
Date: Tue,  8 Jul 2025 15:08:56 -0700
Message-ID: <20250708220856.3059578-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enum64 type used by verifier_global_ptr_args test case requires
CONFIG_SCHED_CLASS_EXT. At the moment selftets do not depend on this
option. There are just a few enum64 types in the kernel. Instead of
tying selftests to implementation details of unrelated sub-systems,
just remove enum64 test case. Simple enums are covered and that should
be sufficient.

Fixes: 68cca81fd57 ("selftests/bpf: tests for __arg_untrusted void * global func params")
Reported-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_global_ptr_args.c        | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index b346f669d159..181da86ba5f0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -275,11 +275,6 @@ __weak int subprog_enum_untrusted(enum bpf_attach_type *p __arg_untrusted)
 	return *(int *)p;
 }
 
-__weak int subprog_enum64_untrusted(enum scx_public_consts *p __arg_untrusted)
-{
-	return *(int *)p;
-}
-
 SEC("tp_btf/sys_enter")
 __success
 __log_level(2)
@@ -306,10 +301,9 @@ int anything_to_untrusted_mem(void *ctx)
 	subprog_void_untrusted((void *)mem + off);
 	/* variable offset to untrusted mem (trusted) */
 	subprog_void_untrusted(bpf_get_current_task_btf() + off);
-	/* variable offset to untrusted char/enum/enum64 (map) */
+	/* variable offset to untrusted char/enum (map) */
 	subprog_char_untrusted(mem + off);
 	subprog_enum_untrusted((void *)mem + off);
-	subprog_enum64_untrusted((void *)mem + off);
 	return 0;
 }
 
-- 
2.47.1


