Return-Path: <bpf+bounces-18683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAAF81E92A
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 20:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74D828259F
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1571852;
	Tue, 26 Dec 2023 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTqNm+nA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E11851
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce2170b716so1004156a12.1
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 11:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703617928; x=1704222728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdTOk330+fUiIcP9DQ8ulyIb3sOh1nuCEozvriXrRAY=;
        b=MTqNm+nAn86s9uFUqamnLNPnjMAqjXnZvnJ5AsqfqNmgFHU4u0eZaf/56aW9ycL0FA
         mcDCrW9FUjRivDYBneB4+lzAXoujekn+aqQZpGNgWSwHwNgnYSacvQOM2D3F2xcNuDRr
         eqUrlMOGr/8GhX9N7iOKk1C+OkCCrIgjfRoJZjl/7pmm/+7NyPeOZa0U8YZ06+BOD4ip
         16sPpu4/LR7gZ4eWfuMiaFCCYdvu3g3XaMpEzcL4BIUNStfaNTZf4QBult7Kr2rd+9wE
         g4+2aIam/BxqbBiHJTaC20dcyRYETtzbdPdfLo/UhKaJUZm0b95yF58wmAVognDKe937
         djbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617928; x=1704222728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdTOk330+fUiIcP9DQ8ulyIb3sOh1nuCEozvriXrRAY=;
        b=deAYb7EE12yAxTJLOIH9ejXRgpyyGt9+iXSzgF+f25iVphaPuFk7iXlYbl2rpkCvg+
         097MT1iCf0CK1lrLNpnpIofMrHljfUuy//aldmLb4FY/WeuvKyMiySj7qviQXaUEgO7D
         kato+4ftaMr8915dDpTi+/igYobdgy5z3/1jLIFNOUQAdBIiSLcS4oxmw5+oja5Ct0tA
         0Bsd/clCCqt0STEOMvxFHBsxdPBAzodxxUIsXXkbyYAraZtYq3BYIVtR4ImdO2ePOpmA
         Pr0AaYegkXGyyw10DRNVk2lIl+deOiBAcET0Z0vKtxEuQjOni3Uw3pwvAa598rm2WtmD
         5A9w==
X-Gm-Message-State: AOJu0YyzlYL2X55EYb++Pnle1M4hmuB7TvljpepY669Lcj/tPRmNqSnE
	Op40lAHArvwdA7IsBAL0kjy17NJy5W0=
X-Google-Smtp-Source: AGHT+IGXgcfHXNNUoW3ZETG7pQFLnj+ARLgERURkwspRk5PMrNFCg18RYP7Lmd/U+MaDgEvpk3fH5Q==
X-Received: by 2002:a05:6a20:12c5:b0:196:19bb:4429 with SMTP id v5-20020a056a2012c500b0019619bb4429mr4461pzg.0.1703617928006;
        Tue, 26 Dec 2023 11:12:08 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:bc9b])
        by smtp.gmail.com with ESMTPSA id p2-20020a056a0026c200b006d99170ab87sm7360859pfw.182.2023.12.26.11.12.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Dec 2023 11:12:07 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 4/6] selftests/bpf: Remove bpf_assert_eq-like macros.
Date: Tue, 26 Dec 2023 11:11:46 -0800
Message-Id: <20231226191148.48536-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Since the last user was converted to bpf_cmp, remove bpf_assert_eq/ne/... macros.

__bpf_assert_op() macro is kept for experiments, since it's slightly more efficient
than bpf_assert(bpf_cmp_unlikely()) until LLVM is fixed.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 150 ------------------
 1 file changed, 150 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 789abf316ad4..4c5ba91fa55a 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -341,156 +341,6 @@ l_true:\
  */
 #define bpf_assert_with(cond, value) if (!(cond)) bpf_throw(value);
 
-/* Description
- *	Assert that LHS is equal to RHS. This statement updates the known value
- *	of LHS during verification. Note that RHS must be a constant value, and
- *	must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the value zero when the assertion fails.
- */
-#define bpf_assert_eq(LHS, RHS)						\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, ==, RHS, 0, true);			\
-	})
-
-/* Description
- *	Assert that LHS is equal to RHS. This statement updates the known value
- *	of LHS during verification. Note that RHS must be a constant value, and
- *	must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the specified value when the assertion fails.
- */
-#define bpf_assert_eq_with(LHS, RHS, value)				\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, ==, RHS, value, true);		\
-	})
-
-/* Description
- *	Assert that LHS is less than RHS. This statement updates the known
- *	bounds of LHS during verification. Note that RHS must be a constant
- *	value, and must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the value zero when the assertion fails.
- */
-#define bpf_assert_lt(LHS, RHS)						\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, <, RHS, 0, false);			\
-	})
-
-/* Description
- *	Assert that LHS is less than RHS. This statement updates the known
- *	bounds of LHS during verification. Note that RHS must be a constant
- *	value, and must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the specified value when the assertion fails.
- */
-#define bpf_assert_lt_with(LHS, RHS, value)				\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, <, RHS, value, false);		\
-	})
-
-/* Description
- *	Assert that LHS is greater than RHS. This statement updates the known
- *	bounds of LHS during verification. Note that RHS must be a constant
- *	value, and must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the value zero when the assertion fails.
- */
-#define bpf_assert_gt(LHS, RHS)						\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, >, RHS, 0, false);			\
-	})
-
-/* Description
- *	Assert that LHS is greater than RHS. This statement updates the known
- *	bounds of LHS during verification. Note that RHS must be a constant
- *	value, and must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the specified value when the assertion fails.
- */
-#define bpf_assert_gt_with(LHS, RHS, value)				\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, >, RHS, value, false);		\
-	})
-
-/* Description
- *	Assert that LHS is less than or equal to RHS. This statement updates the
- *	known bounds of LHS during verification. Note that RHS must be a
- *	constant value, and must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the value zero when the assertion fails.
- */
-#define bpf_assert_le(LHS, RHS)						\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, <=, RHS, 0, false);		\
-	})
-
-/* Description
- *	Assert that LHS is less than or equal to RHS. This statement updates the
- *	known bounds of LHS during verification. Note that RHS must be a
- *	constant value, and must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the specified value when the assertion fails.
- */
-#define bpf_assert_le_with(LHS, RHS, value)				\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, <=, RHS, value, false);		\
-	})
-
-/* Description
- *	Assert that LHS is greater than or equal to RHS. This statement updates
- *	the known bounds of LHS during verification. Note that RHS must be a
- *	constant value, and must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the value zero when the assertion fails.
- */
-#define bpf_assert_ge(LHS, RHS)						\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, >=, RHS, 0, false);		\
-	})
-
-/* Description
- *	Assert that LHS is greater than or equal to RHS. This statement updates
- *	the known bounds of LHS during verification. Note that RHS must be a
- *	constant value, and must fit within the data type of LHS.
- * Returns
- *	Void.
- * Throws
- *	An exception with the specified value when the assertion fails.
- */
-#define bpf_assert_ge_with(LHS, RHS, value)				\
-	({								\
-		barrier_var(LHS);					\
-		__bpf_assert_op(LHS, >=, RHS, value, false);		\
-	})
-
 /* Description
  *	Assert that LHS is in the range [BEG, END] (inclusive of both). This
  *	statement updates the known bounds of LHS during verification. Note
-- 
2.34.1


