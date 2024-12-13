Return-Path: <bpf+bounces-46844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40CA9F0CFD
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5342833A7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CE1E04BF;
	Fri, 13 Dec 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="d2TLvY5T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0A1DFE2F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095278; cv=none; b=HNdllt6bsVU3FQo2qv9l/EP2sopMl9jwczRFciO14xqzkKmWu0ObvfPJtZSciEbLd8pFUtGVWFysZMw2BnlIyB6nmidh8CPngLuMl/u2hsDJ/uI8jJvDXR3WLE7OjzzCoOOx7HBrjobBZo5lTU4ho+bNSixPcxPD0RRr1J0TXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095278; c=relaxed/simple;
	bh=5M+9sZ2uOISCSb6KW/FXzpjBYHwIs149KFBIoWPdbV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRRv7Vi9TzdoCk5/AMGi4U8prAxXlnci9gW3e+7+/Dw1ILNmZu0CvzBqWBhTUzFcrwwnejrAMEow2wFhj/v6xJ8J8B0irJx90AmDxMT6xafu6sz0Kq5gz6BhXAi2mGN5cTUCd28EToeuHjFIGe1Q05tu2Kfog/91dw16iyP8IBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=d2TLvY5T; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa543c4db92so337989566b.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 05:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734095274; x=1734700074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95uLp76JDqCGAntKfWwQIWRGb8VQc95vaaCgVutyp08=;
        b=d2TLvY5TGbSHvCXB3j27O3bjKW8E5v3CpvsI2KVRsfBtS776WMRdXgEfTufotuYZ8e
         tXTT8PUHWTBD4PG+J5WXT0wwyKkU0CCtaQOYIsKKneYG7k8+i0z11Vhn//N9bS3OPol5
         Tp4Dbp9yu32iya7kcAugZCdYeljculHr8d2FrcAErtN/lkUR8yQIIunbjNo9OWGkgv8Q
         6jKWQvJZtao/MMhniH4RWID3MW46dswhzvO7UTn9PL8RdXGuik+OAt8HsY6pYvXiSWE5
         uvf09IZWb6jwyFmqLfVGruhJTqpTm2lfoADVIacaucCW3goDK+/CYCwXW+fjcP0M0Xf1
         B3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095274; x=1734700074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95uLp76JDqCGAntKfWwQIWRGb8VQc95vaaCgVutyp08=;
        b=s5a8bu+6knIGk+PXy4re2NH8zg2Qm4WFQZq8l0wyfE3n7k1J668xzXlAbFg5GbiJa/
         qFhcWpvAMPtoyH9mDTBU7lK5vLTTTcdhWqTyGRjI6s8y8tOWW/VjFfmHpUd+0LZIY3Uo
         RICLDlnlup2uKpIybKH4O+sMVBqJYzl14ocCONSBmlBYTvxAq8Ql9GRqTOTdgPWvTQ2l
         h/DJmLXQQqhK0T5VkAC81BEpFUePDjMvsUMeHNFk9VWuRxSGBcKmGXVWWsg3wPgtNqWO
         beoLzV0scWzfWxxPBcWcMQai7eUHMwsaGsMoZ6dPhPYzjFYuihOTkMsiR5Cp8mKanZVI
         d9Vg==
X-Gm-Message-State: AOJu0YzgIzZooaHzYsS1ClxYutt9lKk859P7wsOzNpkwVt+0e6oczcbk
	0eY8eFmarAKTZlag78/3YMNrldnz4yL7aX6v9OpAl33V2tFm1OrGOiKUEv0Sr0ULEWf/oJyGZIb
	O
X-Gm-Gg: ASbGnctX9UXtGUTMB08fQUY2XrJYLAQp76oiQiGj2mnli984GCn+02IRhQ6r63l9M5Q
	etj0Tb1Dx5I3WBBdkZG4dE0xnrv+EsfhWaLplrfgHG4U4O9B3CCT4uE8yT27/PEQHdU0qAk4KfG
	9FMKSOvArhdeBz862BANeo1r0A1SUOPQ0ov5evn9UtWQ7IJK0KWl92lzbUX7NP5oyVykHFkPb3P
	GSCnwWwpazkNRQ4wSFcAKujGexoC1ZinwwzgpTuuSBXx8lnOFVs+lw9VZH7U2mPaaLbUQ==
X-Google-Smtp-Source: AGHT+IHSJ5PGztA6F3+vb7mVcCAtcTrlQPCLp2ZEcn9iVIFij6O43tbhYKRSOoLHFq2o/4v0XtFTFA==
X-Received: by 2002:a17:906:3089:b0:aa6:887a:57c0 with SMTP id a640c23a62f3a-aab779af3camr229724266b.28.1734095274100;
        Fri, 13 Dec 2024 05:07:54 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa657abb2fbsm931248666b.128.2024.12.13.05.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:53 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v5 bpf-next 7/7] selftest/bpf: replace magic constants by macros
Date: Fri, 13 Dec 2024 13:09:34 +0000
Message-Id: <20241213130934.1087929-8-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213130934.1087929-1-aspsk@isovalent.com>
References: <20241213130934.1087929-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace magic constants in a BTF structure initialization code by
proper macros, as is done in other similar selftests.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index 0f4dfb770c32..b698cc62a371 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -76,9 +76,9 @@ static int btf_load(void)
 			.magic = BTF_MAGIC,
 			.version = BTF_VERSION,
 			.hdr_len = sizeof(struct btf_header),
-			.type_len = sizeof(__u32) * 8,
-			.str_off = sizeof(__u32) * 8,
-			.str_len = sizeof(__u32),
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct btf_blob, str) - offsetof(struct btf_blob, types),
+			.str_len = sizeof(raw_btf.str),
 		},
 		.types = {
 			/* long */
-- 
2.34.1


