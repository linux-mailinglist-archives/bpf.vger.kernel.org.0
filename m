Return-Path: <bpf+bounces-7346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08115775E0E
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F23281B06
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9F18001;
	Wed,  9 Aug 2023 11:44:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF117744
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:44:19 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02AE9B
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:44:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-99bcfe28909so922632166b.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581456; x=1692186256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoQfVAUwXkJ1W9+4QVXdiQlLVeOCQMqFcmTK991KBtI=;
        b=jsEjWzohm9+TLr/o4BjYuZ0JrtceBMXiK2So5OHdwyoV6x8t/UjNrmsr6fBTERbooH
         E6RPKzZPkvw6hqgbTy7IyuZFiNR5EnICFLn6whCqBFTDmx6kdR1dAGKzH/X3CzVI7yts
         mGQq0ji9j9/X8aRG69++1AZYX4vmP9dH3Ai60Cx+dSPeJgZBmOezZXQTnVTF+lqrDRcE
         FfA5GziTZU+dol50fm/WMtETi/RXPZ8EF55UmaHRCK/zgjXfxs9QG2WrYP3gbcKO9/9d
         ksU4jgkiMjjh6cnT0Oe+x+mtDGW4vJKMDLe2FlTa21MXekffb6CmSzGj/rcvUq8RFjr5
         MUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581456; x=1692186256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoQfVAUwXkJ1W9+4QVXdiQlLVeOCQMqFcmTK991KBtI=;
        b=H0HaJcp7uOy0azLOHAsfEacyP/Qh++PfiFFJcemJt7g1vXzo+G69Fg2XEB3A6eMJwO
         MbmG2FOqePR06bUfBw39mixZAJXisU45fzcraDvX1Yvrlmr7cZ64i9kSyOQYkW5czIbm
         +IwSGMP/SXiqaotzIJOuadng9a5K4RCjsfLKC2h8/4m4UH4Oo1PQqxoMx+2DVzoqtS2m
         hJK+O4Y5LukkPa5Pgd24BskCIZF9wWJVBylACOQu6fIupoA9lvGnUV0RdqKJQD7YALMp
         sh3TgutwEa28ZkQJbFg41ZwUmG9h0+tjSsyqLUkTqc1EY5GzD13wj+iTC6obaJCuBxi6
         E/6w==
X-Gm-Message-State: AOJu0Yz0VNIu0VnWuZE2l98jCHKHB/NFxN55zAEj5T8UUshtZfwoT46W
	1/jjUFeSf76rsbIMSbC8mW9TnPIdZ2rR0K9ytlo=
X-Google-Smtp-Source: AGHT+IHZC+tpNd9kw7LREoXTSQ/onAlB6FLhAmLw/De+F0wqFsdQefYIN6P0Edn8+bTHc3V93Nt0lA==
X-Received: by 2002:a17:906:3019:b0:982:45ca:ac06 with SMTP id 25-20020a170906301900b0098245caac06mr1872561ejz.60.1691581455676;
        Wed, 09 Aug 2023 04:44:15 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090668c900b009828e26e519sm7822081ejr.122.2023.08.09.04.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:44:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 13/14] selftests/bpf: Add BPF assertion macros
Date: Wed,  9 Aug 2023 17:11:15 +0530
Message-ID: <20230809114116.3216687-14-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9707; i=memxor@gmail.com; h=from:subject; bh=QURVWXu/ZaKDcpy8ugNyPXoVE8I3kd5SyHBr6uVxLrA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rJHHIs3FJbaMOf+V/nXrMj1S1M5302ICJVm mV1+J6FdrCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yQAKCRBM4MiGSL8R yjrsD/4p/fUtEZAOaey+xvl/lMx07dSc/mxq156gc3rNUDY6ZJa39rqhRJDC7zZuePGXxulhqZc RV54o1/o3CGgqNJ9Si/qsUO4wctDkHkGSZ/kVWZ2XW4GNA6TDRlfnDI4pJWdIllS2E2EZ4boTo7 hddY2NHNNkJrMq9xHSoyJ55LYgvSITTXCGcOGp6pmgGzjOf4Mmzfgj4J9lj8sBFoHr/1BhZCbHE 7lRm68yEcnMB9WDc6V7zqk1QRukMPXci/wEuYu0gawnhM3ZlJXv7TIz4Wh9wPfO7eHQEgHyvDfp P4jN7p6SHoQmuy3bu+H9HbPKZAFLw+oiiVK7pBRBaqXHmE/JhMBL9opX16bCBnEM+HWC4XHg7VV svuCrOdgtnHlY17NOH9zR5AP5mAk1zmqJZ4qMwruKy05OiiAdTeEoKoeX0S4CjuFaU4hPgwdy2M yaJNXaK5NLq7alZWayGAf3B31Gh6ryuzFU8CZfnC51FvNz2Zx7qOlXG3cgojY+91GXnR/f+rrj2 qKNvJNC1n2hHNm8nUNhvdQ71i1zqgj1x9COSBHPqNNbN09zcRRhegYVBxsheDzWOuVq0d9y/EV+ MTcvl3lPzARlgk8XblRyVSIKvbmhU9L3HXEYyldT9GU4STnxjCiAzUnumoYYI81SVWbdZwnVwtd DUL01zh39HcZRvQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add macros implementing an 'assert' statement primitive using macros,
built on top of the BPF exceptions support introduced in previous
patches.

The bpf_assert_*_with variants allow supplying a value which can the be
inspected within the exception handler to signify the assert statement
that led to the program being terminated abruptly, or be returned by the
default exception handler.

Note that only 64-bit scalar values are supported with these assertion
macros, as during testing I found other cases quite unreliable in
presence of compiler shifts/manipulations extracting the value of the
right width from registers scrubbing the verifier's bounds information
and knowledge about the value in the register.

Thus, it is easier to reliably support this feature with only the full
register width, and support both signed and unsigned variants.

The bpf_assert_range is interesting in particular, which clamps the
value in the [begin, end] (both inclusive) range within verifier state,
and emits a check for the same at runtime.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 612ac86873af..faa0e785a331 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -176,4 +176,246 @@ extern void bpf_throw(u64 cookie) __ksym;
  */
 #define __exception_cb(name) __attribute__((btf_decl_tag("exception_callback:" #name)))
 
+#define __bpf_assert_signed(x) _Generic((x), \
+    unsigned long: 0,       \
+    unsigned long long: 0,  \
+    signed long: 1,         \
+    signed long long: 1     \
+)
+
+#define __bpf_assert_check(LHS, op, RHS)								 \
+	_Static_assert(sizeof(&(LHS)), "1st argument must be an lvalue expression");			 \
+	_Static_assert(sizeof(LHS) == 8, "Only 8-byte integers are supported\n");			 \
+	_Static_assert(__builtin_constant_p(__bpf_assert_signed(LHS)), "internal static assert");	 \
+	_Static_assert(__builtin_constant_p((RHS)), "2nd argument must be a constant expression")
+
+#define __bpf_assert(LHS, op, cons, RHS, VAL)							\
+	({											\
+		asm volatile ("if %[lhs] " op " %[rhs] goto +2; r1 = %[value]; call bpf_throw"	\
+			       : : [lhs] "r"(LHS), [rhs] cons(RHS), [value] "ri"(VAL) : );	\
+	})
+
+#define __bpf_assert_op_sign(LHS, op, cons, RHS, VAL, supp_sign)			\
+	({										\
+		__bpf_assert_check(LHS, op, RHS);					\
+		if (__bpf_assert_signed(LHS) && !(supp_sign))				\
+			__bpf_assert(LHS, "s" #op, cons, RHS, VAL);			\
+		else									\
+			__bpf_assert(LHS, #op, cons, RHS, VAL);				\
+	 })
+
+#define __bpf_assert_op(LHS, op, RHS, VAL, supp_sign)					\
+	({										\
+		if (sizeof(typeof(RHS)) == 8) {						\
+			const typeof(RHS) rhs_var = (RHS);				\
+			__bpf_assert_op_sign(LHS, op, "r", rhs_var, VAL, supp_sign);	\
+		} else {								\
+			__bpf_assert_op_sign(LHS, op, "i", RHS, VAL, supp_sign);	\
+		}									\
+	 })
+
+/* Description
+ *	Assert that a conditional expression is true.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the value zero when the assertion fails.
+ */
+#define bpf_assert(cond) if (!(cond)) bpf_throw(0);
+
+/* Description
+ *	Assert that a conditional expression is true.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the specified value when the assertion fails.
+ */
+#define bpf_assert_with(cond, value) if (!(cond)) bpf_throw(value);
+
+/* Description
+ *	Assert that LHS is equal to RHS. This statement updates the known value
+ *	of LHS during verification. Note that RHS must be a constant value, and
+ *	must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the value zero when the assertion fails.
+ */
+#define bpf_assert_eq(LHS, RHS)						\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, ==, RHS, 0, true);			\
+	})
+
+/* Description
+ *	Assert that LHS is equal to RHS. This statement updates the known value
+ *	of LHS during verification. Note that RHS must be a constant value, and
+ *	must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the specified value when the assertion fails.
+ */
+#define bpf_assert_eq_with(LHS, RHS, value)				\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, ==, RHS, value, true);		\
+	})
+
+/* Description
+ *	Assert that LHS is less than RHS. This statement updates the known
+ *	bounds of LHS during verification. Note that RHS must be a constant
+ *	value, and must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the value zero when the assertion fails.
+ */
+#define bpf_assert_lt(LHS, RHS)						\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, <, RHS, 0, false);			\
+	})
+
+/* Description
+ *	Assert that LHS is less than RHS. This statement updates the known
+ *	bounds of LHS during verification. Note that RHS must be a constant
+ *	value, and must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the specified value when the assertion fails.
+ */
+#define bpf_assert_lt_with(LHS, RHS, value)				\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, <, RHS, value, false);		\
+	})
+
+/* Description
+ *	Assert that LHS is greater than RHS. This statement updates the known
+ *	bounds of LHS during verification. Note that RHS must be a constant
+ *	value, and must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the value zero when the assertion fails.
+ */
+#define bpf_assert_gt(LHS, RHS)						\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, >, RHS, 0, false);			\
+	})
+
+/* Description
+ *	Assert that LHS is greater than RHS. This statement updates the known
+ *	bounds of LHS during verification. Note that RHS must be a constant
+ *	value, and must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the specified value when the assertion fails.
+ */
+#define bpf_assert_gt_with(LHS, RHS, value)				\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, >, RHS, value, false);		\
+	})
+
+/* Description
+ *	Assert that LHS is less than or equal to RHS. This statement updates the
+ *	known bounds of LHS during verification. Note that RHS must be a
+ *	constant value, and must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the value zero when the assertion fails.
+ */
+#define bpf_assert_le(LHS, RHS)						\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, <=, RHS, 0, false);		\
+	})
+
+/* Description
+ *	Assert that LHS is less than or equal to RHS. This statement updates the
+ *	known bounds of LHS during verification. Note that RHS must be a
+ *	constant value, and must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the specified value when the assertion fails.
+ */
+#define bpf_assert_le_with(LHS, RHS, value)				\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, <=, RHS, value, false);		\
+	})
+
+/* Description
+ *	Assert that LHS is greater than or equal to RHS. This statement updates
+ *	the known bounds of LHS during verification. Note that RHS must be a
+ *	constant value, and must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the value zero when the assertion fails.
+ */
+#define bpf_assert_ge(LHS, RHS)						\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, >=, RHS, 0, false);		\
+	})
+
+/* Description
+ *	Assert that LHS is greater than or equal to RHS. This statement updates
+ *	the known bounds of LHS during verification. Note that RHS must be a
+ *	constant value, and must fit within the data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the specified value when the assertion fails.
+ */
+#define bpf_assert_ge_with(LHS, RHS, value)				\
+	({								\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, >=, RHS, value, false);		\
+	})
+
+/* Description
+ *	Assert that LHS is in the range [BEG, END] (inclusive of both). This
+ *	statement updates the known bounds of LHS during verification. Note
+ *	that both BEG and END must be constant values, and must fit within the
+ *	data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the value zero when the assertion fails.
+ */
+#define bpf_assert_range(LHS, BEG, END)					\
+	({								\
+		_Static_assert(BEG <= END, "BEG must be <= END");	\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, >=, BEG, 0, false);		\
+		__bpf_assert_op(LHS, <=, END, 0, false);		\
+	})
+
+/* Description
+ *	Assert that LHS is in the range [BEG, END] (inclusive of both). This
+ *	statement updates the known bounds of LHS during verification. Note
+ *	that both BEG and END must be constant values, and must fit within the
+ *	data type of LHS.
+ * Returns
+ *	Void.
+ * Throws
+ *	An exception with the specified value when the assertion fails.
+ */
+#define bpf_assert_range_with(LHS, BEG, END, value)			\
+	({								\
+		_Static_assert(BEG <= END, "BEG must be <= END");	\
+		barrier_var(LHS);					\
+		__bpf_assert_op(LHS, >=, BEG, value, false);		\
+		__bpf_assert_op(LHS, <=, END, value, false);		\
+	})
+
 #endif
-- 
2.41.0


