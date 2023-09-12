Return-Path: <bpf+bounces-9840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C1879DCBA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2606628138C
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A71640C;
	Tue, 12 Sep 2023 23:32:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2F11CAD
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:31 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7AC10FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-9ad8add163cso137077266b.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561549; x=1695166349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOHf7UvNL/MfIQqx3fKPtHAMQ0tFRlyKasyS8VWjH/k=;
        b=Pv+PMv+0jbjieCMS5tji618ss2NcxZh2yeCSyhPy2vj8qrIRgPGyhmjU5+QvWPlikW
         YZ5ZcEjZ3lZExqF7bRi5UcDchwz2AlKk/s0EBB85ZsjcZCdCRtoqoFAFqzzgeZSeWZTJ
         j96dHyOYgAQ4guB/UIzF9GDBDVo5/L6GqVHyFSSIqBieGhMYp6PSfXB7l2ktGl1XH+E2
         qtmDje5gfXw1DOIc2F7gJTsB/yCVO+cfDfEHI0qECQDr/wrIqvtV5njkV1q1UQiPFG0u
         c9trJGhMO1dfY7jD/un85WZsJ/WbcGySJh3BthHmq9MVb/3JuHQhPJy/uuMIT2sQN6Kb
         rGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561549; x=1695166349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOHf7UvNL/MfIQqx3fKPtHAMQ0tFRlyKasyS8VWjH/k=;
        b=XKbBqJkZub7cWP1gA2cOFnshsOp1WnO5e8EuIL10+HmJd2WaEZAh0vdH+89uvVmSxo
         IiFEifoOSQNAqbwupOZV19kJkzaixyo09XbQfC70PXM2QKU4sn/c3SlY4XDdrq4wH/UG
         d+SPU47cmm+4JW+s5wNImWPj8+ZiRmi81HolutSveifmT1E3XDjx8UlD0wfr3RuBtl+p
         P94TKRQ3K+vOpoIj+UiIkL/UbE81iLXJs2Ru03toHwPYrfhH4i9cQm2hqzpL0EZPmBsj
         5l9fb+w4CETwsywr7XAJtGGSF7izmfSKbZ7j8RM5GzXp5M+ndTfnYW9wqv5pqXBJz+pv
         fMpQ==
X-Gm-Message-State: AOJu0YzRsRm5Ux2hSuVf2XYioovzVf8fdhT1KvRS23U0E3LOl7s8VucH
	SENEa8jBfJdHaFOjLEwM/2b9wsgBXLlirw==
X-Google-Smtp-Source: AGHT+IFcbvjsGa9p5uJR5y/awxg7WJUq4ImmxHRbHaAOEl5FEpUkT++TpP4xgLelkQk7QTzCLlbTsw==
X-Received: by 2002:a17:907:a053:b0:9a1:b144:30f0 with SMTP id gz19-20020a170907a05300b009a1b14430f0mr515211ejc.53.1694561549105;
        Tue, 12 Sep 2023 16:32:29 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id f20-20020a170906825400b0099bc2d1429csm7460524ejx.72.2023.09.12.16.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 16/17] selftests/bpf: Add BPF assertion macros
Date: Wed, 13 Sep 2023 01:32:13 +0200
Message-ID: <20230912233214.1518551-17-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9737; i=memxor@gmail.com; h=from:subject; bh=S7OPOB8h/TK+lGTRLmoipCDNro3S4BIBa8ptAz+GI+M=; b=kA0DAAgBTODIhki/EcoByyZiAGUA9K6g8tnxWLLEZdXXyhx4y82HncUEG3mRcdkwNht42FRDP YkCMwQAAQgAHRYhBEu+Kn4G7PnVgjxhEUzgyIZIvxHKBQJlAPSuAAoJEEzgyIZIvxHKEQ0P/jpS 61ILnbkoYWfsrb9gQmLoK/+TuKbjSEJ6tFo6MvPSZAVly/FuhDvOxv7zd4i95pwPZSlU9XH+xPl b+ZCFeB4G859PFHYN9tH/xXoR1/NMl1FRnrcXmeRz+oYYS/5EVAlsUCf/oIhZdxXe4YRI29H8l/ 12sQ7AdV5HRnS14KeFBw+TQ9rCOsXQizljsWW+ilDHEcsbuVdagedPI3lFFJ8ZjGgaearfWlfdc pQRlTeRReDTS79m0v+HGrOL0ttGxuwQcNyN4IkqasiMTojQVEUuhMOSv3a4zx4QlY7G7EkP4wDj iswaXPXF9Yx1tQux1bcFLQjWjPpBfVWTIs8Ke1yIF2VjFJZ3PwwQIihi9TRhqvQxn9R/Iaa6aUV oS5weCMYNYB7cOh0x9PJRuzhikZ22w0kbv07ioHsFjtfUW1z9VWIk3bYqHdNVWDwlQ//tO+5tSv XtK9qrVLC+enWqJLRZlKCe6TB2i3FFD7C1xlz30HA3KPc0XB/r/CnrLYPr7XRloti4CcxKCVmok xBVOrMShvH9JwzwYBQnmUr5WBqKegCh6kiv1hBwvW6YyfF7PZN8IEMRHeJ/2Y56sj/XPkGADqck /gdzNgo46u2jlc2K4nT2mnuYOpJ85tL898S2q+MfrHvV4n0ngjn+acKb5ID5+Rud5tdgv1L8Xzb TPSaD
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

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
 .../testing/selftests/bpf/bpf_experimental.h  | 243 ++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 9a87170524ce..9aa29564bd74 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -207,4 +207,247 @@ extern void bpf_throw(u64 cookie) __ksym;
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
+		(void)bpf_throw;								\
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


