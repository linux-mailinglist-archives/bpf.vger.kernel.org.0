Return-Path: <bpf+bounces-47529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C09FA290
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 22:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBE71671B1
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 21:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3C1D8DFE;
	Sat, 21 Dec 2024 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfYTJdk9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49C186284;
	Sat, 21 Dec 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734815383; cv=none; b=HFXb0vomghNNz5u7Y7kuUMofEtYEkCoy5hS/cWRDHVtMl7Jgd8QlyixTHBh0j0zSFA7BbnZASeLYHG1xB7ud+fAvN8AmhfFZM5iYNb2qmAVj6Fqien5xYHRI7uU7k63FIqM1l2GqBeVgJxaYfY1SJbdX1lCXcxi0dQfkmgQqKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734815383; c=relaxed/simple;
	bh=TzF94QgXzQpaPKyt9mrR4VL7WfvLEsI7X97HOrLI4uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6qOQPiy1nh0lOTtLPBqPJxeOh6MIhi3iHVdMoEn2YOWeHAQ1QMUHRYctmGiqQcoyPPBPY/4BcQI40FsIFodHOYZq/e130WNo9T2Gv2QYJzt8TBu0vraVZlbGzHEeyqjmhKq8LFKI3pKlT2epfVtVF26tLI3NfIxUouyxORZhak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfYTJdk9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2716277b3a.1;
        Sat, 21 Dec 2024 13:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734815381; x=1735420181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNsyydIwl66sSjjl3CYkU8GYTKtrGgErrtD8xsFywJQ=;
        b=jfYTJdk9gZfWKF+01m5xk2hXhJVrdeakrbp2knl0Dz804xOvk85JKJqStL3hf+ch7i
         8vrqaqlxVoRkhA3fkHWO/PzUR0SE/rFSJU1ns8ZX9CxZMrMl+IvLoh89wHVCicgHH/eZ
         yu9Lp0l/Yc4t0ijNzCW4d8QgC0Y7JYGPMgIABFCm+2R/NaK0JJ0poyOCNSHxjhUXBMLm
         QkE2cRfHFAWvfPcWq4CaH0nGVrd+Zo5LvE6Ig/wUQy/yH1q8AwLHKMjBJh2xY7akq6lY
         bCDH2Gm++ki5274c/jLlbF1WLRuxJaVMVZdCF+m2q4perOu4/ZHmxrTh9VPyr6nh7UFP
         4x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734815381; x=1735420181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNsyydIwl66sSjjl3CYkU8GYTKtrGgErrtD8xsFywJQ=;
        b=g21r+wAnhynDMUKxQLN7MkT8bw4+INsU8v0pAmelxRais+TuliVmrsVV3aWMm9VKh/
         8sth91CZtOS+cXKyiIT7FX/lGcE27pa97KBuOF7iJwJ8qiHNmcaIumJPv7eaSyjZWWDT
         Zuu/ucSuH/zuHUqV8wOD035345RUkG4/ZF+svYmj2oHCEKDIvdzT3RpSokYH48qZxHcL
         RQH2U+AbdsdtPyDZkjGpboqNu/g/Jnr0JrJcaif7crPTYos3zdnvpGoET5XtOXLW3yZ9
         TyFMOP20USD17L7G2+E8iZnB1oTI8tZwKkS9WCBCqPYAttjiMKcb8FeUobDJ4YR1DSBK
         WdLA==
X-Forwarded-Encrypted: i=1; AJvYcCW3jTZpzwBU2UoP7trHNffurQfFfqy4bsL1LficyxX1jIBQWtItjlfSEaRMn2ooags0GPdlyzRpYbKqrHhZ@vger.kernel.org, AJvYcCXeTgginsJnrFw8Xg1bl33tL5nKirXJNGBn5ctxNMyfH6fHDHk1WciGEHL2veTuKwAy3UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4G1RohywgCpmbBspA7eM7MtHeKijWY3vPlbdAdlTg1ew6COzZ
	89/x+6If0tsBykVAEYAhfafBrD6XsGs9DoSdbQvX1aXNfJvqEbi7OyeqMX5L
X-Gm-Gg: ASbGncu1ec03UoCa/PZiqGliOIHcULjyC8SLJ+6WM3BbISKZhccoYAzX8xjcymD9bxq
	ZF5ibCXzE2lZoiIlZ2topBm8NWoeknTql4zlgUP5+jALd7gOwjrpA2GNR36ENg4tPIpJ1gJ5EKv
	YQLIKf1rb4kYvxOI9Oe7w3LbJ3OrgYPgz7/mfF4pZGq/JWQV2bHzt6zRH+yyijAdc8WwQG/vUuE
	19ZN7ZLZ77KJtvoAb2jiGbEU4+7nAcBL8IxFjkzMUSNqxMib06DJv9FdbUvmlnH
X-Google-Smtp-Source: AGHT+IEUzPseeNABgve4Ghb9MV+7KJwXTJA7ByjQMu+ymS48utIN51kxDQnGNjcLRmzxWrnwlED7aw==
X-Received: by 2002:a05:6a00:ad3:b0:71d:f2e3:a878 with SMTP id d2e1a72fcca58-72abdd3c2afmr11600253b3a.5.1734815380828;
        Sat, 21 Dec 2024 13:09:40 -0800 (PST)
Received: from prabhav.. ([2401:4900:883e:5fa8:2bac:ed7e:8aa9:bff5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbafesm5286709b3a.128.2024.12.21.13.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 13:09:40 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
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
Cc: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH bpf-next] BPF-Helpers : Correct spelling mistake
Date: Sun, 22 Dec 2024 02:39:26 +0530
Message-Id: <20241221210926.24848-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes :
	- "unsinged" is spelled correctly to "unsigned"

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 532ea74d4850..1493f1daecaa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3057,7 +3057,7 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
-/* Keep unsinged long in prototype so that kfunc is usable when emitted to
+/* Keep unsigned long in prototype so that kfunc is usable when emitted to
  * vmlinux.h in BPF programs directly, but note that while in BPF prog, the
  * unsigned long always points to 8-byte region on stack, the kernel may only
  * read and write the 4-bytes on 32-bit.
-- 
2.34.1


