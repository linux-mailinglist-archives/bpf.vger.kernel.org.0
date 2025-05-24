Return-Path: <bpf+bounces-58876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C6AC2CD7
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CFE1BC7E45
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202A1DEFC8;
	Sat, 24 May 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO5OZVjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879F1D54E2
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049537; cv=none; b=WTvWcWpm5oBxN2BGv7/dgfr2mUrZfaB1r/a/KSk8afgxB8wdykHYAaiN9XDTNyaH3XRnCpUN20ALRdt4POOziDP/PDp27gZM71gGxQi4FQLPtLR+kVuK2CoGJvUf8TuwhM6UxRpmfXjEiWY7Fj8XxrCNclKDjeSqjuJAFAGJ2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049537; c=relaxed/simple;
	bh=/6L3r1xmOdJP+yGpa0V66rM9IfogiFtUktqgRZHh9yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrvtGXEmn+HEbf+oVsytIEc7eUueambuwYkIv/huHa1kXCl3LaJdV1jli2Ws8ZwnZvCO1WUMArjrGGwXqmPsX3qW3pfFTljp2UuCNkO2XE8wjtAAtCtIh5sg25Qf9mNoRBw6z6gQBcceEoW2cZOAVoj9CTMy9EZ2efVCukQKf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO5OZVjd; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-445b11306abso1918795e9.3
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049533; x=1748654333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lALgs0ACfF2VTgby+7pCdVrSH/XNByO5/cUwtTAe4Ag=;
        b=kO5OZVjdHtLm2HFAKxtHDwzqLPRcQuH+1A8t42nT4lYp/r0QMFw6z2zaE5dTvSJdsm
         zoX+eGHUDB+K26nazoQ5+IjeIkunQgKkuCHGtlVOHS/xII5aXTML2XF+ksHWpDbhL3iq
         dwWDo0Jp/MJxz3wZWNZZklUrF+ogHbKDGevdzb9qCbcIn3+x2NtPizTtV1PV/TrAVXXv
         ACOmPrbmKlWsLya5zmECRpT0vU17WvelKhyJ6PnIiOggtyPB4BBJhtdV+ghFhI69jWwc
         L9tpuMlqhlH9vvOdXKI8+MT5T2gikYCl/aXnxA9Q8/DkaHV5maR78cSeEH8zNiCp4Prq
         Gy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049533; x=1748654333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lALgs0ACfF2VTgby+7pCdVrSH/XNByO5/cUwtTAe4Ag=;
        b=l7/e9AsP+Oq9C82XmEYWibjXn9uw+wvaIDI6u5zv+OwQKWaL7EGdvX7XZ/z/Ak60ou
         KN2rjJdoni1RVWD0LQaTdxL6EhM8iOuFv7Q61IZLxP34nYZGZgXb+jfbcqj6BEcEGOD/
         3E362zrdyOjXQCjiaxLGAtEwU42yDbl8Tmzxeb/F3ZnO9KSuUQ6Yaz/nabdIpb9APmGI
         kDg4Xln0FAz9c9XUp0aZO8AgHdzbkKSl48yVZa95LmHxAsYF36om4BPA3rv85ZfryODa
         hbFIDWAMV0y4NN9T/3WspILeX/efNgGZ2huxUfJ4Ef+FxJFm2OVkoIeXvzFd1+bCfKGo
         1hAQ==
X-Gm-Message-State: AOJu0Yyi6qXB54w1Zfh0sH6G7ELSgh8rHhTkntInAbFhbEtPR0xIXCNA
	LIrxgzquNpun2HsJcmSKKVekU1PHfAxJbww+mIWNWtqgm5Np2iRnaI/ChG/iG0CaQVI=
X-Gm-Gg: ASbGncvWHi5ZtdVeR5xMsk+JSmmf4pHbnDyriztmwV+LE154fh/nCbYuJ5IqEFvzS8Q
	VHoWczIBxRKBTURUlLLj0PWvBzWAZRjtL6HiqWRk63Z+DNtAQ5E86IuvadD1b04xpcZdx7ZXTvd
	S28YxZzTQjEkAytFtpnBmfoxeA0okiOyAj2nFrU1PC2O/SOtYuFtcf2WcfARLratsYco6rDW7Nh
	oc0k1bbBKrEkqaoRJHv2bTpVC5sLc4e6cn4S/5Insr4zg0ueDqecd08eJYzRIdAXtXdjo+v+UqO
	C4YEPG5r/W5p6CGVpdQdv4vzAbIzWjn9+uNzqbYcTA==
X-Google-Smtp-Source: AGHT+IHpYPT3DgVdUvE+zbqrYdA0NYJahz2uxOVG5h7xzzMpZEVSzYOK2crLlG/eK4K+//4DRF2Vmg==
X-Received: by 2002:a05:600c:6089:b0:444:c28f:e81a with SMTP id 5b1f17b1804b1-44c94c246b9mr7826145e9.27.1748049533250;
        Fri, 23 May 2025 18:18:53 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7bae847sm155529925e9.36.2025.05.23.18.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 02/11] bpf: Add function to extract program source info
Date: Fri, 23 May 2025 18:18:40 -0700
Message-ID: <20250524011849.681425-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817; h=from:subject; bh=/6L3r1xmOdJP+yGpa0V66rM9IfogiFtUktqgRZHh9yI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3Ovf9kn+3pyrDSnofkvjiIlQcBI6DCMv5J67Vb eIpQxXiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzgAKCRBM4MiGSL8RyitLD/ sEMLPYcKji+ghS0qeJyVrekOKAkT5k6M4coWUu//LWs4ThxV+04PQJ6qFEYAI3Oz9FH0avp/HThNYY LxDC8muaTGtL82hmWYP5rRikY7wnM+fTYD8oDR+0MuTlGhuymz1zLg8MfX6qt2W0WXREipXynWXW89 8ZDrg8vO3gRzLJzrRn/qiqjbyOQxwFOtrcp7QW+M4VrPqMEQPDo0AUemDFIUtRyshyd3A+1sNE45F5 UkHTMVEZEHVL+wJVR8yC+GkyXulRnIH/pqE7VqkV41TbwCv95O7Mtn9hJ6CBh7jKDtS+AoI3uBHKRe DRF9CxXwJsJeb7cM8Eba65tBzoF9+0uBJBT/hOaNrJVG6ce5/Yvv7bzyQpi0FTkcghWjOza5SvoIRR jHYAwFv0eFFsAZvmDqdk0Kxx6rxPYlOvyUhvXIiuDx7Howi8zbTqO2g8Duaz1oi9NG6/irEqbFWgfW QgzitDxZJ+UHDWratx9hH7ANltYF2NPD8BEK4K3Zdy2oErOkwSGYiXYtGb9sQKYJmaukanHggF248p 4M7gkJ+zHPB2hXwIBheUzVoEYh4oIj89Oxt4C2Fm7e67iPoSOHUmgC/QBnK/Hh7H4TARI4zu3YqExp 9tlw3k1j/KhQ+PCYxMy3K4TUq8vnjoBZyGnc57XAC1WUpLbYq3XiqLJErU6Q==
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
 kernel/bpf/core.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d298746f4dcc..4eb4f06f7219 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3659,4 +3659,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep, const char **linep);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 22c278c008ce..7e7fef095bca 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3204,3 +3204,52 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
+
+#ifdef CONFIG_BPF_SYSCALL
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
+	if (!*filep)
+		return -ENOENT;
+	*filep = kbasename(*filep);
+	/* Obtain the source line, and strip whitespace in prefix. */
+	*linep = btf_name_by_offset(btf, linfo[idx].line_off);
+	if (!*linep)
+		return -ENOENT;
+	while (isspace(**linep))
+		*linep += 1;
+	return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
+}
+
+#endif
-- 
2.47.1


