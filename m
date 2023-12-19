Return-Path: <bpf+bounces-18303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA6818B17
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82F01F237D6
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3E1CF8A;
	Tue, 19 Dec 2023 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgV222GR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506FA1D533;
	Tue, 19 Dec 2023 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d13e4f7abso28742785e9.2;
        Tue, 19 Dec 2023 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702999388; x=1703604188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpNIUdgm1xKEgSk1LoKphgMBJlifkTP5txFZXlU5p74=;
        b=XgV222GR+RIvOkm8CXNM2fTbLZM+cDQ/w5ChyrKDgm9uWGE/RTzRSFDbUaDpFaoRdK
         LYONjznfCXWuQBDSPIrbJ/nRte62koRidv6VF84xlG8bZyMOgxZ1PkbSLaEKBBVCT+nI
         s6YdBH9+d78BUshgPSfurWYYayzVfT+D9CeJkvohXpOsCDjs7Sim18JImqQv5/64P0pz
         G+nR3koc0zYy8654bb1J/RVldhiI/m7zCqwKkIAQ64rhxD2DTMGhHP7umukYGYc7VRB3
         TEMpIULtwo2xiDWyV3f571wjMIZj53EsBGUiLhSXo7PjkYlZZEDg+hOau9MFKZ/3ikgP
         qGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999388; x=1703604188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpNIUdgm1xKEgSk1LoKphgMBJlifkTP5txFZXlU5p74=;
        b=mtXI0GMZf4+CpK0Ny1AB5znN8RWxcYbC8PxX+URNDJfwjk1nP7LSLFcNfraVTO4Kao
         u3thFSkvn1gXZaQXrVXMmQCEAZi3Jw+VksHziAr8FVrN2+3OYQ9gHq8fsKLHMLSivjo4
         lx8wp+m9F7hLQGPaBtrDPz7urlOpyNSb529VXAis/x9sYPxBv2x91dg6blXLi559SLXA
         zVy0TCQF1g9jtCTNDrE3lspCQ3eHrRy6QQfhPYclzj/4tSGKD4wIeXTLOui56HauXRPG
         4NpWcXeI1kECGjqeuW0agqg94llZlgNa7fHxGb3DvZNf3W30fOSrQjlbLIgN89NJdDGp
         xKYQ==
X-Gm-Message-State: AOJu0YyWVUwj4refRQ5TXe3KCdm2ZuBl17rTPOBrN0ohsJGlenWizJjd
	9FQDazfkswv/JRwZSgw8ZkA=
X-Google-Smtp-Source: AGHT+IHhPjly3v7Sdop+BFjikOaHSUhil1aU6xIVfY1uk6KdqVl2aWvUISAltvTjKE2rE4sIFpBacw==
X-Received: by 2002:a05:600c:45cb:b0:40d:2522:1164 with SMTP id s11-20020a05600c45cb00b0040d25221164mr716333wmo.82.1702999388209;
        Tue, 19 Dec 2023 07:23:08 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b3-20020adff903000000b003366aad3564sm4687202wrr.30.2023.12.19.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:23:07 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] samples/bpf: use %lu format specifier for unsigned long values
Date: Tue, 19 Dec 2023 15:23:07 +0000
Message-Id: <20231219152307.368921-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently %ld format specifiers are being used for unsigned long
values. Fix this by using %lu instead. Cleans up cppcheck warnings:

warning: %ld in format string (no. 1) requires 'long' but the argument
type is 'unsigned long'. [invalidPrintfArgType_sint]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 samples/bpf/cpustat_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/cpustat_user.c b/samples/bpf/cpustat_user.c
index ab90bb08a2b4..356f756cba0d 100644
--- a/samples/bpf/cpustat_user.c
+++ b/samples/bpf/cpustat_user.c
@@ -66,10 +66,10 @@ static void cpu_stat_print(void)
 
 		printf("CPU-%-6d ", j);
 		for (i = 0; i < MAX_CSTATE_ENTRIES; i++)
-			printf("%-11ld ", data->cstate[i] / 1000000);
+			printf("%-11lu ", data->cstate[i] / 1000000);
 
 		for (i = 0; i < MAX_PSTATE_ENTRIES; i++)
-			printf("%-11ld ", data->pstate[i] / 1000000);
+			printf("%-11lu ", data->pstate[i] / 1000000);
 
 		printf("\n");
 	}
-- 
2.39.2


