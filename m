Return-Path: <bpf+bounces-62333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE2AAF8214
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D051C858B5
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934F2BE63F;
	Thu,  3 Jul 2025 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jozLiUli"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813022BDC2B
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575712; cv=none; b=ZkqU8HbiBMWs6Htgsuk5cvKUdCERJ1Vm4wXTuyRokbuVAyd84kFpHHC69D3FZXpni6QgKtUAkUJ+qPSef2EPRkllKJEc/G14ixRa+RNTbPcHZ4TzULMxDKKtFpfiFi4fd2wpyOepAKnlYhFYaZdlwF5mG6qwMeaG1q/kmK2jdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575712; c=relaxed/simple;
	bh=8QsJvL+XZO1boQ+m9nucIomIAlvQ6D+XhhJ4KcAPcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMQcHZp/rX/hF2bOHv8LyYLiLZHqsvkntlVDu0h9cFjlonwh+9e8NxSla5mYoW2Q3VBmh5VA68DEWys1gL+xmXoVWCpv75mh3IZdcnMmKatRRavIxMAiiktuSaAhx+EBFcWqocLVih7HXSsWiYJHOxbzjrdOhKtpb2iC2czc5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jozLiUli; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae3b336e936so54589366b.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575708; x=1752180508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQnQFp/jTrLJVxvqFvSspFMxGiRhWHM9PL7zWoyaZoY=;
        b=jozLiUli2DW8roHS/6K2z12WlZai53TxXmoa16+vYJVpeMy0qbW/8YgSs9gJWDFJVo
         ex3nDeHUV8kzD38cfiVWiGeKnDG8SE8saJdqVarsgSzw4SKr2jlKx39yTebHHrNxO+Jv
         Kk3jNhXcKLw+3dP5ZxwxQ/Ce4OW654rYd1xkFFeG/fkVDLepK2mpkacODP6P5626QaIp
         f4yUNFf7qBd/ptqUsIyp9dS4hSo0HOlrKpHbOfDhxLDwjtm6ggU4hqVQsYMT0H2BO0hj
         v1VImmA4YrQK7jg9+byU0JJylSo7YuXeBuJOIiM0Qs39uPmhPFvWZRtbFFt1cHo7wLYl
         Hk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575708; x=1752180508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQnQFp/jTrLJVxvqFvSspFMxGiRhWHM9PL7zWoyaZoY=;
        b=pwCkiGOXQoWkltO92m5wVsATw3aqgWM5xzSDDZtSD89wVkjPDmeGGwKwrDROC56P+s
         SfUnns30AM9vnm7LPnyUus5nUdDEKF3GDEVtObyZttxOv4GB8AD6Qc0BftAHw5aHstNT
         YSGaSg7qX8Iq02fEyP6vZyHyZbHdH57zNQNKD0ISuqC1CvlaMSdMUwIDdvu2UyGvHtyV
         zOvkS48eA50/hArtIKBeAj+3tIIYRDEtgiiZ3DVEBXHyH5Qplm0to0WfhQwfF5GY2TLf
         Nyb6IBLkvdvd9dtXIbl4Tbd1DCS/UK2zv7ixbGO6rJiCshf0o7uKbnhW1+dGML12D2kd
         FQow==
X-Gm-Message-State: AOJu0YzYca1pvAA6R6WLQZZv3UbSylPHFjcsUbEujKxoYToCQd/NinGV
	YwjHpBLnLOyrL82XL3/VZquFgNeNGGHzo88Rj+wvim18gTscdJD4BSiorWCrSvPi4EA=
X-Gm-Gg: ASbGncu9WjtRP9plEiXmKW4IUfuomS50k23xf15EGjfnD7kNzbj+BMcPjMl4d0Hmdvo
	RjFWqzn5qrfKQug2qRNU8kgzh4IrCEYu/NpJn/Ap7/EbSSqnKG2UyImuE7rWp8oHRvnhD3Rq7N9
	SsTJiKMqkVNF1lP00VfQk/4jJzvRnemQDzzHxNMMh9Bcz7EPgC9BnLrdaI85DAgsduE4xDlUUrz
	hnqDyV1kyRZR4pDxuPJYtSS+BDMyv6+IE2t/eM/vyulfDBovQVlrHOvjYBKbUP3AqQ7h8hUSYn+
	oo+stsbEos1cLJNG5bMS6++lKj9/F4aN7pN56R2oGlT3acAtqmc=
X-Google-Smtp-Source: AGHT+IEcKEUb0BD8ayD2uG/6ZILInuemHCzJtobPqTcZU3jTQGNXIJjL6IjOTI50NepicIHlgydAAA==
X-Received: by 2002:a17:907:3e94:b0:ae3:74e1:81a3 with SMTP id a640c23a62f3a-ae3c2a8f5a3mr675038566b.8.1751575708141;
        Thu, 03 Jul 2025 13:48:28 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e7d4asm38642966b.23.2025.07.03.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 03/12] bpf: Add function to extract program source info
Date: Thu,  3 Jul 2025 13:48:09 -0700
Message-ID: <20250703204818.925464-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; h=from:subject; bh=8QsJvL+XZO1boQ+m9nucIomIAlvQ6D+XhhJ4KcAPcCg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudLSEwYgmRctlEspltsenzZ9XRgTdjYGxvEiE+x wawrgUOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnSwAKCRBM4MiGSL8RyhWWD/ 43VrZaWp6R/a1k78TzAT7G1w0izlTig0iRHJsD4wbuVPrwUYogqe3Q8fzq7TITb5T1KON/cJzRA96d 2+rVEDCD86awFtYb8M5itLus/kJkecPwvINTB42f6BxPLGfgZ6P2jUS/cBPBLqX5wkagpRMj2xd2Uv GOuNAlpKxMGFUGtzb3yehBwa2rmL1DKKcGSX5mAdJG9qjiX40C3ToA/mvjB1THrTZ8QG/q83R6xXnE Dsmv3uQv9NK8CZtKeDqomXmA9WlQAo/zTxX/wrYT/5zlP7JOqCus9aWWj0n7ZbCE/fMY+Oi3TMB4S4 L6eCUowtRUBlNVZVSmAkqK4qutMJViS4MxadXws5FoHdtbrNYfbjFb+zh//dugkpTxIhVL5iQuSV4T ffJdBI9GP67409ysP2wjF5udH3L2buhq1fhDIFx0ak7SQ4inFXT9pK0XBK3Ddct2GcF/1CHdMMMgq7 B4+exjRZLjRYos9wRq/S6o/ACdzOGQwU0wnJrMfSptUzVGAWoFmspfPjxMkXYtPa+NvhFVvdV04aWA 2s8mN73G/G/LPesbXe4KTBWnkiVud85PYNhghp/IkZmZGSM+NiP+ywcY4vtIBeVihLejyE6O6gEj7o /IrZR/5WQMIWXRdjMhkn2kwCaonG5aPQhDfyMAufK9hKcrnSwLCevnRh5ORg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Prepare a function for use in future patches that can extract the file
info, line info, and the source line number for a given BPF program
provided it's program counter.

Only the basename of the file path is provided, given it can be
excessively long in some cases.

This will be used in later patches to print source info to the BPF
stream.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  3 +++
 kernel/bpf/core.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 85b1cbe494f5..09f06b1ea62e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3660,4 +3660,7 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
+			   const char **linep, int *nump);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f0def24573ae..2dc5b846ae50 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3213,3 +3213,50 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
+
+#ifdef CONFIG_BPF_SYSCALL
+
+int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
+			   const char **linep, int *nump)
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
+	if (!btf || !linfo || !jited_linfo)
+		return -EINVAL;
+	len = prog->aux->func ? prog->aux->func[prog->aux->func_idx]->len : prog->len;
+
+	linfo = &prog->aux->linfo[prog->aux->linfo_idx];
+	jited_linfo = &prog->aux->jited_linfo[prog->aux->linfo_idx];
+
+	insn_start = linfo[0].insn_off;
+	insn_end = insn_start + len;
+
+	for (int i = 0; i < prog->aux->nr_linfo &&
+	     linfo[i].insn_off >= insn_start && linfo[i].insn_off < insn_end; i++) {
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
+	*nump = BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
+	return 0;
+}
+
+#endif
-- 
2.47.1


