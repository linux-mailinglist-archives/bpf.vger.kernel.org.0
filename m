Return-Path: <bpf+bounces-44945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C329CDDA9
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A89B22B0C
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803881B4F21;
	Fri, 15 Nov 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbMjIjK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7518871E;
	Fri, 15 Nov 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671132; cv=none; b=LloM1wp4NFa82ulw5ziK0GHDJr44qbvEww3m77SoJY5S+baecBE+3iwHZvmdVerlcjd//GnLLq0VIQeRxhLqCjl2ilcq1zskfe+NTiCDjLcqmuk7eeD6cej5Rdhbhp9YytjQUIGBvx0C44Kw4U7kmIR+At2jOKVmYoG6c3ykHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671132; c=relaxed/simple;
	bh=xGuzkMxDO+F3Rehl/23Ny+lunu3NLkrjLfDk/TbcNEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhjvljCI5fcSqHYd5LVrjVKR5eL0MmqyVaL4dhbfyozcZwHuBIic1A+S1EfCKEFrcnAsrzpQCBi4ZmqUs5F0pQFo3S27JGBDw9SVMbQr8NHO2jv1QUbQg6XgBI30ZURg/SAkqnaflRfOKRMRUUSiFQ8uGMp18tBEJa3mWOlidTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbMjIjK8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43169902057so14030785e9.0;
        Fri, 15 Nov 2024 03:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731671129; x=1732275929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzc1r6b78LAiuytUC+As0bITf0u5NeHauNj5GmJJ8cs=;
        b=KbMjIjK8xYBwbmxO/2TiSaL+rSI7wH50ZPZgy+uzX90kXynoNnvmYYMZwUf60CmgW+
         P2lqQSmRPkzLQhEnXzXUI1LlSAnwawRqGERYl6gBx0akC6RRhJyuUrg4ycg1FjMiCaQo
         aWjfDoteZq8kNHvlYYIY1KCPRo1MSPdh71lh3xqLz1ga2GxJZDvHASWFfh6ntDWpR7yn
         kRvhn+rFaqGP3PNSGvK0IU0fbjts1p8cSDCLSv1QevKGg/QIqRFbTxpMfBuBjWSeOLMs
         6OwWDAbwLtleaSvwpr/daM0H0lsD15tGj/SboNEheOqpi1t4oRhHU9fb2JLvnLdRlltz
         NcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671129; x=1732275929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzc1r6b78LAiuytUC+As0bITf0u5NeHauNj5GmJJ8cs=;
        b=OnTHCOdzjOKJrc/X6z9I1gJ1/rWMB9F7FJG2hoA4WCx3cUK0HsaIHACK4kMlltDB55
         cgOrmhEp4Vspff3IuD0hhAMuXBMdKLafGPjNeKcJEDgXkk4qRLRL28HLceLwHd5kXun/
         3wYUbqmU0F/VHYrDZlSyCuQUB+mqz1eLw/7Z2SWo07xl9r+V/pskWHRo3h0dNOvDARBB
         uag8fc7EkNTQ4FXyj1x2ItZ8c90uQSAJRPk4lfNQu4WhuTIxthIu7Hl51EXbERtJT5wk
         1gH8m1dVlqCwOSzx+bCkrS7q/y4t4K5tMJh24GLHcASKrwLVIU8Q5u1U3yezK51O1ogV
         YqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCFnzm3KVWTlNEwPGnwnGzletsIFD126WppECd52EaWld74P4eHT0QRU7meXRUE8s0NTI=@vger.kernel.org, AJvYcCWDTrNGruUBgtVsAaMf5WecYfTSDo6xvLePLdZykTnOouIQbT8VrJ00EJy2kJU1/akvDrsA4XWigTwfja66@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzt3KkqaMNu8sSsIQf0X6lx4T5fEF0EdxF5P4aGc34fRP6gqu/
	Ii6qpjkLVehylB7HzXZdYUo0NlZqVTGx5Gsy8VpxeXiHS3PSpJM=
X-Google-Smtp-Source: AGHT+IGPNwUnfCard+9TZO605jPVU79JEDGb94F5QQgc7VL7/oLVfn6eejgrFu6pxqfA3pKJKosKWQ==
X-Received: by 2002:a05:600c:35d1:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-432df72c1cfmr19249825e9.13.1731671128528;
        Fri, 15 Nov 2024 03:45:28 -0800 (PST)
Received: from qoroot.. ([2.181.242.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d4788a31sm50500545e9.0.2024.11.15.03.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:45:27 -0800 (PST)
From: Amir Mohammadi <amirmohammadi1999.am@gmail.com>
X-Google-Original-From: Amir Mohammadi <amiremohamadi@yahoo.com>
To: qmo@kernel.org,
	ast@kernel.org,
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
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Amir Mohammadi <amiremohamadi@yahoo.com>
Subject: [PATCH] bpftool: fix potential NULL pointer dereferencing in prog_dump()
Date: Fri, 15 Nov 2024 15:15:07 +0330
Message-ID: <20241115114507.1322910-1-amiremohamadi@yahoo.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

A NULL pointer dereference could occur if ksyms
is not properly checked before usage in the prog_dump() function.

Signed-off-by: Amir Mohammadi <amiremohamadi@yahoo.com>
---
 tools/bpf/bpftool/prog.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 2ff949ea8..8b5300103 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -822,11 +822,12 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 					printf("%s:\n", sym_name);
 				}
 
-				if (disasm_print_insn(img, lens[i], opcodes,
-						      name, disasm_opt, btf,
-						      prog_linfo, ksyms[i], i,
-						      linum))
-					goto exit_free;
+				if (ksyms)
+					if (disasm_print_insn(img, lens[i], opcodes,
+							      name, disasm_opt, btf,
+							      prog_linfo, ksyms[i], i,
+							      linum))
+						goto exit_free;
 
 				img += lens[i];
 
-- 
2.42.0


