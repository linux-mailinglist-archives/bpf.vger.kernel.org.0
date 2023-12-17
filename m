Return-Path: <bpf+bounces-18132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B3A815F3F
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 14:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B01C1F21C1A
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69244C6F;
	Sun, 17 Dec 2023 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzKLY7MN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11DB446D3;
	Sun, 17 Dec 2023 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6d3165ac96bso226580b3a.0;
        Sun, 17 Dec 2023 05:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702819119; x=1703423919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5PxWUcu/ifiy+mTxB+eS5k2/O2oeySj89/JuoUzQzw=;
        b=RzKLY7MNyryEyzhFh/RudabzSklYQPMtFF3J1EMz3YQgnADBRtufbCETHLfhHrv1FW
         /38nQsqt9I3k1ul9seIQtBVJH0LXt5gyywKTRgrPv4fzrnDKfw5iBt8ZWyimeCNpiRFj
         NwuCHrk2jnOXz2tquCqOwK2fU36R+hHOJG45UvEQPW6Q6a/tpnXgRzJsU3ASIPKs7VPi
         SlK1876oVUJlwt5Q/W+x707FZ4YET0BpZa+5YZxY6zccpX8FkQicJkcFkl0Y2ddbmoEB
         yuxws+3eXq/NoxFr4aaIYZk1NRbi8kXdDZm/F7dcqPiYdCemI0ffFdcsFCpYZ7aO67AY
         W9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702819119; x=1703423919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5PxWUcu/ifiy+mTxB+eS5k2/O2oeySj89/JuoUzQzw=;
        b=t7Orx+RSEFW4M2FOXNNVUqcEACVW3ealtviMH6KbFXJ6fsRXfLdWaY5sSjKhsNCxfi
         z93ckoWIbUrv4KUR2UWjUHBAXYnGn/2Y9VI4E01PYmmFrJhSqLetaaQYkr7u9C//CmDT
         5wtkzlpk/b9sAW3rBrAiCssxQVZb+YAhx3IHz4P0hu+GswuxGffCuLd1zL6Ej+mOUb6N
         To8gOEZ9CkU9ixYlQZ2ho/V7u+sAejgvjR4mETA0foqhlLj5eXqffVywqi6bC1TO8Y19
         1wppkszcFqDTTuke7gcyDZ8Eg7dJoCW5gqVgwNUaDv0NDEQwxpKZoA7PzpJztZW+H5sT
         DSfA==
X-Gm-Message-State: AOJu0Yw+plCUc5xijHbqwk+Nty3Q7Bt8D1INbvv9jNnsZ5kf4X4kYeHd
	6AkFrYi2h3NUaT+QWCz0U+Q=
X-Google-Smtp-Source: AGHT+IGPY16Yge/9iDfCYyCspVfPdW7X7tOPmmEr3ZXjdFPg0jTlouyPA+7+iesblpEZ3NVWZ5Jolg==
X-Received: by 2002:a05:6a20:7d93:b0:18f:97c:8244 with SMTP id v19-20020a056a207d9300b0018f097c8244mr9127608pzj.78.1702819119160;
        Sun, 17 Dec 2023 05:18:39 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001d395d3df30sm1099425plw.130.2023.12.17.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 05:18:38 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: activate the OP_NE login in range_cond()
Date: Sun, 17 Dec 2023 21:17:15 +0800
Message-Id: <20231217131716.830290-3-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217131716.830290-1-menglong8.dong@gmail.com>
References: <20231217131716.830290-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The edge range checking for the registers is supported by the verifier
now, so we can activate the extended login in
tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to test
such logic.

Besides, I added some cases to the "crafted_cases" array for this logic.
These cases are mainly used to test the edge of the src reg and dst reg.

All reg bounds testings has passed in the SLOW_TESTS mode:

$ export SLOW_TESTS=1 && ./test_progs -t reg_bounds -j
Summary: 65/18959832 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
v3:
- do some adjustment to the crafted cases that we added
v2:
- add some cases to the "crafted_cases"
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 0c9abd279e18..c9dc9fe73211 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct range x, struct range y,
 		*newy = range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b));
 		break;
 	case OP_NE:
-		/* generic case, can't derive more information */
-		*newx = range(t, x.a, x.b);
-		*newy = range(t, y.a, y.b);
-		break;
-
-		/* below extended logic is not supported by verifier just yet */
+		/* below logic is supported by the verifier now */
 		if (x.a == x.b && x.a == y.a) {
 			/* X is a constant matching left side of Y */
 			*newx = range(t, x.a, x.b);
@@ -2101,6 +2096,19 @@ static struct subtest_case crafted_cases[] = {
 	{S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}},
 	{S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
 	{S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
+
+	/* edge overlap testings for BPF_NE, skipped some cases that already
+	 * exist above.
+	 */
+	{U64, U64, {0, U64_MAX}, {U64_MAX, U64_MAX}},
+	{U64, U64, {0, U64_MAX}, {0, 0}},
+	{S64, U64, {S64_MIN, 0}, {S64_MIN, S64_MIN}},
+	{S64, U64, {S64_MIN, 0}, {0, 0}},
+	{S64, U64, {S64_MIN, S64_MAX}, {S64_MAX, S64_MAX}},
+	{U32, U32, {0, U32_MAX}, {0, 0}},
+	{S32, U32, {(u32)(s32)S32_MIN, 0}, {0, 0}},
+	{S32, U32, {(u32)(s32)S32_MIN, 0}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
+	{S32, U32, {(u32)(s32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
 };
 
 /* Go over crafted hard-coded cases. This is fast, so we do it as part of
-- 
2.39.2


