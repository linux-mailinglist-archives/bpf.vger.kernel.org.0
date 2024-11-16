Return-Path: <bpf+bounces-45013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87F9CFCF0
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 08:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACAE1F24D4D
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376019004A;
	Sat, 16 Nov 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnCUPjX5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BAC10F9;
	Sat, 16 Nov 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731741250; cv=none; b=lXbwbiUF+lKcbwWpgv5trXYyH2f4dp1R+2KOjeDr33+j9KAPtsYJfopS5ErZSdYsQLEfgOfgvoozOCCSWReNGfaNxB1qMjeIUrNZAqDtxClFCF3IxG4R7pFwvxFq5LiX/bih11dOGtMtZquzK3JG+w5UW3soXiqbeLDNtaT2TAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731741250; c=relaxed/simple;
	bh=gHjzzYf64JH5t6/OfXvNtrh+s30Y+a6d8u5n129b2YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbPv8z5pVJSmgD7DNhduFxARAp9c65KbfqbgZpXAJbL7FLUwPq/GVpG3cAn2BgEpN3N8BkuxadRgsETr4frPLabtqV7hhatVIhm7wL59hul5kwrrvsnCIEhawAys4vSOmosR3OPG+iLC1R+ktncNTjsyvYIJ4eNuC0esYoU4MVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnCUPjX5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38231e9d518so493143f8f.0;
        Fri, 15 Nov 2024 23:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731741247; x=1732346047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky6ai1Jh1s6fwaQ538hBKuOPeo++ZlVzBLCCCuBMY88=;
        b=RnCUPjX5URlu0jqMqPZboipvqyqnlmx2a37s+xnZ3JB5b9ZjpEjl81AFdckbIZz4Yt
         wGoW6Qv38qFK5VohgO7NCHu5/wK9NVsl76DU/SwOpvMSLw8QkGbdHRyZjyqIKRCAuQS4
         VfZ5uD+sNYSJhKDulozqt4ysb/Gydmbclh2Z0XA8fMNHLFNV4UaXMD+YHFteMMzSpI/K
         cfwubaARM+bD5zatF4eBnNwW2xGm60SS/fq529+RSoVVxPJvS/qJwS37buD844dj39v0
         iZRsNP2df6SEAx8Xr3dcnsDmEzStM/eSiVgfnfmeuK4b60VU2bL2TKQ1hLx9eTCKkPvy
         WmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731741247; x=1732346047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky6ai1Jh1s6fwaQ538hBKuOPeo++ZlVzBLCCCuBMY88=;
        b=gysgt+HgQXFcFBzpu9YnLQAuyZgDn29ZxqJQJgcG3BB8vrhQKuzpz+Cs9D3IqZEfFc
         6516FalfFa71hhEC43MgfL69uswFyHbSMOsc9+S8jncC6cI8K1685kEwCuYOYDjrbm2I
         oLwLyg+6ofijmOZwbZCAaNE3gIqJkxDCEFgfzGDJOUDwiVb+aFDIbot7d+CAAgoZE7by
         SIV5XHJXRZtjfAJKBYfmB+MsWCVOlB7rOEoLgGgVQ/nNXNWmZvpMNZ4pDtOLDDdiNwdo
         /P9q7aj3XMCZg1c0xBYIy0sY0kGt0EKwC4GnTAmdyVfPFnvMEOkzle+Jd1aJCBaH8Zu0
         my/g==
X-Forwarded-Encrypted: i=1; AJvYcCWIXOu9un91UgUH7IBMsDqNJrxccnCFX+RVFfzHlYHLAxT6WgX7C8cahlTUUy5a8/2OWp8=@vger.kernel.org, AJvYcCWPUkPb/EzIep34hBrE2/3XX/2M8PdEY8QI8KuWFBvrHYLXhiEIxLgKd5jYwKwPteciEvZn/JB5lc03oNCm@vger.kernel.org
X-Gm-Message-State: AOJu0YzRj3YSuVmUrnRWo+rfD41boyu3ad3Exxu/6HyzSlrKbjjUIc9f
	wpkC/oexZ+2c4Ka+OP45NPkYu5Sg13g2PgYP3qZPonrKWFd2Png=
X-Google-Smtp-Source: AGHT+IFMYcg/vrpa1XK93IYG62K+1//cOQ1DqPDnAC23d6IHrRgk80Mi+m8ErFf4B8jpab3SbJaDJA==
X-Received: by 2002:a5d:5847:0:b0:381:f5c3:1d02 with SMTP id ffacd0b85a97d-38225a91e8bmr5142684f8f.44.1731741247391;
        Fri, 15 Nov 2024 23:14:07 -0800 (PST)
Received: from qoroot.. ([2.181.242.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382308532cbsm2370905f8f.88.2024.11.15.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 23:14:05 -0800 (PST)
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
Subject: [PATCH v2] bpftool: fix potential NULL pointer dereferencing in prog_dump()
Date: Sat, 16 Nov 2024 10:43:46 +0330
Message-ID: <20241116071346.1412266-1-amiremohamadi@yahoo.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <47225498-12ab-4e69-ac50-2aab9dbe62c0@kernel.org>
References: <47225498-12ab-4e69-ac50-2aab9dbe62c0@kernel.org>
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
 tools/bpf/bpftool/prog.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 2ff949ea8..e71be67f1 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -822,11 +822,18 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 					printf("%s:\n", sym_name);
 				}
 
-				if (disasm_print_insn(img, lens[i], opcodes,
-						      name, disasm_opt, btf,
-						      prog_linfo, ksyms[i], i,
-						      linum))
-					goto exit_free;
+				if (ksyms) {
+					if (disasm_print_insn(img, lens[i], opcodes,
+							      name, disasm_opt, btf,
+							      prog_linfo, ksyms[i], i,
+							      linum))
+						goto exit_free;
+				} else {
+					if (disasm_print_insn(img, lens[i], opcodes,
+							      name, disasm_opt, btf,
+							      NULL, 0, 0, false))
+						goto exit_free;
+				}
 
 				img += lens[i];
 
-- 
2.42.0


