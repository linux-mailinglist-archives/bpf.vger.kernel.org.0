Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB01663ADE2
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiK1QfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 11:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiK1QfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 11:35:08 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D820F64
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 08:35:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vv4so27282621ejc.2
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPDyoJ9xhlYxM9/Z0G/mChvXBKKhvySIujD90Cc9Obo=;
        b=avsttkrY5Akc5WBmOjzIsKthIbWuIEWmlZu5TovQKjWEKBAm47ufwe3eiRl4Zaiu+m
         m7EeN80QS7L3zwm/jfoWtMbvdf5DqFtb39sz4tFYVIeqlUxAt0ofltJ6DavR5MuQs+FV
         Y6DXONm/LZVAa/TWTg1isARRARh6VVx7sVTXxtGloMLg9XBysw0d728BxT/FrxLmfDfc
         uYFT9Z18+X3JaZdDNszol4RMofLqC65i3QBbdaNasxsAYnmSdl9AvZtUGS/k8suISiMW
         fjyLxCyAkGGej1whbB7xPhVE7/75CjgwdUM46fuSYt5D4W50sMr9Mj/Uy777oDPnNyzU
         iBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPDyoJ9xhlYxM9/Z0G/mChvXBKKhvySIujD90Cc9Obo=;
        b=jqJipzs19hCZg0ybpeV4hR029oeDXAw+ZBYxcHfC9bYY3sjbiUf4fybJ00Z5l7mLH3
         HxMctm42To5Sih+BTP25Cz7Bz1QBNDtPkJmaU+x86nH/nayqCyi+jVDRVOaizKF9a/TD
         dnRFuTh4lbagL7ZleBrjNzoOATBr6WMTuG1bl6hGMcEoDzeLqfG+bKDQ/ZYqcwTaJV3E
         //2EErVyz4imFAToIbZ11nJpXrTlPSOyw2tEi2W9neJ2fj94OgLl0Gfh0biqY5Ep8qQd
         sr5qiyMHO2ucMH6K6MXsJq4huEHQ/7quhK5WR0aKqAeW7/EAVAhCZ/iPSoR2PLKYYjhY
         Mqvw==
X-Gm-Message-State: ANoB5pk8zQMb9YYP1+tRZfz7yypikXzD34HVlyEbNfil74/ezapkJV0Y
        iqQesFmXaqQ8Aekrv+VI9fyEOuSyOQ0=
X-Google-Smtp-Source: AA0mqf75D16ySSV1hFYgRAYoTz0XaI4i0LbGgMaYG272ydufCiWx2WdC1mOGRYRN7GzBXGoJIUHbpQ==
X-Received: by 2002:a17:906:168e:b0:7c0:78c8:1487 with SMTP id s14-20020a170906168e00b007c078c81487mr3444202ejd.340.1669653305791;
        Mon, 28 Nov 2022 08:35:05 -0800 (PST)
Received: from pluto.. (178-133-113-180.mobile.vf-ua.net. [178.133.113.180])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b007417041fb2bsm5145605ejc.116.2022.11.28.08.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:35:05 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 2/2] selftests/bpf: verify that check_ids() is used for scalars in regsafe()
Date:   Mon, 28 Nov 2022 18:34:42 +0200
Message-Id: <20221128163442.280187-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128163442.280187-1-eddyz87@gmail.com>
References: <20221128163442.280187-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verify that the following example is rejected by verifier:

r9 = ... some pointer with range X ...
r6 = ... unbound scalar ID=a ...
r7 = ... unbound scalar ID=b ...
if (r6 > r7) goto +1
r6 = r7
if (r6 > X) goto exit
r9 += r7
*(u64 *)r9 = Y

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/verifier/scalar_ids.c       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/scalar_ids.c

diff --git a/tools/testing/selftests/bpf/verifier/scalar_ids.c b/tools/testing/selftests/bpf/verifier/scalar_ids.c
new file mode 100644
index 000000000000..38a6959c93e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/scalar_ids.c
@@ -0,0 +1,61 @@
+/* Test cases for verifier.c:find_equal_scalars() and Co */
+
+/* Use a map lookup as a way to get a pointer to some valid memory
+ * location with size known to verifier.
+ */
+#define MAKE_POINTER_TO_48_BYTES(reg)			\
+	BPF_MOV64_IMM(BPF_REG_0, 0),			\
+	BPF_LD_MAP_FD(BPF_REG_1, 0),			\
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),		\
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),		\
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),		\
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),	\
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),		\
+	BPF_EXIT_INSN(),				\
+	BPF_MOV64_REG((reg), BPF_REG_0)
+
+/* See comment in verifier.c:mark_equal_scalars_as_read().
+ *
+ * r9 = ... some pointer with range X ...
+ * r6 = ... unbound scalar ID=a ...
+ * r7 = ... unbound scalar ID=b ...
+ * if (r6 > r7) goto +1
+ * r6 = r7
+ * if (r6 > X) goto exit
+ * r9 += r7
+ * *(u64 *)r9 = Y
+ */
+{
+	"scalar ids: ID mapping in regsafe()",
+	.insns = {
+	MAKE_POINTER_TO_48_BYTES(BPF_REG_9),
+	/* r7 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r6 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* if r6 > r7 goto +1 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+	/* r6 = r7 */
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
+	/* a noop to get to add new parent state */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_0),
+	/* if r6 >= 10 exit(0) */
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_6, 10, 2),
+	/* r9[r7] = 42 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_9, BPF_REG_7),
+	BPF_ST_MEM(BPF_DW, BPF_REG_9, 0, 42),
+	/* exit(0) */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_48b = { 1 },
+	.flags = BPF_F_TEST_STATE_FREQ,
+	.errstr_unpriv = "register with unbounded min value",
+	.result_unpriv = REJECT,
+	.errstr = "register with unbounded min value",
+	.result = REJECT,
+},
+
+#undef MAKE_POINTER_TO_48_BYTES
-- 
2.34.1

