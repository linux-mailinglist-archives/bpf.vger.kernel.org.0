Return-Path: <bpf+bounces-74450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CEDC5B0A3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 03:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14025350627
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D9D246BBA;
	Fri, 14 Nov 2025 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeyCJZiP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C1186E2E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763089068; cv=none; b=UHEvVzuV3dtL4nEa1fOLVza+53irW/lvKFNIKniLnWC2enXcZBYFDVUnD9a0GjuUZ6XW46FjcqdYnj9NecG09LHpJmpiHYat50iAKWvyQokRB6ac2LDZRGhUWnwevJSQBDeWLz7t3EsvYod3RfsRZsJkFz6086xdi/3dcpBTcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763089068; c=relaxed/simple;
	bh=C5I/KLKyzvI6VI2cHJok+9pbr+u3j0S6xw0EYoqQmJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0mHr69BKh4Uku7d5n5kmApt28UHxvqsxdYdOfsyuTNy6MKACbfFJYX3Z4/+NRL2dzxfTkGms+OLz0XKEKRuKnCeOs8dodWz8YX7VnAo/sXu0WQSFFV2UoiQaW8kk5AO7yuKVyMWsIyHkB74fivwKc0pUDH/KsVZg5itrjLvV+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeyCJZiP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297d4a56f97so14741165ad.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 18:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763089066; x=1763693866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY5A8PSndCLem0Ud36nWLWvC+uy4Wv2W4G029MRrrZo=;
        b=FeyCJZiPW+LeBiU/DmHF3uslLHFX0jvG/7cRQKfBMxZq5WfFaJ3aVecscSWj3CM4gu
         0+ZO4crtlLTtNUjw+USIT4lrmAPNVQqhp5SLdJTThIVsDJlgatvwVhJnEEGhLWmhAXuq
         VXE9jqba8/k3wVgM/yxLFMwfPBY04WR8R8kAWO4Va+6FOXw93D+I4wM+sUD9WgGmNrNx
         meh09zBhCCIQoFoPUdpMnZ5phVEP2ZBuaqPTZYjsInyOXBgHcZSENqDyWyllCh1q08r5
         851flOoIjd5t1pYcqmcy6ziBIklBVBHDzYRVEv7kinXER95lra1SWLM2MCpXNl2zNRvF
         iskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763089066; x=1763693866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gY5A8PSndCLem0Ud36nWLWvC+uy4Wv2W4G029MRrrZo=;
        b=naPCgbgdN/8qDPRCwUIrwBmGw7SYWfLauXaTSSACmAWZ9Jbk9D6f0E4PaEaHSreUt9
         w8h2iAAyLGsUfKvkwiBCRSg3Sn95ITT8UBEwT2B0XJLj8Fu1KPNMOBpNy+olAyENBNw8
         QDWDMElCT0d6xmucD5qY8a//GeQh43Sr0jWJPinQsCrKnFzdjeQE5Bf2EP3Lm/yzsQVM
         GMrb0O+98+Y2T3uUJ3W7uhDxe7V3JBlM9YIMumjy53F+xgUd9nh2JtnZlrusqFZwiKVM
         YmqimG2iIVuqmVRllmu/cC1Dlu0V+gsymExb26vihlMpqx2N4k52enJ5QpbQ+CTfyzTu
         6K7A==
X-Gm-Message-State: AOJu0YwIJVBktTSMk5/HvRlcsTe0DYjNU4vcbEYd2T0iXHb8ZSQAPTEM
	dNglcaOzTfN7+z90YJEOhfmZt74s75pvroEPbtEPEplGRlf/rakIIsUhNTjyg54B
X-Gm-Gg: ASbGncuGwl4CEm7pdpyJf2xTWES3bxo8gKWMwV0bOayoXt9yab6/gDSVG32y/1di4RX
	13k+dnM0mFpDipNtXNzurkCbBVvTeMatDsCMeUXPiK4kNlIdnK73IidoDJCTAKgChUr80lwUfk3
	PIAO4x3KlZ7lNoNZELOPjsKZHM5tcNCPWUIHHyCEroGbWo/EagGZw0d/HqpIji2EN/w/oDThYPF
	5id9UTWq/k9C+mUjUXT4qjAlPPaJlK4yOxSW8DGjZjN12ByLjZ2Cb1vPhQX2agU8LrjkMdeUd7V
	aIlQhWrbpPEZ1fVOQhwIVxQrFe5flZeT+WbVtxrzFKVvhxWvF2vAWkWQsG2lnjjbdtotmpPTclw
	awp6hvajVG7dkpPeXK7jrRIU7rM3OA1eQsP90KnfJkDszfYBzE4+kNupgw6vUZoq6MFm1QTSJID
	PSWb8WaLzNwd3T
X-Google-Smtp-Source: AGHT+IEcBXexXIxbZDSjsv0ZQKpGyhfd9oQhxM8JbmlUnpG73+Tyun0RHx2OcBb0sH3OXUhGG/Fepg==
X-Received: by 2002:a17:903:230f:b0:297:d741:d28a with SMTP id d9443c01a7336-2986a72cb1fmr15864385ad.31.1763089066074;
        Thu, 13 Nov 2025 18:57:46 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c92sm38579195ad.69.2025.11.13.18.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 18:57:45 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: widen_imprecise_scalars() and different stack depth
Date: Thu, 13 Nov 2025 18:57:30 -0800
Message-ID: <20251114025730.772723-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114025730.772723-1-eddyz87@gmail.com>
References: <20251114025730.772723-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test case for a situation when widen_imprecise_scalars() is called
with old->allocated_stack > cur->allocated_stack. Test structure:

    def widening_stack_size_bug():
      r1 = 0
      for r6 in 0..1:
        iterator_with_diff_stack_depth(r1)
        r1 = 42

    def iterator_with_diff_stack_depth(r1):
      if r1 != 42:
        use 128 bytes of stack
      iterator based loop

iterator_with_diff_stack_depth() is verified with r1 == 0 first and
r1 == 42 next. Causing stack usage of 128 bytes on a first visit and 8
bytes on a second. Such arrangement triggered a KASAN error in
widen_imprecise_scalars().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/iters_looping.c       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_looping.c b/tools/testing/selftests/bpf/progs/iters_looping.c
index 05fa5ce7fc59..d00fd570255a 100644
--- a/tools/testing/selftests/bpf/progs/iters_looping.c
+++ b/tools/testing/selftests/bpf/progs/iters_looping.c
@@ -161,3 +161,56 @@ int simplest_loop(void *ctx)
 
 	return 0;
 }
+
+__used
+static void iterator_with_diff_stack_depth(int x)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		"if r1 == 42 goto 0f;"
+		"*(u64 *)(r10 - 128) = 0;"
+	"0:"
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"1:"
+		/* consume next item */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto 2f;"
+		"goto 1b;"
+	"2:"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("socket")
+__success
+__naked int widening_stack_size_bug(void *ctx)
+{
+	/*
+	 * Depending on iterator_with_diff_stack_depth() parameter value,
+	 * subprogram stack depth is either 8 or 128 bytes. Arrange values so
+	 * that it is 128 on a first call and 8 on a second. This triggered a
+	 * bug in verifier's widen_imprecise_scalars() logic.
+	 */
+	asm volatile (
+		"r6 = 0;"
+		"r1 = 0;"
+	"1:"
+		"call iterator_with_diff_stack_depth;"
+		"r1 = 42;"
+		"r6 += 1;"
+		"if r6 < 2 goto 1b;"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
-- 
2.51.1


