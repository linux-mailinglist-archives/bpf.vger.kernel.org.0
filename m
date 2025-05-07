Return-Path: <bpf+bounces-57674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B73AAE791
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010C33AD877
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1028C5A1;
	Wed,  7 May 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inKOLbRM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1328C038
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638250; cv=none; b=fHShEJpJJt6N7ipBwnQpLYWjGLxHEc8eGK46JIRHfl+P+PiNDudrYafQ2924tOKBUh87fSvyaNFdW073KJU4Ui3jywMUV5KAsiBzH4lSvj5Fk2zVOI282gqVtJ5aYtblafZOIOJUYq0Ow1sXag1E7W1OdUmH74SGrj/ap5LoH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638250; c=relaxed/simple;
	bh=kVv0V8r0odwAY6+TUQh2bLQ+8M1Wx3xmGxkEBSuPkd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxYonuGLOOCK1h7rYlmoo+MWwGz1jwZ24AIyb8M3hXLucMCykFqGIYy6zyI4MCZv+7v072usZbabi3nCGe7t7noEp1n9/PvPSJahDoCTdAZ7VfPKQ8k9A88f8kuIl/va0qP6wJdS5khMFP27glM4j6h5Jg3YG6+lVc2OAndfhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inKOLbRM; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso119511f8f.0
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638246; x=1747243046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PYveTHr/ImOxVGiQ4nMgSvEwlLAJ0iXdsYxws/sFps=;
        b=inKOLbRMJQkWrsFbJb3WVeMpiYir4KLTWF1+kXgjc9DyB7637rprJCoOv79PxhVOW2
         GZs9LvI/hqATunsRJ00eH+UKN48X4tUTpCrtRh1HJK8gm4OI9jUYlz15wF43vG/mEUqT
         9ZUeP1gveeFxAoKSgLIluUK4VRxG2p8WTudxwoYmQZ0cofysTRqbq8kcE1789asIlSZ+
         ItSOfOt2kfP+8QdP9WpClsCqxeKO9imrP1xnMWgIUlaDhDjQ3ovLSEay/FV3or/gHKkB
         tFwsvHveD3xLiGllBEyCG096EmXVcLiLCstpOUldpYOiV7aWJuEykj0nZl3nMfxlzaxB
         UQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638246; x=1747243046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PYveTHr/ImOxVGiQ4nMgSvEwlLAJ0iXdsYxws/sFps=;
        b=adcjhjpYnkK1xgVHQES0NjcWVxnqw4CSz/TGr8I6GGZuW4R5l4GklOBbFoJk5XK1jT
         lq3Kn0wzk6z5YOf1ztoHfBz+xKRjQV5+mLBaGAu1TfFkPGaKCdFrsTvCzJyRRE/umB1C
         5sXLgnMnE2EKtzqjhLV9mESbuNOITE+2rxCSbI5b538tnJUYasEW5/hIdqDk+qJNUzmA
         nsDP6hzsmmmHFpTTN7tVLAmY5+Z3+CygnXH0AaNt2zNrLzWiodBFFKdyzh6R3t5krNss
         9VsIxL37EM15gkOfS8+berN/IfVZPEJC1e3jk1u6/JpIALmMP0MTPp7yoS89EBDD96pL
         Ya9Q==
X-Gm-Message-State: AOJu0YyAUFtMDwwTqkrkRb9LCDFfs4xbn/GBE/6Ue5hVAKX8l2B16MSv
	Ges2G34CT9QylTHJC4nJJ4qsmj2Pe086sLmkwQdqZMK3mUcLPcRnmg6Zcd5bh2k=
X-Gm-Gg: ASbGncv+ZOy57aTTKRn0+q12S4QnE6vZ8VfkgaTCPlmkMb0byWAwd2Oj4OoiRzptiYJ
	nMRpz/k1OSWKSsM+3t+W+Rd94gXuFmarA6CBpemOyvBj0n3hkYVdJ9Xzcl3d3kY4U+li6rC5TEc
	l4J6uGNHiF73ov2AezFoUgdi9Um6PsYLb03zegTMIJjGlZCiCZmXvb5adml+1GpMaivZN0Woekr
	wv+6xw5h+Cis3QcUKfvuOpW42MeMzlycRI6rqbxF8vk+7GSWAif1GYWMi+22t11D55KcGC/Fs7U
	6GfPWhanNGUanWQQfeRLEBPo+TI2FTM=
X-Google-Smtp-Source: AGHT+IE0mnNGh1IISHGu8jciBRbRDMaPUlV4eT6WhdsqWG44aPJo+sWQzIIZwzbmGvUNXpcoj/4vJg==
X-Received: by 2002:a5d:64e5:0:b0:3a0:b72a:b27 with SMTP id ffacd0b85a97d-3a0b72a0d9amr2314550f8f.56.1746638246441;
        Wed, 07 May 2025 10:17:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c48sm17415838f8f.8.2025.05.07.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/11] bpf: Add function to extract program source info
Date: Wed,  7 May 2025 10:17:12 -0700
Message-ID: <20250507171720.1958296-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; h=from:subject; bh=kVv0V8r0odwAY6+TUQh2bLQ+8M1Wx3xmGxkEBSuPkd8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WJenEdru8kQ3GnMqCfXgZ3dT4Ld/HQdvULpVMx qVDCjECJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuViQAKCRBM4MiGSL8Ryg55EA CLjvxF7wFe8/nVifRnTd1nXjbDI/Yv4iAl131eWmiM7uFbgx1DyoNWVIZ8wLlpKSwi1LeE5RkGDxjN LAiISGIyAAf1ihcZfk9RcGL+die+5IUVsNgzFeRkA4FDQ+/drzMH0GBzVyRox5Zo25yB17574bhfXP LqoVeO18qJXPv9uzguyAtmFnFv3pZ01iL5PlPug6MdzrmacWfu3SrCWeuVzrdMXP8etJwYf1+XlsJG nVs4/NIvoXjxU0hqz5kKfO1jYkJN+8DjcXFSiTLcctXOljduHq5MNh17BsM60sJLH7xt7mIPa95CYq airvhRRreCXXuwPL4yWgrJ1jhHfi0mTuEwQtbZMD5TQZJwPlcStn6siElFx89Q6SNhfBx/KXVI9Gc5 StMwIaSCoRZty8anxOpDW8JCBEKLd8eTjjABWzJ2xNyenz8qB5ynoLutXhUhIIUQ7R/5rMBLY1p7y6 n6wfWxsKAmqB7e+q2olxr82bqxdZpVMK2iaK+lVo9vbMbPttamBm0a6rnLfFx9eyY/cUc9jWFbnVYg D6o8M7dV5nLXo/AVKay6/Mnl5cjYnMCf51Lfm10yMCZXMVpaZwLb2wIaNSUzULDu+TGKKxK+x4hvcs wb6ZlqxdBp/z4Johe1SciQwc+wq9KOkOhY7yPEY/Me7tuyHdOsBmnP94aXOw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Prepare a function for use in future patches that can extract the file
info, line info, and the source line number for a given BPF program
provided it's program counter.

Only the basename of the file path is provided, given it can be
excessively long in some cases.

This will be used in later patches to print source info to the BPF
stream. The source line number is indicated by the return value, and the
file and line info are provided through out parameters.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/core.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2c10ae62df2d..f12a0bf536c0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3644,4 +3644,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep, const char **linep);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 22c278c008ce..df1bae084abd 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3204,3 +3204,43 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
+
+int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep, const char **linep)
+{
+	int idx = -1, insn_start, insn_end, len;
+	struct bpf_line_info *linfo;
+	void **jited_linfo;
+	struct btf *btf;
+
+	btf = prog->aux->btf;
+	linfo = prog->aux->linfo;
+	jited_linfo = prog->aux->jited_linfo;
+
+	if (!btf || !linfo || !prog->aux->jited_linfo)
+		return -EINVAL;
+	len = prog->aux->func ? prog->aux->func[prog->aux->func_idx]->len : prog->len;
+
+	linfo = &prog->aux->linfo[prog->aux->linfo_idx];
+	jited_linfo = &prog->aux->jited_linfo[prog->aux->linfo_idx];
+
+	insn_start = linfo[0].insn_off;
+	insn_end = insn_start + len;
+
+	for (int i = 0; linfo[i].insn_off >= insn_start && linfo[i].insn_off < insn_end; i++) {
+		if (jited_linfo[i] >= (void *)ip)
+			break;
+		idx = i;
+	}
+
+	if (idx == -1)
+		return -ENOENT;
+
+	/* Get base component of the file path. */
+	*filep = btf_name_by_offset(btf, linfo[idx].file_name_off);
+	*filep = kbasename(*filep);
+	/* Obtain the source line, and strip whitespace in prefix. */
+	*linep = btf_name_by_offset(btf, linfo[idx].line_off);
+	while (isspace(**linep))
+		*linep += 1;
+	return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
+}
-- 
2.47.1


