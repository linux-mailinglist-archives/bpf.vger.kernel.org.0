Return-Path: <bpf+bounces-54371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56885A68DF8
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 14:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47D0189361B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE3255246;
	Wed, 19 Mar 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXJwE0jq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07635A29
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391328; cv=none; b=Knl+KT63dgo32r+loGCqAq8thGyKYE6Rj0h+BABIkVk/g5avOzExbiJz4MtBeg3EjMXfIAuiMHtrOfdat6ZSde2WXBCz7c/QakUsVcqWXMSY3hdivhsv9eUr17sl5IuO+SFvkpL9t3JXdcTTOgwEx3xwAZraqZpvieE0z14BMOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391328; c=relaxed/simple;
	bh=n42l6RjHzNB1yC64Hfd0f5cb/YINxGS4VzlcyNpI0k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMe0Ioa1kKSArmHkQGx8d6Y2nBdrVEgH3vD6Gcp7fYtYMi7g9PLQBV+tsvD78w/lgz17ZxUk+tXzH/+wcOzUhNLFARqTccR1K6mxq3QFuzKU2MXAWH3v5L6jIVVI67+Vm1PZrPiAvWOG88Xpdja8/fc2F2Kwrn4w6aTT+QIbIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXJwE0jq; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso48143245e9.3
        for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742391325; x=1742996125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKGnpSSDLXQb/evc5sbcwEea8AMZiYl6piUuUuTUj1Y=;
        b=PXJwE0jqpqBQYoGEIznduVpGX0IZ6Dwg04m04JOAdyL+5X5NGNgAwYQqHA0Nl4Yyuv
         KEz3ZR73Dp7Zfwzb0Ecij2DR3CxTMg21n7rg4OEm2gjcpnVFBtJlp5+WFQJ9oOoMIBEU
         thAGQtpqTeQAqEyUoHIlvVbHLPOB0U5k7jRe4QYS1Y7hdLTZUC6vknIEMpICRUZVdShX
         kklru5Ats9MpS1Ij45lcRMB7YACI65Co6TpHmOaieJLKCgqngTMRJ72ut0trD+VEDBda
         9PI/IqXGQ22WfqTza6kS6zTQSCKVaVgopyvCVrE5wl9xNlsmSy4x2uF3Q1kyHZasG0nJ
         ovxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391325; x=1742996125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKGnpSSDLXQb/evc5sbcwEea8AMZiYl6piUuUuTUj1Y=;
        b=Dqem/lZcnfhPzAMzFTgFqUDTSl28JdDG1TvS30g/DfNJog607C0ym0QiwhoXR5AKKm
         kHVqVBKCIiEBYqczJrvk7NgzPwo61nu5b+Ontu4NDsRcBniVHIQR/rBZKsnQ4v1l8bpY
         Ce39vFlkag9JA16xD4wEYzm4wkfPgNvNTlyeG8qcYnxopneVYzj+JfDPAj4y6gkjDC4k
         aQyWm1d3P4OQHy2lManL0zoJOzZfqpBVpIcLJpK69wLhtZ3X0teL6OkLUfqrj9HOi24D
         hy+VC8DbZqVVfIUd/yNnPOjxRhsDLbO647HzU9GB0ghqtkrmoOvfCx09eKnm0PmJBy0u
         Ps2w==
X-Gm-Message-State: AOJu0YzQoLNGAYLTcSavURACYas0SSkuoo0mjGrRoFqxXlCplOFoqdbi
	YRi8vAYwdn986T3soklupJtbs6CXsYVxSxvN/t0xlO/cNysGLHP+le8orxjRCwU=
X-Gm-Gg: ASbGncv1+esybh+lUXQTIdtY1KEJpBF6zsaCJeD9zOZFWLfb2YHF6wvNdrcomXho978
	DkaEQzPQ+i2fU5qYIIu1Wr6xuN+4PoSoCD8ntCuJtavJ7VYcIlVWnRA3wGbVFfUT5tC4sPmSyyr
	W00QkFvtD1qPBdQ1N/Dx/g1K0Z98XKRxbwlSXdD7bEjLRht66SQQGZVp8pTahIvfDgKeSjRk5kY
	G3+pLjqVuJmKpP3wgCuk83yiljeR0phBm+kSBw4M0v2U+VSHnHSy3jAYyn/JMybyCqbB00b/jDW
	q4GQaBpN4DP8M4vjzwfEVQg6vKImbrp9+g==
X-Google-Smtp-Source: AGHT+IGxKp2Hfo8YzIh3PRTM9HDX8ykr88CR5sookCFn8dnr1YCd6lJWAHf0qm4r3hEqbDHxIZ7SKw==
X-Received: by 2002:a05:600c:1c19:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-43d437821bcmr23646205e9.2.1742391324343;
        Wed, 19 Mar 2025 06:35:24 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a1csm20616968f8f.28.2025.03.19.06.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:35:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH for-next v1] locking: Add __percpu tag to decode_tail qnode argument
Date: Wed, 19 Mar 2025 06:35:23 -0700
Message-ID: <20250319133523.641009-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; h=from:subject; bh=1mHb4Ph1OTFLLUxlk5z00euWw+zrZdx3DGj3SEokOco=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn2sXHnpLM62mKBTTcVyV4Xt9F+hCdKEYneGzZAAeC Iv0D5zKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9rFxwAKCRBM4MiGSL8RymgtD/ 9gHUzt0EDKJrAq0qzrggxFqwLAlcEWVPKF5XhjY7QxiWH87Geqr5cb6781aTzxRXPgyT5oUrU/2bXQ g3qGthLHNf+4qJ6hIEPP0lrmPw81G96inphoY5zwV4ZHB0+sTnqCP9xZ31XayamyhoNjcGlr318Fxz 5Z2rusug6s3Mlz9OjDnDd+h6qZlzfKUsyv+kggAGm6aNH5wO14tZXt3gRodVZoGtg1pXGp7SG0a1vW MfC5GHPH40QvG2LHmwc/V/lgKLfIgAo7L21Pmg0YqgvIE3N0GxlC4SZW2GBLVy1WXp5D2WCoaf+ZA2 cR8qLHci1KsQDbzHGNhXwRZe5N/V8xNNPUmuDuOYCmuBEWIyFvP8/GnkOOpYJcJJkavWaORTgIOWY7 gNkTt8qfL/FwZGH+jJwimWyBNuUNUXG0wHAHD5DaJLkVHvZLW3wj2fWKrh6GuAaZHfS2pi1sWMwxEJ bzlLt96Yd1uuTO9z1gTHeYJ1NFGiOizqokhd8XpM0z4sPdziLSq1JgEyL49oYIQvLVvzxm+XUuDPg8 MWhHJIsCKiHKVFMM178ie2AHyDGaXg3j1BWAd6KbMHEj4fevO8PvV+llohpjPvAZfdT80WVebRCB1s crzAAtANyfDdp9oeOzSCY5wulT7UuBVTHk6OmDUsGpD/q6At9EBvYLMGDE3g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The decode_tail function now takes a qnode argument to use distinct
qnodes for qspinlock and rqspinlock. Add a __percpu tag to avoid
warnings and errors and reflect that the qnodes are per-cpu. There
is no actual bug here as the value was not dereferenced directly and
passed to per_cpu_ptr, so this is just to suppress the warning/errors
at compile time.

Fixes: 06988910ee2d ("locking: Move common qspinlock helpers to a private header")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/qspinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock.h b/kernel/locking/qspinlock.h
index d4ceb9490365..f63b6e04ddd4 100644
--- a/kernel/locking/qspinlock.h
+++ b/kernel/locking/qspinlock.h
@@ -59,7 +59,7 @@ static inline __pure u32 encode_tail(int cpu, int idx)
 	return tail;
 }

-static inline __pure struct mcs_spinlock *decode_tail(u32 tail, struct qnode *qnodes)
+static inline __pure struct mcs_spinlock *decode_tail(u32 tail, struct qnode __percpu *qnodes)
 {
 	int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
 	int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
--
2.47.1


