Return-Path: <bpf+bounces-4904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC5275165C
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A85B1C21262
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A131100;
	Thu, 13 Jul 2023 02:33:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993BB7C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:33:13 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB88E7E
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:33:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so121061b3a.3
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215591; x=1691807591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNehhycek+drsWLR/IwH9p25Up1Tc/cl19ZXBMEPYRI=;
        b=qzNCNzaXo/6aN9p2F3JD2yveDfORqLKOAE+WF1hmPLipQno/Gn08plw8wpFB3Eeb0U
         W9qX2D5Ly7u6W3OJwMQedGUUN6Op1WdQ3UbTlt5XWyM8KBOid0Q5T5voMHnJCfn9O64U
         mxBUl2oXHSc+NL40mQ+oBQrqkp/vryalwVd/gZh2pN97wza3P1OXcySND8ICJs0VDFyG
         +YLwCd5l0cCBB98XwZV6gfVWdSZ1ONMlCtwcyOYjjlnlL8/YtU0lkFmeT+gV+exktNJ+
         uH+zeGwQG83eZJAqERPgfM7Aq2XrMFq40z3PxeRZALFtphicf6ld8V4qOb04SfqJ43Ym
         85RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215591; x=1691807591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNehhycek+drsWLR/IwH9p25Up1Tc/cl19ZXBMEPYRI=;
        b=MwjsQcak4pNMYZUQzcxAkAa/+uuoAsnPXamjXcEdHmW5gd1sUj+u37WXebp5XMDxtd
         0B6no3eL2A/5IouR3QogH9F7zXFM1u5HuEFjfrtupp4S1kaN3sMrJVblOkqU6mxhDUAX
         frPN0plll5Ec5/dRe1UX6MvmWgqglYpxKuLR74tBnRMumkJ8KDl6hgNgVnoZqHm+yRVV
         LXemEYW9ozdXURW0bvpGWhC1KkE+yfWPj9Fk0Ts5VAHuPNa0WIwAy7gqJxavgftrUowj
         QM/HK+fQXVLodNyw8YtCpXSWvfh1uLom5WpTKHvf+THR/5AXmSyNI1kULXYzRcL4eIBd
         hdhQ==
X-Gm-Message-State: ABy/qLbInqLQHCKqh7PZRcRxNwfEA+OQPpk/PLQQrC/v1/hku2lUtdPf
	WAgTKx+IGw2c4eX5MO5/L8MWDyTbMP/1Mg==
X-Google-Smtp-Source: APBJJlFjD+WEXf2uIJd+kJBsER18vx3ild4/cAbEC9orvyChVBEySASyL419iswzkIjMcvR9dYhKnw==
X-Received: by 2002:a05:6a20:8f15:b0:129:c38e:cdd7 with SMTP id b21-20020a056a208f1500b00129c38ecdd7mr84620pzk.38.1689215591575;
        Wed, 12 Jul 2023 19:33:11 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902ed4100b001b7fa81b145sm4611299plb.265.2023.07.12.19.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:33:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 09/10] selftests/bpf: Add BPF assertion macros
Date: Thu, 13 Jul 2023 08:02:31 +0530
Message-Id: <20230713023232.1411523-10-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2269; i=memxor@gmail.com; h=from:subject; bh=HDXy5CXUtzcMi3yW/JNz0jTfoZtVdLHrKtwGhdrzRL8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HJ+0S77AQ4AGXmOuCxQuzwtbtiON0ogOlsA k/grlrxe9CJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hyQAKCRBM4MiGSL8R ym6AEADAJbxK8fZvtEWIwiPsWpbeu7UXqlQju4Cq+ItV/h3udcqtZ7bcrbU5jkgi/rpAHHcajL0 exS2Zeq6ht0pXx5KDGe1079rKcv1OU9sgOR9TZC9ROXmO9F83GQfvwyLllak5T1oUBZNFBgCSdE 92ELfwGZcRI1WgWwowiqQhBz9td2moyVxU7+ojBY6CxrFwVNjCl0jifDsC3nMaw/12yoxB19rki D/tcc577uktYJasR+Ti66ZhPEFgYCR8gDEZK+4gy4VsE29IHrUi+JmWlsfeLT5xhQ1eEXFelfDH fyYcAhE2HJeJ5PvG6aVqt9HOB2I01NfETEPzzEpaovuS+Y0uetz7y5TPb2pNCFS/tqF4AyK+IMc OIUnRrFOXBt+a4/BfMQu1ahaGPicdDFW7T8se368pB6aM/rdeQD8Jh/bUXE0hPF3olAEvNQvC4q CvqwSHMFsHpHTsu/yHMA77hVabNAilkTkCwZP5vCuW1kA78xG/gvoPmrCH1B1UGFXBdjs6SIwQR cXEmYkfyuxU6Uf+a7Ija+zsI/sVtrYUABcDG3Rj6L7mhZdgwpOK7DYHCQy2vPiIP+SBAf4oXwPU 1uB3CAlJkePiMdMrYwlEk0/XGbAdqIyVlc8YLZASpzKTKcVY14h/4ab/bLG6K/+0IoWT5g7hRmy V1RqTQgMi52jmgA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add macros implementing an 'assert' statement primitive using macros,
built on top of the BPF exceptions support introduced in previous
patches.

The bpf_assert_*_value variants allow supplying a value which can the be
inspected within the exception handler to signify the assert statement
that led to the program being terminated abruptly.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d27e694392a7..30774fef455c 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -139,4 +139,24 @@ extern void bpf_throw(u64 cookie) __ksym;
 
 extern void bpf_set_exception_callback(int (*cb)(u64)) __ksym;
 
+#define __bpf_assert_op(LHS, op, RHS, VAL)							   \
+	_Static_assert(sizeof(&(LHS)), "1st argument must be an lvalue expression");		   \
+	_Static_assert(__builtin_constant_p((RHS)), "2nd argument must be a constant expression"); \
+	asm volatile ("if %[lhs] " op " %[rhs] goto +2; r1 = %[value]; call bpf_throw"		   \
+		      : : [lhs] "r"(LHS), [rhs] "i"(RHS), [value] "ri"(VAL) : )
+
+#define bpf_assert_eq(LHS, RHS) __bpf_assert_op(LHS, "==", RHS, 0)
+#define bpf_assert_ne(LHS, RHS) __bpf_assert_op(LHS, "!=", RHS, 0)
+#define bpf_assert_lt(LHS, RHS) __bpf_assert_op(LHS, "<", RHS, 0)
+#define bpf_assert_gt(LHS, RHS) __bpf_assert_op(LHS, ">", RHS, 0)
+#define bpf_assert_le(LHS, RHS) __bpf_assert_op(LHS, "<=", RHS, 0)
+#define bpf_assert_ge(LHS, RHS) __bpf_assert_op(LHS, ">=", RHS, 0)
+
+#define bpf_assert_eq_value(LHS, RHS, value) __bpf_assert_op(LHS, "==", RHS, value)
+#define bpf_assert_ne_value(LHS, RHS, value) __bpf_assert_op(LHS, "!=", RHS, value)
+#define bpf_assert_lt_value(LHS, RHS, value) __bpf_assert_op(LHS, "<", RHS, value)
+#define bpf_assert_gt_value(LHS, RHS, value) __bpf_assert_op(LHS, ">", RHS, value)
+#define bpf_assert_le_value(LHS, RHS, value) __bpf_assert_op(LHS, "<=", RHS, value)
+#define bpf_assert_ge_value(LHS, RHS, value) __bpf_assert_op(LHS, ">=", RHS, value)
+
 #endif
-- 
2.40.1


