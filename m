Return-Path: <bpf+bounces-61339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA12AE5A61
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A87444ABE
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D41F4628;
	Tue, 24 Jun 2025 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBNiN2U4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D0192D87
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734781; cv=none; b=sGsRxyKQ14LHmF3blvFTARNNPrz/2NHGHRstna0eb6a4eIAoTsxz+XQxCMYYy4pwR6iUd6tQHNrHjKSQK0bYBqA2UnyGq8wx5TgB5Ee3Yx/qvGcla7Mz2Stn7eGFVpGVizBaAEsCtzbHyrhvW3R9VuzbVz4AmIGBTe9ofz3qR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734781; c=relaxed/simple;
	bh=7rMNU6al8xl2IR7waRixJcjrw776mAeFeVF8NFNnCQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXAdLLcZBEO20mAkplBxVbxFG71wPrYsAgtwJwSZHT/pYTPBpcnZD/onPipc9pzPzPY58b74hDv9S5zBNIUg7CoRwi+q/vpTHmLUFyXh6h7X0jDdyFVTPWT23kwgq4PydicFPA+hjuSgHFn97C7jerJzvMy/r+oETQn+liwmPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBNiN2U4; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ade48b24c97so848082466b.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734778; x=1751339578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsOZrkl4yZUq7zsnX75WI81xSlFYBwTl7ifJCHRa8AI=;
        b=hBNiN2U4r8CgAXftK44x3Tgb6NmlibswmXrYUKEV1mAAx+Wll9r3sRMF3m0mdEWEhd
         Eo/AAJHpdDzd/ocQj9JfCbWCk6oML7uMt9xhXBDf14HV3YGljSNqpyJLdgNoI6qIPXCk
         RCUH6Tt4XPL4/StSUctU4HM5LCznKVo2CMsryWAkqZFD3Zfsv3Wd7+RPEVxaQANjP2q3
         QSsLXXL6DjTh8dQYdnE+EQiz+UW++ilvjUCFkqyVqGKpyQ+DupGX68XTvIe/GK6qyuTR
         fkeoEL9uwBzIxRy0UPXvsTd2jmrrKU1VxUgOxqwuu9jlZTKwdeTcciPng/PeZzuZSkCE
         6mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734778; x=1751339578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsOZrkl4yZUq7zsnX75WI81xSlFYBwTl7ifJCHRa8AI=;
        b=u/3xMdrYrYsgvPac18yVfkWDhNOhhRspo3ws7m+rYy3+mClt0S7+yFSfgEhZQUmAIP
         w4lzOU3sk6l0Rwr7AuB9esbC2tSK9ColWeBaV4qoRQpE8AxpDFcDog9K/sfZZrYBjWqw
         OJ8ArJ+KGnikAQ8z03d87TqyXSLtrhqd+Yel8AjBPsozarQu0qg1oabFh5GsE+ZMS3eq
         B6g02ubh0O+/2Fs0mVvIZbkcmLJKhGrOqSpFMQaSZ7BOdUkRVsSpsTSwZ2lZ5E5uu+vC
         YhGLf1K3yAk4X9uWo0XEwykI79/JLS7kCkjm+ReSXUpUXfyWkZKH9Z1PjHPKZ1CExlby
         UBJw==
X-Gm-Message-State: AOJu0YwpMDAuE0PJeyTzW1tWvUxZ2LiFnjocjeULoTHVuR9rzo90UlUn
	VLuDav8xPmiEcKUZhBFyFXIU2TrT6pWl/BddCOqFxh1UL6wfmAxT9RkaaVQ+QpDkouab0Q==
X-Gm-Gg: ASbGncvtFdkzOVmz2JrnBSKf8rzxoxBRK/ydYxWVuXF5xU9RYgTRqQ7aES0waiFP8AL
	invoMe+1cfnw8fiu5oXXzdoHInVNcU+599EXLoG6/QqYnDktujSiNYKlB8a4l0Sd8p3P7oP72Jq
	itx3b6fFabiP5Tf6RF0k/RcA5kEcpN2ZzyzoAjEdptW5nQaJ+SqOtRA+rjSO5iWzTj0zgmJxggt
	oACx4DldqNjrXhne3kx1f2R0rc9Fso6c4ycmIfN0JS3oaSzTkc4XAyQdp6O4n3poEI42kY3VO3V
	mlRRLyzyWZZ9xHOyKLNyJ8nUfdPuYCCLM/dq4S1UkTXaKL1Pwxm8MisxiP9gcA==
X-Google-Smtp-Source: AGHT+IEK5DSQiue5KAzUDB4iBoEy6Cat2h+azamrBUtAH/im4AoYVEL4li/2aDF7A9EA4QQ79EfG1Q==
X-Received: by 2002:a17:906:fe0c:b0:adf:f82f:fe0a with SMTP id a640c23a62f3a-ae0579bc670mr1298548366b.16.1750734777605;
        Mon, 23 Jun 2025 20:12:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbda9sm794004266b.48.2025.06.23.20.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:12:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 03/12] bpf: Add function to extract program source info
Date: Mon, 23 Jun 2025 20:12:43 -0700
Message-ID: <20250624031252.2966759-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; h=from:subject; bh=7rMNU6al8xl2IR7waRixJcjrw776mAeFeVF8NFNnCQ0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWdL/vgUQymZn62fKNSo8Cls4vb8vw1DqY6O7qM W5mPk12JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVnQAKCRBM4MiGSL8RyoGLD/ 4rAbX2dn739buXT/2Q6lDVwf5169lf51Yscsfz7aij8HACmYo4CnNk7L3esbhPJc27bXzwBr3ASe2j aHd6JXQHG/8q2XCqo/U/YmqkXAaDaZxoikIj1RruST56wlag3YAl9ilkXnMMDaIwAksFQ8gW41CQEv wcG6BrQz8ger6AW1ss1/Q5KVsVmKVBL/LM61RKSVC0a/N7Cumo6VlaxG3WXxK2/VXoCqn1eqlDp3YS O84eyZ7CqOOp4l+8mKOevCJAwb5HMNuCF4r07G32WU+TrLYhEeBUnv4zKt51mzPIzVB3KZn0aRDnWU HByTNYsEAGbTaG1Rq4avALrEO2eA0dXoi88x5I0+LrFcuCqN0xibBThHH2D0iriNBmwayRYiTOLW0a Wv4nJqBLVfnP0Fqd4AwJ5VqFrS36TKae/TtaLzsV6gu7mHZUbRwphV32Uh8GM3JkAvqG4j4wp0hDHe zgexq/y+e+atP6h9KM3BMR/bKrUKehlNBXK09s+0vtxqTXWHq2CNxrrSML2mGIu6ufiAGAJFRI2/UO HwAE3rvq4OB/9agSBHgA2LXK4jjQmKgnRtfsW0kD0VRNYQ1UxIyniH63Dj+80jn3tIYf5DBs58zGcy ty6kubOK+iKSeTgxv1Chpp3LxYELGRqgwVqp1gA7v/VTj5kr8zmDuz0W3hbA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Prepare a function for use in future patches that can extract the file
info, line info, and the source line number for a given BPF program
provided it's program counter.

Only the basename of the file path is provided, given it can be
excessively long in some cases.

This will be used in later patches to print source info to the BPF
stream.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  3 +++
 kernel/bpf/core.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cdd726cfe622..f30697c72ba9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3667,4 +3667,7 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
+			   const char **linep, int *nump);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f0def24573ae..5c6e9fbb5508 100644
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


