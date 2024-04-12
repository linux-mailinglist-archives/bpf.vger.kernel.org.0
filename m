Return-Path: <bpf+bounces-26669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370F8A37AB
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F281C214E4
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0B155347;
	Fri, 12 Apr 2024 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD1vY0BI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B151514E3
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956112; cv=none; b=ioa0XaTOVD92u0UjTgVBrB12E81H2R3rydeE/9jd2sl3mLKLP2OePexnlJqpbhqo1vZbHl2Tu3SaQst3G3yqkYnbkfWVRbzZ1Ctp6RDYWAf2C+AvGwwGs3GI7I4E6CwpNM6HKae50mtv0NP0GBx7/PNK1MYNKtgF0VKFNhxuHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956112; c=relaxed/simple;
	bh=WqjYgyHey8ZaGJ0KCr/4HIlllNyG29jbp0/EBTx83R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WioVZWtvrQJdWl0t5RLjMBpAFVeePNf/8r5WbAbuKd/WVMLQ6XGlVjGvx0QAMd2nvUOBvbBVPyFw8JgUCSsN0hbovKrMt0ZCbOjvFhAp5kNkgM58JnSt5gZAGvOt9eHr5BcYYmFZnL97UVVJP++JcjZhOvYFHzjCz1lPH6uOz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD1vY0BI; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22f746c56a2so636487fac.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956110; x=1713560910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0q/ZdC0G1jUqK369GNantm3vlcpUDTGm2krIxfZLzk=;
        b=QD1vY0BI2kCH/Sd/mp2Eh2UkOhbtUOuEHtlcjqPheQoLrVO2Sz5aGMIGaJxhMlEsq9
         VWA1kDstlF+W9rC77y48mVE/VqBTBkzVdXI2NtkjW9QIE7lMRYl3TFQldHsh+jio+ecy
         a+ooVxkrtesueP2OTSe+24wHkU6rHgkt9T5w9MINQfig67RPkQta6QqMX00oYCOCj/yv
         vwSsAQcO9b0jKXLAnupmS9jUJVkLQpJVbfIXefdaMKVhD1saaVdhn4JCWJZzTsyhN+cn
         Yro4+msL/DQC0mX9fnzVn0Q2FWT2mf73I2RhQ+B+JGK9DXAcBb3PI4HEtkqgRgl2VHKO
         lUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956110; x=1713560910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0q/ZdC0G1jUqK369GNantm3vlcpUDTGm2krIxfZLzk=;
        b=cOhIZOEhds5sBOGyQkokvLMsQZ0mNK3MnVYo8ycJI9parEWNRmr0JeCCGx0UqRaF6b
         MXbbQXxSTdIjSpRbK+qQejcyrcGtB7IKda6okvXK5VK8XqrUm5u82amHEiZHiEdQjJyl
         787JsPoj+/p8z+fK+m7O6Ij8Nre98ds1IFXZYS4VxGAlJf9t03rbWVXcHMjRrwJnGw/O
         xvGUIXSXslHXRPy/UbrajDz+JEQJC0qzhDF0PvnWBvm1wTQPsCYVD7P5m911Jf6y5gmR
         s7RPnowLU9zR6xGga/8mJPmk5WlBvjQcXIZGERwDv6SoEAYiODawCFzxgnCCqrHqUi8X
         6Nzg==
X-Gm-Message-State: AOJu0YxXtPZvN0KfBNDxjf1BXO1YsCdAyBsw7Ld7UOTqpgYpFRVEbZAX
	b7fkmMr364FlYb5NQKGecf2mPGi3e7r3zVJJRFl4jVfl/xTL82h3otelfw==
X-Google-Smtp-Source: AGHT+IHYpfXIb6pRPPbxLB+uBcpqQIeXmYipspbOInfWVzjG36yvtZv1Io3uMvw3jxJCEICwxLGc9A==
X-Received: by 2002:a05:6871:a583:b0:232:f991:8fc4 with SMTP id wd3-20020a056871a58300b00232f9918fc4mr4193406oab.46.1712956110467;
        Fri, 12 Apr 2024 14:08:30 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:30 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 11/11] selftests/bpf: Test global bpf_list_head arrays.
Date: Fri, 12 Apr 2024 14:08:14 -0700
Message-Id: <20240412210814.603377-12-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure global arrays of bpf_list_head(s) work correctly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    |  6 +++++
 .../testing/selftests/bpf/progs/linked_list.c | 24 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 2fb89de63bd2..0f0ccee688c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -183,6 +183,12 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	if (!leave_in_map)
 		clear_fields(skel->maps.bss_A);
 
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_array_push_pop), &opts);
+	ASSERT_OK(ret, "global_list_array_push_pop");
+	ASSERT_OK(opts.retval, "global_list_array_push_pop retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.bss_A);
+
 	if (mode == PUSH_POP)
 		goto end;
 
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 26205ca80679..7c203b5367a7 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -11,6 +11,10 @@
 
 #include "linked_list.h"
 
+private(C) struct bpf_spin_lock glock_c;
+private(C) struct bpf_list_head ghead_array[2] __contains(foo, node2);
+private(C) struct bpf_list_head ghead_array_one[1] __contains(foo, node2);
+
 static __always_inline
 int list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
 {
@@ -309,6 +313,26 @@ int global_list_push_pop(void *ctx)
 	return test_list_push_pop(&glock, &ghead);
 }
 
+SEC("tc")
+int global_list_array_push_pop(void *ctx)
+{
+	int r;
+
+	r = test_list_push_pop(&glock_c, &ghead_array[0]);
+	if (r)
+		return r;
+
+	r = test_list_push_pop(&glock_c, &ghead_array[1]);
+	if (r)
+		return r;
+
+	/* Arrays with only one element is a special case, being treated
+	 * just like a bpf_list_head variable by the verifier, not an
+	 * array.
+	 */
+	return test_list_push_pop(&glock_c, &ghead_array_one[0]);
+}
+
 SEC("tc")
 int map_list_push_pop_multiple(void *ctx)
 {
-- 
2.34.1


