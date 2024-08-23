Return-Path: <bpf+bounces-37925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7749A95C764
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE60C1F25A19
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F614264C;
	Fri, 23 Aug 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBn0LEu4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6AD140E23
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400425; cv=none; b=qY8NpUQNhzqLzuvu4oymghhqH3kQfLxc/QN1q+IvPj4EER6eiUNVoFkhD5AQuJeJFXIkjyX2/iVSp/unD7SASu+ff2x4+t3r0mwyOWN/myiSzDSMRACGkgOBbweI5f5I0ilnPZjwpikjlGm0fS/e9ymFWoQy7eP5MnqUWmo079U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400425; c=relaxed/simple;
	bh=kVDT7KuyrVApObgO6Oyh1m4xSCeQcbIL0Y0yzfjKntc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTnQL7Ac5+Nro/z8qL1hzSoYigX5zQtjQ9iHbILf91Aqqb04eoIKxyU0sZzl835TgMrBh1zHsKheZgq3iuiERQhTJIv9R5FJRNxRLMXMK+UZZPW6nGfIL6MQtVgzygtzhEMrkBoTsKph1fAiH78JxcESG8yuDcTK6uK0nsAHhws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBn0LEu4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2021c08b95cso21764825ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724400422; x=1725005222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z2LLbIpDy50MRImJ98Lp+Br9vG4OoOapBprDnt+jCE=;
        b=dBn0LEu4dyIZcHdgoQNGChcEIwe4bXV0NwRKdX34XZh5f4ghakdPBFZrTdt+LqsvU5
         cjSnRFzYAD04leFmM+PhW1fkxLQ9IAZdrx2q2TlZ57+PZQ2Glojouz74B80jl05ykqoO
         neplYUWUhjjrkHLGX4kAZbnnWkYMYnDjqOGA9bW9o+H+YQ65FiW6+5PrVWN429kGODb4
         n+/TI9CQthXn7npIt6py/cOaApIDIG+MZamJgsk5ZusRQyEr18knOvW+4ugub/r3K1JY
         3P1APuGOo7ngKkFZXa12EMmAnAE/eCJVJZw5pwNEEDIj/CA17Vg+X7AnDh1BiioklQDJ
         hf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400422; x=1725005222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6z2LLbIpDy50MRImJ98Lp+Br9vG4OoOapBprDnt+jCE=;
        b=dI5Oi+8CuKpO649OBIb7zLxRbZwykazxQBVRBUvqOWvJyd8i8QYdwuSUnEQcKHxVD5
         QTXHJGLJch5EELGCV4EFqG6hg0JpnrzY9Sf5uS84JjsyEsartsHGvpQdp4HDe2yiPNH7
         XjdflEyhvJIg2gV105x6TeNsKbp6dNd5jTaeDkYm0ZPXM+U6VaURSKfIq68dyWRpwZfi
         PV38d2Ntl0g8zVZrTN99KxL2VHY3u1z0/0keuO4mxngf21YA2xFg0JPUoMKz+PAwwaZg
         FyfkfJULnZdLtDkiogUvoHjf7MO+s6ZgD3jtnagry6ibe/xbIr8pFU1AUsI5K60/mXbi
         SfVw==
X-Gm-Message-State: AOJu0Yy0U4HrSI7gxO9npqo20qZHvaNtbVJpACQIZU3C1tlQWHj0uIit
	BcFPTIaVijHYZyNqjp4nAqDNE6MKl97FcrKcM6K8TWoUlVUnCjzWn+CBZg==
X-Google-Smtp-Source: AGHT+IEKFM7Gb5VoWUyGPdRxBNDc+26SjZCCUlwvvgMdNxLkjdRNnFXkQjX0LS6Eqs8LbmGTa2tbBQ==
X-Received: by 2002:a17:902:dacd:b0:1fc:41c0:7a82 with SMTP id d9443c01a7336-2039bb3f532mr33728965ad.0.1724400422477;
        Fri, 23 Aug 2024 01:07:02 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567f74sm23463925ad.60.2024.08.23.01.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:07:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: #define LOCAL_LABEL_LEN for jit_disasm_helpers.c
Date: Fri, 23 Aug 2024 01:06:44 -0700
Message-ID: <20240823080644.263943-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823080644.263943-1-eddyz87@gmail.com>
References: <20240823080644.263943-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract local label length as a #define directive and
elaborate why 'i % MAX_LOCAL_LABELS' expression is needed
for local labels array initialization.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/jit_disasm_helpers.c  | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 1b0f1fd267c0..febd6b12e372 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -16,6 +16,11 @@
  */
 #define MAX_LOCAL_LABELS 32
 
+/* Local labels are encoded as 'L42', this requires 4 bytes of storage:
+ * 3 characters + zero byte
+ */
+#define LOCAL_LABEL_LEN 4
+
 static bool llvm_initialized;
 
 struct local_labels {
@@ -23,7 +28,7 @@ struct local_labels {
 	__u32 prog_len;
 	__u32 cnt;
 	__u32 pcs[MAX_LOCAL_LABELS];
-	char names[MAX_LOCAL_LABELS][4];
+	char names[MAX_LOCAL_LABELS][LOCAL_LABEL_LEN];
 };
 
 static const char *lookup_symbol(void *data, uint64_t ref_value, uint64_t *ref_type,
@@ -118,8 +123,14 @@ static int disasm_one_func(FILE *text_out, uint8_t *image, __u32 len)
 	}
 	qsort(labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
 	for (i = 0; i < labels.cnt; ++i)
-		/* use (i % 100) to avoid format truncation warning */
-		snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i % 100);
+		/* gcc is unable to infer upper bound for labels.cnt and assumes
+		 * it to be U32_MAX. U32_MAX takes 10 decimal digits.
+		 * snprintf below prints into labels.names[*],
+		 * which has space only for two digits and a letter.
+		 * To avoid truncation warning use (i % MAX_LOCAL_LABELS),
+		 * which informs gcc about printed value upper bound.
+		 */
+		snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i % MAX_LOCAL_LABELS);
 
 	/* now print with labels */
 	labels.print_phase = true;
-- 
2.46.0


