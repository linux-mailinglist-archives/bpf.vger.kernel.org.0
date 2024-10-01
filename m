Return-Path: <bpf+bounces-40726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5387098C981
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 01:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C08285465
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2AD1CEE95;
	Tue,  1 Oct 2024 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYuUKqm9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93AE1CDFBC
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825574; cv=none; b=sYLnRZT9bSqixvmZnTYIgF349/5tJisj/kyViLiQJUM7f3LcH1BJ0YPxHmz3jbd4K+to/KXAN8ym5+NR8VcCqWPTFQnbugDxl3DLueT53l+WkillLDfPuSEFwsx1pFGv7Xn4olzFV6no2VrDZj9dGGU0UZ6xxvzhYkdhNWyuUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825574; c=relaxed/simple;
	bh=3oZt5ylCoxHKsVyh7aMpTeR7cd5wiXs2ywGS5msBh1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QR9K9R3D1YyCYXmAS9eu7yicmkMCm6zdcVBqEFxjhESUdpbkEFoYICMsIqzh/mEuRHnFxslajEOiHszmId44sbasKiZeueBRLHIORginG8cb1bQFKhG3oJ1Xk2I48tw2aV/w7ClYM6sziikegAb+0hsU8XXvuXMSmrfxWHYBITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYuUKqm9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b7eb9e81eso31076585ad.2
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 16:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727825572; x=1728430372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNoUe1svAWin57NsNPtdWX0dqIy/2tnTAhAce/E9hRY=;
        b=DYuUKqm9E0B7zVCiiZdRAxAdFttJHBqiuTb1LRTjY/22MPgjQr60JjaHREq1jERy4n
         8XH9sepoRgl8PUebeTBitcfqV2Pobr6EnEm5JMebczKsxf9I4BclrOIdd08pFNAohzLu
         od4fiFIvXU2QYknaLpb4lb8dEl9ENbIPEhdgtldXaeIhATLoOlW7j7OS642gDjiAI/Ug
         iOkCQIOezBVrWtGUtt4LXwTdhfWAQi847y22K8VSSRwaNl/il3maJ2ibGp+UgVE5kQLO
         OzMDV+/EJoy9n3yjo1bTHt0Ra4ywwtUZ5L+MkaDAR+xBmYOvg4HTCQcWP5e2hriwXFQF
         2GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727825572; x=1728430372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNoUe1svAWin57NsNPtdWX0dqIy/2tnTAhAce/E9hRY=;
        b=CyZnj9n8rz4+F+5ufYxHMZ3+5vdPZyF1r9RWuo7WOQ5FeoWQhFSqQJc4vVaxM2NQ4z
         fr2s7rQjkIug3lWMUeKu62J+a5o7+HINTpuZcV5A1YNm5t3GqHgt6oTfJSdZvYw3qWHf
         n9vXNwayZYNZjB9wZCcYRqfV/loTu8WJSKCq3zqdprF4G0jNF/ZP+EwnxWldYGFdfKF8
         JQQ/s6ATgQwBZzCQezCLI9DyI1+Rjl4eJ443Z16iOtle7+GsT8D9iEPGv6q93eTS0btP
         NtjMbSUg/nqQ/sulc4l03fGlz2Z5sXUM6sV2WpnwP7ihWXiosV/lz0eu3wMEHN38WG8+
         TJWg==
X-Gm-Message-State: AOJu0Yy+Jx04/gOoc+thkQ3Ir615Lv16VElR/Qdt2Mt146BfNv7CaBil
	KqWtjwq/SL7JO+RzmvCSPcwUSQmuSrdbansoJgDHEjvzUrKE2SvU
X-Google-Smtp-Source: AGHT+IGLtEAPEHdS+EvbHSIcvx2skWMxvqq9/1ykvTOAUPLqBUNvjJEohjnF49ePnGYjuxW6g3m/vQ==
X-Received: by 2002:a17:90a:ac16:b0:2d8:8252:f675 with SMTP id 98e67ed59e1d1-2e1849692a1mr1564967a91.39.1727825572181;
        Tue, 01 Oct 2024 16:32:52 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([112.96.85.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f758dd3sm189690a91.4.2024.10.01.16.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:32:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v3] bpf: syscall_nrs: disable no previous prototype warnning
Date: Wed,  2 Oct 2024 07:32:42 +0800
Message-Id: <20241001233242.98679-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In some environments (gcc treated as error in W=1, which is default), if we
make -C samples/bpf/, it will be stopped because of
"no previous prototype" error like this:

  ../samples/bpf/syscall_nrs.c:7:6:
  error: no previous prototype for ‘syscall_defines’ [-Werror=missing-prototypes]
   void syscall_defines(void)
        ^~~~~~~~~~~~~~~

Actually, this file meets our expectatations because it will be converted to
a .h file. In this way, it's correct. Considering the warnning stopping us
compiling, we can remove the warnning directly.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
Link: https://lore.kernel.org/all/20241001012540.39007-1-kerneljasonxing@gmail.com/
1. remove clang check (Andrii)
2. add matching pop at the bottom of that file (Andrii)

v2
Link: https://lore.kernel.org/all/CAEf4BzaVdr_0kQo=+jPLN++PvcU6pwTjaPVEA880kgDN94TZYw@mail.gmail.com/
1. use #pragma GCC diagnostic ignored to disable warnning (Andrii Nakryiko)
---
 samples/bpf/syscall_nrs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
index 88f940052450..a6e600f3d477 100644
--- a/samples/bpf/syscall_nrs.c
+++ b/samples/bpf/syscall_nrs.c
@@ -2,6 +2,9 @@
 #include <uapi/linux/unistd.h>
 #include <linux/kbuild.h>
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wmissing-prototypes"
+
 #define SYSNR(_NR) DEFINE(SYS ## _NR, _NR)
 
 void syscall_defines(void)
@@ -17,3 +20,5 @@ void syscall_defines(void)
 #endif
 
 }
+
+#pragma GCC diagnostic pop
-- 
2.37.3


