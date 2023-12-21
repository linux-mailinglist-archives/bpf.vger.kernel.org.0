Return-Path: <bpf+bounces-18478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5481AD97
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FBEAB22E52
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 03:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73224C64;
	Thu, 21 Dec 2023 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaehkeI0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD7522D
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35f418f394dso1454645ab.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703129949; x=1703734749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL85L7CxeUz8xKEsZNpnUof2sxAyDVTU8FyhwDWG87s=;
        b=KaehkeI0lN/OqvHwOEqSk/CT029BIOX+dNiYWeBKKEfHNjqx14LPAbE/vEAwXycfWB
         HfqctMfis5DX3rFHx8AvjUqox90n53sEIN2oU0R0kaChysoDOQ2QjYuk9WylegKBElkm
         QRcXduUwnnpAZhwfYV4spxUPaLi/GcLBvkv/xDpG14MqU8CjiIITycrZz+sqIf7vHfB+
         RGKBC7FX71rjT1GhgRzWJFQqNtLzQ1Wbz0xahu3Bdo4uagRqjEenljfEcIriritFxbVP
         o8EP0wDodgENpFreMlGTiB+tAPFTn5CC7xhv93BKrEkrJdwhNwUGH7npWsdUI0ablszS
         N9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129949; x=1703734749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL85L7CxeUz8xKEsZNpnUof2sxAyDVTU8FyhwDWG87s=;
        b=oWSckU0tBBPpPuUN7Goh3MUGvGCGzvFMk0bqK1DYltEvIqXIz19vdhyYB/LK1st1Wi
         2cnnpM/PRnMmuqrdb+BecfMlZp9twq5gZoGosJyFFXOP6HkCrC31C95gUNFYjvuqp13P
         n+mVgYGbiqV0Vr2VuljQKps/SeG4wjUaippAwX7NYY31foSHTn9kLXpZnPV1M/66a83X
         rdd6v51JvlZ7bIIdrApWTQNu7+V7StEdcVyyRDyZSAqNrz7LDDezJJI9zfe6VLeRMfmv
         hbAvyOW57I3Zc23S54AjUzFGmRvtRJkkgyGTcC3Ch9SyOvwt6u+L3E9ItToUGbwf/Uy4
         wyDQ==
X-Gm-Message-State: AOJu0YxLIVyNP4LCawaxFOxqKoZcBGNFihf8/9QnELKI3FKg4PyZhDLG
	+nZ/cI/tw9XQlczBuwnnF4M=
X-Google-Smtp-Source: AGHT+IH4kU9XxuQndcKVPAXIjpMnsX15aHngeMbqj7jw2f2Sz97+A/eGClfJKmF1/wuIEZ9AkG4OVg==
X-Received: by 2002:a05:6e02:1c2f:b0:35e:6aed:e523 with SMTP id m15-20020a056e021c2f00b0035e6aede523mr29731000ilh.13.1703129949038;
        Wed, 20 Dec 2023 19:39:09 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:ec38])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709027c8b00b001c755810f89sm475136pll.181.2023.12.20.19.39.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 19:39:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net
Cc: andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 3/5] selftests/bpf: Convert exceptions_assert.c to bpf_cmp
Date: Wed, 20 Dec 2023 19:38:52 -0800
Message-Id: <20231221033854.38397-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Convert exceptions_assert.c to bpf_cmp() macro.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/exceptions_assert.c   | 80 +++++++++----------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index 0ef81040da59..84374c3ef23b 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -11,51 +11,51 @@
 #define check_assert(type, op, name, value)				\
 	SEC("?tc")							\
 	__log_level(2) __failure					\
-	int check_assert_##op##_##name(void *ctx)			\
+	int check_assert_##name(void *ctx)				\
 	{								\
 		type num = bpf_ktime_get_ns();				\
-		bpf_assert_##op(num, value);				\
+		bpf_assert(bpf_cmp(num, op, value));			\
 		return *(u64 *)num;					\
 	}
 
-__msg(": R0_w=0xffffffff80000000 R10=fp0")
-check_assert(s64, eq, int_min, INT_MIN);
-__msg(": R0_w=0x7fffffff R10=fp0")
-check_assert(s64, eq, int_max, INT_MAX);
-__msg(": R0_w=0 R10=fp0")
-check_assert(s64, eq, zero, 0);
-__msg(": R0_w=0x8000000000000000 R1_w=0x8000000000000000 R10=fp0")
-check_assert(s64, eq, llong_min, LLONG_MIN);
-__msg(": R0_w=0x7fffffffffffffff R1_w=0x7fffffffffffffff R10=fp0")
-check_assert(s64, eq, llong_max, LLONG_MAX);
-
-__msg(": R0_w=scalar(smax=0x7ffffffe) R10=fp0")
-check_assert(s64, lt, pos, INT_MAX);
-__msg(": R0_w=scalar(smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
-check_assert(s64, lt, zero, 0);
-__msg(": R0_w=scalar(smax=0xffffffff7fffffff,umin=0x8000000000000000,umax=0xffffffff7fffffff,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
-check_assert(s64, lt, neg, INT_MIN);
-
-__msg(": R0_w=scalar(smax=0x7fffffff) R10=fp0")
-check_assert(s64, le, pos, INT_MAX);
-__msg(": R0_w=scalar(smax=0) R10=fp0")
-check_assert(s64, le, zero, 0);
-__msg(": R0_w=scalar(smax=0xffffffff80000000,umin=0x8000000000000000,umax=0xffffffff80000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
-check_assert(s64, le, neg, INT_MIN);
-
-__msg(": R0_w=scalar(smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
-check_assert(s64, gt, pos, INT_MAX);
-__msg(": R0_w=scalar(smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
-check_assert(s64, gt, zero, 0);
-__msg(": R0_w=scalar(smin=0xffffffff80000001) R10=fp0")
-check_assert(s64, gt, neg, INT_MIN);
-
-__msg(": R0_w=scalar(smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
-check_assert(s64, ge, pos, INT_MAX);
-__msg(": R0_w=scalar(smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff)) R10=fp0")
-check_assert(s64, ge, zero, 0);
-__msg(": R0_w=scalar(smin=0xffffffff80000000) R10=fp0")
-check_assert(s64, ge, neg, INT_MIN);
+__msg(": R0_w=0xffffffff80000000")
+check_assert(s64, ==, eq_int_min, INT_MIN);
+__msg(": R0_w=0x7fffffff")
+check_assert(s64, ==, eq_int_max, INT_MAX);
+__msg(": R0_w=0")
+check_assert(s64, ==, eq_zero, 0);
+__msg(": R0_w=0x8000000000000000 R1_w=0x8000000000000000")
+check_assert(s64, ==, eq_llong_min, LLONG_MIN);
+__msg(": R0_w=0x7fffffffffffffff R1_w=0x7fffffffffffffff")
+check_assert(s64, ==, eq_llong_max, LLONG_MAX);
+
+__msg(": R0_w=scalar(id=1,smax=0x7ffffffe)")
+check_assert(s64, <, lt_pos, INT_MAX);
+__msg(": R0_w=scalar(id=1,smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+check_assert(s64, <, lt_zero, 0);
+__msg(": R0_w=scalar(id=1,smax=0xffffffff7fffffff")
+check_assert(s64, <, lt_neg, INT_MIN);
+
+__msg(": R0_w=scalar(id=1,smax=0x7fffffff)")
+check_assert(s64, <=, le_pos, INT_MAX);
+__msg(": R0_w=scalar(id=1,smax=0)")
+check_assert(s64, <=, le_zero, 0);
+__msg(": R0_w=scalar(id=1,smax=0xffffffff80000000")
+check_assert(s64, <=, le_neg, INT_MIN);
+
+__msg(": R0_w=scalar(id=1,smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, >, gt_pos, INT_MAX);
+__msg(": R0_w=scalar(id=1,smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, >, gt_zero, 0);
+__msg(": R0_w=scalar(id=1,smin=0xffffffff80000001")
+check_assert(s64, >, gt_neg, INT_MIN);
+
+__msg(": R0_w=scalar(id=1,smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, >=, ge_pos, INT_MAX);
+__msg(": R0_w=scalar(id=1,smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, >=, ge_zero, 0);
+__msg(": R0_w=scalar(id=1,smin=0xffffffff80000000")
+check_assert(s64, >=, ge_neg, INT_MIN);
 
 SEC("?tc")
 __log_level(2) __failure
-- 
2.34.1


