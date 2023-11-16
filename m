Return-Path: <bpf+bounces-15144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841E7ED938
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5513E1C209B0
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98B045966;
	Thu, 16 Nov 2023 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfoU6YS/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4931A6
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:43 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so2970974a12.0
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101121; x=1700705921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQByzJ1IDqN4etV9mKIxv7+TzYzW+8KxKfCPACO1t5g=;
        b=TfoU6YS/6iSsijfwoIU2D9u3mtt+6l1FViJZToMPnbfD47nIDDLOW4ZVzahyNkmhTI
         dcL/+EOOnUMfuaNyXCk3fBJFVHgpx60Ah1CmEe0S1T8oJsGNTpOFAIofSMjwe/ffBp3U
         xFiPJqBhzG3Wpke04q2oMK4KUNJW2uTblEB94LqkeVtaLPN5RJBHqYSNFPGDg2pg01AD
         BQLV8yx3nQCUDfuBpX9ALTNseQ1BZ6eUZJYMXksfJQwJPPAyIb/pQ16HIzbaoEWvavyH
         2vn2tt5MGgRrjXsl3OE6I/WY4uMFp/+GuqqAkKk5ykxsYMhv7ULpxO8TJzoWu70tW0TX
         aQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101121; x=1700705921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQByzJ1IDqN4etV9mKIxv7+TzYzW+8KxKfCPACO1t5g=;
        b=eIIkGUgjcOh1T0GDltm8P72xnz53TG7kKpXJTW1EafLVvzQnjH9gSxYkdmYsHLP69i
         qSFI+SdQmMEfTVntZt4qFSf//PTyNYwDUbSmvBamGTi196GrQB2edLYqOp/SP2lVPRM0
         c6MUxDLJ8c/Rqor8L/Il3E0FrMH5po8mazMTfB6hgVwjuNNcTGqP6MhM66OrSfIpN+F9
         59JUE/0TlQioL9H8E6u0UJB/0QIQr1QOK+STXtqpFTpoCHt2jGiqIhwevCrZyNp6LGMu
         V6kNQzG4Ju9g0OpAHk5P0Kxar8aAVnfHDK5UrLMpEJnNUlQerEgSvq7c29NAVUeMTw5A
         tLSQ==
X-Gm-Message-State: AOJu0Ywnk+y+xHT+BwXaIHZ4RPTcb0Zoj0Hj3NU6b4enBSLh4m1gh+tu
	K/TkCJOLJEvRcJ0rtgaMUpwjCyNFzv1B9Q==
X-Google-Smtp-Source: AGHT+IH78XpiOWEXPJEnj4nnmYhofDdBzGa4eEZ58TkVeeEQdRYMKE/bkvKEjbdig6phNd92eav97g==
X-Received: by 2002:a17:906:e0d:b0:9b2:b755:5b94 with SMTP id l13-20020a1709060e0d00b009b2b7555b94mr254521eji.38.1700101121496;
        Wed, 15 Nov 2023 18:18:41 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:41 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 09/12] selftests/bpf: test widening for iterating callbacks
Date: Thu, 16 Nov 2023 04:18:00 +0200
Message-ID: <20231116021803.9982-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test case to verify that imprecise scalars widening is applied to
callback bodies on repetative iteration.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index fa9429f77a81..598c1e984b26 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -25,6 +25,7 @@ struct buf_context {
 
 struct num_context {
 	__u64 i;
+	__u64 j;
 };
 
 __u8 choice_arr[2] = { 0, 1 };
@@ -69,6 +70,25 @@ int unsafe_on_zero_iter(void *unused)
 	return choice_arr[loop_ctx.i];
 }
 
+static int widening_cb(__u32 idx, struct num_context *ctx)
+{
+	++ctx->i;
+	return 0;
+}
+
+SEC("?raw_tp")
+__success
+int widening(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0, .j = 1 };
+
+	bpf_loop(100, widening_cb, &loop_ctx, 0);
+	/* loop_ctx.j is not changed during callback iteration,
+	 * verifier should not apply widening to it.
+	 */
+	return choice_arr[loop_ctx.j];
+}
+
 static int loop_detection_cb(__u32 idx, struct num_context *ctx)
 {
 	for (;;) {}
-- 
2.42.0


