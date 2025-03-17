Return-Path: <bpf+bounces-54244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE9A66180
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 23:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DCE188603D
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366111FECB6;
	Mon, 17 Mar 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QB66/3Ox"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E953202C47
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250269; cv=none; b=DN95E5XLS9G/ekfHND5IG8xKzMwfkrkh6sBzI6nXvUo40x1HNOuuMhtYzvnNxYHZS+qlGQSNE5P31DuGDkQD0s6Fuwt1T6LOfg/+DvwvxLAaLg8Y1u+8ARv7JxtjRWDfi7H1AZOvh6iaGAGaiYMd/odIO+7L+WNc0eCmEvXVIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250269; c=relaxed/simple;
	bh=rKlaSfeOL/ClT9nMnyH/t8r9RRBB2gXlo6EGvOf05qo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=McSBBY8RjwiUbWC1DYNi5nEIJ13Yz78hnhBIZXPwDJ12wRqw4J/9wZad/ojjYPqZjXxcQT8FBU5CjiTQGglCRMb3T2Jh4RbYpUbHASUXAm2kQbwdTtJAZ8CG3Tl2DURNTzfkChDFa0aYnnGEirwyrgitpndgqlWyuoEUnKGrJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QB66/3Ox; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22410b910b0so63110955ad.2
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742250267; x=1742855067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bppswTLwyuw8FSA9NviSJa6kYnh7VslUHPOj1zMFbvg=;
        b=QB66/3OxtE2EXe+QHDEA0lp30gkm9Ub7TX+lqx3yOC7O67vRx637qAMT1Qkl3S3NdC
         aK6AZOF8v1t5w5ZhW8juQ2MhSrNPwvGWykIqygaN4rzQMZsUvtc67s+93j5S/JBWtfhf
         R5icDAaONiFDtEaLC/K+h8HAzNjahgKM8nLZ/DJzv4R9QUuzTIL65x4BhPfHGF558lJD
         UtC9j2WDvfGV2tihaeZ/uWIA2Dn6/P3dEVWCuckbl37dCdgt0QohPoWLjXqTFE24IScd
         ryIeVZV2Ama+ohxQhyMR7sRquNcOzEpanzkU/JExCiEOJmsjWB4etXsxL9RISXzogwtt
         hCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250267; x=1742855067;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bppswTLwyuw8FSA9NviSJa6kYnh7VslUHPOj1zMFbvg=;
        b=ENln5ZhYOpiSu0yo6RbITHwsNw0rMWKQOOOVdJlz7c5vdea5+GGBjpuxE8yPcQ0wLC
         QsvPVSJgNlvyIbMSmYdSG8d/qwx4LLtFtMvZHBJPOlYQ2OxzJmvkF6SWsluzTg009Iv4
         l1PTMHlvwRHVOhivOd1QbXbYZQ7S7ASWP1n6741wNDJBWNstYNA5qEcjM3eRhcNUXfIB
         15Qh9x1U4dwn3cECaggE7/xMuAbOq8kshiKe76PEVIfV+D16MkyDHBIMM88ziuCWmTTP
         jamJe+V9Qk46X0eNRnBMWaa8az89mXqHWXJk6Ji9g7prUMV+e58JouyEBgbsDLBrJLVG
         Y5oA==
X-Forwarded-Encrypted: i=1; AJvYcCUjiKBV1ToabxLR+UhbcTwKI+i6j1w0N742Zo9SxzA+k3Z2lEGTYxVxO0HeMZeqCQdDzOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcczfybs8G7U1zw5tnayX02c3Nfc6w9V2wsaSqUm86Q8CH/ZNn
	GU3roo919OliQfXSrN4nDE3jykrg1sirXyfyBd4rF++QR4rFKz3N69DRNr70PiX2IDJ31KYfw/1
	d302tyyQEydxuMeZQ5k9YGdkQgg==
X-Google-Smtp-Source: AGHT+IHLmcNi0Ym0nS0iDdRoTURL2g7j6W6DLmylxhOIm26ynKdWVbz34Pa3vMP3oN303VoxmlsPmqhIQ7I9p8ETbhs=
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:2ff:6132:8710])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70c:b0:225:ac99:ae08 with SMTP id d9443c01a7336-225e0a288c6mr192303765ad.5.1742250267625;
 Mon, 17 Mar 2025 15:24:27 -0700 (PDT)
Date: Mon, 17 Mar 2025 22:24:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317222424.3837495-1-samitolvanen@google.com>
Subject: [PATCH dwarves] btf_encoder: Filter out __gendwarfksyms_ptr_
From: Sami Tolvanen <samitolvanen@google.com>
To: dwarves@vger.kernel.org
Cc: acme@kernel.org, yonghong.song@linux.dev, ast@kernel.org, 
	andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, song@kernel.org, 
	eddyz87@gmail.com, olsajiri@gmail.com, stephen.s.brennan@oracle.com, 
	laura.nao@collabora.com, ubizjak@gmail.com, alan.maguire@oracle.com, 
	xiyou.wangcong@gmail.com, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr_<symbol>
variables are added to the kernel in EXPORT_SYMBOL() to ensure
DWARF type information is available for exported symbols in the
TUs where they're actually exported. These symbols are dropped
when linking vmlinux, but dangling references to them remain
in DWARF, which results in thousands of 0 address variables
that pahole needs to validate (since commit 9810758003ce
("btf_encoder: Verify 0 address DWARF variables are in ELF
section")).

Filter out symbols with the __gendwarfksyms_ptr_ name prefix in
filter_variable_name() instead of calling variable_in_sec()
for all of them. This reduces the time it takes to process
.tmp_vmlinux1 by ~77% on my test system:

Before: 35.775 +- 0.121  seconds time elapsed  ( +-  0.34% )
 After: 8.3516 +- 0.0407 seconds time elapsed  ( +-  0.49% )

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 btf_encoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1bde310..2bf7c59 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2239,6 +2239,7 @@ static bool filter_variable_name(const char *name)
 		X("__UNIQUE_ID"),
 		X("__tpstrtab_"),
 		X("__exitcall_"),
+		X("__gendwarfksyms_ptr_"),
 		X("__func_stack_frame_non_standard_")
 		#undef X
 	};

base-commit: a0be596ae76c720d21eef257dec1cf2462130da1
-- 
2.49.0.rc1.451.g8f38331e32-goog


