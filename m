Return-Path: <bpf+bounces-45969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE3B9E0F78
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44753282FD1
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C188C11;
	Tue,  3 Dec 2024 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpJk5M+J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0FD23CE
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184166; cv=none; b=Jag4Hv+hgEXjxgOGmMVrhNY5X/wyaxRaXMq7Pk+t1645Ve5qctY2hLKQiKvspRo3aP4iyYf/ipF0fBH+3MYagbGOM9Iys/7B81XG+iOgr1TKcdYbw4ybrQCxgiOufBSjhKlHZKjoir4tVv08rSrUwwQdXBV9CMaz8+pZewi/Mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184166; c=relaxed/simple;
	bh=VVSnnd5PPxsbyeRoUs9dYQOdFuOdcxqauXYXxOFgJNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZQ5Bcw7ELjse7272EBUr1BjW2euD8fODbwXNYMe5EnMmuK8GUEaM5L+wdZKFHBqK2F1skAckw9xzBpI6ct8DHKOeT606BcQs42v6Y2pgKtoLJOlcJ1tWFnxiVsHuy4D/4uZhoIq6U1GekzIt3OE1rwuHQO3/U8lpIvUg0C8wzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpJk5M+J; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434a1833367so29057485e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184162; x=1733788962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLqPTyADr8UAmbhI/kaJVTbXI0NNMl4IlBiwUNjwiMQ=;
        b=HpJk5M+J+2Uq8zKI0SJ915LV6ZJFO/NbxUjDToEmBBUm8krose0pfDRIJdgz2rF5c4
         apCjKR66H/UWA2kkBhzW4KPQVk0IXlTukisV52YHNT22aUYo32SPommTC4CiPgMkjNX5
         OuPR0qxa288HpNx25JG6MS9ykhEdGD5qcfdrF2aLeZoqV4K3/mE74+4AZX4an2EMCNSX
         PWTpGzO9FxbuKeOFg7MCJ8efDWpSxx5J7Aj7eXTMsDc4wlCAj6VNd0/xq4eTWc417WGL
         BNJVu/tfhGnWLq2E7osKAYVRFS5JN3ZMgQorxyuLUks35ilkio3Zd+Ng0PKYmBUafEcG
         1SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184162; x=1733788962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLqPTyADr8UAmbhI/kaJVTbXI0NNMl4IlBiwUNjwiMQ=;
        b=JGcMgggNQ8X2R2Y2SkQJsAxQPyi/PnmKJC+otm3BboIwKIA1ck1Fxo5NNVkBbshB56
         XJh2Zf8ympQqhAnXtg0//9qAxGxeaxPVgMRtLdqwfuM3i93weUJksmJaaIiM6aH2EtmP
         sD4i86gCTxhGepKxapuzLqIRH2uwBvq93boAREMbVLRxcOn9CAIaDnqDizpdq62HX7mf
         y0kJ+mbDVi7MI9ovJPTWkVCQe/DOk0ZSP5rRI54UMc1+CTZrdMj6c2162Be+4i3OFvdF
         Kf/9AZXjXH1CdyO4KHIJy8RsAFRJVKXBRCIoADCu1af+df+SDqFgcbyccbABsrskVwFe
         A5NQ==
X-Gm-Message-State: AOJu0Yz3rbDgvU+fDK/tZINDkK0I6I3zbmMwfWaR5hsfRy9FTbw7KeS/
	5RqFvN+QssVtRbplKr9WokzZCIbYa3JcrikEH+n1/llBmofr8KXyoJtHxTcadmw=
X-Gm-Gg: ASbGncthtHpD6NywOu0ixZaD5R10/wDnKGzbMXyDaRomWmLX295HOztuQ3ZJ1SZJdRH
	iXUBj0M17nSp92NMnTdcsC5tArMtXOHq3OlXGxWu2bFZQ3hmCel55j75WCMZXLIljiGQsdBOE4Q
	zgRjr62EMF+O4Km9eTYXWquz3ixBWCI3hq0Kn3iDr30uj+ba/z88JDbYBIxaHSjMPDpvk7lCk4K
	Z+9pAnrPrJ2i8kNLoAjlgsoRO2r3bl8P96uC3SjFD1B5B79fVUbinNLy7FEkkrKl0N1E9dYCXCy
	LQ==
X-Google-Smtp-Source: AGHT+IHkgDlhO4780xHhcmj8ZD+AGbtmDVfMSC85oKS8WksC9g0TnSi/pXjyq7DJmmixS1vjVkKTvg==
X-Received: by 2002:a05:600c:3b88:b0:433:c76d:d56b with SMTP id 5b1f17b1804b1-434d0d63ffbmr1982625e9.12.1733184162303;
        Mon, 02 Dec 2024 16:02:42 -0800 (PST)
Received: from localhost (fwdproxy-cln-033.fbsv.net. [2a03:2880:31ff:21::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f327casm171897475e9.27.2024.12.02.16.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:02:41 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add tests for iter arg check
Date: Mon,  2 Dec 2024 16:02:38 -0800
Message-ID: <20241203000238.3602922-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241203000238.3602922-1-memxor@gmail.com>
References: <20241203000238.3602922-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; h=from:subject; bh=VVSnnd5PPxsbyeRoUs9dYQOdFuOdcxqauXYXxOFgJNg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTkjeDgupXJk+tPJ6UVIPrYB0L6XfIHP2RWidRQMu D7PPcPeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ05I3gAKCRBM4MiGSL8RyozOEA ChHv7SDkvGSP8hrXKwFZf5PzLMWXu+6S81fzFgFo3OFgE/7DQoC1jazBYhURnth5e31wWi7V7BCcab PZoCwZDHnjr+3KiZQd/wCBOHvF+Gv65Gampn9gtg4VxEBGVTtTFXkuaRN/RVM3yCi862TO4nnVjAg5 Z/EO7lNY+qDpmLLQ1Wh84cMSmmoSR4g+3Jm7C/7eP48COGYckZ+UtdNnADnazJAA0MlfJeYmxDrUy/ elLv49370kmG2DF6ZIRXl3eezKWoDB2DoFGt3is3uYP9D8yP4NesWCgMSx8gT5ZVprjhempfD+n2mA asX0rtHEsFja/IeTjzbfeC1uTBjcAhEA6fWN9mzPzukCYetQgcv2CyX+M6eha/VE9YmmI1vkInkGPv QhyfbvqR/z5i3KcvrGgNi38QIMJcSPGBHFtdgPX9RM8h7nMI7Ky8+Fc2EKHel5X/WEdl0DBsy3B43/ f5jQFStTWMgtgYJICPWE3QN7L89Y2cOasezrvuhh4RlFW0pqdef0oQVbB/u8A5uP+E+ueXGs2KHvCw WWOHFP9IluQ7J+THHSqYf1vBOOOV5YhmjfyXbwqTWV0Ni65TcDrM92i4MaqDOT8B1iXFVznRREU6DT Dgm1o95vyHLplBQMqwgq8p5J0jFkBEu6yr90SN/5NfMADRkyDVzDrPYXjyGw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests to cover argument type check for iterator kfuncs, and
cover all three kinds (new, next, destroy). Without the fix in the
previous patch, the selftest would not cause a verifier error.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ef70b88bccb2..7c969c127573 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1486,4 +1486,30 @@ int iter_subprog_check_stacksafe(const void *ctx)
 	return 0;
 }
 
+struct bpf_iter_num global_it;
+
+SEC("raw_tp")
+__failure __msg("arg#0 expected pointer to an iterator on stack")
+int iter_new_bad_arg(const void *ctx)
+{
+	bpf_iter_num_new(&global_it, 0, 1);
+	return 0;
+}
+
+SEC("raw_tp")
+__failure __msg("arg#0 expected pointer to an iterator on stack")
+int iter_next_bad_arg(const void *ctx)
+{
+	bpf_iter_num_next(&global_it);
+	return 0;
+}
+
+SEC("raw_tp")
+__failure __msg("arg#0 expected pointer to an iterator on stack")
+int iter_destroy_bad_arg(const void *ctx)
+{
+	bpf_iter_num_destroy(&global_it);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


