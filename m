Return-Path: <bpf+bounces-67431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B78AEB43AC8
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 13:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7211C262FF
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AA72FDC5A;
	Thu,  4 Sep 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYXlp/V4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833362FD7B1
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986842; cv=none; b=mj0dFNssOQiyzFQxETXavnWQrusDuJPj0x2Q7PQZNfC6uxo7UZxaI7lYUtljo8Yl9bZy4NliKFEA0HsTOKFH4a9dvCdztbsHMgrzRWdsRPyamntGJ5UD0oo6L7MEkcP6xuhnTrjyu7uN72yXERWvw81VwsqvFz2kp8VlgQN1iNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986842; c=relaxed/simple;
	bh=ZGDry0f3I9LdhfdPtPrCDF1bR37eHAMJfJY2yIdL1pE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mu3EB4ph0dqHwjc7Y3gMf8IsSlmyZy1uT6VjAbphMhFB6UhTwEWsSfCHMPkip2uz6QYFj4CpaGj4KIi3IENEm4X8S5CMeuadocwsHjPVRd9kXu7yG7ZC3vmxGKGcnV6UFsIU0Snb4dJcO6C/lNjZczdbDYqe2NIBKVQzxbWqGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYXlp/V4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso783113b3a.2
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756986841; x=1757591641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOyaOy1TUeTlLQpuH2jY8lV+lD5/5FEO5WmDobRugY0=;
        b=PYXlp/V4vn661Br+uYIc0HktWnrpDmlirLLK7bq4inbpnAHM5NpTkoykTyAaajm9YX
         ZoI+WaRgz0eoZ64VCBaCr3mkdPoyKtQSRjQ3Tme3OMLbfeXn82cUwRtIfF2kRPmstTIV
         JqzTCZt39rpGRkhkivt0bZ3WAFDt86KZ5e7N0m5O3MvshaEO9JPnanJdecH3nKkIgi2B
         KExvp1vkeMFnGJzGA/q5QwfOLXIJ+GnJEMIV1aIqIfBfGn3V5o65SCB68yq27u7rdW9j
         ILypoGKG/GHNKeM/7Y0mmDIfradfOBF1pFwO4Iz6zmlC45po6DpmqVwfhB6rgoiuQ40l
         zsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756986841; x=1757591641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOyaOy1TUeTlLQpuH2jY8lV+lD5/5FEO5WmDobRugY0=;
        b=UUpyJMpYl3cxDLWr8/iCq6+STHTq+SgiQGc1KA4BZyhxTE/NjNWEgLtNGR6Vr/bWNU
         lk6dBD6LQZMmiphdlOUneKcLu1To91bpbAfuwxfakrDL8jKDrX1/ZrdD5Uk8JmkxArfB
         c2vKGUuwOxsmS0EpU2E4GBbTXgFu3o18oeIKrSvhhjHMUI+yGGY7YZL6YSvI2KRtUgca
         NHBzRk/83/J80/aJK5FID9v/FQ14wpgL1FgZtKPN9w5Lr3Ye5zAoUotJtB4eWX1JlouJ
         ze2yWs38StAzZ6y2k+s/8S7yKBofMwq0mYh4Knlo7ChZktO7Z/ErFutHj5Skit/r7Vij
         8nog==
X-Gm-Message-State: AOJu0YwcTuFUiq5TvEk+aFQvBhkel1doHi0jbd+ZM4WXmtNvSgsCsz1Z
	5Dc2sw3ByBtRY2ssX6jRgmar+KOTm2AyOzTLkpp6pZlFqQZ7493qvmue
X-Gm-Gg: ASbGncsjKkf7peaH0WrtaYE2aWvLadIffIqTNK1suxsP3lxdUsSWCfma7ezCVgKGDyQ
	6V/8+HeI23y+L6/kHT47f0DMvRRe7JE4aMML3TpArGkqv6rIy76F+As4AQU+BpF2jZm0uTwDCg9
	ezlATMYRUU74n17NkL5ozELbMj5hp+Z2Y56sDzztfd2p0sVFJ20PN803Z37UhfQ23fzACQmhoOE
	6gHZeucuaWGzMkbJh9SjpP1qv5w1crWMoPj1cexTIB0Vm22BQ8p9wBcPFnb5MMw2f2flyvTv/GH
	JkpphmcYYxRSH1PT0bqvzFfEpvpbhjxbwd21ZDcqQ01fnbZg7HjUwbolLyrsoOS1bVioe3TXLwV
	9JvVdHOrGI0GzVvm0+HtWFr8HM6NbK7XNogtP0nsW
X-Google-Smtp-Source: AGHT+IG5U8I77c0aXyWTZbBAke1v35au5SmobUKELJ9QsTDU5WcZb24e3FlTusI3wJ/BkyFpwW2QiA==
X-Received: by 2002:a05:6a00:14d6:b0:770:579a:bb84 with SMTP id d2e1a72fcca58-7723e21e765mr20732802b3a.5.1756986840648;
        Thu, 04 Sep 2025 04:54:00 -0700 (PDT)
Received: from devbox.. ([43.132.141.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77231f40553sm18016441b3a.43.2025.09.04.04.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 04:54:00 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com
Cc: bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next] bpf, arm64: Remove duplicated bpf_flush_icache()
Date: Thu,  4 Sep 2025 07:57:03 +0000
Message-ID: <20250904075703.49404-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_flush_icache() is done by bpf_arch_text_copy() already.
Remove the duplicated one in arch_prepare_bpf_trampoline().

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a98b8132479a..f0b1cb2c3bc4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2773,7 +2773,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 		goto out;
 	}
 
-	bpf_flush_icache(ro_image, ro_image + size);
 out:
 	kvfree(image);
 	return ret;
-- 
2.43.5



