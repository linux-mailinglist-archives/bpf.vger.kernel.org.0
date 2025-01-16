Return-Path: <bpf+bounces-49038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D654AA1344A
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 08:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B323A166A
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6BC1917D9;
	Thu, 16 Jan 2025 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZU7Ki8X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACA7083D
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013859; cv=none; b=NtY0B+MaSRQ6mApdCBaCYWZ7U4tLZlCkyAATb2tZqDrkzpUkl8OStrrf+OGpFJgqCU9aQXAPWoBjBIEfYuhg1wMguRGLn9OthilQaQh3dI0oW5x2DPcHk+0Z+dNgOt/AaGDZDS248NXk00wJC/Vik43YTgqB22+az95H4nIocE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013859; c=relaxed/simple;
	bh=mKYBeQfRAJA3UwR1ArjGg3VDifRCFs+0aRV+3KUOx5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qq85C/qtqHmWqEAsZyX6nhuA4tjaaNrGAHEkSfghqIdKVrGtUpcAIrkCVjPU7uRmDmGNCo4E3BuFGoGoFwjrxGYUvVNtVJncj1s4wrabrYqBoX92FzEyGYggnQCBPn+LFhtI2uGDIrvVLV4whj9jIvihvsOLGFi9PzLdIjFAFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZU7Ki8X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216281bc30fso13887035ad.0
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 23:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737013857; x=1737618657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlAVhWOyGlhyeAGODfEHHZ+7iZ/38uTw7jOCjj3glWQ=;
        b=NZU7Ki8Xx3Jp5rgbWyeAgYGrmw8qwCeEQ+YOUbgqgqxqAqW2CTQV/3vn0muH/uBMXl
         JbnksJd8hfXyWEpIv1sOgXlK5T6VRaBEiz3JRO+LCc1OIpXUArgbkp2Wx45djprwk3Vn
         uM1O1lWaEwtTYJtljEqkqtoHOprPF799pD5m/kASM8r5AX8in+/O7nOCFXPjKjybp8s/
         G+ewYygyxJr8oLb3gwoDfJi8OAwcJdCYwTLhDTmjOc6to7h76zGVWxHUcm5xJgVEv9gx
         6bCIOlTuhfav9bS7+nolHOKPA2bRrCEuHWYDny/Olgip4+dS20T8RsxZ+zSFHqhi5kuP
         ViYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737013857; x=1737618657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlAVhWOyGlhyeAGODfEHHZ+7iZ/38uTw7jOCjj3glWQ=;
        b=A+ylulkLV8Ar/jx13tzq46G5c8NwpuO0fJLhT20U60jZE6ElYQ5/CR1imJDW+Wpm6y
         Y55Od5eiUDdJm/mte46+80uQsV8FMfTtLdMHwh9lWQn/pbWBF2+X6R8F1k26k3y5nmHp
         7gnyxxS7KUKXgVDeWaDq9aaMFTuitZHTEj/aWw0gRKEQ2+IY5BJ7MwMsf7hbv5FfIrgI
         uJQuweHSwOscQKwlBdIM1zpoh8B59VtZzqY/VLk+6bzjvBGhOZASs3FHiNJXGAtujmDI
         UAisX52alov1XP9z3SFdlBhBS97/dAkvLNaUhz06fG53GOzgb4JcueDmZuUzRD0dhHU4
         3twQ==
X-Gm-Message-State: AOJu0YwnE8Wvr1dUjJ8TbuKM5XFgMnXkpVvfSC86HNV0GVG3ZI1LyD4s
	a21T4uS7KJ8XqbWAMr5od0fdXytJOJt8QyoI7nXgAiJ4kKf2+5EUqbNZNg==
X-Gm-Gg: ASbGncueEj2RQdhSv9KEk4oxitpOkMPCqTBMWMyHDTKDQZN/0P/Ms+Bv5Grss2wm4Qb
	Wc/kQ+Vybghf7C3CxrQuuya2TNFTj7SREHlRgGKrn7Mb8hMnF0B8BZsLYvAIoC7pVr4rUoS8xdJ
	6k8r+hLlhvXYzMNkexrz6lQ1w5zo0Qkfcao+yY/3zbXp8dLy6QHTtM3cZ/yK+nOurf1Xh18AG8j
	rqLkUu0JcDCG62HVTwb14EzWxfWmF13lg51BAuZlcHeD1zcLWI14HCWMkUEt+79FruZrhcqH/4X
	wh7PUdr9bYMZJT4nf3plF7VjnB18oEpv
X-Google-Smtp-Source: AGHT+IESZEeOG1h7WbOgSWWBDAQ+Tec7i/8vaU6Qu0mNpJxnMxsUicwuloE1zt7xcHaQOREWDrGQzg==
X-Received: by 2002:a17:902:f68b:b0:216:32c4:f807 with SMTP id d9443c01a7336-21a83fdea82mr503702335ad.45.1737013856942;
        Wed, 15 Jan 2025 23:50:56 -0800 (PST)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25cc1esm92120585ad.213.2025.01.15.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:50:56 -0800 (PST)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf v1] selftests/bpf: Fix undefined UINT_MAX in veristat.c
Date: Wed, 15 Jan 2025 23:50:36 -0800
Message-Id: <20250116075036.3459898-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include <limits.h> in 'veristat.c' to provide a UINT_MAX definition and
avoid multiple compile errors against mips64el/musl-libc:

veristat.c: In function 'max_verifier_log_size':
veristat.c:1135:36: error: 'UINT_MAX' undeclared (first use in this function)
 1135 |         const int SMALL_LOG_SIZE = UINT_MAX >> 8;
      |                                    ^~~~~~~~
veristat.c:24:1: note: 'UINT_MAX' is defined in header '<limits.h>'; did you forget to '#include <limits.h>'?
   23 | #include <math.h>
  +++ |+#include <limits.h>
   24 |

CC: Mykyta Yatsenko <yatsenko@meta.com>
Fixes: 1f7c33630724 ("selftests/bpf: Increase verifier log limit in veristat")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 8dcf5ee000ca..c72111dfb35d 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -21,6 +21,7 @@
 #include <gelf.h>
 #include <float.h>
 #include <math.h>
+#include <limits.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-- 
2.34.1


