Return-Path: <bpf+bounces-61715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C133AEAC73
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 03:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7CE4E0999
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 01:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E31547D2;
	Fri, 27 Jun 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUc/ABsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26052F1FE1
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750989344; cv=none; b=e1eCbEla6jf2tqkN8vah7+dn1UY9jJY3gLnE9n7e5hVaP6XCGpfOGIbi/SJJ0+WmDaZkH7iZ2J52JopK9v0Y8sZMhBh3s5CdgzE6usmzxtdTCRftA9UEYURDFRT4XwQa9Ds+Gk984b2I62xovDxbZUhyQYKbJEfAj9oRe+0tBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750989344; c=relaxed/simple;
	bh=IUicsdaLrWNFiljXa6vySP05v4ByX42mQfDYprHjdsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErCddAOs7yVigYMtN3YW+C0N6zV5TEL2zC2VvmDJvq5pId1x8aNDA9SUrhmEzWIJ1XpYBIpUPI5RKcxBByuLlb1x8kes9aYjPvfacYP2GeN8n/wGxycj/f+lRHoMW9UeF6mxScjQUDOupU0NK3r9N81kXUBSvcd6XS0ZlUAyokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUc/ABsZ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70f862dbeaeso18372197b3.1
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750989341; x=1751594141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiatSxSLVVxDhRKq2J1nAtr2pigRtzjlduv3G8BNaEw=;
        b=GUc/ABsZ/7XxcVfICuFnRL7XJudWrOkbvd36gwlLXXRLwYXxh5KSt1tod+0c/ZoD9A
         lT6ljsHPQPCV3jea2VxjInK4M6He6egXULn2ATUCFEtOtiBk57pV27rYWGTPctqbd0tU
         +FWtgl/R7XADat4kHtgIVhvzzpAz2dgC+tmXDxHTYlAZArAsJqdQN5TAXuS0Op4pVt6l
         gofpRSodZjY3kKqBkZE+CpXjpJNkgzbV49XAGuyxC+jNeXkYSBbewXjK9jwPzUJG1trz
         LS4HUPVSLLzXBwO6Lz3jufOd5tbdWePP9YKu2X0geRt1xyi0nsVbJRfRaIHskHoSYEiT
         amzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750989341; x=1751594141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiatSxSLVVxDhRKq2J1nAtr2pigRtzjlduv3G8BNaEw=;
        b=f6rUJJWtebIVefIlVEU9yEJiEBVgh2TDwn1JOybVHH7B8jLC9FIvU4EFBLOEBMg1ry
         f+fcJ1IcFBJl3d8mCcVnoteiHDWTbZrsnD5JwFGJ2LWl0rd9pbrGR4moLrguu303z8K9
         iG2qJXq/WtIzeV49NdYdESewSiU1QPNZVDEqb3U0X5YA2Og7gMYAgR7nyGs5gYmDDRZp
         qljvEbvCRLOHeNwxXTmgWuE3Juby7de7LzLJScBVK6cqaIKkfB1AK2NN8M5vxJ3XQ6iu
         lMrfXFqG/L7/DPkau2ZtLcMO9Eqou5Wby1uiuFjMPkKnL0ekYSITRHLDyF+itGhzPvi3
         8mRQ==
X-Gm-Message-State: AOJu0Yx2Z4vSX2UHmOLVgZ+3fhN4yYpSCRtFVd1S6Equ2x77jjliERsp
	mqXBZG9W1+FpHmo8c5Z8DuifRsq7bgES4tYH9eL3hS6yVUgFR963ggk24WDCyHcj
X-Gm-Gg: ASbGncsHbSWtM2ZhB1/9vhlrDC+dMyuLq3vsWDk7GuDMGvWZ9p65BwDTbANFO4X4DBU
	yWyWHEaEN2ntGW9mlhzxpQzV0BL4HA6KLNYSJKuoVs+jx4DtbEiNOfMHULGtw5WJdnb4MgmfBha
	tF3GX8cie9wxcQATz6GrwfjJt7SZREH5foZRybsHdj3Xf/13Pqm5p+gDfhX5E/HL+q3ndkSHh7S
	QrWq0VKB4hRuc87P3dUqwtmeEaojrfTj2rM4m6dL0+1/AU+cxbLvShi7DGBbawJrNJGJOPMEDt2
	srKSRp5tC7Uq5W6ONzNoJokM9sre9U4x1tjEuuMKNmASCEuocFP2bA==
X-Google-Smtp-Source: AGHT+IGCWaFsXOn8YkeKT/NZ4GmQTXQJ416B1iJJ6UVHbCSjLt4RLMYs9/6M5rnTf869iuD2lTwpyw==
X-Received: by 2002:a05:690c:338a:b0:70e:2d1a:82b8 with SMTP id 00721157ae682-715171adb6cmr23220187b3.34.1750989341571;
        Thu, 26 Jun 2025 18:55:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515c91280sm2419297b3.64.2025.06.26.18.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 18:55:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v1] selftests/bpf: bpf_rdonly_cast u{8,16,32,64} access tests
Date: Thu, 26 Jun 2025 18:55:39 -0700
Message-ID: <20250627015539.1439656-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests with aligned and misaligned memory access of different sizes via
pointer returned by bpf_rdonly_cast().

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/mem_rdonly_untrusted.c          | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 00604755e698..b0486af36f55 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -133,4 +133,45 @@ int mixed_mem_type(void *ctx)
 	return *p;
 }
 
+__attribute__((__aligned__(8)))
+u8 global[] = {
+	0x11, 0x22, 0x33, 0x44,
+	0x55, 0x66, 0x77, 0x88,
+	0x99
+};
+
+__always_inline
+static u64 combine(void *p)
+{
+	u64 acc;
+
+	acc = 0;
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	acc |= (*(u64 *)p >> 56) << 24;
+	acc |= (*(u32 *)p >> 24) << 16;
+	acc |= (*(u16 *)p >> 8)  << 8;
+	acc |= *(u8 *)p;
+#else
+	acc |= (*(u64 *)p & 0xff) << 24;
+	acc |= (*(u32 *)p & 0xff) << 16;
+	acc |= (*(u16 *)p & 0xff) << 8;
+	acc |= *(u8 *)p;
+#endif
+	return acc;
+}
+
+SEC("socket")
+__retval(0x88442211)
+int diff_size_access(void *ctx)
+{
+	return combine(bpf_rdonly_cast(&global, 0));
+}
+
+SEC("socket")
+__retval(0x99553322)
+int misaligned_access(void *ctx)
+{
+	return combine(bpf_rdonly_cast(&global, 0) + 1);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


