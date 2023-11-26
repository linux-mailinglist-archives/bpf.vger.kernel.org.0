Return-Path: <bpf+bounces-15862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF90F7F90B1
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 02:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE672813AB
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 01:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC11C1375;
	Sun, 26 Nov 2023 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnHhYLSE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B614E110
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 17:53:28 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67a295e40baso3793196d6.1
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 17:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700963607; x=1701568407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI+oR2NZvrQ1Hdif94QsAEG+mGJnjt6kUj6zcM9W8Jc=;
        b=bnHhYLSED87+g6hEhMuhdjyAjdYx1q+qC7ZxsKaycy7eodTSxycuq2+x+EQdS9tnbe
         2FPHXRPAgZeTKWgtali4zUAo2jEYBbpi0/xbyKkQZu+kdH0RXpbkXdZBRCcfJABYOWrY
         vbdui9fr8SJCU/O0QXKui0NHz3KKvjOq9bz0jn1AS69gpdOsS1atPWtwGq3ex2cEJCsX
         AT6cDhwfrx355BtiYsYP9ts07kp7iArCj0D+DjjPl7iCQEII38GNmD/gMBDOTK2sphiW
         mVo4A7/hJ++uVdc61M57iNJOybJToz0jwVbxUYW+p2JoB8n0d6rVsGANw0XEm3wtBb9h
         X38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700963607; x=1701568407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yI+oR2NZvrQ1Hdif94QsAEG+mGJnjt6kUj6zcM9W8Jc=;
        b=t8oaSXQbM5b3q0uM0FL29Lf4A4My5Ct/6pDY7MwHJQEOMq7Dobz0/mYZtOqs7Fhss1
         qX1I1ueOzSUCw7i/TdWzuAfYtfkX6dhljShwXR3nZXe4XbaGuM362T6Q9A415HAfzbez
         vLFgCb+k4Spw04cy0DrTaQlLZ48YdhZ3Ce+FCRUz9aySJkb6hDQGAsmhSoBVbM8jsEJv
         LHlTFUjTG0nih3NHvLVSBCixZGaT53m3a/rSjD6PTbilgjAfh+9ljfUjrPr27vR2bcU5
         0Hhbpi4Upx69RYO4SJHDSMBxgRlOm6Z3RU7Mw9moM5zUOCD6UzNATwpXSNfv+KC8IBPA
         i/UQ==
X-Gm-Message-State: AOJu0YyGNz1+LgLMYxBQ1DXWMrfZrqe4aMMggPipg2blq38Op0skIU6w
	5UwCP/2gUrE9dp4q4Gqsg46ko9fMziQ=
X-Google-Smtp-Source: AGHT+IGoeEiuO9udC9z7IYXNsoQCZGNvCR0i8SsWWf09y3pyeyhOu9lYOnJedBkICtncBEITPhQb5g==
X-Received: by 2002:ad4:5147:0:b0:67a:3ab2:12b4 with SMTP id g7-20020ad45147000000b0067a3ab212b4mr499100qvq.50.1700963607099;
        Sat, 25 Nov 2023 17:53:27 -0800 (PST)
Received: from andrei-framework.. (c-73-133-17-174.hsd1.md.comcast.net. [73.133.17.174])
        by smtp.gmail.com with ESMTPSA id k11-20020a0cb24b000000b0066cfbe4e0f4sm1245501qve.26.2023.11.25.17.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 17:53:26 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com,
	eddyz87@gmail.com,
	kernel-team@dataexmachina.dev,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v2 2/2] bpf: new verifier tests for stack access
Date: Sat, 25 Nov 2023 20:50:46 -0500
Message-Id: <20231126015045.1092826-3-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126015045.1092826-1-andreimatei1@gmail.com>
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds tests for the previous patch, checking the tracking of
the maximum stack size and checking that accesses to uninit stack memory
are allowed.

They are a separate patch for review purposes; whoever merges them can
consider squashing.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c  | 24 ++++++++++++
 tools/testing/selftests/bpf/verifier/stack.c | 40 ++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/stack.c

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 98107e0452d3..a62610585ee4 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -135,6 +135,10 @@ struct bpf_test {
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t insn_processed;
+	/* Expected maximum stack depth for the main subprogram. Not checked if 0.
+	 * Only checked if the program is accepted.
+	 */
+	uint16_t max_stack_depth;
 	int prog_len;
 	enum {
 		UNDEF,
@@ -1703,6 +1707,26 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		}
 	}
 
+	/* Check the stack size if the test configured an expecation and the program
+	 * was loaded successfully.
+	 */
+	if (test->max_stack_depth && fd_prog >= 0) {
+		uint32_t max_stack;
+		char *s;
+
+		s = strstr(bpf_vlog, "stack depth ");
+		if (s == NULL) {
+			printf("FAIL\nstack depth result not found in verifier output\n");
+			goto fail_log;
+		}
+		max_stack = atoi(s + 12);
+		if (test->max_stack_depth != max_stack) {
+			printf("FAIL\nUnexpected max stack %u vs %u\n",
+			       max_stack, test->max_stack_depth);
+			goto fail_log;
+		}
+	}
+
 	if (verbose)
 		printf(", verifier log:\n%s", bpf_vlog);
 
diff --git a/tools/testing/selftests/bpf/verifier/stack.c b/tools/testing/selftests/bpf/verifier/stack.c
new file mode 100644
index 000000000000..ac571783c05e
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/stack.c
@@ -0,0 +1,40 @@
+{
+	/* Check that reading unitialized stack memory is allowed only in privileged
+	 * mode. Also check that such reads maintain the max stack depth.
+	 */
+	"read uninit stack",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -504),
+		/* exit(0); */
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid read from stack",
+    .max_stack_depth = 504,
+},
+{
+    /* Check that indirect accesses to stack maintain the max stack depth. */
+	"read (indirect) uninit stack",
+	.insns = {
+		/* We'll use probe_read_user as an arbitrary helper that can access the
+		 * stack. We're going to read into *(fp-104).
+		 */
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -104),
+		BPF_MOV32_IMM(BPF_REG_2, 8),
+        /* read from a random address */
+		BPF_MOV32_IMM(BPF_REG_3, 0x4242),
+        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_user),
+        BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	    BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "",
+    .max_stack_depth = 104,
+},
\ No newline at end of file
-- 
2.40.1


