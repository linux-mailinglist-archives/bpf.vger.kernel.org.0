Return-Path: <bpf+bounces-64667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE336B152CE
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21A54E7FF1
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF9298CA2;
	Tue, 29 Jul 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPaOXQLO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AB29826C;
	Tue, 29 Jul 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813565; cv=none; b=nu2+S29ozSeqlegbKuMXhh4eDpZBvEwAUM+Bbl0OkE//c3+A6X2+6DnCgjH/dl88bii2wo9RyrigtRg8ARcOtx7GRKGKDDN/IAwH/TcR99UE0g5w55A6deHGp7BO3tbizM5LqHM2aCjcQs3UvEX10YcAapFT4mGQCtsVb+pKO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813565; c=relaxed/simple;
	bh=ThxrhUQmgHnKoZCiKwbvXXsLAzRmEKu+szF5n18oy50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nohpuvn6u1gVayvAg2v40T8rhGUIwQx8vu9F2OTkQjxCeILKAE8BIXaOpIQWzzrZPjpeVn2kEzC8WOuBAvnRtCmXGiv0/zZ1YE6wzy5HO6/gOY13+p31nPh8Qfmkb6k7sGjWvcV8sCGgYgGeiUJqHvMQ+B1jLTa1gYNsNsXBln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPaOXQLO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2402b5396cdso1224375ad.2;
        Tue, 29 Jul 2025 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813563; x=1754418363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o9GcNR9ynlNqGpUBid4pxs3oaL3zXfQJssJsmwzass=;
        b=cPaOXQLOKIyFmXWZ7bRng+N1GiKPVLX5RBFdD4zZzjy0lYwxQQhGfZaGD+dTrACm0C
         UdxoDZGKzcoH/vNOcipudnr0s/Kz+Y9QkCZGA5ALA4jZ9d8BfB+9HC8M+uJafLYGQdMD
         Je+sNZ/7RnQs1o3ImZ/lhv6RRSjIXAYwxTjMYyP8nhGTxMmrw/AMaHP+k37dUAIM+LvE
         i8G6NMNHoYcHVeQCivXHL/GXcmGAt7lmB31z9391aBMlWDONnr2ihjHYe6jBIcqDPM9H
         NAOJR5G6qZQ+yOW/x05hzZiFVnCS51OcEHP3kzmOqW82t06hMvqf3KBoyFi+ToHCj0yB
         ot4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813563; x=1754418363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o9GcNR9ynlNqGpUBid4pxs3oaL3zXfQJssJsmwzass=;
        b=W0PdiRJ5djaL2oaqZBeAvqFgdDJX+iUICmvYVlF3qqy1WqOgJMNQ8tJBFMDvbKxNrF
         akMomvC5zYKf3AmUczdtg0e3wiQo+OZ/qioqjMH7Xc/QYDYMtPhu7SEZbM2N6d5tOBbV
         NoLLSzl9ICUzJmK+jYYFfc3Eb3kXrYymXyVTK/6MnH4dbvliAUfNcj2+gz2/gP/OlLId
         l2Ipko3uVkC3S+VDXwlWE3TIoFU8wTUYR83HIdqquxLY4Q2DaTleis7ibk0veNksEqJ0
         axnk350nfYLJIaQPOCdRKM6jyhaV1UERD0f4uObu5X1rksUS/FRNqkuv/Yiug79RSopM
         UK3Q==
X-Gm-Message-State: AOJu0Yy1z7tCXksBhTEAdXGPmXqajHOStV8ayDCdaIIozHb/f2o9DIRD
	oOZqtJ367m78gwEXW8UhH1KVDv6LE22YeAFYJXCunCwLfWF3uFLEiiWpwdh5PQ==
X-Gm-Gg: ASbGncsZ//EL39KRFi4mAG6ytPK9MN5nzgzexRH43Pxu4ZsfCG35/uO7VixcDGZhQJ6
	MMX7qOEMcx3VaEIJP0rJbhMa0Cqh0K0XSEwP92RZwmYGzNAfwDARCFx8xquDufreKW2ShHhjk2C
	y0u8SvwBmxmcjnVMKV7vVWfkEen1GSQWagvRGDhEcKdesuAcyuTu+NKr6mdgSKQSo/sgU7o7qkk
	zELvMHFYEBCc+YSloHM2co7XEc6pDwfIFZKZVo8gvw9IT7GYIyFeBjfcAlkaIm3Dnn5xgC20a4M
	jwtdrHskJle2j77p1lsIyUUZxXBc3rcl+l5JMHbdC+cwVzzE2DvTFFNyRxlieatZ7llCrMqetva
	1vPM6xeAJLtZOFw==
X-Google-Smtp-Source: AGHT+IGfHuRZpIPv7PK3xUbEmgv99miKgW4zy8zmYTCrve4XQdREDemY4ElDAr6yP/6zWsiN/zL8+w==
X-Received: by 2002:a17:902:f543:b0:240:96a:b812 with SMTP id d9443c01a7336-24096ae55eemr7445295ad.24.1753813562883;
        Tue, 29 Jul 2025 11:26:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30fd50sm83644745ad.43.2025.07.29.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:26:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	kpsingh@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 11/11] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Tue, 29 Jul 2025 11:25:49 -0700
Message-ID: <20250729182550.185356-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
References: <20250729182550.185356-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cgrp_storage_busy has been removed. Use bpf_bprintf_nest_level
instead. This percpu variable is also in the bpf subsystem so that
if it is removed in the future, BPF-CI will catch this type of CI-
breaking change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 82903585c870..e08b6e6475df 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -875,8 +875,8 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_F_COMPACT,
-			  "static int bpf_cgrp_storage_busy = (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_bprintf_nest_level", int, BTF_F_COMPACT,
+			  "static int bpf_bprintf_nest_level = (int)2", 2);
 }
 
 struct btf_dump_string_ctx {
-- 
2.47.3


