Return-Path: <bpf+bounces-18479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67C81AD98
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73F92859E6
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 03:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7C4A2C;
	Thu, 21 Dec 2023 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbgbCDgp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94337524E
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d775f9af42so346584b3a.3
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703129953; x=1703734753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVZHg/f2iG8R+owdV11FE5XbWdBtSj3G6bBWcFfdXvA=;
        b=KbgbCDgpem4qUnC8INYoqBeIxTrffGgfhma1QHybevHEEO3h7erQxVqFq+bP3Nj0q5
         Ofvx1otPil/uqNUEer0e0e68OK+Nh70WN+NH5/R9wWXiJdiAd6WErnr27fTnh1B5ovqQ
         SyRtTpYs+BofbDpMTreFn23ezoWBUwnNkT0WWG8T6brc7Hxkw59OGWBHRbEQptD+TX/P
         +TUrYfYa31J3MBp6Z0ltEPWFpNs6zlnAA98ZINCnLBYa5aOG7JG5pXVLwFgOsADFyBTv
         DCBt1cLwX25sZd8Yh5CLqfNKWA4OEbL/COq665J6BL3+JqL0Xk0hR7rAFm2YIuMdnR+g
         56qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129953; x=1703734753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVZHg/f2iG8R+owdV11FE5XbWdBtSj3G6bBWcFfdXvA=;
        b=FM+YHMv5rgGqvBQvw/5oDxxgDOfyZrbnZ/ul3b3ui+r8WM4Io5mnkURpKD7iMWnV9m
         S03ydSexCd0ffdLGjBTS/GQeCOACB1YfdZ+bC8pqY8DTk17/79vFKoLqEvBubHSLhECD
         /7Y3/nwhVYTvnCcwEB0juykuh4y5lX8PYEty2r6h2IS8ZKKbW+t0Z3GqIuSFP6pNNRNN
         xzIQKA6lS3Id90sZWWdSKKM2KPlNCmAX6+BgvX8QEwlg496Vu9rU8zu8ha2lVrBkq+IA
         D1T2JRpr8uZFtWcpEnadsE49vPE3WQ3NvDdxP1xa/bc4sBP+s10r0kgN6v89hqCBZ9WS
         FPMA==
X-Gm-Message-State: AOJu0YzrHNUavUMYoJZc7P0+IU0q6wKlp8dkw0z72gBKRf05miGppaqF
	ltyzwOpPJWS4KkybOu09Fgs=
X-Google-Smtp-Source: AGHT+IHCKK/xcdJP8jPRRyNudGM7hisVjYxmHcUQTo/9rrs5cXFKHSXimuvm3p4YqJefVKZctrUPQw==
X-Received: by 2002:a05:6a00:4b0e:b0:6be:25c5:4f74 with SMTP id kq14-20020a056a004b0e00b006be25c54f74mr25876969pfb.13.1703129952673;
        Wed, 20 Dec 2023 19:39:12 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:ec38])
        by smtp.gmail.com with ESMTPSA id l4-20020a632504000000b005cd85b3d097sm519894pgl.12.2023.12.20.19.39.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 19:39:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net
Cc: andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Remove bpf_assert_eq-like macros.
Date: Wed, 20 Dec 2023 19:38:53 -0800
Message-Id: <20231221033854.38397-5-alexei.starovoitov@gmail.com>
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

Since the last user was converted to bpf_cmp, remove bpf_assert_eq/ne/... macros.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 150 ------------------
 1 file changed, 150 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index b78a9449793d..0f94c266c35b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -316,156 +316,6 @@ l_true:\
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


