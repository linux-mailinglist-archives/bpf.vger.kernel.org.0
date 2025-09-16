Return-Path: <bpf+bounces-68598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79670B7C7B0
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC287A44D3
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909021B9C9;
	Wed, 17 Sep 2025 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsHs1cxz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D041C3BF7
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072383; cv=none; b=iHtkyBPZqqqfw6BiOCQzg8zy2y8SZ6lkYvTzpt/fWdqcWaU+HDwAMiYtale3PdLyRDedgbdqKYkVb1cSLU1J2rNizK9NP/Fur7hS17boGJ3GT3Q4qA7xMtrQ6XQpBi5DC/KF66QAHqdktNT+ho8212RXE4c7ZEmN8GCuB4BXMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072383; c=relaxed/simple;
	bh=yByAR8pISeOMGdU3ru61JfHWJ5K6qAx/f2QQ0ziYsGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHdnrDIwu5jEf2B0FTonJb+sbMbU1DTmsW1wJxwmviRHlIPor/2CCJcUNsDUOe11SaSTgoN+r9ekYK0bfxUrqy36dju1+ZITIMOr+u237EuNrYuMUKUcIpxuPiR/f2FE+G3CULJq4yK+cHEcKGcAcq4oxnuHlBedgMEBZy9jgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsHs1cxz; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so3608823a12.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 18:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758072381; x=1758677181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPt+rEqdYuKl8keqkruShaawdezZ3o7CfBIi1U44gCw=;
        b=UsHs1cxz9WmgDcF7z0BozOXOLlJEnVNWApbJ9HYJ2E7yRp7piWE2rEHff9B+FNJQqa
         zVTCOU1WmPBWbCJ6VDGKKxBwHPHJXSPl8FwBbbSkmLBYByF8mq91O8Cg23YCr58hQoSC
         SjyXuUQU8AiXGf1taYq3ZxE3l/BaSUm2mVuQdCnhx2aWvaDSAUrzORvZQDSdrAZUtPdL
         uqta1oR8MjanEmBrhToOkE/2Viyb7VpE/8XlfhHM4nHDbvaHQXLbUy4PdEs9YXzpYxIZ
         5J3Vfa8CgF+V+u7YYibNq4YvtFSo1vgvUI+21L2wAFYMQXAWX+Zz2qDRLE5IQS9oagyK
         chlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072381; x=1758677181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPt+rEqdYuKl8keqkruShaawdezZ3o7CfBIi1U44gCw=;
        b=RpY4GUTQ/rUA5j09Sh+Ejg+4hBqLVYgYKJQl8j4ngS/6yOPj7eHegvSe11B2ovApY+
         mD6mn9LXNdU1gCj6UFWUBZ1FEMlsmgEYaw4cAiEvgVdutvWHIeT5G7JNG5zvz8ey/FaH
         mgbD5XrnMpZ4mIfaJQJRkA0VKwSVCujHj+9oy0duYP9xQGPYFRkQitGcjf3Q4p++Rh4s
         IiQ2jd8kg5P79v/1QVyiqaRCRa0GrYcCsxhvnhKbsPwwJCI9KgvZO/zjadXpwqPvQxxD
         JFXaY8Ur90+AZAghYNtkcOj/osNXHkwxBF3cRdM7ndl0aqU3K7ZJartOr6HPtdPyg81d
         dIqQ==
X-Gm-Message-State: AOJu0Yxk/85tpAza5qWm6hSdsAQX0i9HzhLj8y6HsPw7MH0/TD5tYKxd
	Bq6kxRYeHjh5LGTVFOiPy3c+IVYa1oCefBsxBztK/y9f3cvFOHl8cFVi
X-Gm-Gg: ASbGncvMflfShX5IZzfBmSk4H7gU9tJIXRC0U+uCC+8XG8lY6At+iMft9A6vRhktU4H
	xFAmRn6yOCRlPRksXXqA40vIaD6yIHP8coJPn3kDxezoYr4xarQfZq5j41fPH9TwVHHHhmqkhH8
	z5NNvHQGzjIJeIZnOSkpxMNnKaI7WTj6oJbn+ktIjtCH14KJUpgFTTbP0jqx0v52G7YkcR4WAT/
	rkb5BFDFnGjgjKYy9al4B2dyfm6+POnd7A6e8KqE6nhqgEFdF8NAZEKdHog64vyO6wOwMV8Jl4m
	U6GdPvdANxEdzo1BwrqnMZsrIdVyc8W/CkqQto4o3JnUtL4SdpFGwbRZP4kPOghNUUXtZwTYJhR
	qsEDX7w43Nt/IpCkDheGo73RhLmbKjIKPCsHFs58=
X-Google-Smtp-Source: AGHT+IFJL8uvxyb3+zp8ScoLZ9F/QxqxUp3OEkXRXHMkqCEsypffXOk3SsQ90x81ynbKu1aZyyGFWQ==
X-Received: by 2002:a17:903:3bcf:b0:258:c13d:9b1a with SMTP id d9443c01a7336-26813903d23mr3108855ad.41.1758072381161;
        Tue, 16 Sep 2025 18:26:21 -0700 (PDT)
Received: from devbox.. ([43.132.141.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2623fd4d163sm107091185ad.80.2025.09.16.18.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:26:20 -0700 (PDT)
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
Date: Tue, 16 Sep 2025 23:26:53 +0000
Message-ID: <20250916232653.101004-1-hengqi.chen@gmail.com>
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
Acked-by: Puranjay Mohan <puranjay@kernel.org>
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



