Return-Path: <bpf+bounces-66766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC2B39117
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 03:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA45188A53D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5F1EFF96;
	Thu, 28 Aug 2025 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtiVp+UC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402A1E9B2D
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344879; cv=none; b=QNegk5RQYbUNw/qkLUorZQoaiw4LTfU7rE8PsIoMyqbZN3+PI2Lrmd5aFingPJLMcIn+1jCS2AJaPNG0bIfm6EysGd4ZawB0bEl0JAwotTc74R7JfZLiHphjH+upy7RctFGOYlKg42OUnwEYn7ld9Dw6faa+aUAbRypSom0m9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344879; c=relaxed/simple;
	bh=gfF1qyvjB5N6yTD7hSqxjyiQ6KSRAWz8/QKL8zTWPh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EW63EWLjiDq0eV5JnBw75upRF62iyRpBhmDqmP57EjwOH0wICX+c7OEAf8yvIII+FQXZLrz08PE7ZeaNlwzG8D/7A5dWGTk33n9KB94r12wo5gkI0iCASKyDpW55b4AyYdfTovDaY5xPnjz/NpTua5aqsEFnF8ECLCTKSA446ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtiVp+UC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-771e987b4e6so378931b3a.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 18:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756344877; x=1756949677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1v9lGyqvYOU8BD3RlsHoHwZkWbWE/xNcKpE/dT3FZ5A=;
        b=GtiVp+UCo8Pyl884Nz7Kt8CThhVZ3u46mcJ9wrGp1EdsiWSc9KBQ/+NT0giMFFoduP
         S/rFVmsiQqTVQSjYiJ7AWFnpLBvVT6Z2NdUsyGcNmCmCRU3bhHn+3ntzjufk+5VMmXPe
         qzKhLZB3vEo6UfJVndOGu1ZIX2Knez74TR/RkBvKWW6ZWo3u7p895WFC3e98aZ7Vj8lY
         0OoLfSUNuVeSY0z4n02Q/85pohUDN3kVGKmdAQd7j5FKxMg/W9VmDX+ewce+dcqRsgar
         A3gaPm86QkC4RVJ/D9KnS1kegzAy2AuvMoRlMeV9wrwlNhK7rDLvEOn91b/uPr70+0mw
         0UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756344877; x=1756949677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1v9lGyqvYOU8BD3RlsHoHwZkWbWE/xNcKpE/dT3FZ5A=;
        b=vlAG2FJJVeOgK8AMoO/RVFBh89YYdfLt/3NhIPFoDRz8Blghj8tvTXrn6KrQogKDRY
         lbM7ydRNd5z00PGwmWjMQ60PthsP84a2p5LxZqZjA76ipLNn+8XpnJIYYn7s/Dx1TBb6
         0K6t1tipaSejG+tAvMmCZgQ6YPSEs3Avx6LfBrb3A9CSwAAoOC7A8Yq3+EWJvGCTNQxT
         9nzjM225dIzHLKDmvhl6uNFm0vlnpKFykC1es99WZShIS8Tm8kqD/4seV3gdJwgP+Q6n
         dodh5/m3UopOb7UUITSLZ2U7plaYIkhslNrmM2zo7xbv6MaxmMu2JCGml1UhQHk9lWHD
         bPNg==
X-Gm-Message-State: AOJu0YxNCHFuNU1Q5dReXscGm4ztcVVtU7vaCMS5wnhewB8Qx08zZqcM
	NqljxLG0OFHNrnfcPrgwxxMtg33r6QwarN0NvRzY3dKBfopmkzxM5RecW4HD0tiH/W8=
X-Gm-Gg: ASbGncvTRfV2FL66B71BCsPSa8ppn295DhkuYk5XkIpBUF8gDxuNXNuwD0ZzBZ/QnUa
	CapZW8PB0QR/7zt7iDYEBkjbJWVK5N30IgepwvlLNB0GdZtQCXf0R/v8jvwQ8voFSLpC9RPwPLy
	3DsZ4WdIisoRLrUG+4llmfZ/GHQgY6jMZMp+rJE/0dgWCNWIgGNdkmG7THLe2vSHzXupM8HCvGo
	2M4UmYzaY9mqQlnmkSbVrDEcFEqEoiD5I4qrQDbDF3tGYvP3ZZBVa2mnK4Ne8u6X26VUqmjzdUr
	5WGrnZKZ23Varv0XsV6CFQIz96llnVXBy9lUEQJEcaZJgzRpDBMc1r0X7LmZf6wX9DV86V5LvqX
	nZY8A8JUzi5xCX5F51ogyR50ak0d53Fb730lXUPo=
X-Google-Smtp-Source: AGHT+IHI2OB8fTggpwSt8Lv3DIwQ78aQfIRRuqHkq8NOU6aMNHWhFkvLuZILCgyJxropRjELU6CMew==
X-Received: by 2002:a05:6a20:939e:b0:21a:e751:e048 with SMTP id adf61e73a8af0-24340d7bb9emr30381580637.35.1756344876946;
        Wed, 27 Aug 2025 18:34:36 -0700 (PDT)
Received: from devbox.. ([43.132.141.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9a18esm12624021a12.39.2025.08.27.18.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 18:34:36 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com
Cc: bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next] bpf, arm64: Call bpf_jit_binary_pack_finalize() in bpf_jit_free()
Date: Thu, 28 Aug 2025 01:34:15 +0000
Message-ID: <20250828013415.2298-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation seems incorrect and does NOT match the
comment above, use bpf_jit_binary_pack_finalize() instead.

Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 52ffe115a8c4..4ef9b7b8fb40 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3064,8 +3064,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 * before freeing it.
 		 */
 		if (jit_data) {
-			bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
-					   sizeof(jit_data->header->size));
+			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
 			kfree(jit_data);
 		}
 		prog->bpf_func -= cfi_get_offset();
-- 
2.27.0



