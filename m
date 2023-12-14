Return-Path: <bpf+bounces-17792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D938127F2
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5111F21A1E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35C7D263;
	Thu, 14 Dec 2023 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajXqj6/e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D4F4;
	Wed, 13 Dec 2023 22:28:46 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-7b45ab9e084so325200139f.2;
        Wed, 13 Dec 2023 22:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702535325; x=1703140125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsGm+j7nwlGOQcDgyTd4xbThNMw0KWzAWGGOI0U9NQE=;
        b=ajXqj6/eyuXW9Yvdyq1mzAlxNtyZ+Oq1xYBRrLe5mITwB3lO7mEWxLiaGqNTNyIVj+
         T0eng5GwntVkJpNrM5InQMkmKE0SQrL4754u8NLuqIrDNOn+uuGB2KVbZSQqhcn2dkce
         CJRyRtAxCxxuIrRbbZUWBMdh0mrvdwpSHu5SIFvP/SVOCmz3mTNOna5ufuF3n2kVn+Q0
         Lzbm+K/S7ZCdBqgF6apWMt7zC6w462qwBHHP7OW/KmbrSPphQyiIwslZF1OCgI738zxm
         N6TuvDd4uPNG3c6vmZqHfUKT7GgpiLoson7BVAxcvX/ljjgPHJuLW26cUfatKup3nR0t
         aukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535325; x=1703140125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsGm+j7nwlGOQcDgyTd4xbThNMw0KWzAWGGOI0U9NQE=;
        b=o4tMOSK0DVdKkboRAHDODeBiFjcl5o2jYpr8m0WN8gZLOv1TdlYpVF5rsnJy1DHpnJ
         /wiu69b5oiHW8rQ76fuE0XEqsjv4phmvcRYneQa5wyvb8KdAK08KZZ+UEVw7KbK697Ek
         WMfObou4Qj18FoyruWTdwz2ApznLythmFnHUSQ+ZyBBwRib2dYkc/H+IsbFZAzFOOEy9
         ecE4HZJ6OZ81J+JlBgA9sLnH/+sF0yvrDk2TVSva23xWw8GN9G/BOYCeHj9PoSV22Kp9
         IJZ0env/jkujnL/3tBzCLgfslimalVC7nQwYuz0ngTP2uqdgt382xv5h20Dy7+r6n2x/
         XSuw==
X-Gm-Message-State: AOJu0YyL5HYXcLBRG5ScM2OP/6p6EZDi9sEdXgO8hk8fVxEqJqfiRXhR
	gx1Qo9y6DXUJBx25zMlEha0=
X-Google-Smtp-Source: AGHT+IGlZg/DY0rf8exPQGNki32QDzNyU516U6ngtZG/Ojs4M0/ofTA4sp3X9XEO7x/gT3rDdLttWw==
X-Received: by 2002:a05:6e02:1a44:b0:35d:59a2:332b with SMTP id u4-20020a056e021a4400b0035d59a2332bmr13251059ilv.47.1702535325386;
        Wed, 13 Dec 2023 22:28:45 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e107000000b005af08f65227sm10744770pgh.80.2023.12.13.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:28:45 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: activate the OP_NE login in range_cond()
Date: Thu, 14 Dec 2023 14:24:34 +0800
Message-Id: <20231214062434.3565630-3-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214062434.3565630-1-menglong8.dong@gmail.com>
References: <20231214062434.3565630-1-menglong8.dong@gmail.com>
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

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
v2:
- add some cases to the "crafted_cases"
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 0c9abd279e18..53b8711cfd2d 100644
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
@@ -2101,6 +2096,24 @@ static struct subtest_case crafted_cases[] = {
 	{S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}},
 	{S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
 	{S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
+
+	/* edge overlap testings for BPF_NE */
+	{U64, U64, {1, 1}, {1, 0x80000000}},
+	{U64, S64, {1, 1}, {1, 0x80000000}},
+	{U64, U32, {1, 1}, {1, 0x80000000}},
+	{U64, S32, {1, 1}, {1, 0x80000000}},
+	{U64, U64, {0x80000000, 0x80000000}, {1, 0x80000000}},
+	{U64, S64, {0x80000000, 0x80000000}, {1, 0x80000000}},
+	{U64, U32, {0x80000000, 0x80000000}, {1, 0x80000000}},
+	{U64, S32, {0x80000000, 0x80000000}, {1, 0x80000000}},
+	{U64, U64, {1, 0x80000000}, {1, 1}},
+	{U64, S64, {1, 0x80000000}, {1, 1}},
+	{U64, U32, {1, 0x80000000}, {1, 1}},
+	{U64, S32, {1, 0x80000000}, {1, 1}},
+	{U64, U64, {1, 0x80000000}, {0x80000000, 0x80000000}},
+	{U64, S64, {1, 0x80000000}, {0x80000000, 0x80000000}},
+	{U64, U32, {1, 0x80000000}, {0x80000000, 0x80000000}},
+	{U64, S32, {1, 0x80000000}, {0x80000000, 0x80000000}},
 };
 
 /* Go over crafted hard-coded cases. This is fast, so we do it as part of
-- 
2.39.2


